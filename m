Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3ED22DA88
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jul 2020 01:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgGYXTr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 Jul 2020 19:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgGYXTF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Jul 2020 19:19:05 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9499CC08C5C0;
        Sat, 25 Jul 2020 16:19:04 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 716C823E44;
        Sun, 26 Jul 2020 01:19:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595719143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8f+9wMUYIftgWhOFB1JTULU7e/DlL3E7X7hMoc+boKM=;
        b=pmucjxbz11RDuWUvKHhmJMc5JNC9upNN/Arz6EJ5vpYzm24iMGLgo8NjG3IEbHZDAGg8ew
        eaTmvyhhuGAO/DsQCB1s24FXPHWj2JBtel4jnxLsDBbD5MSEl0FfeNegsHpOv8bQAYdL2Z
        gzeRT2Xq9YUrfqOpy6ElYWF1xa1PwKo=
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v6 06/13] pwm: add support for sl28cpld PWM controller
Date:   Sun, 26 Jul 2020 01:18:27 +0200
Message-Id: <20200725231834.25642-7-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200725231834.25642-1-michael@walle.cc>
References: <20200725231834.25642-1-michael@walle.cc>
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
Changes since v5:
 - added brief description of the PWM hardware implementation
 - added hardware limitations
 - dropped the frequency mode table, instead calculate the prescaler
   value on the fly.
 - round the requested parameters instead of support just distinct
   periods.
 - prefix the macros by SL28CPLD_ to make them less generic
 - set polarity to PWM_POLARITY_NORMAL and reject inverted polarity
   requests.
 - apply the workaround just for prescaler value of 0.
 - make errors during probing more verbose

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
 drivers/pwm/pwm-sl28cpld.c | 223 +++++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)
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
index 000000000000..956fa09f3aba
--- /dev/null
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * sl28cpld PWM driver
+ *
+ * Copyright (c) 2020 Michael Walle <michael@walle.cc>
+ *
+ * There is no public datasheet available for this PWM core. But it is easy
+ * enough to be briefly explained. It consists of one 8-bit counter. The PWM
+ * supports four distinct frequencies by selecting when to reset the counter.
+ * With the prescaler setting you can select which bit of the counter is used
+ * to reset it. This implies that the higher the frequency the less remaining
+ * bits are available for the actual counter.
+ *
+ * Let cnt[7:0] be the counter, clocked at 32kHz:
+ * +-----------+--------+--------------+-----------+
+ * | prescaler |  reset | counter bits | frequency |
+ * +-----------+--------+--------------+-----------+
+ * |         0 | cnt[7] |     cnt[6:0] |     250Hz |
+ * |         1 | cnt[6] |     cnt[5:0] |     500Hz |
+ * |         2 | cnt[5] |     cnt[4:0] |      1kHz |
+ * |         3 | cnt[4] |     cnt[3:0] |      2kHz |
+ * +-----------+--------+--------------+-----------+
+ *
+ * Limitations:
+ * - The hardware cannot generate a 100% duty cycle if the prescaler is 0.
+ * - The hardware cannot atomically set the prescaler and the counter value,
+ *   which might lead to glitches and inconsistent states if a write fails.
+ * - The counter is not reset if you switch the prescaler which leads
+ *   to glitches, too.
+ * - The duty cycle will switch immediately and not after a complete cycle.
+ * - Depending on the actual implementation, disabling the PWM might have
+ *   side effects. For example, if the output pin is shared with a GPIO pin
+ *   it will automatically switch back to GPIO mode.
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
+#define SL28CPLD_PWM_CTRL			0x00
+#define   SL28CPLD_PWM_CTRL_ENABLE		BIT(7)
+#define   SL28CPLD_PWM_CTRL_PRESCALER_MASK	GENMASK(1, 0)
+#define SL28CPLD_PWM_CYCLE			0x01
+#define   SL28CPLD_PWM_CYCLE_MAX		GENMASK(6, 0)
+
+#define SL28CPLD_PWM_CLK			32000 /* 32 kHz */
+#define SL28CPLD_PWM_MAX_DUTY_CYCLE(prescaler)	(1 << (7 - (prescaler)))
+#define SL28CPLD_PWM_PERIOD(prescaler) \
+	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * SL28CPLD_PWM_MAX_DUTY_CYCLE(prescaler))
+
+/*
+ * We calculate the duty cycle like this:
+ *   duty_cycle_ns = pwm_cycle_reg * max_period_ns / max_duty_cycle
+ *
+ * With
+ *   max_period_ns = (1 << 7 - prescaler) / pwm_clk * NSEC_PER_SEC
+ *   max_duty_cycle = 1 << (7 - prescaler)
+ * this then simplifies to:
+ *   duty_cycle_ns = pwm_cycle_reg / pwm_clk * NSEC_PER_SEC
+ */
+#define SL28CPLD_PWM_TO_DUTY_CYCLE(reg) \
+	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * (reg))
+#define SL28CPLD_PWM_FROM_DUTY_CYCLE(duty_cycle) \
+	(DIV_ROUND_DOWN_ULL((duty_cycle), NSEC_PER_SEC / SL28CPLD_PWM_CLK))
+
+struct sl28cpld_pwm {
+	struct pwm_chip pwm_chip;
+	struct regmap *regmap;
+	u32 offset;
+};
+
+static void sl28cpld_pwm_get_state(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   struct pwm_state *state)
+{
+	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
+	unsigned int reg;
+	int prescaler;
+
+	regmap_read(priv->regmap, priv->offset + SL28CPLD_PWM_CTRL, &reg);
+
+	state->enabled = reg & SL28CPLD_PWM_CTRL_ENABLE;
+
+	prescaler = FIELD_GET(SL28CPLD_PWM_CTRL_PRESCALER_MASK, reg);
+	state->period = SL28CPLD_PWM_PERIOD(prescaler);
+
+	regmap_read(priv->regmap, priv->offset + SL28CPLD_PWM_CYCLE, &reg);
+	state->duty_cycle = SL28CPLD_PWM_TO_DUTY_CYCLE(reg);
+	state->polarity = PWM_POLARITY_NORMAL;
+}
+
+static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
+	unsigned int cycle, prescaler;
+	int ret;
+	u8 ctrl;
+
+	/* Polarity inversion is not supported */
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * Calculate the prescaler. Pick the the biggest period that isn't
+	 * bigger than the requested period.
+	 */
+	prescaler = DIV_ROUND_UP_ULL(SL28CPLD_PWM_PERIOD(0), state->period);
+	prescaler = order_base_2(prescaler);
+
+	if (prescaler > field_max(SL28CPLD_PWM_CTRL_PRESCALER_MASK))
+		return -ERANGE;
+
+	ctrl = FIELD_PREP(SL28CPLD_PWM_CTRL_PRESCALER_MASK, prescaler);
+	if (state->enabled)
+		ctrl |= SL28CPLD_PWM_CTRL_ENABLE;
+
+	cycle = SL28CPLD_PWM_FROM_DUTY_CYCLE(state->duty_cycle);
+	cycle = min_t(unsigned int, cycle, SL28CPLD_PWM_MAX_DUTY_CYCLE(prescaler));
+
+	/*
+	 * Work around the hardware limitation. See also above. Trap 100% duty
+	 * cycle if the prescaler is 0. Set prescaler to 1 instead. We don't
+	 * care about the frequency because its "all-one" in either case.
+	 *
+	 * We don't need to check the actual prescaler setting, because only
+	 * if the prescaler is 0 we can have this particular value.
+	 */
+	if (cycle == SL28CPLD_PWM_MAX_DUTY_CYCLE(0)) {
+		ctrl &= ~SL28CPLD_PWM_CTRL_PRESCALER_MASK;
+		ctrl |= FIELD_PREP(SL28CPLD_PWM_CTRL_PRESCALER_MASK, 1);
+		cycle = SL28CPLD_PWM_MAX_DUTY_CYCLE(1);
+	}
+
+	ret = regmap_write(priv->regmap, priv->offset + SL28CPLD_PWM_CTRL, ctrl);
+	if (ret)
+		return ret;
+
+	return regmap_write(priv->regmap, priv->offset + SL28CPLD_PWM_CYCLE, (u8)cycle);
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
+	if (ret) {
+		dev_err(&pdev->dev, "no 'reg' property found (%pe)\n",
+			ERR_PTR(ret));
+		return -EINVAL;
+	}
+
+	/* Initialize the pwm_chip structure */
+	chip = &priv->pwm_chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &sl28cpld_pwm_ops;
+	chip->base = -1;
+	chip->npwm = 1;
+
+	ret = pwmchip_add(&priv->pwm_chip);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add PWM chip (%pe)",
+			ERR_PTR(ret));
+		return ret;
+	}
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

