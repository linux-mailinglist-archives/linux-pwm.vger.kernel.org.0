Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EE425A61E
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 09:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIBHHa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 03:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIBHHa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 03:07:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9712BC061244
        for <linux-pwm@vger.kernel.org>; Wed,  2 Sep 2020 00:07:29 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMrd-0002tV-RO; Wed, 02 Sep 2020 09:07:25 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDMrc-0007KR-Fc; Wed, 02 Sep 2020 09:07:24 +0200
Date:   Wed, 2 Sep 2020 09:07:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH v2 3/3] drivers: pwm: pwm-pca9685.c: Disable unused
 alternative addresses
Message-ID: <20200902070724.27l64r2ri66srjam@pengutronix.de>
References: <20200828121415.1292388-1-david@protonic.nl>
 <20200828121415.1292388-4-david@protonic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tod22mzyjzpq3woh"
Content-Disposition: inline
In-Reply-To: <20200828121415.1292388-4-david@protonic.nl>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tod22mzyjzpq3woh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2020 at 02:14:15PM +0200, David Jander wrote:
> The PCA9685 supports listening to 1 or more alternative I2C chip addresses
> for some special features that this driver does not support.
> By default the LED ALLCALL address is active (default 0x70), which causes
> this chip to respond to address 0x70 in addition to its main address
> (0x41). This is not desireable if there is another device on the same bus
> that uses this address (like a TMP103 for example).
> Since this feature is not supported by this driver, it is best to disable
> these addresses in the chip to avoid unsuspected bus collisions.

Is this feature on by default? If the feature is on during boot and the
device at address 0x70 is tryed to probe first, this is unfortunate. (In
this case you might want to disable this feature in the bootloader, too.)
=20
> Signed-off-by: David Jander <david@protonic.nl>
> ---
>  drivers/pwm/pwm-pca9685.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 9d1d9dece0c0..ca7d205d6130 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -58,6 +58,10 @@
>  #define PCA9685_MAXCHAN		0x10
> =20
>  #define LED_FULL		BIT(4)
> +#define MODE1_ALLCALL		BIT(0)
> +#define MODE1_SUB3		BIT(1)
> +#define MODE1_SUB2		BIT(2)
> +#define MODE1_SUB1		BIT(3)
>  #define MODE1_SLEEP		BIT(4)
>  #define MODE2_INVRT		BIT(4)
>  #define MODE2_OUTDRV		BIT(2)
> @@ -444,7 +448,7 @@ static int pca9685_pwm_probe(struct i2c_client *clien=
t,
>  {
>  	struct pca9685 *pca;
>  	int ret;
> -	int mode2;
> +	int reg;

This rename makes the patch considerably bigger. I'd expect you can just
add a mode1 variable, use this to access the MODE1 register and still
get the same compiler output. If so, I'd prefer this way.

>  	pca =3D devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
>  	if (!pca)
> @@ -461,19 +465,24 @@ static int pca9685_pwm_probe(struct i2c_client *cli=
ent,
> =20
>  	i2c_set_clientdata(client, pca);
> =20
> -	regmap_read(pca->regmap, PCA9685_MODE2, &mode2);
> +	regmap_read(pca->regmap, PCA9685_MODE2, &reg);
> =20
>  	if (device_property_read_bool(&client->dev, "invert"))
> -		mode2 |=3D MODE2_INVRT;
> +		reg |=3D MODE2_INVRT;
>  	else
> -		mode2 &=3D ~MODE2_INVRT;
> +		reg &=3D ~MODE2_INVRT;
> =20
>  	if (device_property_read_bool(&client->dev, "open-drain"))
> -		mode2 &=3D ~MODE2_OUTDRV;
> +		reg &=3D ~MODE2_OUTDRV;
>  	else
> -		mode2 |=3D MODE2_OUTDRV;
> +		reg |=3D MODE2_OUTDRV;
> =20
> -	regmap_write(pca->regmap, PCA9685_MODE2, mode2);
> +	regmap_write(pca->regmap, PCA9685_MODE2, reg);
> +
> +	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
> +	regmap_read(pca->regmap, PCA9685_MODE1, &reg);
> +	reg &=3D ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
> +	regmap_write(pca->regmap, PCA9685_MODE1, reg);
> =20
>  	/* Clear all "full off" bits */
>  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tod22mzyjzpq3woh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9PRKkACgkQwfwUeK3K
7Ak3owf/Up0SwMwZYR/W3WA2AgMjVP6JN5gS0ulMOwBz1ws0N6UyCmekUKUQO2wF
/2+X7lVEDGT9T5yXD5VlNs+bS5rf5nieufUF0ZHX4pG03eZRlwZShW5LsRCK9uRZ
pZ5+3a9sn2UrCk1rUiHv9c+pnNdbr9wEt5DKG/5FvH4LzFPZQldqdUz86cKAhJnO
IONRVof8I+fKTqhCZa9ECMPa1/BQC7rNxIurZR5sihbNqY9KYjoqstztWnOf+u8U
08Do5dnFyd66XEqF4kvcfg4TcisU11lpJW5rvU42Mk1hml4EhH5wKOyoLIcqCU1S
Pch8Ar4g+sk3Ab+AzM1gdS20gd4NvA==
=5lW7
-----END PGP SIGNATURE-----

--tod22mzyjzpq3woh--
