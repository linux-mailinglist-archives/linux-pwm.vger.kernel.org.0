Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728D02CF77D
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 00:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgLDX3M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Dec 2020 18:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgLDX3M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Dec 2020 18:29:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745C5C0613D1
        for <linux-pwm@vger.kernel.org>; Fri,  4 Dec 2020 15:28:46 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klKVA-0005YY-O9; Sat, 05 Dec 2020 00:28:36 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1klKV9-0005Dz-3l; Sat, 05 Dec 2020 00:28:35 +0100
Date:   Sat, 5 Dec 2020 00:28:34 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, thierry.reding@gmail.com,
        lee.jones@linaro.org, nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: bcm2835: Support apply function for atomic
 configuration
Message-ID: <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dz3tdc7ddc5owrhb"
Content-Disposition: inline
In-Reply-To: <20201204113846.GA6547@gofer.mess.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--dz3tdc7ddc5owrhb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Fri, Dec 04, 2020 at 11:38:46AM +0000, Sean Young wrote:
> On Fri, Dec 04, 2020 at 12:13:26PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Dec 04, 2020 at 08:44:17AM +0000, Sean Young wrote:
> > > On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> > > > > You're storing an unsigned long long (i.e. 64 bits) in an u32. If
> > > > > you are sure that this won't discard relevant bits, please explain
> > > > > this in a comment for the cursory reader.
> > > >=20
> > > > What about an extra check then to make sure that the period has not=
 been truncated,
> > > > e.g:
> > > >=20
> > > > 	value =3D DIV_ROUND_CLOSEST_ULL(state->period, scaler);
> > > >=20
> > > > 	/* dont accept a period that is too small or has been truncated */
> > > > 	if ((value < PERIOD_MIN) ||
> > > > 	    (value !=3D DIV_ROUND_CLOSEST_ULL(state->period, scaler)))
> > > > 		return -EINVAL;
> > >=20
> > > Rather than doing another 64 bit division which is expensive (esp on =
32 bit
> > > kernels), you could assign to u64 and check:
> > >=20
> > > 	if (value < PERIOD_MIN || value > U32_MAX)
> > > 		return -EINVAL;
> >=20
> > Given that value is a u32, value > U32_MAX will never trigger.
>=20
> I meant that value is declared u64 as well ("assign to u64").
>=20
> > Maybe checking period before doing the division is more sensible.
>=20
> That could introduce rounding errors, exactly why PERIOD_MIN was introduc=
ed.

If done correctly it doesn't introduce rounding errors.

> > > > > Also note that round_closed is probably wrong, as .apply() is
> > > > > supposed to round down the period to the next achievable period. =
(But
> > > > > fixing this has to do done in a separate patch.)
> > > >=20
> > > > According to commit 11fc4edc4 rounding to the closest integer has b=
een introduced
> > > > to improve precision in case that the pwm controller is used by the=
 pwm-ir-tx driver.
> > > > I dont know how strong the requirement is to round down the period =
in apply(), but I
> > > > can imagine that this may be a good reason to deviate from this rul=
e.
> > > > (CCing Sean Young who introduced DIV_ROUND_CLOSEST)
> > >=20
> > > There was a problem where the carrier is incorrect for some IR hardwa=
re
> > > which uses a carrier of 455kHz. With periods that small, rounding err=
ors
> > > do really matter and rounding down might cause problems.
> > >=20
> > > A policy of rounding down the carrier is not the right thing to do
> > > for pwm-ir-tx, and such a change will probably break pwm-ir-tx in some
> > > edge cases.
> >=20
> > IMO it's not an option to say: pwm-driver A is used for IR, so A's
> > .apply uses round-nearest and pwm-driver B is used for $somethingelse,
> > so B's .apply uses round-down.
>=20
> I'm not saying that one driver should have one it one way and another dri=
ver
> another way.

I read between your lines that you think that round-nearest is the
single best strategy, is that right?

> > To be a sensible API pwm_apply_state
> > should have a fixed behaviour. I consider round-down the sensible
> > choice (because it is easier to implmement the other options with this)
>=20
> It's not sensible when it's wrong about half the time.

So round-nearest which is wrong about the other half is better?
If you have two consumer drivers and one requires round-nearest and the
other requires round-down, how would you suggest to implement these two?
Always adapting the low-level driver depending on which consumer is in
use sounds wrong. So I conclude that the expectation about the
implemented rounding behaviour should be the same for all drivers. And
if your consumer happens to require a different strategy you're either
out of luck (bad), or we need to expand the PWM API to make this
possible, probably by implementing a round_state callback that tells the
caller the resulting state if the given state is applied.

> Why is is easier to implement?

If pwm_apply_state (and so pwm_round_state) rounds down, you can achieve
round-nearest (simplified: Ignoring polarity, just looking for period) usin=
g:

	lower_state =3D pwm_round_state(pwm, target_state);
	upper_state =3D {
		.period =3D 2 * target_state.period - lower_state.period,
		...
	}
	tmp =3D pwm_round_state(pwm, upper)

	if tmp.period < target_state.period:
		# tmp =3D=3D lower_state
		return lower_state

	else while tmp.period > target_state.period:
		upper =3D tmp;
		tmp.period -=3D 1
		tmp =3D pwm_round_state(pwm, tmp)

I admit it is not pretty. But please try to implement it the other way
around (i.e. pwm_round_state rounding to nearest and search for a
setting that yields the biggest period not above target.period without
just trying all steps). I spend a few brain cycles and the corner cases
are harder. (But maybe I'm not smart enough, so please convince me.)

Note that with round-nearest there is another complication: Assume a PWM
that can implement period =3D 500 =B5s and period =3D 1000 =B5s (and nothing
inbetween). That corresponds to the frequencies 2000 Hz and 1000 Hz.
round_nearest for state with period =3D 700 =B5s (corresponding to 1428.5714
Hz) would then pick 500 =B5s (corresponding to 2000 Hz), right? So is
round-nearest really what you prefer?

> > and for consumers like the IR stuff we need to provide some more
> > functions to allow it selecting a better suited state. Something like:
> >=20
> > 	pwm_round_state_nearest(pwm, { .period =3D 2198, .. }, &state)
> >=20
> > which queries the hardwares capabilities and then assigns state.period =
=3D
> > 2200 instead of 2100.
>=20
> This is very elaborate and surely not "easier to implement". Why not just
> do the right thing in the first place and round-closest?

I looked through the history of drivers/pwm for commits changing the
rounding behaviour. I found:

 - 11fc4edc483 which changes bcm2835 from round-down to round-closest
   (I didn't check but given that the driver divides by the result of a
   division the rounding might not always be round-closest.)
 - 12f9ce4a519 which changes pwm-rockchip from round-down to
   round-closest
   (The motivation described in the commit log is wrong today as
   pwm_get_state() gives the last set value, not the result of the
   lowlevel driver's .get_state callback. Also this problem can be fixed
   with drivers implementing round-down by just letting .get_state round
   up. (Which by the way is how I recommend how to implement it when
   reviewing new drivers.))

Did I miss something?

For a quick (and maybe unreliable) overview:

	$ git grep -l _CLOSEST drivers/pwm/ | wc -l
	15

so we might have 15 drivers that round to nearest and the remaining 40
round down. (I checked a few and didn't find a false diagnose.)

For me this isn't a clear indication that round-nearest is
unconditionally better. What is the fact that convinces you that
round-nearest is better in general?

> > Where can I find the affected (consumer) driver?
>=20
> So there is the pwm-ir-tx driver. The infrared led is directly connected
> to the pwm output pin, so that's all there is.

Ah, found it, drivers/media/rc/pwm-ir-tx.c, thanks.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--dz3tdc7ddc5owrhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/Kxh8ACgkQwfwUeK3K
7AnC9Af+Olfe5u/TIPqi1qneWGOWZ4bUWFpXsJfY3JhhbnQdrF8nESdp/9fhNXfV
HD2k4V5uM5tUmMp4pQ4PeJZmdMxNHcwPzac/xPgTHsTASDQnVo22g4pQul3F4QR/
RFAd/N7bLJNAuF9TAaWTvZVgX2EdfTUrEgb1BeR04iKQ8JS9IGSWXH6CEJeThgtU
NCgpt/bTaydow8hMlZof3BtIVVxzMc5Z3k7jjzMONAusgOVbKmbsL/oZlfJzxx1E
ZovfogF44ez53h2cIuwzfITQ7boCwSd3+EIq29VNfuOoK9N+ks+1sKXAkYGXvcch
Kq9Nmw3qaOsA+2Afxe4wqreA1H6lmQ==
=zFCS
-----END PGP SIGNATURE-----

--dz3tdc7ddc5owrhb--
