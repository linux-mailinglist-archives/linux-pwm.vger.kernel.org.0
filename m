Return-Path: <linux-pwm+bounces-6439-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F921ADF627
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 20:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7580318899B3
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jun 2025 18:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6181A316E;
	Wed, 18 Jun 2025 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCstE6Fk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0E23085B3;
	Wed, 18 Jun 2025 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750272341; cv=none; b=QO1OcM6Hu8+kKROGd0wdfGvzJTyDtJw4kfV0I0YuEKIlDBv0BIJ4bTeufdlYVLW0rmcI/HkG0mm+XhJSibgWrRJWM2jKtiUuoRVCeXIrtBPX3X1T+MBR4RLCUdIKfPnnHU0NT8tx1wPKh9yu0E//r0dsy2qVjuFBnaH6G3NaG+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750272341; c=relaxed/simple;
	bh=68swwkz5WLUDkgvby28K+L/7Yq5D/ex+5F8+/n1VM34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtvWbH3RXYPbLgdX+TUJl4f3UBcem1qTCq3JFoAO8Nx6rJTgEb9Rbth2HynfbM8TdpioNj3nl19geEn5tl+2TBNxWfxYScuqMOPWDSCTR77k2LUduQaehwpww3oYlezzZXWQBj3qpbmLH9UL3wIiH5rHqcu/VIDs2vCFHpV9E2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCstE6Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEE5C4CEE7;
	Wed, 18 Jun 2025 18:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750272341;
	bh=68swwkz5WLUDkgvby28K+L/7Yq5D/ex+5F8+/n1VM34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCstE6Fk0hg6V1f/jiM/Wd3QOJemurFTPyYcxCtb+mcbCmR4uUG6vSSnijonLbt6M
	 Ixaz8BOXVTA6zRYvOwJYl+qu8ROFot80wICOOBMnKxssz7i67mueGYtvwotNbHqfmA
	 Tzbh4okcWY1vTw3icBFtUx3wPuz9eii2GYamIat1Xoz3ohc4AnITtl4t79WRT0RL6+
	 zIW+e8FnA7LVvbj1vwY0l6SUdq/gOnR/ENJLD39lZxSiqtFxT9MZHAAkprFY9qhfG3
	 6VwNZa3k3ANKbWAjpUFvBI8m1blP5VxvYmag2jQ4Ke1VokA9HpMZW2zNpdQap5XCYv
	 2/Si3/z9lZL4w==
Date: Wed, 18 Jun 2025 20:45:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: mathieu.dubois-briand@bootlin.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v10 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <amukbuzpu34jbcjhmzmvfgh6eik5isrwcicfmlqmsyibvhij72@nnmhdj3celnt>
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-4-ce3b9e60a588@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nb4jfns7i22b6xds"
Content-Disposition: inline
In-Reply-To: <20250530-mdb-max7360-support-v10-4-ce3b9e60a588@bootlin.com>


--nb4jfns7i22b6xds
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 04/11] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

On Fri, May 30, 2025 at 12:00:12PM +0200, mathieu.dubois-briand@bootlin.com=
 wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>=20
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  drivers/pwm/Kconfig       |  10 +++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-max7360.c | 180 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 191 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 4731d5b90d7e..0b22141cbf85 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -755,4 +755,14 @@ config PWM_XILINX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-xilinx.
> =20
> +config PWM_MAX7360
> +	tristate "MAX7360 PWMs"
> +	depends on MFD_MAX7360
> +	help
> +	  PWM driver for Maxim Integrated MAX7360 multifunction device, with
> +	  support for up to 8 PWM outputs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-max7360.

Alphabetic ordering (by config name) please.

>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 539e0def3f82..9c7701d8070b 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_LPSS)		+=3D pwm-lpss.o
>  obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MAX7360)	+=3D pwm-max7360.o
>  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
>  obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-core.o
> diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
> new file mode 100644
> index 000000000000..a0c82c63d2ac
> --- /dev/null
> +++ b/drivers/pwm/pwm-max7360.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2025 Bootlin
> + *
> + * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
> + * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> + *
> + * Limitations:
> + * - Only supports normal polarity.
> + * - The period is fixed to 2 ms.
> + * - Only the duty cycle can be changed, new values are applied at the b=
eginning
> + *   of the next cycle.
> + * - When disabled, the output is put in Hi-Z.
> + */
> +#include <linux/bits.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/math64.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +
> +#define MAX7360_NUM_PWMS			8
> +#define MAX7360_PWM_MAX_RES			255
> +#define MAX7360_PWM_PERIOD_NS			(2 * NSEC_PER_MSEC)
> +
> +struct max7360_pwm_waveform {
> +	u8 duty_steps;
> +	bool enabled;
> +};
> +
> +static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> +
> +	return regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
> +				 MAX7360_PORT_CFG_COMMON_PWM, 0);
> +}

Do you need to undo that in .free()?

> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const struct pwm_waveform *wf,
> +					   void *_wfhw)
> +{
> +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
> +	u64 duty_steps;
> +
> +	/*
> +	 * Ignore user provided values for period_length_ns and duty_offset_ns:
> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of =
0.
> +	 */
> +	duty_steps =3D mul_u64_u64_div_u64(wf->duty_length_ns, MAX7360_PWM_MAX_=
RES,
> +					 MAX7360_PWM_PERIOD_NS);

You don't need the 64 bit division (which is expensive on 32 bit archs)
if you use:

	if (wf->duty_length_ns >=3D MAX7360_PWM_PERIOD_NS)
		duty_steps =3D MAX7360_PWM_MAX_RES;
	else
		duty_steps =3D (u32)wf->duty_length_ns * MAX7360_PWM_MAX_RES / MAX7360_PW=
M_PERIOD_NS;

> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX_RES, duty_steps);
> +	wfhw->enabled =3D !!wf->duty_length_ns;

How does the output behave if you clean the respective bit in
MAX7360_REG_GPIOCTRL? Unless it emits a constant low signal (and not
e.g. High-Z) you have to do

	wfhw->enabled =3D !!wf->period_length_ns;

here. Please document the behaviour in a paragraph at the top of
the driver. Look at other drivers for the right format. The questions to
answer are:

 - How does the driver behave on disable? (Typical is constant low or
   High-Z or freezing. Does it stop instantly or does it complete the
   currently running period?)

 - How does the driver behave on a (non-disabling) reconfiguration? Can
   it happen that there are glitches? (Consider for example that
   duty_cycle changes from 0.5 ms to 1.5ms while the hardware is just in
   the middle of the 2ms period. Does the output go high immediately
   then producing two 0.5ms pulses during that period?)

> +	return 0;
> +}
> +
> +static int max7360_pwm_round_waveform_fromhw(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
> +					     const void *_wfhw, struct pwm_waveform *wf)
> +{
> +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
> +
> +	wf->period_length_ns =3D wfhw->enabled ? MAX7360_PWM_PERIOD_NS : 0;
> +	wf->duty_offset_ns =3D 0;
> +	wf->duty_length_ns =3D DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PERI=
OD_NS,
> +					  MAX7360_PWM_MAX_RES);

This should be 0 if !wfhw->enabled to make *wf a valid setting.

A check for that in the core (with CONFIG_PWM_DEBUG) would be great.

> +	return 0;
> +}
> +
> +static int max7360_pwm_write_waveform(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      const void *_wfhw)
> +{
> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> +	const struct max7360_pwm_waveform *wfhw =3D _wfhw;
> +	unsigned int val;
> +	int ret;
> +
> +	if (wfhw->enabled) {
> +		ret =3D regmap_write(regmap, MAX7360_REG_PWM(pwm->hwpwm), wfhw->duty_s=
teps);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	val =3D wfhw->enabled ? BIT(pwm->hwpwm) : 0;
> +	return regmap_write_bits(regmap, MAX7360_REG_GPIOCTRL, BIT(pwm->hwpwm),=
 val);
> +}
> +
> +static int max7360_pwm_read_waveform(struct pwm_chip *chip,
> +				     struct pwm_device *pwm,
> +				     void *_wfhw)
> +{
> +	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> +	struct max7360_pwm_waveform *wfhw =3D _wfhw;
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, MAX7360_REG_GPIOCTRL, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & BIT(pwm->hwpwm)) {
> +		wfhw->enabled =3D true;
> +		ret =3D regmap_read(regmap, MAX7360_REG_PWM(pwm->hwpwm), &val);
> +		if (ret)
> +			return ret;
> +
> +		wfhw->duty_steps =3D val;
> +	} else {
> +		wfhw->enabled =3D false;
> +		wfhw->duty_steps =3D 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops max7360_pwm_ops =3D {
> +	.request =3D max7360_pwm_request,
> +	.round_waveform_tohw =3D max7360_pwm_round_waveform_tohw,
> +	.round_waveform_fromhw =3D max7360_pwm_round_waveform_fromhw,
> +	.read_waveform =3D max7360_pwm_read_waveform,
> +	.write_waveform =3D max7360_pwm_write_waveform,
> +};
> +
> +static int max7360_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct pwm_chip *chip;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap =3D dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
> +
> +	/*
> +	 * This MFD sub-device does not have any associated device tree node:
> +	 * properties are stored in the device node of the parent (MFD) device
> +	 * and this same node is used in phandles of client devices.
> +	 * Reuse this device tree node here, as otherwise the PWM subsystem
> +	 * would be confused by this topology.
> +	 */
> +	device_set_of_node_from_dev(dev, dev->parent);
> +
> +	chip =3D devm_pwmchip_alloc(dev, MAX7360_NUM_PWMS, 0);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->ops =3D &max7360_pwm_ops;
> +
> +	pwmchip_set_drvdata(chip, regmap);
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver max7360_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "max7360-pwm",

Please consider setting

		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,

here.

> +	},
> +	.probe =3D max7360_pwm_probe,
> +};
> +module_platform_driver(max7360_pwm_driver);
> +
> +MODULE_DESCRIPTION("MAX7360 PWM driver");
> +MODULE_AUTHOR("Kamel BOUHARA <kamel.bouhara@bootlin.com>");
> +MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>=
");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--nb4jfns7i22b6xds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhTCU8ACgkQj4D7WH0S
/k7cqgf/WXi9aiJFe2APaRTmgebwjHm/Vfjzf54eQh2WwG38kavCDRRV5ejcm7nh
MVn0PLwf4W1ItJXh89u66zRUCy5N8hlak4RPRIGbbVFRhYqtiAPwCXX0/hrZyfHL
6U12235ATlUUfQvI2cMOwgcTC3LGWL6xStZSICqyFKFH+Qg3jYwk1/qo2Ecz/RKL
w74N4UucyvzToYBYvWHuzt1jeXpgnHIi2wvK6RVM3v/PA064TZa9mbYZ6oK/JzsM
kvCKbcBTLXtC88VXC/XsTKmeZXfx0GF5xGmmC7RiDt5phNxrnnK2ra+YAxXl9UoD
9hFdvagIMmLv4Fa6N9+WyhfuhR2SFQ==
=yW7s
-----END PGP SIGNATURE-----

--nb4jfns7i22b6xds--

