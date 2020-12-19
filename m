Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22E2DF197
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Dec 2020 21:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgLSUpl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 19 Dec 2020 15:45:41 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:37442 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgLSUpl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 19 Dec 2020 15:45:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 26F2DC2537;
        Sat, 19 Dec 2020 20:45:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hmgycagr5TIp; Sat, 19 Dec 2020 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id E5D59BFBC9;
        Sat, 19 Dec 2020 20:44:45 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        heiko@sntech.de, bbrezillon@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v2 2/3] pwm: rockchip: Eliminate potential race condition when probing
Date:   Sat, 19 Dec 2020 15:44:09 -0500
Message-Id: <fcfb96fd2fd860ae3f08cb563c74eb864cdab41a.1608407584.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608407584.git.simon@simonsouth.net>
References: <cover.1608407584.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running
PWMs") introduced a potential race condition in rockchip_pwm_probe() as the
function could disable the clock of a PWM device after having registered it
through a call to pwmchip_add().

Eliminate this possibility by moving the code that disables the clock of a
non-enabled PWM ahead of the code that registers the device.

Also refactor the code slightly to eliminate goto targets as the error
handlers no longer share any recovery steps.

Fixes: 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running PWMs")
Fixes: 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while probing")
Reported-by: Trent Piepho <tpiepho@gmail.com>
Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index d2058138ce1e..f286a498b82c 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -289,6 +289,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	struct rockchip_pwm_chip *pc;
 	struct resource *r;
 	u32 enable_conf, ctrl;
+	bool enabled;
 	int ret, count;
 
 	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
@@ -335,7 +336,8 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	ret = clk_prepare_enable(pc->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
-		goto err_clk;
+		clk_disable_unprepare(pc->clk);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, pc);
@@ -351,29 +353,26 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		pc->chip.of_pwm_n_cells = 3;
 	}
 
-	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
-		clk_unprepare(pc->clk);
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
 
-	return 0;
-
-err_pclk:
-	clk_disable_unprepare(pc->pclk);
-err_clk:
-	clk_disable_unprepare(pc->clk);
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
+		if (enabled)
+			clk_disable(pc->clk);
+		clk_unprepare(pc->clk);
+		clk_unprepare(pc->pclk);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int rockchip_pwm_remove(struct platform_device *pdev)
-- 
2.29.2

