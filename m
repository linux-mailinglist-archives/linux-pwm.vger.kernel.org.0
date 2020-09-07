Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00FD426067F
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Sep 2020 23:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgIGVkI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Sep 2020 17:40:08 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:54647 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgIGViY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Sep 2020 17:38:24 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B46F723E47;
        Mon,  7 Sep 2020 23:38:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1599514699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Y31xzXF9MQJbq5L0RXJtNuH32vhoF72yDLLyzXytJw=;
        b=gkIVETadbYRSkqPC2uLDhOULMXT5gDi6FnCdbL2O8dw0KdbXv8iWYBjwPqfslWyx6ic5UU
        XhROWdWAlhRl4yMwysJKfkw8SiZpMossZQKKsIWgpiNDVGqO1zlNvl++vLWZQttJulzmu9
        wN79xKkkFB1VQY7kceB5YZHrZd8W5BA=
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
Subject: [PATCH v9 06/13] pwm: add support for sl28cpld PWM controller
Date:   Mon,  7 Sep 2020 23:37:55 +0200
Message-Id: <20200907213802.26745-7-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907213802.26745-1-michael@walle.cc>
References: <20200907213802.26745-1-michael@walle.cc>
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
Acked-by: Thierry Reding <thierry.reding@gmail.com>
---
Changes since v8:
 - none

Changes since v7:
 - added "depends on MFD_SL28CPLD || COMPILE_TEST"
 - corrected comment about divison
 - sanitize pwm values before handing them over to the PWM core
 - check wether we need to write the the duty cycle first to avoid
   glitches

Changes since v6:
 - added new row "period length"
 - fixed parenthesis mistake in the description of a calculation
 - added sl28cpld_pwm_{read/write}()
 - added more error messages

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
 drivers/pwm/pwm-sl28cpld.c | 269 +++++++++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+)
 create mode 100644 drivers/pwm/pwm-sl28cpld.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 9448e4ca8c73..a0692deafcb5 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -428,6 +428,16 @@ config PWM_SIFIVE
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sifive.
 
+config PWM_SL28CPLD
+	tristate "Kontron sl28cpld PWM support"
+	depends on MFD_SL28CPLD ||  COMPILE_TEST
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
index 000000000000..29e338368d3e
--- /dev/null
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -0,0 +1,269 @@
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
+ * +-----------+--------+--------------+-----------+---------------+
+ * | prescaler |  reset | counter bits | frequency | period length |
+ * +-----------+--------+--------------+-----------+---------------+
+ * |         0 | cnt[7] |     cnt[6:0] |    250 Hz |    4000000 ns |
+ * |         1 | cnt[6] |     cnt[5:0] |    500 Hz |    2000000 ns |
+ * |         2 | cnt[5] |     cnt[4:0] |     1 kHz |    1000000 ns |
+ * |         3 | cnt[4] |     cnt[3:0] |     2 kHz |     500000 ns |
+ * +-----------+--------+--------------+-----------+---------------+
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
+ *   max_period_ns = 1 << (7 - prescaler) / pwm_clk * NSEC_PER_SEC
+ *   max_duty_cycle = 1 << (7 - prescaler)
+ * this then simplifies to:
+ *   duty_cycle_ns = pwm_cycle_reg / pwm_clk * NSEC_PER_SEC
+ *
+ * NSEC_PER_SEC is a multiple of SL28CPLD_PWM_CLK, therefore we're not losing
+ * precision by doing the divison first.
+ */
+#define SL28CPLD_PWM_TO_DUTY_CYCLE(reg) \
+	(NSEC_PER_SEC / SL28CPLD_PWM_CLK * (reg))
+#define SL28CPLD_PWM_FROM_DUTY_CYCLE(duty_cycle) \
+	(DIV_ROUND_DOWN_ULL((duty_cycle), NSEC_PER_SEC / SL28CPLD_PWM_CLK))
+
+#define sl28cpld_pwm_read(priv, reg, val) \
+	regmap_read((priv)->regmap, (priv)->offset + (reg), (val))
+#define sl28cpld_pwm_write(priv, reg, val) \
+	regmap_write((priv)->regmap, (priv)->offset + (reg), (val))
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
+	sl28cpld_pwm_read(priv, SL28CPLD_PWM_CTRL, &reg);
+
+	state->enabled = reg & SL28CPLD_PWM_CTRL_ENABLE;
+
+	prescaler = FIELD_GET(SL28CPLD_PWM_CTRL_PRESCALER_MASK, reg);
+	state->period = SL28CPLD_PWM_PERIOD(prescaler);
+
+	sl28cpld_pwm_read(priv, SL28CPLD_PWM_CYCLE, &reg);
+	state->duty_cycle = SL28CPLD_PWM_TO_DUTY_CYCLE(reg);
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	/*
+	 * Sanitize values for the PWM core. Depending on the prescaler it
+	 * might happen that we calculate a duty_cycle greater than the actual
+	 * period. This might happen if someone (e.g. the bootloader) sets an
+	 * invalid combination of values. The behavior of the hardware is
+	 * undefined in this case. But we need to report sane values back to
+	 * the PWM core.
+	 */
+	state->duty_cycle = min(state->duty_cycle, state->period);
+}
+
+static int sl28cpld_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct sl28cpld_pwm *priv = dev_get_drvdata(chip->dev);
+	unsigned int cycle, prescaler;
+	bool write_duty_cycle_first;
+	int ret;
+	u8 ctrl;
+
+	/* Polarity inversion is not supported */
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	/*
+	 * Calculate the prescaler. Pick the biggest period that isn't
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
+	/*
+	 * To avoid glitches when we switch the prescaler, we have to make sure
+	 * we have a valid duty cycle for the new mode.
+	 *
+	 * Take the current prescaler (or the current period length) into
+	 * account to decide whether we have to write the duty cycle or the new
+	 * prescaler first. If the period length is decreasing we have to
+	 * write the duty cycle first.
+	 */
+	write_duty_cycle_first = pwm->state.period > state->period;
+
+	if (write_duty_cycle_first) {
+		ret = sl28cpld_pwm_write(priv, SL28CPLD_PWM_CYCLE, cycle);
+		if (ret)
+			return ret;
+	}
+
+	ret = sl28cpld_pwm_write(priv, SL28CPLD_PWM_CTRL, ctrl);
+	if (ret)
+		return ret;
+
+	if (!write_duty_cycle_first) {
+		ret = sl28cpld_pwm_write(priv, SL28CPLD_PWM_CYCLE, cycle);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
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
+	if (!pdev->dev.parent) {
+		dev_err(&pdev->dev, "no parent device\n");
+		return -ENODEV;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!priv->regmap) {
+		dev_err(&pdev->dev, "could not get parent regmap\n");
+		return -ENODEV;
+	}
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

