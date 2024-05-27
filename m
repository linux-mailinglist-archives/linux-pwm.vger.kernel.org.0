Return-Path: <linux-pwm+bounces-2247-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579DD8CFEF8
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 13:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 084DF2836E8
	for <lists+linux-pwm@lfdr.de>; Mon, 27 May 2024 11:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDFA152DFA;
	Mon, 27 May 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ZVO4Toee"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B61527B5;
	Mon, 27 May 2024 11:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809399; cv=none; b=nPoG73VDBz/isKI+PPQbQBxavjtJUSy1xznICHM78OYNbH+rPJqCEDrvqcMibkXvkwn2d2Szxi1DqKNwJ9F7ZdxmWiMULWswKY636blTUbQGvfm1oLkcN4IgQFuW1nLjDBnj4+uBL5x9SRkO4mIIzEhWwZ3FlReBXR/9PcgBrSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809399; c=relaxed/simple;
	bh=3kdr0iah+C78UxOGPk+2OoqSNTLDL67XrCiTOtcWo1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIAvRkAjPiMBrkSE22MBnh39V6xtQda4RzaIoSGDN8MKozBoY792wxQhQfvLR1jXrTfHW4RoOYPDDLBoWy9pV3US+54tsHS1urbQ7YqBbGJ3+p8QICV4CsA7+W53i5poRY3g6uRB9Q+4gabsCz7hiWwhbWhT3eVlYiZQKsOE3Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ZVO4Toee; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1716809384; x=1717414184; i=wahrenst@gmx.net;
	bh=Tn56RjTQiM2j0lEu9uV33aqBk4FYBicy0U5Sylx/ETo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZVO4ToeeSR+Rw/AxVbD4d9lkQMfX//onmK94zxLW5NDGXVfQ4m7vQ/idG7I6BqkP
	 I3j/Vx+lBiDfx8qZqHm5lHTGNg3CBKYtGZYfiuKPTHBY7hZ7r4i8GW2BvSOSLKKqv
	 3jRDhlfYXaIMRepEcABBDN5s+4Hst403WTyz1jlWNs6wWjl8T7CKzleS6fIu+2Zsb
	 I/TpiFhjlaHP7mPlW0mTAKue8H7ctOSkCq3bRZ3E/4+WutrdRX9h6e390nQg5x/6Z
	 oMY61M1WZxnu+6WyqAgSDMHhaOi7tgTGHdoa8AbEZaaiKiozJonn+q9MbP7P/g+9+
	 OXM4eqgPCkYzUGVPFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJm5-1sq65j0EQl-00nPOf; Mon, 27
 May 2024 13:29:44 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: andy.shevchenko@gmail.com,
	Philip Howard <phil@gadgetoid.com>,
	Sean Young <sean@mess.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V5 2/2] pwm: Add GPIO PWM driver
Date: Mon, 27 May 2024 13:28:57 +0200
Message-Id: <20240527112857.90554-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527112857.90554-1-wahrenst@gmx.net>
References: <20240527112857.90554-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4/p8QzA9t1HKeZyURo9IVN7itrMRyCfYmHWBCHukbE32dUIO0hF
 ZCdhYoKJMc7A62ChIguqzJws+cq8HGFf7UveuRWS18GaiLQBDA4qEFPNk04nZG8YbS2uTR1
 S8Z1W1fk/wuwnZkpFYs7HFq7qLWpS686DMQxJ0i8fy06irLE0J1SmGYBrEPqDAFzr+UCbw6
 hUAOXS/h77wJY0ML7h6jg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5uxdiqc6DDI=;RvpaddA4NDslZfFVb+P5QtjAji3
 1G55ptuJYlr4SCkPvntD72NgtFhOjsj6UpeOYLiUmnWlbWdxW6zkLsazIFwJhkZTvKshhLjkU
 W+RIdDD/TzFybmwkCJxNmtaHzs/0X8Ns1qJK6by9Xyd8BGGLSgFcfxJWnDbu81EYUsnizs2Fu
 8r3cZ0f4bbuv60/rA+TDWv7Ltfn9+1us74nNT+74sFuRvsDMd7ojKdOAVuvXRr0Qv38qHNnvs
 70hhtJvAaamxCfYA8NFfq2N3uBYxKLhdHhW1mZCfNKpnQv8qOLonhmEPRQpkaMkhl/7yEFL+E
 qdp7e8D/rKvh5dD04tt6qM6cpiXe2WfrnqTvkulc/vcUACzhlqWXLXoL1CQePpm06bJjExVrV
 +f3f4tITsB4mZrE0ho6x9csu2ZENaay/BfmMJnwcWOzYwFVFRMBEejGWHf7/Y4QU9NQKpQVtB
 sT0bMXxfmlMosgSjRqJgRZ/Q/ecC9lzq5vgxDjI9It+EZHasHYZG7XFPWvL/RRTet9HvyZWX6
 79w+0nQojDOItNvG0V4ZfmJta49Pu2tinjoOk2rieWTVtSMmxLhsXanVi4tzwKioGXq8tJiex
 GsB02i3bK0z/fHYDtyJ/C4818jzTnGSvGJ9th9VkUfMZPxElUlRwW2UPTONi4z8gi3naeuvE0
 EZhHfUaiv+Zr1lCiLAnJ1qUbbZrN4DeSA+axK3RTYGrq3lP+0+YETmGOl7bzXvcfEj1OiYNIW
 bEruC6A+oV0wYahr93+sMca3w1xcpGAgRaQZiowFByLlue6QwDZINk8Ym4Xxu8F/GjzfzkAyw
 u3QwiVu7U3tMcrkefF2YUsD+eIz/gQLNh/0MBatn3kxe0=

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
=2D--
 drivers/pwm/Kconfig    |  11 ++
 drivers/pwm/Makefile   |   1 +
 drivers/pwm/pwm-gpio.c | 249 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/pwm/pwm-gpio.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 1dd7921194f5..68ba28d52c4c 100644
=2D-- a/drivers/pwm/Kconfig
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
=2D-- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_PWM_DWC_CORE)	+=3D pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+=3D pwm-dwc.o
 obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
+obj-$(CONFIG_PWM_GPIO)		+=3D pwm-gpio.o
 obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
new file mode 100644
index 000000000000..a3bafa723ff4
=2D-- /dev/null
+++ b/drivers/pwm/pwm-gpio.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic software PWM for modulating GPIOs
+ *
+ * Copyright (C) 2020 Axis Communications AB
+ * Copyright (C) 2020 Nicola Di Lieto
+ * Copyright (C) 2024 Stefan Wahren
+ */
+
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/hrtimer.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
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
+static void pwm_gpio_round(struct pwm_state *dest, const struct pwm_state=
 *src)
+{
+	u64 dividend;
+	u32 remainder;
+
+	*dest =3D *src;
+
+	/* Round down to hrtimer resolution */
+	dividend =3D dest->period;
+	remainder =3D do_div(dividend, hrtimer_resolution);
+	dest->period -=3D remainder;
+
+	dividend =3D dest->duty_cycle;
+	remainder =3D do_div(dividend, hrtimer_resolution);
+	dest->duty_cycle -=3D remainder;
+}
+
+static u64 pwm_gpio_toggle(struct pwm_gpio *gpwm, bool level)
+{
+	const struct pwm_state *state =3D &gpwm->state;
+	bool invert =3D state->polarity =3D=3D PWM_POLARITY_INVERSED;
+
+	gpwm->level =3D level;
+	gpiod_set_value(gpwm->gpio, gpwm->level ^ invert);
+
+	if (!state->duty_cycle || state->duty_cycle =3D=3D state->period) {
+		gpwm->running =3D false;
+		return 0;
+	}
+
+	gpwm->running =3D true;
+	return level ? state->duty_cycle : state->period - state->duty_cycle;
+}
+
+static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *gpio_timer)
+{
+	struct pwm_gpio *gpwm =3D container_of(gpio_timer, struct pwm_gpio,
+					     gpio_timer);
+	unsigned long flags;
+	u64 next_toggle;
+	bool new_level;
+
+	spin_lock_irqsave(&gpwm->lock, flags);
+
+	/* Apply new state at end of current period */
+	if (!gpwm->level && gpwm->changing) {
+		gpwm->changing =3D false;
+		gpwm->state =3D gpwm->next_state;
+		new_level =3D !!gpwm->state.duty_cycle;
+	} else {
+		new_level =3D !gpwm->level;
+	}
+
+	next_toggle =3D pwm_gpio_toggle(gpwm, new_level);
+
+	if (next_toggle)
+		hrtimer_forward(gpio_timer, hrtimer_get_expires(gpio_timer),
+				ns_to_ktime(next_toggle));
+
+	spin_unlock_irqrestore(&gpwm->lock, flags);
+
+	return next_toggle ? HRTIMER_RESTART : HRTIMER_NORESTART;
+}
+
+static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	struct pwm_gpio *gpwm =3D pwmchip_get_drvdata(chip);
+	bool invert =3D state->polarity =3D=3D PWM_POLARITY_INVERSED;
+	unsigned long flags;
+
+	if (state->duty_cycle && state->duty_cycle < hrtimer_resolution)
+		return -EINVAL;
+
+	if (state->duty_cycle !=3D state->period &&
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
+		ret =3D gpiod_direction_output(gpwm->gpio, invert);
+		if (ret)
+			return ret;
+	}
+
+	spin_lock_irqsave(&gpwm->lock, flags);
+
+	if (!state->enabled) {
+		pwm_gpio_round(&gpwm->state, state);
+		gpwm->running =3D false;
+		gpwm->changing =3D false;
+
+		gpiod_set_value(gpwm->gpio, invert);
+	} else if (gpwm->running) {
+		pwm_gpio_round(&gpwm->next_state, state);
+		gpwm->changing =3D true;
+	} else {
+		unsigned long next_toggle;
+
+		pwm_gpio_round(&gpwm->state, state);
+		gpwm->changing =3D false;
+
+		next_toggle =3D pwm_gpio_toggle(gpwm, !!state->duty_cycle);
+		if (next_toggle)
+			hrtimer_start(&gpwm->gpio_timer, next_toggle,
+				      HRTIMER_MODE_REL);
+	}
+
+	spin_unlock_irqrestore(&gpwm->lock, flags);
+
+	return 0;
+}
+
+static int pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device *p=
wm,
+			       struct pwm_state *state)
+{
+	struct pwm_gpio *gpwm =3D pwmchip_get_drvdata(chip);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpwm->lock, flags);
+
+	if (gpwm->changing)
+		*state =3D gpwm->next_state;
+	else
+		*state =3D gpwm->state;
+
+	spin_unlock_irqrestore(&gpwm->lock, flags);
+
+	return 0;
+}
+
+static const struct pwm_ops pwm_gpio_ops =3D {
+	.apply =3D pwm_gpio_apply,
+	.get_state =3D pwm_gpio_get_state,
+};
+
+static int pwm_gpio_probe(struct platform_device *pdev)
+{
+	struct pwm_chip *chip;
+	struct device *dev =3D &pdev->dev;
+	struct pwm_gpio *gpwm;
+	int ret;
+
+	chip =3D devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*gpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	gpwm =3D pwmchip_get_drvdata(chip);
+
+	spin_lock_init(&gpwm->lock);
+
+	gpwm->gpio =3D devm_gpiod_get(dev, NULL, GPIOD_ASIS);
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
+	chip->ops =3D &pwm_gpio_ops;
+	chip->atomic =3D true;
+
+	hrtimer_init(&gpwm->gpio_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	gpwm->gpio_timer.function =3D pwm_gpio_timer;
+
+	ret =3D pwmchip_add(chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "could not add pwmchip\n");
+
+	platform_set_drvdata(pdev, gpwm);
+
+	dev_info(dev, "pwm-gpio probed, hr timer resolution: %u ns\n", hrtimer_r=
esolution);
+
+	return 0;
+}
+
+static void pwm_gpio_remove(struct platform_device *pdev)
+{
+	struct pwm_gpio *gpwm =3D platform_get_drvdata(pdev);
+
+	hrtimer_cancel(&gpwm->gpio_timer);
+}
+
+static const struct of_device_id pwm_gpio_dt_ids[] =3D {
+	{ .compatible =3D "pwm-gpio" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, pwm_gpio_dt_ids);
+
+static struct platform_driver pwm_gpio_driver =3D {
+	.driver =3D {
+		.name =3D "pwm-gpio",
+		.of_match_table =3D pwm_gpio_dt_ids,
+	},
+	.probe =3D pwm_gpio_probe,
+	.remove_new =3D pwm_gpio_remove,
+};
+module_platform_driver(pwm_gpio_driver);
+
+MODULE_DESCRIPTION("PWM GPIO driver");
+MODULE_AUTHOR("Vincent Whitchurch");
+MODULE_LICENSE("GPL");
=2D-
2.34.1


