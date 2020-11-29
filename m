Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690D22C7A78
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Nov 2020 19:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgK2SLm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Nov 2020 13:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgK2SLm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Nov 2020 13:11:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C7C0613D2
        for <linux-pwm@vger.kernel.org>; Sun, 29 Nov 2020 10:11:02 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjR9z-0001or-Hl; Sun, 29 Nov 2020 19:10:55 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kjR9y-0004rr-Ee; Sun, 29 Nov 2020 19:10:54 +0100
Date:   Sun, 29 Nov 2020 19:10:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5swyij2tuuhknhdb"
Content-Disposition: inline
In-Reply-To: <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5swyij2tuuhknhdb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2020 at 01:02:06PM +0100, Lino Sanfilippo wrote:
> Use the newer apply function of pwm_ops instead of config, enable, disable
> and set_polarity.
>=20
> This guarantees atomic changes of the pwm controller configuration. It al=
so
> reduces the size of the driver.
>=20
> This has been tested on a Raspberry PI 4.
>=20
> v2: Fixed compiler error

Changelog between review rounds go to below the tripple-dash below.

> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
>  drivers/pwm/pwm-bcm2835.c | 64 ++++++++++++++++-------------------------=
------
>  1 file changed, 21 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
> index 6841dcf..dad7443 100644
> --- a/drivers/pwm/pwm-bcm2835.c
> +++ b/drivers/pwm/pwm-bcm2835.c
> @@ -58,13 +58,14 @@ static void bcm2835_pwm_free(struct pwm_chip *chip, s=
truct pwm_device *pwm)
>  	writel(value, pc->base + PWM_CONTROL);
>  }
> =20
> -static int bcm2835_pwm_config(struct pwm_chip *chip, struct pwm_device *=
pwm,
> -			      int duty_ns, int period_ns)
> +static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
> +			     const struct pwm_state *state)
>  {
> +
>  	struct bcm2835_pwm *pc =3D to_bcm2835_pwm(chip);
>  	unsigned long rate =3D clk_get_rate(pc->clk);
>  	unsigned long scaler;
> -	u32 period;
> +	u32 value;
> =20
>  	if (!rate) {
>  		dev_err(pc->dev, "failed to get clock rate\n");
> @@ -72,65 +73,42 @@ static int bcm2835_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  	}
> =20
>  	scaler =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);
> -	period =3D DIV_ROUND_CLOSEST(period_ns, scaler);
> +	/* set period */
> +	value =3D DIV_ROUND_CLOSEST_ULL(state->period, scaler);

You're storing an unsigned long long (i.e. 64 bits) in an u32. If you
are sure that this won't discard relevant bits, please explain this in a
comment for the cursory reader.

Also note that round_closed is probably wrong, as .apply() is supposed
to round down the period to the next achievable period. (But fixing this
has to do done in a separate patch.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5swyij2tuuhknhdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/D5CcACgkQwfwUeK3K
7AnJDwf9E/ryrmjtun7VJxEEtA3dKXzqCwdvNxUnoWdwundHkyX78y8CpI5guv/w
1LQrUnpqqVGCuLPihnF5cpjtcxprC2SbShCgZBErumoVoC0n4ZYb3j+z0ld/p9d6
ff4VlBmYjf5Wpzoq347N5d0tTsq6M0+GknYOtc4SIuEDkOqoUhROg/+MkYvdMZES
wBS/9vWTD6SX0OnXa7DPRon8P0INQmcCYcJkOHrIsQeUiTQJfh+Ux/McwmI9yxFv
zXBL0vsViZ79V3U08p9XMQ+E7LCJMqfcqFQKlmuP1ARgo1Z5hxpnDQREaU9+rEaj
5vJPYJlb7qFzisCGSkEpgY+Fjhw5KA==
=T3ed
-----END PGP SIGNATURE-----

--5swyij2tuuhknhdb--
