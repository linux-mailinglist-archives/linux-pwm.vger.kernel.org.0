Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE563B6F74
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jun 2021 10:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhF2IeS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Jun 2021 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbhF2IeO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Jun 2021 04:34:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038B6C061574
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jun 2021 01:31:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ly99l-0007vb-D9; Tue, 29 Jun 2021 10:31:45 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ly99k-0003wC-NK; Tue, 29 Jun 2021 10:31:44 +0200
Date:   Tue, 29 Jun 2021 10:31:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Lenngren <emil.lenngren@gmail.com>,
        michal.simek@xilinx.com, Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210629083144.53onthkcchbk73lo@pengutronix.de>
References: <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
 <a748143d-f157-562e-795d-dcd9a0cf9d85@seco.com>
 <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
 <f1772da9-8bd8-57cf-6eba-3c16c58a903f@seco.com>
 <20210627181919.iunagls4j67ignhh@pengutronix.de>
 <59e93f67-0552-04bb-116e-73ddf878761e@seco.com>
 <20210628162407.dxxt6hqfzeokdtxa@pengutronix.de>
 <27fca5ef-8c82-f122-4bd0-f595cad4d588@seco.com>
 <20210628172021.q5enzmr7u6cornm6@pengutronix.de>
 <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zw3gcxqombv3kcc7"
Content-Disposition: inline
In-Reply-To: <661e52c3-cd79-c2aa-e031-64eef5617be0@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zw3gcxqombv3kcc7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Mon, Jun 28, 2021 at 01:41:43PM -0400, Sean Anderson wrote:
> On 6/28/21 1:20 PM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jun 28, 2021 at 12:35:19PM -0400, Sean Anderson wrote:
> >> On 6/28/21 12:24 PM, Uwe Kleine-K=F6nig wrote:
> >> > On Mon, Jun 28, 2021 at 11:50:33AM -0400, Sean Anderson wrote:
> >> > > On 6/27/21 2:19 PM, Uwe Kleine-K=F6nig wrote:
> >> > > > On Fri, Jun 25, 2021 at 01:46:26PM -0400, Sean Anderson wrote:
> >> > > > > So for the moment, why not give an error? This will be legal c=
ode both
> >> > > > > now and after round_state is implemented.
> >> > > >
> >> > > > The problem is where to draw the line. To stay with your example=
: If a
> >> > > > request for period =3D 150 ns comes in, and let X be the biggest=
 period <=3D
> >> > > > 150 ns that the hardware can configure. For which values of X sh=
ould an
> >> > > > error be returned and for which values the setting should be
> >> > > > implemented.
> >> > > >
> >> > > > In my eyes the only sensible thing to implement here is to tell =
the
> >> > > > consumer about X and let it decide if it's good enough. If you h=
ave a
> >> > > > better idea let me hear about it.
> >> > >
> >> > > Sure. And I think it's ok to tell the consumer that X is the best =
we can
> >> > > do. But if they go along and request an unconfigurable state anywa=
y, we
> >> > > should tell them as much.
> >> >
> >> > I have the impression you didn't understand where I see the problem.=
 If
> >> > you request 150 ns and the controller can only do 149 ns (or 149.666=
7 ns)
> >> > should we refuse? If yes: This is very unusable, e.g. the led-pwm dr=
iver
> >> > expects that it can configure the duty_cycle in 1/256 steps of the
> >> > period, and then maybe only steps 27 and 213 of the 256 possible ste=
ps
> >> > work. (This example doesn't really match because the led-pwm driver
> >> > varies duty_cycle and not period, but the principle becomes clear I
> >> > assume.) If no: Should we accept 151 ns? Isn't that ridiculous?
> >>
> >> I am fine with this sort of rounding. The part I take issue with is wh=
en
> >> the consumer requests (e.g.) a 10ns period, but the best we can do is
> >> 20ns. Or at the other end if they request a 4s period but the best we
> >> can do is 2s. Here, there is no obvious way to round it, so I think we
> >> should just say "come back with a reasonable period" and let whoever
> >> wrote the device tree pick a better period.
> >
> > Note that giving ridiculus examples is easy, but this doesn't help to
> > actually implement something sensible. Please tell us for your example
> > where the driver can only implement 20 ns what is the smallest requested
> > period the driver should accept.
>=20
> 20ns :)
>=20
> In the case of this device, that would result in 0% duty cycle with a
> 100MHz input. So the smallest reasonable period is 30ns with a duty
> cycle of 20ns.

I took the time to understand the hardware a bit better, also to be able
to reply to your formulae below. So to recap (and simplify slightly
assuming TCSR_UDT =3D 1):


              TLR0 + 2
 period     =3D --------
              clkrate

              TLR1 + 2
 duty_cycle =3D -------- if TLR1 < TLR0, else 0
              clkrate


where TLRx has the range [0..0xffffffff] (for some devices the range is
smaller). So clkrate seems to be 100 MHz?

> >> > > IMO, this is the best way to prevent surprising results in the API.
> >> >
> >> > I think it's not possible in practise to refuse "near" misses and ev=
ery
> >> > definition of "near" is in some case ridiculous. Also if you consider
> >> > the pwm_round_state() case you don't want to refuse any request to t=
ell
> >> > as much as possible about your controller's capabilities. And then i=
t's
> >> > straight forward to let apply behave in the same way to keep complex=
ity
> >> > low.
> >> >
> >> > > The real issue here is that it is impossible to determine the corr=
ect
> >> > > way to round the PWM a priori, and in particular, without consider=
ing
> >> > > both duty_cycle and period. If a consumer requests very small
> >> > > period/duty cycle which we cannot produce, how should it be rounde=
d?
> >> >
> >> > Yeah, because there is no obviously right one, I picked one that is =
as
> >> > wrong as the other possibilities but is easy to work with.
> >> >
> >> > > Should we just set TLR0=3D1 and TLR1=3D0 to give them 66% duty cyc=
le with
> >> > > the least period? Or should we try and increase the period to bett=
er
> >> > > approximate the % duty cycle? And both of these decisions must be =
made
> >> > > knowing both parameters. We cannot (for example) just always round=
 up,
> >> > > since we may produce a configuration with TLR0 =3D=3D TLR1, which =
would
> >> > > produce 0% duty cycle instead of whatever was requested. Rounding =
rate
> >> > > will introduce significant complexity into the driver. Most of the=
 time
> >> > > if a consumer requests an invalid rate, it is due to misconfigurat=
ion
> >> > > which is best solved by fixing the configuration.
> >> >
> >> > In the first step pick the biggest period not bigger than the reques=
ted
> >> > and then pick the biggest duty cycle that is not bigger than the
> >> > requested and that can be set with the just picked period. That is t=
he
> >> > behaviour that all new drivers should do. This is somewhat arbitrary=
 but
> >> > after quite some thought the most sensible in my eyes.
> >>
> >> And if there are no periods smaller than the requested period?
> >
> > Then return -ERANGE.
>=20
> Ok, so instead of
>=20
> 	if (cycles < 2 || cycles > priv->max + 2)
> 		return -ERANGE;
>=20
> you would prefer
>=20
> 	if (cycles < 2)
> 		return -ERANGE;
> 	else if (cycles > priv->max + 2)
> 		cycles =3D priv->max;

The actual calculation is a bit harder to handle TCSR_UDT =3D 0 but in
principle, yes, but see below.

> But if we do the above clamping for TLR0, then we have to recalculate
> the duty cycle for TLR1. Which I guess means doing something like
>=20
> 	ret =3D xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
> 	if (ret)
> 		return ret;
>=20
> 	state->duty_cycle =3D mult_frac(state->duty_cycle,
> 				      xilinx_timer_get_period(priv, tlr0, tcsr0),
> 				      state->period);
>=20
> 	ret =3D xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycle);
> 	if (ret)
> 		return ret;

No, you need something like:

	/*
	 * The multiplication cannot overflow as both priv_max and
	 * NSEC_PER_SEC fit into an u32.
	 */
	max_period =3D div64_ul((u64)priv->max * NSEC_PER_SEC, clkrate);

	/* cap period to the maximal possible value */
	if (state->period > max_period)
		period =3D max_period;
	else
		period =3D state->period;

	/* cap duty_cycle to the maximal possible value */
	if (state->duty_cycle > max_period)
		duty_cycle =3D max_period;
	else
		duty_cycle =3D state->duty_cycle;

	period_cycles =3D period * clkrate / NSEC_PER_SEC;

	if (period_cycles < 2)
		return -ERANGE;

	duty_cycles =3D duty_cycle * clkrate / NSEC_PER_SEC;

	/*
	 * The hardware cannot emit a 100% relative duty cycle, if
	 * duty_cycle >=3D period_cycles is programmed the hardware emits
	 * a 0% relative duty cycle.
	 */
	if (duty_cycle =3D=3D period_cycles)
		duty_cycles =3D period_cycles - 1;

	/*
	 * The hardware cannot emit a duty_cycle of one clk step, so
	 * emit 0 instead.
	 */
	if (duty_cycles < 2)
		duty_cycles =3D period_cycles;

> >> > > > > Perhaps I should add
> >> > > > >
> >> > > > > 	if (tlr0 <=3D tlr1)
> >> > > > > 		return -EINVAL;
> >> > > > >
> >> > > > > here to prevent accidentally getting 0% duty cycle.
> >> > > >
> >> > > > You can assume that duty_cycle <=3D period when .apply is called.
> >> > >
> >> > > Ok, I will only check for =3D=3D then.
> >> >
> >> > You just have to pay attention to the case that you had to decrement
> >> > .period to the next possible value. Then .duty_cycle might be bigger
> >> > than the corrected period.
> >>
> >> This is specifically to prevent 100% duty cycle from turning into 0%. =
My
> >> current draft is
> >>
> >> 	/*
> >> 	 * If TLR0 =3D=3D TLR1, then we will produce 0% duty cycle instead of=
 100%
> >> 	 * duty cycle. Try and reduce the high time to compensate. If we can't
> >> 	 * do that because the high time is already 0 cycles, then just error
> >> 	 * out.
> >> 	 */
> >> 	if (tlr0 =3D=3D tlr1 && !tlr1--)
> >> 		return -EINVAL;
> >
> > If you follow my suggested policy this isn't an error and you should
> > yield the biggest duty_cycle here even if it is zero.
>=20
> So like this?
>=20
> 	if (tlr0 =3D=3D tlr1) {
> 		if (tlr1)
> 			tlr1--;
> 		else if (tlr0 !=3D priv->max)
> 			tlr0++;
> 		else
> 			return -ERANGE;
> 	}

No, this is wrong as it configures a longer period than requested in
some cases.

> And I would really appreciate if you could write up some documentation
> with common errors and how to handle them. It's not at all obvious to me
> what all the implications of the above guidelines are.

Yes, I fully agree this should be documented and doing that is on my
todo list. Until I come around to do this, enabling PWM_DEBUG should
help you getting this right (assuming you test extensively and read the
resulting kernel messages).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zw3gcxqombv3kcc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDa2m0ACgkQwfwUeK3K
7AnqWAf7Bcs27Gx2S4VXUpSUFpFHo07wQYtDRmb3fhxv6K0C66frexKLCiLq7oSz
IfnELRaL/tswH59hnHdjia4M6jR+m/1EaZa5kxJcuQcx2xAuQF3Sg6keNLYOQOsL
nLU34jYgjClsSOsYzml0tiD/uASW+M+nYxxpyfvurdYD4MWx5CspO5XdRZ1xPkhN
b9ZCrdtdb2gAPRT18AkOG6GwaVRe/tTgG6ZYoQGXUinXO8XopvOKUpTNf99n1EaH
Edd4sKhJEgJxqKJm/bWuetL/MEs6/VzpWo/ZDPvwJe6RP4FPMBrfCUN58UXY+isQ
Nh+qk4l8Mm6COQVx6PRacbm/2TV6jg==
=QjkF
-----END PGP SIGNATURE-----

--zw3gcxqombv3kcc7--
