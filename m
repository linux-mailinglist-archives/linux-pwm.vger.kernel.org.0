Return-Path: <linux-pwm+bounces-4413-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C29F8759
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 22:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0120516F210
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9823C1C5CB2;
	Thu, 19 Dec 2024 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzsQwbAD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511488F6D;
	Thu, 19 Dec 2024 21:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734645208; cv=none; b=FlmXQMXbvkcxO0uug5lgQX+BFg9zC3iPreeTwL/Bq5yNQYZMP3VyBu/vcKd8VH0vv7ZfD1YXT3EFbUvxySmLi52GfpreMW7iRngS38JaiSkYSbGzSCkybTq533CP1/c88ud3lYgzwff+XNxycupJIcuAFN5kbjy8YbRBYIGd37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734645208; c=relaxed/simple;
	bh=SZHMXZo8UFK80a78XkZE9RnxiiIbtlS3hQmuAlJndcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXhufZ0oVwKEQ+eGMcX1WV7AALvZiXN4LsCHZjP8f5vJ7VhBZNhnvjkqhViWNh5yLf6e8qCuQ78+2e68VXuuo4WO5oQtN3ia2eIBJh/sDqWHusGyyvw0n4A7x6ENTkSFUhxvS3eN6Cdv5VWtP+yGpmOpNkgt1vaJ/tumJe/X1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzsQwbAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D12C4CECE;
	Thu, 19 Dec 2024 21:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734645207;
	bh=SZHMXZo8UFK80a78XkZE9RnxiiIbtlS3hQmuAlJndcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzsQwbADHT5/DTZImq087Ryw+jm79h7zByFikDExi/gjmVLiDv0aqzKjw2AOC/5dG
	 +dT/2EtVzwjOpbibDv7ONHWf3bF3PRp5ksWm7uR6s0opWQhY/0FpsR7OZLdjhKjnzZ
	 SaQbQOeAreHtq2xsBLMcPrtJHQ3y90pPSQZPT6VktuVxyj+FrRpWUJ7pGtUu+Ww3ua
	 FeF2o953OO9OQ7wHmGexKfr4w6mrXnIQAMNdaO/QJxxaCMztp6itJbvlDLAfcDg2Dr
	 cYIOMdeD14DwIasJuznxyU58W9mS9TSvKbuL+poEOwXNH7KwZak0iUACPsU0uW4x8P
	 amNZm9DOqbsPA==
Date: Thu, 19 Dec 2024 22:53:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: mathieu.dubois-briand@bootlin.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 4/8] pwm: max7360: Add MAX7360 PWM support
Message-ID: <dmfnpq57n3s32o33pm7wfppr5nttdvtuthe7hf32psmykotrox@mogq35gj6rjq>
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
 <20241219-mdb-max7360-support-v1-4-8e8317584121@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="l674q7a73qucv7pw"
Content-Disposition: inline
In-Reply-To: <20241219-mdb-max7360-support-v1-4-8e8317584121@bootlin.com>


--l674q7a73qucv7pw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/8] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

Hello,

On Thu, Dec 19, 2024 at 05:21:21PM +0100, mathieu.dubois-briand@bootlin.com=
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
>  drivers/pwm/pwm-max7360.c | 173 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 185 insertions(+)
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
> index 000000000000..b1cde3e86864
> --- /dev/null
> +++ b/drivers/pwm/pwm-max7360.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Bootlin
> + *
> + * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
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
> +	struct device *dev;
> +	struct regmap *regmap;
> +};
> +
> +static inline struct max7360_pwm *to_max7360_pwm(struct pwm_chip *chip)
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
> +	ret =3D max7360_port_pin_request(max7360_pwm->dev->parent, pwm->hwpwm,
> +				       true);
> +	if (ret) {
> +		dev_err(&chip->dev, "failed to request pwm-%d\n", pwm->hwpwm);

Please no error messages after probe.

> +		return ret;
> +	}
> +
> +	ret =3D regmap_write_bits(max7360_pwm->regmap,
> +				MAX7360_REG_PWMCFG + pwm->hwpwm,
> +				MAX7360_PWM_COMMON_PWN,
> +				0);
> +	if (ret) {
> +		dev_err(&chip->dev, "failed to write pwm-%d cfg register, error %d\n",
> +			pwm->hwpwm, ret);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_PORTS,
> +				MAX7360_PWM_PORT(pwm->hwpwm),
> +				MAX7360_PWM_PORT(pwm->hwpwm));
> +	if (ret) {
> +		dev_err(&chip->dev, "failed to write pwm-%d ports register, error %d\n=
",
> +			pwm->hwpwm, ret);
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
> +		dev_err(&chip->dev, "failed to enable pwm-%d , error %d\n",
> +			pwm->hwpwm, ret);
> +
> +	max7360_port_pin_request(max7360_pwm->dev->parent, pwm->hwpwm,
> +				 false);
> +}
> +
> +static int max7360_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
> +{
> +	struct max7360_pwm *max7360_pwm;
> +	u64 duty_steps =3D state->duty_cycle * MAX7360_PWM_MAX_RES;

This might overflow.

> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	max7360_pwm =3D to_max7360_pwm(chip);
> +	ret =3D regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
> +				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm),
> +				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm));
> +	if (ret) {
> +		dev_err(&chip->dev, "failed to enable pwm-%d , error %d\n",
> +			pwm->hwpwm, ret);
> +		return ret;
> +	}
> +
> +	do_div(duty_steps, MAX7360_PWM_PERIOD_NS);
> +
> +	ret =3D regmap_write(max7360_pwm->regmap, MAX7360_REG_PWMBASE + pwm->hw=
pwm,
> +			   duty_steps >=3D 255 ? 255 : duty_steps);
> +	if (ret) {
> +		dev_err(&chip->dev,
> +			"failed to apply pwm duty_cycle %llu on pwm-%d, error %d\n",
> +			duty_steps, pwm->hwpwm, ret);
> +		return ret;
> +	}

Huh, state->period isn't used at all. That is wrong for sure.

> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops max7360_pwm_ops =3D {
> +	.request =3D max7360_pwm_request,
> +	.free =3D max7360_pwm_free,
> +	.apply =3D max7360_pwm_apply,

Please implement .get_state() (or the new waveform callbacks)

> +};
> +
> +static int max7360_pwm_probe(struct platform_device *pdev)
> +{
> +	struct max7360_pwm *max7360_pwm;
> +	struct pwm_chip *chip;
> +
> +	if (!pdev->dev.parent) {
> +		dev_err(&pdev->dev, "no parent device\n");
> +		return -ENODEV;

return dev_err_probe(...);

> +	}
> +
> +	chip =3D devm_pwmchip_alloc(&pdev->dev, MAX7360_NUM_PWMS,
> +				  sizeof(*max7360_pwm));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->ops =3D &max7360_pwm_ops;
> +
> +	max7360_pwm =3D to_max7360_pwm(chip);
> +	max7360_pwm->dev =3D &pdev->dev;

This is only ever used to get max7360_pwm->dev->parent; so better store
the parent directly in max7360_pwm.

> +
> +	max7360_pwm->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!max7360_pwm->regmap) {
> +		dev_err(&pdev->dev, "could not get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	return devm_pwmchip_add(&pdev->dev, chip);

error message please

> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id max7360_pwm_of_match[] =3D {
> +	{ .compatible =3D "maxim,max7360-pwm", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max7360_pwm_of_match);
> +#endif

Please drop the CONFIG_OF guard.

> +
> +static struct platform_driver max7360_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "max7360-pwm",
> +		.of_match_table =3D of_match_ptr(max7360_pwm_of_match),
> +	},
> +	.probe =3D max7360_pwm_probe,
> +};
> +module_platform_driver(max7360_pwm_driver);
> +
> +MODULE_DESCRIPTION("MAX7360 PWM driver");
> +MODULE_AUTHOR("Kamel BOUHARA <kamel.bouhara@bootlin.com>");
> +MODULE_ALIAS("platform:max7360-pwm");
> +MODULE_LICENSE("GPL");

--l674q7a73qucv7pw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdkldEACgkQj4D7WH0S
/k7+cQgAuKweHK6PzSr+FW9o4C46vJOunHmP5QnDY/OevBWmLErEp2QIZG2a6k0r
ym81OH3qFrHekOy8vcMXCSygACvLDoZRAB/HlMgT22mwYesPzbRt8Cl4gAev9hLM
gL6p6OqKzcd7mTslsSnHSsf3wlUt1kOxtHO+FYIE6zq7z5iZY0oVcJ0hyxds1jtO
m8lxR96o+Pt1O5liyHpXmy6qIrTx8xjVCOADxsVAaSsS5wGnSOYSCuJ6OaK51DzQ
5nUlsZcuyqWQA8gjdor5Ai5l3wZ/JYwvskLr9wJKAgqNqa8adjTXuAapaTxtVx5O
XD4P63Ni0CrDFRRz3yEVNMWNU0TT5A==
=q/jG
-----END PGP SIGNATURE-----

--l674q7a73qucv7pw--

