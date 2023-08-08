Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28B07743F7
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjHHSOa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbjHHSN6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:13:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF00E175DCC
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMx-0006mk-Ey; Tue, 08 Aug 2023 19:19:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMw-002232-QU; Tue, 08 Aug 2023 19:19:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMw-00BTAP-7O; Tue, 08 Aug 2023 19:19:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 004/101] pwm: atmel-hlcdc: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:17:54 +0200
Message-Id: <20230808171931.944154-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4008; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=i9GUr95g7ndk3ZR6iz3H67zBgNelyFjV7jyIE4OtmA4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0ni0xAGDWW0sPBoBYAdLy9K65JfHDRGs4Cfbv d4dp0g2dviJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4tAAKCRCPgPtYfRL+ ThxGB/9Icwkm+s6D9RM0vHw2mnjoEjGDnFQBs/2KZ+Wim69W2ja8CfBgua9M3cafmW4ft86850r T1ya4Am/ve6tfishI5TW1TDyWS6s+EL/c9VMRK5fcqbnMv1aeDebvb5BG28nuAtW4S2BJJnAPD2 3SJRJu3vfslEOIi7ltFW7WyCfPrUHutJK6vmB5k374X2Vydxate2S7Bc3TGjieUBAq5lxUbzYLK UP/IEHLtT6Zy4z4VD+JEa/2hyGEEazsHPwBvfr+OOsG6AJmx4K9lVlp6oZKCbTYWbosmAS6X5O9 +uevW5N3UOvtXou/+KZUcxMRtaihjn6Bk9+6Z5PPkYkrDaeD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-atme-hlcdc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 07920e034757..c3b18a51c926 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -28,7 +28,6 @@ struct atmel_hlcdc_pwm_errata {
 };
 
 struct atmel_hlcdc_pwm {
-	struct pwm_chip chip;
 	struct atmel_hlcdc *hlcdc;
 	struct clk *cur_clk;
 	const struct atmel_hlcdc_pwm_errata *errata;
@@ -36,7 +35,7 @@ struct atmel_hlcdc_pwm {
 
 static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct atmel_hlcdc_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int atmel_hlcdc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -183,10 +182,11 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 #ifdef CONFIG_PM_SLEEP
 static int atmel_hlcdc_pwm_suspend(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (pwm_is_enabled(&atmel->chip.pwms[0]))
+	if (pwm_is_enabled(&chip->pwms[0]))
 		clk_disable_unprepare(atmel->hlcdc->periph_clk);
 
 	return 0;
@@ -194,11 +194,12 @@ static int atmel_hlcdc_pwm_suspend(struct device *dev)
 
 static int atmel_hlcdc_pwm_resume(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
 	struct pwm_state state;
 	int ret;
 
-	pwm_get_state(&atmel->chip.pwms[0], &state);
+	pwm_get_state(&chip->pwms[0], &state);
 
 	/* Re-enable the periph clock it was stopped during suspend. */
 	if (!state.enabled) {
@@ -207,8 +208,7 @@ static int atmel_hlcdc_pwm_resume(struct device *dev)
 			return ret;
 	}
 
-	return atmel_hlcdc_pwm_apply(&atmel->chip, &atmel->chip.pwms[0],
-				     &state);
+	return atmel_hlcdc_pwm_apply(chip, &chip->pwms[0], &state);
 }
 #endif
 
@@ -245,15 +245,17 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct atmel_hlcdc_pwm *atmel;
 	struct atmel_hlcdc *hlcdc;
 	int ret;
 
 	hlcdc = dev_get_drvdata(dev->parent);
 
-	atmel = devm_kzalloc(dev, sizeof(*atmel), GFP_KERNEL);
-	if (!atmel)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*atmel));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	atmel = to_atmel_hlcdc_pwm(chip);
 
 	ret = clk_prepare_enable(hlcdc->periph_clk);
 	if (ret)
@@ -264,11 +266,9 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 		atmel->errata = match->data;
 
 	atmel->hlcdc = hlcdc;
-	atmel->chip.ops = &atmel_hlcdc_pwm_ops;
-	atmel->chip.dev = dev;
-	atmel->chip.npwm = 1;
+	chip->ops = &atmel_hlcdc_pwm_ops;
 
-	ret = pwmchip_add(&atmel->chip);
+	ret = pwmchip_add(chip);
 	if (ret) {
 		clk_disable_unprepare(hlcdc->periph_clk);
 		return ret;
@@ -281,9 +281,10 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 
 static void atmel_hlcdc_pwm_remove(struct platform_device *pdev)
 {
-	struct atmel_hlcdc_pwm *atmel = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct atmel_hlcdc_pwm *atmel = to_atmel_hlcdc_pwm(chip);
 
-	pwmchip_remove(&atmel->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(atmel->hlcdc->periph_clk);
 }
-- 
2.40.1

