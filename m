Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C2034D45B
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 17:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbhC2P4G (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 11:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhC2Pzc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 11:55:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B8C061574
        for <linux-pwm@vger.kernel.org>; Mon, 29 Mar 2021 08:55:30 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQuEh-00076z-Qe; Mon, 29 Mar 2021 17:55:27 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQuEh-0001hX-HH; Mon, 29 Mar 2021 17:55:27 +0200
Date:   Mon, 29 Mar 2021 17:55:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] pwm: pca9685: Improve runtime PM behavior
Message-ID: <20210329155527.q3o25ubh33pmszsi@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-3-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="anui7dfz743pecr5"
Content-Disposition: inline
In-Reply-To: <20210329125707.182732-3-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--anui7dfz743pecr5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 02:57:03PM +0200, Clemens Gruber wrote:
> The chip does not come out of POR in active state but in sleep state.
> To be sure (in case the bootloader woke it up) we force it to sleep in
> probe.
>=20
> On kernels without CONFIG_PM, we wake the chip in .probe and put it to
> sleep in .remove.

What is the effect of sleep state? Does it continue to oscilate it the
bootloader set up some configuration?


> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index fb026a25fb61..4d6684b90819 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -469,14 +469,19 @@ static int pca9685_pwm_probe(struct i2c_client *cli=
ent,
>  		return ret;
>  	}
> =20
> -	/* The chip comes out of power-up in the active state */
> -	pm_runtime_set_active(&client->dev);
>  	/*
> -	 * Enable will put the chip into suspend, which is what we
> -	 * want as all outputs are disabled at this point
> +	 * The chip comes out of power-up in the sleep state,
> +	 * but force it to sleep in case it was woken up before
>  	 */
> +	pca9685_set_sleep_mode(pca, true);
> +	pm_runtime_set_suspended(&client->dev);
>  	pm_runtime_enable(&client->dev);
> =20
> +	if (!IS_ENABLED(CONFIG_PM)) {
> +		/* Wake the chip up on non-PM environments */
> +		pca9685_set_sleep_mode(pca, false);

I admit I didn't grasp all the PM framework details, but I wonder if
it's right to first call set_sleep_mode(true) and then in some cases to
false again.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--anui7dfz743pecr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBh+GwACgkQwfwUeK3K
7AkbOggAjYvZJ4yGp4lADVNTwgOi0pKpb9Dp/MLD1RJO3uK16kZsTD5MQu2W/5hu
wlxYxQ4E2C0cBKwq6dpphiCf2aC+wdF91SQx+ylH1jsLoDVwsVRISHre62252aRI
6ph+w1/xoi3taNeLwB4g6Bt7/c7nKz1nFope2UJuMRvD5yq6WykfBkVvygpOxs9q
I7OQuzb2swBYCRm5TVaZeU6M96yZDzqEuLoiXD3PqbsoDxjqZ5axt4cgiVUb1PTr
o5xbGzjthqNZd8V1BjkBQ4cHHlZy1YO0VSiTlvTPSyu3j7zwrXTQjJODNbOOluxS
OXXMPJvHfZY8h1KJvSVjlvEz32FBkA==
=aroP
-----END PGP SIGNATURE-----

--anui7dfz743pecr5--
