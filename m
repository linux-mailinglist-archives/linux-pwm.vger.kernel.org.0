Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B78C49C7EF
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jan 2022 11:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240253AbiAZKtB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jan 2022 05:49:01 -0500
Received: from mail.schwermer.no ([49.12.228.226]:59210 "EHLO
        mail.schwermer.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiAZKtA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jan 2022 05:49:00 -0500
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1643194133;
        bh=OMZL8kONW/AM9+U8nIXx8+GpSz786dVhlOVIhXbrf7k=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=vuyxgXq1e9saKP01+1CzmUZX8HzT7C5I3/rEvoncH2utBh0RydONzvhRM9m8JxaKW
         tzgYrzro8+pySkovVVcb0oBV3e6et/evTiEhbZmDvLqqKXfjieQ9d34pQAqlDRKbC0
         uoMzyxL/atyblrnOCgfAatg9FHTyDhPhd1To8USD1o1z2Wp4/uwxQdj4OC2IH+1PWn
         oO85rOTLQHdgpHoBQ9wTfaVCxrChMIOgk7jeFZVOb7fqWGUjn6UyrrphsQUgDpyVxG
         Mz3oUYd/2ugCSr9WWpwFqdFbSUeUi26kYLMEPzFxtAT0AuWA9k3jjqFDxSRnGfTOzS
         s90jGaT0zIZJQ==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de
Subject: [PATCH v3 2/2] leds: Add PWM multicolor driver
Date:   Wed, 26 Jan 2022 11:48:44 +0100
Message-Id: <20220126104844.246068-3-sven@svenschwermer.de>
In-Reply-To: <20220126104844.246068-1-sven@svenschwermer.de>
References: <20220126104844.246068-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

By allowing to group multiple monochrome PWM LEDs into multicolor LEDs,
all involved LEDs can be controlled in-sync. This enables using effects
using triggers, etc.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
---

Notes:
    Changes in v3:
    * Release fwnode handles
    * Sort header includes
    * Remove deprecated device tree properties
    * Remove deprecated LED_OFF
    * Remove subled channel assignment
    * s/pwmstate/state/

 drivers/leds/Kconfig               |   8 ++
 drivers/leds/Makefile              |   1 +
 drivers/leds/leds-pwm-multicolor.c | 184 +++++++++++++++++++++++++++++
 3 files changed, 193 insertions(+)
 create mode 100644 drivers/leds/leds-pwm-multicolor.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 6090e647daee..bae1f63f6195 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -552,6 +552,14 @@ config LEDS_PWM
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
index 000000000000..bc4d21ddd74a
--- /dev/null
+++ b/drivers/leds/leds-pwm-multicolor.c
@@ -0,0 +1,184 @@
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
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
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
+	int i;
+	unsigned long long duty;
+	int ret = 0;
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct pwm_mc_led *priv = container_of(mc_cdev, struct pwm_mc_led, mc_cdev);
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+
+	mutex_lock(&priv->lock);
+
+	for (i = 0; i < mc_cdev->num_colors; ++i) {
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
+static int led_pwm_mc_probe(struct platform_device *pdev)
+{
+	struct fwnode_handle *mcnode, *fwnode;
+	int count = 0;
+	struct pwm_mc_led *priv;
+	struct mc_subled *subled;
+	struct led_classdev *cdev;
+	struct pwm_led *pwmled;
+	u32 color;
+	int ret = 0;
+	struct led_init_data init_data = {};
+
+	mcnode = device_get_named_child_node(&pdev->dev, "multi-led");
+	if (!mcnode) {
+		dev_err(&pdev->dev, "expected multi-led node\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* count the nodes inside the multi-led node */
+	fwnode_for_each_child_node(mcnode, fwnode)
+		++count;
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
+		goto destroy_mutex;
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
+	/* iterate over the nodes inside the multi-led node */
+	fwnode_for_each_child_node(mcnode, fwnode) {
+		pwmled = &priv->leds[priv->mc_cdev.num_colors];
+		pwmled->pwm = devm_fwnode_pwm_get(&pdev->dev, fwnode, NULL);
+		if (IS_ERR(pwmled->pwm)) {
+			ret = PTR_ERR(pwmled->pwm);
+			dev_err(&pdev->dev, "unable to request PWM: %d\n", ret);
+			fwnode_handle_put(fwnode);
+			goto destroy_mutex;
+		}
+		pwm_init_state(pwmled->pwm, &pwmled->state);
+
+		ret = fwnode_property_read_u32(fwnode, "color", &color);
+		if (ret) {
+			dev_err(&pdev->dev, "cannot read color: %d\n", ret);
+			fwnode_handle_put(fwnode);
+			goto destroy_mutex;
+		}
+
+		subled[priv->mc_cdev.num_colors].color_index = color;
+		++priv->mc_cdev.num_colors;
+	}
+
+	init_data.fwnode = mcnode;
+	ret = devm_led_classdev_multicolor_register_ext(&pdev->dev,
+							&priv->mc_cdev,
+							&init_data);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register multicolor PWM led for %s: %d\n",
+			cdev->name, ret);
+		goto destroy_mutex;
+	}
+
+	ret = led_pwm_mc_set(cdev, cdev->brightness);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set led PWM value for %s: %d",
+			cdev->name, ret);
+		goto destroy_mutex;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	return 0;
+
+destroy_mutex:
+	mutex_destroy(&priv->lock);
+release_mcnode:
+	fwnode_handle_put(mcnode);
+out:
+	return ret;
+}
+
+static int led_pwm_mc_remove(struct platform_device *pdev)
+{
+	struct pwm_mc_led *priv = platform_get_drvdata(pdev);
+
+	mutex_destroy(&priv->lock);
+	return 0;
+}
+
+static const struct of_device_id of_pwm_leds_mc_match[] = {
+	{ .compatible = "pwm-leds-multicolor", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_pwm_leds_mc_match);
+
+static struct platform_driver led_pwm_mc_driver = {
+	.probe		= led_pwm_mc_probe,
+	.remove		= led_pwm_mc_remove,
+	.driver		= {
+		.name	= "leds_pwm_multicolor",
+		.of_match_table = of_pwm_leds_mc_match,
+	},
+};
+
+module_platform_driver(led_pwm_mc_driver);
+
+MODULE_AUTHOR("Sven Schwermer <sven.schwermer@disruptive-technologies.com>");
+MODULE_DESCRIPTION("multi-color PWM LED driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:leds-pwm-multicolor");
-- 
2.35.0

