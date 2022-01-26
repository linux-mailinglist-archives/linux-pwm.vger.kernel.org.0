Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8983449C7E9
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jan 2022 11:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbiAZKtA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jan 2022 05:49:00 -0500
Received: from mail.schwermer.no ([49.12.228.226]:59172 "EHLO
        mail.schwermer.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbiAZKs7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jan 2022 05:48:59 -0500
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1643194131;
        bh=/v0yMFkImvcfC3KjY1tLpHyj9fxf/TQH7leivdxQIb8=;
        h=From:To:Cc:Subject;
        b=mh2RpdbMeYydBAB6t5vA8dhCGqF/muvSR3waRBn/IoLe1gYQGl6d5LS9b7mK0b46L
         +tZrnaLgR3S8Rv90L+cbKd3DYu+i4422Q1BCLJO4o4EB7n0ZnMy7vSHqBsHqsakYzR
         t8uGzx53at9cpbxd3FWS1fa2d0bj4Fi98slJ+yMWmPVioad6Zmg0uSLOCTAYi0FYix
         ZgzRCGEPfxa6kfOox+zQRvsjLvmCSy25X/7yYOQJ91kh6v6lwjx3jansIFinr++Fbg
         /fVK6IfwbOrfuGvnDbQ3ivYosL2LmxkoC9w7HjB/Pc9WmrP/nyTL+MtsgCKamOuGu7
         EDnPqtDRjpvBw==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
Subject: [PATCH v3 0/2] Multicolor PWM LED support
Date:   Wed, 26 Jan 2022 11:48:42 +0100
Message-Id: <20220126104844.246068-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/leds/Kconfig                          |   8 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-pwm-multicolor.c            | 184 ++++++++++++++++++
 4 files changed, 268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
 create mode 100644 drivers/leds/leds-pwm-multicolor.c

Interdiff against v2:
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
index b82b26f2e140..5a7ed5e1bb9f 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -17,8 +17,7 @@ properties:
   compatible:
     const: pwm-leds-multicolor
 
-patternProperties:
-  '^multi-led@[0-9a-f]$':
+  multi-led:
     type: object
     allOf:
       - $ref: leds-class-multicolor.yaml#
@@ -51,7 +50,7 @@ examples:
     rgb-led {
         compatible = "pwm-leds-multicolor";
 
-        multi-led@0 {
+        multi-led {
           color = <LED_COLOR_ID_RGB>;
           function = LED_FUNCTION_INDICATOR;
           max-brightness = <65535>;
diff --git a/drivers/leds/leds-pwm-multicolor.c b/drivers/leds/leds-pwm-multicolor.c
index c54bed4536d3..bc4d21ddd74a 100644
--- a/drivers/leds/leds-pwm-multicolor.c
+++ b/drivers/leds/leds-pwm-multicolor.c
@@ -5,18 +5,18 @@
  * Copyright 2022 Sven Schwermer <sven.schwermer@disruptive-technologies.com>
  */
 
-#include <linux/module.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
 #include <linux/led-class-multicolor.h>
 #include <linux/leds.h>
-#include <linux/err.h>
-#include <linux/pwm.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
 
 struct pwm_led {
 	struct pwm_device *pwm;
-	struct pwm_state pwmstate;
+	struct pwm_state state;
 };
 
 struct pwm_mc_led {
@@ -39,14 +39,14 @@ static int led_pwm_mc_set(struct led_classdev *cdev,
 	mutex_lock(&priv->lock);
 
 	for (i = 0; i < mc_cdev->num_colors; ++i) {
-		duty = priv->leds[i].pwmstate.period;
+		duty = priv->leds[i].state.period;
 		duty *= mc_cdev->subled_info[i].brightness;
 		do_div(duty, cdev->max_brightness);
 
-		priv->leds[i].pwmstate.duty_cycle = duty;
-		priv->leds[i].pwmstate.enabled = duty > 0;
+		priv->leds[i].state.duty_cycle = duty;
+		priv->leds[i].state.enabled = duty > 0;
 		ret = pwm_apply_state(priv->leds[i].pwm,
-				      &priv->leds[i].pwmstate);
+				      &priv->leds[i].state);
 		if (ret)
 			break;
 	}
@@ -83,7 +83,7 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 			    GFP_KERNEL);
 	if (!priv) {
 		ret = -ENOMEM;
-		goto out;
+		goto release_mcnode;
 	}
 	mutex_init(&priv->lock);
 
@@ -96,8 +96,6 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 
 	/* init the multicolor's LED class device */
 	cdev = &priv->mc_cdev.led_cdev;
-	fwnode_property_read_string(mcnode, "label", &cdev->name);
-	cdev->brightness = LED_OFF;
 	fwnode_property_read_u32(mcnode, "max-brightness",
 				 &cdev->max_brightness);
 	cdev->flags = LED_CORE_SUSPENDRESUME;
@@ -110,19 +108,19 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 		if (IS_ERR(pwmled->pwm)) {
 			ret = PTR_ERR(pwmled->pwm);
 			dev_err(&pdev->dev, "unable to request PWM: %d\n", ret);
+			fwnode_handle_put(fwnode);
 			goto destroy_mutex;
 		}
-		pwm_init_state(pwmled->pwm, &pwmled->pwmstate);
+		pwm_init_state(pwmled->pwm, &pwmled->state);
 
 		ret = fwnode_property_read_u32(fwnode, "color", &color);
 		if (ret) {
 			dev_err(&pdev->dev, "cannot read color: %d\n", ret);
+			fwnode_handle_put(fwnode);
 			goto destroy_mutex;
 		}
 
 		subled[priv->mc_cdev.num_colors].color_index = color;
-		subled[priv->mc_cdev.num_colors].channel =
-			priv->mc_cdev.num_colors;
 		++priv->mc_cdev.num_colors;
 	}
 
@@ -149,6 +147,8 @@ static int led_pwm_mc_probe(struct platform_device *pdev)
 
 destroy_mutex:
 	mutex_destroy(&priv->lock);
+release_mcnode:
+	fwnode_handle_put(mcnode);
 out:
 	return ret;
 }
-- 
2.35.0

