Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36898244C64
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Aug 2020 18:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHNQCl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Aug 2020 12:02:41 -0400
Received: from smtp2.axis.com ([195.60.68.18]:51476 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgHNQCj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 14 Aug 2020 12:02:39 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Aug 2020 12:02:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=5875; q=dns/txt; s=axis-central1;
  t=1597420958; x=1628956958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wlkm85miuh5Ubj0O9GpEOx4iAJ2QCuLhxi0fh2VaIPQ=;
  b=UzOLknhXsV7g7+2K3nnfFYEUSEqnwEIV1fWc49gw0bKvogpswYR+SwaZ
   Nu4SEKBg6lCRGs4D3TTMqYxkarD1X9cciJ86yD8s+ui4AxkHEjssHJ2cW
   VIgZUi+v6JPVzctMVFX6lJvOW5DhchIpE+2iqemAHKJ9XThxyQAP2CWvK
   iI93+x1ZzXe/k9wKvbnwrhTIDop7BC+ILKejYLVJFdjB8Zoqab4TZH6LW
   w+OQJgtVJQ/m9VevpJyWWlWbghI65RYLlb6s6XLRqUu6xy9DiJpNEyNoL
   JZkncf7f+x2xR9f2j4pwzyyJ+YrAJz7aVdHeALAeJ+3zWlH8bFyAIerXw
   A==;
IronPort-SDR: Y6dBNiK6gqbk+f47HBq+NTLa04lL5naTNkiBigGNHgHYnNFFIaEfw15Zf4X/TejBBRHPT92741
 jKHPHWASfgHTo9Hnocqvq8b9TrOr4LEFuZNgGhSbj6iP+gZKr83Uj/uTPBvOfsu2GGXL5JMyU0
 ft/DinMEqmIufuV5wz3JVwYKoX8FEj8yeTEQs8NalTNnb0cqOGhoudP+ISzuo3jx4GHFaAPZko
 8T9mflhEnRqZCd97hAh1P4W2rXW/fwAFplnxiJISScGk3OAzAm9ptdgfiVBkCfh6GrbA5dNB9i
 LaU=
X-IronPort-AV: E=Sophos;i="5.76,312,1592863200"; 
   d="scan'208";a="11476347"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>
CC:     <kernel@axis.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <oliver@schinagl.nl>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 2/2] pwm: Add GPIO PWM driver
Date:   Fri, 14 Aug 2020 17:55:13 +0200
Message-ID: <20200814155513.31936-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814155513.31936-1-vincent.whitchurch@axis.com>
References: <20200814155513.31936-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a software PWM which toggles a GPIO from a high-resolution timer.

This will naturally not be as accurate or as efficient as a hardware
PWM, but it is useful in some cases.  I have for example used it for
evaluating LED brightness handling (via leds-pwm) on a board where the
LED was just hooked up to a GPIO, and for a simple verification of the
timer frequency on another platform.

Since high-resolution timers are used, sleeping gpio chips are not
supported and are rejected in the probe function.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
While preparing this driver for posting, I found a pwm-gpio driver posted to
the lists way back in 2015 by Olliver Schinagl:

 https://lore.kernel.org/linux-pwm/1445895161-2317-8-git-send-email-o.schinagl@ultimaker.com/

This driver was developed independently, but since both drivers are trivial
they are quite similar.  The main difference I see (apart from the usage of
newer APIs and DT schemas) is that this driver only supports one PWM per
instance, which makes for simpler code.  I also reject sleeping GPIO chips
explicitly while that driver uses gpio_set_value_cansleep() from a hrtimer,
which is a no-no.

 drivers/pwm/Kconfig    |  10 ++++
 drivers/pwm/Makefile   |   1 +
 drivers/pwm/pwm-gpio.c | 123 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/pwm/pwm-gpio.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 7dbcf6973d33..20e4fda82e61 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -181,6 +181,16 @@ config PWM_FSL_FTM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-fsl-ftm.
 
+config PWM_GPIO
+	tristate "GPIO PWM support"
+	depends on OF && GPIOLIB
+	help
+	  Generic PWM framework driver for a software PWM toggling a GPIO pin
+	  from kernel high-resolution timers.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-gpio.
+
 config PWM_HIBVT
 	tristate "HiSilicon BVT PWM support"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 2c2ba0a03557..2e045f063cd1 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
+obj-$(CONFIG_PWM_GPIO)		+= pwm-gpio.o
 obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
new file mode 100644
index 000000000000..e579aca0f937
--- /dev/null
+++ b/drivers/pwm/pwm-gpio.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2020 Axis Communications AB */
+
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/hrtimer.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pwm.h>
+#include <linux/err.h>
+#include <linux/of.h>
+
+struct pwm_gpio {
+	struct pwm_chip chip;
+	struct hrtimer hrtimer;
+	struct gpio_desc *gpio;
+	ktime_t on_interval;
+	ktime_t off_interval;
+	bool invert;
+	bool on;
+};
+
+static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *hrtimer)
+{
+	struct pwm_gpio *gpwm = container_of(hrtimer, struct pwm_gpio, hrtimer);
+	bool newon = !gpwm->on;
+
+	gpwm->on = newon;
+	gpiod_set_value(gpwm->gpio, newon ^ gpwm->invert);
+
+	hrtimer_forward_now(hrtimer, newon ? gpwm->on_interval : gpwm->off_interval);
+
+	return HRTIMER_RESTART;
+}
+
+static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	struct pwm_gpio *gpwm = container_of(chip, struct pwm_gpio, chip);
+
+	hrtimer_cancel(&gpwm->hrtimer);
+
+	if (!state->enabled) {
+		gpiod_set_value(gpwm->gpio, 0);
+		return 0;
+	}
+
+	gpwm->on_interval = ns_to_ktime(state->duty_cycle);
+	gpwm->off_interval = ns_to_ktime(state->period - state->duty_cycle);
+	gpwm->invert = state->polarity == PWM_POLARITY_INVERSED;
+
+	gpwm->on = !!gpwm->on_interval;
+	gpiod_set_value(gpwm->gpio, gpwm->on ^ gpwm->invert);
+
+	if (gpwm->on_interval && gpwm->off_interval)
+		hrtimer_start(&gpwm->hrtimer, gpwm->on_interval, HRTIMER_MODE_REL);
+
+	return 0;
+}
+
+static const struct pwm_ops pwm_gpio_ops = {
+	.owner = THIS_MODULE,
+	.apply = pwm_gpio_apply,
+};
+
+static int pwm_gpio_probe(struct platform_device *pdev)
+{
+	struct pwm_gpio *gpwm;
+	int ret;
+
+	gpwm = devm_kzalloc(&pdev->dev, sizeof(*gpwm), GFP_KERNEL);
+	if (!gpwm)
+		return -ENOMEM;
+
+	gpwm->gpio = devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
+	if (IS_ERR(gpwm->gpio))
+		return PTR_ERR(gpwm->gpio);
+
+	if (gpiod_cansleep(gpwm->gpio))
+		return -EINVAL;
+
+	gpwm->chip.dev = &pdev->dev;
+	gpwm->chip.ops = &pwm_gpio_ops;
+	gpwm->chip.base = pdev->id;
+	gpwm->chip.npwm = 1;
+
+	hrtimer_init(&gpwm->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	gpwm->hrtimer.function = pwm_gpio_timer;
+
+	ret = pwmchip_add(&gpwm->chip);
+	if (ret < 0)
+		return ret;
+
+	platform_set_drvdata(pdev, gpwm);
+
+	return 0;
+}
+
+static int pwm_gpio_remove(struct platform_device *pdev)
+{
+	struct pwm_gpio *gpwm = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&gpwm->chip);
+}
+
+static const struct of_device_id pwm_gpio_dt_ids[] = {
+	{ .compatible = "pwm-gpio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwm_gpio_dt_ids);
+
+static struct platform_driver pwm_gpio_driver = {
+	.driver = {
+		.name = "pwm-gpio",
+		.of_match_table = pwm_gpio_dt_ids,
+	},
+	.probe = pwm_gpio_probe,
+	.remove = pwm_gpio_remove,
+};
+
+module_platform_driver(pwm_gpio_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

