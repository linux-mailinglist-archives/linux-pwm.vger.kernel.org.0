Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA636A8D0
	for <lists+linux-pwm@lfdr.de>; Sun, 25 Apr 2021 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhDYSYv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 25 Apr 2021 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbhDYSXx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 25 Apr 2021 14:23:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716B5C061756
        for <linux-pwm@vger.kernel.org>; Sun, 25 Apr 2021 11:23:12 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lajPS-0002S3-4h; Sun, 25 Apr 2021 20:23:10 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lajPR-0008Gr-Bu; Sun, 25 Apr 2021 20:23:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: pxa: Always use the same variable name for driver data
Date:   Sun, 25 Apr 2021 20:23:00 +0200
Message-Id: <20210425182300.2807668-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210425182300.2807668-1-u.kleine-koenig@pengutronix.de>
References: <20210425182300.2807668-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In most functions the driver data variable is called pc. Do the same in
the two remaining functions.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pxa.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 31752640dcf7..e091a528e33c 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -165,7 +165,7 @@ pxa_pwm_of_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
-	struct pxa_pwm_chip *pwm;
+	struct pxa_pwm_chip *pc;
 	int ret = 0;
 
 	if (IS_ENABLED(CONFIG_OF) && id == NULL)
@@ -174,44 +174,44 @@ static int pwm_probe(struct platform_device *pdev)
 	if (id == NULL)
 		return -EINVAL;
 
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (pwm == NULL)
+	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
+	if (pc == NULL)
 		return -ENOMEM;
 
-	pwm->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pwm->clk))
-		return PTR_ERR(pwm->clk);
+	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pc->clk))
+		return PTR_ERR(pc->clk);
 
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &pxa_pwm_ops;
-	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
+	pc->chip.dev = &pdev->dev;
+	pc->chip.ops = &pxa_pwm_ops;
+	pc->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
 
 	if (IS_ENABLED(CONFIG_OF)) {
-		pwm->chip.of_xlate = pxa_pwm_of_xlate;
-		pwm->chip.of_pwm_n_cells = 1;
+		pc->chip.of_xlate = pxa_pwm_of_xlate;
+		pc->chip.of_pwm_n_cells = 1;
 	}
 
-	pwm->mmio_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pwm->mmio_base))
-		return PTR_ERR(pwm->mmio_base);
+	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pc->mmio_base))
+		return PTR_ERR(pc->mmio_base);
 
-	ret = pwmchip_add(&pwm->chip);
+	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pwm);
+	platform_set_drvdata(pdev, pc);
 	return 0;
 }
 
 static int pwm_remove(struct platform_device *pdev)
 {
-	struct pxa_pwm_chip *chip;
+	struct pxa_pwm_chip *pc;
 
-	chip = platform_get_drvdata(pdev);
+	pc = platform_get_drvdata(pdev);
 
-	return pwmchip_remove(&chip->chip);
+	return pwmchip_remove(&pc->chip);
 }
 
 static struct platform_driver pwm_driver = {
-- 
2.30.2

