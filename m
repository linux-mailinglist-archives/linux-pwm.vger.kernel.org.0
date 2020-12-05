Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2112CFE5D
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 20:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgLET0E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Dec 2020 14:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLET0D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 14:26:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7FAC0613D1
        for <linux-pwm@vger.kernel.org>; Sat,  5 Dec 2020 11:25:22 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kldBA-0004YV-Vd; Sat, 05 Dec 2020 20:25:12 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kldB8-0005Qv-Lb; Sat, 05 Dec 2020 20:25:10 +0100
Date:   Sat, 5 Dec 2020 20:25:10 +0100
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
Message-ID: <20201205192510.o76pjs3yc524nwvm@pengutronix.de>
References: <202011281128.54eLfMWr-lkp@intel.com>
 <1606564926-19555-1-git-send-email-LinoSanfilippo@gmx.de>
 <20201129181050.p6rkif5vjoumvafm@pengutronix.de>
 <4683237c-7b40-11ab-b3c0-f94a5dd39b4d@gmx.de>
 <20201204084417.GA2154@gofer.mess.org>
 <20201204111326.qjux6k2472dmukot@pengutronix.de>
 <20201204113846.GA6547@gofer.mess.org>
 <20201204232834.xzsafkzfmfpw7pqz@pengutronix.de>
 <20201205173444.GA1265@gofer.mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wdm6e7mw35nruoak"
Content-Disposition: inline
In-Reply-To: <20201205173444.GA1265@gofer.mess.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wdm6e7mw35nruoak
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Sat, Dec 05, 2020 at 05:34:44PM +0000, Sean Young wrote:
> On Sat, Dec 05, 2020 at 12:28:34AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Dec 04, 2020 at 11:38:46AM +0000, Sean Young wrote:
> > > On Fri, Dec 04, 2020 at 12:13:26PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Fri, Dec 04, 2020 at 08:44:17AM +0000, Sean Young wrote:
> > > > > On Fri, Dec 04, 2020 at 12:42:15AM +0100, Lino Sanfilippo wrote:
> > > > > > > You're storing an unsigned long long (i.e. 64 bits) in an u32=
=2E If
> > > > > > > you are sure that this won't discard relevant bits, please ex=
plain
> > > > > > > this in a comment for the cursory reader.
> > > > > >=20
> > > > > > > Also note that round_closed is probably wrong, as .apply() is
> > > > > > > supposed to round down the period to the next achievable peri=
od. (But
> > > > > > > fixing this has to do done in a separate patch.)
> > > > > >=20
> > > > > > According to commit 11fc4edc4 rounding to the closest integer h=
as been introduced
> > > > > > to improve precision in case that the pwm controller is used by=
 the pwm-ir-tx driver.
> > > > > > I dont know how strong the requirement is to round down the per=
iod in apply(), but I
> > > > > > can imagine that this may be a good reason to deviate from this=
 rule.
> > > > > > (CCing Sean Young who introduced DIV_ROUND_CLOSEST)
> > > > >=20
> > > > > There was a problem where the carrier is incorrect for some IR ha=
rdware
> > > > > which uses a carrier of 455kHz. With periods that small, rounding=
 errors
> > > > > do really matter and rounding down might cause problems.
> > > > >=20
> > > > > A policy of rounding down the carrier is not the right thing to do
> > > > > for pwm-ir-tx, and such a change will probably break pwm-ir-tx in=
 some
> > > > > edge cases.
> > > >=20
> > > > IMO it's not an option to say: pwm-driver A is used for IR, so A's
> > > > .apply uses round-nearest and pwm-driver B is used for $somethingel=
se,
> > > > so B's .apply uses round-down.
> > >=20
> > > I'm not saying that one driver should have one it one way and another=
 driver
> > > another way.
> >=20
> > I read between your lines that you think that round-nearest is the
> > single best strategy, is that right?
>=20
> Certain the default strategy. When setting a pwm of period X, I would
> expect it set it to the closest period it can match to X. Doing anything
> else by default is a surprising API.

This reminds me of a similar discussion about rounding in the clk
framework which is an unsolved problem, too. It's unspecified how
clk_set_rate and clk_round_rate behave. If you want to operate an IP
block you usually have a fixed upper limit for the clock frequency and
you want the clk as fast as possible. If you operate an UART you want
the nearest match (for some definition of near, see below) to match the
baud rate.

> What real life uses-cases are there for round down? If you want to round
> down, is there any need for round up?

The scenario I have in mind is for driving a motor. I have to admit
however that usually the period doesn't matter much and it's the
duty_cycle that defines the motor's speed. So for this case the
conservative behaviour is round-down to not make the motor run faster
than expected.

For other usecases (fan, backlight, LED) exactness typically doesn't
matter that much.

So we could find a compromise: round period to nearest and duty_cycle
down. But I'm convinced this is a bad compromise because it's quite
unintuitive.

> Hypothetically you may want e.g. nearest to 100kHz but absolutely no less
> than 100kHz. I don't know when this comes up, it would be interesting to
> hear where this is needed.

ack.

> > > Why is is easier to implement?
> >=20
> > If pwm_apply_state (and so pwm_round_state) rounds down, you can achieve
> > round-nearest (simplified: Ignoring polarity, just looking for period) =
using:
> >=20
> > 	lower_state =3D pwm_round_state(pwm, target_state);
> > 	upper_state =3D {
> > 		.period =3D 2 * target_state.period - lower_state.period,
> > 		...
> > 	}
> > 	tmp =3D pwm_round_state(pwm, upper)
> >=20
> > 	if tmp.period < target_state.period:
> > 		# tmp =3D=3D lower_state
> > 		return lower_state
> >=20
> > 	else while tmp.period > target_state.period:
> > 		upper =3D tmp;
> > 		tmp.period -=3D 1
> > 		tmp =3D pwm_round_state(pwm, tmp)
> >=20
> > I admit it is not pretty. But please try to implement it the other way
> > around (i.e. pwm_round_state rounding to nearest and search for a
> > setting that yields the biggest period not above target.period without
> > just trying all steps). I spend a few brain cycles and the corner cases
> > are harder. (But maybe I'm not smart enough, so please convince me.)
>=20
> Ok. Does pwm hardware always work on a linear scale?

No. A quite usual setup is that the PWM hardware has a built-in divider.
The details here vary heavily (range of the divider, some can only
divide by powers of two, or by little integer multiples of powers of two
=2E..)

> > Note that with round-nearest there is another complication: Assume a PWM
> > that can implement period =3D 500 =B5s and period =3D 1000 =B5s (and no=
thing
> > inbetween). That corresponds to the frequencies 2000 Hz and 1000 Hz.
> > round_nearest for state with period =3D 700 =B5s (corresponding to 1428=
=2E5714
> > Hz) would then pick 500 =B5s (corresponding to 2000 Hz), right? So is
> > round-nearest really what you prefer?
>=20
> That is an interesting point. So, I guess the question is: do you want the
> nearest period or the nearest frequency.

I think to match a carrier frequency you want to minimize the deviation
in period, not frequency. (That is, if you want to match 1000 Hz, 950 Hz
is worse than 1050 Hz because with 950 Hz it takes little more than 19
periods ((1/1000) / abs(1/950 - 1/1000)) until you have more than one
period difference compared to 1000 Hz while with 1050 Hz it takes nearly
21 periods ((1/1000) / abs(1/1050 - 1/1000)). (So this was a bit of a
trick question because yes, you should prefer round-nearest, but it
nicely shows the complexity of the topic.)

> > For a quick (and maybe unreliable) overview:
> >=20
> > 	$ git grep -l _CLOSEST drivers/pwm/ | wc -l
> > 	15
> >=20
> > so we might have 15 drivers that round to nearest and the remaining 40
> > round down. (I checked a few and didn't find a false diagnose.)
> >=20
> > For me this isn't a clear indication that round-nearest is
> > unconditionally better.
>=20
> Just because some drivers don't use DIV_ROUND_CLOSEST() doesn't mean
> it was considered by the driver author.
>=20
> I think some drivers use DIV_ROUND_UP, e.g. pwm-sl28cpld.c.

Yes, still the intention there (see the comment above DIV_ROUND_UP) is
to round down the period. And rounding up the prescaler is right because
a bigger divisor yields a lower period.
=20
> So there is no concensus between the pwm drivers as to what should be the
> default.

yes. And that's mostly because for a long time nobody cared for
uniformity. Since some time I ensure for new drivers that they implement
round-down, but touching older drivers is difficult because often there
is no contact to someone who can test it, and even if there is someone,
this doesn't mean others don't depend on the current behaviour.

So this is kind of a chicken-and-egg problem. We should provide the
option to consumers to choose their preferred rounding, but adding an
API function with having lowlevel drivers implementing different
behaviour is quite hard.

> > What is the fact that convinces you that
> > round-nearest is better in general?
>=20
> Surely the general use-case is match frequency (or period!) as closely
> as possible.

Sounds tempting, but I'm not convinced enough to think this to be
universally right.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wdm6e7mw35nruoak
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/L3pMACgkQwfwUeK3K
7AnZkAf8CWkUZ4jB7r7cV/9xR10+Dq4piFgIr1YpKGDX5BR7o0wmgjQPYsFSy+MJ
KO9UpEcp3g8F6ai27brZVm0EsJD3zXvnTjPTu7HI2nqbp2bfanOBesg5LGTMxWtB
tZqcFAMI5ldl71eZuPqjCd9DNxnUeLtD2EU031lSGfD8kzBz5d6LcOmi2mx6bg5R
N+jEMdQACTF/pCYt3jjfNHaP1LAadtQIFW/dRWN/C2xrFQFk/Xmi6VVSbdWig10J
2C/nSVHImGFuZs5B9bOK1CUqRBErx8oyhrJeaiotPh5PiAwW1XTMIG6hfZwFGwOq
WVKtWjqLSj910cRBDTM1llUxW7MPMg==
=kEAS
-----END PGP SIGNATURE-----

--wdm6e7mw35nruoak--
