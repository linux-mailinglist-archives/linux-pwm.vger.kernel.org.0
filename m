Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6694AB1B4
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Feb 2022 20:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiBFTgM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Feb 2022 14:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiBFTgJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Feb 2022 14:36:09 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40BCC06173B;
        Sun,  6 Feb 2022 11:36:04 -0800 (PST)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644176162;
        bh=CmVyaRxshIe2DY0x1/NgVOSye1m7rKH8NUHcOZu0m9Q=;
        h=From:To:Cc:Subject;
        b=K8kNle2l/UI6tXKI/0usxHXDVsWSmTohpeoh2BVCFPPhs9gqV31m0NgAG59+8srbH
         FatxJZWlkU5w7jaBbA/wpnh92KSbuXFyCFw89k//OuZJb4u7A685x/vA797ySlUdS4
         eTv1hF46w7Ha5OQiZPSM8xRk7mDTGgTP+YniOGQZyQBG7ABP3p1X2igfnWxrVnKDgd
         gHBjzvFuDJeX+lD3robyU2bK7i6jx0ta1c1RSZ/Nl2G34oyNQsJ3BY7s4tSIQvjAt6
         qwFUeRC+hlIHs9vHll8/DOIsbpJlcYqvBSm/2mrYUPhqaXKUcLaAUFkAnRgYnJ+rVm
         xvGkMMlmqnZNw==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com
Subject: [PATCH v4 0/2] Multicolor PWM LED support
Date:   Sun,  6 Feb 2022 20:35:52 +0100
Message-Id: <20220206193554.171070-1-sven@svenschwermer.de>
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

 .../bindings/leds/leds-pwm-multicolor.yaml    |  75 ++++++++
 drivers/leds/Kconfig                          |  11 ++
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-pwm-multicolor.c            | 170 ++++++++++++++++++
 4 files changed, 257 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
 create mode 100644 drivers/leds/leds-pwm-multicolor.c

Interdiff against v3:
diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index bae1f63f6195..e70a46704076 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -560,6 +560,9 @@ config LEDS_PWM_MULTICOLOR
 	  This option enables support for PWM driven monochrome LEDs that are
 	  grouped into multicolor LEDs.
 
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-pwm-multicolor.
+
 config LEDS_REGULATOR
 	tristate "REGULATOR driven LED support"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/leds-pwm-multicolor.c b/drivers/leds/leds-pwm-multicolor.c
index bc4d21ddd74a..96712b8ca98e 100644
--- a/drivers/leds/leds-pwm-multicolor.c
+++ b/drivers/leds/leds-pwm-multicolor.c
@@ -9,9 +9,11 @@
 #include <linux/kernel.h>
 #include <linux/led-class-multicolor.h>
 #include <linux/leds.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 
 struct pwm_led {
@@ -28,17 +30,17 @@ struct pwm_mc_led {
 static int led_pwm_mc_set(struct led_classdev *cdev,
 			  enum led_brightness brightness)
 {
-	int i;
-	unsigned long long duty;
-	int ret = 0;
 	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
 	struct pwm_mc_led *priv = container_of(mc_cdev, struct pwm_mc_led, mc_cdev);
+	unsigned long long duty;
+	int ret = 0;
+	int i;
 
 	led_mc_calc_color_components(mc_cdev, brightness);
 
 	mutex_lock(&priv->lock);
 
-	for (i = 0; i < mc_cdev->num_colors; ++i) {
+	for (i = 0; i < mc_cdev->num_colors; i++) {
 		duty = priv->leds[i].state.period;
 		duty *= mc_cdev->subled_info[i].brightness;
 		do_div(duty, cdev->max_brightness);
@@ -59,25 +61,23 @@ static int led_pwm_mc_set(struct led_classdev *cdev,
 static int led_pwm_mc_probe(struct platform_device *pdev)
 {
 	struct fwnode_handle *mcnode, *fwnode;
-	int count = 0;
-	struct pwm_mc_led *priv;
-	struct mc_subled *subled;
+	struct led_init_data init_data = {};
 	struct led_classdev *cdev;
+	struct mc_subled *subled;
+	struct pwm_mc_led *priv;
 	struct pwm_led *pwmled;
-	u32 color;
+	int count = 0;
 	int ret = 0;
-	struct led_init_data init_data = {};
+	u32 color;
 
 	mcnode = device_get_named_child_node(&pdev->dev, "multi-led");
-	if (!mcnode) {
-		dev_err(&pdev->dev, "expected multi-led node\n");
-		ret = -ENODEV;
-		goto out;
-	}
+	if (!mcnode)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "expected multi-led node\n");
 
 	/* count the nodes inside the multi-led node */
 	fwnode_for_each_child_node(mcnode, fwnode)
-		++count;
+		count++;
 
 	priv = devm_kzalloc(&pdev->dev, struct_size(priv, leds, count),
 			    GFP_KERNEL);
@@ -90,7 +90,7 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 	subled = devm_kcalloc(&pdev->dev, count, sizeof(*subled), GFP_KERNEL);
 	if (!subled) {
 		ret = -ENOMEM;
-		goto destroy_mutex;
+		goto release_mcnode;
 	}
 	priv->mc_cdev.subled_info = subled;
 
@@ -109,7 +109,7 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 			ret = PTR_ERR(pwmled->pwm);
 			dev_err(&pdev->dev, "unable to request PWM: %d\n", ret);
 			fwnode_handle_put(fwnode);
-			goto destroy_mutex;
+			goto release_mcnode;
 		}
 		pwm_init_state(pwmled->pwm, &pwmled->state);
 
@@ -117,11 +117,11 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(&pdev->dev, "cannot read color: %d\n", ret);
 			fwnode_handle_put(fwnode);
-			goto destroy_mutex;
+			goto release_mcnode;
 		}
 
 		subled[priv->mc_cdev.num_colors].color_index = color;
-		++priv->mc_cdev.num_colors;
+		priv->mc_cdev.num_colors++;
 	}
 
 	init_data.fwnode = mcnode;
@@ -132,50 +132,36 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"failed to register multicolor PWM led for %s: %d\n",
 			cdev->name, ret);
-		goto destroy_mutex;
+		goto release_mcnode;
 	}
 
 	ret = led_pwm_mc_set(cdev, cdev->brightness);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to set led PWM value for %s: %d",
-			cdev->name, ret);
-		goto destroy_mutex;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to set led PWM value for %s: %d",
+				     cdev->name, ret);
 
 	platform_set_drvdata(pdev, priv);
 	return 0;
 
-destroy_mutex:
-	mutex_destroy(&priv->lock);
 release_mcnode:
 	fwnode_handle_put(mcnode);
-out:
 	return ret;
 }
 
-static int led_pwm_mc_remove(struct platform_device *pdev)
-{
-	struct pwm_mc_led *priv = platform_get_drvdata(pdev);
-
-	mutex_destroy(&priv->lock);
-	return 0;
-}
-
 static const struct of_device_id of_pwm_leds_mc_match[] = {
 	{ .compatible = "pwm-leds-multicolor", },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, of_pwm_leds_mc_match);
 
 static struct platform_driver led_pwm_mc_driver = {
 	.probe		= led_pwm_mc_probe,
-	.remove		= led_pwm_mc_remove,
 	.driver		= {
 		.name	= "leds_pwm_multicolor",
 		.of_match_table = of_pwm_leds_mc_match,
 	},
 };
-
 module_platform_driver(led_pwm_mc_driver);
 
 MODULE_AUTHOR("Sven Schwermer <sven.schwermer@disruptive-technologies.com>");
-- 
2.35.1

