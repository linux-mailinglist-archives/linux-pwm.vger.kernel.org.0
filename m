Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790CD2FBC3E
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbhASQSD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Jan 2021 11:18:03 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:50028 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392110AbhASQOb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2021 11:14:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 10D7F25084;
        Tue, 19 Jan 2021 16:13:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo06-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo06-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Uu2rOVrj1JKe; Tue, 19 Jan 2021 16:13:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 2C4A22502E;
        Tue, 19 Jan 2021 16:13:30 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        david.wu@rock-chips.com, steven.liu@rock-chips.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v4 4/5] pwm: rockchip: Eliminate potential race condition when probing
Date:   Tue, 19 Jan 2021 11:12:08 -0500
Message-Id: <4bf623acf2cae5247f60a6e9765f0755132647e4.1610976129.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1610976129.git.simon@simonsouth.net>
References: <cover.1610976129.git.simon@simonsouth.net>
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

Fixes: 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running PWMs")
Reported-by: Trent Piepho <tpiepho@gmail.com>
Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index b5bab427b5de..228147e9bc6e 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -288,6 +288,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	const struct of_device_id *id;
 	struct rockchip_pwm_chip *pc;
 	u32 enable_conf, ctrl;
+	bool enabled;
 	int ret, count;
 
 	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
@@ -349,6 +350,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		pc->chip.of_pwm_n_cells = 3;
 	}
 
+	enable_conf = pc->data->enable_conf;
+	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
+	enabled = (ctrl & enable_conf) == enable_conf;
+
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
@@ -356,9 +361,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	}
 
 	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
-	enable_conf = pc->data->enable_conf;
-	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
-	if ((ctrl & enable_conf) != enable_conf)
+	if (!enabled)
 		clk_disable(pc->clk);
 
 	clk_disable(pc->pclk);
-- 
2.30.0

