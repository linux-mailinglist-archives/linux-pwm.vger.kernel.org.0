Return-Path: <linux-pwm+bounces-4642-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7879A14C35
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 10:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1184B1657A1
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC61F941A;
	Fri, 17 Jan 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTpTUAJN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531D725A659;
	Fri, 17 Jan 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737106410; cv=none; b=M+IZj+cy2MhWB87iAJ4t0i8aWlGkgA8M4wk5SEar9qWgok0NtBOckbF0jIsIZuCiM8p9ICU1vINYwl46pLDeEcqwNUblADq7R524tSYlCYoxccVFB0crcgHqgg27cAkT71W4QadFO140Gy3O/IcvZ4AptawsQCLoXszGGz7WvbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737106410; c=relaxed/simple;
	bh=eZDzyCYMomRlkjMuQwgage8yVeHPfDOgKoiSoYjQKSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YfnzstGAc1RRd4uttQ9LM5OhwOeVR3NRXhEG+vxgQiyTL0rPyRE8Rpv2WWIbwk0S3bhrEYCFJ4SUPwdeQQFNoNLxmROAUfTjtEx53/omLg3xVOIcDDU6VPkqD6C35YWM58jeWjBW4qJtVR15kXbES0LLEQd6XGFwdUzHhRYAYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTpTUAJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7C3C4CEDD;
	Fri, 17 Jan 2025 09:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737106409;
	bh=eZDzyCYMomRlkjMuQwgage8yVeHPfDOgKoiSoYjQKSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTpTUAJNDWS9S1jfGTbfYoZJo3kmegh7r7rBKY/N02xeR0ASfk4Yy0sG8oenDeTOa
	 t98EuvvK084Vk3adg8nqSwjjKatD5wL+y29MB7N6e/vWXGPEIeRF7oWo130zR8SEFL
	 UPpY3TcKejUMSRMf/BM6F9c2YJdpFoPkO74yoBKuXPaCYHh9E2TGVqt2FFQsIqYSfH
	 FrW3WRsq67vxNsvUCfN0nEO8udcbds2GxbYiRahmUhlWZRUFt3LkNWAvKv8OYJxYeo
	 1Kq4APf8V3eGqGdVbwFFHyHB2QMRBjQ3Xwe+VeOnV3529yPTnL9YGv2aBl/nUSfK2d
	 OB3vMAr7FNL+w==
Date: Fri, 17 Jan 2025 10:33:27 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: mathieu.dubois-briand@bootlin.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/7] pwm: max7360: Add MAX7360 PWM support
Message-ID: <f22l3uqgt65utxehv2zmozqixjkktp4trpr42xr5arvp6o5zcf@g5iriaeskqa5>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
 <20250113-mdb-max7360-support-v3-3-9519b4acb0b1@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vithmpfjab4b6jn6"
Content-Disposition: inline
In-Reply-To: <20250113-mdb-max7360-support-v3-3-9519b4acb0b1@bootlin.com>


--vithmpfjab4b6jn6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/7] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

Hello Mathieu,

On Mon, Jan 13, 2025 at 01:42:27PM +0100, mathieu.dubois-briand@bootlin.com=
 wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>=20
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  drivers/pwm/Kconfig       |  11 +++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-max7360.c | 220 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 232 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..399dc3f76e92 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -745,4 +745,15 @@ config PWM_XILINX
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-xilinx.
> =20
> +config PWM_MAX7360
> +	tristate "MAX7360 PWMs"
> +	depends on MFD_MAX7360
> +	depends on OF_GPIO
> +	help
> +	  PWM driver for Maxim Integrated MAX7360 multifunction device, with
> +	  support for up to 8 PWM outputs.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-max7360.
> +
>  endif
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..ae8908ffc892 100644
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
> index 000000000000..e76a8aa05fc4
> --- /dev/null
> +++ b/drivers/pwm/pwm-max7360.c
> @@ -0,0 +1,220 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Bootlin
> + *
> + * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
> + *
> + * Limitations:
> + * - Only supports normal polarity.
> + * - The period is fixed to 2 ms.
> + * - Only the duty cycle can be changed, new values are applied at the b=
eginning
> + *   of the next cycle.
> + * - When disabled, the output is put in Hi-Z.
> + */
> +#include <linux/math.h>
> +#include <linux/mfd/max7360.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +
> +#define MAX7360_NUM_PWMS			8
> +#define MAX7360_PWM_MAX_RES			256
> +#define MAX7360_PWM_PERIOD_NS			2000000 /* 500 Hz */
> +#define MAX7360_PWM_COMMON_PWN			BIT(5)
> +#define MAX7360_PWM_CTRL_ENABLE(n)		BIT(n)
> +#define MAX7360_PWM_PORT(n)			BIT(n)
> +
> +struct max7360_pwm {
> +	struct device *parent;
> +	struct regmap *regmap;
> +};
> +
> +static inline struct max7360_pwm *to_max7360_pwm(struct pwm_chip *chip)

Please stick to the common function prefix also here. So something like
max7360_pwm_from_chip would work.

> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct max7360_pwm *max7360_pwm;
> +	int ret;
> +
> +	max7360_pwm =3D to_max7360_pwm(chip);
> +	ret =3D max7360_port_pin_request(max7360_pwm->parent, pwm->hwpwm,
> +				       true);

The statement fits on a single line just fine.

> +	if (ret) {
> +		dev_warn(&chip->dev, "failed to request pwm-%d\n", pwm->hwpwm);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_write_bits(max7360_pwm->regmap,
> +				MAX7360_REG_PWMCFG + pwm->hwpwm,

Can you make MAX7360_REG_PWMCFG a macro accepting pwm->hwpwm as
parameter please?

> +				MAX7360_PWM_COMMON_PWN,
> +				0);
> +	if (ret) {
> +		dev_warn(&chip->dev,
> +			 "failed to write pwm-%d cfg register, error %d\n",
> +			 pwm->hwpwm, ret);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_PORTS,
> +				MAX7360_PWM_PORT(pwm->hwpwm),
> +				MAX7360_PWM_PORT(pwm->hwpwm));
> +	if (ret) {
> +		dev_warn(&chip->dev,
> +			 "failed to write pwm-%d ports register, error %d\n",
> +			 pwm->hwpwm, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void max7360_pwm_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct max7360_pwm *max7360_pwm;
> +	int ret;
> +
> +	max7360_pwm =3D to_max7360_pwm(chip);
> +	ret =3D regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
> +				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm),
> +				0);
> +	if (ret)
> +		dev_warn(&chip->dev, "failed to disable pwm-%d , error %d\n",
> +			 pwm->hwpwm, ret);

=2Efree is not supposed to stop the PWM. Though I admit this concept is a
bit fuzzy, because when unconfiguring the pin function this is kind of
moot. Still it's the responsibility of the consumer to stop the PWM
before pwm_put().

Also s/ ,/,/ and use %pe for error codes.

> +	max7360_port_pin_request(max7360_pwm->parent, pwm->hwpwm,
> +				 false);
> +}
> +
> +static int max7360_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct max7360_pwm *max7360_pwm;
> +	u64 duty_steps;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (state->period !=3D MAX7360_PWM_PERIOD_NS) {
> +		dev_warn(&chip->dev,
> +			 "unsupported pwm period: %llu, should be %u\n",
> +			 state->period, MAX7360_PWM_PERIOD_NS);
> +		return -EINVAL;

Please don't emit error messages in .apply(). Also a driver is supposed
to round down .period, so any value >=3D MAX7360_PWM_PERIOD_NS should be
accepted.

Also note that you might want to implement the waveform callbacks
instead of .apply() and .get_state() for the more modern abstraction
(with slightly different rounding rules).

> +	}
> +
> +	duty_steps =3D mul_u64_u64_div_u64(state->duty_cycle, MAX7360_PWM_MAX_R=
ES,
> +					 MAX7360_PWM_PERIOD_NS);
> +
> +	max7360_pwm =3D to_max7360_pwm(chip);
> +	ret =3D regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
> +				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm),
> +				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm));
> +	if (ret) {
> +		dev_warn(&chip->dev, "failed to enable pwm-%d , error %d\n",
> +			 pwm->hwpwm, ret);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_write(max7360_pwm->regmap, MAX7360_REG_PWMBASE + pwm->hw=
pwm,
> +			   duty_steps >=3D 255 ? 255 : duty_steps);
> +	if (ret) {
> +		dev_warn(&chip->dev,
> +			 "failed to apply pwm duty_cycle %llu on pwm-%d, error %d\n",
> +			 duty_steps, pwm->hwpwm, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max7360_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> +				 struct pwm_state *state)
> +{
> +	struct max7360_pwm *max7360_pwm;
> +	unsigned int val;
> +	int ret;
> +
> +	max7360_pwm =3D to_max7360_pwm(chip);
> +
> +	state->period =3D MAX7360_PWM_PERIOD_NS;
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	ret =3D regmap_read(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL, &val);
> +	if (ret) {
> +		dev_warn(&chip->dev,
> +			 "failed to read pwm configuration on pwm-%d, error %d\n",
> +			 pwm->hwpwm, ret);

Similar to .apply() please no messages in .get_state(). Just fail
silently.

> +		return ret;
> +	}
> +	state->enabled =3D !!(val & MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm));
> +
> +	ret =3D regmap_read(max7360_pwm->regmap, MAX7360_REG_PWMBASE + pwm->hwp=
wm,
> +			  &val);
> +	if (ret) {
> +		dev_warn(&chip->dev,
> +			 "failed to read pwm duty_cycle on pwm-%d, error %d\n",
> +			 pwm->hwpwm, ret);
> +		return ret;
> +	}
> +	state->duty_cycle =3D mul_u64_u64_div_u64(val, MAX7360_PWM_PERIOD_NS,
> +						MAX7360_PWM_MAX_RES);

You have to round up here. I would expect that the checks in the core
(with PWM_DEBUG=3D1) help you catching this type of error. In your case
changing the configuration to

	.period =3D 2000000,
	.duty_cycle =3D 234379,

should yield some hint in the kernel log.

> +	return 0;
> +}

Best regards
Uwe

--vithmpfjab4b6jn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeKI+QACgkQj4D7WH0S
/k4+Jgf+OjxiqOdWsGmWBl4iR6nf7x6NhFz+B45X5Qq9nLFe36xTsQzsz4VG7AvC
HCeJ+FinC/HuvweZNOYgQaCTxnbdeIj2jZOmSbo8T2OQFGPSXBFLbLh3hZfhiNEV
rF4rtDLt5tX/Ap1yTKQzboCi/Z70ESveEeor5lMVaQKwQZKzuLFBMBYSF7wTk5cK
tg5yThyM5vc8LZE1oTTP91jh942BNwiTnDDSlrLvc3RVv5UdTOcy5RpFjuDFBVa9
qpBmxolfCFDNf9NAZXnwm5Jo8FPJbDQyAdnMdcdGlEVZewLV34jvCv1IJXZmrfIy
gvX4qITK0x3r2xdvSV3a7SHO5DUW5A==
=otwK
-----END PGP SIGNATURE-----

--vithmpfjab4b6jn6--

