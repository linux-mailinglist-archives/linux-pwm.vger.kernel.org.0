Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB9B2F0DA8
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 09:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbhAKIMJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 03:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAKIMJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2021 03:12:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27AC06179F
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jan 2021 00:11:29 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kysI9-0001p5-8x; Mon, 11 Jan 2021 09:11:09 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kysHz-0006LC-5p; Mon, 11 Jan 2021 09:10:59 +0100
Date:   Mon, 11 Jan 2021 09:10:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v6 1/4] gpio: mvebu: fix pwm get_state period calculation
Message-ID: <20210111081058.himyiehpblhqiw5o@pengutronix.de>
References: <cover.1609917364.git.baruch@tkos.co.il>
 <22d1fe7b2137e3a2660ab2e6f1f127d41493fb16.1609917364.git.baruch@tkos.co.il>
 <20210107142953.ifg5yuy3dsblgsju@pengutronix.de>
 <87wnwkyas6.fsf@tarshish>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="emqvwaujl6tyqcjn"
Content-Disposition: inline
In-Reply-To: <87wnwkyas6.fsf@tarshish>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--emqvwaujl6tyqcjn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 10, 2021 at 07:14:17PM +0200, Baruch Siach wrote:
> Hi Uwe,
>=20
> Thanks for your review comments.
>=20
> On Thu, Jan 07 2021, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jan 06, 2021 at 09:37:37AM +0200, Baruch Siach wrote:
> >> The period is the sum of on and off values.
> >>=20
> >> Reported-by: Russell King <linux@armlinux.org.uk>
> >> Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> ---
> >> v6: divide (on + off) sum to reduce rounding error (RMK)
> >> ---
> >>  drivers/gpio/gpio-mvebu.c | 19 ++++++++-----------
> >>  1 file changed, 8 insertions(+), 11 deletions(-)
> >>=20
> >> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> >> index 672681a976f5..a912a8fed197 100644
> >> --- a/drivers/gpio/gpio-mvebu.c
> >> +++ b/drivers/gpio/gpio-mvebu.c
> >> @@ -676,20 +676,17 @@ static void mvebu_pwm_get_state(struct pwm_chip =
*chip,
> >>  	else
> >>  		state->duty_cycle =3D 1;
> >> =20
> >> +	val =3D (unsigned long long) u; /* on duration */
> >>  	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
> >> -	val =3D (unsigned long long) u * NSEC_PER_SEC;
> >> +	val +=3D (unsigned long long) u; /* period =3D on + off duration */
> >> +	val *=3D NSEC_PER_SEC;
> >>  	do_div(val, mvpwm->clk_rate);
> >> -	if (val < state->duty_cycle) {
> >> +	if (val > UINT_MAX)
> >> +		state->period =3D UINT_MAX;
> >
> > state->period is an u64, so there is no reason to not use values greater
> > than UINT_MAX.
>=20
> I'll post a patch for that.
>=20
> >> +	else if (val)
> >> +		state->period =3D val;
> >> +	else
> >>  		state->period =3D 1;
> >
> > This case assigning 1 looks strange. An explanation in a comment would
> > be great. I wonder if this is a hardware property or if it is only used
> > to not report 0 in case that mvpwm->clk_rate is high.
>=20
> I guess that this is because 0 period does not make sense for pwm. It is
> like a zero divisor. What is the common behavior?

It depends on how the hardware behaves in this case. One measure is to
use round-up (in .get_state) for the divisions -- as I already pointed
out. Then the problem only triggers if both on and off registers are
zero.

> > I found a few further shortcommings in the mvebu_pwm implementation whi=
le
> > looking through it:
> >
> >  a) The rounding problem that RMK found is also present in .apply
> >
> >     There we have:
> >
> >     	val =3D clk_rate * (period - duty_cycle) / NSEC_PER_SEC
> >
> >     while
> >
> >     	val =3D clk_rate * period / NSEC_PER_SEC - on
> >
> >     would be more exact.
>=20
> I'll post a patch for that.
>=20
> >  b) To make
> >
> >  	pwm_get_state(pwm, &state);
> > 	pwm_apply_state(pwm, &state);
> >
> >     idempotent .get_state should round up the division results.
>=20
> I'll post a patch for that as well.
>=20
> >  c) .apply also has a check for val being zero and configures at least 1
> >     cycle for the on and off intervals. Is this a hardware imposed
> >     limitation?=20
>=20
> Not sure what was the original intention. Maybe Andrew can explain.
>=20
> On my hardware (Armada 8040), zero 'on' value does not work as
> expected. There is a blink once in a long while. Maybe this is the
> reason?

It would be good to understand and document this. Hardware PWMs not
supporting a zero duty cycle are always a surprise for me and probably
also others.

> As I understand, all these issues should not block this patch, right?

Yes, having this patch in a series fixing all the stuff I pointed out
would still be very welcome :-)

> BTW, the key you used to sign your message is expired since 2020-01-10
> on the key server I use (keys.gnupg.net). Where can I find your updated
> key?

Hmm, I thought keyservers are out of fashion. Anyhow, I updated my key
there. There is no WKD for @pengutronix.de addresses, but

	gpg --locate-external-keys uwe@kleine-koenig.org

should work just fine, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--emqvwaujl6tyqcjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/8CBAACgkQwfwUeK3K
7Akviwf5ATrHFCh+q0a7R6COLP/gdCQBvawsj4GwSbU6Wm//BN9gFhiCL3d18Y5+
uxB+/+b1F4r9Jz3IvsWvZYlt94FNGOlIYRpmhNYSzE8bMZoj66KLEcFkjAo9byRv
l54f8uGoJjtg9U10FcEASlFxHXIOxpCjvfjZlaGnL4Y3+SEcUUzN3LosSGeE4b3x
qSsXjEpMW8CgdCEEjJKHGlMYfdbLm1GHdgNrhRx58cWgMVldMeP6JltkoU/F/exz
KlhPe4Xo2LUVaKnrHgJuVOHnKzJAvHTJTjG/vhMfIUJRxs7tLFIPMadI23W41rFQ
yX2F/aL1KY11gyrfr9ZnQbEYXxwxQA==
=FUTQ
-----END PGP SIGNATURE-----

--emqvwaujl6tyqcjn--
