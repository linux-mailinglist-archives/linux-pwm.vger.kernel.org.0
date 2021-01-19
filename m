Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8BA2FC03D
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Jan 2021 20:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbhASTkn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Jan 2021 14:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbhASTkb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Jan 2021 14:40:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E949C061573
        for <linux-pwm@vger.kernel.org>; Tue, 19 Jan 2021 11:39:51 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1wql-0007Vp-Hz; Tue, 19 Jan 2021 20:39:35 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l1wqc-0000CL-3n; Tue, 19 Jan 2021 20:39:26 +0100
Date:   Tue, 19 Jan 2021 20:39:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 5/5] gpio: mvebu: improve handling of pwm zero on/off
 values
Message-ID: <20210119193925.xcqr6owx7nf4h63l@pengutronix.de>
References: <cover.1610882271.git.baruch@tkos.co.il>
 <065aa239ba7e10b64f1c563aba08626f5de790ba.1610882271.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jsctpgqt2dlm4ahi"
Content-Disposition: inline
In-Reply-To: <065aa239ba7e10b64f1c563aba08626f5de790ba.1610882271.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jsctpgqt2dlm4ahi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Baruch,

On Sun, Jan 17, 2021 at 03:17:06PM +0200, Baruch Siach wrote:
> Hardware appears to treat zero value as 2^32. Take advantage of this
> fact to support on/off values of up to UINT_MAX+1 =3D=3D 2^32. Adjust both
> .apply and .get_sate to handle zero as a special case.

s/get_sate/get_state/

> Rounded up division result in .get_state can't be zero, since the
> dividend is now larger than 0. Remove check for this case.
>=20
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Analyzed-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/gpio-mvebu.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 6b017854ce61..37f5bd65062f 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -667,22 +667,20 @@ static void mvebu_pwm_get_state(struct pwm_chip *ch=
ip,
>  	spin_lock_irqsave(&mvpwm->lock, flags);
> =20
>  	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), &u);
> -	val =3D (unsigned long long) u * NSEC_PER_SEC;
> -	val =3D DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
> -	if (val)
> -		state->duty_cycle =3D val;
> +	/* Hardware treats zero as 2^32. See mvebu_pwm_apply(). */
> +	if (u > 0)
> +		val =3D (unsigned long long) u * NSEC_PER_SEC;
>  	else
> -		state->duty_cycle =3D 1;
> +		val =3D ((unsigned long long) UINT_MAX+1) * NSEC_PER_SEC;
> +	state->duty_cycle =3D DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);

Instead of

	if (u > 0)
		val =3D (unsigned long long) u * NSEC_PER_SEC;
	else
		val =3D ((unsigned long long) UINT_MAX+1) * NSEC_PER_SEC;

	state->duty_cycle =3D DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);

you could also write

	if (u > 0)
		val =3D u;
	else
		val =3D UINT_MAX + 1;

	state->duty_cycle =3D DIV_ROUND_UP_ULL(val * NSEC_PER_SEC, mvpwm->clk_rate=
);

which is a bit lighter (IMHO).

> =20
> -	val =3D (unsigned long long) u; /* on duration */
>  	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
> -	val +=3D (unsigned long long) u; /* period =3D on + off duration */
> -	val *=3D NSEC_PER_SEC;
> -	val =3D DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
> -	if (val)
> -		state->period =3D val;
> +	/* period =3D on + off duration */
> +	if (u > 0)
> +		val +=3D (unsigned long long) u * NSEC_PER_SEC;
>  	else
> -		state->period =3D 1;
> +		val +=3D ((unsigned long long) UINT_MAX+1) * NSEC_PER_SEC;
> +	state->period =3D DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);

> =20
>  	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset, &u);
>  	if (u)
> @@ -704,9 +702,15 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> =20
>  	val =3D (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
>  	do_div(val, NSEC_PER_SEC);
> -	if (val > UINT_MAX)
> +	if (val > (unsigned long long) UINT_MAX+1)

Please add whitespace around the +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jsctpgqt2dlm4ahi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAHNWoACgkQwfwUeK3K
7AnXjgf9EwtZ55HS0s52jx06kVWGpriRFGau/ipPimx3D5uMO1gXKxlWiqRpA2xp
yn3LutJ5nPW3E1zJZ243BcswZe3EEuyl3THD7nAvTlK/fwaBUmd/Tc0lPdTBYKAf
qZxb2IiX++LA4ATTLLWrxXeW52dRR8lD3CteidMra1tIUwXLKH/KDaHSwH7PCxzQ
Dgcu6u5IUMH0SoWHpqPagKLKSMgCaoY4M7C32AxQ1xMygFyVFCezQ0/r2/xWocF+
fjvCVut44wwSYH3uvYLJ4Es2ko9dp0GWFxbT/n3RFkDh739tMNYicYI29Fp0yLwm
fJIl6K4OFSLqnj4IckOr4vIJEq2Imw==
=xEsd
-----END PGP SIGNATURE-----

--jsctpgqt2dlm4ahi--
