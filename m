Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB463567B5
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhDGJJ6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 05:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhDGJJ5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 05:09:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F989C06174A
        for <linux-pwm@vger.kernel.org>; Wed,  7 Apr 2021 02:09:48 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU4C0-0000zQ-43; Wed, 07 Apr 2021 11:09:44 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU4Bz-0006cu-EQ; Wed, 07 Apr 2021 11:09:43 +0200
Date:   Wed, 7 Apr 2021 11:09:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/8] pwm: pca9685: Support hardware readout
Message-ID: <20210407090943.vshoxqhaha4j6wq7@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-2-clemens.gruber@pqgruber.com>
 <20210407053135.tx2q4bzxf2lwtqna@pengutronix.de>
 <YG1gQNdDYA1RwrCo@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pshvs3vilf37gue4"
Content-Disposition: inline
In-Reply-To: <YG1gQNdDYA1RwrCo@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--pshvs3vilf37gue4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2021 at 09:33:20AM +0200, Clemens Gruber wrote:
> On Wed, Apr 07, 2021 at 07:31:35AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 06, 2021 at 06:41:34PM +0200, Clemens Gruber wrote:
> > > Implements .get_state to read-out the current hardware state.
> > >=20
> > > The hardware readout may return slightly different values than those
> > > that were set in apply due to the limited range of possible prescale =
and
> > > counter register values.
> > >=20
> > > Also note that although the datasheet mentions 200 Hz as default
> > > frequency when using the internal 25 MHz oscillator, the calculated
> > > period from the default prescaler register setting of 30 is 5079040ns.
> > >=20
> > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > ---
> > > Changes since v6:
> > > - Added a comment regarding the division (Suggested by Uwe)
> > > - Rebased
> > >=20
> > >  drivers/pwm/pwm-pca9685.c | 46 +++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 46 insertions(+)
> > >=20
> > > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > > index 5a2ce97e71fd..d4474c5ff96f 100644
> > > --- a/drivers/pwm/pwm-pca9685.c
> > > +++ b/drivers/pwm/pwm-pca9685.c
> > > @@ -333,6 +333,51 @@ static int pca9685_pwm_apply(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
> > >  	return 0;
> > >  }
> > > =20
> > > +static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_=
device *pwm,
> > > +				  struct pwm_state *state)
> > > +{
> > > +	struct pca9685 *pca =3D to_pca(chip);
> > > +	unsigned long long duty;
> > > +	unsigned int val =3D 0;
> > > +
> > > +	/* Calculate (chip-wide) period from prescale value */
> > > +	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> > > +	/*
> > > +	 * PCA9685_OSC_CLOCK_MHZ is 25, i.e. an integer divider of 1000.
> > > +	 * The following calculation is therefore only a multiplication
> > > +	 * and we are not losing precision.
> > > +	 */
> > > +	state->period =3D (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK=
_MHZ) *
> > > +			(val + 1);
> > > +
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
> > Given that with duty =3D 0 the chip is still "on" and changing the duty
> > will first complete the currently running period, I'd model duty=3D0 as
> > enabled. This also simplifies the code a bit, to something like:
> >=20
> >=20
> > 	state->enabled =3D true;
> > 	duty =3D pca9685_pwm_get_duty(pca, pwm->hwpwm);
> > 	state->duty_cycle =3D div_round_up(duty * state->period, PCA9685_COUNT=
ER_RANGE);
> >=20
> > (I'm using round-up here assuming apply uses round-down to get
> > idempotency. In the current patch set state this is wrong however.)
>=20
> So, in your opinion, every requested PWM of the pca9685 should always be
> enabled by default (from the PWM core viewpoint) ?
>=20
> And this wouldn't break the following because pwm_get_state does not
> actually read out the hw state:
> pwm_get_state -> enabled=3Dtrue duty=3D0
> pwm_apply_state -> enabled =3Dfalse duty=3D0
> pwm_get_state -> enabled=3Dfalse duty=3D0

I don't see any breakage here. Either there is none or I failed to grasp
where you see a problem.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pshvs3vilf37gue4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBtdtQACgkQwfwUeK3K
7AkV9QgAmzkvZmlwDOuD+LCEIwVv5auPUPnPoHRyMlVqa+tf6TGAsf2cIBa8RYTz
0xAfh5Ur3gt0joZoPFUZwAyegth9iz3wdQLpemqXd5mGQv6VLUE8D7F1szrwO8kx
G1V3dU7EwqPegD32zeERBm3kLA70Aggw2hnSFeq0AJghTxN8qLVWslrHm1MRaiYS
1VHnR/bmdgxt33SwmNpzcw2pYwZDsRECA6SE5McR5m7B91hSKVlOJyTjTL9xhihb
5w3rFI/nC6dFvIyJRmhYoVkkvDABbrqWL0ssLkE41b1U+RyxIKaqvqNJvUPVTaVa
/1tstHjiLlYeRCUp4IEFTHiijhVClg==
=FbW8
-----END PGP SIGNATURE-----

--pshvs3vilf37gue4--
