Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889B4757FD7
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 16:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjGROlf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 10:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGROlf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 10:41:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40275F9
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 07:41:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLltM-0000fr-3q; Tue, 18 Jul 2023 16:41:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLltK-000OWr-JP; Tue, 18 Jul 2023 16:41:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLltJ-005s12-Sp; Tue, 18 Jul 2023 16:41:29 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: lpc18xx-sct: Simplify using devm_clk_get_enabled()
Date:   Tue, 18 Jul 2023 16:41:28 +0200
Message-Id: <20230718144128.371818-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2895; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=q3I6a2iRMSAMGg2/yW8ey2YZmnmkBcgKC2f17BPfnTY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBktqSX198L4VQGC0DM6QnbeYgsKTfkYJjSMTkng wSkQibqQ0GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLaklwAKCRCPgPtYfRL+ Tn+qB/40LN6qFPZUkfM2ymLKMUZlF9sBQLQba6NbE0CLhmgavDxW0G6lnH0GG9VYVtWpKhs7hUu r6QMU9G8/M9wp3pgnw+sWifu73eHtLhSrji/x41ebl+ozI0+jWgzAaMnX7lCqF8TAUgt9gN0R2G yrSP4JUpISj1VOz3iukHVFWqQHJgO+Lf5wcdQO8Lkl5NDdLpAdUOIq1Ckq42i//dQFo4Tflq2mQ IZaca0N6iWpnWRMvmE5e+OegyIlLGpme6MM5KYrw0I25a/GOaGYyUNUBVvjWoBjs/qaz9PVVMDP fPonGj/JS/g+MAEoyZY+b5Mt/vRwtUT+WaM6loW0OOFrm/VH
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With devm_clk_get_enabled() the call to clk_disable_unprepare() can be
dropped from the error path and the remove callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index b9bf5b366f4b..0bf0893a5d52 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -366,30 +366,21 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(lpc18xx_pwm->base))
 		return PTR_ERR(lpc18xx_pwm->base);
 
-	lpc18xx_pwm->pwm_clk = devm_clk_get(&pdev->dev, "pwm");
+	lpc18xx_pwm->pwm_clk = devm_clk_get_enabled(&pdev->dev, "pwm");
 	if (IS_ERR(lpc18xx_pwm->pwm_clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(lpc18xx_pwm->pwm_clk),
 				     "failed to get pwm clock\n");
 
-	ret = clk_prepare_enable(lpc18xx_pwm->pwm_clk);
-	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret,
-				     "could not prepare or enable pwm clock\n");
-
 	lpc18xx_pwm->clk_rate = clk_get_rate(lpc18xx_pwm->pwm_clk);
-	if (!lpc18xx_pwm->clk_rate) {
-		ret = dev_err_probe(&pdev->dev,
-				    -EINVAL, "pwm clock has no frequency\n");
-		goto disable_pwmclk;
-	}
+	if (!lpc18xx_pwm->clk_rate)
+		return dev_err_probe(&pdev->dev,
+				     -EINVAL, "pwm clock has no frequency\n");
 
 	/*
 	 * If clkrate is too fast, the calculations in .apply() might overflow.
 	 */
-	if (lpc18xx_pwm->clk_rate > NSEC_PER_SEC) {
-		ret = dev_err_probe(&pdev->dev, -EINVAL, "pwm clock to fast\n");
-		goto disable_pwmclk;
-	}
+	if (lpc18xx_pwm->clk_rate > NSEC_PER_SEC)
+		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock to fast\n");
 
 	mutex_init(&lpc18xx_pwm->res_lock);
 	mutex_init(&lpc18xx_pwm->period_lock);
@@ -435,18 +426,12 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
 
 	ret = pwmchip_add(&lpc18xx_pwm->chip);
-	if (ret < 0) {
-		dev_err_probe(&pdev->dev, ret, "pwmchip_add failed\n");
-		goto disable_pwmclk;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "pwmchip_add failed\n");
 
 	platform_set_drvdata(pdev, lpc18xx_pwm);
 
 	return 0;
-
-disable_pwmclk:
-	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
-	return ret;
 }
 
 static void lpc18xx_pwm_remove(struct platform_device *pdev)
@@ -459,8 +444,6 @@ static void lpc18xx_pwm_remove(struct platform_device *pdev)
 	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL,
 			   val | LPC18XX_PWM_CTRL_HALT);
-
-	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
 }
 
 static struct platform_driver lpc18xx_pwm_driver = {

base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.39.2

