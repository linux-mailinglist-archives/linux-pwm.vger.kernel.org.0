Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD9758479
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjGRSTV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjGRSTU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D641FC
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHp-0001oG-KQ; Tue, 18 Jul 2023 20:19:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHk-000Qmh-Pb; Tue, 18 Jul 2023 20:18:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHj-005unZ-MY; Tue, 18 Jul 2023 20:18:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 03/18] pwm: apple: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:34 +0200
Message-Id: <20230718181849.3947851-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RLlnp/gj3zph2q9sZt8AjzN71Y6ak9HYYE2ntCXMNkc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttbqRpSTaTVcfcq0cczklQJyQ5gZuouDUKFjX CgpeSZ6K+aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW6gAKCRCPgPtYfRL+ TpVUB/4xLmZoenE8ucyYsWre1w5sRDBePNVTckEQ763oMjV/bpOwycK3X73TUpaBwgT0M/SScAB +F3nRJdHwQPlZLYNZ5FkIhVN+CLijwiTDvQ+lHRNtNp6B1lkZGndqnXBMTQp8qDnwDCGxi9k7Xd enLF1QDCSCKzX1isnU3e61sLgE4KyYoQyI/xpNFPCdd6gFHeesLd1C+jQXiOzW8706CyIxdxV/b eUy7hZBkUitVPqpny8zoqIfVQr8flxyJGM/53bW9cZJSJBpvwN8U4B3erMDDu+wYbaVft2bIiX7 OBvj73rg4B5uAkQqoBWT12X/ZOl8CTGNhOwOtepB6nOB7BQg
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-apple driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-apple.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c
index a38a62edd713..cc045a719cbb 100644
--- a/drivers/pwm/pwm-apple.c
+++ b/drivers/pwm/pwm-apple.c
@@ -31,14 +31,13 @@
 #define APPLE_PWM_CTRL_OUTPUT_ENABLE BIT(14)
 
 struct apple_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	u64 clkrate;
 };
 
 static inline struct apple_pwm *to_apple_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct apple_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -103,14 +102,17 @@ static const struct pwm_ops apple_pwm_ops = {
 
 static int apple_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct apple_pwm *fpwm;
 	struct clk *clk;
 	int ret;
 
-	fpwm = devm_kzalloc(&pdev->dev, sizeof(*fpwm), GFP_KERNEL);
-	if (!fpwm)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*fpwm));
+	if (!chip)
 		return -ENOMEM;
 
+	fpwm = to_apple_pwm(chip);
+
 	fpwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fpwm->base))
 		return PTR_ERR(fpwm->base);
@@ -129,11 +131,10 @@ static int apple_pwm_probe(struct platform_device *pdev)
 	if (fpwm->clkrate > NSEC_PER_SEC)
 		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");
 
-	fpwm->chip.dev = &pdev->dev;
-	fpwm->chip.npwm = 1;
-	fpwm->chip.ops = &apple_pwm_ops;
+	chip->npwm = 1;
+	chip->ops = &apple_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &fpwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
 
-- 
2.39.2

