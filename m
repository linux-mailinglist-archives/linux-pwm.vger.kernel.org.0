Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F0D758470
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGRSTO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGRSTJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB3E52
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHm-0001ow-KL; Tue, 18 Jul 2023 20:18:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-000Qn5-Ph; Tue, 18 Jul 2023 20:18:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-005unz-2L; Tue, 18 Jul 2023 20:18:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 10/18] pwm: jz4740: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:41 +0200
Message-Id: <20230718181849.3947851-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2895; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xJLpojHWbRrirvas4EL/KjQ5OZIVeJZDyHdQDYyNYt4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpRt1z5FcxQa7vBV3sjJWOxmsV28KCRl91sHdQ5tGZOu1 7yMktc7GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZjIFn/2/848i966p6+cv9I7 +cfTY1asD00bSqKO3O5R01QI/XWrXoH/aWNaa1fbVh2Tjh39TB+0+O1UYtQ/KmXOKbLSOPzspVH OUqb22PDX7yVmTdQ93RYlfvPN7Gdeq3tSb56envRP1WTKzeO35sYfVN9v1Bn99+Icxx3TF7Tn5W /ltZCq/6RxtHRHV01rvP+eJ/Gvy6ZqhPibPZuTvWtRaiOr0v7ukF6Fd/8mtj7guxSvqcX01apqh fxz6QIN3pwN9wTf/hLhS4qaufqcSLchb82lizcmsU2V3mGgGTBB4XXuhcuT852Wu51nm+/tUlwv wPz1aZijGs/7zGvzlxd5R3zq0NYuWtcaqr5DpyPHcOk3AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-jz4740 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 8b01819df67d..de3b891f1ceb 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -25,23 +25,22 @@ struct soc_info {
 };
 
 struct jz4740_pwm_chip {
-	struct pwm_chip chip;
 	struct regmap *map;
 	struct clk *clk[];
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 {
-	return container_of(chip, struct jz4740_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
-static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
+static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip,
 				   unsigned int channel)
 {
 	/* Enable all TCU channels for PWM use by default except channels 0/1 */
-	u32 pwm_channels_mask = GENMASK(jz->chip.npwm - 1, 2);
+	u32 pwm_channels_mask = GENMASK(chip->npwm - 1, 2);
 
-	device_property_read_u32(jz->chip.dev->parent,
+	device_property_read_u32(chip->dev->parent,
 				 "ingenic,pwm-channels-mask",
 				 &pwm_channels_mask);
 
@@ -55,7 +54,7 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	char name[16];
 	int err;
 
-	if (!jz4740_pwm_can_use_chn(jz, pwm->hwpwm))
+	if (!jz4740_pwm_can_use_chn(chip, pwm->hwpwm))
 		return -EBUSY;
 
 	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
@@ -224,6 +223,7 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct jz4740_pwm_chip *jz4740;
 	const struct soc_info *info;
 
@@ -231,10 +231,10 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	jz4740 = devm_kzalloc(dev, struct_size(jz4740, clk, info->num_pwms),
-			      GFP_KERNEL);
-	if (!jz4740)
+	chip = devm_pwmchip_alloc(dev, struct_size(jz4740, clk, info->num_pwms));
+	if (!chip)
 		return -ENOMEM;
+	jz4740 = to_jz4740(chip);
 
 	jz4740->map = device_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(jz4740->map)) {
@@ -242,11 +242,10 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(jz4740->map);
 	}
 
-	jz4740->chip.dev = dev;
-	jz4740->chip.ops = &jz4740_pwm_ops;
-	jz4740->chip.npwm = info->num_pwms;
+	chip->ops = &jz4740_pwm_ops;
+	chip->npwm = info->num_pwms;
 
-	return devm_pwmchip_add(dev, &jz4740->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct soc_info jz4740_soc_info = {
-- 
2.39.2

