Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D841977469F
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjHHS66 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjHHS6k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7589D75850
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN2-00074D-WA; Tue, 08 Aug 2023 19:19:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN2-00224o-55; Tue, 08 Aug 2023 19:19:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-00BTBo-1k; Tue, 08 Aug 2023 19:19:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 027/101] pwm: jz4740: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:17 +0200
Message-Id: <20230808171931.944154-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2856; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=r0xGWvVnRys2Hcwj/wIuBtGGqBSRWU8h0vQ1gpJo8CU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njPsg5vR+VsiLZQUjKCVYhPkv6vm5zqR9Q+L /lzAAj8IMOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4zwAKCRCPgPtYfRL+ ThSsB/0cVK125jQGJ4pLY0CdqMPJxqaSWleOX9nVq4s3Z8ZTPA57uNzU08SEzTU7MjRRyJfKcFT kNtMNzjwUbOd35MdJSv6IRHw47mAiFPSV1CPNVEMTB3nkUxl+h/xlqPXubJt3YRc/gBUQ2cyGQ8 z3QN8k5Mj+/BK55ka6yI0rnOeoyzqGqoHy1tBGcNIn0tFF3EuctV6phh7EBq2kpMxzHzT7OvMJ3 hIgOx0B9pRt4EUBrmvOLp95QSFF6ADBWG6Ih1+s1AGroUvXhuFbh/3HOE0D1SlGzirTZEm6Bdgj 2sMbhDkB4FM5WQQ5V79Cwc7jo2IecTtbuBGpbth99XWxFOx0
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

This prepares the pwm-jz4740 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 881958a79d55..f06010590504 100644
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
@@ -223,6 +222,7 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct jz4740_pwm_chip *jz;
 	const struct soc_info *info;
 
@@ -230,10 +230,10 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	jz = devm_kzalloc(dev, struct_size(jz, clk, info->num_pwms),
-			  GFP_KERNEL);
-	if (!jz)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, info->num_pwms, struct_size(jz, clk, info->num_pwms));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	jz = to_jz4740(chip);
 
 	jz->map = device_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(jz->map)) {
@@ -241,11 +241,9 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(jz->map);
 	}
 
-	jz->chip.dev = dev;
-	jz->chip.ops = &jz4740_pwm_ops;
-	jz->chip.npwm = info->num_pwms;
+	chip->ops = &jz4740_pwm_ops;
 
-	return devm_pwmchip_add(dev, &jz->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct soc_info jz4740_soc_info = {
-- 
2.40.1

