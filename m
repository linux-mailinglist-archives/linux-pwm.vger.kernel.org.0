Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD58215DC0
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2020 19:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgGFR6O (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Jul 2020 13:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgGFR5g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jul 2020 13:57:36 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED75C061794;
        Mon,  6 Jul 2020 10:57:35 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ABF0622FEB;
        Mon,  6 Jul 2020 19:57:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594058254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHl1Tc7aOvXirXfgGGWl8EwtNqd6E5CLj8vfFb2yY3g=;
        b=mg771PBZKgAHlINc3ltwnUEF7MXmdgIPYHHgwI0osEyyLpUzsoJxvAXAb+FeW6RHvIYWXb
        9a67BNfhvj4ssNhnZ1GemB9gehM/gtRNXj9lHcSZTcA0IyNyl/FTMbEayzJeTqq3Fo2vDW
        JpfZhOvjf2ql4v6LAMokTblogcFgusA=
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v5 07/13] pwm: add support for sl28cpld PWM controller
Date:   Mon,  6 Jul 2020 19:53:47 +0200
Message-Id: <20200706175353.16404-8-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706175353.16404-1-michael@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for the PWM controller of the sl28cpld board management
controller. This is part of a multi-function device driver.

The controller has one PWM channel and can just generate four distinct
frequencies.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v4:
 - update copyright year
 - remove #include <linux/of_device.h>, suggested by Andy.
 - make the pwm mode table look nicer, suggested by Lee.
 - use dev_get_drvdata(chip->dev) instead of container_of(), suggested by
   Lee.
 - use whole sentence in comments, suggested by Lee.
 - renamed the local "struct sl28cpld_pwm" variable to "priv" everywhere,
   suggested by Lee.
 - use pwm_{get,set}_relative_duty_cycle(), suggested by Andy.
 - make the comment about the 250Hz hardware limitation clearer
 - don't use "if (ret < 0)", but only "if (ret)", suggested by Andy.
 - don't use KBUID_MODNAME
 - remove comma in terminator line of the compatible strings list
 - remove the platform device table

Changes since v3:
 - see cover letter

 drivers/pwm/Kconfig        |  10 ++
 drivers/pwm/Makefile       |   1 +
 drivers/pwm/pwm-sl28cpld.c | 187 +++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/pwm/pwm-sl28cpld.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 7dbcf6973d33..a0d50d70c3b9 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -428,6 +428,16 @@ config PWM_SIFIVE
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sifive.
 
+config PWM_SL28CPLD
+	tristate "Kontron sl28cpld PWM support"
+	select MFD_SIMPLE_MFD_I2C
+	help
+	  Generic PWM framework driver for board management controller
+	  found on the Kontron sl28 CPLD.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sl28cpld.
+
 config PWM_SPEAR
 	tristate "STMicroelectronics SPEAr PWM support"
 	depends on PLAT_SPEAR || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 2c2ba0a03557..cbdcd55d69ee 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
+obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
 obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
 obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
 obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
new file mode 100644
index 000000000000..8ee286b605bf
--- /dev/null
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sl28cpld PWM driver
+ *
+ * Copyright 2020 Kontron Europe GmbH
+ */
+
+#include <linux/bitfield.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+/*
+ * PWM timer block registers.
+ */
+#define PWM_CTRL		0x00
+#define   PWM_ENABLE		BIT(7)
+#define   PWM_MODE_250HZ	0
+#define   PWM_MODE_500HZ	1
+#define   PWM_MODE_1KHZ		2
+#define   PWM_MODE_2KHZ		3
+#define   PWM_MODE_MASK		GENMASK(1, 0)
+#define PWM_CYCLE		0x01
+#define   PWM_CYCLE_MAX		0x7f
+
+struct sl28cpld_pwm {
+	struct pwm_chip pwm_chip;
+	struct regmap *regmap;
+	u32 offset;
+};
+
+struct sl28cpld_pwm_periods {
+	u8 ctrl;
+	unsigned long duty_cycle;
+};
+
+struct sl28cpld_pwm_config {
+	unsigned long period_ns;
+	u8 max_duty_cycle;
+};
+
+static struct sl28cpld_pwm_config sl28cpld_pwm_config[] = {
+	[PWM_MODE_250HZ] = { .period_ns = 4000000, .max_duty_cycle = 0x80 },
+	[PWM_MODE_500HZ] = { .period_ns = 2000000, .max_duty_cycle = 0x40 },
+	[PWM_MODE_1KHZ]  = { .period_ns = 1000000, .max_duty_cycle = 0x20 },
+	[PWM_MODE_2KHZ]  = { .period_ns =  500000, .max_duty_cycle = 0x10 },
+};
+
+static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   struct pwm_state *state)
+{
+	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
+	static struct sl28cpld_pwm_config *config;
+	unsigned int reg;
+	unsigned int mode;
+
+	regmap_read(priv->regmap, priv->offset + PWM_CTRL, &reg);
+
+	state->enabled = reg & PWM_ENABLE;
+
+	mode = FIELD_GET(PWM_MODE_MASK, reg);
+	config = &sl28cpld_pwm_config[mode];
+	state->period = config->period_ns;
+
+	regmap_read(priv->regmap, priv->offset + PWM_CYCLE, &reg);
+	pwm_set_relative_duty_cycle(state, reg, config->max_duty_cycle);
+}
+
+static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
+	struct sl28cpld_pwm_config *config;
+	unsigned int cycle;
+	int ret;
+	int mode;
+	u8 ctrl;
+
+	/* Get the configuration by comparing the period */
+	for (mode = 0; mode < ARRAY_SIZE(sl28cpld_pwm_config); mode++) {
+		config = &sl28cpld_pwm_config[mode];
+		if (state->period == config->period_ns)
+			break;
+	}
+
+	if (mode == ARRAY_SIZE(sl28cpld_pwm_config))
+		return -EINVAL;
+
+	ctrl = FIELD_PREP(PWM_MODE_MASK, mode);
+	if (state->enabled)
+		ctrl |= PWM_ENABLE;
+
+	cycle = pwm_get_relative_duty_cycle(state, config->max_duty_cycle);
+
+	/*
+	 * The hardware doesn't allow to set max_duty_cycle if the
+	 * 250Hz mode is enabled, thus we have to trap that here.
+	 * But because a 100% duty cycle is equal on all modes, i.e.
+	 * it is just a "all-high" output, we trap any case with a
+	 * 100% duty cycle and use the 500Hz mode.
+	 */
+	if (cycle == config->max_duty_cycle) {
+		ctrl &= ~PWM_MODE_MASK;
+		ctrl |= FIELD_PREP(PWM_MODE_MASK, PWM_MODE_500HZ);
+		cycle = PWM_CYCLE_MAX;
+	}
+
+	ret = regmap_write(priv->regmap, priv->offset + PWM_CTRL, ctrl);
+	if (ret)
+		return ret;
+
+	return regmap_write(priv->regmap, priv->offset + PWM_CYCLE, (u8)cycle);
+}
+
+static const struct pwm_ops sl28cpld_pwm_ops = {
+	.apply = sl28cpld_pwm_apply,
+	.get_state = sl28cpld_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int sl28cpld_pwm_probe(struct platform_device *pdev)
+{
+	struct sl28cpld_pwm *priv;
+	struct pwm_chip *chip;
+	int ret;
+
+	if (!pdev->dev.parent)
+		return -ENODEV;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!priv->regmap)
+		return -ENODEV;
+
+	ret = device_property_read_u32(&pdev->dev, "reg", &priv->offset);
+	if (ret)
+		return -EINVAL;
+
+	/* Initialize the pwm_chip structure */
+	chip = &priv->pwm_chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &sl28cpld_pwm_ops;
+	chip->base = -1;
+	chip->npwm = 1;
+
+	ret = pwmchip_add(&priv->pwm_chip);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int sl28cpld_pwm_remove(struct platform_device *pdev)
+{
+	struct sl28cpld_pwm *priv = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&priv->pwm_chip);
+}
+
+static const struct of_device_id sl28cpld_pwm_of_match[] = {
+	{ .compatible = "kontron,sl28cpld-pwm" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sl28cpld_pwm_of_match);
+
+static struct platform_driver sl28cpld_pwm_driver = {
+	.probe = sl28cpld_pwm_probe,
+	.remove	= sl28cpld_pwm_remove,
+	.driver = {
+		.name = "sl28cpld-pwm",
+		.of_match_table = sl28cpld_pwm_of_match,
+	},
+};
+module_platform_driver(sl28cpld_pwm_driver);
+
+MODULE_DESCRIPTION("sl28cpld PWM Driver");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_LICENSE("GPL");
-- 
2.20.1

