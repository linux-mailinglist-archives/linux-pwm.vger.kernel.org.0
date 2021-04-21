Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE2E366F16
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Apr 2021 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243974AbhDUP04 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Apr 2021 11:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243977AbhDUP0z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Apr 2021 11:26:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E52C06174A
        for <linux-pwm@vger.kernel.org>; Wed, 21 Apr 2021 08:26:21 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZEk7-0005kZ-L4; Wed, 21 Apr 2021 17:26:19 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZEk6-000857-AN; Wed, 21 Apr 2021 17:26:18 +0200
Date:   Wed, 21 Apr 2021 17:26:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-pwm@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: overflow and wrong timeout errors in pwm-atmel
Message-ID: <20210421152618.x3wtxdyup7cnvfh5@pengutronix.de>
References: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
 <20210421092606.1634092-1-u.kleine-koenig@pengutronix.de>
 <20210421110336.bd5s6e2kjxqilddi@pengutronix.de>
 <20210421134825.powx5tvqvce32fho@pengutronix.de>
 <YIA0PXR+oxxpkrzL@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xl3deklgypok7leq"
Content-Disposition: inline
In-Reply-To: <YIA0PXR+oxxpkrzL@piout.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xl3deklgypok7leq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alexandre,

On Wed, Apr 21, 2021 at 04:18:37PM +0200, Alexandre Belloni wrote:
> On 21/04/2021 15:48:25+0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Apr 21, 2021 at 01:03:36PM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Wed, Apr 21, 2021 at 11:26:08AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > With these three patches PWM_DEBUG is now happy. (At least I couldn=
't
> > > > trigger a warning any more. I think there are still a few problems =
with
> > > > integer overflows.)
> > >=20
> > > BTW, setting the period to 138350580899 (with a clock rate of 1333333=
33
> > > Hz) results in setting period=3D0 because
> > >=20
> > > 	state->period * clkrate =3D
> > > 	138350580899 * 133333333 =3D
> > > 	40254751 (discarded from 18446744073749806367).
> >=20
> > As a first remedy the following could be done:
> >=20
> > diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > index 38d86340201c..02d69fa5f7d2 100644
> > --- a/drivers/pwm/pwm-atmel.c
> > +++ b/drivers/pwm/pwm-atmel.c
> > @@ -199,6 +199,11 @@ static int atmel_pwm_calculate_cprd_and_pres(struc=
t pwm_chip *chip,
> >  	unsigned long long cycles =3D state->period;
> >  	int shift;
> > =20
> > +	if (fls(cycles) + fls(clkrate) > 64) {
> > +		dev_err(chip->dev, "period to big to calculate HW parameters\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	/* Calculate the period cycles and prescale value */
> >  	cycles *=3D clkrate;
> >  	do_div(cycles, NSEC_PER_SEC);
> >=20
> > Is this sensible? (Actually I'd prefer to just continue with
> >=20
> > 	period =3D (ULL(1) << (64 - fls(clkrate))) - 1
> >=20
> > according to the motto to yield the highest possible period, but this
> > function has another error path that returns -EINVAL so this would be
> > inconsistent.)
>=20
> Shouldn't that be -ERANGE?

The other exit point a few lines down also uses -EINVAL so I sticked to
that.

> I do think it is better to return an error and let userspace decide
> what is the policy instead of having the policy in the driver.

I agree that the consumer (userspace is just one of them) should have
the choice what happens. IMHO the only sane way to implement this is
using a round_state function that tells the consumer what they can
expect when a certain state is passed to apply. (Otherwise the consumer
might already be unhappy if they request a period of say 652799 ns and
the driver implements 645120 ns (which is BTW what happens with the
pwm-atmel driver when feed by a 133333333 Hz clk).)

And another critical detail of this round_state function is that it
should expose the same behaviour for all lowlevel drivers. I think
first rounding down period and then duty_cycle is a good strategy that
can be worked with. With that in place the next (IMHO) obvious
conclusion is that .apply() should behave in the same way for
consistency and also to keep the drivers simple.

If then a consumer prefers a different rounding strategy (e.g. for the
pwm-ir-tx driver rounding to the nearest values is better), this can be
(more or less) easily and (more important) generically implemented in a
single place.

Does this make sense in your eyes?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xl3deklgypok7leq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCARBcACgkQwfwUeK3K
7Am82gf8D7M5km9kW0eHArNhx6ZM3DBXGqbt3QpqZX4wkmlPDGssSkeBCoKNqnVR
SPrgYg/gum0ogTYOVdSTPvq6OgY+zwk9vf60d8dztWZ55IL1pxox40Du1fRR+2O8
jNR+7vAk+dIHrsmXX2glkrJnrnlkDKUqc0i76W4fKjE01XI51wdQWq7gNTpoDmr1
dWNbZq4kgKPsg/GZdDB2VGqtubhyDBz0u6k48ryd1/SbNUnO63ovXsjA1t2uqzlv
acwXdSVKHOt2I10GoJePuKfnj1HWc5YYMj+UOePMvIHAoFudt0RgpzG4bmtQbT02
qcmg0EcWKlEr4IVednLU/tDbpBR7ZQ==
=5m61
-----END PGP SIGNATURE-----

--xl3deklgypok7leq--
