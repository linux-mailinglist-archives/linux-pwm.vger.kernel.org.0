Return-Path: <linux-pwm+bounces-2342-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F31A38FBDB5
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 23:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698161F255B1
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Jun 2024 21:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D74614D28A;
	Tue,  4 Jun 2024 21:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqLi9+fR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7F14C591
	for <linux-pwm@vger.kernel.org>; Tue,  4 Jun 2024 21:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717534850; cv=none; b=rPWmUo48iKqOeVjul+LHhmk9gqZnA6S5Bv5bThWF93FzKw9n/Zr17DnPKClUMAIno+dZ9lBvyqbeSg4mGgh9Kt6rpeAf+su4OrgShye78yh8dcG5SnzCABzXja7BE2f5rV8NFhJgdnZw4hVR56OgqucIwINMJFSJMjSMnj1wnjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717534850; c=relaxed/simple;
	bh=ESTF32lMBgnfmtpVmFxezA2ZDd3LVBT4FCldxnU73VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbII/X/b0HI9a96O1QkdOYTPqeE4xFcaPoSEDnbcczE2OLLyTXF0kP3Oqxj7Yx/FDHxhoeS4/gmWI8JypkDmxeildP3mTKQ8SMHQmJTKU/Fn5lOmbQOQwMHCESIgkF9OkRDACbGhgOhF1mU1muxj+XSokP3ZCzkLydbfCIIpPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fqLi9+fR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e95a1f9c53so74144371fa.0
        for <linux-pwm@vger.kernel.org>; Tue, 04 Jun 2024 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717534846; x=1718139646; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wPN7HZ2vwvvaPOlO2MX7LqUrxdB6GJC3BE6c+ARMRWU=;
        b=fqLi9+fR7ZFW90BEivbbOfyMOJKOdeUgxDZVMEXr6xprcM2m0fwB+mi2hoC3oea4OL
         oa56l+9lUR1pi4T/TujCJPBya5U9dc7zxcHCwKhaczr02yemCTbJTx5HAT7NIpgZYvkg
         UleOPpcCqW/WxYgb0OFuPqmcWaNMGj0oHOUwku3GSSdr0AyhhqSy5oM4JZ3xTmLmqUDv
         8jwf0p+4Y2fxAKp7dlHfNKjmNG2TKLlg7UNzSRsMPs1ZjJkSadzxz5KGaHY80diaCEAF
         ZSNEj5CaJHc6NiUd8FutVgdXJJWEngw6lY/qy8BMSqWxdHV7OUBhE7CDOPWELk6b9VfW
         t1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717534846; x=1718139646;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPN7HZ2vwvvaPOlO2MX7LqUrxdB6GJC3BE6c+ARMRWU=;
        b=uCJNqgTAfG5KSHIKtyJXCPQmj96FAUkSFibrI7md6sbY0l6UwWaVAvQW+J9BdKWX3y
         gOP139GV/5SkRxzDDnJFA0b286Mob3FVEIvW5vGJFEB5J6g9arSYbMrAAaVlPKGEvSHV
         tr5AsI5OPDYRaqObUILLMBtE20Yr673m5IRPianuXWkQV9dOoLu182sniTuTu7xoEFaa
         U5qJ/xceuOEKVCf+Lffq2jzCsDSAflq+OwWGoWHRolx5Z8FajcRBFhFyW0y5fTcvjyAa
         Y0dlHwULLMQqM6XPGbqnUlq+9o8HpZK7xAAysfCT6pleAlGVaT++Jxjgz/WMLpV4cKOb
         5V5w==
X-Forwarded-Encrypted: i=1; AJvYcCVr86bAxDQB1hzHoebDSldBJeRFd3BhgiDPtJhrpgoNwG8kPkge1RjBtpM6gGmTwyyMM99eagTSx2ulLTm1F1JJ0orsGGmBZ13C
X-Gm-Message-State: AOJu0YzZw6GWVCh+XW8OpAMndU/7bvj6TmfZnBAt9qWaqueLD9sRwWDM
	/Icc0cyUFC0icva0FGIF0mvq1lzs39rHjLtMIkSko2ZmzmTJJsMQduiE1Ms5sNI=
X-Google-Smtp-Source: AGHT+IFs3MkcSueqtHX9PciHP/k4irbilM07o/0UR/kiPwl5QdzapG7Ex7bzRFQvfYUUhTUQrzrD1g==
X-Received: by 2002:a2e:9811:0:b0:2e5:67bc:6f2 with SMTP id 38308e7fff4ca-2eac7a988ddmr1970521fa.44.1717534846130;
        Tue, 04 Jun 2024 14:00:46 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cc8082sm16140991fa.94.2024.06.04.14.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 14:00:44 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 04 Jun 2024 23:00:41 +0200
Subject: [PATCH v7 2/2] pwm: Add GPIO PWM driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-pwm-gpio-v7-2-6b67cf60db92@linaro.org>
References: <20240604-pwm-gpio-v7-0-6b67cf60db92@linaro.org>
In-Reply-To: <20240604-pwm-gpio-v7-0-6b67cf60db92@linaro.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com, 
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Stefan Wahren <wahrenst@gmx.net>, 
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Vincent Whitchurch <vincent.whitchurch@axis.com>, 
 Andy Shevchenko <andy@kernel.org>
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
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/driver-api/gpio/drivers-on-gpio.rst |   7 +-
 drivers/pwm/Kconfig                               |  11 +
 drivers/pwm/Makefile                              |   1 +
 drivers/pwm/pwm-gpio.c                            | 241 ++++++++++++++++++++++
 4 files changed, 259 insertions(+), 1 deletion(-)

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
index 000000000000..9f8884ac7504
--- /dev/null
+++ b/drivers/pwm/pwm-gpio.c
@@ -0,0 +1,241 @@
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


