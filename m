Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3363B798A
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jun 2021 22:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhF2Uxg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Jun 2021 16:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbhF2Uxf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Jun 2021 16:53:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B823C061767
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jun 2021 13:51:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyKhE-0003e2-TB; Tue, 29 Jun 2021 22:51:04 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyKhC-0005VM-VK; Tue, 29 Jun 2021 22:51:02 +0200
Date:   Tue, 29 Jun 2021 22:51:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210629205102.wtnhdlqdbkihi4mz@pengutronix.de>
References: <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
 <f1772da9-8bd8-57cf-6eba-3c16c58a903f@seco.com>
 <20210627181919.iunagls4j67ignhh@pengutronix.de>
 <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
 <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
 <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
 <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
 <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
 <20210629083144.53onthkcchbk73lo@pengutronix.de>
 <a4943aa5-956c-1820-3489-994f0812c3a7@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ld3iqnsztxzqcmj4"
Content-Disposition: inline
In-Reply-To: <a4943aa5-956c-1820-3489-994f0812c3a7@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ld3iqnsztxzqcmj4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Tue, Jun 29, 2021 at 02:01:31PM -0400, Sean Anderson wrote:
> On 6/29/21 4:31 AM, Uwe Kleine-K=F6nig wrote:
> > Hello Sean,
> >
> > On Mon, Jun 28, 2021 at 01:41:43PM -0400, Sean Anderson wrote:
> >> On 6/28/21 1:20 PM, Uwe Kleine-K=F6nig wrote:
> >> > On Mon, Jun 28, 2021 at 12:35:19PM -0400, Sean Anderson wrote:
> >> >> On 6/28/21 12:24 PM, Uwe Kleine-K=F6nig wrote:
> >> >> > On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
> >> >> > > On 6/27/21 2:19 PM, Uwe Kleine-K=F6nig wrote:
> >> >> > > > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
> >> >> > > > > So for the moment, why not give an error? This will be lega=
l code both
> >> >> > > > > now and after round_state is implemented.
> >> >> > > >
> >> >> > > > The problem is where to draw the line. To stay with your exam=
ple: If a
> >> >> > > > request for period =3D 150 ns comes in, and let X be the bigg=
est period <=3D
> >> >> > > > 150 ns that the hardware can configure. For which values of X=
 should an
> >> >> > > > error be returned and for which values the setting should be
> >> >> > > > implemented.
> >> >> > > >
> >> >> > > > In my eyes the only sensible thing to implement here is to te=
ll the
> >> >> > > > consumer about X and let it decide if it's good enough. If yo=
u have a
> >> >> > > > better idea let me hear about it.
> >> >> > >
> >> >> > > Sure. And I think it's ok to tell the consumer that X is the be=
st we can
> >> >> > > do. But if they go along and request an unconfigurable state an=
yway, we
> >> >> > > should tell them as much.
> >> >> >
> >> >> > I have the impression you didn't understand where I see the probl=
em. If
> >> >> > you request 150 ns and the controller can only do 149 ns (or 149.=
6667 ns)
> >> >> > should we refuse? If yes: This is very unusable, e.g. the led-pwm=
 driver
> >> >> > expects that it can configure the duty_cycle in 1/256 steps of the
> >> >> > period, and then maybe only steps 27 and 213 of the 256 possible =
steps
> >> >> > work. (This example doesn't really match because the led-pwm driv=
er
> >> >> > varies duty_cycle and not period, but the principle becomes clear=
 I
> >> >> > assume.) If no: Should we accept 151 ns? Isn't that ridiculous?
> >> >>
> >> >> I am fine with this sort of rounding. The part I take issue with is=
 when
> >> >> the consumer requests (e.g.) a 10ns period, but the best we can do =
is
> >> >> 20ns. Or at the other end if they request a 4s period but the best =
we
> >> >> can do is 2s. Here, there is no obvious way to round it, so I think=
 we
> >> >> should just say "come back with a reasonable period" and let whoever
> >> >> wrote the device tree pick a better period.
> >> >
> >> > Note that giving ridiculus examples is easy, but this doesn't help to
> >> > actually implement something sensible. Please tell us for your examp=
le
> >> > where the driver can only implement 20 ns what is the smallest reque=
sted
> >> > period the driver should accept.
> >>
> >> 20ns :)
> >>
> >> In the case of this device, that would result in 0% duty cycle with a
> >> 100MHz input. So the smallest reasonable period is 30ns with a duty
> >> cycle of 20ns.
> >
> > I took the time to understand the hardware a bit better, also to be able
> > to reply to your formulae below. So to recap (and simplify slightly
> > assuming TCSR_UDT =3D 1):
> >
> >
> >                TLR0 + 2
> >   period     =3D --------
> >                clkrate
> >
> >                TLR1 + 2
> >   duty_cycle =3D -------- if TLR1 < TLR0, else 0
> >                clkrate
> >
> >
> > where TLRx has the range [0..0xffffffff] (for some devices the range is
> > smaller). So clkrate seems to be 100 MHz?
>=20
> On my system, yes.
>=20
> >
> >> >> > > IMO, this is the best way to prevent surprising results in the =
API.
> >> >> >
> >> >> > I think it's not possible in practise to refuse "near" misses and=
 every
> >> >> > definition of "near" is in some case ridiculous. Also if you cons=
ider
> >> >> > the pwm_round_state() case you don't want to refuse any request t=
o tell
> >> >> > as much as possible about your controller's capabilities. And the=
n it's
> >> >> > straight forward to let apply behave in the same way to keep comp=
lexity
> >> >> > low.
> >> >> >
> >> >> > > The real issue here is that it is impossible to determine the c=
orrect
> >> >> > > way to round the PWM a priori, and in particular, without consi=
dering
> >> >> > > both duty_cycle and period. If a consumer requests very small
> >> >> > > period/duty cycle which we cannot produce, how should it be rou=
nded?
> >> >> >
> >> >> > Yeah, because there is no obviously right one, I picked one that =
is as
> >> >> > wrong as the other possibilities but is easy to work with.
> >> >> >
> >> >> > > Should we just set TLR0=3D1 and TLR1=3D0 to give them 66% duty =
cycle with
> >> >> > > the least period? Or should we try and increase the period to b=
etter
> >> >> > > approximate the % duty cycle? And both of these decisions must =
be made
> >> >> > > knowing both parameters. We cannot (for example) just always ro=
und up,
> >> >> > > since we may produce a configuration with TLR0 =3D=3D TLR1, whi=
ch would
> >> >> > > produce 0% duty cycle instead of whatever was requested. Roundi=
ng rate
> >> >> > > will introduce significant complexity into the driver. Most of =
the time
> >> >> > > if a consumer requests an invalid rate, it is due to misconfigu=
ration
> >> >> > > which is best solved by fixing the configuration.
> >> >> >
> >> >> > In the first step pick the biggest period not bigger than the req=
uested
> >> >> > and then pick the biggest duty cycle that is not bigger than the
> >> >> > requested and that can be set with the just picked period. That i=
s the
> >> >> > behaviour that all new drivers should do. This is somewhat arbitr=
ary but
> >> >> > after quite some thought the most sensible in my eyes.
> >> >>
> >> >> And if there are no periods smaller than the requested period?
> >> >
> >> > Then return -ERANGE.
> >>
> >> Ok, so instead of
> >>
> >> 	if (cycles < 2 || cycles > priv->max + 2)
> >> 		return -ERANGE;
> >>
> >> you would prefer
> >>
> >> 	if (cycles < 2)
> >> 		return -ERANGE;
> >> 	else if (cycles > priv->max + 2)
> >> 		cycles =3D priv->max;
> >
> > The actual calculation is a bit harder to handle TCSR_UDT =3D 0 but in
> > principle, yes, but see below.
> >
> >> But if we do the above clamping for TLR0, then we have to recalculate
> >> the duty cycle for TLR1. Which I guess means doing something like
> >>
> >> 	ret =3D xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
> >> 	if (ret)
> >> 		return ret;
> >>
> >> 	state->duty_cycle =3D mult_frac(state->duty_cycle,
> >> 				      xilinx_timer_get_period(priv, tlr0, tcsr0),
> >> 				      state->period);
> >>
> >> 	ret =3D xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle=
);
> >> 	if (ret)
> >> 		return ret;
> >
> > No, you need something like:
> >
> > 	/*
> > 	 * The multiplication cannot overflow as both priv_max and
> > 	 * NSEC_PER_SEC fit into an u32.
> > 	 */
> > 	max_period =3D div64_ul((u64)priv->max * NSEC_PER_SEC, clkrate);
> >
> > 	/* cap period to the maximal possible value */
> > 	if (state->period > max_period)
> > 		period =3D max_period;
> > 	else
> > 		period =3D state->period;
> >
> > 	/* cap duty_cycle to the maximal possible value */
> > 	if (state->duty_cycle > max_period)
> > 		duty_cycle =3D max_period;
> > 	else
> > 		duty_cycle =3D state->duty_cycle;
>=20
> These caps may increase the % duty cycle.

Correct.

For some usecases keeping the relative duty cycle might be better, for
others it might not. I'm still convinced that in general my solution
makes sense, is computationally cheaper and easier to work with.

>=20
> > 	period_cycles =3D period * clkrate / NSEC_PER_SEC;
> >
> > 	if (period_cycles < 2)
> > 		return -ERANGE;
> >
> > 	duty_cycles =3D duty_cycle * clkrate / NSEC_PER_SEC;
> >
> > 	/*
> > 	 * The hardware cannot emit a 100% relative duty cycle, if
> > 	 * duty_cycle >=3D period_cycles is programmed the hardware emits
> > 	 * a 0% relative duty cycle.
> > 	 */
> > 	if (duty_cycle =3D=3D period_cycles)
> > 		duty_cycles =3D period_cycles - 1;
> >
> > 	/*
> > 	 * The hardware cannot emit a duty_cycle of one clk step, so
> > 	 * emit 0 instead.
> > 	 */
> > 	if (duty_cycles < 2)
> > 		duty_cycles =3D period_cycles;
>=20
> Of course, the above may result in 100% duty cycle being rounded down to
> 0%. I feel like that is too big of a jump to ignore. Perhaps if we
> cannot return -ERANGE we should at least dev_warn.

You did it again. You picked one single case that you consider bad but
didn't provide a constructive way to make it better.

Assume there was already a pwm_round_state function (that returns the
state that pwm_apply_state would implement for a given request) Consider
a consumer that wants say a 50% relative duty together with a small
period. So it first might call:

	ret =3D pwm_round_rate(pwm, { .period =3D 20, .duty_cycle =3D 20, ... }, &=
rounded_state)

to find out if .period =3D 20 can be implemented with the given PWM. If
this returns rounded state as:

	.period =3D 20
	.duty_cycle =3D 0

this says quite a lot about the pwm if the driver implements my policy.
(i.e.: The driver can do 20ns, but the biggest duty_cycle is only 0).
If however it returns -ERANGE this means (assuming the driver implements
the policy I try to convice you to be the right one) it means: The
hardware cannot implement 20 ns (or something smaller) and so the next
call probably tries 40 ns.

With your suggested semantic -ERANGE might mean:

 - The driver doesn't support .period =3D 20 ns
   (Follow up questions: What period should be tried next? 10 ns? 40
   ns? What if this returns -ERANGE again?)
 - The driver supports .period =3D 20 ns, but the biggest possible
   duty_cycle is "too different from 20 ns to ignore".

Then how should the search continue?

So: As soon as there is a pwm_round_rate function this can be catched
and then it's important that the drivers adhere to the expected policy.
Implementing this is a big thing and believe me I already spend quite
some brain cycles into it. Once the core is extended accordingly I will
be happy about each driver already doing the right thing.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ld3iqnsztxzqcmj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDbh7MACgkQwfwUeK3K
7Amp1wf9Esoqcjj9aQ3bQBGWTMw8ciHw9shD3mGnJBtUPuExdml94vBIFgWKLAtD
kajIpirRNiRfOJE4tC7fJIXtfcqf1Y42cmghYPjo+/aMZNeNCErJKqHSulX8bgP8
5Od/fhMQbN6KezYslUCxxLP39StmAOEUOwU7K/w77Jbkn9oV+GsYB2TK+ZSMMb2N
2ws23gFli0pf2mvzL2qDfJJQ8kJfX9Jk7UoIMH+X6Q1i1q7IcbXPFD/aZ2RHPBeM
uEB2K+704PxJXxPkKrn4k2D7JHJdT248tX7UHie5pwtdtaMAif9gVQzF1sDFE2I+
RmXkMbmznijAhALyyKzgC/K5FWNfpg==
=F+pj
-----END PGP SIGNATURE-----

--ld3iqnsztxzqcmj4--
