Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF032CFF58
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 22:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgLEVok (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Dec 2020 16:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLEVok (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 16:44:40 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECA5C0613D1
        for <linux-pwm@vger.kernel.org>; Sat,  5 Dec 2020 13:43:59 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id r18so10765269ljc.2
        for <linux-pwm@vger.kernel.org>; Sat, 05 Dec 2020 13:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RBWJc2G89rIviA8W1HJZcxquyFaN4q5Tk2nXV5IYFT8=;
        b=ngQCxYjs09w2IUkZQQv65wg65Y44ICVTZjWlmfTk3c3i8EtA86pK3occf7iQ0Um64L
         JBSI93nTRfcerxOb64hACqA8ZOl6uiXhQIFVQ0uXoYYeOLz5QI8vviNhl7KBlzgmaYZg
         VhI3OchjGabrBq/ruUIToTYcObgdPsy3plBRP2F8myBeZ3DSwY88OJwns9VV3hyVMxXW
         5gOXjBz62HJvAhm7sKbJ44RacvtEkhLa7hGVMpWc68wL1a9EOSEb8KA0sQd6VIL4eP/K
         9Xn1UWe1XVfrzX4XGxkWkHoVfP4AfELh8CqwVX54eJhVYgJ5bAZJaLG8dg/SQJi3yfXY
         jVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RBWJc2G89rIviA8W1HJZcxquyFaN4q5Tk2nXV5IYFT8=;
        b=B6WkKr5Qyw5ThN/7zNKGz+S7/p5ql8b677pWGin96Bfrrg2vPUNeC8xBrTtApHPYPm
         oEK6LlWQqHbCc5v8s2O9FATTjC8dI9ySdzGnTGHe0349VODfH/j+dXX3cNhUiUvRWTrj
         3TBpePW8HUbUA+thErQ204Yt/ecWNAmnngQdO4lghWz28NlwA1kM9IUC91T+wC94BwHr
         1iTyQxoGhY3uOberz1Xkt6MXdIgSKugg5DMGjkM9n/iisZljPyyFSfJv9/XW0YHmFuEu
         AOuDN+kO7PVeNQyQK9j/SrPw9P7npZ0Mk1vA7qp47QZSB15cwHGOaecqg+fclIYiUtlD
         g7uw==
X-Gm-Message-State: AOAM531okbsWACKAAFzSX6l5/DCk2eqfk5uB70k4MGlYk3RZBzVH7bMh
        7CLruIyGdbkl/ME37GyK//hOg0fFT8NJkA==
X-Google-Smtp-Source: ABdhPJx3UgOFo4kX4ZZTNgTDgG1BpSc8E846SbjCu2sFGLKYS3neGZ/vWzpv7rfx84OcmEM/QMZNtA==
X-Received: by 2002:a2e:2a46:: with SMTP id q67mr533215ljq.331.1607204637810;
        Sat, 05 Dec 2020 13:43:57 -0800 (PST)
Received: from einstein.dilieto.eu (einstein.dilieto.eu. [188.68.43.228])
        by smtp.gmail.com with ESMTPSA id r15sm52665lfn.309.2020.12.05.13.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Dec 2020 13:43:57 -0800 (PST)
Date:   Sat, 5 Dec 2020 22:43:53 +0100
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/2] pwm: pwm-gpio: New driver
Message-ID: <20201205214353.xapax46tt5snzd2v@einstein.dilieto.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This new driver allows pulse width modulating any GPIOs using
a high resolution timer. It is fully generic and can be useful
in a variety of situations. As an example I used it to provide
a pwm to the pwm-beeper driver so that my embedded system can
produce tones through a piezo buzzer connected to a GPIO which
unfortunately is not hardware PWM capable.

Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
---
 MAINTAINERS            |   7 ++
 drivers/pwm/Kconfig    |  10 +++
 drivers/pwm/Makefile   |   1 +
 drivers/pwm/pwm-gpio.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/pwm/pwm-gpio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ebe4829cdd4d..fe9b5b00ba94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14215,6 +14215,13 @@ F:	Documentation/devicetree/bindings/hwmon/pwm-fan.txt
 F:	Documentation/hwmon/pwm-fan.rst
 F:	drivers/hwmon/pwm-fan.c
 
+PWM GPIO DRIVER
+M:	Nicola Di Lieto <nicola.dilieto@gmail.com>
+L:	linux-pwm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
+F:	drivers/pwm/pwm-gpio.c
+
 PWM IR Transmitter
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 63be5362fd3a..5432084c6276 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -181,6 +181,16 @@ config PWM_FSL_FTM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-fsl-ftm.
 
+config PWM_GPIO
+	tristate "PWM GPIO support"
+	depends on GPIOLIB
+	depends on HIGH_RES_TIMERS
+	help
+	  Generic PWM for software modulation of GPIOs
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-gpio.
+
 config PWM_HIBVT
 	tristate "HiSilicon BVT PWM support"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index cbdcd55d69ee..eea0216215a7 100644
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
index 000000000000..6f425f2d02fe
--- /dev/null
+++ b/drivers/pwm/pwm-gpio.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic software PWM for modulating GPIOs
+ *
+ * Copyright 2020 Nicola Di Lieto
+ *
+ * Author: Nicola Di Lieto <nicola.dilieto@gmail.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/hrtimer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/workqueue.h>
+
+struct pwm_gpio {
+	struct pwm_chip chip;
+	struct gpio_desc *desc;
+	struct work_struct work;
+	struct hrtimer timer;
+	atomic_t enabled;
+	u64 ton_ns;
+	u64 toff_ns;
+	enum pwm_polarity polarity;
+	bool output;
+};
+
+static void pwm_gpio_work(struct work_struct *work)
+{
+	struct pwm_gpio *pwm_gpio = container_of(work, struct pwm_gpio, work);
+
+	gpiod_set_value_cansleep(pwm_gpio->desc,
+		(pwm_gpio->polarity == PWM_POLARITY_INVERSED) ^ pwm_gpio->output);
+}
+
+enum hrtimer_restart pwm_gpio_do_timer(struct hrtimer *handle)
+{
+	struct pwm_gpio *pwm_gpio = container_of(handle, struct pwm_gpio, timer);
+	u64 ns;
+
+	if (!atomic_read(&pwm_gpio->enabled))
+		return HRTIMER_NORESTART;
+
+	if (pwm_gpio->output) {
+		ns = pwm_gpio->toff_ns;
+		pwm_gpio->output = false;
+	} else {
+		ns = pwm_gpio->ton_ns;
+		pwm_gpio->output = true;
+	}
+
+	schedule_work(&pwm_gpio->work);
+	hrtimer_forward(handle, hrtimer_get_expires(handle), ns_to_ktime(ns));
+
+	return HRTIMER_RESTART;
+}
+
+static inline struct pwm_gpio *to_pwm_gpio(struct pwm_chip *_chip)
+{
+	return container_of(_chip, struct pwm_gpio, chip);
+}
+
+static void pwm_gpio_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_gpio *pwm_gpio = to_pwm_gpio(chip);
+
+	cancel_work_sync(&pwm_gpio->work);
+	gpiod_set_value_cansleep(pwm_gpio->desc,
+		pwm_gpio->polarity == PWM_POLARITY_INVERSED);
+}
+
+static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	struct pwm_gpio *pwm_gpio = to_pwm_gpio(chip);
+	u64 period = clamp(state->period, U64_C(50000), U64_C(1000000000));
+	u64 duty_cycle = clamp(state->duty_cycle, U64_C(0), period);
+
+	pwm_gpio->ton_ns = duty_cycle;
+	pwm_gpio->toff_ns = period - duty_cycle;
+	pwm_gpio->polarity = state->polarity;
+
+	if (state->enabled && !atomic_read(&pwm_gpio->enabled)) {
+		atomic_set(&pwm_gpio->enabled, 1);
+		hrtimer_start(&pwm_gpio->timer, 0, HRTIMER_MODE_REL);
+	} else if (!state->enabled && atomic_read(&pwm_gpio->enabled)) {
+		atomic_set(&pwm_gpio->enabled, 0);
+		pwm_gpio->output = false;
+		schedule_work(&pwm_gpio->work);
+	}
+	return 0;
+}
+
+static void pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct pwm_gpio *pwm_gpio = to_pwm_gpio(chip);
+
+	state->duty_cycle = pwm_gpio->ton_ns;
+	state->period = pwm_gpio->ton_ns + pwm_gpio->toff_ns;
+	state->polarity = pwm_gpio->polarity;
+	state->enabled = atomic_read(&pwm_gpio->enabled);
+}
+
+static const struct pwm_ops pwm_gpio_ops = {
+	.free = pwm_gpio_free,
+	.apply = pwm_gpio_apply,
+	.get_state = pwm_gpio_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int pwm_gpio_probe(struct platform_device *pdev)
+{
+	struct pwm_gpio *pwm_gpio;
+
+	pwm_gpio = devm_kzalloc(&pdev->dev, sizeof(*pwm_gpio), GFP_KERNEL);
+	if (!pwm_gpio)
+		return -ENOMEM;
+
+	pwm_gpio->desc = devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
+	if (IS_ERR(pwm_gpio->desc))
+		return PTR_ERR(pwm_gpio->desc);
+
+	INIT_WORK(&pwm_gpio->work, pwm_gpio_work);
+
+	hrtimer_init(&pwm_gpio->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	pwm_gpio->timer.function = pwm_gpio_do_timer;
+	pwm_gpio->chip.dev = &pdev->dev;
+	pwm_gpio->chip.ops = &pwm_gpio_ops;
+	pwm_gpio->chip.npwm = 1;
+
+	platform_set_drvdata(pdev, pwm_gpio);
+
+	return pwmchip_add(&pwm_gpio->chip);
+}
+
+static int pwm_gpio_remove(struct platform_device *pdev)
+{
+	struct pwm_gpio *pwm_gpio = platform_get_drvdata(pdev);
+
+	hrtimer_cancel(&pwm_gpio->timer);
+
+	return pwmchip_remove(&pwm_gpio->chip);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id pwm_gpio_of_match[] = {
+	{ .compatible = "pwm-gpio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pwm_gpio_of_match);
+#endif
+
+static struct platform_driver pwm_gpio_driver = {
+	.probe = pwm_gpio_probe,
+	.remove = pwm_gpio_remove,
+	.driver = {
+		.name = "pwm-gpio",
+		.of_match_table = of_match_ptr(pwm_gpio_of_match),
+	},
+};
+module_platform_driver(pwm_gpio_driver);
+
+MODULE_DESCRIPTION("PWM GPIO driver");
+MODULE_ALIAS("platform:pwm-gpio");
+MODULE_AUTHOR("Nicola Di Lieto");
+MODULE_LICENSE("GPL");
-- 
2.11.0

