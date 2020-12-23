Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE32E1F30
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Dec 2020 17:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgLWQDq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Dec 2020 11:03:46 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:43644 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbgLWQDm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Dec 2020 11:03:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id BA8D7C0E6D;
        Wed, 23 Dec 2020 16:03:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YLM3m_ioQk8w; Wed, 23 Dec 2020 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 70DE7C0DA8;
        Wed, 23 Dec 2020 16:02:41 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v3 4/7] pwm: rockchip: Eliminate potential race condition when probing
Date:   Wed, 23 Dec 2020 11:01:06 -0500
Message-Id: <88a446b3e7f6a9bd1d2c079926fcaa408622e480.1608735481.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608735481.git.simon@simonsouth.net>
References: <cover.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running
PWMs") introduced a potential race condition in rockchip_pwm_probe(): A
consumer could enable an inactive PWM, or disable a running one, between
rockchip_pwm_probe() registering the device via pwmchip_add() and checking
whether it is enabled (to determine whether it was started by a
bootloader). This could result in a device's PWM clock being either enabled
once more than necessary, potentially causing it to continue running when
no longer needed, or disabled once more than necessary, producing a warning
from the kernel.

Eliminate these possibilities by modifying rockchip_pwm_probe() so it
checks whether a device is enabled before registering it rather than after.

Also update the code that handles errors from pwmchip_add() to account for
the fact a device's PWM clock may now be disabled and that its APB clock
certainly is, and eliminate the "err_pclk" goto target as it is no longer
of use.

Fixes: 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running PWMs")
Reported-by: Trent Piepho <tpiepho@gmail.com>
Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 3b1aa5daafff..d904a5d24885 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -289,6 +289,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	struct rockchip_pwm_chip *pc;
 	struct resource *r;
 	u32 enable_conf, ctrl;
+	bool enabled;
 	int ret, count;
 
 	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
@@ -351,24 +352,27 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		pc->chip.of_pwm_n_cells = 3;
 	}
 
-	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto err_pclk;
-	}
-
 	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
 	enable_conf = pc->data->enable_conf;
 	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
-	if ((ctrl & enable_conf) != enable_conf)
+	enabled = ((ctrl & enable_conf) == enable_conf);
+	if (!enabled)
 		clk_disable(pc->clk);
 
 	clk_disable(pc->pclk);
 
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		if (enabled)
+			clk_disable(pc->clk);
+		clk_unprepare(pc->clk);
+		clk_unprepare(pc->pclk);
+		return ret;
+	}
+
 	return 0;
 
-err_pclk:
-	clk_disable_unprepare(pc->pclk);
 err_clk:
 	clk_disable_unprepare(pc->clk);
 
-- 
2.29.2

