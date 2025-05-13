Return-Path: <linux-pwm+bounces-5943-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCC6AB527B
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E79189E5D3
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8F41EB18C;
	Tue, 13 May 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBc6dcyH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BA718DB20;
	Tue, 13 May 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130933; cv=none; b=PnDopRtqGzoevLdpKBKvJJxFFsqdCBDZjD801RcxM4ro2aipuypt8SwtuZIxokxKoNMmHaG7MWR8O0T3lv8z0YjBRs1x/cEUlYUj7/ijtkmyZwhRl1Z18TrtSh8um/oBifvC0VfwVIFq9PdFrmHhLn7kHoKC2qOZls0G/GgbYj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130933; c=relaxed/simple;
	bh=zaeAUYaQaFHz8DDo3EJfThuIgsaCi3wiYrz7Dcx2zMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVq3ZDUJh8F3GjwniaCu/F3kK3nbW776p3UFM5ksNiVgC8LbazHmmC309YknJE5lgAAMkKGbYn/QOBUj9oXpKLqJPZ5oQNGHGPdu57o3/GgcZwK48qh95fa/V5NxrJdnM4ebOMDS3rEHQ2H4LsoQcYazzEqFx8M2A5Rp3qtAUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBc6dcyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08DCC4CEEF;
	Tue, 13 May 2025 10:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747130932;
	bh=zaeAUYaQaFHz8DDo3EJfThuIgsaCi3wiYrz7Dcx2zMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBc6dcyHfRmLVPnEJ7WqN6jAAGEAy1SxD+69ZeQkyenu2zi1lBZ1UAoWBRdVUsG3e
	 5REm+NHtSlykhwg38l+cCizPJlE7VbxCPTAzDti3CU+vt25zRRMMjvTEbB7grlw9/S
	 Melmd91vg176MxOgnp2edXmzJuRrRt8rvB1lXNU5165SZF1Tny3uf34Ag83GKKQ4z3
	 Q2De000VrTC/39GfW5XHj7N9zaqt4xtZQb+3r5bD0EO2oAOKjOPNwvv3gj0jKeQgTI
	 rLpxk3KKYh8Bh1hHT1NsCl/UBXX3uBBDCVx2JUHnW8gzQbkWHgqfmLI130FigyC0Y+
	 ncbjFVXqPyAig==
Date: Tue, 13 May 2025 12:08:49 +0200
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
Subject: Re: [PATCH v8 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <5eb7xqo7bfzath3xy7i6v5fep7qwfeg4z3rtzifmgnyvlc3o5b@yi6hzur52hl3>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
 <20250509-mdb-max7360-support-v8-4-bbe486f6bcb7@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2yxh7t5v6ayknmhz"
Content-Disposition: inline
In-Reply-To: <20250509-mdb-max7360-support-v8-4-bbe486f6bcb7@bootlin.com>


--2yxh7t5v6ayknmhz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 04/11] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

Hello,

On Fri, May 09, 2025 at 11:14:38AM +0200, mathieu.dubois-briand@bootlin.com=
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
>  drivers/pwm/pwm-max7360.c | 186 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 197 insertions(+)
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
> +
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
> index 000000000000..af2006ec7a96
> --- /dev/null
> +++ b/drivers/pwm/pwm-max7360.c
> @@ -0,0 +1,186 @@
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
> +	int ret;
> +
> +	ret =3D regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
> +				MAX7360_PORT_CFG_COMMON_PWM, 0);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write_bits(regmap, MAX7360_REG_PORTS, BIT(pwm->hwpwm), BI=
T(pwm->hwpwm));

What is the effect of these writes? It doesn't need to be undone in a
matching .free()?

> +}
> +
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
> +
> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX_RES, duty_steps);
> +	wfhw->enabled =3D !!wf->duty_length_ns;
> +
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
> +
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
> +	val =3D wfhw->enabled ? BIT(pwm->hwpwm) : 0;
> +	ret =3D regmap_write_bits(regmap, MAX7360_REG_GPIOCTRL, BIT(pwm->hwpwm)=
, val);
> +	if (ret)
> +		return ret;
> +
> +	if (wfhw->duty_steps)
> +		return regmap_write(regmap, MAX7360_REG_PWM(pwm->hwpwm), wfhw->duty_st=
eps);

Would it make sense to first write duty_steps and only then enable?
Otherwise it might happen that you enable and still have a wrong duty
configuration in the MAX7360_REG_PWM register and emit a wrong period?

Do you need to write duty_steps =3D 0 if enabled is false?

> +	return 0;
> +}

Best regards
Uwe

--2yxh7t5v6ayknmhz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgjGi4ACgkQj4D7WH0S
/k7HQgf+Odk90m1utgkmYbrz0FZcNC2Skz6UXgO3C4M5SobWtBPbpcaW/JcIB4Gk
fVwmhMBKl2od85hqkXxZLOuVzA3oBPOCDzQAZTg9gb4bisIWrT3hHpDvL5UZEoKI
ma06cuOTdO38aJByqPveRD54zUJugND1BcQcNT9+ZOxNmj1pg1QUe+4yxrFN8Zbp
ZrIUqujG7ME+OV1MxFw5g3WVvGonjnVJFfi9BVdzNAUpjlqaOEQIj5en96e3titd
JlpLFklRScDWH8stcquc87bhxm4NDdK0BP01NK5r/9NbJmVLDfCBgeM0ATUGGkLS
G20Lg42CoxYWzsO+yiLcAyR7uCky3g==
=gP0G
-----END PGP SIGNATURE-----

--2yxh7t5v6ayknmhz--

