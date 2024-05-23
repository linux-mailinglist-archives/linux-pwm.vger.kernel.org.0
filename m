Return-Path: <linux-pwm+bounces-2231-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A338CD871
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 18:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020EB1F229E7
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 16:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263F12B7F;
	Thu, 23 May 2024 16:31:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08AB20335
	for <linux-pwm@vger.kernel.org>; Thu, 23 May 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481908; cv=none; b=eZXZv4tePLxsqa64k3RzGCona//VgQXjj2O/QecHko95hMwY8V3fta0zVNY20/57Fu0ZvihrkFiNkYCSqzb1i+W0D+8VFfASzj6SkO5HbAXXWI7pWCbNzUrFAReZ2XyTIFI41lYUFeYh6halslWXI7tlLOyuXcNwR+zrGOG6MBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481908; c=relaxed/simple;
	bh=3VbRWmYIFG9dsSmrAmoUhbkC2RILkNWYuZv05L4/OKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEHa4VS5cJAie0INNuY9s4kT4yE7x6rJY/H3QNvL6oAlU4o7waylcCCDNF1v6vChohy9cjyj9HzY9lDXFY6aMxAlrXjisrDATyFYHFxl7GaeVmPVSZ/JDywH+K3be9DwbxplutekJ4Jw59aW7h+6ji3dAWEhSXyAETRcXqmojtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1sABLc-0000Tz-H3; Thu, 23 May 2024 18:31:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1sABLX-002gTL-2H; Thu, 23 May 2024 18:31:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1sABLW-00Aqfp-3A;
	Thu, 23 May 2024 18:31:14 +0200
Date: Thu, 23 May 2024 18:31:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Juxin Gao <gaojuxin@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	loongson-kernel@lists.loongnix.cn, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v3 2/2] pwm: Add Loongson PWM controller support
Message-ID: <t3efvxh4d2xvjh4pfrdnho6mwonwm6spjer72ww3wiqx2v3a2x@52ufzsdhc44i>
References: <cover.1713164810.git.zhoubinbin@loongson.cn>
 <c89917023b49fff70bc89ddb66be7da4e0fe67ef.1713164810.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7c3t7av3wh3yxy4m"
Content-Disposition: inline
In-Reply-To: <c89917023b49fff70bc89ddb66be7da4e0fe67ef.1713164810.git.zhoubinbin@loongson.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--7c3t7av3wh3yxy4m
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

sorry for taking so long to get back to your patch. reviewing new
drivers is quite time consuming which makes me often fail to review in a
timely manner.

On Tue, Apr 16, 2024 at 09:55:15AM +0800, Binbin Zhou wrote:
> This commit adds a generic PWM framework driver for the PWM controller
> found on Loongson family chips.
>=20
> Co-developed-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                |   1 +
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-loongson.c | 298 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 310 insertions(+)
>  create mode 100644 drivers/pwm/pwm-loongson.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecef2744726d..d32da7c77f0e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12756,6 +12756,7 @@ M:	Binbin Zhou <zhoubinbin@loongson.cn>
>  L:	linux-pwm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
> +F:	drivers/pwm/pwm-loongson.c
> =20
>  LOONGSON-2 SOC SERIES CLOCK DRIVER
>  M:	Yinbo Zhu <zhuyinbo@loongson.cn>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4b956d661755..bb163c65e5ae 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -324,6 +324,16 @@ config PWM_KEEMBAY
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-keembay.
> =20
> +config PWM_LOONGSON
> +	tristate "Loongson PWM support"
> +	depends on MACH_LOONGSON64

Something with || COMPILE_TEST would be nice.

> +	help
> +	  Generic PWM framework driver for Loongson family.
> +	  It can be found on Loongson-2K series cpu and Loongson LS7A bridge ch=
ips.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-loongson.
> +
>  config PWM_LP3943
>  	tristate "TI/National Semiconductor LP3943 PWM support"
>  	depends on MFD_LP3943
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index c5ec9e168ee7..bffa49500277 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PWM_INTEL_LGM)	+=3D pwm-intel-lgm.o
>  obj-$(CONFIG_PWM_IQS620A)	+=3D pwm-iqs620a.o
>  obj-$(CONFIG_PWM_JZ4740)	+=3D pwm-jz4740.o
>  obj-$(CONFIG_PWM_KEEMBAY)	+=3D pwm-keembay.o
> +obj-$(CONFIG_PWM_LOONGSON)	+=3D pwm-loongson.o
>  obj-$(CONFIG_PWM_LP3943)	+=3D pwm-lp3943.o
>  obj-$(CONFIG_PWM_LPC18XX_SCT)	+=3D pwm-lpc18xx-sct.o
>  obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
> diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
> new file mode 100644
> index 000000000000..5ac79a69acd3
> --- /dev/null
> +++ b/drivers/pwm/pwm-loongson.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Loongson PWM driver
> + *
> + * Author: Juxin Gao <gaojuxin@loongson.cn>
> + * Further cleanup and restructuring by:
> + *         Binbin Zhou <zhoubinbin@loongson.cn>
> + *
> + * Copyright (C) 2017-2024 Loongson Technology Corporation Limited.

A paragraph about the hardware capabilities here please. Please answer
the following questions:

 - How does the hardware behave on disable? (Does it complete the
   currently running period? Is the output still driven then? If yes,
   which level?)

 - How does the hardware behave on configuration changes? (Does it
   complete the currently running period? Are there some glitches
   expected (like driving an output corresponding to the old period
   length but the new duty_cycle or similar).

 - Are there any restrictions like: Cannot do 100% relative duty (or
   0%)?

Stick to the format used in most other drivers such that

	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/pwm-loongson.c

emits the requested info.

> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/units.h>
> +
> +/* Loongson PWM registers */
> +#define PWM_DUTY	0x4 /* Low Pulse Buffer Register */
> +#define PWM_PERIOD	0x8 /* Pulse Period Buffer Register */
> +#define PWM_CTRL	0xc /* Control Register */

Please use a driver specific prefix for these defines. PWM_DUTY is quite
generic otherwise.

> +
> +/* Control register bits */
> +#define PWM_CTRL_EN	BIT(0)  /* Counter Enable Bit */
> +#define PWM_CTRL_OE	BIT(3)  /* Pulse Output Enable Control Bit, Valid Lo=
w */
> +#define PWM_CTRL_SINGLE	BIT(4)  /* Single Pulse Control Bit */
> +#define PWM_CTRL_INTE	BIT(5)  /* Interrupt Enable Bit */
> +#define PWM_CTRL_INT	BIT(6)  /* Interrupt Bit */
> +#define PWM_CTRL_RST	BIT(7)  /* Counter Reset Bit */
> +#define PWM_CTRL_CAPTE	BIT(8)  /* Measurement Pulse Enable Bit */
> +#define PWM_CTRL_INVERT	BIT(9)  /* Output flip-flop Enable Bit */
> +#define PWM_CTRL_DZONE	BIT(10) /* Anti-dead Zone Enable Bit */
> +
> +#define PWM_FREQ_STD       (50 * HZ_PER_KHZ)
> +
> +struct pwm_loongson_ddata {
> +	struct pwm_chip	chip;
> +	struct clk	*clk;
> +	void __iomem	*base;
> +	/* The following for PM */
> +	u32		ctrl;
> +	u32		duty;
> +	u32		period;

This needs updating to cope for commit 05947224ff46 ("pwm: Ensure that
pwm_chips are allocated using pwmchip_alloc()")

Also I'm not a fan of aligning the member names. If you feel strong
about it, keep it as is, however.

> +};
> +
> +static inline struct pwm_loongson_ddata *to_pwm_loongson_ddata(struct pw=
m_chip *chip)
> +{
> +	return container_of(chip, struct pwm_loongson_ddata, chip);
> +}
> +
> +static inline u32 pwm_loongson_readl(struct pwm_loongson_ddata *ddata, u=
64 offset)

I don't know about the calling convention on loongson, but I'd expect
offset to be an unsigned int only, given that (I guess) only PWM_CTRL
and friends are passed here.

> +{
> +	return readl(ddata->base + offset);
> +}
> +
> +static inline void pwm_loongson_writel(struct pwm_loongson_ddata *ddata,
> +				       u32 val, u64 offset)
> +{
> +	writel(val, ddata->base + offset);
> +}
> +
> +static int pwm_loongson_set_polarity(struct pwm_chip *chip, struct pwm_d=
evice *pwm,
> +				     enum pwm_polarity polarity)
> +{
> +	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> +	u16 val;
> +
> +	val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> +
> +	if (polarity =3D=3D PWM_POLARITY_INVERSED)
> +		/* Duty cycle defines LOW period of PWM */
> +		val |=3D PWM_CTRL_INVERT;
> +	else
> +		/* Duty cycle defines HIGH period of PWM */
> +		val &=3D ~PWM_CTRL_INVERT;
> +
> +	pwm_loongson_writel(ddata, val, PWM_CTRL);
> +
> +	return 0;
> +}
> +
> +static void pwm_loongson_disable(struct pwm_chip *chip, struct pwm_devic=
e *pwm)
> +{
> +	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> +	u32 val;
> +
> +	if (pwm->state.polarity =3D=3D PWM_POLARITY_NORMAL)
> +		pwm_loongson_writel(ddata, ddata->period, PWM_DUTY);
> +	else if (pwm->state.polarity =3D=3D PWM_POLARITY_INVERSED)
> +		pwm_loongson_writel(ddata, 0, PWM_DUTY);
> +
> +	val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> +	val &=3D ~PWM_CTRL_EN;
> +	pwm_loongson_writel(ddata, val, PWM_CTRL);

Technically it's not needed to configure the duty. A consumer who
expects a certain behaviour is supposed to not disable the PWM.

> +}
> +
> +static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> +	u32 val;
> +
> +	pwm_loongson_writel(ddata, ddata->duty, PWM_DUTY);
> +	pwm_loongson_writel(ddata, ddata->period, PWM_PERIOD);

pwm_loongson_enable() is called from pwm_loongson_apply() and PWM_DUTY and
PWM_PERIOD were already written there. So please either only write it
once, or add a code comment about why writing twice is needed.

> +	val =3D pwm_loongson_readl(ddata, PWM_CTRL);
> +	val |=3D PWM_CTRL_EN;
> +	pwm_loongson_writel(ddata, val, PWM_CTRL);
> +
> +	return 0;
> +}
> +
> +static u32 pwm_loongson_set_config(struct pwm_loongson_ddata *ddata, int=
 ns,
> +				   u64 clk_rate, u64 offset)
> +{
> +	u32 val;
> +	u64 c;
> +
> +	c =3D clk_rate * ns;

That migth overflow?!

> +	do_div(c, NSEC_PER_SEC);
> +	val =3D c < 1 ? 1 : c;

That smells fishy. If a period (or duty_cycle) is requested that is too
small to be implemented, let .apply() return -EINVAL.

> +	pwm_loongson_writel(ddata, val, offset);
> +
> +	return val;
> +}
> +
> +static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       int duty_ns, int period_ns)
> +{
> +	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> +	struct device *dev =3D chip->dev;
> +	u64 clk_rate;
> +
> +	if (duty_ns > NANOHZ_PER_HZ || period_ns > NANOHZ_PER_HZ)
> +		return -ERANGE;

Nope, that's wrong. Please configure the biggest possible period not
bigger than the requested period. So something like:

	period_ns =3D min(period_ns, NANOHZ_PER_HZ);

; ditto for duty_cycle.

> +	clk_rate =3D has_acpi_companion(dev) ? PWM_FREQ_STD : clk_get_rate(ddat=
a->clk);
> +
> +	ddata->duty =3D pwm_loongson_set_config(ddata, duty_ns, clk_rate, PWM_D=
UTY);
> +	ddata->period =3D pwm_loongson_set_config(ddata, period_ns, clk_rate, P=
WM_PERIOD);
> +
> +	return 0;
> +}
> +
> +static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device *=
pwm,
> +			      const struct pwm_state *state)
> +{
> +	int err;
> +	bool enabled =3D pwm->state.enabled;
> +
> +	if (state->polarity !=3D pwm->state.polarity) {
> +		if (enabled) {
> +			pwm_loongson_disable(chip, pwm);
> +			enabled =3D false;
> +		}
> +
> +		err =3D pwm_loongson_set_polarity(chip, pwm, state->polarity);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			pwm_loongson_disable(chip, pwm);
> +		return 0;
> +	}
> +
> +	err =3D pwm_loongson_config(chip, pwm, state->duty_cycle, state->period=
);

state->duty_cycle is an u64, however it's truncated to an int here.

> +	if (err)
> +		return err;
> +
> +	if (!enabled)
> +		err =3D pwm_loongson_enable(chip, pwm);
> +
> +	return err;
> +}
> +
> +static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_devi=
ce *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct pwm_loongson_ddata *ddata =3D to_pwm_loongson_ddata(chip);
> +	u32 period, duty, ctrl;
> +	u64 ns;
> +
> +	ctrl =3D pwm_loongson_readl(ddata, PWM_CTRL);
> +	state->polarity =3D (ctrl & PWM_CTRL_INVERT) ? PWM_POLARITY_INVERSED : =
PWM_POLARITY_NORMAL;
> +	state->enabled =3D (ctrl & PWM_CTRL_EN) ? true : false;
> +
> +	duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> +	ns =3D duty * NSEC_PER_SEC;
> +	state->duty_cycle =3D do_div(ns, duty);
> +
> +	period =3D pwm_loongson_readl(ddata, PWM_PERIOD);
> +	ns =3D period * NSEC_PER_SEC;
> +	state->period =3D do_div(ns, period);
> +
> +	ddata->ctrl =3D ctrl;
> +	ddata->duty =3D pwm_loongson_readl(ddata, PWM_DUTY);
> +	ddata->period =3D pwm_loongson_readl(ddata, PWM_PERIOD);

The rounding looks wrong. Did you test with PWM_DEBUG enabled?

I think the value assigned to ddata->period and the other members isn't
used. Unless I'm mistaken, please drop the assignment.

> +	return 0;
> +}
> +
> +static const struct pwm_ops pwm_loongson_ops =3D {
> +	.apply =3D pwm_loongson_apply,
> +	.get_state =3D pwm_loongson_get_state,
> +};
> +
> +static int pwm_loongson_probe(struct platform_device *pdev)
> +{
> +	struct pwm_loongson_ddata *ddata;
> +	struct device *dev =3D &pdev->dev;
> +
> +	ddata =3D devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(ddata->base))
> +		return PTR_ERR(ddata->base);
> +
> +	if (!has_acpi_companion(dev)) {
> +		ddata->clk =3D devm_clk_get_enabled(dev, NULL);
> +		if (IS_ERR(ddata->clk))
> +			return PTR_ERR(ddata->clk);

error message with dev_err_probe() please.

> +	}
> +
> +	ddata->chip.dev =3D dev;
> +	ddata->chip.ops =3D &pwm_loongson_ops;
> +	ddata->chip.npwm =3D 1;
> +	platform_set_drvdata(pdev, ddata);

The effect of platform_set_drvdata is used in .suspend below, however
there you use dev_get_drvdata on &pdev->dev. For symmetry I suggest to
use dev_set_drvdata(dev, ddata) here.

> +	return devm_pwmchip_add(dev, &ddata->chip);

error message iwth dev_err_probe() please (if it fails).

> +}
> +
> [...]
> +static struct platform_driver pwm_loongson_driver =3D {
> +	.probe  =3D pwm_loongson_probe,
> +	.driver =3D {
> +		.name   =3D "loongson-pwm",
> +		.pm	=3D pm_ptr(&pwm_loongson_pm_ops),
> +		.of_match_table   =3D pwm_loongson_of_ids,
> +		.acpi_match_table =3D pwm_loongson_acpi_ids,

This alignment looks really ugly. Please use a single space before the
=3D. (Or if you must, properly align the =3D.)

> +	},
> +};
> +module_platform_driver(pwm_loongson_driver);
> +
> +MODULE_DESCRIPTION("Loongson PWM driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited.");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7c3t7av3wh3yxy4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZPb1EACgkQj4D7WH0S
/k7HxAgAu4SkCeoPLMhJTdbgvmSQm+Ju8Hjm6gxtPviGX7wkDPprNKGOHgiS8Xp7
G3ofUkekEp79nZXb37BrUbd1mu0kkh1WL8PguByZ3KpedU2SGFY0k2fhstpMSjPe
Vd96GyjvCmlWL5G3a2diZyu1KrGNJQZKcEDad4aSqPftzzC8oNWcfn3li4SFE9ze
QqETg54U+5fziazI2Z7/73vwnya0hn6kIvQWwWuAUXdQLqNFbypOIbR+NOHnEz8V
LyZHe5KlnTHitay5rttTfdjK24SjVp4MBuKrq/ZhZ9uQ+mwz4BNn12aG/AMlPHVJ
qjIpewCPxpVHIkD/LDRuu/f+fBKuIQ==
=UFZo
-----END PGP SIGNATURE-----

--7c3t7av3wh3yxy4m--

