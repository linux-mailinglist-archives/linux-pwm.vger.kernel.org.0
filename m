Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E92E355D1C
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 22:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347193AbhDFUoi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 16:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245587AbhDFUoi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 16:44:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC78C06174A
        for <linux-pwm@vger.kernel.org>; Tue,  6 Apr 2021 13:44:29 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTsYi-00055L-4L; Tue, 06 Apr 2021 22:44:24 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTsYh-0003Tt-NK; Tue, 06 Apr 2021 22:44:23 +0200
Date:   Tue, 6 Apr 2021 22:44:23 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210406204423.s57u6zlr5aueqzme@pengutronix.de>
References: <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
 <X/H5CqcRHelg5M4p@workstation.tuxnet>
 <20210111204350.k2bhpdj7xnnqkfi3@pengutronix.de>
 <YFhWjXAF/D6oBpGE@orome.fritz.box>
 <20210331102543.adefgrpkuaqkbg3x@pengutronix.de>
 <YGSazQSm+xPtbjCX@orome.fritz.box>
 <20210406063357.x6ty25eiamu44lev@pengutronix.de>
 <YGxmY3xYLoX+PW5E@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5bgc43cbpkg5cgha"
Content-Disposition: inline
In-Reply-To: <YGxmY3xYLoX+PW5E@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5bgc43cbpkg5cgha
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Tue, Apr 06, 2021 at 03:47:15PM +0200, Thierry Reding wrote:
> On Tue, Apr 06, 2021 at 08:33:57AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Wed, Mar 31, 2021 at 05:52:45PM +0200, Thierry Reding wrote:
> > > On Wed, Mar 31, 2021 at 12:25:43PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > On Mon, Mar 22, 2021 at 09:34:21AM +0100, Thierry Reding wrote:
> > > > > On Mon, Jan 11, 2021 at 09:43:50PM +0100, Uwe Kleine-K=F6nig wrot=
e:
> > > > > > On Sun, Jan 03, 2021 at 06:04:10PM +0100, Clemens Gruber wrote:
> > > > > > > Another point is the period: Sven suggested we do not read ou=
t the
> > > > > > > period at all, as the PWM is disabled anyway (see above).
> > > > > > > Is this acceptable?
> > > > > >=20
> > > > > > In my eyes consumers should consider the period value as "don't=
 care" if
> > > > > > the PWM is off. But this doesn't match reality (and maybe also =
it
> > > > > > doesn't match Thierry's opinion). See for example the
> > > > > > drivers/video/backlight/pwm_bl.c driver which uses the idiom:
> > > > > >=20
> > > > > > 	pwm_get_state(mypwm, &state);
> > > > > > 	state.enabled =3D true;
> > > > > > 	pwm_apply_state(pb->pwm, &state);
> > > > > >=20
> > > > > > which breaks if .period is invalid. (OK, this isn't totally acc=
urate
> > > > > > because currently the .get_state callback has only little to do=
 with
> > > > > > pwm_get_state(), but you get the point.)
> > > > >=20
> > > > > The idea behind atomic states in the PWM API is to provide accura=
te
> > > > > snapshots of a PWM channel's settings. It's not a representation =
of
> > > > > the PWM channel's physical output, although in some cases they may
> > > > > be the same.
> > > >=20
> > > > I think the pwm_state returned by .get_state() should be an accurate
> > > > representation of the PWM channel's physical output.
> > >=20
> > > Yeah, like I said, in most cases that will be true. However, as
> > > mentioned below, if there's no 1:1 correspondence between the settings
> > > and what's actually coming out of the PWM, this isn't always possible.
> > > But yes, it should always be as accurate as possible.
> >=20
> > It should always be true, not only in most cases. For any given PWM
> > output you can provide a pwm_state that describes this output (unless
> > you'd need a value bigger than u64 to describe it or a higher precision
> > as pwm_state only uses integer values). So it's a 1:n relation: You
> > should always be able to provide a pwm_state and in some cases there are
> > more than one such states (and you should still provide one of them).
>=20
> My point is that the correspondence between the pwm_state and what's
> programmed to hardware can't always be read back to unambiguously give
> the same result. As you mentioned there are these cases where the PWM
> channel doesn't have a separate enable bit, in which case it must be
> emulated by setting the duty cycle to 0.

OK, I think we agree here.

> In such cases it doesn't make sense to always rely on ->get_state() to
> read back the logical state because it just can't.

If with "logical state" you mean the state that was just requested to be
programmed, then I agree here, too.

> How is it supposed to know from reading that 0 duty cycle whether that
> means the PWM is on or off? So for the initial read-out we can't do
> any better so we have to pick one. The easiest would probably be to
> just assume PWM disabled when duty cycle is 0 and in most cases that
> will be just fine as the resulting PWM will be the same regardless of
> which of the two options we pick.

If the current period is completed before a new setting is applied
returning .enabled =3D true always is probably the more accurate view. But
details.

> However, what I'm also saying is that once the consumer has called
> pwm_apply_state(), there's no reason to read back the value from
> hardware and potentially loose information about the state that isn't
> contained in hardware.

Yes, as long as the consumer is only interested in their requested
values and not what was actually implemented, that's true.

> If the consumer has applied this state:
>=20
> 	{
> 		.period =3D 100,
> 		.duty_cycle =3D 0,
> 		.polarity =3D PWM_POLARITY_NORMAL,
> 		.enabled =3D true,
> 	}
>=20
> then why would we want to have it call ->get_state() and turn this into:
>=20
> 	{
> 		.period =3D 100,
> 		.duty_cycle =3D 0,
> 		.polarity =3D PWM_POLARITY_NORMAL,
> 		.enabled =3D false,
> 	}
> ?

This case is probably indeed uninteresting because the two pwm_states
(nearly) describe the same thing. But the consumer might be interested
if

	{
		.period =3D 100,
		.duty_cycle =3D 50,
		.polarity =3D PWM_POLARITY_NORMAL,
		.enabled =3D true
	}

is implemented by the hardware as

	{
		.period =3D 90,
		.duty_cycle =3D 30,
		.polarity =3D PWM_POLARITY_NORMAL,
		.enabled =3D true
	}

because it can only do multiples of 30 ns.

> If pwm_apply_state() has properly applied the first state there's no
> reason for the consumer to continue using either its own cache or the
> PWM framework's cache (via pwm_get_state()) and just toggle the bits as
> necessary.

I fail to understand what you want to say here.

> > > > > However, given that we want a snapshot of the currently configured
> > > > > settings, we can't simply assume that there's a 1:1 correspondenc=
e and
> > > > > then use shortcuts to simplify the hardware state representation =
because
> > > > > it isn't going to be accurate.
> > > >=20
> > > > When we assume that pwm_get_state returns the state of the hardware,
> > > > relying on these values might be too optimistic. Consider a hardware
> > > > (e.g.  pwm-cros-ec) that has no disable switch. Disabling is modele=
d by
> > > > .duty_cycle =3D 0. So after:
> > > >=20
> > > > 	pwm_apply_state(mypwm, { .period =3D 1000, .duty_cycle =3D 500, .e=
nabled =3D false })
> > > >=20
> > > > doing:
> > > >=20
> > > > 	pwm_get_state(pwm, &mystate);
> > > > 	mystate.enabled =3D true;
> > > > 	pwm_apply_state(pwm, &mystate);
> > > >=20
> > > > the PWM stays configured with .duty_cycle =3D 0.
> > >=20
> > > Uhm... no, that's not what should be happening.
> >=20
> > Agreed, it shouldn't be happening. Note the paragraph started with "When
> > we assume that pwm_get_state returns the state of the hardware" and with
> > that my statement is correct. And so the conclusion is that calculations
> > by the consumer should always be done based on requested states, not on
> > actually implemented settings.
> >=20
> > > pwm_get_state() copies the PWM channel's internal software state. It
> > > doesn't actually go and read the hardware state. We only ever read the
> > > hardware state when the PWM is requested. After that there should be
> > > no reason to ever read back the hardware state again because the
> > > consumer owns the state and that state must not change unless
> > > explicitly requested by the owner.
> >=20
> > I have problems to follow your reasoning. What is the semantic of "PWM
> > channel's internal software state"? What is "currently configured
> > setting"?
> >=20
> > There are two different possible semantics for pwm_get_state():
> >=20
> >  a) The state that was passed to pwm_apply_state() before.
> >  b) What is actually configured in hardware.
> >=20
> > Currently the implemented semantic is a). (Apart from the very beginning
> > when there wasn't anything applied before.) And there is no way for a
> > consumer to get b). If you only ever want to yield a) there is indeed
> > no need to read the state from hardware.
>=20
> b) should only ever be necessary the first time a PWM is used. We
> currently do that at request time because then we always guarantee that
> the PWM state is up to date for every new consumer.
>=20
> From a consumer point of view the difference between a) and b) shouldn't
> matter.

I think there are cases as above where a consumer might want to know b),
but AFAIK there is no such consumer in the kernel tree. A motor
controller might be such an example.

> b) is the driver-specific representation of a), taking into
> account any of the device's restrictions. So in order to be truly
> agnostic of the underlying PWM controller, consumers should only ever
> work with a).

I don't agree completely here. If a motor control driver wants a 50%
relative duty cycle but the PWM can only provide 47% or 52% it might be
picky about which of the two it prefers. Or consider the case we had
recently here on the list about the pwm-ir-tx.

> Note that there's technically also:
>=20
> 	c) the driver-specific representation of what was passed to
> 	   pwm_apply_state()
>=20
> The difference to a) being that it may have adjusted values for period
> and duty cycle depending on any scaler restrictions and such. There's
> also a difference to b) in that we can have information that the
> hardware is not able to contain (such as the difference between duty
> cycle =3D 0 and "off" by the presence of that extra "enabled" field).

If the driver adapted the state (but it doesn't, see commit
71523d1812aca61e32e742e87ec064e3d8c615e1) I'd want that it then yields
the exact same state that .get_state also returns in this situation,
i.e. b). Everything else doesn't make sense to me.

> > > So in the above case, mystate.duty_cycle should be 500 after that call
> > > to pwm_get_state(). The fact that the hardware can't explicitly disab=
le
> > > a PWM and needs to emulate that by setting duty-cycle =3D 0 is a driv=
er
> > > implementation detail and shouldn't leak to the consumer.
> > >=20
> > > > [...]
> > > >
> > > > So I think calculating the state from the previously implemented st=
ate
> > > > has too many surprises and should not be the recommended way.
> > > > Consumers should just request what they want and provide this state
> > > > without relying on .get_state(). And then the needs to cache the
> > > > duty_cycle for a disabled PWM or reading the period for a disabled =
PWM
> > > > just vanish in thin air.
> > >=20
> > > Again, note that ->get_state() and pwm_get_state() are two different
> > > things.
> >=20
> > I'm aware and interpret your statement here as confirmation that the
> > function that consumers base their calculations on should always return
> > the state that was requested before.
>=20
> Yes.
>=20
> > > The naming is perhaps a bit unfortunate...
> >=20
> > What about renaming pwm_get_state() then, to pwm_get_last_applied_state=
()?
>=20
> I replied to that patch earlier and I don't think it's worth the churn
> and it just makes the API more cumbersome to use. If there's any
> confusion we can clarify with better kerneldoc.

That's one of the remaining points where we don't agree.
=20
> > > But also, the above should never happen because drivers are not suppo=
sed
> > > to modify the software state and the core will never use ->get_state()
> > > to read back the hardware state.
> >=20
> > Agreed. So .get_state() is only ever called at driver load time. (Well,
> > there is the PWM_DEBUG stuff, but that doesn't leak to the consumer.)
>=20
> No that's not correct. ->get_state() can also be called when the
> consumer changes.

IMHO that's an inconsistency in the framework because (assuming no other
consumer makes use of the hardware in the break) pwm_get_state() returns
something different than pwm_put(); pwm_get(); pwm_get_state() even
though the hardware wasn't touched.
=20
> > Then I think low level drivers should be allowed to make use of this
> > fact and drop all caching of data between .apply() and .get_state(), for
> > example for pwm-cros-ec:
>=20
> No, I don't think there's a need to remove that code. It's entirely
> reasonable to keep this extra information if it helps to more accurately
> reflect the hardware state.

But it doesn't. It just reflects a software property, and to increase the
inconsistency the driver cached duty cycle isn't reset by pwm_put();
pwm_get();. In my eyes it's a workaround in the wrong layer if really a
consumer depends on getting back the last set duty_cycle for a disabled
PWM. The drivers should be as simple as possible while still providing
the full capabilities of the device. And caching a certain value that
doesn't matter for the operation of the hardware doesn't belong there.

Iff there are really consumers that depend on such a behaviour, then
(and only then) the framework should do something like:

	pwm_get_state_hw(pwm):
	    state =3D chip->ops->get_state()

	    if state.enabled =3D=3D false:
	        # The duty_cycle doesn't matter for the semantic of the
		# returned state. So for convenience set it to the last
		# requested duty_cycle
		state.duty_cycle =3D pwm->state.duty_cycle

But my preference is that no user of pwm_get_state_hw() should take the
duty_cycle of a disabled PWM into account for any decision.

> > > Basically that means that pwm_get_state(), followed by
> > > pwm_apply_state() called on the same PWM and the same state object
> > > should be an idempotent operation.
> >=20
> > Agreed.
> >=20
> > > Well, it's possible for a driver to have to modify the software state=
 to
> > > more accurately reflect what has been configured to hardware. So the
> > > pwm_get_state()/pwm_apply_state()/pwm_get_state() sequence may give y=
ou
> > > a different state from the initial state. However it must not be to a
> > > degree that would make a subsequent pwm_apply_state() change the valu=
es
> > > again.
> >=20
> > Now you lost me. If pwm_get_state() has semantic a) (i.e. return the
> > pwm_state that was passed before to pwm_apply_state()) there is no
> > deviation necessary or possible. So I don't see how the state could ever
> > change in the pwm_get_state()/pwm_apply_state()/pwm_get_state()
> > sequence. Please explain in more detail.
>=20
> I don't think this is still a bit of a grey area, though admittedly I'm
> not sure if there are any drivers that currently do this. I recall that
> there had been discussions at some point whether it was a good idea to
> let drivers update pwm->state to reflect the state that was actually
> programmed. If so, it'd mean that pwm_get_state() could yield a state
> that is slightly different from a) (this is basically the c) case that I
> described above). However, it represents the exact same settings that
> would have been applied with the state that was originally specified.

That doesn't make sense to me. So you think a driver should feed back
that it implemented .enabled =3D false using .duty_cycle =3D 0, but not that
the requested .enabled =3D true; .period =3D 100; was implemented with
=2Eperiod =3D 90?

> > > So I guess the idempotency rule really is more like this: the followi=
ng
> > > sequence must always yield the same PWM signal:
> > >=20
> > > 	pwm_apply_state(pwm, &state);
> > > 	pwm_get_state(pwm, &state);
> > > 	pwm_apply_state(pwm, &state);
> >=20
> > This is just another idempotency rule.  So there isn't "the" idempotency
> > rule, in my eyes both should apply. That is:
> >=20
> >  1) ("your" idempotency rule) Applying a state returned by pwm_get_stat=
e()
> >     should not modify the output. (Note: True for both semantics a) and=
 b))
> >  2) ("my" idempotency rule) When a state that was returned by
> >     .get_state() (i.e. semantic b) only) is applied, .get_state() should
> >     return the same state afterwards.
>=20
> That's exactly what I described above as the first idempotency rule. And
> yes, I agree that both of those rules should hold true.

\o/

> > > > > It is entirely expected that consumers will be able to use an exi=
sting
> > > > > atomic state, update it and then apply it without necessarily hav=
ing to
> > > > > recompute the whole state. So what pwm-backlight is doing is expr=
essly
> > > > > allowed (and in fact was one specific feature that we wanted to h=
ave in
> > > > > the atomic API).
> > > > >
> > > > > Similarly it's a valid use-case to do something like this:
> > > > >=20
> > > > > 	/* set duty cycle to 50% */
> > > > > 	pwm_get_state(pwm, &state);
> > > > > 	state.duty_cycle =3D state.period / 2;
> > > > > 	pwm_apply_state(pwm, &state);
> > > >=20
> > > > The cost to continue doing that is that the consumer has to cache t=
he
> > > > state. Then the idiom looks as follows:
> > > >=20
> > > > 	state =3D &driver_data->state;
> > > > 	state->duty_cycle =3D state->period / 2;
> > > > 	pwm_apply_state(pwm, state);
> > >=20
> > > Sorry but no. Consumers have no business reaching into driver-data and
> > > operating on the internal state objects.

Maybe you understood from my example that driver_data is the driver data
of the PWM lowlevel driver (or the PWM framework)? That would explain
your reaction, but I meant consumer driver data, i.e.
&driver_data->state is the pwm_state cached by the consumer.

> > I wouldn't call a struct pwm_state driver-data. This is the way to
> > communicate between driver and consumer and so also with your idiom the
> > consumer has to use it. But ok, we can continue caching the last
> > requested pwm_state.
>=20
> struct pwm_state is not data at all, it's a definition.

You mean that struct pwm_state is (only) the format of some data, right?

> But once you embed a struct pwm_state into a driver-specific structure
> and you instantiate that data, then the embedded struct pwm_state also
> becomes driver-specific data. Your example showed that the consumer
> was reaching into driver-specific data to obtain the state and that's
> what I objected to.

There is a misunderstanding here somewhere.

I'll try to describe how I understood your approach:

  To program the PWM for the first time, the consumer does:

  	struct pwm_state mystate;

	...

	pwm_init_state(ddata->pwm, &mystate);

	mystate.duty_cycle =3D mystate.period / 2;
	mystate.enabled =3D true;

	pwm_apply_state(ddata->pwm, &mystate);

  and for further updates it does:

  	struct pwm_state mystate;

	pwm_get_state(ddata->pwm, &mystate);

	pwm_set_relative_duty_cycle(&mystate, intensity, 100);

	pwm_apply_state(ddata->pwm, &mystate);

With pwm_get_state() returning the state that was applied before, this
is semantically identically to my approach:

  To program the PWM for the first time, the consumer does:

	pwm_init_state(ddata->pwm, &ddata->pwmstate);

	ddata->pwmstate.duty_cycle =3D ddata->pwmstate.period / 2;
	ddata->pwmstate.enabled =3D true;

	pwm_apply_state(ddata->pwm, ddata->pwmstate);

  and for further updates it does:

	pwm_set_relative_duty_cycle(ddata->pwmstate, intensity, 100);

	pwm_apply_state(ddata->pwm, ddata->pwmstate);

=2E Would you consider ddata->pwmstate driver-specific for the consumer
driver? It doesn't contain any data that isn't contained in pwm->state
when using your approach. And both approaches break (or don't break) in
the same way when we decide to add a .color member to struct pwm_state.

IMHO the only difference is that for your approach you need one PWM call
more and there is more data movement involved in return to smaller
(consumer) driver data.

> > > So yes, if you want to toggle between 50% and 75% duty cycles,
> > > consumers should spell that out explicitly, perhaps by caching the PWM
> > > args and reusing period from that, for example.
> >=20
> > You really confuse me. The obvious way to cache the PWM args is using a
> > pwm_state, isn't it? So you're saying exactly what I proposed?!
>=20
> See the "So yes" confirmation at the beginning of that sentence? Looks
> like I did agree with what you were proposing, although, admittedly, I'm
> having trouble finding in the backlog what exactly that proposal was.

What you did agree with was that caching the pwm state in the consumer
driver is necessary/sensible. Together with the fact(?) that the most
effective way to store this is a struct pwm_state you agreed to my idea
that you just opposed to in the paragraphs before. That's what confuses
me.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5bgc43cbpkg5cgha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBsyCQACgkQwfwUeK3K
7Amq+gf/VBHeY69alKqIVp0V/TFm7tE+Ej1hIWkIQiA346kJ4ab/p8/tJPpzmxUK
yb7gsn0FROB1t9VURKFUWTl3hGmuEeT7nnJ0yT7nIMegfv1Qcm8vg3+ya7MlAbY8
8qvQPEMHYPjBXmNBAKESz3d8teIGXidacLEB1LV5dhJMUAIsMgaGeZAkXqmomOV8
KI0PqYP4reMMzyOV4JMYILDN3PRBffVYR6Ar9IA0q/IY06v3dl2MnPI0dlDFDml8
dLc2+iummzCXHOIg2fgx35iciK0T2MR52gDbStFKuK0tYAkezhVeqQANIjcee274
/tD2F3c+uMcsMjnaC/mLDrs+wfXL0A==
=RBAD
-----END PGP SIGNATURE-----

--5bgc43cbpkg5cgha--
