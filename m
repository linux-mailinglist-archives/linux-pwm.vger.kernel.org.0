Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B8E34FE07
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Mar 2021 12:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhCaK0Y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 31 Mar 2021 06:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbhCaKZx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 Mar 2021 06:25:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B9C061574
        for <linux-pwm@vger.kernel.org>; Wed, 31 Mar 2021 03:25:52 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lRY2l-0000aS-OG; Wed, 31 Mar 2021 12:25:47 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lRY2l-0006ia-2X; Wed, 31 Mar 2021 12:25:47 +0200
Date:   Wed, 31 Mar 2021 12:25:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210331102543.adefgrpkuaqkbg3x@pengutronix.de>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
 <X/H5CqcRHelg5M4p@workstation.tuxnet>
 <20210111204350.k2bhpdj7xnnqkfi3@pengutronix.de>
 <YFhWjXAF/D6oBpGE@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7pgcsfvfttsgo4kx"
Content-Disposition: inline
In-Reply-To: <YFhWjXAF/D6oBpGE@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7pgcsfvfttsgo4kx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Mar 22, 2021 at 09:34:21AM +0100, Thierry Reding wrote:
> On Mon, Jan 11, 2021 at 09:43:50PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sun, Jan 03, 2021 at 06:04:10PM +0100, Clemens Gruber wrote:
> > > Another point is the period: Sven suggested we do not read out the
> > > period at all, as the PWM is disabled anyway (see above).
> > > Is this acceptable?
> >=20
> > In my eyes consumers should consider the period value as "don't care" if
> > the PWM is off. But this doesn't match reality (and maybe also it
> > doesn't match Thierry's opinion). See for example the
> > drivers/video/backlight/pwm_bl.c driver which uses the idiom:
> >=20
> > 	pwm_get_state(mypwm, &state);
> > 	state.enabled =3D true;
> > 	pwm_apply_state(pb->pwm, &state);
> >=20
> > which breaks if .period is invalid. (OK, this isn't totally accurate
> > because currently the .get_state callback has only little to do with
> > pwm_get_state(), but you get the point.)
>=20
> The idea behind atomic states in the PWM API is to provide accurate
> snapshots of a PWM channel's settings. It's not a representation of
> the PWM channel's physical output, although in some cases they may
> be the same.

I think the pwm_state returned by .get_state() should be an accurate
representation of the PWM channel's physical output.

> However, there's no 1:1 correspondence between those two. For example,
> when looking purely at the physical output of a PWM it is in most cases
> not possible to make the distinction between these two states:
>=20
>     - duty: 0
>       period: 100
>=20
>     - duty: 0
>       period: 200
>=20
> Because the output will be a constant 0 (or 1, depending on polarity).

I agree that there isn't in all cases a unique pwm_state that formalizes
the current output. That's because with .enabled=3Dfalse the settings
=2Eduty_cycle and .period hardly matter for the output and when
=2Eduty_cycle =3D 0 or =3D .period the actual period also (mostly) doesn't
matter.

> However, given that we want a snapshot of the currently configured
> settings, we can't simply assume that there's a 1:1 correspondence and
> then use shortcuts to simplify the hardware state representation because
> it isn't going to be accurate.

When we assume that pwm_get_state returns the state of the hardware,
relying on these values might be too optimistic. Consider a hardware
(e.g.  pwm-cros-ec) that has no disable switch. Disabling is modeled by
=2Eduty_cycle =3D 0. So after:

	pwm_apply_state(mypwm, { .period =3D 1000, .duty_cycle =3D 500, .enabled =
=3D false })

doing:

	pwm_get_state(pwm, &mystate);
	mystate.enabled =3D true;
	pwm_apply_state(pwm, &mystate);

the PWM stays configured with .duty_cycle =3D 0.

There are also more delicate surprises. Consider a PWM that can
implement all duty_cycles and periods with a resolution of 30 ns up to
the consumers preferred period of 2000 ns and uses the usual round-down
strategy. Consider the consumer wants to repeatedly switch between 75%
and 50% relative duty cycle.=20

When relying on .get_state, the first configuration is likely to still
be 1500/2000. .get_state() then returns

	.duty_cycle =3D 1500
	.period =3D 1980

and then to implement the 50% relative duty the resulting request is

	.duty_cycle =3D 990
	.period =3D 1980

which can be implemented exactly. When then switching back to 75% the
request is

	.duty_cycle =3D 1485
	.period =3D 1980

yielding a period of 1470 ns. So this is a different setting than on the
first go to implement 75% because the rounding errors accumulate.

The IMHO only sane way out is that the consumer should always request
1500/2000 and 1000/2000.

So I think calculating the state from the previously implemented state
has too many surprises and should not be the recommended way.
Consumers should just request what they want and provide this state
without relying on .get_state(). And then the needs to cache the
duty_cycle for a disabled PWM or reading the period for a disabled PWM
just vanish in thin air.

> It is entirely expected that consumers will be able to use an existing
> atomic state, update it and then apply it without necessarily having to
> recompute the whole state. So what pwm-backlight is doing is expressly
> allowed (and in fact was one specific feature that we wanted to have in
> the atomic API).

Who is "we"?

> Similarly it's a valid use-case to do something like this:
>=20
> 	/* set duty cycle to 50% */
> 	pwm_get_state(pwm, &state);
> 	state.duty_cycle =3D state.period / 2;
> 	pwm_apply_state(pwm, &state);

The cost to continue doing that is that the consumer has to cache the
state. Then the idiom looks as follows:

	state =3D &driver_data->state;
	state->duty_cycle =3D state->period / 2;
	pwm_apply_state(pwm, state);

which=20

 - allows to drop caching in the PWM layer (which is good as it
   simplifies the PWM framework and saves some memory for consumers that
   don't need caching)

 - doesn't accumulate rounding errors

 - needs less PWM API calls

Also I think keeping the PWM configuration in the consumer instead of
the PWM is the right place, but I assume that's subjective. I don't
oppose to caching the previously applied state for consumers, but IMHO
we should differentiate between the currently configured state and the
previously applied state as there are semantic differences between these
two.

Note that even if we somehow normalize the state returned by a driver's
=2Eget_state callback (e.g. by setting .duty_cycle =3D 0 for disabled PWMs)
this still matches your expectation that "consumers will be able to use
an existing atomic state, update it and then apply without necessarily
having to recompute the whole state". The critical part is just that
consumers should not start with a pwm_state returned by .get_state() but
=66rom the previously requested state.

> which allows a consumer to do simple modifications without actually
> knowing what period has been configured. Some consumers just don't care
> about the period or don't even have a clue about what a good value would
> be (again, pwm-backlight would be one example). For some PWMs it may
> also not be possible to modify the period and if there's no explicit
> reason to do so, why should consumers be forced to even bother?
>=20
> All of that's out the window if we start taking shortcuts. If the PWM
> provider reads out the hardware state's PWM as "don't care", how is the
> consumer going to know what value to use? Yes, they can use things like
> pwm_get_args() to get the configuration from DT, but then what's the
> purpose of using states in the first place if consumers have to do all
> the tracking manually anyway?

With my approach the consumers always have to explicitly request a
complete setting, but I'd consider this an advantage that makes the
mechanisms clearer. Other than that I don't see any disadvantages and
the PWM framework can stop pretending things that don't match (the
hardware's) reality.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7pgcsfvfttsgo4kx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBkTiQACgkQwfwUeK3K
7Ak+iAf/U/thXBAcuYUK9XOEClmxQVv0c9KXgZ+glpXpWw95u/9DvzvcekOSh5zu
vWg1SwjmUxp7eE2dK/oUFfvau9TfOt2OTo8JrguXwFh72uhL9ZaQu+bJ4n7NMkFu
bVIC37p4nktnvAGAfcSSvjnb9cbmNrx9JJNVFBRrkaEdYJAgH6sIuP+gYT/IaVz/
DX6nCgcybFR85Du8cuyI5K6Tgp3zGwFzYyGR/KPMTh730fspupodIUzT8H5UvZgR
+qzt0HKpkE3bCb3I/M/6SyF6iQ3ZnNmmDpcDUIyFtYGUW9dkRns+d/LKsKdKbSUG
rf6RYEmaouUfsSxPuuJ/CoH6Z+r7Ew==
=GQaC
-----END PGP SIGNATURE-----

--7pgcsfvfttsgo4kx--
