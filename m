Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A034AB89B
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Feb 2022 11:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238023AbiBGKSH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Feb 2022 05:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350229AbiBGKDh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Feb 2022 05:03:37 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A94C043181;
        Mon,  7 Feb 2022 02:03:34 -0800 (PST)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644228212;
        bh=UaWC6jlWJi+7N4xF716S8bVr4vlxC0qHFQUU+Udcfv4=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=HG72TVhMCPUk9Sx5gsR5dMI9po9LiZ4kbA+lRNqombbckE3XWn1ZNi1nKOPoKXiUf
         ZyRF4TLFhEe6/7ccEOzot6O5U+yZ31jh0uCxVTmVmH67jtk+DdbO9Gl74Ob/QEXX5T
         Tbab5WzTW+lQVRehWSXyKgCffrllUrbuOR6KIhQewHtVSNoCylhu98xIZ4qVcEH3hE
         qRUChM+l1k8zoY05eMRlY5YG6zE37beUXqw0/5AuMPDI7N21q0CAyW2m9s4Af2ckW7
         cG6K+qrSbMcRGtNkUTGPSc9SHISswFMpfNZUtpAZOIEObUEE12whmHO73TeZ+Tr0mP
         SmhQXKhoAYtbQ==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com
Subject: [PATCH v5 2/2] leds: Add PWM multicolor driver
Date:   Mon,  7 Feb 2022 11:03:26 +0100
Message-Id: <20220207100326.426940-3-sven@svenschwermer.de>
In-Reply-To: <20220207100326.426940-1-sven@svenschwermer.de>
References: <20220207100326.426940-1-sven@svenschwermer.de>
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

By allowing to group multiple monochrome PWM LEDs into multicolor LEDs,
all involved LEDs can be controlled in-sync. This enables using effects
using triggers, etc.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Notes:
    Changes in v5:
    * Factor iteration over subleds out into function
    
    Changes in v4:
    * Remove mutex destruction and remove function
    * Include missing headers
    * Use post-increment instead of pre-increment
    * Variable declarations in reverse xmas tree order
    * Use dev_err_probe where possible
    * Return immediately where possible
    * Cosmetic changes
    * Document LKM name
    
    Changes in v3:
    * Release fwnode handles
    * Sort header includes
    * Remove deprecated device tree properties
    * Remove deprecated LED_OFF
    * Remove subled channel assignment
    * s/pwmstate/state/

 drivers/leds/Kconfig               |  11 ++
 drivers/leds/Makefile              |   1 +
 drivers/leds/leds-pwm-multicolor.c | 186 +++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/leds/leds-pwm-multicolor.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6090e647daee..e70a46704076 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -552,6 +552,17 @@ config LEDS_PWM
 	help
 	  This option enables support for pwm driven LEDs
 
+config LEDS_PWM_MULTICOLOR
+	tristate "PWM driven multi-color LED Support"
+	depends on LEDS_CLASS_MULTICOLOR
+	depends on PWM
+	help
+	  This option enables support for PWM driven monochrome LEDs that are
+	  grouped into multicolor LEDs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-pwm-multicolor.
+
 config LEDS_REGULATOR
 	tristate "REGULATOR driven LED support"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index e58ecb36360f..ba2c2c1edf12 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_LEDS_PCA963X)		+= leds-pca963x.o
 obj-$(CONFIG_LEDS_PM8058)		+= leds-pm8058.o
 obj-$(CONFIG_LEDS_POWERNV)		+= leds-powernv.o
 obj-$(CONFIG_LEDS_PWM)			+= leds-pwm.o
+obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
 obj-$(CONFIG_LEDS_REGULATOR)		+= leds-regulator.o
 obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
 obj-$(CONFIG_LEDS_SC27XX_BLTC)		+= leds-sc27xx-bltc.o
diff --git a/drivers/leds/leds-pwm-multicolor.c b/drivers/leds/leds-pwm-multicolor.c
new file mode 100644
index 000000000000..45e38708ecb1
--- /dev/null
+++ b/drivers/leds/leds-pwm-multicolor.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PWM-based multi-color LED control
+ *
+ * Copyright 2022 Sven Schwermer <sven.schwermer@disruptive-technologies.com>
+ */
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
+
+struct pwm_led {
+	struct pwm_device *pwm;
+	struct pwm_state state;
+};
+
+struct pwm_mc_led {
+	struct led_classdev_mc mc_cdev;
+	struct mutex lock;
+	struct pwm_led leds[];
+};
+
+static int led_pwm_mc_set(struct led_classdev *cdev,
+			  enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct pwm_mc_led *priv = container_of(mc_cdev, struct pwm_mc_led, mc_cdev);
+	unsigned long long duty;
+	int ret = 0;
+	int i;
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+
+	mutex_lock(&priv->lock);
+
+	for (i = 0; i < mc_cdev->num_colors; i++) {
+		duty = priv->leds[i].state.period;
+		duty *= mc_cdev->subled_info[i].brightness;
+		do_div(duty, cdev->max_brightness);
+
+		priv->leds[i].state.duty_cycle = duty;
+		priv->leds[i].state.enabled = duty > 0;
+		ret = pwm_apply_state(priv->leds[i].pwm,
+				      &priv->leds[i].state);
+		if (ret)
+			break;
+	}
+
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
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
+static int led_pwm_mc_probe(struct platform_device *pdev)
+{
+	struct fwnode_handle *mcnode, *fwnode;
+	struct led_init_data init_data = {};
+	struct led_classdev *cdev;
+	struct mc_subled *subled;
+	struct pwm_mc_led *priv;
+	int count = 0;
+	int ret = 0;
+
+	mcnode = device_get_named_child_node(&pdev->dev, "multi-led");
+	if (!mcnode)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "expected multi-led node\n");
+
+	/* count the nodes inside the multi-led node */
+	fwnode_for_each_child_node(mcnode, fwnode)
+		count++;
+
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, leds, count),
+			    GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto release_mcnode;
+	}
+	mutex_init(&priv->lock);
+
+	subled = devm_kcalloc(&pdev->dev, count, sizeof(*subled), GFP_KERNEL);
+	if (!subled) {
+		ret = -ENOMEM;
+		goto release_mcnode;
+	}
+	priv->mc_cdev.subled_info = subled;
+
+	/* init the multicolor's LED class device */
+	cdev = &priv->mc_cdev.led_cdev;
+	fwnode_property_read_u32(mcnode, "max-brightness",
+				 &cdev->max_brightness);
+	cdev->flags = LED_CORE_SUSPENDRESUME;
+	cdev->brightness_set_blocking = led_pwm_mc_set;
+
+	ret = iterate_subleds(&pdev->dev, priv, mcnode);
+	if (ret)
+		goto release_mcnode;
+
+	init_data.fwnode = mcnode;
+	ret = devm_led_classdev_multicolor_register_ext(&pdev->dev,
+							&priv->mc_cdev,
+							&init_data);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register multicolor PWM led for %s: %d\n",
+			cdev->name, ret);
+		goto release_mcnode;
+	}
+
+	ret = led_pwm_mc_set(cdev, cdev->brightness);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to set led PWM value for %s: %d",
+				     cdev->name, ret);
+
+	platform_set_drvdata(pdev, priv);
+	return 0;
+
+release_mcnode:
+	fwnode_handle_put(mcnode);
+	return ret;
+}
+
+static const struct of_device_id of_pwm_leds_mc_match[] = {
+	{ .compatible = "pwm-leds-multicolor", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_pwm_leds_mc_match);
+
+static struct platform_driver led_pwm_mc_driver = {
+	.probe		= led_pwm_mc_probe,
+	.driver		= {
+		.name	= "leds_pwm_multicolor",
+		.of_match_table = of_pwm_leds_mc_match,
+	},
+};
+module_platform_driver(led_pwm_mc_driver);
+
+MODULE_AUTHOR("Sven Schwermer <sven.schwermer@disruptive-technologies.com>");
+MODULE_DESCRIPTION("multi-color PWM LED driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:leds-pwm-multicolor");
-- 
2.35.1

