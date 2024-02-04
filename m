Return-Path: <linux-pwm+bounces-1199-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD3584910E
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 23:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD84D1C21F84
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 22:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7B32C89;
	Sun,  4 Feb 2024 22:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="LG3NvFTN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E072C6B3;
	Sun,  4 Feb 2024 22:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707084561; cv=none; b=owkGD+3ugFLjKSnHd9GMX/egFWHr+eqxFwKiRnrZxwKB6IRB621XnF7lBGIlPaSnWt8xuof068sLLgql1hIehMhrZi6M335rvmW5eRAcK6GtFDjHiG2uC+7ANk7QMA6YtjZ5t8Ut6K60p2UqPMttlKEbj2Dm2AnqwwrLe9ETGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707084561; c=relaxed/simple;
	bh=K8qWR1gXMftDOGEmOPMFwFic5jW0k8wyteq5pX3AZzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NrVyEDurxZ/kExt8DqT9hr60Y1ZvxizmXBQz/E9+tVQHY5ch6tG04eF1D5x/9YOK2MQKBa/J3/UjRJgpD5Cw7cDdgelCDTtRyffnXcJCqqoYHnNEbfSGqLe3sfhxIAPY1rObmzW3bWcu9vhQVJEdoUzObwoZkV6n/4gH6qmLVsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=LG3NvFTN; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707084549; x=1707689349; i=wahrenst@gmx.net;
	bh=K8qWR1gXMftDOGEmOPMFwFic5jW0k8wyteq5pX3AZzY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=LG3NvFTNl3EcBnSXTZSPQdWXCnRMcTO02byLkoa0jFAbRJL1hn0YtHZgeC+d/Yka
	 KDk5UbtUfdnrjQuJyzhiVi+BeCYqmEPqjOGkdniNRBSugBEyp9PX3S4gV1i5NuuyN
	 xLE7QxG1Np5WHOm9L3/hQyATt+/stiHl4JiJlvaEcVrUtcAJjmmodRUbCfAUoGBvL
	 GiblqcGryBbTa7eTTydXuvZHqoW7M3wR5jLAkMblxYdkYSZoKZCNvUzXkW9trtEsJ
	 wuEyNFywvJSmuNoNVQDnPz1V1xWD4T5U/AKqO2IBb0WknfN0XBbLbuXpULEfE3O/f
	 Gai1+Yj6JWP4hjn6Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTABZ-1rSAnK24EB-00UeU5; Sun, 04
 Feb 2024 23:09:09 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: andy.shevchenko@gmail.com,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>,
	Sean Young <sean@mess.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V4 2/2] pwm: Add GPIO PWM driver
Date: Sun,  4 Feb 2024 23:08:51 +0100
Message-Id: <20240204220851.4783-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204220851.4783-1-wahrenst@gmx.net>
References: <20240204220851.4783-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VRqSiuwZNbTjTymkpJbG4h2Y8k7/Rd5F3m9+/xgEbX2+yGTcOMl
 E3Xd+DUY8fpEhjfv1AmWchzYTtTNY4mPlnOSnj6Qc5RSf3mlOzQkYyECEUMHrIhm7QWGTdM
 zaiBKjfdHq/UZxrb42IGOuAP6Dnn45OeO+xi50cRzbIE4Tiki9u+nHtCCftQ8cZWb5Mow0S
 +gEp10u14yiRr45HanhlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FZxfHLaJG3w=;eJnF/esNWNJT3R23yDPzkeNKfIo
 qeamUqUPk/VjV/UZnpO8UPiJ4V++tEwxVElrnYoDfDFvaZZidey96hfVgsjrRU12mpzSer6sr
 /JPC8wrMXG4B+6+LcgtG8ip5VPsQHlDAYBT3im8oxM3B1Hp1u1ll7ofDKt6K+zIkpb2Th6k6/
 t1W5fhqEnEqPoP0ky9wenZ46a/WjLBbAY8nzmvBDgHyg32FR9Q0BzQkms6OgpoFofPJKi1ksN
 Z79DI+V7nXKuf6RH/7lUv8Ndl7N8DBlxAoubkEFO4dYwcwzmzmMAtttAF4uEY/uD/fNTcZxGD
 dgkCyrT0Scd4KAOaJ8uj18hWPOPwce7yYsBtAK236f9Cj0ClwpeGNNcoJeBWu6gn8ogv0aN8/
 seKt+rTQsiDOBx3FHp3+KRKfjj5ZJMbtHg+ChiUaooXs7ETf2Z9nyQRKOt0nf1oO56K4rVeKO
 vgLVYMUWHPWXaXwPLpx9/3wWg6aTM5DXBYorHu8KGJsNPoNxd9V5iWjBSOQtvfbCyoTAzTLof
 IEcwhx20GYlrt3xzC9l/1YF6iNtSvXDNVTMTote7sbjxio5kcbHVI5qg+loASuDEXR1dpHfjN
 4GqCPTV5Pvc92qm7voX/JHeQB4Jn/sic0GWhpnT4XGU+PUhHuD7meMMO0DWbpzK0xQUP+Z3UD
 1Vn8V5+e76CAFlbky/Ly4fwjSlziT5S+h2B2+LPJSG7vVeeD5RBUJDGBuUVhpp2B+wu2CaWiF
 gQEe/oW1fQbzfCCxwO9Y4fcz36aKARUMv2hfPFhbiGxME+2jW1hWJgvVA6gNBlPvN9JDTY0aH
 fgECTDRqEj7W/TRy+icYQ0MGrra7lnTrmksYdMCdmCyA4=

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

Add a software PWM which toggles a GPIO from a high-resolution timer.

This will naturally not be as accurate or as efficient as a hardware
PWM, but it is useful in some cases.  I have for example used it for
evaluating LED brightness handling (via leds-pwm) on a board where the
LED was just hooked up to a GPIO, and for a simple verification of the
timer frequency on another platform.

Since high-resolution timers are used, sleeping gpio chips are not
supported and are rejected in the probe function.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/pwm/Kconfig    |  11 ++
 drivers/pwm/Makefile   |   1 +
 drivers/pwm/pwm-gpio.c | 228 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 drivers/pwm/pwm-gpio.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..7cfda2cde130 100644
=2D-- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -227,6 +227,17 @@ config PWM_FSL_FTM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-fsl-ftm.

+config PWM_GPIO
+	tristate "GPIO PWM support"
+	depends on GPIOLIB
+	depends on HIGH_RES_TIMERS
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
index c5ec9e168ee7..59d1a46bb1af 100644
=2D-- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_PWM_DWC_CORE)	+=3D pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+=3D pwm-dwc.o
 obj-$(CONFIG_PWM_EP93XX)	+=3D pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+=3D pwm-fsl-ftm.o
+obj-$(CONFIG_PWM_GPIO)		+=3D pwm-gpio.o
 obj-$(CONFIG_PWM_HIBVT)		+=3D pwm-hibvt.o
 obj-$(CONFIG_PWM_IMG)		+=3D pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+=3D pwm-imx1.o
diff --git a/drivers/pwm/pwm-gpio.c b/drivers/pwm/pwm-gpio.c
new file mode 100644
index 000000000000..4435f275f509
=2D-- /dev/null
+++ b/drivers/pwm/pwm-gpio.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic software PWM for modulating GPIOs
+ *
+ * Copyright (C) 2020 Axis Communications AB
+ * Copyright (C) 2020 Nicola Di Lieto
+ * Copyright (C) 2024 Stefan Wahren
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/hrtimer.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/spinlock.h>
+
+struct pwm_gpio {
+	struct pwm_chip chip;
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
+static unsigned long pwm_gpio_toggle(struct pwm_gpio *gpwm, bool level)
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
+	unsigned long next_toggle;
+	unsigned long flags;
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
+	if (next_toggle) {
+		hrtimer_forward(gpio_timer, hrtimer_get_expires(gpio_timer),
+				ns_to_ktime(next_toggle));
+	}
+
+	spin_unlock_irqrestore(&gpwm->lock, flags);
+
+	return next_toggle ? HRTIMER_RESTART : HRTIMER_NORESTART;
+}
+
+static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	struct pwm_gpio *gpwm =3D container_of(chip, struct pwm_gpio, chip);
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
+		/*
+		 * This just enables the output, but pwm_gpio_toggle()
+		 * really starts the duty cycle.
+		 */
+		int ret =3D gpiod_direction_output(gpwm->gpio, invert);
+
+		if (ret)
+			return ret;
+	}
+
+	spin_lock_irqsave(&gpwm->lock, flags);
+
+	if (!state->enabled) {
+		gpwm->state =3D *state;
+		gpwm->running =3D false;
+		gpwm->changing =3D false;
+
+		gpiod_set_value(gpwm->gpio, invert);
+	} else if (gpwm->running) {
+		gpwm->next_state =3D *state;
+		gpwm->changing =3D true;
+	} else {
+		unsigned long next_toggle;
+
+		gpwm->state =3D *state;
+		gpwm->changing =3D false;
+
+		next_toggle =3D pwm_gpio_toggle(gpwm, !!state->duty_cycle);
+		if (next_toggle) {
+			hrtimer_start(&gpwm->gpio_timer, next_toggle,
+				      HRTIMER_MODE_REL);
+		}
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
+	struct pwm_gpio *gpwm =3D container_of(chip, struct pwm_gpio, chip);
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
+	struct device *dev =3D &pdev->dev;
+	struct pwm_gpio *gpwm;
+	int ret;
+
+	gpwm =3D devm_kzalloc(dev, sizeof(*gpwm), GFP_KERNEL);
+	if (!gpwm)
+		return -ENOMEM;
+
+	spin_lock_init(&gpwm->lock);
+
+	gpwm->gpio =3D devm_gpiod_get(dev, NULL, GPIOD_ASIS);
+	if (IS_ERR(gpwm->gpio)) {
+		return dev_err_probe(dev, PTR_ERR(gpwm->gpio),
+				     "could not get gpio\n");
+	}
+
+	if (gpiod_cansleep(gpwm->gpio)) {
+		return dev_err_probe(dev, -EINVAL,
+				     "sleeping GPIO %d not supported\n",
+				     desc_to_gpio(gpwm->gpio));
+	}
+
+	gpwm->chip.dev =3D dev;
+	gpwm->chip.ops =3D &pwm_gpio_ops;
+	gpwm->chip.npwm =3D 1;
+	gpwm->chip.atomic =3D true;
+
+	hrtimer_init(&gpwm->gpio_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	gpwm->gpio_timer.function =3D pwm_gpio_timer;
+
+	ret =3D pwmchip_add(&gpwm->chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "could not add pwmchip\n");
+
+	platform_set_drvdata(pdev, gpwm);
+
+	return 0;
+}
+
+static void pwm_gpio_remove(struct platform_device *pdev)
+{
+	struct pwm_gpio *gpwm =3D platform_get_drvdata(pdev);
+
+	pwmchip_remove(&gpwm->chip);
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


