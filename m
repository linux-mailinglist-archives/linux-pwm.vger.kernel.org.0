Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A41C7B37B5
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjI2QT3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjI2QT2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4082E1A8
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-0007nY-2l; Fri, 29 Sep 2023 18:19:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD4-009r5U-Lz; Fri, 29 Sep 2023 18:19:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD4-00615x-Ch; Fri, 29 Sep 2023 18:19:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 03/11] pwm: brcmstb: Simplify using devm functions
Date:   Fri, 29 Sep 2023 18:19:10 +0200
Message-Id: <20230929161918.2410424-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VF3VFnRhINh01In7Wvv/oBx1G0IOWGs3DyxhGx8WqW0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSxH9+1F4nvFniS1XOUi/t6adyZtpROxfre8ERXjfkX5 y+bsIClk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJ+Gax/zPsbm1z9V740tqw auZr6RUqc+ZdecnJvW3Xoq6lV4ouZsW/OJF1Q4mn/7qlD/dx3euna7imfi9tDKvo4bmlyHiYfY7 47vKPH8IzrFfm2Icx3vvO+6KCs4Nx/yvdCO1eCZMrGdvFnVnXr/tgsy72/putO1sNtS5Epm8NbI xcFsNmpdh5/6psdx9P/B7dyD0FPzZP2CP0vov7j1vOE/Z4yavmN6+eZt59OPls53dRLYPbIcw6U 11nud2RWTr9+/HNXQpaSY/b1bw8hF69XtDG9K+b+637xMInk2smZ3jI6i7YwXnKkjF2odHi8E4p zW49AY0cblGFVdss3r+KC/6R7sP3zeJp8cPwy1NVigQ5AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With devm_clk_get_enabled() the call to clk_disable_unprepare() can be
dropped from the error path and the remove callback. With
devm_pwmchip_add() pwmchip_remove() can be dropped. Then the remove
callback is empty and can go away, too.

Also use dev_err_probe() for simplified (and improved) error reporting.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-brcmstb.c | 42 +++++++++------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index a3faa9a3de7c..7b6336e22e20 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -238,17 +238,10 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	if (!p)
 		return -ENOMEM;
 
-	p->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(p->clk)) {
-		dev_err(&pdev->dev, "failed to obtain clock\n");
-		return PTR_ERR(p->clk);
-	}
-
-	ret = clk_prepare_enable(p->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
-		return ret;
-	}
+	p->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(p->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(p->clk),
+				     "failed to obtain clock\n");
 
 	platform_set_drvdata(pdev, p);
 
@@ -257,30 +250,14 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	p->chip.npwm = 2;
 
 	p->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(p->base)) {
-		ret = PTR_ERR(p->base);
-		goto out_clk;
-	}
+	if (IS_ERR(p->base))
+		return PTR_ERR(p->base);
 
-	ret = pwmchip_add(&p->chip);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		goto out_clk;
-	}
+	ret = devm_pwmchip_add(&pdev->dev, &p->chip);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
 	return 0;
-
-out_clk:
-	clk_disable_unprepare(p->clk);
-	return ret;
-}
-
-static void brcmstb_pwm_remove(struct platform_device *pdev)
-{
-	struct brcmstb_pwm *p = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&p->chip);
-	clk_disable_unprepare(p->clk);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -308,7 +285,6 @@ static SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops, brcmstb_pwm_suspend,
 
 static struct platform_driver brcmstb_pwm_driver = {
 	.probe = brcmstb_pwm_probe,
-	.remove_new = brcmstb_pwm_remove,
 	.driver = {
 		.name = "pwm-brcmstb",
 		.of_match_table = brcmstb_pwm_of_match,
-- 
2.40.1

