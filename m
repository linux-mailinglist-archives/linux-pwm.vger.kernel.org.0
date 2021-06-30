Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984B23B7F1A
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 10:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhF3Ihq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Jun 2021 04:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhF3Ihp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Jun 2021 04:37:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D74C061756
        for <linux-pwm@vger.kernel.org>; Wed, 30 Jun 2021 01:35:16 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyVgg-0006dI-R3; Wed, 30 Jun 2021 10:35:14 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyVgf-0003eC-R5; Wed, 30 Jun 2021 10:35:13 +0200
Date:   Wed, 30 Jun 2021 10:35:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210630083513.gi3yql5u3tzuub3e@pengutronix.de>
References: <20210627181919.iunagls4j67ignhh@pengutronix.de>
 <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
 <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
 <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
 <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
 <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
 <20210629083144.53onthkcchbk73lo@pengutronix.de>
 <a4943aa5-956c-1820-3489-994f0812c3a7@seco.com>
 <20210629205102.wtnhdlqdbkihi4mz@pengutronix.de>
 <dab8407a-7cff-392c-46b7-effc8ee7ecff@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="czszgzwfssnh7tid"
Content-Disposition: inline
In-Reply-To: <dab8407a-7cff-392c-46b7-effc8ee7ecff@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--czszgzwfssnh7tid
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

I often mistype the name of the rounding function as "pwm_round_rate",
the better name is "pwm_round_state" of course. That's just me thinking
about clk_round_rate where ".._rate" is the right term. I'll try harder
to get this right from now on.

On Tue, Jun 29, 2021 at 06:21:15PM -0400, Sean Anderson wrote:
> On 6/29/21 4:51 PM, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jun 29, 2021 at 02:01:31PM -0400, Sean Anderson wrote:
> > > On 6/29/21 4:31 AM, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Jun 28, 2021 at 01:41:43PM -0400, Sean Anderson wrote:
> > > >> On 6/28/21 1:20 PM, Uwe Kleine-K=F6nig wrote:
> > > >> > On Mon, Jun 28, 2021 at 12:35:19PM -0400, Sean Anderson wrote:
> > > >> >> On 6/28/21 12:24 PM, Uwe Kleine-K=F6nig wrote:
> > > >> >> > On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
> > > >> >> > > On 6/27/21 2:19 PM, Uwe Kleine-K=F6nig wrote:
> > > >> >> > > > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson w=
rote:
> > > >> >> > > IMO, this is the best way to prevent surprising results in =
the API.
> > > >> >> >
> > > >> >> > I think it's not possible in practise to refuse "near" misses=
 and every
> > > >> >> > definition of "near" is in some case ridiculous. Also if you =
consider
> > > >> >> > the pwm_round_state() case you don't want to refuse any reque=
st to tell
> > > >> >> > as much as possible about your controller's capabilities. And=
 then it's
> > > >> >> > straight forward to let apply behave in the same way to keep =
complexity
> > > >> >> > low.
> > > >> >> >
> > > >> >> > > The real issue here is that it is impossible to determine t=
he correct
> > > >> >> > > way to round the PWM a priori, and in particular, without c=
onsidering
> > > >> >> > > both duty_cycle and period. If a consumer requests very sma=
ll
> > > >> >> > > period/duty cycle which we cannot produce, how should it be=
 rounded?
> > > >> >> >
> > > >> >> > Yeah, because there is no obviously right one, I picked one t=
hat is as
> > > >> >> > wrong as the other possibilities but is easy to work with.
> > > >> >> >
> > > >> >> > > Should we just set TLR0=3D1 and TLR1=3D0 to give them 66% d=
uty cycle with
> > > >> >> > > the least period? Or should we try and increase the period =
to better
> > > >> >> > > approximate the % duty cycle? And both of these decisions m=
ust be made
> > > >> >> > > knowing both parameters. We cannot (for example) just alway=
s round up,
> > > >> >> > > since we may produce a configuration with TLR0 =3D=3D TLR1,=
 which would
> > > >> >> > > produce 0% duty cycle instead of whatever was requested. Ro=
unding rate
> > > >> >> > > will introduce significant complexity into the driver. Most=
 of the time
> > > >> >> > > if a consumer requests an invalid rate, it is due to miscon=
figuration
> > > >> >> > > which is best solved by fixing the configuration.
> > > >> >> >
> > > >> >> > In the first step pick the biggest period not bigger than the=
 requested
> > > >> >> > and then pick the biggest duty cycle that is not bigger than =
the
> > > >> >> > requested and that can be set with the just picked period. Th=
at is the
> > > >> >> > behaviour that all new drivers should do. This is somewhat ar=
bitrary but
> > > >> >> > after quite some thought the most sensible in my eyes.
> > > >> >>
> > > >> >> And if there are no periods smaller than the requested period?
> > > >> >
> > > >> > Then return -ERANGE.
> > > >>
> > > >> Ok, so instead of
> > > >>
> > > >> 	if (cycles < 2 || cycles > priv->max + 2)
> > > >> 		return -ERANGE;
> > > >>
> > > >> you would prefer
> > > >>
> > > >> 	if (cycles < 2)
> > > >> 		return -ERANGE;
> > > >> 	else if (cycles > priv->max + 2)
> > > >> 		cycles =3D priv->max;
> > > >
> > > > The actual calculation is a bit harder to handle TCSR_UDT =3D 0 but=
 in
> > > > principle, yes, but see below.
> > > >
> > > >> But if we do the above clamping for TLR0, then we have to recalcul=
ate
> > > >> the duty cycle for TLR1. Which I guess means doing something like
> > > >>
> > > >> 	ret =3D xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period=
);
> > > >> 	if (ret)
> > > >> 		return ret;
> > > >>
> > > >> 	state->duty_cycle =3D mult_frac(state->duty_cycle,
> > > >> 				      xilinx_timer_get_period(priv, tlr0, tcsr0),
> > > >> 				      state->period);
> > > >>
> > > >> 	ret =3D xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_c=
ycle);
> > > >> 	if (ret)
> > > >> 		return ret;
> > > >
> > > > No, you need something like:
> > > >
> > > > 	/*
> > > > 	 * The multiplication cannot overflow as both priv_max and
> > > > 	 * NSEC_PER_SEC fit into an u32.
> > > > 	 */
> > > > 	max_period =3D div64_ul((u64)priv->max * NSEC_PER_SEC, clkrate);
> > > >
> > > > 	/* cap period to the maximal possible value */
> > > > 	if (state->period > max_period)
> > > > 		period =3D max_period;
> > > > 	else
> > > > 		period =3D state->period;
> > > >
> > > > 	/* cap duty_cycle to the maximal possible value */
> > > > 	if (state->duty_cycle > max_period)
> > > > 		duty_cycle =3D max_period;
> > > > 	else
> > > > 		duty_cycle =3D state->duty_cycle;
> > >=20
> > > These caps may increase the % duty cycle.
> >=20
> > Correct.
> >=20
> > For some usecases keeping the relative duty cycle might be better, for
> > others it might not. I'm still convinced that in general my solution
> > makes sense, is computationally cheaper and easier to work with.
>=20
> Can you please describe one of those use cases? Every PWM user I looked
> (grepping for pwm_apply_state and pwm_config) set the duty cycle as a
> percentage of the period, and not as an absolute time. Keeping the high
> time the same while changing the duty cycle runs contrary to the
> assumptions of all of those users.

Indeed there is no mainline driver that relies on this. There are some
smart LED controllers (e.g. WS2812B) where the duty_cycle is more
important than the period. (I admit a PWM is not really the right driver
for that one as it could only completely enable and complete disable
white color.) Also there are some servo motor chips where the absolute
duty is relevant but the period isn't (in some range). (See
https://www.mikrocontroller.net/articles/Modellbauservo_Ansteuerung#Signala=
ufbau
for a article about that (in German though).)

In case you want to argue that out-of-mainline users don't count: I
think in the design of an API they do count to place the bar to enter
the mainline low. Frameworks should be generic enough to cover as much
use cases as possible.

And note that if you want a nearest to (say) 50% relative duty cycle and
don't care much about the period it doesn't really matter if you scale
duty_cycle in pwm_round_state() to the period change or not because in
general you need several calls to pwm_round_state() anyhow to find a
setting with 51% if the next lower possibility is 47%. So in the end you
save (I think) one call in generic PWM code.

In contrast the math gets quite a bit more complicated because there is
rounding involved in scaling the duty cycle. Consider a PWM that can
configure period and duty in 16.4 ns steps and you ask for

	.period =3D 100 ns
	.duty_cycle =3D 50 ns

Then the best period you can provide is 98.4 ns, so you return .period =3D
99 from pwm_round_state(). (Yes, you don't return 98, because
round-nearest is much harder to handle than round down.) To determine
the adapted duty_cycle you have to do

	50 * realperiod / 100

which independently of choosing 98, 98.4 or 99 for realperiod is 49. Then
to approximate 49 without rounding up you end up with 32.8 while 49.2
would have be perfectly fine.

You might find a way around that (maybe you have to round up in the
adaption of duty_cycle, I didn't convince myself this is good enough
though).

So your suggestion to adapt the duty_cycle to keep the relative
duty_cycle constant (as good as possible within the bounds the hardware
dictates) implies additional complication at the driver level.

=46rom a framework maintainer's point of view (and also from a low-level
driver maintainer's point of view) I prefer one complication in a
generic function over a complication that I have to care for in each and
every low-level driver by a big margin.

So unless you volunteer to complete the math above and promise to review
low-level drivers for that aspect in the future (or alternatively
convince me that math is easy and I missed something) I would like to
end this discussion here and stay with the policy I explained.

> > > > 	period_cycles =3D period * clkrate / NSEC_PER_SEC;
> > > >
> > > > 	if (period_cycles < 2)
> > > > 		return -ERANGE;
> > > >
> > > > 	duty_cycles =3D duty_cycle * clkrate / NSEC_PER_SEC;
> > > >
> > > > 	/*
> > > > 	 * The hardware cannot emit a 100% relative duty cycle, if
> > > > 	 * duty_cycle >=3D period_cycles is programmed the hardware emits
> > > > 	 * a 0% relative duty cycle.
> > > > 	 */
> > > > 	if (duty_cycle =3D=3D period_cycles)
> > > > 		duty_cycles =3D period_cycles - 1;
> > > >
> > > > 	/*
> > > > 	 * The hardware cannot emit a duty_cycle of one clk step, so
> > > > 	 * emit 0 instead.
> > > > 	 */
> > > > 	if (duty_cycles < 2)
> > > > 		duty_cycles =3D period_cycles;
> > >=20
> > > Of course, the above may result in 100% duty cycle being rounded down=
 to
> > > 0%. I feel like that is too big of a jump to ignore. Perhaps if we
> > > cannot return -ERANGE we should at least dev_warn.
> >=20
> > You did it again. You picked one single case that you consider bad but
> > didn't provide a constructive way to make it better.
>=20
> Sure I did. I suggested that we warn. Something like
>=20
> if (duty_cycles =3D=3D period_cycles)
> 	if (--duty_cycles < 2)
> 		dev_warn(chip->dev, "Rounding 100%% duty cycle down to 0%%; pick a long=
er period\n");
>=20
> or
>=20
> if (period_cycles < 2)
> 	return -ERANGE;
> else if (period_cycles < 10)
> 	dev_notice(chip->dev,
> 		   "very short period of %u cycles; duty cycle may be rounded to 0%%\n",
> 		   period_cycles);

Ah ok, so only a 100% jump warrants that warning. I think adding that
has no practical relevance, so I don't oppose to that. Add it if you
want. (But note that if it triggers indeed it might flood the kernel log
if your consumer wants to start a motor but notices it doesn't run fast
enough and so configures 100% in a tight loop. So I would recommend some
rate limiting.)

> Because 90% of the time, if a user requests such a short period it is
> due to a typo or something similar. And if they really are doing it
> intentionally, then they should just set duty_cycle=3D0.

Uh, don't you think that a warning that is wrong in 10% of the cases is
bad?

> > Assume there was already a pwm_round_state function (that returns the
> > state that pwm_apply_state would implement for a given request) Consider
> > a consumer that wants say a 50% relative duty together with a small
> > period. So it first might call:
> >=20
> > 	ret =3D pwm_round_rate(pwm, { .period =3D 20, .duty_cycle =3D 20, ... =
}, &rounded_state)
> >=20
> > to find out if .period =3D 20 can be implemented with the given PWM. If
> > this returns rounded state as:
> >=20
> > 	.period =3D 20
> > 	.duty_cycle =3D 0
> >=20
> > this says quite a lot about the pwm if the driver implements my policy.
> > (i.e.: The driver can do 20ns, but the biggest duty_cycle is only 0).
> > If however it returns -ERANGE this means (assuming the driver implements
> > the policy I try to convice you to be the right one) it means: The
> > hardware cannot implement 20 ns (or something smaller) and so the next
> > call probably tries 40 ns.
> >=20
> > With your suggested semantic -ERANGE might mean:
> >=20
> >   - The driver doesn't support .period =3D 20 ns
> >     (Follow up questions: What period should be tried next? 10 ns? 40
> >     ns? What if this returns -ERANGE again?)
> >   - The driver supports .period =3D 20 ns, but the biggest possible
> >     duty_cycle is "too different from 20 ns to ignore".
> >=20
> > Then how should the search continue?
>=20
> round_rate does not have to use the same logic as apply_state.

I want to have .round_state() and .apply() (i.e. the driver callbacks)
to behave identically. If we indeed come to the conclusion that
pwm_apply_state needs to have some precautions, I'd like to have them
implemented in pwm_apply_state() only and not in every driver.

> However, calling
>=20
> 	ret =3D pwm_apply_state(pwm, { .period =3D 20, .duty_cycle =3D 0, ... })
>=20
> should work just fine, as the caller clearly knows what they are getting
> into. IMO this is the best way to allow hypothetical round_rate users to
> find out the edges of the PWM while still protecting existing users.
>=20
> It's perfectly fine to round
>=20
> 	{ .period =3D 150, .duty_cycle =3D 75 }
>=20
> to
>=20
> 	{ .period =3D 100, .duty_cycle =3D 75 }
>=20
> in round_rate. But doing the same thing for apply_state would be very
> surprising to every existing PWM user.
>=20
> IMO the following invariant should hold
>=20
> 	apply_state(round_rate(x))
> 	assert(round_rate(x) =3D=3D get_state())

(merged your correction of the follow up mail into the quote above)

(Fun fact: Only needing this one would allow a generic implementation of
round_state, it just had to return a pwm_state that doesn't depend on x
:o)

> but the following should not necessarily hold
>=20
> 	apply_state(x)
> 	assert(round_rate(x) =3D=3D get_state())
>=20
> Of course, where it is reasonable to round down, we should do so.
>=20
> But where the result may be surprising, then the caller should specify
> the rounded state specifically. It is better to fail loudly and
> noisily than
> to silently accept garbage.

Can you please come up with an algorithm to judge if a given deviation
is reasonable or surprising? I agree there are surprises and some of
them are obviously bad. For most cases however the judgement depends on
the use case so I fail to see how someone should program such a check
that should cover all consumers and use cases. I prefer no precautions +
an easy relation between pwm_round_state and pwm_apply_state (i.e.
behave identically) over a most of the time(?) useless precaution and
some policy defined differences between pwm_round_state and
pwm_apply_state

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--czszgzwfssnh7tid
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDcLL4ACgkQwfwUeK3K
7Al/3Qf/TULcy0EdS9212IgOJGM5ZHq6DIEuMTcgtt3RxmqpQPh2r0SZYfxePzWa
ZzgCmy37FTP0C2L+RHD8pQ+rS2fA48E8daBG8hSO5YIMcqM1deAg+VIeP46fBK1e
mVfk4lZirlLhWd7Wo99k2tn3MlkDtz3cbIP1eVyPfz9+qA9u6M3zMJHYK0tM1wpG
xgKSO6JMlH10cwJZ3psV7sjw52fv7ntcV/JZOlq74Y34ixwQyV0eEzMEzZwVRNeX
ec7s6V/kKR1Pq0N0HlWAdj75pOZEfWx2fMEGPJfimwomde3o8/sJ2VpJFCToldrZ
afl37WwoaWZuunnqzNIS+NnA+AH8Fw==
=almK
-----END PGP SIGNATURE-----

--czszgzwfssnh7tid--
