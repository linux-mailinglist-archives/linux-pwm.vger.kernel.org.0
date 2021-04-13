Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA435DC82
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 12:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245151AbhDMKef (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 06:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245197AbhDMKee (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 06:34:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D44DC061574
        for <linux-pwm@vger.kernel.org>; Tue, 13 Apr 2021 03:34:15 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWGN2-0008Cb-Vn; Tue, 13 Apr 2021 12:34:12 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWGN2-0002a2-FD; Tue, 13 Apr 2021 12:34:12 +0200
Date:   Tue, 13 Apr 2021 12:34:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/8] pwm: pca9685: Support new PWM_USAGE_POWER flag
Message-ID: <20210413103412.ngvtk5cw2ftyjvob@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412132745.76609-6-clemens.gruber@pqgruber.com>
 <20210412163045.apgnac7atgpboths@pengutronix.de>
 <YHR/Xm5nOjrSwVYs@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5yi73bsuwgixsqmt"
Content-Disposition: inline
In-Reply-To: <YHR/Xm5nOjrSwVYs@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5yi73bsuwgixsqmt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Clemens,

On Mon, Apr 12, 2021 at 07:11:58PM +0200, Clemens Gruber wrote:
> On Mon, Apr 12, 2021 at 06:30:45PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Apr 12, 2021 at 03:27:43PM +0200, Clemens Gruber wrote:
> > >  static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int ch=
annel)
> > >  {
> > > -	unsigned int off_h =3D 0, val =3D 0;
> > > +	struct pwm_device *pwm =3D &pca->chip.pwms[channel];
> > > +	unsigned int off =3D 0, on =3D 0, val =3D 0;
> > > =20
> > >  	if (WARN_ON(channel >=3D PCA9685_MAXCHAN)) {
> > >  		/* HW does not support reading state of "all LEDs" channel */
> > >  		return 0;
> > >  	}
> > > =20
> > > -	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off_h);
> > > -	if (off_h & LED_FULL) {
> > > +	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off);
> > > +	if (off & LED_FULL) {
> > >  		/* Full OFF bit is set */
> > >  		return 0;
> > >  	}
> > > =20
> > > -	regmap_read(pca->regmap, LED_N_ON_H(channel), &val);
> > > -	if (val & LED_FULL) {
> > > +	regmap_read(pca->regmap, LED_N_ON_H(channel), &on);
> > > +	if (on & LED_FULL) {
> > >  		/* Full ON bit is set */
> > >  		return PCA9685_COUNTER_RANGE;
> > >  	}
> > > =20
> > > -	val =3D 0;
> > >  	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> > > -	return ((off_h & 0xf) << 8) | (val & 0xff);
> > > +	off =3D ((off & 0xf) << 8) | (val & 0xff);
> > > +	if (!pwm->args.usage_power)
> > > +		return off;
> > > +
> > > +	/* Read ON register to calculate duty cycle of staggered output */
> > > +	val =3D 0;
> > > +	regmap_read(pca->regmap, LED_N_ON_L(channel), &val);
> > > +	on =3D ((on & 0xf) << 8) | (val & 0xff);
> > > +	return (off - on) & (PCA9685_COUNTER_RANGE - 1);
> >=20
> > If LED_N_ON is !=3D 0 but usage_power is false, the returned state is
> > bogus.
>=20
> If usage_power is false, LED_N_ON is guaranteed to be 0. It is reset to
> 0 in probe and never changed. Or did I miss something?

Ah right, so my concern is only a challenge once the reset in probe goes
away.

> > >  }
> > > =20
> > >  #if IS_ENABLED(CONFIG_GPIOLIB)
> > > @@ -439,9 +469,11 @@ static int pca9685_pwm_probe(struct i2c_client *=
client,
> > >  	reg &=3D ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
> > >  	regmap_write(pca->regmap, PCA9685_MODE1, reg);
> > > =20
> > > -	/* Reset OFF registers to POR default */
> > > +	/* Reset OFF/ON registers to POR default */
> > >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, LED_FULL);
> > >  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
> > > +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> > > +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
> > > =20
> > >  	pca->chip.ops =3D &pca9685_pwm_ops;
> > >  	/* Add an extra channel for ALL_LED */
> > > @@ -450,6 +482,9 @@ static int pca9685_pwm_probe(struct i2c_client *c=
lient,
> > >  	pca->chip.dev =3D &client->dev;
> > >  	pca->chip.base =3D -1;
> > > =20
> > > +	pca->chip.of_xlate =3D of_pwm_xlate_with_flags;
> > > +	pca->chip.of_pwm_n_cells =3D 3;
> > > +
> >=20
> > Huh, you're incompatibly changing the device tree binding here.
>=20
> No, I don't think so:
>=20
> The third cell is optional with of_pwm_xlate_with_flags.
> So previous DTs with pwm-cells =3D <2> will still work.

I thought that .of_pwm_n_cells was enforced, let me check the code ... I
had in mind that of_pwm_get() enforced that, but I cannot find it, so I
guess you're right and my concern is unjustified.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5yi73bsuwgixsqmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB1c6AACgkQwfwUeK3K
7AklQQgAmLXZlUmBHqlmxp/futrTOuHVljzfFpomRmDqlZuObEjkJP81nV8mExNu
DBAxVX1Th6DSWddMWZzkEUzVrqGo3xe9EDM1GhSRufq3Eh+PpIQfBEi4j1EiRjW0
uq6Gz0e58FtVAGbcwQl/xEPTBDNdYtPQ3cPcNQ0btvlFGPnyALVaD1TzIajpxoOQ
6sa4XqoXweKu+HNdD3l/VmnT9S7odmJw7BMgnJ8EMtGJVW4T/w9UvKFh6ZcJzskQ
cAgv6qMUmEEjKd1bKZeIPui3OPAxVn7lwf9AVpem/U9iTikpuCpmPI7fbHp3jWw9
5TUqU7sLjtkRr9qJr/VkCHNG2Wodeg==
=KDCe
-----END PGP SIGNATURE-----

--5yi73bsuwgixsqmt--
