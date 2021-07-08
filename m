Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA4A3C1A03
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jul 2021 21:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhGHTqA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Jul 2021 15:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhGHTqA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jul 2021 15:46:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0475C06175F
        for <linux-pwm@vger.kernel.org>; Thu,  8 Jul 2021 12:43:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1ZvW-0006k9-4e; Thu, 08 Jul 2021 21:43:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1ZvU-0003Pe-LK; Thu, 08 Jul 2021 21:43:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1ZvU-0000I7-K9; Thu, 08 Jul 2021 21:43:12 +0200
Date:   Thu, 8 Jul 2021 21:43:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210708194312.d4gjf6plvk2535yt@pengutronix.de>
References: <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
 <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
 <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
 <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
 <20210629083144.53onthkcchbk73lo@pengutronix.de>
 <a4943aa5-956c-1820-3489-994f0812c3a7@seco.com>
 <20210629205102.wtnhdlqdbkihi4mz@pengutronix.de>
 <dab8407a-7cff-392c-46b7-effc8ee7ecff@seco.com>
 <20210630083513.gi3yql5u3tzuub3e@pengutronix.de>
 <ddd2ad0c-1dff-c437-17a6-4c7be72c2fce@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hzcgv3mhm5yedjq6"
Content-Disposition: inline
In-Reply-To: <ddd2ad0c-1dff-c437-17a6-4c7be72c2fce@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hzcgv3mhm5yedjq6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Thu, Jul 08, 2021 at 12:59:18PM -0400, Sean Anderson wrote:
> On 6/30/21 4:35 AM, Uwe Kleine-K=F6nig wrote:
> > I often mistype the name of the rounding function as "pwm_round_rate",
> > the better name is "pwm_round_state" of course. That's just me thinking
> > about clk_round_rate where ".._rate" is the right term. I'll try harder
> > to get this right from now on.
> >=20
> > On Tue, Jun 29, 2021 at 06:21:15PM -0400, Sean Anderson wrote:
> > > On 6/29/21 4:51 PM, Uwe Kleine-K=F6nig wrote:
> > > > On Tue, Jun 29, 2021 at 02:01:31PM -0400, Sean Anderson wrote:
> > > > > On 6/29/21 4:31 AM, Uwe Kleine-K=F6nig wrote:
> > > > > > On Mon, Jun 28, 2021 at 01:41:43PM -0400, Sean Anderson wrote:
> > > > > >> On 6/28/21 1:20 PM, Uwe Kleine-K=F6nig wrote:
> > > > > >> > On Mon, Jun 28, 2021 at 12:35:19PM -0400, Sean Anderson wrot=
e:
> > > > > >> >> On 6/28/21 12:24 PM, Uwe Kleine-K=F6nig wrote:
> > > > > >> >> > On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson w=
rote:
> > > > > >> >> > > On 6/27/21 2:19 PM, Uwe Kleine-K=F6nig wrote:
> > > > > >> >> > > > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anders=
on wrote:
> > > > > >> >> > > IMO, this is the best way to prevent surprising results=
 in the API.
> > > > > >> >> >
> > > > > >> >> > I think it's not possible in practise to refuse "near" mi=
sses and every
> > > > > >> >> > definition of "near" is in some case ridiculous. Also if =
you consider
> > > > > >> >> > the pwm_round_state() case you don't want to refuse any r=
equest to tell
> > > > > >> >> > as much as possible about your controller's capabilities.=
 And then it's
> > > > > >> >> > straight forward to let apply behave in the same way to k=
eep complexity
> > > > > >> >> > low.
> > > > > >> >> >
> > > > > >> >> > > The real issue here is that it is impossible to determi=
ne the correct
> > > > > >> >> > > way to round the PWM a priori, and in particular, witho=
ut considering
> > > > > >> >> > > both duty_cycle and period. If a consumer requests very=
 small
> > > > > >> >> > > period/duty cycle which we cannot produce, how should i=
t be rounded?
> > > > > >> >> >
> > > > > >> >> > Yeah, because there is no obviously right one, I picked o=
ne that is as
> > > > > >> >> > wrong as the other possibilities but is easy to work with.
> > > > > >> >> >
> > > > > >> >> > > Should we just set TLR0=3D1 and TLR1=3D0 to give them 6=
6% duty cycle with
> > > > > >> >> > > the least period? Or should we try and increase the per=
iod to better
> > > > > >> >> > > approximate the % duty cycle? And both of these decisio=
ns must be made
> > > > > >> >> > > knowing both parameters. We cannot (for example) just a=
lways round up,
> > > > > >> >> > > since we may produce a configuration with TLR0 =3D=3D T=
LR1, which would
> > > > > >> >> > > produce 0% duty cycle instead of whatever was requested=
=2E Rounding rate
> > > > > >> >> > > will introduce significant complexity into the driver. =
Most of the time
> > > > > >> >> > > if a consumer requests an invalid rate, it is due to mi=
sconfiguration
> > > > > >> >> > > which is best solved by fixing the configuration.
> > > > > >> >> >
> > > > > >> >> > In the first step pick the biggest period not bigger than=
 the requested
> > > > > >> >> > and then pick the biggest duty cycle that is not bigger t=
han the
> > > > > >> >> > requested and that can be set with the just picked period=
=2E That is the
> > > > > >> >> > behaviour that all new drivers should do. This is somewha=
t arbitrary but
> > > > > >> >> > after quite some thought the most sensible in my eyes.
> > > > > >> >>
> > > > > >> >> And if there are no periods smaller than the requested peri=
od?
> > > > > >> >
> > > > > >> > Then return -ERANGE.
> > > > > >>
> > > > > >> Ok, so instead of
> > > > > >>
> > > > > >> 	if (cycles < 2 || cycles > priv->max + 2)
> > > > > >> 		return -ERANGE;
> > > > > >>
> > > > > >> you would prefer
> > > > > >>
> > > > > >> 	if (cycles < 2)
> > > > > >> 		return -ERANGE;
> > > > > >> 	else if (cycles > priv->max + 2)
> > > > > >> 		cycles =3D priv->max;
> > > > > >
> > > > > > The actual calculation is a bit harder to handle TCSR_UDT =3D 0=
 but in
> > > > > > principle, yes, but see below.
> > > > > >
> > > > > >> But if we do the above clamping for TLR0, then we have to reca=
lculate
> > > > > >> the duty cycle for TLR1. Which I guess means doing something l=
ike
> > > > > >>
> > > > > >> 	ret =3D xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->pe=
riod);
> > > > > >> 	if (ret)
> > > > > >> 		return ret;
> > > > > >>
> > > > > >> 	state->duty_cycle =3D mult_frac(state->duty_cycle,
> > > > > >> 				      xilinx_timer_get_period(priv, tlr0, tcsr0),
> > > > > >> 				      state->period);
> > > > > >>
> > > > > >> 	ret =3D xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->du=
ty_cycle);
> > > > > >> 	if (ret)
> > > > > >> 		return ret;
> > > > > >
> > > > > > No, you need something like:
> > > > > >
> > > > > > 	/*
> > > > > > 	 * The multiplication cannot overflow as both priv_max and
> > > > > > 	 * NSEC_PER_SEC fit into an u32.
> > > > > > 	 */
> > > > > > 	max_period =3D div64_ul((u64)priv->max * NSEC_PER_SEC, clkrate=
);
> > > > > >
> > > > > > 	/* cap period to the maximal possible value */
> > > > > > 	if (state->period > max_period)
> > > > > > 		period =3D max_period;
> > > > > > 	else
> > > > > > 		period =3D state->period;
> > > > > >
> > > > > > 	/* cap duty_cycle to the maximal possible value */
> > > > > > 	if (state->duty_cycle > max_period)
> > > > > > 		duty_cycle =3D max_period;
> > > > > > 	else
> > > > > > 		duty_cycle =3D state->duty_cycle;
> > > > >
> > > > > These caps may increase the % duty cycle.
> > > >
> > > > Correct.
> > > >
> > > > For some usecases keeping the relative duty cycle might be better, =
for
> > > > others it might not. I'm still convinced that in general my solution
> > > > makes sense, is computationally cheaper and easier to work with.
> > >=20
> > > Can you please describe one of those use cases? Every PWM user I look=
ed
> > > (grepping for pwm_apply_state and pwm_config) set the duty cycle as a
> > > percentage of the period, and not as an absolute time. Keeping the hi=
gh
> > > time the same while changing the duty cycle runs contrary to the
> > > assumptions of all of those users.
> >=20
> > Indeed there is no mainline driver that relies on this. There are some
> > smart LED controllers (e.g. WS2812B) where the duty_cycle is more
> > important than the period. (I admit a PWM is not really the right driver
> > for that one as it could only completely enable and complete disable
> > white color.) Also there are some servo motor chips where the absolute
> > duty is relevant but the period isn't (in some range). (See
> > https://www.mikrocontroller.net/articles/Modellbauservo_Ansteuerung#Sig=
nalaufbau
> > for a article about that (in German though).)
>=20
> > In case you want to argue that out-of-mainline users don't count:
>=20
> They don't :)
>=20
> This is a kernel-internal API.
>=20
> But my point is that the vast majority of PWM users, and 100% of the
> in-kernel users care about the % duty cycle and not about the absolute
> high time. We should design around the common use case first and
> foremost.
>=20
> > I think in the design of an API they do count to place the bar to
> > enter the mainline low. Frameworks should be generic enough to cover
> > as much use cases as possible.
>=20
> They can cover many use-cases as possible, but they should be ergonomic
> firstly for the most common use case.

First I think going the easy way now and accepting to have to spend
quite more work later isn't a sensible approach. Second: Your approach
isn't even easier. And third: I agree that it should be easy for
consumers who care more about relative duty cycle than absolute numers.
But that doesn't imply that each and every device driver must provide
exactly that algorithm. The possible ways forward are:

 a) The framework has no complexity and all lowlevel drivers have to do
    complicated maths;=20

 b) The framework contains the complexity and the lowlevel drivers are
    simpler.

I'd choose b) at any time.

> > And note that if you want a nearest to (say) 50% relative duty cycle and
> > don't care much about the period it doesn't really matter if you scale
> > duty_cycle in pwm_round_state() to the period change or not because in
> > general you need several calls to pwm_round_state() anyhow to find a
> > setting with 51% if the next lower possibility is 47%. So in the end you
> > save (I think) one call in generic PWM code.
> >=20
> > In contrast the math gets quite a bit more complicated because there is
> > rounding involved in scaling the duty cycle. Consider a PWM that can
> > configure period and duty in 16.4 ns steps and you ask for
> >=20
> > 	.period =3D 100 ns
> > 	.duty_cycle =3D 50 ns
> >=20
> > Then the best period you can provide is 98.4 ns, so you return .period =
=3D
> > 99 from pwm_round_state(). (Yes, you don't return 98, because
> > round-nearest is much harder to handle than round down.)
> > To determine the adapted duty_cycle you have to do
> >=20
> > 	50 * realperiod / 100
> >=20
> > which independently of choosing 98, 98.4 or 99 for realperiod is 49. Th=
en
> > to approximate 49 without rounding up you end up with 32.8 while 49.2
> > would have be perfectly fine.
>=20
> And what if the consumer comes and requests 49 for their period in the
> first place? You have the same problem. The rescaling made it worse in
> this instance, but this is just an unfortunate case study.

I cannot follow. There are cases that are easy and others are hard.
Obviously I presented a hard case, and just because there are simpler
cases, too, doesn't mean that implementing the algorithm that must cover
all cases becomes simple, too. Maybe I just didn't understand what you
want to say?!

> > You might find a way around that (maybe you have to round up in the
> > adaption of duty_cycle, I didn't convince myself this is good enough
> > though).
> >=20
> > So your suggestion to adapt the duty_cycle to keep the relative
> > duty_cycle constant (as good as possible within the bounds the hardware
> > dictates) implies additional complication at the driver level.
> >=20
> >  From a framework maintainer's point of view (and also from a low-level
> > driver maintainer's point of view) I prefer one complication in a
> > generic function over a complication that I have to care for in each and
> > every low-level driver by a big margin.
>=20
> FWIW what you're suggesting is also complex for the low-level driver.

Well, it is as complex as necessary and simpler than adapting the
duty_cycle as you suggested.

> [...]
> > Can you please come up with an algorithm to judge if a given deviation
> > is reasonable or surprising? I agree there are surprises and some of
> > them are obviously bad. For most cases however the judgement depends on
> > the use case so I fail to see how someone should program such a check
> > that should cover all consumers and use cases. I prefer no precautions +
> > an easy relation between pwm_round_state and pwm_apply_state (i.e.
> > behave identically) over a most of the time(?) useless precaution and
> > some policy defined differences between pwm_round_state and
> > pwm_apply_state
>=20
> After thinking it over, I believe I agree with you on most things, but I
> think your proposed API has room for additional checks without any loss
> of generality.

\o/

> The PWM subsystem has several major players:
>=20
> * Existing users of the PWM API. Most of these do not especially care
>   about the PWM period, usually just leaving at the default. The
>   exception is of course the pwm-clk driver. Many of these users care
>   about % duty cycle, and they all calculate the high time based on the
>   configured period of the PWM. I suspect that while many of these users
>   have substantial leeway in what accuracy they expect from the % duty
>   cycle, significant errors (in the 25-50% range) are probably unusual
>   and indicative of a misconfigured period. Unfortunately, we cannot
>   make a general judgement about what sort of accuracy is OK in most
>   cases.

ack.

> * Hypothetical future users of some kind of round_state function. These
>   users have some kind of algorithm which determines whether a PWM state
>   is acceptable for the driver. Most of the time this will be some kind
>   of accuracy check. What the round_state function returns is not
>   particularly important, because users have the opportunity to revise
>   their request based on what the state is rounded to. However, it is
>   important that each round rate function is consistent in manner that
>   it rounds so that these users

This sentence isn't complete, is it? One thing I consider important is
that there is a policy which of the implementable states is returned for
a given request to make it efficient to search for a best state
(depending on what the consumer driver considers best). Otherwise this
yields to too much distinctions of cases.

> * Existing drivers for the PWM subsystem. These drivers must implement
>   an apply_state function which is correct for both existing and future
>   users. In addition, they may implement some kind of round_state
>   function in the future. it is important to reduce the complexity of
>   the calculations these drivers perform so that it is easier to
>   implement and review them.

It's hard to know what "correct" means. But ack for "They should not be
more complex than necessary".

> I believe the following requirements satisfy the above constraints:
>=20
> * The round_state function shall round the period to the largest period
>   representable by the PWM less than the requested period. It shall also
>   round the duty cycle to the largest duty cycle representable by the
>   PWM less than the requested duty cycle. No attempt shall be made to
>   preserve the % duty cycle.

ack if you replace "less" by "less or equal" twice.

> * The apply_state function shall only round the requested period down, and
>   may do so by no more than one unit cycle. If the requested period is
>   unrepresentable by the PWM, the apply_state function shall return
>   -ERANGE.

I don't understand what you mean by "more than one unit cycle", but that
doesn't really matter for what I think is wrong with that approach:

I think this is a bad idea if with "apply_state" you mean the callback
each driver has to implement: Once you made all drivers conformant to
this, someone will argue that one unit cycle is too strict. Or that it's
ok to increase the period iff the duty_cycle is 0.

Then you have to adapt all 50 or so drivers to adapt the policy.
Better let .apply_state() do the same as .round_state() and then you can
have in the core (i.e. in a single place):

	def pwm_apply_state(pwm, state):
	    rounded_state =3D pwm_round_state(pwm, state)
	    if some_condition(rounded_state, state):
	    	return -ERANGE
	    else:
	    	pwm->apply(pwm, state)

Having said that I think some_condition should always return False, but
independant of the discussion how some_condition should actually behave
this is definitively better than to hardcode some_condition in each
driver.

> * The apply_state function shall only round the requested duty cycle
>   down. The apply_state function shall not return an error unless there
>   is no duty cycle less than the requested duty cycle which is
>   representable by the PWM.

ack. (Side note: Most drivers can implement duty_cycle =3D 0, so for them
duty_cycle isn't a critical thing.)

> * After applying a state returned by round_state with apply_state,
>   get_state must return that state.

ack.

> The reason that we must return an error when the period is
> unrepresentable is that generally the duty cycle is calculated based on
> the period. This change has no affect on future users of round_state,
> since that function will only return valid periods. Those users will
> have the opportunity to detect that the period has changed and determine
> if the duty cycle is still acceptable.

ack up to here.

> However, for existing users, we
> should also provide the same opportunity.

Here you say: If the period has changed they should get a return value
of -ERANGE, right? Now what should they do with that. Either they give
up (which is bad) or they need to resort to pwm_round_state to
find a possible way forward. So they have to belong in the group of
round_state users and so they can do this from the start and then don't
need to care about some_condition at all.

> This requirement simplifies
> the behavior of apply_state, since there is no longer any chance that
> the % duty cycle is rounded up.

This is either wrong, or I didn't understand you. For my hypothetical
hardware that can implement periods and duty_cycles that are multiples
of 16.4 ns the following request:

	period =3D 1650
	duty_cycle =3D 164

(with relative duty_cycle =3D 9.9393939393939 %)
will be round to:

	period =3D 1640
	duty_cycle =3D 164

which has a higher relative duty_cycle (i.e. 10%).

> This requirement is easy to implement in
> drivers as well. Instead of writing something like
>=20
> 	period =3D clamp(period, min_period, max_period);
>=20
> they will instead write
>=20
> 	if (period < min_period || period > max_period)
> 		return -ERANGE;

Are you aware what this means for drivers that only support a single
fixed period?

I still think it should be:

	if (period < min_period)
		return -ERANGE;
=09
	if (period > max_period)
		period =3D max_period;

There are two reasons for this compared to your suggestion:

 a) Consider again the 16.4 ns driver and that it is capable to
    implement periods up to 16400 ns. With your approach a request of
    16404 ns will yield -ERANGE.
    Now compare that with a different 16.4 ns driver with max_period =3D
    164000 ns. The request of 16404 ns will yield 16400 ns, just because
    this driver could also do 16416.4 ns. This is strange, because the
    possibility to do 16416.4 ns is totally irrelevant here, isn't it?

 b) If a consumer asked for a certain state and gets back -ENORANGE they
    don't know if they should increase or decrease the period to guess a
    state that might be implementable instead.

(Hmm, or are you only talking about .apply_state and only .round_state
should do if (period < min_period) return -ERANGE; if (period >
max_period) period =3D max_period;? If so, I'd like to have this in the
framework, not in each driver. Then .round_state and .apply_state can be
identical which is good for reducing complexity.)

> Instead of viewing round_state as "what get_state would return if I
> passed this state to apply_state", it is better to view it as "what is
> the closest exactly representable state with parameters less than this
> state."
> I believe that this latter representation is effectively identical for
> users of round_state, but it allows for implementations of apply_state
> which provide saner defaults for existing users.

I look forward to how you modify your claim here after reading my
reasoning above.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hzcgv3mhm5yedjq6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDnVUwACgkQwfwUeK3K
7AnJCQf/fBNeq7J8wM6s/lRDUai3zz6c4DfiFKXbHMVwBm2SQ4mxZdK7fV/DWC1v
FygzMh55JZDGI67DClSw62sIJgZpJ3pz0Y4+xarz8ZS+bKz+AJGhSByHLihMIN74
OGu3xkxV98ST1cR+P6DHb8yT4myjBJdOntR8vNJP9TUsSf4gC5eDIznfS+GrcknF
9qEI+CLExXvkxEo/ThVfv673meWhUFDSVjMbWGIKda2mZA6/XPmAjLK4PRv2BvuI
jfq7U4xdrmmS6wkIJbMnIopOpwgIYYRSQFSjAk5DHE54CCNaVxL7geDcFqMCoYFB
XOPHR+upKTeL3s8ruNF1MZjipfF7Gw==
=RBCa
-----END PGP SIGNATURE-----

--hzcgv3mhm5yedjq6--
