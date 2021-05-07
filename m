Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66422376D36
	for <lists+linux-pwm@lfdr.de>; Sat,  8 May 2021 01:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEGXTf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 May 2021 19:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhEGXTe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 May 2021 19:19:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C075C061574
        for <linux-pwm@vger.kernel.org>; Fri,  7 May 2021 16:18:34 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lf9js-0007eI-RW; Sat, 08 May 2021 01:18:32 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lf9js-00072L-3R; Sat, 08 May 2021 01:18:32 +0200
Date:   Sat, 8 May 2021 01:18:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Sven Van Asbroeck <TheSven73@gmail.com>
Subject: Re: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM
 state
Message-ID: <20210507231831.zmvyspcq7xhm25y4@pengutronix.de>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
 <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
 <YJVhLrkeNXBp6M1p@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ksziii7f32ahf4ic"
Content-Disposition: inline
In-Reply-To: <YJVhLrkeNXBp6M1p@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ksziii7f32ahf4ic
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Fri, May 07, 2021 at 05:47:58PM +0200, Clemens Gruber wrote:
> On Fri, May 07, 2021 at 05:03:17PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, May 07, 2021 at 03:18:42PM +0200, Clemens Gruber wrote:
> > > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > > index 5bb90af4997e..5a73251d28e3 100644
> > > --- a/include/linux/pwm.h
> > > +++ b/include/linux/pwm.h
> > > @@ -54,12 +54,17 @@ enum {
> > >   * @duty_cycle: PWM duty cycle (in nanoseconds)
> > >   * @polarity: PWM polarity
> > >   * @enabled: PWM enabled status
> > > + * @usage_power: If set, the PWM driver is only required to maintain=
 the power
> > > + *               output but has more freedom regarding signal form.
> > > + *               If supported, the signal can be optimized, for exam=
ple to
> > > + *               improve EMI by phase shifting individual channels.
> > >   */
> > >  struct pwm_state {
> > >  	u64 period;
> > >  	u64 duty_cycle;
> > >  	enum pwm_polarity polarity;
> > >  	bool enabled;
> > > +	bool usage_power;
> > >  };
> > > =20
> > >  /**
> >=20
> > If we really want to support this usecase, I would prefer to not have it
> > in pwm_state because this concept is not a property of the wave form. So
> > for a driver it doesn't really make sense to set this flag in
> > .get_state().
>=20
> It is related to the wave form in so far as it allows the driver to
> change the wave form as long as the power output remains the same.

Yes, the thing I wanted to express is: usage_power is a software thing.
Just from reading the hardware registers you can never know if
usage_power is set or not. So it is conceptually slightly different than
the other members of pwm_state which all are represented 1:1 in
hardware.

> > Maybe it makes more sense to put this in a separate argument for a
> > variant of pwm_apply_state? something like:
> >=20
> > 	int pwm_apply_state_transition(struct pwm_device *pwm, const struct pw=
m_state *state, const struct pwm_state_transition *transition);
> >=20
> > and pwm_state_transition can then contain something like this usage
> > power concept and maybe also a sync flag that requests that the call
> > should only return when the new setting is active and maybe also a
> > complete_period flag that requests that the currently running period
> > must be completed before the requested setting is implemented.
> >=20
> > OTOH the information "I only care about the relative duty cycle" is
> > relevant longer than during the transition to a new setting. (So if
> > there are two consumers and one specified to be only interested in the
> > relative duty cycle, the other might be allowed to change the common
> > period.)
>=20
> As you said, usage_power does not only apply to one state transition.
>=20
> > Having said that, I don't like the proposed names. Neither "usage_power"
> > nor "pwm_apply_state_transition".
> >=20
> > In a non-representative survey among two hardware engineers and one
> > software engineer who already contributed to PWM (!=3D me) I found out
> > that these three have an intuitive right understanding of
> > "allow-phase-shift" but have no idea what "usage-power" could mean.
>=20
> One advantage of usage_power is that it is not limited to phase
> shifting. Drivers could do other optimizations as long as the power
> output remains the same.

Freedom you give to the lowlevel driver might be a burden to the
consumer. I think it makes sense to split the concept into:

	PWM_ALLOW_PHASE_SHIFT		1
	PWM_SET_RELATIVE_DUTY		2
	PWM_SET_POWER			(PWM_ALLOW_PHASE_SHIFT | PWM_SET_RELATIVE_DUTY)

This way a consumer (e.g. a clock driver) who doesn't care about the
phase shift but wants a fixed period can specify that, and if a consumer
really only cares about the emitted power that's possible, too.

And given that your driver actually only implements a phase shift I
suggest not to generalize more than necessary here; also because the
semantic of usage-power isn't well defined. So this is something where I
agree to Thierry: Let's not solve a problem we don't have. (Though he
comes to a different conclusion here.)

> > On a side note: The hardware guys noted that it might make sense to
> > align the shifted phases. i.e. instead of shifting channel i by i *
> > period/16, it might be better to let the 2nd channel get active when the
> > first gets inactive. (i.e. try to keep the count of active channels
> > constant).
>=20
> I am not sure what you mean exactly, because the duty cycles of the
> 16 outputs are not necessarily the same and can all be active at the
> same time. The idea is to spread the edges out as evenly as possible.
> Shifting them by period/16 is the best way to smoothen the current
> spikes in my opinion and the implementation is also very simple.

Yes, the algorithm needed to satisfy this wish is more complicated. And
maybe it even isn't possible to implement it in a sane way, I didn't
think about it much. I just believed them that if you have two channels
that run at 50% it's better to have a phase shift of 50% between them
than 6.25%. Maybe it makes sense to align the start of channel #i+1 (if
allowed) to the end of channel #i to already get a better behaviour on
average than the fixed offset depending on the channel number.

> > And as already mentioned earlier I still think we should define the
> > concept of "usage power" better. It should be clearly defined for a
> > driver author which setting they should pick for a given request. This
> > removes surprises for consumers and guessing for lowlevel driver
> > authors. Also a uniform policy brings conflicts better to light.
> > (Something like driver A does the right thing for consumer C and driver
> > B makes it right for D. But once D tries to use A things break. (And
> > then maybe A is changed to fit D, and C doesn't object because they
> > don't read the pwm list resulting in a breakage for C later.))
>=20
> I added documentation and comments to the header file as a first step
> but we can always improve them.

In my book the documentation is inadequate because it doesn't define how
a driver should behave and so doesn't define what the consumer can
expect. With your description all settings I suggested in
https://lore.kernel.org/r/20210413175631.pwbynvwmnn7oog4m@pengutronix.de
are allowed. I don't think this is a good idea.

And given that all people I talked to about "usage-power" were unable to
correctly guess its semantic, I'm convinced that we need a better name.
This is something you cannot outweigh with documentation -- most people
won't read it anyway.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ksziii7f32ahf4ic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCVyr4ACgkQwfwUeK3K
7An7xgf/cvnetFcNEugQ1gDLUwbuovGmtfiiynpfiUf/6ep8keswBQgXVyf2HWu9
LlcXst0Row5G8etH201tgPFu5cbf5T9Mi50ckDhbruSIvl1B7vyjPCMiclsXPe3Q
8WqHTbchvgHVVYbjU+gXtMoSQmEmcRYjB1Wdv13c6r/aPkX461nQD5faYSq6ewDd
QPgFZjryqHYbXrQsD5LNUkaDbIkHE+gdaS120z0AyUW0WD4M9S1iVJLE4k39NcVS
jPnB3MzylA/oGN3k0eIdZqptjNlVrhPcVtazB3cXCsXqJhFCrWwynQmQ+4KA/XqF
HqvW4UYmHwJgqEP7Wg+bzR6sva9ykQ==
=KaxH
-----END PGP SIGNATURE-----

--ksziii7f32ahf4ic--
