Return-Path: <linux-pwm+bounces-2325-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8595C8D7820
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2024 22:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF21FB2247D
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2024 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07A677F11;
	Sun,  2 Jun 2024 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O08/lM5+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE9770E6
	for <linux-pwm@vger.kernel.org>; Sun,  2 Jun 2024 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360404; cv=none; b=qWxTpfaRhXdSLj3yWfn+PdXjCMIR1oMWg2rkucs53o4jDbfS59rBHhkyH73DTQs/gItuX27nhPPYSykoX2jCK2RoP+xuZ0O16aQXYQZtdroteDZ3Hql1De8Gj5QsGIJCoWSTYrRalVx4yBGhAKyWZQbLi4UDAhjF+YSUX4osHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360404; c=relaxed/simple;
	bh=LEH54Xss6M4fJdUT0ypflO26lqVmUNuMH4m+tTK9ZIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXjoVvRsdoNFmmI76tHZRZ+dTGbNccuHfBcIrKtaa4Yhfe6WVXx1JF2ro+Yq/Fxoz2VFQvBb5dltqFntrs2VsOFsobGJqDk2owu6xdVQfGx4nC2ZUeBUMJYzHqBEqPOZ54wOR5DK00XP8FaE8cKz7xa91NSYlCICpF7sy/zfvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O08/lM5+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52965199234so4118354e87.2
        for <linux-pwm@vger.kernel.org>; Sun, 02 Jun 2024 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717360401; x=1717965201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VddKJjdJ2hWtpkrc2+6Jag2VOkVNIboyOcgFS2Ya0c=;
        b=O08/lM5+Hl6aPedScRJP4inr50ai9ng1fjObosoxap4OrAUzzY6Aoa8L/AoYHcKxcD
         BjHJ+pKidgkX6LhDzyXPPp8Xy3X3pzXDRJHQpcsNGVy2E+vZbtoYrIe/KDQdBnR3otU8
         KlPtFsg7DzddYkeyuzJ7jhlA8+jtvVI3A+vIvuYoEN3GDSa8Ctx4LaoH1gyZHX3+oAxD
         PYIKBN5faB0AEgrdRZlsSc5M3nAwh8dzc8QfNMb+ca08JznS77JuF4tPbXkfX0Q8b32v
         a/NJYWJ6iDdm19nsn1FHW7ZsEgE1T14Ysx9vumzSFHPiK0MaxUKU06N3NIsE7JImgtdc
         ePng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360401; x=1717965201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VddKJjdJ2hWtpkrc2+6Jag2VOkVNIboyOcgFS2Ya0c=;
        b=SyAFhCKjBHzZRqrMCdOBAiL3Ne/kMrTumYIEDrZwuF9od295m/HtVPI69v3OURtNyZ
         eeXNnPdMP/j1OXwzn4/apzVzRR9PN3Xz710tZgPyTE4YZ6Nek+UqT/fj3xCTuGse5tUS
         Gg++MYMYr0YHO2V2A3lc8iq+bsoJCaciXsB7eYetO4VeUZBSpzuPxjCh0pkpPHUctPVE
         1AIgVY8f/b69rzIDIvbdWqkT7cX7CRmAPyzdAJWnKOJ2DiwIEcIXeBiphh77EuvH9kY9
         du2VH9NsQ1LGsX6loR+ad6x5BWCRcYLNF0pWsF7LWZaWaiUg6SLNZ7QDAHM6hCX3XeS1
         qivQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn3LKAp1A7Ka+JTl0Slh3zgOowlspa533lGGCBmXSzsfX8KKYmbqqIXvc9Z+6Hzw9h34S+XCw0rjsFzIsr2v81daQFQXRELkLU
X-Gm-Message-State: AOJu0YwHYh5Uu18l+LrGLungbn+eeshEuZJPxjlGaDIOebI7ND4X0bEY
	KCuU04Wg9SuGV5r5cdjqw9VG4ctqXG0pKlpOM7+twBeGbSNjBsf7A2d+V+bl+JY=
X-Google-Smtp-Source: AGHT+IGvg21TUFiJusrL8v6x/FgG8eOjVDQorlu2qC+SsxyjWCxhwERsdQE9JqaI5oIxj7t8lI+guA==
X-Received: by 2002:a05:6512:4c6:b0:52b:5f39:9221 with SMTP id 2adb3069b0e04-52b896f183fmr4342822e87.64.1717360400937;
        Sun, 02 Jun 2024 13:33:20 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b98845508sm245859e87.288.2024.06.02.13.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:33:19 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 02 Jun 2024 22:33:09 +0200
Subject: [PATCH v6 2/2] pwm: Add GPIO PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240602-pwm-gpio-v6-2-e8f6ec9cc783@linaro.org>
References: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org>
In-Reply-To: <20240602-pwm-gpio-v6-0-e8f6ec9cc783@linaro.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com, 
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Stefan Wahren <wahrenst@gmx.net>, 
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.13.0

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

Add a software PWM which toggles a GPIO from a high-resolution timer.

This will naturally not be as accurate or as efficient as a hardware
PWM, but it is useful in some cases.  I have for example used it for
evaluating LED brightness handling (via leds-pwm) on a board where the
LED was just hooked up to a GPIO, and for a simple verification of the
timer frequency on another platform.

Since high-resolution timers are used, sleeping GPIO chips are not
supported and are rejected in the probe function.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Co-developed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/driver-api/gpio/drivers-on-gpio.rst |   7 +-
 drivers/pwm/Kconfig                               |  11 +
 drivers/pwm/Makefile                              |   1 +
 drivers/pwm/pwm-gpio.c                            | 243 ++++++++++++++++++++++
 4 files changed, 261 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/gpio/drivers-on-gpio.rst b/Documentation/driver-api/gpio/drivers-on-gpio.rst
index af632d764ac6..95572d2a94ce 100644
--- a/Documentation/driver-api/gpio/drivers-on-gpio.rst
+++ b/Documentation/driver-api/gpio/drivers-on-gpio.rst
@@ -27,7 +27,12 @@ hardware descriptions such as device tree or ACPI:
   to the lines for a more permanent solution of this type.
 
 - gpio-beeper: drivers/input/misc/gpio-beeper.c is used to provide a beep from
-  an external speaker connected to a GPIO line.
+  an external speaker connected to a GPIO line. (If the beep is controlled by
+  off/on, for an actual PWM waveform, see pwm-gpio below.)
+
+- pwm-gpio: drivers/pwm/pwm-gpio.c is used to toggle a GPIO with a high
+  resolution timer producing a PWM waveform on the GPIO line, as well as
+  Linux high resolution timers can do.
 
 - extcon-gpio: drivers/extcon/extcon-gpio.c is used when you need to read an
   external connector status, such as a headset line for an audio driver or an
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 1dd7921194f5..68ba28d52c4c 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -223,6 +223,17 @@ config PWM_FSL_FTM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-fsl-ftm.
 
+config PWM_GPIO
+	tristate "GPIO PWM support"
+	depends on GPIOLIB
+	depends on HIGH_RES_TIMERS
+	help
+	  Generic PWM framework driver for software PWM toggling a GPIO pin
+	  from kernel high-resolution timers.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-gpio.
+
 config PWM_HIBVT
 	tristate "HiSilicon BVT PWM support"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 90913519f11a..65d62cc41a8f 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
+obj-$(CONFIG_PWM_GPIO)		+= pwm-gpio.o
 obj-$(CONFIG_PWM_HIBVT)		+= pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
new file mode 100644
index 000000000000..32ae9bba87c3
--- /dev/null
+++ b/drivers/pwm/pwm-gpio.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic software PWM for modulating GPIOs
+ *
+ * Copyright (C) 2020 Axis Communications AB
+ * Copyright (C) 2020 Nicola Di Lieto
+ * Copyright (C) 2024 Stefan Wahren
+ * Copyright (C) 2024 Linus Walleij
+ */
+
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/hrtimer.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
+#include <linux/spinlock.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+struct pwm_gpio {
+	struct hrtimer gpio_timer;
+	struct gpio_desc *gpio;
+	struct pwm_state state;
+	struct pwm_state next_state;
+
+	/* Protect internal state between pwm_ops and hrtimer */
+	spinlock_t lock;
+
+	bool changing;
+	bool running;
+	bool level;
+};
+
+static void pwm_gpio_round(struct pwm_state *dest, const struct pwm_state *src)
+{
+	u64 dividend;
+	u32 remainder;
+
+	*dest = *src;
+
+	/* Round down to hrtimer resolution */
+	dividend = dest->period;
+	remainder = do_div(dividend, hrtimer_resolution);
+	dest->period -= remainder;
+
+	dividend = dest->duty_cycle;
+	remainder = do_div(dividend, hrtimer_resolution);
+	dest->duty_cycle -= remainder;
+}
+
+static u64 pwm_gpio_toggle(struct pwm_gpio *gpwm, bool level)
+{
+	const struct pwm_state *state = &gpwm->state;
+	bool invert = state->polarity == PWM_POLARITY_INVERSED;
+
+	gpwm->level = level;
+	gpiod_set_value(gpwm->gpio, gpwm->level ^ invert);
+
+	if (!state->duty_cycle || state->duty_cycle == state->period) {
+		gpwm->running = false;
+		return 0;
+	}
+
+	gpwm->running = true;
+	return level ? state->duty_cycle : state->period - state->duty_cycle;
+}
+
+static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *gpio_timer)
+{
+	struct pwm_gpio *gpwm = container_of(gpio_timer, struct pwm_gpio,
+					     gpio_timer);
+	u64 next_toggle;
+	bool new_level;
+
+	guard(spinlock_irqsave)(&gpwm->lock);
+
+	/* Apply new state at end of current period */
+	if (!gpwm->level && gpwm->changing) {
+		gpwm->changing = false;
+		gpwm->state = gpwm->next_state;
+		new_level = !!gpwm->state.duty_cycle;
+	} else {
+		new_level = !gpwm->level;
+	}
+
+	next_toggle = pwm_gpio_toggle(gpwm, new_level);
+	if (next_toggle)
+		hrtimer_forward(gpio_timer, hrtimer_get_expires(gpio_timer),
+				ns_to_ktime(next_toggle));
+
+	return next_toggle ? HRTIMER_RESTART : HRTIMER_NORESTART;
+}
+
+static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	struct pwm_gpio *gpwm = pwmchip_get_drvdata(chip);
+	bool invert = state->polarity == PWM_POLARITY_INVERSED;
+
+	if (state->duty_cycle && state->duty_cycle < hrtimer_resolution)
+		return -EINVAL;
+
+	if (state->duty_cycle != state->period &&
+	    (state->period - state->duty_cycle < hrtimer_resolution))
+		return -EINVAL;
+
+	if (!state->enabled) {
+		hrtimer_cancel(&gpwm->gpio_timer);
+	} else if (!gpwm->running) {
+		int ret;
+
+		/*
+		 * This just enables the output, but pwm_gpio_toggle()
+		 * really starts the duty cycle.
+		 */
+		ret = gpiod_direction_output(gpwm->gpio, invert);
+		if (ret)
+			return ret;
+	}
+
+	guard(spinlock_irqsave)(&gpwm->lock);
+
+	if (!state->enabled) {
+		pwm_gpio_round(&gpwm->state, state);
+		gpwm->running = false;
+		gpwm->changing = false;
+
+		gpiod_set_value(gpwm->gpio, invert);
+	} else if (gpwm->running) {
+		pwm_gpio_round(&gpwm->next_state, state);
+		gpwm->changing = true;
+	} else {
+		unsigned long next_toggle;
+
+		pwm_gpio_round(&gpwm->state, state);
+		gpwm->changing = false;
+
+		next_toggle = pwm_gpio_toggle(gpwm, !!state->duty_cycle);
+		if (next_toggle)
+			hrtimer_start(&gpwm->gpio_timer, next_toggle,
+				      HRTIMER_MODE_REL);
+	}
+
+	return 0;
+}
+
+static int pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct pwm_gpio *gpwm = pwmchip_get_drvdata(chip);
+
+	guard(spinlock_irqsave)(&gpwm->lock);
+
+	if (gpwm->changing)
+		*state = gpwm->next_state;
+	else
+		*state = gpwm->state;
+
+	return 0;
+}
+
+static const struct pwm_ops pwm_gpio_ops = {
+	.apply = pwm_gpio_apply,
+	.get_state = pwm_gpio_get_state,
+};
+
+static void pwm_gpio_disable_hrtimer(void *data)
+{
+	struct pwm_gpio *gpwm = data;
+
+	hrtimer_cancel(&gpwm->gpio_timer);
+}
+
+static int pwm_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
+	struct pwm_gpio *gpwm;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*gpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	gpwm = pwmchip_get_drvdata(chip);
+
+	spin_lock_init(&gpwm->lock);
+
+	gpwm->gpio = devm_gpiod_get(dev, NULL, GPIOD_ASIS);
+	if (IS_ERR(gpwm->gpio))
+		return dev_err_probe(dev, PTR_ERR(gpwm->gpio),
+				     "%pfw: could not get gpio\n",
+				     dev_fwnode(dev));
+
+	if (gpiod_cansleep(gpwm->gpio))
+		return dev_err_probe(dev, -EINVAL,
+				     "%pfw: sleeping GPIO not supported\n",
+				     dev_fwnode(dev));
+
+	chip->ops = &pwm_gpio_ops;
+	chip->atomic = true;
+
+	hrtimer_init(&gpwm->gpio_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ret = devm_add_action_or_reset(dev, pwm_gpio_disable_hrtimer, gpwm);
+	if (ret)
+		return ret;
+
+	gpwm->gpio_timer.function = pwm_gpio_timer;
+
+	ret = pwmchip_add(chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "could not add pwmchip\n");
+
+	platform_set_drvdata(pdev, gpwm);
+
+	return 0;
+}
+
+static const struct of_device_id pwm_gpio_dt_ids[] = {
+	{ .compatible = "pwm-gpio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pwm_gpio_dt_ids);
+
+static struct platform_driver pwm_gpio_driver = {
+	.driver = {
+		.name = "pwm-gpio",
+		.of_match_table = pwm_gpio_dt_ids,
+	},
+	.probe = pwm_gpio_probe,
+};
+module_platform_driver(pwm_gpio_driver);
+
+MODULE_DESCRIPTION("PWM GPIO driver");
+MODULE_AUTHOR("Vincent Whitchurch");
+MODULE_LICENSE("GPL");

-- 
2.45.1


