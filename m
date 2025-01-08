Return-Path: <linux-pwm+bounces-4551-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B7CA054E7
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 09:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35052165127
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 08:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F011AA781;
	Wed,  8 Jan 2025 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln7EGzxR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E98225D7;
	Wed,  8 Jan 2025 08:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323270; cv=none; b=uSIyOzE0eSLGG41N1dEBu1e356+8m/u9N6/PfiWXW7T9N2UdjXTStpLtALurQQ0YbAFoh5CRLpQRHUSROhG91/Oi00I7bDt8RyDW435CKNsHv8p+KqQgi4Kek/7GHUWVLl5gCCeiwvvIRjZd0nQHHlK+wZgrrVf2OIgYImSiock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323270; c=relaxed/simple;
	bh=i0PZUY3UgJKZP/GGgIi6bHMMnaWAtE6/uEWrRXixbF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2EcN4aL2qCR3qai084EqZ4bv5udiPRU7qljT4nVEgBwsPwnmro2QJi2HPhRaGHtkqHZmcCfiOdbWHE0NjrZwpunw87knJFf0A8zPw8dYRgX4zXN3zOSYXdMqF0z1vP/hX1MggcdwqDGSJTRAW+kPJKrOrRIaMVkaRLOkEIMWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln7EGzxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82BFC4CEE0;
	Wed,  8 Jan 2025 08:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736323270;
	bh=i0PZUY3UgJKZP/GGgIi6bHMMnaWAtE6/uEWrRXixbF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ln7EGzxRlg7VptPdgOT0IKy7DkGU+TlwfMkbtLrjZKibLkTOpICqyExCyOR2F48zV
	 jsuUxtUcjdl0NSKFY0ow9XPPz8LyOngB5qVaMhQFCpNDEBFYJLu2act7qE4u8xhgMt
	 WhNkJE9JrrSOLQaZI1ZmIcvqLW3tVqY6sMlncY4cwUWUBjYUuw4K8/jC6bY8O7nXMC
	 WuqssYgFmTfK9cTrLp87HFsvnd7e10GriyIvlGZoVdXr5IwKAvebvwq0RIndFo9n9U
	 mrnUGIAQtCwwCiSf24qTySs2q60yyodh5YpVv0V5o9cXUVg0k5+3xNo8DEaM0JPnl6
	 GeQQYf4/bHvRA==
Date: Wed, 8 Jan 2025 09:01:07 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <5msw2ptk2ip5h5ovqe2ficgofqmaryq2qf5h7qendygaa23lp4@gy754ev7cnqm>
References: <20241109174135.26292-1-dima.fedrau@gmail.com>
 <20241109174135.26292-3-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wauwio6435lexh5q"
Content-Disposition: inline
In-Reply-To: <20241109174135.26292-3-dima.fedrau@gmail.com>


--wauwio6435lexh5q
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
MIME-Version: 1.0

Hello Dimitri,

thanks for your patience. I'm mostly happy now. Just a few minor
comments below:

On Sat, Nov 09, 2024 at 06:41:35PM +0100, Dimitri Fedrau wrote:
> The MC33XS2410 is a four channel high-side switch. Featuring advanced
> monitoring and control function, the device is operational from 3.0 V to
> 60 V. The device is controlled by SPI port for configuration.
>=20
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>  drivers/pwm/Kconfig          |  12 ++
>  drivers/pwm/Makefile         |   1 +
>  drivers/pwm/pwm-mc33xs2410.c | 388 +++++++++++++++++++++++++++++++++++
>  3 files changed, 401 insertions(+)
>  create mode 100644 drivers/pwm/pwm-mc33xs2410.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16..f513513f9b2f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -411,6 +411,18 @@ config PWM_LPSS_PLATFORM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-lpss-platform.
> =20
> +config PWM_MC33XS2410
> +	tristate "MC33XS2410 PWM support"
> +	depends on OF
> +	depends on SPI
> +	help
> +	  NXP MC33XS2410 high-side switch driver. The MC33XS2410 is a four
> +	  channel high-side switch. The device is operational from 3.0 V
> +	  to 60 V. The device is controlled by SPI port for configuration.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-mc33xs2410.
> +
>  config PWM_MESON
>  	tristate "Amlogic Meson PWM driver"
>  	depends on ARCH_MESON || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 9081e0c0e9e0..c75deeeace40 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_LPSS)		+=3D pwm-lpss.o
>  obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MC33XS2410)	+=3D pwm-mc33xs2410.o
>  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
>  obj-$(CONFIG_PWM_MICROCHIP_CORE)	+=3D pwm-microchip-core.o
> diff --git a/drivers/pwm/pwm-mc33xs2410.c b/drivers/pwm/pwm-mc33xs2410.c
> new file mode 100644
> index 000000000000..97cf31ef608a
> --- /dev/null
> +++ b/drivers/pwm/pwm-mc33xs2410.c
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + *
> + * Reference Manual : https://www.nxp.com/docs/en/data-sheet/MC33XS2410.=
pdf
> + *
> + * Limitations:
> + * - Supports frequencies between 0.5Hz and 2048Hz with following steps:
> + *   - 0.5 Hz steps from 0.5 Hz to 32 Hz
> + *   - 2 Hz steps from 2 Hz to 128 Hz
> + *   - 8 Hz steps from 8 Hz to 512 Hz
> + *   - 32 Hz steps from 32 Hz to 2048 Hz
> + * - Cannot generate a 0 % duty cycle.
> + * - Always produces low output if disabled.
> + * - Configuration isn't atomic. When changing polarity, duty cycle or p=
eriod
> + *   the data is taken immediately, counters not being affected, resulti=
ng in a
> + *   behavior of the output pin that is neither the old nor the new stat=
e,
> + *   rather something in between.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pwm.h>
> +
> +#include <linux/spi/spi.h>
> +
> +#define MC33XS2410_GLB_CTRL		0x00
> +#define MC33XS2410_GLB_CTRL_MODE	GENMASK(7, 6)
> +#define MC33XS2410_GLB_CTRL_MODE_NORMAL	FIELD_PREP(MC33XS2410_GLB_CTRL_M=
ODE, 1)
> +
> +#define MC33XS2410_PWM_CTRL1		0x05
> +/* x in { 1 ... 4 } */

Here x ranges over the 4 output channels, right? Maybe call it "chan" or
similar instead of "x"?

> +#define MC33XS2410_PWM_CTRL1_POL_INV(x)	BIT((x - 1))

BIT((x) - 1)

> +
> +#define MC33XS2410_PWM_CTRL3		0x07
> +/* x in { 1 ... 4 } */
> +#define MC33XS2410_PWM_CTRL3_EN(x)	BIT(4 + (x - 1))
> +
> +/* x in { 1 ... 4 } */
> +#define MC33XS2410_PWM_FREQ(x)		(0x08 + (x - 1))
> +#define MC33XS2410_PWM_FREQ_STEP	GENMASK(7, 6)
> +#define MC33XS2410_PWM_FREQ_COUNT	GENMASK(5, 0)
> +
> +/* x in { 1 ... 4 } */
> +#define MC33XS2410_PWM_DC(x)		(0x0c + (x - 1))
> +
> +#define MC33XS2410_WDT			0x14
> +
> +#define MC33XS2410_PWM_MIN_PERIOD	488282
> +/* x in { 0 ... 3 } */
> +#define MC33XS2410_PWM_MAX_PERIOD(x)	(2000000000 >> (2 * x))

Here x ranges over the four period intervals. I suggest to call this x
"step" instead. Also the parameter needs bracketing.

> +#define MC33XS2410_FRAME_IN_ADDR	GENMASK(15, 8)
> +#define MC33XS2410_FRAME_IN_DATA	GENMASK(7, 0)
> +#define MC33XS2410_FRAME_IN_ADDR_WR	BIT(7)
> +#define MC33XS2410_FRAME_IN_DATA_RD	BIT(7)
> +#define MC33XS2410_FRAME_OUT_DATA	GENMASK(13, 0)
> +
> +#define MC33XS2410_MAX_TRANSFERS	5
> +
> [...]
> +static int mc33xs2410_pwm_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				const struct pwm_state *state)
> +{
> +	struct mc33xs2410_pwm *mc33xs2410 =3D mc33xs2410_from_chip(chip);
> +	struct spi_device *spi =3D mc33xs2410->spi;
> +	u8 reg[4] =3D {
> +			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
> +			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
> +			MC33XS2410_PWM_CTRL1,
> +			MC33XS2410_PWM_CTRL3
> +		    };
> +	u64 period, duty_cycle;
> +	int ret, rel_dc;
> +	u16 rd_val[2];
> +	u8 wr_val[4];
> +	u8 mask;
> +
> +	period =3D min(state->period, MC33XS2410_PWM_MAX_PERIOD(0));
> +	if (period < MC33XS2410_PWM_MIN_PERIOD)
> +		return -EINVAL;
> +
> +	ret =3D mc33xs2410_read_regs(spi, &reg[2], MC33XS2410_FRAME_IN_DATA_RD,=
 rd_val, 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* frequency */
> +	wr_val[0] =3D mc33xs2410_pwm_get_freq(period);
> +	/* Continue calculations with the possibly truncated period */
> +	period =3D mc33xs2410_pwm_get_period(wr_val[0]);
> +
> +	/* duty cycle */
> +	duty_cycle =3D min(period, state->duty_cycle);
> +	rel_dc =3D div64_u64(duty_cycle * 256, period) - 1;
> +	if (rel_dc < 0)
> +		wr_val[1] =3D 0;
> +	else
> +		wr_val[1] =3D rel_dc;
> +
> +	/* polarity */
> +	mask =3D MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm + 1);
> +	wr_val[2] =3D (state->polarity =3D=3D PWM_POLARITY_INVERSED) ?
> +		    (rd_val[0] | mask) : (rd_val[0] & ~mask);
> +
> +	/* enable output */

/*
 * As the hardware cannot generate a 0% relative duty cycle but emits a
 * constant low signal when disabled, also disable in the duty_cycle =3D 0
 * case.
 */

> +	mask =3D MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm + 1);
> +	wr_val[3] =3D (state->enabled && rel_dc >=3D 0) ? (rd_val[1] | mask) :
> +						      (rd_val[1] & ~mask);
> +
> +	return mc33xs2410_write_regs(spi, reg, wr_val, 4);
> +}
> +
> +static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
> +				    struct pwm_device *pwm,
> +				    struct pwm_state *state)
> +{
> +	struct mc33xs2410_pwm *mc33xs2410 =3D mc33xs2410_from_chip(chip);
> +	struct spi_device *spi =3D mc33xs2410->spi;
> +	u8 reg[4] =3D {
> +			MC33XS2410_PWM_FREQ(pwm->hwpwm + 1),
> +			MC33XS2410_PWM_DC(pwm->hwpwm + 1),
> +			MC33XS2410_PWM_CTRL1,
> +			MC33XS2410_PWM_CTRL3,
> +		    };
> +	u16 val[4];
> +	int ret;
> +
> +	ret =3D mc33xs2410_read_regs(spi, reg, MC33XS2410_FRAME_IN_DATA_RD, val=
, 4);

ARRAY_SIZE(reg) instead of hardcoded 4?

> +	if (ret < 0)
> +		return ret;
> +
> +	state->period =3D mc33xs2410_pwm_get_period(val[0]);
> +	state->polarity =3D (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm +=
 1)) ?
> +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> +	state->enabled =3D !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm + 1));
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL((val[1] + 1) * state->period, 25=
6);
> +
> +	return 0;
> +}
> [...]
> +static int mc33xs2410_probe(struct spi_device *spi)
> +{
> +	struct mc33xs2410_pwm *mc33xs2410;
> +	struct device *dev =3D &spi->dev;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, 4, sizeof(*mc33xs2410));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	spi->bits_per_word =3D 16;
> +	spi->mode |=3D SPI_CS_WORD;
> +	ret =3D spi_setup(spi);
> +	if (ret < 0)
> +		return ret;
> +
> +	mc33xs2410 =3D mc33xs2410_from_chip(chip);
> +	mc33xs2410->spi =3D spi;
> +	chip->ops =3D &mc33xs2410_pwm_ops;

Given that struct mc33xs2410_pwm only has a single member you can pass 0
as 3rd parameter to devm_pwmchip_alloc(), call pwmchip_set_drvdata(chip,
spi). Then you can save on indirection.

> +	ret =3D mc33xs2410_reset(dev);
> +	if (ret)
> +		return ret;
> +

Best regards
Uwe

--wauwio6435lexh5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmd+MMEACgkQj4D7WH0S
/k7xeQgAk6yDUMVaVCPk1Qix8wbF0gs3JHWR2PiPF09A1MlR0uyNYyyV+48syCqn
acdjeXGA/AgzNUkdxjmwBIWJ3+53wJ3JmQdQ4uI7QUGl4iF5gA6/Tg7LClweDq+4
KvoHKx5AauP+gLq9qWKQHhTY86QZ+yJ4SrPZyYeGflS05+0u88TufJcu6+1cwxdh
PIIZwcn2Olq1Cml9wXQbTrjC9GQCbaJwgps1zpQWS0NMNy/XrqnQJl+mPEFwaPoc
5kVpUhzJvLXd4QdSalV9DFm18hHjclChOJ4vBLzhFXDs0IOzQ9Lj9354YjPubrhH
lUNgPhAolzGX3ILiQ+WwIIOjmaSBNA==
=rlQs
-----END PGP SIGNATURE-----

--wauwio6435lexh5q--

