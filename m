Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C084AB897
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Feb 2022 11:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbiBGKQ7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Feb 2022 05:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349644AbiBGKDh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Feb 2022 05:03:37 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F271C043189;
        Mon,  7 Feb 2022 02:03:34 -0800 (PST)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644228211;
        bh=sGjuLzSYNwzNO2by+q3wtuT6x/BHJWCeX5bK3FXUhcc=;
        h=From:To:Cc:Subject;
        b=FT30slUkYXo4cVmR/0bcnvW1e3AMjudBYQHKVLFeVkjeG2ffLm6aIlM8UpclqGGY3
         moEhO3seOZDDLrxUpt1FfIahnO+wBQgtmFgcN20H5Mfeco6H+A+QyCbmDsKjhL3w6p
         jnpQSjqrU3ufrJumcus3/icwBg4GwRuQYh/g/9XBRHm+yllYk+zosL6AoioPhnwLU0
         qqgkYaid4OsyroUkKt0kB87njr1TFV5b4w2XaJBBDu9p3C1ZayncY8mjD/PZCBrxU4
         VZo9EOaofVCTPcMiWNXA6KRujExQx8I6RDWt9KETG8uJlZvTWPfkxEpI82pc24d6Pw
         yUrwZ0VHFyVog==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com
Subject: [PATCH v5 0/2] Multicolor PWM LED support
Date:   Mon,  7 Feb 2022 11:03:24 +0100
Message-Id: <20220207100326.426940-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

Hi,

This patch series is getting mature. I have removed the RFC tag for this
version. The initial discussion happened here [1].

I would appreciate if anyone would test this code. It runs on my
i.MX6ULL-based hardware.

Best regards,
Sven

[1]:https://lore.kernel.org/linux-leds/37540afd-f2f1-52dd-f4f1-6e7b436e9595@svenschwermer.de/

Sven Schwermer (2):
  dt-bindings: leds: Add multicolor PWM LED bindings
  leds: Add PWM multicolor driver

 .../bindings/leds/leds-pwm-multicolor.yaml    |  75 +++++++
 drivers/leds/Kconfig                          |  11 ++
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-pwm-multicolor.c            | 186 ++++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
 create mode 100644 drivers/leds/leds-pwm-multicolor.c

Interdiff against v4:
diff --git a/drivers/leds/leds-pwm-multicolor.c b/drivers/leds/leds-pwm-multicolor.c
index 96712b8ca98e..45e38708ecb1 100644
--- a/drivers/leds/leds-pwm-multicolor.c
+++ b/drivers/leds/leds-pwm-multicolor.c
@@ -58,6 +58,43 @@ static int led_pwm_mc_set(struct led_classdev *cdev,
 	return ret;
 }
 
+static int iterate_subleds(struct device *dev, struct pwm_mc_led *priv,
+			   struct fwnode_handle *mcnode)
+{
+	struct mc_subled *subled = priv->mc_cdev.subled_info;
+	struct fwnode_handle *fwnode;
+	struct pwm_led *pwmled;
+	u32 color;
+	int ret;
+
+	/* iterate over the nodes inside the multi-led node */
+	fwnode_for_each_child_node(mcnode, fwnode) {
+		pwmled = &priv->leds[priv->mc_cdev.num_colors];
+		pwmled->pwm = devm_fwnode_pwm_get(dev, fwnode, NULL);
+		if (IS_ERR(pwmled->pwm)) {
+			ret = PTR_ERR(pwmled->pwm);
+			dev_err(dev, "unable to request PWM: %d\n", ret);
+			goto release_fwnode;
+		}
+		pwm_init_state(pwmled->pwm, &pwmled->state);
+
+		ret = fwnode_property_read_u32(fwnode, "color", &color);
+		if (ret) {
+			dev_err(dev, "cannot read color: %d\n", ret);
+			goto release_fwnode;
+		}
+
+		subled[priv->mc_cdev.num_colors].color_index = color;
+		priv->mc_cdev.num_colors++;
+	}
+
+	return 0;
+
+release_fwnode:
+	fwnode_handle_put(fwnode);
+	return ret;
+}
+
 static int led_pwm_mc_probe(struct platform_device *pdev)
 {
 	struct fwnode_handle *mcnode, *fwnode;
@@ -65,10 +102,8 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 	struct led_classdev *cdev;
 	struct mc_subled *subled;
 	struct pwm_mc_led *priv;
-	struct pwm_led *pwmled;
 	int count = 0;
 	int ret = 0;
-	u32 color;
 
 	mcnode = device_get_named_child_node(&pdev->dev, "multi-led");
 	if (!mcnode)
@@ -101,28 +136,9 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 	cdev->flags = LED_CORE_SUSPENDRESUME;
 	cdev->brightness_set_blocking = led_pwm_mc_set;
 
-	/* iterate over the nodes inside the multi-led node */
-	fwnode_for_each_child_node(mcnode, fwnode) {
-		pwmled = &priv->leds[priv->mc_cdev.num_colors];
-		pwmled->pwm = devm_fwnode_pwm_get(&pdev->dev, fwnode, NULL);
-		if (IS_ERR(pwmled->pwm)) {
-			ret = PTR_ERR(pwmled->pwm);
-			dev_err(&pdev->dev, "unable to request PWM: %d\n", ret);
-			fwnode_handle_put(fwnode);
-			goto release_mcnode;
-		}
-		pwm_init_state(pwmled->pwm, &pwmled->state);
-
-		ret = fwnode_property_read_u32(fwnode, "color", &color);
-		if (ret) {
-			dev_err(&pdev->dev, "cannot read color: %d\n", ret);
-			fwnode_handle_put(fwnode);
-			goto release_mcnode;
-		}
-
-		subled[priv->mc_cdev.num_colors].color_index = color;
-		priv->mc_cdev.num_colors++;
-	}
+	ret = iterate_subleds(&pdev->dev, priv, mcnode);
+	if (ret)
+		goto release_mcnode;
 
 	init_data.fwnode = mcnode;
 	ret = devm_led_classdev_multicolor_register_ext(&pdev->dev,
-- 
2.35.1

