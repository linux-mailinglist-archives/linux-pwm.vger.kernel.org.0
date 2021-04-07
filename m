Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D433F3576FE
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 23:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbhDGViR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 17:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbhDGViP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 17:38:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1A9C061760
        for <linux-pwm@vger.kernel.org>; Wed,  7 Apr 2021 14:38:05 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUFsA-0007Eq-W2; Wed, 07 Apr 2021 23:38:02 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUFsA-00022d-Lt; Wed, 07 Apr 2021 23:38:02 +0200
Date:   Wed, 7 Apr 2021 23:38:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 7/8] pwm: pca9685: Restrict period change for enabled
 PWMs
Message-ID: <20210407213802.yuure3jawpw4wnee@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-7-clemens.gruber@pqgruber.com>
 <20210407061229.lsyg7blh3ebxtvx6@pengutronix.de>
 <YG4Y94sIL/xO2u/N@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rfx6gg2mob3mnmhe"
Content-Disposition: inline
In-Reply-To: <YG4Y94sIL/xO2u/N@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--rfx6gg2mob3mnmhe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 10:41:27PM +0200, Clemens Gruber wrote:
> On Wed, Apr 07, 2021 at 08:12:29AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 06, 2021 at 06:41:39PM +0200, Clemens Gruber wrote:
> > > Previously, the last used PWM channel could change the global prescale
> > > setting, even if other channels are already in use.
> > >=20
> > > Fix it by only allowing the first enabled PWM to change the global
> > > chip-wide prescale setting. If there is more than one channel in use,
> > > the prescale settings resulting from the chosen periods must match.
> > >=20
> > > GPIOs do not count as enabled PWMs as they are not using the prescaler
> > > and can't change it.
> > >=20
> > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > ---
> > > Changes since v6:
> > > - Only allow the first PWM that is enabled to change the prescaler, n=
ot
> > >   the first one that uses the prescaler
> > >=20
> > >  drivers/pwm/pwm-pca9685.c | 66 +++++++++++++++++++++++++++++++++----=
--
> > >  1 file changed, 56 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > > index 24221ee7a77a..cf0c98e4ef44 100644
> > > --- a/drivers/pwm/pwm-pca9685.c
> > > +++ b/drivers/pwm/pwm-pca9685.c
> > > @@ -23,11 +23,11 @@
> > >  #include <linux/bitmap.h>
> > > =20
> > >  /*
> > > - * Because the PCA9685 has only one prescaler per chip, changing the=
 period of
> > > - * one channel affects the period of all 16 PWM outputs!
> > > - * However, the ratio between each configured duty cycle and the chi=
p-wide
> > > - * period remains constant, because the OFF time is set in proportio=
n to the
> > > - * counter range.
> > > + * Because the PCA9685 has only one prescaler per chip, only the fir=
st channel
> > > + * that is enabled is allowed to change the prescale register.
> > > + * PWM channels requested afterwards must use a period that results =
in the same
> > > + * prescale setting as the one set by the first requested channel.
> > > + * GPIOs do not count as enabled PWMs as they are not using the pres=
caler.
> > >   */
> > > =20
> > >  #define PCA9685_MODE1		0x00
> > > @@ -78,8 +78,9 @@
> > >  struct pca9685 {
> > >  	struct pwm_chip chip;
> > >  	struct regmap *regmap;
> > > -#if IS_ENABLED(CONFIG_GPIOLIB)
> > >  	struct mutex lock;
> > > +	DECLARE_BITMAP(pwms_enabled, PCA9685_MAXCHAN + 1);
> > > +#if IS_ENABLED(CONFIG_GPIOLIB)
> > >  	struct gpio_chip gpio;
> > >  	DECLARE_BITMAP(pwms_inuse, PCA9685_MAXCHAN + 1);
> > >  #endif
> > > @@ -90,6 +91,22 @@ static inline struct pca9685 *to_pca(struct pwm_ch=
ip *chip)
> > >  	return container_of(chip, struct pca9685, chip);
> > >  }
> > > =20
> > > +/* This function is supposed to be called with the lock mutex held */
> > > +static bool pca9685_prescaler_can_change(struct pca9685 *pca, int ch=
annel)
> > > +{
> > > +	/* No PWM enabled: Change allowed */
> > > +	if (bitmap_empty(pca->pwms_enabled, PCA9685_MAXCHAN + 1))
> > > +		return true;
> > > +	/* More than one PWM enabled: Change not allowed */
> > > +	if (bitmap_weight(pca->pwms_enabled, PCA9685_MAXCHAN + 1) > 1)
> > > +		return false;
> > > +	/*
> > > +	 * Only one PWM enabled: Change allowed if the PWM about to
> > > +	 * be changed is the one that is already enabled
> > > +	 */
> > > +	return test_bit(channel, pca->pwms_enabled);
> >=20
> > Maybe this is a bit more effective?:
> >=20
> > 	DECLARE_BITMAP(blablub, PCA9685_MAXCHAN + 1);=09
> > 	bitmap_zero(blablub, PCA9685_MAXCHAN + 1);
> > 	bitmap_set(blablub, channel);
> > 	return bitmap_subset(pca->pwms_enabled, blablub);
>=20
> But if no PWM is enabled, it should return true, not false.

If no PWM is enabled we have pca->pwms_enabled =3D empty set which is a
subset of every set. So I'd expect this case to be handled just fine.

> > (but that's a minor issue, the suggested algorithm is correct.)
>=20
> I would prefer to keep it explicit because it is a little easier to
> follow and probably not worth optimizing.

I didn't find it hard to follow, but I'm willing to accept that this
isn't representative. I'm ok with keeping the code as is.
=20
> I agree that it would be nice to drop the ALL channel support.

Maybe deprecate it using a config item? But no hurry.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rfx6gg2mob3mnmhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBuJjcACgkQwfwUeK3K
7Aks6wf/Z2rmxyuymCKjoKi1DLXheYM+riFwHVBj7ZA/N8cWa6ibMfXYvn0eKhtN
0CuA4lkYjn4faQ5HIr+cXC40RPE67AewlSClKZ+SFLXD3rKzDqBVdvi2hQubxVV1
znc8/Q+6AqzNJ/uwNrRYOxXHwTLFsBvPql0SkV3OAHFzqW+iQBeUd4a49/3X63DG
LMEeFPShNA604faxO8LfJDG19zJvJcodqOCfL/catOkcyHPSqNutMA6qHGcRGK9i
0SezTGmx7PIeiTsHnjziZVySpfNjnwc4F2boskApqvTRTiWuP0B+zEmg67JAgaMr
lmvmjEOqOr86n8PCF2xjS5V9E5ikXA==
=gkoQ
-----END PGP SIGNATURE-----

--rfx6gg2mob3mnmhe--
