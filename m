Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8B23475AF
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Mar 2021 11:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhCXKRA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 Mar 2021 06:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhCXKQu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Mar 2021 06:16:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BEAC061763
        for <linux-pwm@vger.kernel.org>; Wed, 24 Mar 2021 03:16:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP0ZE-000077-VB; Wed, 24 Mar 2021 11:16:48 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lP0ZE-000521-4p; Wed, 24 Mar 2021 11:16:48 +0100
Date:   Wed, 24 Mar 2021 11:16:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de, Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v3] pwm: Soften potential loss of precision in compat code
Message-ID: <20210324101646.ejy3ngobtjl6tmz4@pengutronix.de>
References: <20210315080050.2337075-1-u.kleine-koenig@pengutronix.de>
 <YFh7uCgeir4L+ZTf@orome.fritz.box>
 <20210322112947.iru2dj3yggkhecwl@pengutronix.de>
 <YFiKY7nrIDj+ZD47@orome.fritz.box>
 <20210322154659.vwlavhpacfp5rdpw@pengutronix.de>
 <YFo0Q1DHZbwfFzxG@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wd3qgze5dotremvm"
Content-Disposition: inline
In-Reply-To: <YFo0Q1DHZbwfFzxG@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wd3qgze5dotremvm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

TL;DR: If you think my suggested algorithm to implement which setting to
implement for a given request is bad, please provide a better one.

On Tue, Mar 23, 2021 at 07:32:35PM +0100, Thierry Reding wrote:
> On Mon, Mar 22, 2021 at 04:46:59PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 22, 2021 at 01:15:31PM +0100, Thierry Reding wrote:
> > > On Mon, Mar 22, 2021 at 12:29:47PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > No, the strategy I ask authors of new drivers to implement is to pr=
ogram
> > > > the biggest possible period not bigger than the requested period. S=
o if
> > > > a consumer requests INT_MAX+3 it must already today cope with the c=
ase
> > > > that it gets a smaller period.
> > >=20
> > > That just seems wrong. I mean to a degree this might be sensible, but
> > > the way you do this here it's completely out of hands. What if somebo=
dy
> > > tries to configure this?
> >=20
> > The charm it has is that it is simple and doesn't cut somewhere
> > arbitrary.
> >=20
> > > 	duty-cycle: 0x0000000100000000
> > > 	period:     0x0000000200000000
> > >=20
> > > Clearly what they were aiming for is a 50% duty-cycle, but with your
> > > proposal, this will now result in a 100% duty-cycle, which is cleary =
not
> > > what's requested here.
> >=20
> > OK, can you please formally describe how a hardware driver author should
> > detect these clear aims? Some document that for any given request and
> > any given hardware capability tells what setting to pick would be great.
> >=20
> > Assume that the longest 50% setting some driver can implement is
> > duty_cycle =3D 0x7fffffff ns + period =3D 0xfffffffe ns. What is the bi=
ggest
> > duty_cycle + period where you want 0x7fffffff + 0xfffffffe to be
> > configured?
> >=20
> > I expect that anything that targets to be practically better than my
> > approach is damned to be complicated, arbitrary and still doesn't catch
> > all clear aims. Still more because "clear aims" is something that is
> > subjective to each developer. And assume you really produce a recipe
> > that clearly dissects between "round a little bit" and "clearly not what
> > was requested", do you really want to implement that in each and every
> > low level driver? I don't, this would be a maintenance mess.
> >=20
> > So that's why I think we need pwm_round_state with *easy* rules.
> >=20
> > And given that this easy (and admittedly practically imperfect) rule
> > was "Use the biggest possible period not bigger than requested" and I
> > still consider this a good choice, clamping instead of returning an
> > error is still the right choice in my eyes.
> >=20
> > > That's different, in my opinion, from a case where you may have to ro=
und
> > > a little bit and get a deviation of, say, 1% in the resulting signal.
> >=20
> > Let's assume "1% deviation is ok" is to become the golden rule. If
> > the nearest possibility to satisfy the request
> >=20
> > 	.duty_cycle =3D 1000 ns
> > 	.period =3D 2000 ns
> >=20
> > was
> >=20
> > 	.duty_cycle =3D 1010 ns
> > 	.period =3D 1980 ns
> >=20
> > would this be within the 1% rule or wouldn't it? (The relative duty
> > cycle is > 51% and so it's off by > 2%, but the individual values differ
> > by just 1%.) Or should we prefer
> >=20
> > 	.duty_cycle =3D 1010 ns
> > 	.period =3D 2030 ns
> >=20
> > where the period is off by more than 1% but the relative duty_cycle is
> > actually nearer to the "clearly requested" 50%?
>=20
> No matter where you draw the line, you're always going to be able to
> find a case like that. But that's completely besides the point.

IMHO it's not besides the point. You say yielding 0x7fffffff/0x7fffffff
when 0x100000000/0x200000000 was requested is bad and you want it to be
refused. To actually implement this refusal we have to draw a line
somewhere. Should we say for a legacy driver (that only supports ints as
values) that everything that doesn't fit into an int is invalid? So
period =3D 0x80000000 is refused independent of the question what is the
highest supportable period of the driver in use? What about out-of-range
for small values? If a consumer requests a period of 1ms but the driver
cannot provide that, should it refuse, too? How should a consumer know
if the driver can only do smaller or bigger periods? How can a consumer
find a request that the driver can fulfill in general?

Saying "This case is ridiculus" is easy (and I agree), but can you
please make a practical suggestion, how out-of-range requests should be
handled that gives enough information to actually implement it? Just
giving examples that are out of range is not enough.

With my suggested algorithm (i.e.: First pick the highest supported
period not bigger than the requested period, then pick the highest
supported duty_cycle not bigger than the requested duty_cycle) there are
results that are way off, yes. But together with a round_state function
consumers can know beforehand and there is an (more or less) effective
way for a consumer to pick the best configuration no matter what "best"
means for this particular consumer. Together with the fact that this
algorithm is simple for lowlevel drivers this convinces me that it is a
good strategy and I believe all other strategies are worse when
considering both sensibility and code complexity.

> I'm not suggesting any solutions here to the problem of drivers
> guessing what's right or of consumers detecting what drivers will set.
>=20
> What I'm objecting to here is essentially ignoring what the user has
> requested and doing something close to arbitrary instead. This might
> yield a reasonable result in some cases but it can just as easily be
> complete nonsense.

As written above: These two things are essentially the same thing. To
let a driver judge how to respond to a given request that it cannot
fulfil exactly we need an algorithm that decides between "No, this is
too far off, return an error code" and "The configuration nearest to the
request is fine, configure that one."

(But note, this isn't even enough. Consider a driver that can provide
all combinations of period and duty_cycle where both values are a
multiple of 3ns (and duty_cycle <=3D period of course). What should be
chosen if period=3D32ns, duty_cycle=3D16ns is requested? Is it period=3D33n=
s +
duty_cycle=3D15ns because that's the nearest rounding? Or should it be
period=3D30ns+duty_cycle=3D15ns to hit the obviously wanted 50%? Or should
it be refused, because yielding 33 when 32 was requested is off by more
than 1%? So additionally we need a formal definition of "nearest".)

> If the requested values are outside of the supported range we should
> just reject the request and be done with it. Then there's no need to
> even attempt guessing what might have been the intention. Instead we
> let the user deal with the problem and provide values that are
> supported.

OK, so if a hardware supports say the following period lengths:

=09
	1000/3 ns, 2000/3 ns, 4000/3 ns, 8000/3 ns,
	16000/3 ns, 32000/3 ns, 64000/3 ns, 128000/3 ns

you want to have:

	if requested_period <=3D 333 ns or requested_period >=3D 42667 ms:
	    return -EINVAL

, right? So when a consumer request 42667 they get -EINVAL (while the
driver can do 42666.666) and if they request 32000 they get 21333.333?

If you request a period of 3000 ns and your driver's only possible
period is 2800 ns, you get -EINVAL, right? If however the driver
supports 2800 ns and 5600 ns you get 2800 ns? If a driver only supports
a period of 6553.5 ns, what should I actually request to get this,
because mathematically both 6553 and 6554 are out of range? What if the
single supportable period is 6553.6 ns or 6553.4?

In sum I think whatever algorithm is picked, there are ridiculous cases.
So lets pick a strategy that is at least simple to implement, doesn't
require to adapt a driver if a consumer appears that has a different
metric of "best" and allows to find a best match no matter what best
means today for the consumer in question.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wd3qgze5dotremvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBbEYsACgkQwfwUeK3K
7AmkuwgAm6B6GYMprsLEvCAtSew8h4ySV3cMT/TtnSGm9MNWKpzmS8oIE7B20R2r
17ZklI2KXmOPjS34OgsmlmmzK02pxnKbZ69PXCdLGeB9370EHaL4v+uknOPy+Swp
Rni+PxcIDVYjpIKSwTQWsPFA1du4q+OOJRyWjRSwguATOopxz/ipu6N0FY5K6cyR
nPML5g67sGa+Uq3ZOmukEQUCSMvAektSOAN+zp6orkrr4Ko2bq/LcdGxLgjt7KAt
bbkuAlm1ESYPjrh0sHtpg0uJqsmzc2RBko1yE0jC9vZaXEEQqigS5grHqQx86YTc
/smTK921wYaESdlDeyfN4QWZnVrhVw==
=wGm2
-----END PGP SIGNATURE-----

--wd3qgze5dotremvm--
