Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7AE3503D8
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Mar 2021 17:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhCaPwj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 31 Mar 2021 11:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbhCaPwW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 Mar 2021 11:52:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0780C061574;
        Wed, 31 Mar 2021 08:52:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bf3so22895139edb.6;
        Wed, 31 Mar 2021 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aPao8vVfMifLnCt4un1X4EWUmmT+xd9qi3zAXZX1qRg=;
        b=CmVi6RnLIZo4D6I8qCK6qJkQ64nmAkbzv2hFIQcZQRKzoM/pkRXSTzcfHN0HT4hDzG
         pWGNmEdPGN5o6dbbpsb2pGLJAWiuvzr4jvioKqkoH4z3MRFMdCi0zZTFbx3zTKThcdk2
         89iA2bOiwQ/YdVn4JRv1w/FH6fR27fTOYFHy+joS3LOv9kKlF+En6cQrR21tyqkEYnOx
         wltZNQj9fRO9R9RaZWkYDRNvdV+grTv0X0skvTDRlvCxY1VMELFQPGzWGI5zfGqYoD5c
         y7/c9rLiEZTRhR7kg/rDCU72rh92dlur0iakDO8S4QycheNeblru22C0UjBwPQT9ASUj
         Sgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aPao8vVfMifLnCt4un1X4EWUmmT+xd9qi3zAXZX1qRg=;
        b=AEdxdtoGOc2xDAQ538MwZXcqVCP52TBc8LdhTMexQyKS9o0kf2aqMDvUEcO4JiZVOs
         jNnK5blGSJbKLPemk/rJJADEjH7Tgt/+ZvrtD/aORfgKOuK3ZZD9uqqKlv/7VYw+E5uP
         hh4bGzAa4Ku1OlEwgMEQ411YiuDxD2HozD7ubYvsX7ACnQ0F2K/c10sNvmipOlvMy+MA
         o88tWqWcsSnN1p2jUUinrXaC0s7Isy7bn5t53IXK/XyQK6Ak+546Pr/gsRFlktXXECe+
         cD0lL0yrY/roGdMkJmPzTZf22SyAhZ6iDWcpyGWDSi/K+pN4MYj2EuEICCN1Z9xpOKf+
         DiRg==
X-Gm-Message-State: AOAM533J/x9KpPbwBLziNfkHSzEPaAf8GUHHhqT5QQbcdpgZlk6S/3oY
        FQCV71CN9Kuf1BcITP8Pz/A=
X-Google-Smtp-Source: ABdhPJzUlSRPqeo5TwvrgcMfBXgZfyQfpaOeX2mIJihlQyN/TzP5ccKFpVsFdd8Jm0MZ9wx9Yv+6xA==
X-Received: by 2002:a50:ed96:: with SMTP id h22mr4467483edr.39.1617205940302;
        Wed, 31 Mar 2021 08:52:20 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id g22sm1442256ejm.69.2021.03.31.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 08:52:18 -0700 (PDT)
Date:   Wed, 31 Mar 2021 17:52:45 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YGSazQSm+xPtbjCX@orome.fritz.box>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
 <X/H5CqcRHelg5M4p@workstation.tuxnet>
 <20210111204350.k2bhpdj7xnnqkfi3@pengutronix.de>
 <YFhWjXAF/D6oBpGE@orome.fritz.box>
 <20210331102543.adefgrpkuaqkbg3x@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AfdCWXY/uLoBIPX"
Content-Disposition: inline
In-Reply-To: <20210331102543.adefgrpkuaqkbg3x@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7AfdCWXY/uLoBIPX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 31, 2021 at 12:25:43PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Mon, Mar 22, 2021 at 09:34:21AM +0100, Thierry Reding wrote:
> > On Mon, Jan 11, 2021 at 09:43:50PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Sun, Jan 03, 2021 at 06:04:10PM +0100, Clemens Gruber wrote:
> > > > Another point is the period: Sven suggested we do not read out the
> > > > period at all, as the PWM is disabled anyway (see above).
> > > > Is this acceptable?
> > >=20
> > > In my eyes consumers should consider the period value as "don't care"=
 if
> > > the PWM is off. But this doesn't match reality (and maybe also it
> > > doesn't match Thierry's opinion). See for example the
> > > drivers/video/backlight/pwm_bl.c driver which uses the idiom:
> > >=20
> > > 	pwm_get_state(mypwm, &state);
> > > 	state.enabled =3D true;
> > > 	pwm_apply_state(pb->pwm, &state);
> > >=20
> > > which breaks if .period is invalid. (OK, this isn't totally accurate
> > > because currently the .get_state callback has only little to do with
> > > pwm_get_state(), but you get the point.)
> >=20
> > The idea behind atomic states in the PWM API is to provide accurate
> > snapshots of a PWM channel's settings. It's not a representation of
> > the PWM channel's physical output, although in some cases they may
> > be the same.
>=20
> I think the pwm_state returned by .get_state() should be an accurate
> representation of the PWM channel's physical output.

Yeah, like I said, in most cases that will be true. However, as
mentioned below, if there's no 1:1 correspondence between the settings
and what's actually coming out of the PWM, this isn't always possible.
But yes, it should always be as accurate as possible.

> > However, there's no 1:1 correspondence between those two. For example,
> > when looking purely at the physical output of a PWM it is in most cases
> > not possible to make the distinction between these two states:
> >=20
> >     - duty: 0
> >       period: 100
> >=20
> >     - duty: 0
> >       period: 200
> >=20
> > Because the output will be a constant 0 (or 1, depending on polarity).
>=20
> I agree that there isn't in all cases a unique pwm_state that formalizes
> the current output. That's because with .enabled=3Dfalse the settings
> .duty_cycle and .period hardly matter for the output and when
> .duty_cycle =3D 0 or =3D .period the actual period also (mostly) doesn't
> matter.
>=20
> > However, given that we want a snapshot of the currently configured
> > settings, we can't simply assume that there's a 1:1 correspondence and
> > then use shortcuts to simplify the hardware state representation because
> > it isn't going to be accurate.
>=20
> When we assume that pwm_get_state returns the state of the hardware,
> relying on these values might be too optimistic. Consider a hardware
> (e.g.  pwm-cros-ec) that has no disable switch. Disabling is modeled by
> .duty_cycle =3D 0. So after:
>=20
> 	pwm_apply_state(mypwm, { .period =3D 1000, .duty_cycle =3D 500, .enabled=
 =3D false })
>=20
> doing:
>=20
> 	pwm_get_state(pwm, &mystate);
> 	mystate.enabled =3D true;
> 	pwm_apply_state(pwm, &mystate);
>=20
> the PWM stays configured with .duty_cycle =3D 0.

Uhm... no, that's not what should be happening. pwm_get_state() copies
the PWM channel's internal software state. It doesn't actually go and
read the hardware state. We only ever read the hardware state when the
PWM is requested. After that there should be no reason to ever read back
the hardware state again because the consumer owns the state and that
state must not change unless explicitly requested by the owner.

So in the above case, mystate.duty_cycle should be 500 after that call
to pwm_get_state(). The fact that the hardware can't explicitly disable
a PWM and needs to emulate that by setting duty-cycle =3D 0 is a driver
implementation detail and shouldn't leak to the consumer.

> There are also more delicate surprises. Consider a PWM that can
> implement all duty_cycles and periods with a resolution of 30 ns up to
> the consumers preferred period of 2000 ns and uses the usual round-down
> strategy. Consider the consumer wants to repeatedly switch between 75%
> and 50% relative duty cycle.=20
>=20
> When relying on .get_state, the first configuration is likely to still
> be 1500/2000. .get_state() then returns
>=20
> 	.duty_cycle =3D 1500
> 	.period =3D 1980
>=20
> and then to implement the 50% relative duty the resulting request is
>=20
> 	.duty_cycle =3D 990
> 	.period =3D 1980
>=20
> which can be implemented exactly. When then switching back to 75% the
> request is
>=20
> 	.duty_cycle =3D 1485
> 	.period =3D 1980
>=20
> yielding a period of 1470 ns. So this is a different setting than on the
> first go to implement 75% because the rounding errors accumulate.
>=20
> The IMHO only sane way out is that the consumer should always request
> 1500/2000 and 1000/2000.
>=20
> So I think calculating the state from the previously implemented state
> has too many surprises and should not be the recommended way.
> Consumers should just request what they want and provide this state
> without relying on .get_state(). And then the needs to cache the
> duty_cycle for a disabled PWM or reading the period for a disabled PWM
> just vanish in thin air.

Again, note that ->get_state() and pwm_get_state() are two different
things. The naming is perhaps a bit unfortunate...

But also, the above should never happen because drivers are not supposed
to modify the software state and the core will never use ->get_state()
to read back the hardware state. Basically that means that
pwm_get_state(), followed by pwm_apply_state() called on the same PWM
and the same state object should be an idempotent operation.

Well, it's possible for a driver to have to modify the software state to
more accurately reflect what has been configured to hardware. So the
pwm_get_state()/pwm_apply_state()/pwm_get_state() sequence may give you
a different state from the initial state. However it must not be to a
degree that would make a subsequent pwm_apply_state() change the values
again.

So I guess the idempotency rule really is more like this: the following
sequence must always yield the same PWM signal:

	pwm_apply_state(pwm, &state);
	pwm_get_state(pwm, &state);
	pwm_apply_state(pwm, &state);

> > It is entirely expected that consumers will be able to use an existing
> > atomic state, update it and then apply it without necessarily having to
> > recompute the whole state. So what pwm-backlight is doing is expressly
> > allowed (and in fact was one specific feature that we wanted to have in
> > the atomic API).
>=20
> Who is "we"?

Myself and whoever else was involved back at the time when we designed
the atomic API.

> > Similarly it's a valid use-case to do something like this:
> >=20
> > 	/* set duty cycle to 50% */
> > 	pwm_get_state(pwm, &state);
> > 	state.duty_cycle =3D state.period / 2;
> > 	pwm_apply_state(pwm, &state);
>=20
> The cost to continue doing that is that the consumer has to cache the
> state. Then the idiom looks as follows:
>=20
> 	state =3D &driver_data->state;
> 	state->duty_cycle =3D state->period / 2;
> 	pwm_apply_state(pwm, state);

Sorry but no. Consumers have no business reaching into driver-data and
operating on the internal state objects.

> which=20
>=20
>  - allows to drop caching in the PWM layer (which is good as it
>    simplifies the PWM framework and saves some memory for consumers that
>    don't need caching)

What exactly is complicated in the PWM framework that would need to be
simplified. This is really all quite trivial.

>  - doesn't accumulate rounding errors

See above, if rounding errors accumulate then something is wrong. This
shouldn't be happening.

Now, the above idempotency rule does not rule out rounding that can
occur due to consumer error. So consumers need to be aware that some
hardware state may not be applied exactly as specified. Reusing too
much of the state may introduce these rounding errors. So yes, if you
want to toggle between 50% and 75% duty cycles, consumers should spell
that out explicitly, perhaps by caching the PWM args and reusing period
=66rom that, for example.

>  - needs less PWM API calls
>=20
> Also I think keeping the PWM configuration in the consumer instead of
> the PWM is the right place, but I assume that's subjective. I don't
> oppose to caching the previously applied state for consumers, but IMHO
> we should differentiate between the currently configured state and the
> previously applied state as there are semantic differences between these
> two.
>=20
> Note that even if we somehow normalize the state returned by a driver's
> .get_state callback (e.g. by setting .duty_cycle =3D 0 for disabled PWMs)
> this still matches your expectation that "consumers will be able to use
> an existing atomic state, update it and then apply without necessarily
> having to recompute the whole state". The critical part is just that
> consumers should not start with a pwm_state returned by .get_state() but
> from the previously requested state.

Again, see above. pwm_get_state() does not use ->get_state().

> > which allows a consumer to do simple modifications without actually
> > knowing what period has been configured. Some consumers just don't care
> > about the period or don't even have a clue about what a good value would
> > be (again, pwm-backlight would be one example). For some PWMs it may
> > also not be possible to modify the period and if there's no explicit
> > reason to do so, why should consumers be forced to even bother?
> >=20
> > All of that's out the window if we start taking shortcuts. If the PWM
> > provider reads out the hardware state's PWM as "don't care", how is the
> > consumer going to know what value to use? Yes, they can use things like
> > pwm_get_args() to get the configuration from DT, but then what's the
> > purpose of using states in the first place if consumers have to do all
> > the tracking manually anyway?
>=20
> With my approach the consumers always have to explicitly request a
> complete setting, but I'd consider this an advantage that makes the
> mechanisms clearer. Other than that I don't see any disadvantages and
> the PWM framework can stop pretending things that don't match (the
> hardware's) reality.

That's really no different from what's currently happening. Consumers
always request a full state to be applied. The only difference is that
some of the values might be cached. But again, that's really a good
thing. Why should consumers need to have their own copy of PWM state
if all the want to do is toggle a PWM on and off?

And this is all very subjective. I don't think requiring consumers to
keep their own cached copy of the state is going to make things clearer
at all. If anything it complicates things for consumers. For example if
we ever want to extend PWM state with an additional field, we would end
up having to modify every single consumer to make sure it copies the
whole state. If we deal with the state in the core like we do right now
we only need to update the core (and perhaps some consumers that really
care about the new field).

Thierry

--7AfdCWXY/uLoBIPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBkmssACgkQ3SOs138+
s6EPgw//XGFvW/1Pxgtyan0EBx9NZgUxZRs18rfASZW//SdrV3TFk7TYjVKYDGBk
lSEAZco0ULtOlwgV9He+ZLZAKNKYV8pkMlhbnajy9wFVDkB+7uViavDiSY0qgXpY
tHlz88mTPT1IA1BDWypdzWOfgi9R3rzCbpQCvNW6KFa0fEhgUsdeV/u0wha171D9
ini86lXj1VkPKGJ3xubY2hnhr2O+4o/GLSRcvyCGsR+Jm8kvLCO1wdSNEgxX648M
9+UcQWbGjKOOdxzKPgSunj5alOzVD0p9I4uh/cPLSp3GjlOsh+pLVzaCiO2yn020
vbWDpYQLA4amwtLVtAWsahJqqF259f9EO1hzaPPJHp8t7zuwN5Vjq86iFL8SxiTu
GZaI92BI+pUxfNrtv6j7UZLIiFYLILTPn6u0X+3FNc/lP7iVU9DD8SM1CGnVCth6
RJ5vQ1Nv8R8hoi0WfJ9YalQbWZBnvezzK/4dMASNlqTjJX7wdDtr0E94ikbEDFJ0
ncTLVEYuPv2PRZ8TwT/xNmE7H2ouqrpCULUzwYuTTq1TN+R/t/Mwu2TjeGmRKA9H
sKFQqhL3YnDC3IAcg1VptbBu8hZrQfRjY/aAKVcRMaBcqN0zMNJPHiQaYcXQnj3B
wUr4mldqD0lMRTr3ppZy9gr5472KirEP82GDtCLIMhSQZFFbuSk=
=Vhj0
-----END PGP SIGNATURE-----

--7AfdCWXY/uLoBIPX--
