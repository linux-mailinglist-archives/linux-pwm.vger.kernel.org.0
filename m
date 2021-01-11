Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367442F209B
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 21:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403784AbhAKUVU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 15:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390690AbhAKUVS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2021 15:21:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444D6C061786
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jan 2021 12:20:38 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3g1-00078g-AQ; Mon, 11 Jan 2021 21:20:33 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3fq-0001wi-3j; Mon, 11 Jan 2021 21:20:22 +0100
Date:   Mon, 11 Jan 2021 21:20:21 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] gpio: mvebu: make pwm apply/get_state closer to
 idempotent
Message-ID: <20210111202021.bspxeo73co7vxk6x@pengutronix.de>
References: <cover.1610362661.git.baruch@tkos.co.il>
 <1c8864722e4c74d1d8d5d4a213998a1672be9992.1610362661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a7urpazil2brnwq7"
Content-Disposition: inline
In-Reply-To: <1c8864722e4c74d1d8d5d4a213998a1672be9992.1610362661.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--a7urpazil2brnwq7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 01:17:04PM +0200, Baruch Siach wrote:
> Round up the result of division in period/duty_cycle calculation to make
> the result closer to idempotent.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/gpio-mvebu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index c424d88e9e2b..6fc64846eda3 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -668,7 +668,7 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
> =20
>  	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), &u);
>  	val =3D (unsigned long long) u * NSEC_PER_SEC;
> -	do_div(val, mvpwm->clk_rate);
> +	val =3D DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
>  	if (val > UINT_MAX)
>  		state->duty_cycle =3D UINT_MAX;
>  	else if (val)
> @@ -680,7 +680,7 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
>  	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
>  	val +=3D (unsigned long long) u; /* period =3D on + off duration */
>  	val *=3D NSEC_PER_SEC;
> -	do_div(val, mvpwm->clk_rate);
> +	val =3D DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
>  	if (val > UINT_MAX)
>  		state->period =3D UINT_MAX;
>  	else if (val)
> @@ -707,7 +707,7 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  	unsigned int on, off;
> =20
>  	val =3D (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
> -	do_div(val, NSEC_PER_SEC);
> +	val =3D DIV_ROUND_UP_ULL(val, NSEC_PER_SEC);

=2Eapply must continue to round down.

Best regards
Uwe

>  	if (val > UINT_MAX)
>  		return -EINVAL;
>  	if (val)
> @@ -716,7 +716,7 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
>  		on =3D 1;
> =20
>  	val =3D (unsigned long long) mvpwm->clk_rate * state->period;
> -	do_div(val, NSEC_PER_SEC);
> +	val =3D DIV_ROUND_UP_ULL(val, NSEC_PER_SEC);
>  	val -=3D on;
>  	if (val > UINT_MAX)
>  		return -EINVAL;
> --=20
> 2.29.2
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--a7urpazil2brnwq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/8swIACgkQwfwUeK3K
7AnUFgf/cVI70lShvO/O233g28jfUwhO/cpDFR63OLhrVPy3APWDvCdcgR8zRnzT
sXl8o3w1Kw61JjBKDb1PiR3mA5qRAhQrZiobnxyXgYignZm2zNY6UB34rdNbI1Bp
O5PJY3XXnMg88+euHRNnlgLTv53m2iU7vnDixJR/KDZyT87lbmeb5TtQ+gd0wgv9
Jnol3MKQmsIUZNitUl+VYfXeddICJJXkNKj6SQSTgjZVPtwUnIfmzbDji81W5Xbe
eoyz3p6FR4COfD+ROnMyOkVplW/m9VSbyvoBSTO1EfipwgoARjNjAjd4OHP0B0N2
KuIncPl+dDYJhNcpza9Ot/8IkzUgyA==
=1bVW
-----END PGP SIGNATURE-----

--a7urpazil2brnwq7--
