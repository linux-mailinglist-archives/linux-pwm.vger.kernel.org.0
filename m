Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16624287AE
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Oct 2021 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhJKHeB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Oct 2021 03:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhJKHeB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Oct 2021 03:34:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7382CC061570
        for <linux-pwm@vger.kernel.org>; Mon, 11 Oct 2021 00:32:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZpml-00021n-DJ; Mon, 11 Oct 2021 09:31:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZpme-0003JX-Rz; Mon, 11 Oct 2021 09:31:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mZpme-0007mP-Qf; Mon, 11 Oct 2021 09:31:40 +0200
Date:   Mon, 11 Oct 2021 09:31:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v12 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20211011073138.rofxayep6p47zrc6@pengutronix.de>
References: <20210906024339.21124-1-billy_tsai@aspeedtech.com>
 <20210906024339.21124-3-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yedmwtf2izpi2vro"
Content-Disposition: inline
In-Reply-To: <20210906024339.21124-3-billy_tsai@aspeedtech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yedmwtf2izpi2vro
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 06, 2021 at 10:43:39AM +0800, Billy Tsai wrote:
> This patch add the support of PWM controller which can be found at aspeed
> ast2600 soc. The pwm supoorts up to 16 channels and it's part function
> of multi-function device "pwm-tach controller".
>=20
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/pwm/Kconfig              |  10 +
>  drivers/pwm/Makefile             |   1 +
>  drivers/pwm/pwm-aspeed-ast2600.c | 327 +++++++++++++++++++++++++++++++
>  3 files changed, 338 insertions(+)
>  create mode 100644 drivers/pwm/pwm-aspeed-ast2600.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 63be5362fd3a..b0d26f6c2a8f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -51,6 +51,16 @@ config PWM_AB8500
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-ab8500.
> =20
> +config PWM_ASPEED_AST2600
> +	tristate "Aspeed ast2600 PWM support"
> +	depends on ARCH_ASPEED || COMPILE_TEST
> +	depends on HAVE_CLK && HAS_IOMEM
> +	help
> +	  This driver provides support for Aspeed ast2600 PWM controllers.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-aspeed-ast2600.
> +
>  config PWM_ATMEL
>  	tristate "Atmel PWM support"
>  	depends on OF
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index cbdcd55d69ee..ada454f9129a 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_SYSFS)		+=3D sysfs.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
> +obj-$(CONFIG_PWM_ASPEED_AST2600)	+=3D pwm-aspeed-ast2600.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
>  obj-$(CONFIG_PWM_ATMEL_TCB)	+=3D pwm-atmel-tcb.o
> diff --git a/drivers/pwm/pwm-aspeed-ast2600.c b/drivers/pwm/pwm-aspeed-as=
t2600.c
> new file mode 100644
> index 000000000000..e4507a503698
> --- /dev/null
> +++ b/drivers/pwm/pwm-aspeed-ast2600.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 Aspeed Technology Inc.
> + *
> + * PWM controller driver for Aspeed ast2600 SoCs.
> + * This drivers doesn't support earlier version of the IP.
> + *
> + * The formula of pwm period duration:
> + * period duration =3D ((DIV_L + 1) * (PERIOD + 1) << DIV_H) / input-clk
> + *
> + * The formula of pwm duty cycle duration:
> + * duty cycle duration =3D period duration * DUTY_CYCLE_FALLING_POINT / =
(PERIOD + 1)
> + * =3D ((DIV_L + 1) * DUTY_CYCLE_FALLING_POINT << DIV_H) / input-clk
> + *
> + * The software driver fixes the period to 255, which causes the high-fr=
equency
> + * precision of the PWM to be coarse, in exchange for the fineness of th=
e duty cycle.
> + *

=46rom reading this it's not clear (to me that is) what's the difference
between "period duration" and "PERIOD". Maybe rewrite the comment to
something like:

	The hardware operates in time quantities of length

		Q :=3D (DIV_L + 1) << DIV_H / input-clk

	The length of a PWM period is (DUTY_CYCLE_PERIOD + 1) * Q.
	The maximal value for DUTY_CYCLE_PERIOD is used here to provide
	a fine grained selection for the duty cycle.

	This driver uses DUTY_CYCLE_RISING_POINT =3D 0, so from the start of a
	period the output is active until DUTY_CYCLE_FALLING_POINT * Q. Note
	that if DUTY_CYCLE_RISING_POINT =3D DUTY_CYCLE_FALLING_POINT the output is
	always active.

This is a bit more high-level and still gives all the details.

Maybe the special case with DUTY_CYCLE_RISING_POINT =3D
DUTY_CYCLE_FALLING_POINT would be a bit more natural if the driver used
inverse logic: Assume the output to be inverted with CTRL_INVERSE =3D 0,
fix DUTY_CYCLE_FALLING_POINT to 0 and adapt DUTY_CYCLE_RISING_POINT
dependant on duty cycle? At least then DUTY_CYCLE_RISING_POINT =3D 0
corresponds to duty_cycle =3D 0. Just an idea ... which might or might not
work depending on the hardware.

> + * Register usage:
> + * PIN_ENABLE: When it is unset the pwm controller will emit inactive le=
vel to the extern.
> + * Use to determine whether the PWM channel is enabled or disabled
> + * CLK_ENABLE: When it is unset the pwm controller will assert the duty =
counter reset and
> + * emit inactive level to the PIN_ENABLE mux after that the driver can s=
till change the pwm period
> + * and duty and the value will apply when CLK_ENABLE be set again.
> + * Use to determine whether duty_cycle bigger than 0.
> + * PWM_ASPEED_CTRL_INVERSE: When it is toggled the output value will inv=
erse immediately.
> + * PWM_ASPEED_DUTY_CYCLE_FALLING_POINT/PWM_ASPEED_DUTY_CYCLE_RISING_POIN=
T: When these two
> + * values are equal it means the duty cycle =3D 100%.
> + *
> + * The glitch may generate at:
> + * - Enabled changing when the duty_cycle bigger than 0% and less than 1=
00%.
> + * - Polarity changing when the duty_cycle bigger than 0% and less than =
100%.
> + * - Set duty cycle to 0% from other values.
> + *
> + * Limitations:
> + * - When changing both duty cycle and period, we cannot prevent in
> + *   software that the output might produce a period with mixed
> + *   settings.
> + * - Disabling the PWM doesn't complete the current period.
> + *
> + * Improvements:
> + * - When only changing one of duty cycle or period, our pwm controller =
will not
> + *   generate the glitch, the configure will change at next cycle of pwm.
> + *   This improvement can disable/enable through PWM_ASPEED_CTRL_DUTY_SY=
NC_DISABLE.
> + */
> +
> [...]
> +static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct device *dev =3D chip->dev;
> +	struct aspeed_pwm_data *priv =3D aspeed_pwm_chip_to_data(chip);
> +	u32 hwpwm =3D pwm->hwpwm, duty_pt;
> +	unsigned long rate;
> +	u64 div_h, div_l, divisor;
> +	bool clk_en;
> +
> +	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns", state->period,
> +		state->duty_cycle);
> +
> +	rate =3D clk_get_rate(priv->clk);
> +	if (state->period > div64_u64(ULLONG_MAX, (u64)rate))
> +		return -ERANGE;

Given that the biggest possible period <=3D requested period should be
configured, this check + return is wrong.

> +	/*
> +	 * Pick the smallest value for div_h so that div_l can be the biggest
> +	 * which results in a finer resolution near the target period value.
> +	 */
> +	divisor =3D (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
> +		  (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
> +	div_h =3D order_base_2(DIV64_U64_ROUND_UP(rate * state->period, divisor=
));
> +	if (div_h > 0xf)
> +		div_h =3D 0xf;
> +
> +	divisor =3D ((u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1)) << div_=
h;
> +	div_l =3D div64_u64(rate * state->period, divisor);
> +
> +	if (div_l =3D=3D 0)
> +		return -ERANGE;
> +
> +	div_l -=3D 1;
> +
> +	if (div_l > 255)
> +		div_l =3D 255;
> +
> + [...]

I didn't check the remaining part here in detail, it does look right and
I think we already discussed this in the earlier revisions.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yedmwtf2izpi2vro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFj6FcACgkQwfwUeK3K
7Amp1QgAoX+pmbfrkAp6L86xmjjYiGH0g4aGp+iO0LZSybNiemKmoezrZg/JmEfU
9ppyxw/XhFudTmO3f/EtaoHDuys7C8qDK/26IT3mXp7hH6hImQ4yNZjAU2BsvNT9
CEjX5Mmz4YkyRl9tMOt7cCumU1An1Br0xbjJQizuaEZe7k4Ef64YHHmppzboCKxP
NiFUM9gWTUzUio2DqP1FRPWLb8ETavKQ1T5GTK+XwIIjICmIT0RS/M0Q2ir8bWeL
BfacRjilzdzdo2ySCS1ARrzEZ5seEWnNyNsRLvXxVP8gn1aL8TWhKSsQM5EJH3Ts
zk2YnlBf5kn3FTbTyDnWQe2s+ClC+Q==
=hbqw
-----END PGP SIGNATURE-----

--yedmwtf2izpi2vro--
