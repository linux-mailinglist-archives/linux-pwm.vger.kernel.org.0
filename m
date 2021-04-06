Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A3B354CF9
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 08:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239020AbhDFGeP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 02:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238603AbhDFGeO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 02:34:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDEC06174A
        for <linux-pwm@vger.kernel.org>; Mon,  5 Apr 2021 23:34:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTfHk-0001Mo-TZ; Tue, 06 Apr 2021 08:34:00 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTfHk-00056h-DT; Tue, 06 Apr 2021 08:34:00 +0200
Date:   Tue, 6 Apr 2021 08:33:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210406063357.x6ty25eiamu44lev@pengutronix.de>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
 <X/H5CqcRHelg5M4p@workstation.tuxnet>
 <20210111204350.k2bhpdj7xnnqkfi3@pengutronix.de>
 <YFhWjXAF/D6oBpGE@orome.fritz.box>
 <20210331102543.adefgrpkuaqkbg3x@pengutronix.de>
 <YGSazQSm+xPtbjCX@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="udwfh3s4qtilsszv"
Content-Disposition: inline
In-Reply-To: <YGSazQSm+xPtbjCX@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--udwfh3s4qtilsszv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Wed, Mar 31, 2021 at 05:52:45PM +0200, Thierry Reding wrote:
> On Wed, Mar 31, 2021 at 12:25:43PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 22, 2021 at 09:34:21AM +0100, Thierry Reding wrote:
> > > On Mon, Jan 11, 2021 at 09:43:50PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Sun, Jan 03, 2021 at 06:04:10PM +0100, Clemens Gruber wrote:
> > > > > Another point is the period: Sven suggested we do not read out the
> > > > > period at all, as the PWM is disabled anyway (see above).
> > > > > Is this acceptable?
> > > >=20
> > > > In my eyes consumers should consider the period value as "don't car=
e" if
> > > > the PWM is off. But this doesn't match reality (and maybe also it
> > > > doesn't match Thierry's opinion). See for example the
> > > > drivers/video/backlight/pwm_bl.c driver which uses the idiom:
> > > >=20
> > > > 	pwm_get_state(mypwm, &state);
> > > > 	state.enabled =3D true;
> > > > 	pwm_apply_state(pb->pwm, &state);
> > > >=20
> > > > which breaks if .period is invalid. (OK, this isn't totally accurate
> > > > because currently the .get_state callback has only little to do with
> > > > pwm_get_state(), but you get the point.)
> > >=20
> > > The idea behind atomic states in the PWM API is to provide accurate
> > > snapshots of a PWM channel's settings. It's not a representation of
> > > the PWM channel's physical output, although in some cases they may
> > > be the same.
> >=20
> > I think the pwm_state returned by .get_state() should be an accurate
> > representation of the PWM channel's physical output.
>=20
> Yeah, like I said, in most cases that will be true. However, as
> mentioned below, if there's no 1:1 correspondence between the settings
> and what's actually coming out of the PWM, this isn't always possible.
> But yes, it should always be as accurate as possible.

It should always be true, not only in most cases. For any given PWM
output you can provide a pwm_state that describes this output (unless
you'd need a value bigger than u64 to describe it or a higher precision
as pwm_state only uses integer values). So it's a 1:n relation: You
should always be able to provide a pwm_state and in some cases there are
more than one such states (and you should still provide one of them).

> > > However, given that we want a snapshot of the currently configured
> > > settings, we can't simply assume that there's a 1:1 correspondence and
> > > then use shortcuts to simplify the hardware state representation beca=
use
> > > it isn't going to be accurate.
> >=20
> > When we assume that pwm_get_state returns the state of the hardware,
> > relying on these values might be too optimistic. Consider a hardware
> > (e.g.  pwm-cros-ec) that has no disable switch. Disabling is modeled by
> > .duty_cycle =3D 0. So after:
> >=20
> > 	pwm_apply_state(mypwm, { .period =3D 1000, .duty_cycle =3D 500, .enabl=
ed =3D false })
> >=20
> > doing:
> >=20
> > 	pwm_get_state(pwm, &mystate);
> > 	mystate.enabled =3D true;
> > 	pwm_apply_state(pwm, &mystate);
> >=20
> > the PWM stays configured with .duty_cycle =3D 0.
>=20
> Uhm... no, that's not what should be happening.

Agreed, it shouldn't be happening. Note the paragraph started with "When
we assume that pwm_get_state returns the state of the hardware" and with
that my statement is correct. And so the conclusion is that calculations
by the consumer should always be done based on requested states, not on
actually implemented settings.

> pwm_get_state() copies the PWM channel's internal software state. It
> doesn't actually go and read the hardware state. We only ever read the
> hardware state when the PWM is requested. After that there should be
> no reason to ever read back the hardware state again because the
> consumer owns the state and that state must not change unless
> explicitly requested by the owner.

I have problems to follow your reasoning. What is the semantic of "PWM
channel's internal software state"? What is "currently configured
setting"?

There are two different possible semantics for pwm_get_state():

 a) The state that was passed to pwm_apply_state() before.
 b) What is actually configured in hardware.

Currently the implemented semantic is a). (Apart from the very beginning
when there wasn't anything applied before.) And there is no way for a
consumer to get b). If you only ever want to yield a) there is indeed
no need to read the state from hardware.

> So in the above case, mystate.duty_cycle should be 500 after that call
> to pwm_get_state(). The fact that the hardware can't explicitly disable
> a PWM and needs to emulate that by setting duty-cycle =3D 0 is a driver
> implementation detail and shouldn't leak to the consumer.
>=20
> > [...]
> >
> > So I think calculating the state from the previously implemented state
> > has too many surprises and should not be the recommended way.
> > Consumers should just request what they want and provide this state
> > without relying on .get_state(). And then the needs to cache the
> > duty_cycle for a disabled PWM or reading the period for a disabled PWM
> > just vanish in thin air.
>=20
> Again, note that ->get_state() and pwm_get_state() are two different
> things.

I'm aware and interpret your statement here as confirmation that the
function that consumers base their calculations on should always return
the state that was requested before.

> The naming is perhaps a bit unfortunate...

What about renaming pwm_get_state() then, to pwm_get_last_applied_state()?

> But also, the above should never happen because drivers are not supposed
> to modify the software state and the core will never use ->get_state()
> to read back the hardware state.

Agreed. So .get_state() is only ever called at driver load time. (Well,
there is the PWM_DEBUG stuff, but that doesn't leak to the consumer.)

Then I think low level drivers should be allowed to make use of this
fact and drop all caching of data between .apply() and .get_state(), for
example for pwm-cros-ec:

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index c1c337969e4e..fb865f39da9f 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -38,26 +38,6 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_=
pwm(struct pwm_chip *c)
 	return container_of(c, struct cros_ec_pwm_device, chip);
 }
=20
-static int cros_ec_pwm_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
-{
-	struct cros_ec_pwm *channel;
-
-	channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
-	if (!channel)
-		return -ENOMEM;
-
-	pwm_set_chip_data(pwm, channel);
-
-	return 0;
-}
-
-static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
-
-	kfree(channel);
-}
-
 static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 d=
uty)
 {
 	struct {
@@ -116,7 +96,6 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm =3D pwm_to_cros_ec_pwm(chip);
-	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
 	u16 duty_cycle;
 	int ret;
=20
@@ -134,8 +113,6 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, str=
uct pwm_device *pwm,
 	if (ret < 0)
 		return ret;
=20
-	channel->duty_cycle =3D state->duty_cycle;
-
 	return 0;
 }
=20
@@ -143,7 +120,6 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip=
, struct pwm_device *pwm,
 				  struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm =3D pwm_to_cros_ec_pwm(chip);
-	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
 	int ret;
=20
 	ret =3D cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
@@ -154,20 +130,7 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chi=
p, struct pwm_device *pwm,
=20
 	state->enabled =3D (ret > 0);
 	state->period =3D EC_PWM_MAX_DUTY;
-
-	/*
-	 * Note that "disabled" and "duty cycle =3D=3D 0" are treated the same. If
-	 * the cached duty cycle is not zero, used the cached duty cycle. This
-	 * ensures that the configured duty cycle is kept across a disable and
-	 * enable operation and avoids potentially confusing consumers.
-	 *
-	 * For the case of the initial hardware readout, channel->duty_cycle
-	 * will be 0 and the actual duty cycle read from the EC is used.
-	 */
-	if (ret =3D=3D 0 && channel->duty_cycle > 0)
-		state->duty_cycle =3D channel->duty_cycle;
-	else
-		state->duty_cycle =3D ret;
+	state->duty_cycle =3D ret;
 }
=20
 static struct pwm_device *

> Basically that means that pwm_get_state(), followed by
> pwm_apply_state() called on the same PWM and the same state object
> should be an idempotent operation.

Agreed.

> Well, it's possible for a driver to have to modify the software state to
> more accurately reflect what has been configured to hardware. So the
> pwm_get_state()/pwm_apply_state()/pwm_get_state() sequence may give you
> a different state from the initial state. However it must not be to a
> degree that would make a subsequent pwm_apply_state() change the values
> again.

Now you lost me. If pwm_get_state() has semantic a) (i.e. return the
pwm_state that was passed before to pwm_apply_state()) there is no
deviation necessary or possible. So I don't see how the state could ever
change in the pwm_get_state()/pwm_apply_state()/pwm_get_state()
sequence. Please explain in more detail.

> So I guess the idempotency rule really is more like this: the following
> sequence must always yield the same PWM signal:
>=20
> 	pwm_apply_state(pwm, &state);
> 	pwm_get_state(pwm, &state);
> 	pwm_apply_state(pwm, &state);

This is just another idempotency rule.  So there isn't "the" idempotency
rule, in my eyes both should apply. That is:

 1) ("your" idempotency rule) Applying a state returned by pwm_get_state()
    should not modify the output. (Note: True for both semantics a) and b))
 2) ("my" idempotency rule) When a state that was returned by
    .get_state() (i.e. semantic b) only) is applied, .get_state() should
    return the same state afterwards.

> > > It is entirely expected that consumers will be able to use an existing
> > > atomic state, update it and then apply it without necessarily having =
to
> > > recompute the whole state. So what pwm-backlight is doing is expressly
> > > allowed (and in fact was one specific feature that we wanted to have =
in
> > > the atomic API).
> > >
> > > Similarly it's a valid use-case to do something like this:
> > >=20
> > > 	/* set duty cycle to 50% */
> > > 	pwm_get_state(pwm, &state);
> > > 	state.duty_cycle =3D state.period / 2;
> > > 	pwm_apply_state(pwm, &state);
> >=20
> > The cost to continue doing that is that the consumer has to cache the
> > state. Then the idiom looks as follows:
> >=20
> > 	state =3D &driver_data->state;
> > 	state->duty_cycle =3D state->period / 2;
> > 	pwm_apply_state(pwm, state);
>=20
> Sorry but no. Consumers have no business reaching into driver-data and
> operating on the internal state objects.

I wouldn't call a struct pwm_state driver-data. This is the way to
communicate between driver and consumer and so also with your idiom the
consumer has to use it. But ok, we can continue caching the last
requested pwm_state.

> > which=20
> >=20
> >  - allows to drop caching in the PWM layer (which is good as it
> >    simplifies the PWM framework and saves some memory for consumers that
> >    don't need caching)
>=20
> What exactly is complicated in the PWM framework that would need to be
> simplified. This is really all quite trivial.

Even dropping trivial stuff is nice in my eyes.

> >  - doesn't accumulate rounding errors
>=20
> See above, if rounding errors accumulate then something is wrong. This
> shouldn't be happening.
>=20
> Now, the above idempotency rule does not rule out rounding that can
> occur due to consumer error.
>=20
> So consumers need to be aware that some
> hardware state may not be applied exactly as specified. Reusing too
> much of the state may introduce these rounding errors.

Yes, if you start not to return the last requested state and consumers
make calculations based on that, you indeed get rounding errors.=20

> So yes, if you want to toggle between 50% and 75% duty cycles,
> consumers should spell that out explicitly, perhaps by caching the PWM
> args and reusing period from that, for example.

You really confuse me. The obvious way to cache the PWM args is using a
pwm_state, isn't it? So you're saying exactly what I proposed?!

> >  - needs less PWM API calls
> >=20
> > Also I think keeping the PWM configuration in the consumer instead of
> > the PWM is the right place, but I assume that's subjective. I don't
> > oppose to caching the previously applied state for consumers, but IMHO
> > we should differentiate between the currently configured state and the
> > previously applied state as there are semantic differences between these
> > two.
> >=20
> > Note that even if we somehow normalize the state returned by a driver's
> > .get_state callback (e.g. by setting .duty_cycle =3D 0 for disabled PWM=
s)
> > this still matches your expectation that "consumers will be able to use
> > an existing atomic state, update it and then apply without necessarily
> > having to recompute the whole state". The critical part is just that
> > consumers should not start with a pwm_state returned by .get_state() but
> > from the previously requested state.
>=20
> Again, see above. pwm_get_state() does not use ->get_state().

Indeed and because of that normalizing the return value of .get_state()
doesn't hurt consumers as (today) they don't get their hands on the
returned value.

> > > which allows a consumer to do simple modifications without actually
> > > knowing what period has been configured. Some consumers just don't ca=
re
> > > about the period or don't even have a clue about what a good value wo=
uld
> > > be (again, pwm-backlight would be one example). For some PWMs it may
> > > also not be possible to modify the period and if there's no explicit
> > > reason to do so, why should consumers be forced to even bother?
> > >=20
> > > All of that's out the window if we start taking shortcuts. If the PWM
> > > provider reads out the hardware state's PWM as "don't care", how is t=
he
> > > consumer going to know what value to use? Yes, they can use things li=
ke
> > > pwm_get_args() to get the configuration from DT, but then what's the
> > > purpose of using states in the first place if consumers have to do all
> > > the tracking manually anyway?
> >=20
> > With my approach the consumers always have to explicitly request a
> > complete setting, but I'd consider this an advantage that makes the
> > mechanisms clearer. Other than that I don't see any disadvantages and
> > the PWM framework can stop pretending things that don't match (the
> > hardware's) reality.
>=20
> That's really no different from what's currently happening. Consumers
> always request a full state to be applied. The only difference is that
> some of the values might be cached. But again, that's really a good
> thing. Why should consumers need to have their own copy of PWM state
> if all the want to do is toggle a PWM on and off?

They might trade memory for speed.

	/* set duty cycle to 50% */
	pwm_get_state(pwm, &state);
	state.duty_cycle =3D state.period / 2;
	pwm_apply_state(pwm, &state);

allows to use a stack variable (and so doesn't occupy memory most of the
time). But you need to initialize if while you could just reuse the
pwm_state that was passed to pwm_apply_state before (without the need to
initialize).

> And this is all very subjective. I don't think requiring consumers to
> keep their own cached copy of the state is going to make things clearer
> at all. If anything it complicates things for consumers. For example if
> we ever want to extend PWM state with an additional field, we would end
> up having to modify every single consumer to make sure it copies the
> whole state. If we deal with the state in the core like we do right now
> we only need to update the core (and perhaps some consumers that really
> care about the new field).

The initial way to get the hands on a valid pwm_state are not any
different for the two idioms. And after that the only difference is
where the pwm_state is cached (in the PWM framework for you and directly
in the consumer for me). Both approaches then modify incrementally and
if we introduce a new member to pwm_state it affects both idioms in the
same way.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--udwfh3s4qtilsszv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBsANEACgkQwfwUeK3K
7AlJGggAi+/UXXvNk2KkRe81tfyVq+ID3HdmDi/MD/ZPZjnGfsx4Vg2OU8pDDLGo
nRDfJRuqTR0mTV3W0h1kATaiOdV6gw4XjVC6mqsARHrJbMk/dvet3lxIX8Dom4yY
vjJNazhq3yT/CO46x7zUlTbf4uR5jF91bMDTImaztEiiM/z+/uDRPtlVYbgLG7iM
4m67/iNuttDdmvhPWAkJ6mwZpoMSP8hFn6g0Z5FeIQHBkVS1NzGshrsEHjj6snXC
AicsMsRyl4F+uGtCJMjhnP4jdXv2AkhsD8iVRPm2VpuxfjV1lenhUGPYlSXzXlGY
DGahch9RXqycGKctWZuEed//Cpd1Ig==
=L+l9
-----END PGP SIGNATURE-----

--udwfh3s4qtilsszv--
