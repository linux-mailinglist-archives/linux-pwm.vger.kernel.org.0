Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C429834D633
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhC2Rm2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 13:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhC2Rl6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 13:41:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D605AC061574
        for <linux-pwm@vger.kernel.org>; Mon, 29 Mar 2021 10:41:57 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQvtj-00027M-K6; Mon, 29 Mar 2021 19:41:55 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQvtj-0008MM-9r; Mon, 29 Mar 2021 19:41:55 +0200
Date:   Mon, 29 Mar 2021 19:41:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210329174154.kixw3f6r5r435a45@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-2-clemens.gruber@pqgruber.com>
 <20210329165429.ookfliw4eq6zz2sg@pengutronix.de>
 <YGIKWRfT7354nkPX@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="okhdllggjdckkruy"
Content-Disposition: inline
In-Reply-To: <YGIKWRfT7354nkPX@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--okhdllggjdckkruy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 29, 2021 at 07:11:53PM +0200, Clemens Gruber wrote:
> On Mon, Mar 29, 2021 at 06:54:29PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 29, 2021 at 02:57:02PM +0200, Clemens Gruber wrote:
> > > [...]
> > > +	/* Calculate (chip-wide) period from prescale value */
> > > +	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> > > +	state->period =3D (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK=
_MHZ) *
> > > +			(val + 1);
> >=20
> > As we have PCA9685_OSC_CLOCK_MHZ =3D 25 this is an integer calculation
> > without loss of precision. It might be worth to point that out in a
> > comment. (Otherwise doing the division at the end might be more
> > sensible.)
>=20
> What comment do you have in mind?
> /* 1 integer multiplication (without loss of precision) at runtime */ ?

Something like:

	/*
	 * PCA9685_OSC_CLOCK_MHZ is 25 and so an integer divider of
	 * 1000. So the calculation here is only a multiplication and
	 * we're not loosing precision.
	 */
=20
> > > +	/* The (per-channel) polarity is fixed */
> > > +	state->polarity =3D PWM_POLARITY_NORMAL;
> > > +
> > > +	if (pwm->hwpwm >=3D PCA9685_MAXCHAN) {
> > > +		/*
> > > +		 * The "all LEDs" channel does not support HW readout
> > > +		 * Return 0 and disabled for backwards compatibility
> > > +		 */
> > > +		state->duty_cycle =3D 0;
> > > +		state->enabled =3D false;
> > > +		return;
> > > +	}
> > > +
> > > +	duty =3D pca9685_pwm_get_duty(pca, pwm->hwpwm);
> > > +
> > > +	state->enabled =3D !!duty;
> > > +	if (!state->enabled) {
> > > +		state->duty_cycle =3D 0;
> > > +		return;
> > > +	} else if (duty =3D=3D PCA9685_COUNTER_RANGE) {
> > > +		state->duty_cycle =3D state->period;
> > > +		return;
> > > +	}
> > > +
> > > +	duty *=3D state->period;
> > > +	state->duty_cycle =3D duty / PCA9685_COUNTER_RANGE;
> >=20
> > .apply uses ROUND_CLOSEST to calculate duty from state->duty_cycle,
> > still using / here (instead of ROUND_CLOSEST), but again as
> > PCA9685_OSC_CLOCK_MHZ is 25 this calculation doesn't suffer from
> > rounding errors. So if you feed the state returned here into .apply
> > again, there is (as I want it) no change.
> >=20
> > The only annoyance is that if PCA9685_PRESCALE holds a value smaller
> > than 3, .apply() will fail. Not sure there is any saner way to handle
> > this.
>=20
> According to the datasheet, "The hardware forces a minimum value that
> can be loaded into the PRE_SCALE register at '3'", so there should never
> be anything below 3 in that register.

Did you verify that the register reads back a 3 if you write a lower
value into the register?

Maybe the most defensive way would be:

+	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
+	/*
+	 * According to the datasheet, the hardware forces a minimum
+	 * value that can be loaded is 3, so if we read something lower
+	 * assume that the hardware actually implemented a 3.
+	 */
+	if (val < 3)
+		val =3D 3;
+	state->period =3D ...
=09
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--okhdllggjdckkruy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBiEV8ACgkQwfwUeK3K
7Ak9zQf/cDqjfk6kHgcX8/J2+bnqxLRhHeTg6kkh1K5QEOyoDey0/doIEKyU36Nf
UkDh0YDtZTlhc/ImiGhIu70RhI+bNeacUR7wF7CymUg1WRBwBe8MbMSt7No+DLAA
7IqTGPUdBNkkUtETkhxgVEmKj1SRTiV9Fk8ahDBghuNAG9M+3+WyzB6mbhcIGEYC
ZdeOWroVntj5O3PnJF5Rd1LWcZnyV6f0k3upZ9tcBfcx5A5IBjFDMziY4RRuxZIr
gg+dWBCSgngFUg5aPzXI0Usx616ejcX0xLYE4KxfCTgc5K1RL35KaAaxlTmhdwYc
o7mThDKsIVgKL6tRpRXd0MfmvmXBiA==
=DjYB
-----END PGP SIGNATURE-----

--okhdllggjdckkruy--
