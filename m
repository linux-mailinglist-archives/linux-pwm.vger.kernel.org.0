Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAB42D7C5E
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 18:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392152AbgLKRGR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 12:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394288AbgLKRFb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Dec 2020 12:05:31 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34FDC061793
        for <linux-pwm@vger.kernel.org>; Fri, 11 Dec 2020 09:04:50 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id y19so14243929lfa.13
        for <linux-pwm@vger.kernel.org>; Fri, 11 Dec 2020 09:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OZQ6PDs1QdSK1hbVaFeCy9qBnWIxwRfwd0fj0h6NUbo=;
        b=tVy2Wd6Hwx0BO8P/mPCBTMVuAaCrk0pWNgfXMrPjEcXsleM3XsEfsjbYlxDGFkhEKR
         QFI2nvDm2iGsnd05VoVI+GfsQRqgrvCP6nseCJ9TwITA+4Z6Ybgjibi24Sgq4/SNNByI
         HsYfceHY8fhxedezgx6ho3smFg+iK0GY0RQ1JP7KL8geC+FHVhTWF3lV4l/qaYolbSVo
         EkUK25IN7nLOs1THopczpodzpnlKqkDtJDYSZ5o9cSLIQ8HlScageVE/mEZQCl0quOH7
         FTx1ys7HQNieXlQKs600w8XijBCqxpyRLuOytVtXhW8lSY1ALvyFryr/ew9gYIrEm2DQ
         ykUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZQ6PDs1QdSK1hbVaFeCy9qBnWIxwRfwd0fj0h6NUbo=;
        b=pAoLQL1PpXj7+4VzMg6k9Pqd5BaOGCkRa4L5ji1UnS9Jx1nZ+OoRDt/70jAZI/oYRf
         I5ktuNCQ9A4kdYaK3dnRA1PRK8LIes26HXqsaVTEB5/+qYahu78VsDyXpL9pf/IG1DL8
         DmYgRhGeEcUeRLWUvnr7B295nTgRvJiJGOpjjVzzMVfv4VINRahnC1mFy/yCKaTldOk0
         z5WNwaYrlph3hxMqEOHXURCnknEDx9VA3CrxHeYN/1QLjBq4Zp4bOZRvZBydvS16N1hq
         HHQUJ48+juoFhE5nyzOS5/I7Nkq9X7I9PJY0jrAIKTCEB4kA2krSYMr6SXAfAY+P3UD5
         xQLQ==
X-Gm-Message-State: AOAM533cjHLSPy6AT0WcViL9ozffKJJ4yy0yLHSkoEh4WlsvnpCI+j2b
        7TRs+RMWFbDd+6NGGKQ9MR+UxzADyvB4VvILe36jSQ==
X-Google-Smtp-Source: ABdhPJwCzbigeQ1vPK17mhIM4YURv4nnP4DccDQbaK0OD4D49LtDUPBvTupk5QSJtOJQezxr5pvlnA==
X-Received: by 2002:ac2:59c6:: with SMTP id x6mr5178986lfn.82.1607706288871;
        Fri, 11 Dec 2020 09:04:48 -0800 (PST)
Received: from einstein.dilieto.eu (einstein.dilieto.eu. [2a03:4000:17:6e2::1000])
        by smtp.gmail.com with ESMTPSA id c4sm944809lfh.94.2020.12.11.09.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 09:04:48 -0800 (PST)
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     linux-pwm@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] pwm: pwm-gpio: New driver
Date:   Fri, 11 Dec 2020 18:04:31 +0100
Message-Id: <20201211170432.6113-2-nicola.dilieto@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201211170432.6113-1-nicola.dilieto@gmail.com>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com>
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
 drivers/pwm/pwm-gpio.c | 188 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 drivers/pwm/pwm-gpio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 52086876ce40..486a8857b47b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14222,6 +14222,13 @@ F:	Documentation/devicetree/bindings/hwmon/pwm-fan.txt
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
index 000000000000..06b4ddee389d
--- /dev/null
+++ b/drivers/pwm/pwm-gpio.c
@@ -0,0 +1,188 @@
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
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+struct pwm_gpio {
+	struct pwm_chip chip;
+	struct gpio_desc *desc;
+	struct work_struct work;
+	struct hrtimer timer;
+	atomic_t enabled;
+	spinlock_t lock;
+	struct {
+		u64 ton_ns;
+		u64 toff_ns;
+		bool invert;
+	} cur, new;
+	bool state;
+	bool output;
+};
+
+static void pwm_gpio_work(struct work_struct *work)
+{
+	struct pwm_gpio *pwm_gpio = container_of(work, struct pwm_gpio, work);
+
+	gpiod_set_value_cansleep(pwm_gpio->desc, pwm_gpio->output);
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
+	if (pwm_gpio->state) {
+		ns = pwm_gpio->cur.toff_ns;
+		pwm_gpio->state = false;
+	} else {
+		if (spin_trylock(&pwm_gpio->lock)) {
+			pwm_gpio->cur = pwm_gpio->new;
+			spin_unlock(&pwm_gpio->lock);
+		}
+		ns = pwm_gpio->cur.ton_ns;
+		pwm_gpio->state = true;
+	}
+	pwm_gpio->output = pwm_gpio->state ^ pwm_gpio->cur.invert;
+
+	schedule_work(&pwm_gpio->work);
+	hrtimer_forward(handle, hrtimer_get_expires(handle), ns_to_ktime(ns));
+
+	return HRTIMER_RESTART;
+}
+
+static inline struct pwm_gpio *pwm_gpio_from_chip(struct pwm_chip *_chip)
+{
+	return container_of(_chip, struct pwm_gpio, chip);
+}
+
+static void pwm_gpio_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_gpio *pwm_gpio = pwm_gpio_from_chip(chip);
+
+	cancel_work_sync(&pwm_gpio->work);
+	gpiod_set_value_cansleep(pwm_gpio->desc, pwm_gpio->cur.invert);
+}
+
+static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	struct pwm_gpio *pwm_gpio = pwm_gpio_from_chip(chip);
+
+	spin_lock(&pwm_gpio->lock);
+	pwm_gpio->new.ton_ns = state->duty_cycle;
+	pwm_gpio->new.toff_ns = state->period - state->duty_cycle;
+	pwm_gpio->new.invert = (state->polarity == PWM_POLARITY_INVERSED);
+	spin_unlock(&pwm_gpio->lock);
+
+	if (state->enabled && !atomic_cmpxchg(&pwm_gpio->enabled, 0, 1)) {
+		hrtimer_start(&pwm_gpio->timer, 0, HRTIMER_MODE_REL);
+	} else if (!state->enabled && atomic_cmpxchg(&pwm_gpio->enabled, 1, 0)) {
+		pwm_gpio->state = false;
+		pwm_gpio->output = (state->polarity == PWM_POLARITY_INVERSED);
+		schedule_work(&pwm_gpio->work);
+	}
+	return 0;
+}
+
+static void pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct pwm_gpio *pwm_gpio = pwm_gpio_from_chip(chip);
+
+	state->duty_cycle = pwm_gpio->new.ton_ns;
+	state->period = pwm_gpio->new.ton_ns + pwm_gpio->new.toff_ns;
+	state->polarity = pwm_gpio->new.invert ? PWM_POLARITY_INVERSED
+					       : PWM_POLARITY_NORMAL;
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
+	pwm_gpio->chip.base = -1;
+
+	platform_set_drvdata(pdev, pwm_gpio);
+
+	spin_lock_init(&pwm_gpio->lock);
+
+	return pwmchip_add(&pwm_gpio->chip);
+}
+
+static int pwm_gpio_remove(struct platform_device *pdev)
+{
+	int ret;
+	struct pwm_gpio *pwm_gpio = platform_get_drvdata(pdev);
+
+	ret = pwmchip_remove(&pwm_gpio->chip);
+	if (ret)
+		return ret;
+
+	hrtimer_cancel(&pwm_gpio->timer);
+
+	return 0;
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

