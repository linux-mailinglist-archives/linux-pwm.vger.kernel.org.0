Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E403563CC
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 08:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbhDGGQd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 02:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbhDGGQb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 02:16:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6074C06174A
        for <linux-pwm@vger.kernel.org>; Tue,  6 Apr 2021 23:16:22 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU1UC-0005bW-LU; Wed, 07 Apr 2021 08:16:20 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU1UC-0004OE-31; Wed, 07 Apr 2021 08:16:20 +0200
Date:   Wed, 7 Apr 2021 08:16:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 8/8] pwm: pca9685: Add error messages for failed
 regmap calls
Message-ID: <20210407061619.fl6ffos6csvgtnjh@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-8-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vfnjmoawnycporzw"
Content-Disposition: inline
In-Reply-To: <20210406164140.81423-8-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--vfnjmoawnycporzw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 06:41:40PM +0200, Clemens Gruber wrote:
> Regmap operations can fail if the underlying subsystem is not working
> properly (e.g. hogged I2C bus, etc.)
> As this is useful information for the user, print an error message if it
> happens.
> Let probe fail if the first regmap_read or the first regmap_write fails.
>=20
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
> Changes since v6:
> - Rebased
>=20
>  drivers/pwm/pwm-pca9685.c | 83 ++++++++++++++++++++++++++++-----------
>  1 file changed, 59 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index cf0c98e4ef44..8a4993882b40 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -107,6 +107,30 @@ static bool pca9685_prescaler_can_change(struct pca9=
685 *pca, int channel)
>  	return test_bit(channel, pca->pwms_enabled);
>  }
> =20
> +static int pca9685_read_reg(struct pca9685 *pca, unsigned int reg, unsig=
ned int *val)
> +{
> +	struct device *dev =3D pca->chip.dev;
> +	int err;
> +
> +	err =3D regmap_read(pca->regmap, reg, val);
> +	if (err !=3D 0)
> +		dev_err(dev, "regmap_read of register 0x%x failed: %d\n", reg, err);

Please use %pe to emit the error code instead of %d.

> +
> +	return err;
> +}
> +
> +static int pca9685_write_reg(struct pca9685 *pca, unsigned int reg, unsi=
gned int val)
> +{
> +	struct device *dev =3D pca->chip.dev;
> +	int err;
> +
> +	err =3D regmap_write(pca->regmap, reg, val);
> +	if (err !=3D 0)
> +		dev_err(dev, "regmap_write to register 0x%x failed: %d\n", reg, err);
> +
> +	return err;
> +}
> +
>  /* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=
=3D2048 -> 50%) */
>  static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsig=
ned int duty)
>  {
> @@ -115,12 +139,12 @@ static void pca9685_pwm_set_duty(struct pca9685 *pc=
a, int channel, unsigned int
> =20
>  	if (duty =3D=3D 0) {
>  		/* Set the full OFF bit, which has the highest precedence */
> -		regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
> +		pca9685_write_reg(pca, REG_OFF_H(channel), LED_FULL);

You didn't check all return codes? How did you select the calls to
check?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vfnjmoawnycporzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBtTjEACgkQwfwUeK3K
7AmlpAf/Ys9OlGLMDV++TA9VDwM/Ywp0P7HPN+Pw/FaEO5wvTM9HBvACUwWOpBV7
iX50S3rqBwBpi4oy0eOEmKVibWWKwIIbLdVqq9Emaccl742KZ2Gt4ItW4qdKHkw/
q8hPbEBYLB5ZdgdCOnsiOj75nWcwoOrCH1d8szRAONN7fuNeV20ESF7FcurS44Xz
2UD+MyEZWui9deKSNE6JhzEWLYJQwtyhba0/bqD0++rhp4spKVrTb7df3YRi6EFv
bJvMAahRP8I2FItnzsCmyCbrFkkhWnJL062wuMC745ZrCXTzp/1bNd4wXN3P27Dt
VuYwFFqn/MFPgpnXX07s7Jk1QPTwCQ==
=Gk6O
-----END PGP SIGNATURE-----

--vfnjmoawnycporzw--
