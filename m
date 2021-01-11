Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4AA2F208D
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 21:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388548AbhAKUS2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 15:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391503AbhAKUS1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2021 15:18:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3691C061786
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jan 2021 12:17:46 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3d5-0006pf-QB; Mon, 11 Jan 2021 21:17:31 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz3cm-0001oG-1F; Mon, 11 Jan 2021 21:17:12 +0100
Date:   Mon, 11 Jan 2021 21:17:11 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>, g@pengutronix.de
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
Subject: Re: [PATCH 1/5] gpio: mvebu: fix pwm get_state period calculation
Message-ID: <20210111201711.ym46w7dy62ux66zb@pengutronix.de>
References: <cover.1610362661.git.baruch@tkos.co.il>
 <e3afc6e297e495322971c26a79c6f841d5952fd1.1610362661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sbfrqob34qguvdht"
Content-Disposition: inline
In-Reply-To: <e3afc6e297e495322971c26a79c6f841d5952fd1.1610362661.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--sbfrqob34qguvdht
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Baruch,

$Subject ~=3D s/get_state/.get_state/ ?

On Mon, Jan 11, 2021 at 01:17:02PM +0200, Baruch Siach wrote:
> The period is the sum of on and off values.
>=20
> Reported-by: Russell King <linux@armlinux.org.uk>
> Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
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
> +	else if (val)
> +		state->period =3D val;
> +	else
>  		state->period =3D 1;
> -	} else {
> -		val -=3D state->duty_cycle;
> -		if (val > UINT_MAX)
> -			state->period =3D UINT_MAX;
> -		else if (val)
> -			state->period =3D val;
> -		else
> -			state->period =3D 1;
> -	}

The patch looks good, the patch description could be a bit more verbose.
Something like:

	Calculate the period as

		($on + $off) / clkrate

	instead of

		$off / clkrate - $on / clkrate

	.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--sbfrqob34qguvdht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/8skQACgkQwfwUeK3K
7Alzogf+KPPg546GsrokpTE2wlvllmFTgHygaAWs0ZXan8lWTdaN0bFHLvt1FF24
f8b8auIDDRkqJjkATM7hByvyU8Dh7JKG9Uc4/YJ0Fba6t9bdRZFjJRE4rCycgcK1
+8PmLZFgx4YA9h7qcNJm3te7Q1JOuZigmQffuxbzlVc0/q5kKkbtkhIbCY0dpGvH
ShuxJo3Rz4vdq6lnyaT1oadkz6kVfAj3BTtpAbUAx4/O8cwnQOtIZTeQCCMuFqDG
ms+vCmfNgQ6pMxFz51i+XNLNbrk54Dq/9HcnJ2oD6KWR/aG0tmYPWVcjIqEBwwpN
Dqii+4ngHXKSJEsdnIJnSdjdkzfU7w==
=iOoM
-----END PGP SIGNATURE-----

--sbfrqob34qguvdht--
