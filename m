Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5D63C6424
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Jul 2021 21:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbhGLTw3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Jul 2021 15:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbhGLTw2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Jul 2021 15:52:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FD8C0613DD
        for <linux-pwm@vger.kernel.org>; Mon, 12 Jul 2021 12:49:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m31vu-0001AJ-7X; Mon, 12 Jul 2021 21:49:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m31vt-00063R-13; Mon, 12 Jul 2021 21:49:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m31vs-0008SH-WD; Mon, 12 Jul 2021 21:49:37 +0200
Date:   Mon, 12 Jul 2021 21:49:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210712194933.t2oui3wzocfzeatk@pengutronix.de>
References: <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
 <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
 <20210629083144.53onthkcchbk73lo@pengutronix.de>
 <a4943aa5-956c-1820-3489-994f0812c3a7@seco.com>
 <20210629205102.wtnhdlqdbkihi4mz@pengutronix.de>
 <dab8407a-7cff-392c-46b7-effc8ee7ecff@seco.com>
 <20210630083513.gi3yql5u3tzuub3e@pengutronix.de>
 <ddd2ad0c-1dff-c437-17a6-4c7be72c2fce@seco.com>
 <20210708194312.d4gjf6plvk2535yt@pengutronix.de>
 <ad61c979-62e0-d2e4-7d20-72304e515ded@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u63wreuahwjue43z"
Content-Disposition: inline
In-Reply-To: <ad61c979-62e0-d2e4-7d20-72304e515ded@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--u63wreuahwjue43z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Mon, Jul 12, 2021 at 12:26:47PM -0400, Sean Anderson wrote:
> On 7/8/21 3:43 PM, Uwe Kleine-K=F6nig wrote:
> > Hello Sean,
> >=20
> > On Thu, Jul 08, 2021 at 12:59:18PM -0400, Sean Anderson wrote:
> > > And what if the consumer comes and requests 49 for their period in the
> > > first place? You have the same problem. The rescaling made it worse in
> > > this instance, but this is just an unfortunate case study.
> >=20
> > I cannot follow. There are cases that are easy and others are hard.
> > Obviously I presented a hard case, and just because there are simpler
> > cases, too, doesn't mean that implementing the algorithm that must cover
> > all cases becomes simple, too. Maybe I just didn't understand what you
> > want to say?!
>=20
> My point is that you cannot just pick a bad case and call the whole
> process poor.

Yeah, there are surprises with both approaches. My point is mostly that
if you cannot prevent these surprises with a more complicate algorithm,
then better live with the surprises and stick to the simple algorithm.

(For the sake of completeness: If the request for my 16.4 ns PWM was

	.period =3D 100 ns
	.duty_cycle =3D 49 ns

the hardware should be configured with

	.period =3D 98.4 ns
	.duty_cycle =3D 32.8 ns

=2E The key difference to the scaling approach is: The computation is easy
and it's clear how it should be implemented. So I don't see how my
approach yields problems.)

> I can do the same thing for your proposed process.
> In any case, I don't wish to propose that drivers do rescaling in this
> manner; I hoped that my below discussion had made that clear.

Yes, After reading the start of your mail I was positively surprised to
see you reasoning for nearly the same things as I do :-)

> Though I really would like if we could pick a different name for "the
> duration of the initial part of the PWM's cycle". I know "high time" is
> not strictly correct for inverted polarity, but duty cycle refers to
> percentage everywhere but the Linux kernel...

"active time" would be a term that should be fine. But I think
"duty-cycle" in contrast to "relative duty-cycle" is fine enough and
IMHO we should keep the terms as they are.

> > > * Hypothetical future users of some kind of round_state function. The=
se
> > >   users have some kind of algorithm which determines whether a PWM st=
ate
> > >   is acceptable for the driver. Most of the time this will be some ki=
nd
> > >   of accuracy check. What the round_state function returns is not
> > >   particularly important, because users have the opportunity to revise
> > >   their request based on what the state is rounded to. However, it is
> > >   important that each round rate function is consistent in manner that
> > >   it rounds so that these users
> >=20
> > This sentence isn't complete, is it?
>=20
> this should be finished like
>=20
> 	... can manipulate it programmatically.

Then ack.

> > > * The apply_state function shall only round the requested period down=
, and
> > >   may do so by no more than one unit cycle. If the requested period is
> > >   unrepresentable by the PWM, the apply_state function shall return
> > >   -ERANGE.
> >=20
> > I don't understand what you mean by "more than one unit cycle", but
> > that doesn't really matter for what I think is wrong with that
> > approach: I think this is a bad idea if with "apply_state" you mean
> > the callback each driver has to implement: Once you made all drivers
> > conformant to this, someone will argue that one unit cycle is too
> > strict.
>=20
> The intent here is to provide guidance against drivers which round
> excessively. That is, a driver which always rounded down to its minimum
> period would not be very interesting. And neither would a driver which
> did not make a very good effort (such as always rounding to multiples of
> 10 when it could round to multiples of 3 or whatever). So perhaps
> s/shall/should/.

Ah, that's what I formalized as "return the *biggest possible* period
not bigger than the request". fine.
=20
> > Or that it's ok to increase the period iff the duty_cycle is 0.
>=20
> IMO it doesn't matter what the period is for a duty cycle of 0 or 100.
> Whatever policy we decide on, the behavior in that case will

So it might even be you who thinks that the request

	.period =3D 15
	.duty_cycle =3D 0

should not be refused just because the smallest implementable period is
16.4 ns :-)

> > Then you have to adapt all 50 or so drivers to adapt the policy.
>=20
> Of course, as I understand it, this must be done for your policy as
> well.

Well to be fair, yes. But the advantage of my policy is that it
returns success in more situations and so the core (and so the consumer)
can work with that in more cases.

> > Better let .apply_state() do the same as .round_state() and then you can
> > have in the core (i.e. in a single place):
> >=20
> > 	def pwm_apply_state(pwm, state):
> > 	    rounded_state =3D pwm_round_state(pwm, state)
> > 	    if some_condition(rounded_state, state):
> > 	    	return -ERANGE
> > 	    else:
> > 	    	pwm->apply(pwm, state)
> >=20
> > Having said that I think some_condition should always return False, but
> > independant of the discussion how some_condition should actually behave
> > this is definitively better than to hardcode some_condition in each
> > driver.
>=20
> And IMO the condition should just be "is the period different"?

So a request of .period =3D X must result in a real period that's bigger
than X - 1 and not bigger than X, correct?

> I think a nice interface for many existing users would be something like
>=20
>         # this ignores polarity and intermediate errors, but that should
>         # not be terribly difficult to add
>         def pwm_apply_relative_duty_cycle(pwm, duty_cycle, scale):
>             state =3D pwm_get_state(pwm)
>             state.enabled =3D True
>             state =3D pwm_set_relative_duty_cycle(state, duty_cycle, scal=
e)
>             rounded_state =3D pwm_round_state(pwm, state)
>             if rounded_state.period !=3D state.period:
>                 state =3D pwm_set_relative_duty_cycle(rounded_state, duty=
_cycle, scale)
>                 rounded_state =3D pwm_round_state(pwm, state)

This should be rounded_state, right?! -----------------^^^^^

>             if duty_cycle and not rounded_state.duty_cycle:
>                 return -ERANGE
>             return pwm_apply_state(pwm, rounded_state)

(Fixed tabs vs space indention)

I oppose to the duty_cycle and not rounded_state.duty_cycle check. Zero
shouldn't be handled differently to other values. If it's ok to round 32
ns down to 16.4 ns, rounding down 2 ns to 0 should be fine, too.

Also for these consumers it might make sense to allow rounding up
period, so if a consumer requests .period =3D 32 ns, better yield 32.8 ns
instead of 16.4 ns.

> which of course could be implemented both with your proposed semantics
> or with mine.

Yeah, and each pwm_state that doesn't yield an error is an advantage.
(OK, you could argue now that period should be round up if a too small
value for period is requested. That's a weighing to reduce complexity in
the lowlevel drivers.)

> > > * The apply_state function shall only round the requested duty cycle
> > >   down. The apply_state function shall not return an error unless the=
re
> > >   is no duty cycle less than the requested duty cycle which is
> > >   representable by the PWM.
> >=20
> > ack. (Side note: Most drivers can implement duty_cycle =3D 0, so for th=
em
> > duty_cycle isn't a critical thing.)
>=20
> Yes, and unfortunately the decision is not as clear-cut as for period.

Oh, note that up to now we consider different options as the right thing
to do with period. That's not what I would call clear-cut :-)

> > > * After applying a state returned by round_state with apply_state,
> > >   get_state must return that state.
> >=20
> > ack.
> >=20
> > > The reason that we must return an error when the period is
> > > unrepresentable is that generally the duty cycle is calculated based =
on
> > > the period. This change has no affect on future users of round_state,
> > > since that function will only return valid periods. Those users will
> > > have the opportunity to detect that the period has changed and determ=
ine
> > > if the duty cycle is still acceptable.
> >=20
> > ack up to here.
> >=20
> > > However, for existing users, we
> > > should also provide the same opportunity.
> >=20
> > Here you say: If the period has changed they should get a return value
> > of -ERANGE, right? Now what should they do with that. Either they give
> > up (which is bad)
>=20
> No, this is exactly what we want. Consider how period is set. Either
> it is whatever the default is (e.g. set by PoR or the bootloader), in
> which case it is a driver bug if we think it is unrepresentable, or it
> is set from the device tree (or platform info), in which case it is a
> bug in the configuration. This is not something like duty cycle where
> you could make a case depending on the user, but an actual case of
> misconfiguration.

That is very little cooperative. The result is that the pwm-led driver
fails to blink because today the UART driver was probed before the
pwm-led and changed a clk in a way that the pwm-led cannot achieve the
configured period any more.

> > or they need to resort to pwm_round_state to
> > find a possible way forward. So they have to belong in the group of
> > round_state users and so they can do this from the start and then don't
> > need to care about some_condition at all.
> >=20
> > > This requirement simplifies
> > > the behavior of apply_state, since there is no longer any chance that
> > > the % duty cycle is rounded up.
> >=20
> > This is either wrong, or I didn't understand you. For my hypothetical
> > hardware that can implement periods and duty_cycles that are multiples
> > of 16.4 ns the following request:
> >=20
> > 	period =3D 1650
> > 	duty_cycle =3D 164
> >=20
> > (with relative duty_cycle =3D 9.9393939393939 %)
> > will be round to:
> >=20
> > 	period =3D 1640
> > 	duty_cycle =3D 164
> >=20
> > which has a higher relative duty_cycle (i.e. 10%).
>=20
> This is effectively bound by the clause above to be no more than the
> underlying precision of the PWM.  Existing users expect to be able to
> pass unrounded periods/duty cycles, so we need to round in some manner.
> Any way we round is OK, as long as it is not terribly excessive (hence
> the clause above). We could have chosen to round up (and in fact this is
> exactly what happens for inverted polarity PWMs). But I think that for
> ease of implementation is is better to mostly round in the same manner
> as round_state.
>=20
> > > This requirement is easy to implement in
> > > drivers as well. Instead of writing something like
> > >=20
> > > 	period =3D clamp(period, min_period, max_period);
> > >=20
> > > they will instead write
> > >=20
> > > 	if (period < min_period || period > max_period)
> > > 		return -ERANGE;
> >=20
> > Are you aware what this means for drivers that only support a single
> > fixed period?
>=20
> This is working as designed. Either the period comes from configuration
> (e.g. pwm_init_state), which is specialized to the board in question, in
> which case it is OK to return an error because the writer of the dts
> either should leave it as the default or specify it correctly, or it
> comes from pwm_get_state in which case it is a driver error for
> returning a a period which that driver cannot support.
>=20
> There are two exceptions to the above. First, a fixed period PWM driver
> could have its period changed by the parent clock frequency changing.
> But I think such driver should just clk_rate_exclusive_get because
> otherwise all bets are off. You just have to hope your consumer doesn't
> care about the period.
>=20
> The other exception is pwm_clk. In this case, I think it is reasonable
> to pass an error on if the user tries to change the frequency of what is
> effectively a fixed-rate clock.
>=20
> > I still think it should be:
> >=20
> > 	if (period < min_period)
> > 		return -ERANGE;
> > =09
> > 	if (period > max_period)
> > 		period =3D max_period;
> >=20
> > There are two reasons for this compared to your suggestion:
> >=20
> >   a) Consider again the 16.4 ns driver and that it is capable to
> >      implement periods up to 16400 ns. With your approach a request of
> >      16404 ns will yield -ERANGE.
> >      Now compare that with a different 16.4 ns driver with max_period =
=3D
> >      164000 ns. The request of 16404 ns will yield 16400 ns, just becau=
se
> >      this driver could also do 16416.4 ns. This is strange, because the
> >      possibility to do 16416.4 ns is totally irrelevant here, isn't it?
>=20
> Ah, it looks like I mis-specified this a little bit. My intent was
>=20
> 	The apply_state function shall only round the requested period
> 	down, and should do so by no more than one unit cycle. If the
> 	period *rounded as such* is unrepresentable by the PWM, the
> 	apply_state function shall return -ERANGE.

I don't understand "one unit cycle". What is a unit cycle for a PWM that
can implement periods in the form 10 s / X for X in [1, ... 4096]? What
is a unit cycle for a fixed period PWM?

> >   b) If a consumer asked for a certain state and gets back -ENORANGE th=
ey
> >      don't know if they should increase or decrease the period to guess=
 a
> >      state that might be implementable instead.
>=20
> Because I believe this is effectively a configuration issue, it should
> be obvious to the user which direction they need to go. Programmatic
> users which want to automatically pick a better period would need to use
> round_state instead.

You only consider consumers with a fixed period. Do you want to
explicitly configure all possible periods for a a driver that uses ~ 50%
relative duty cycle but varies period (e.g. the pwm-ir-tx driver)?
(OK, these drivers could use pwm_round_rate(), but then that argument
could be applied to all consumers and the result of an unrounded request
doesn't really matter any more.)

> > (Hmm, or are you only talking about .apply_state and only .round_state
> > should do if (period < min_period) return -ERANGE; if (period >
> > max_period) period =3D max_period;?
>=20
> Yes.

I really want to have .apply_state() and .round_state() to behave
exactly the same. Everything else I don't want to ask from driver
authors. I don't believe you can argue enough that I will drop this
claim.

> > If so, I'd like to have this in the framework, not in each driver.
> > Then .round_state and .apply_state can be identical which is good for
> > reducing complexity.)
>=20
> So you would like each PWM driver to have a "max_period" and
> "min_period" parameter?

No, I don't want this explicitly. What did I write to make you think
that? With .round_state() these values can be found out though.

> And what if the clock rate changes? Otherwise, how do you propose that
> the framework detect when a requested period is out of range?

I call round_rate() with

	.period =3D requested_period
	.duty_cycle =3D requested_period

and if that returns -ERANGE the PWM doesn't support this rate (and
smaller ones). And a big requested period is never out of range.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u63wreuahwjue43z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDsnMoACgkQwfwUeK3K
7Ako/gf/VXeC5ohPNr3Uqj7WNfpVxilZ5m0xnHZdYUSFqDCLt5oj1VYCRkJK55WR
l/fXJIM2gHaNwP9+EhTUCwqRGDbzOCmNXYGYarTRQ6Hz7ONzTJ9x7YWGccmYoM2w
OTSlrTZCk/bLwYDjV3voBFlKiXCxwusPu1J8RndvdcZ0ZqGmUYfUclqKFK27V3/L
qKgpvyaBzyfe83XyoaV+XIsWlEYUN/XO2nIN3xsRHRAJzdA36GQ0Xf4MOuhSib8s
nOxl4inW5nBLNEK7x9cGhXqTbiIx8QdxKWsey3E8QMdpsiaHhiCwKgvhWlGpf2p0
KK6fEEuo1r1wSsy0Q6T7v6TkNXqOuQ==
=amRf
-----END PGP SIGNATURE-----

--u63wreuahwjue43z--
