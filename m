Return-Path: <linux-pwm+bounces-7085-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E84B29D23
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 11:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41EB27ABB48
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Aug 2025 09:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C64E30DD2A;
	Mon, 18 Aug 2025 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNQwpjpR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3D30C366;
	Mon, 18 Aug 2025 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507935; cv=none; b=WiAHxob4uwZzY0PJliCTYjEQFPWgw2oWQ1tw8EzlwEO4ywrrlc7G8LtC75XD1/P5nd+3Oc7kAEC1RJ/lN9I7NJ9CxfH8hGVLVqfi4dnEpzWg22u6/le8j7lFraC4K/xM2CyhISiMv9saNMTcc8nq6eujUJIWEYNFQUUHQQV4E5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507935; c=relaxed/simple;
	bh=vPUErYbWGmNKxPxliyJVPTXbvWnb22hHtW7n+fRfO2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRJPaU0NnCNzmOHM/PXHcqntfz/QRQO74N+4h54lHprmH/qrBgMdt+ZUqBc7Mi+7nWmII1Yai6Hl/5kLliuPnbYtCDO8L7TMUckqpf3T4UdgBVW2Z4MkWn6qJdAA1XoaG5BaxWhuhu4/mCiLtw3CA4Z5fVNMYDUAogC5mGqIkYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNQwpjpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA5AC4CEEB;
	Mon, 18 Aug 2025 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755507935;
	bh=vPUErYbWGmNKxPxliyJVPTXbvWnb22hHtW7n+fRfO2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNQwpjpRulUDez2+KKdE1mtVLN8u75gAEGBFGNYMqcUhcDsvnoUp+EeBtBaq/Tk+b
	 zSW30CPVBKB1eS/2O2Fm5OvGimQ+CvltFn09SAh9r8U04CVXmAGoF1B1FdTTRMmQf6
	 vmg3ZOOjGfcb7/YWE6w6WJ4S10e9PlAXY0H0uvgQYqBM+BJc5Fd6EkDI3O6vomcvQC
	 0bYEUlilK9/3UicTXbtCIm9RZVMWJydEAsyavIV/B49I40vm+cdt2Y1MBIew1HHyr3
	 XbAbcQAQJxAZMQnZIk1a/WfK+jknTGVYHCPby+QkO3mgDsGeyQ3FRvb0/Uhi87cCKX
	 zBreGL3foGLbw==
Date: Mon, 18 Aug 2025 11:05:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v13 04/10] pwm: max7360: Add MAX7360 PWM support
Message-ID: <l5crrk3ugpo2ggjtykcy5eretclgntebyq52xuouekoimbrsvh@u4koyu5z2wwi>
References: <20250811-mdb-max7360-support-v13-0-e79fcabff386@bootlin.com>
 <20250811-mdb-max7360-support-v13-4-e79fcabff386@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f5yur2tjb4sfvpro"
Content-Disposition: inline
In-Reply-To: <20250811-mdb-max7360-support-v13-4-e79fcabff386@bootlin.com>


--f5yur2tjb4sfvpro
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v13 04/10] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

Hello,

On Mon, Aug 11, 2025 at 12:46:22PM +0200, Mathieu Dubois-Briand wrote:
> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
>=20
> Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
> 8 independent PWM outputs.
>=20
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/Kconfig       |  10 +++
>  drivers/pwm/Makefile      |   1 +
>  drivers/pwm/pwm-max7360.c | 209 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 220 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index f00ce973dddf..f2b1ce47de7f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -432,6 +432,16 @@ config PWM_LPSS_PLATFORM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-lpss-platform.
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
>  config PWM_MC33XS2410
>  	tristate "MC33XS2410 PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index ff4f47e5fb7a..dfa8b4966ee1 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+=3D pwm-lpc32xx.o
>  obj-$(CONFIG_PWM_LPSS)		+=3D pwm-lpss.o
>  obj-$(CONFIG_PWM_LPSS_PCI)	+=3D pwm-lpss-pci.o
>  obj-$(CONFIG_PWM_LPSS_PLATFORM)	+=3D pwm-lpss-platform.o
> +obj-$(CONFIG_PWM_MAX7360)	+=3D pwm-max7360.o
>  obj-$(CONFIG_PWM_MC33XS2410)	+=3D pwm-mc33xs2410.o
>  obj-$(CONFIG_PWM_MEDIATEK)	+=3D pwm-mediatek.o
>  obj-$(CONFIG_PWM_MESON)		+=3D pwm-meson.o
> diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
> new file mode 100644
> index 000000000000..5a0c10d2320e
> --- /dev/null
> +++ b/drivers/pwm/pwm-max7360.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2025 Bootlin
> + *
> + * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
> + * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> + *
> + * PWM functionality of the MAX7360 multi-function device.
> + * https://www.analog.com/media/en/technical-documentation/data-sheets/M=
AX7360.pdf
> + *
> + * Limitations:
> + * - Only supports normal polarity.
> + * - The period is fixed to 2 ms.
> + * - Only the duty cycle can be changed, new values are applied at the b=
eginning
> + *   of the next cycle.
> + * - When disabled, the output is put in Hi-Z immediately.
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
> +#define MAX7360_PWM_MAX				255
> +#define MAX7360_PWM_STEPS			256
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
> +	/*
> +	 * Make sure we use the individual PWM configuration register and not
> +	 * the global one.
> +	 * We never need to use the global one, so there is no need to revert
> +	 * that in the .free() callback.
> +	 */
> +	return regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
> +				 MAX7360_PORT_CFG_COMMON_PWM, 0);
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
> +	 * Values from 0 to 254 as duty_steps will provide duty cycles of 0/256
> +	 * to 254/256, while value 255 will provide a duty cycle of 100%.
> +	 */
> +	if (wf->duty_length_ns >=3D MAX7360_PWM_PERIOD_NS) {
> +		duty_steps =3D MAX7360_PWM_MAX;
> +	} else {
> +		duty_steps =3D (u32)wf->duty_length_ns * MAX7360_PWM_STEPS / MAX7360_P=
WM_PERIOD_NS;
> +		if (duty_steps =3D=3D MAX7360_PWM_MAX)
> +			duty_steps =3D MAX7360_PWM_MAX - 1;
> +	}
> +
> +	wfhw->duty_steps =3D min(MAX7360_PWM_MAX, duty_steps);
> +	wfhw->enabled =3D !!wf->period_length_ns;
> +
> +	if (wf->period_length_ns < MAX7360_PWM_PERIOD_NS)

I know this code was suggested as is by me, but I think we need:

	if (wf->period_length_ns && wf->period_length_ns < MAX7360_PWM_PERIOD_NS)

here to prevent to trigger a PWM_DEBUG warning. Sorry to spot this only
now.

> +		return 1;
> +	else
> +		return 0;
> +}

Best regards
Uwe

--f5yur2tjb4sfvpro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmii7NkACgkQj4D7WH0S
/k5D8wf9GBIjiwJiHOnPpVDsuFnX8sxtuJdUua7aE1rqfhF/xgF9iV8F9B20QvX2
eBP2xYJ3wgAuICwvYFKZO5GvS3axiblep6ptsGS9Rl9PBgMSchCcaqPLguzHm/6T
SNtAuW6vQZ8dph7yzaMcLA6GCGTPd5PytE5WXIssrYlfHDBAw4UIcTTE1v4oh1g6
1V6vlfC+bmQHa73IlG/CChUlN4x/ZIfs1jUqKnSOpIMCdWaY4DiBJ3YF0SYUFvny
V75ilLDG25R3Dz5iVkcMYWImrdLAQwem1yBkdvsykjQHcNOB0susXmEVpw3UmxCR
sDbWK5JFIwOD7kRJ5T9o+blRHyRvjw==
=UJjy
-----END PGP SIGNATURE-----

--f5yur2tjb4sfvpro--

