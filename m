Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C0A2C7C27
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 01:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgK3AqQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Nov 2020 19:46:16 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:57128 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgK3AqP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Nov 2020 19:46:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 2A72FC0059;
        Mon, 30 Nov 2020 00:45:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ktvZwHXTIvKO; Mon, 30 Nov 2020 00:45:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 0F502BFEAB;
        Mon, 30 Nov 2020 00:45:20 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        heiko@sntech.de, bbrezillon@kernel.org
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Simon South <simon@simonsouth.net>
Subject: [PATCH] pwm: rockchip: Eliminate potential race condition when probing
Date:   Sun, 29 Nov 2020 19:44:19 -0500
Message-Id: <20201130004419.1714-1-simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <875z5nof46.fsf@simonsouth.net>
References: <875z5nof46.fsf@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running
PWMs") introduced a potential race condition in rockchip_pwm_probe() by
having it disable the clock of a PWM already registered through a call to
pwmchip_add().

Eliminate this possibility by calling clk_enable() for a probed PWM's clock
only when it appears the PWM itself has already been enabled (by a
bootloader, presumably), instead of always enabling the clock and then
disabling it after registration for non-enabled PWMs.

Fixes: 48cf973cae33 ("pwm: rockchip: Avoid glitches on already running PWMs")
Fixes: 457f74abbed0 ("pwm: rockchip: Keep enabled PWMs running while probing")
Reported-by: Trent Piepho <tpiepho@gmail.com>
Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 45 ++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 77c23a2c6d71..7efba1d0adb4 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -289,6 +289,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	struct rockchip_pwm_chip *pc;
 	struct resource *r;
 	u32 enable_conf, ctrl;
+	bool enabled;
 	int ret, count;
 
 	id = of_match_device(rockchip_pwm_dt_ids, &pdev->dev);
@@ -299,6 +300,8 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (!pc)
 		return -ENOMEM;
 
+	pc->data = id->data;
+
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pc->base = devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(pc->base))
@@ -326,21 +329,38 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(pc->clk);
+	ret = clk_prepare(pc->clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
+		dev_err(&pdev->dev, "Can't prepare bus clk: %d\n", ret);
 		return ret;
 	}
 
+	/*
+	 * If it appears the PWM has already been enabled, perhaps by a
+	 * bootloader, re-enable its clock to increment the clock's enable
+	 * counter and ensure it is kept running (particularly in the case
+	 * where there is no separate APB clock).
+	 */
+	enable_conf = pc->data->enable_conf;
+	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
+	enabled = (ctrl & enable_conf) == enable_conf;
+	if (enabled) {
+		ret = clk_enable(pc->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't re-enable bus clk: %d\n",
+				ret);
+			goto err_clk_prepared;
+		}
+	}
+
 	ret = clk_prepare(pc->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't prepare APB clk: %d\n", ret);
-		goto err_clk;
+		goto err_clk_enabled;
 	}
 
 	platform_set_drvdata(pdev, pc);
 
-	pc->data = id->data;
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &rockchip_pwm_ops;
 	pc->chip.base = -1;
@@ -355,21 +375,18 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		clk_unprepare(pc->clk);
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto err_pclk;
+		goto err_pclk_prepared;
 	}
 
-	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
-	enable_conf = pc->data->enable_conf;
-	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
-	if ((ctrl & enable_conf) != enable_conf)
-		clk_disable(pc->clk);
-
 	return 0;
 
-err_pclk:
+err_pclk_prepared:
 	clk_unprepare(pc->pclk);
-err_clk:
-	clk_disable_unprepare(pc->clk);
+err_clk_enabled:
+	if (enabled)
+		clk_disable(pc->clk);
+err_clk_prepared:
+	clk_unprepare(pc->clk);
 
 	return ret;
 }
-- 
2.29.2

