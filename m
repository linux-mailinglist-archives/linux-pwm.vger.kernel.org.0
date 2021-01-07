Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9EF2ED22B
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Jan 2021 15:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbhAGObH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 7 Jan 2021 09:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbhAGObH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Jan 2021 09:31:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E9FC0612F5
        for <linux-pwm@vger.kernel.org>; Thu,  7 Jan 2021 06:30:26 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kxWIe-0003jA-66; Thu, 07 Jan 2021 15:30:04 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kxWIV-0000VA-Pp; Thu, 07 Jan 2021 15:29:55 +0100
Date:   Thu, 7 Jan 2021 15:29:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/4] gpio: mvebu: fix pwm get_state period calculation
Message-ID: <20210107142953.ifg5yuy3dsblgsju@pengutronix.de>
References: <cover.1609917364.git.baruch@tkos.co.il>
 <22d1fe7b2137e3a2660ab2e6f1f127d41493fb16.1609917364.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ks3fthzfzjkbbgmh"
Content-Disposition: inline
In-Reply-To: <22d1fe7b2137e3a2660ab2e6f1f127d41493fb16.1609917364.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ks3fthzfzjkbbgmh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 06, 2021 at 09:37:37AM +0200, Baruch Siach wrote:
> The period is the sum of on and off values.
>=20
> Reported-by: Russell King <linux@armlinux.org.uk>
> Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> v6: divide (on + off) sum to reduce rounding error (RMK)
> ---
>  drivers/gpio/gpio-mvebu.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 672681a976f5..a912a8fed197 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -676,20 +676,17 @@ static void mvebu_pwm_get_state(struct pwm_chip *ch=
ip,
>  	else
>  		state->duty_cycle =3D 1;
> =20
> +	val =3D (unsigned long long) u; /* on duration */
>  	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
> -	val =3D (unsigned long long) u * NSEC_PER_SEC;
> +	val +=3D (unsigned long long) u; /* period =3D on + off duration */
> +	val *=3D NSEC_PER_SEC;
>  	do_div(val, mvpwm->clk_rate);
> -	if (val < state->duty_cycle) {
> +	if (val > UINT_MAX)
> +		state->period =3D UINT_MAX;

state->period is an u64, so there is no reason to not use values greater
than UINT_MAX.

> +	else if (val)
> +		state->period =3D val;
> +	else
>  		state->period =3D 1;

This case assigning 1 looks strange. An explanation in a comment would
be great. I wonder if this is a hardware property or if it is only used
to not report 0 in case that mvpwm->clk_rate is high.

I found a few further shortcommings in the mvebu_pwm implementation while
looking through it:

 a) The rounding problem that RMK found is also present in .apply

    There we have:

    	val =3D clk_rate * (period - duty_cycle) / NSEC_PER_SEC

    while

    	val =3D clk_rate * period / NSEC_PER_SEC - on

    would be more exact.

 b) To make

 	pwm_get_state(pwm, &state);
	pwm_apply_state(pwm, &state);

    idempotent .get_state should round up the division results.

 c) .apply also has a check for val being zero and configures at least 1
    cycle for the on and off intervals. Is this a hardware imposed
    limitation?=20

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ks3fthzfzjkbbgmh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/3Gt4ACgkQwfwUeK3K
7AmqFwf/eYT5rulDQlSUn8MsOkXYy7NLmfZcRfU/HdExqVyhJv8sxtYPdWfdGzxx
ev8bGjQtylhb4fh0eSvq6LZTdvaxEOFXCO7BrE5CG8Qw4I4a6Av08ypNatSbub7d
wreWhjuB+lVdiYOKAxOXKeKIpHPi9TKRCr2oOnBb1VP2hN5k5WdXnMRqleZerALG
AdNVRdveRwG1Sii80z1XL2WdSDM+DdPMv48Ustct1KzHGXweN2GfNueaoTrvA4s4
OshvyGv/pSYKzCxols4HKScQ2cD6QT4XcovNytSaH1eLkeQ8Y7xkXYIllZ+hZ7hU
k9xrblYpXwOgA2R/1Hp1VQIgPfqfdQ==
=yjYP
-----END PGP SIGNATURE-----

--ks3fthzfzjkbbgmh--
