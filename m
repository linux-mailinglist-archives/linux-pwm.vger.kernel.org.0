Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EF625AAEA
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 14:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBMM5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 08:12:57 -0400
Received: from smtp1.axis.com ([195.60.68.17]:61031 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgIBMMv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 2 Sep 2020 08:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=7037; q=dns/txt; s=axis-central1;
  t=1599048770; x=1630584770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NgY5w3xH2lj1cZZS/nQahGWKPSDaeMwerV/JL1U8k9o=;
  b=dXLF2B8zZ/WkWzyTM6P1IU5q5PJnDcGLfGhnS/IA+KkNaaeZppxWCO8j
   EbmLvql1AjXcGhj91ksteC7iDc/1Brm+1sLVvkJhJAwwaazYTpeN9Pe9R
   SYHhSWOdu4KRPr4FOa8MFQGep8iSJ4OfiWuJ/5bpqV0nJ7jjsVc/yqG8e
   RcjjQZdcPqL/x6vhjGWyAw13t2joidt98nJXzn/3ZOZrTB2Rv6vVK9CUw
   jL2UUfIbqSP8z9/4cCENGVCBsFkmbb9nqfaSBZD57VDHsvOg/0n3BsGjb
   sK5PIdtZatT/TshMjB1ka7vXBqe13W5gmMtF25xtgoqhcpAuBLU0sINSX
   A==;
IronPort-SDR: 1Oa7QskpL8Xbkiha57hfvenGCJe8Il2QHT3MYnqu64TM9yf4X3Xa31NQyScZSRn7mxJX4KgRyN
 mG4ZqB9pZZL2+mPG2W/JKzkYL8lGvVRK/Om1YbcG3Lz3RopQ42AZY+Tu3pFRA3hmVqSDZQbRvU
 +WODhRAhFYwADiINNHG3Vzz4EoBWn8JSiDGdDSvycc0Jd0jemx3PHeBQilz+XpFfwdFsk3K0ce
 BNKR2GF0vfZo7PWYYSZvNW7BbhX6yCITNLdzyl8Jd4KmTpKZIM9Siut/FqvIjyyncea2qmyIXD
 Cs8=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="12474751"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>
CC:     <kernel@axis.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <oliver@schinagl.nl>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 2/2] pwm: Add GPIO PWM driver
Date:   Wed, 2 Sep 2020 14:12:36 +0200
Message-ID: <20200902121236.20514-3-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902121236.20514-1-vincent.whitchurch@axis.com>
References: <20200902121236.20514-1-vincent.whitchurch@axis.com>
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
 drivers/pwm/Kconfig    |  10 +++
 drivers/pwm/Makefile   |   1 +
 drivers/pwm/pwm-gpio.c | 195 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)
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
index 000000000000..0c35c6fdcef5
--- /dev/null
+++ b/drivers/pwm/pwm-gpio.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2020 Axis Communications AB */
+
+#include <linux/gpio/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
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
+	struct pwm_state state;
+	struct pwm_state nextstate;
+	spinlock_t lock;
+	bool changing;
+	bool running;
+	bool level;
+};
+
+static unsigned long pwm_gpio_toggle(struct pwm_gpio *gpwm, bool level)
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
+static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *hrtimer)
+{
+	struct pwm_gpio *gpwm = container_of(hrtimer, struct pwm_gpio, hrtimer);
+	unsigned long nexttoggle;
+	unsigned long flags;
+	bool newlevel;
+
+	spin_lock_irqsave(&gpwm->lock, flags);
+
+	/* Apply new state at end of current period */
+	if (!gpwm->level && gpwm->changing) {
+		gpwm->changing = false;
+		gpwm->state = gpwm->nextstate;
+		newlevel = !!gpwm->state.duty_cycle;
+	} else {
+		newlevel = !gpwm->level;
+	}
+
+	nexttoggle = pwm_gpio_toggle(gpwm, newlevel);
+	if (nexttoggle)
+		hrtimer_forward(hrtimer, hrtimer_get_expires(hrtimer),
+				ns_to_ktime(nexttoggle));
+
+	spin_unlock_irqrestore(&gpwm->lock, flags);
+
+	return nexttoggle ? HRTIMER_RESTART : HRTIMER_NORESTART;
+}
+
+static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	struct pwm_gpio *gpwm = container_of(chip, struct pwm_gpio, chip);
+	unsigned long flags;
+
+	if (!state->enabled)
+		hrtimer_cancel(&gpwm->hrtimer);
+
+	spin_lock_irqsave(&gpwm->lock, flags);
+
+	if (!state->enabled) {
+		gpwm->state = *state;
+		gpwm->running = false;
+		gpwm->changing = false;
+
+		gpiod_set_value(gpwm->gpio, 0);
+	} else if (gpwm->running) {
+		gpwm->nextstate = *state;
+		gpwm->changing = true;
+	} else {
+		unsigned long nexttoggle;
+
+		gpwm->state = *state;
+		gpwm->changing = false;
+
+		nexttoggle = pwm_gpio_toggle(gpwm, !!state->duty_cycle);
+		if (nexttoggle)
+			hrtimer_start(&gpwm->hrtimer, nexttoggle,
+				      HRTIMER_MODE_REL);
+	}
+
+	spin_unlock_irqrestore(&gpwm->lock, flags);
+
+	return 0;
+}
+
+static void pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct pwm_gpio *gpwm = container_of(chip, struct pwm_gpio, chip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpwm->lock, flags);
+
+	if (gpwm->changing)
+		*state = gpwm->nextstate;
+	else
+		*state = gpwm->state;
+
+	spin_unlock_irqrestore(&gpwm->lock, flags);
+}
+
+static const struct pwm_ops pwm_gpio_ops = {
+	.owner = THIS_MODULE,
+	.apply = pwm_gpio_apply,
+	.get_state = pwm_gpio_get_state,
+};
+
+static int pwm_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwm_gpio *gpwm;
+	int ret;
+
+	gpwm = devm_kzalloc(dev, sizeof(*gpwm), GFP_KERNEL);
+	if (!gpwm)
+		return -ENOMEM;
+
+	spin_lock_init(&gpwm->lock);
+
+	gpwm->gpio = devm_gpiod_get(dev, NULL, GPIOD_OUT_LOW);
+	if (IS_ERR(gpwm->gpio))
+		return dev_err_probe(dev, PTR_ERR(gpwm->gpio),
+				     "could not get gpio\n");
+
+	if (gpiod_cansleep(gpwm->gpio))
+		return dev_err_probe(dev, -EINVAL,
+				     "sleeping GPIOs not supported\n");
+
+	gpwm->chip.dev = dev;
+	gpwm->chip.ops = &pwm_gpio_ops;
+	gpwm->chip.base = pdev->id;
+	gpwm->chip.npwm = 1;
+
+	hrtimer_init(&gpwm->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	gpwm->hrtimer.function = pwm_gpio_timer;
+
+	ret = pwmchip_add(&gpwm->chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "could not add pwmchip\n");
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
+	pwm_disable(&gpwm->chip.pwms[0]);
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
2.28.0

