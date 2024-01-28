Return-Path: <linux-pwm+bounces-1108-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C848583F83F
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jan 2024 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD90280F29
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jan 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E562C1B1;
	Sun, 28 Jan 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="m4pasbyR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78601D680;
	Sun, 28 Jan 2024 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706459838; cv=none; b=lU2RmBjD+591iC6HLHTgKSTSnlJeRISIEdbdlyphpvhnXaipVltQm8IVndxTQtbgkE0Zy3LEh+57JVJDxfcvpG/CoXz7FH5XVJBinlMicC5u+cMA5dBIWduzNdSHm9c93ft7lbFEc+zk7zElbHtnX3M3Ed8LL2Pcrq1pm6PzvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706459838; c=relaxed/simple;
	bh=BohQprQB51l6ihIoZBbVLeW8R+5yliHCGpJvOHOSM6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SVnXL2z8XOKy5sKi0s8a6Fyte8PVsMHlZHLEplu3ZURkiow0BuglSpyw9JM8UdRHybwSSxbdR8YsJ1S6Umw5rilO3SrBo2Hd51YBn/IDmgMJ4f07v0oir1PqPR8QnRUhO2EFuZujYGT+49Kz+SrwcvCFgkwrTNiv0d9LjIyWM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=m4pasbyR; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706459825; x=1707064625; i=wahrenst@gmx.net;
	bh=BohQprQB51l6ihIoZBbVLeW8R+5yliHCGpJvOHOSM6k=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=m4pasbyR/2W3clxx296gHVWVt01vUeDAxAhpqQVDDZSoZaBdiaNN9gMERS3Uur95
	 2KbuS33zKi3gCCoh/0Ws+voOEHL0wLRqaTOw88Lh656WS1lo2XuJ0riojMSg0X6EC
	 frOSi56qYnxv5CzMoSE6IhEuMNVuqckxBKMy96PspE7Hs4u6TWUm3sMOKZThgYn5f
	 cS7W64COiRqoQljTfCIn54BShiIw9GFb0ci7pnmS+ywkX3vnLk+YU8JdPZSa4G5+f
	 HTUQY/521AEyyG4qseX6Da5W5KKbCR9RmeLdD9HKrEKuFR6Si5x+tRYFFf5NoW+Pp
	 l/4NtTHz61I4fN+o6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1r9jid1hc2-00y8Ec; Sun, 28
 Jan 2024 17:37:05 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: andy.shevchenko@gmail.com,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Philip Howard <phil@gadgetoid.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 2/2] pwm: Add GPIO PWM driver
Date: Sun, 28 Jan 2024 17:36:30 +0100
Message-Id: <20240128163630.104725-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128163630.104725-1-wahrenst@gmx.net>
References: <20240128163630.104725-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:av63O9S6j9RKoXEd833Mi5loi5nqy8JlimNJ9AhkgrvuLQRSkoI
 Y1114Mqf8EKgqNHaXR+TwX2BbGryDzfSMwkocthA8OObGPgnpm4fsnvf46xh+0ZNGNj1HTh
 wZ8jl+jnTk/7AygHC723M+kvXc+OdvHbEyO7mw9dHAqz2pVJEBO1j3+TVLBUiRzhOWXZ8D2
 9y74Op2+0j2WKohtCrJHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o5TMCyM4FqU=;Lc0quUfCJYgvmPlIkaVfTm4/tOw
 njmoDGPAommTX4WQU0NWuMoiVbD7Q8PWRDxQq/04RaD+8bZbuGHzc4UfN9XOgryJcqbPCuG2h
 gnmq73WeXj1LLu8FxIXym7nL+CHxEIDKQjFvTkX97WNMsLRb1LJ6VU4xO92rXbCcFcDxIkcwy
 AGCHVZUeUZLZwIeyHG7EDRdiJTXvqBBODlMeWHcewUM73Zd/jjehrKhKhcUBjjjSvJ5YCoMiq
 TcUwwc1qziaalc5r7s/wO10JhOfYdLyDJpkocFt1n7yKEIkMTBa95mlsPX6CD7z4eILEbwuHs
 XAiZVMDACzG5KFbNhTnfpIPidCnjTWL5TIHS584+T0Ex0Q5JOncJvzIAuzmgEeLRrLJ5glMTg
 ZVDN8XloCBRWb5tYpSz2ISjo0WagC2i+ttuQ+cPMLYEyWmXL8AjUIJdST/PMNZdv3/b7spsyG
 0NdZgPdZAaezKOW6m2YB9RdPj/op4FUaj1YqDT0RhK0LUm7CSw9AvSrljXvspGWi3hpeb8Fct
 B1DMylwb8lrRxTAZzXlGl7R0MWNXmREadVyLfWh4zcwKoV0HFiYEV1MDhP3tcijBvj2D+3Byf
 peXeLjXkkX9jGpFmv5qEY5BQ1B4NaUL/8CpY6WxCSTS9hMML063KWdPRHK88V9dJQauFN34h1
 hGxhUcoe2WyqM3xuUjDab6qpxpSDJBCPpgPRSc1xWnHF+JbJI3TF+slWItEPn9UQkmpOOU2TL
 25by6fhy7/UEWT2QeNCdnS1wuVmNbhn/EBeXhbdC5mMKt/qgEcVQJ2jclXYGsMyWPikPRIWhx
 a1giooS5LB/bzd+QXOubg6Xb96wkScGSFh5rItNuOFDPe3E/R2Gylrx0jE/g7rIkTChriariJ
 L+E+sALch4UN3tWwrACGoSB48wQKO9z2l/cGSD8MUqyUASPbN1II0DtIkxO80xVlixSliNpO+
 fGVqLD4YPpOWk2VGg57be9e+Jdg=

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
 drivers/pwm/pwm-gpio.c | 221 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+)
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
index 000000000000..14637abe465b
=2D-- /dev/null
+++ b/drivers/pwm/pwm-gpio.c
@@ -0,0 +1,221 @@
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
+MODULE_ALIAS("platform:pwm-gpio");
+MODULE_AUTHOR("Vincent Whitchurch");
+MODULE_LICENSE("GPL");
=2D-
2.34.1


