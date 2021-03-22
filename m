Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8A34409A
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 13:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhCVMPc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 08:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhCVMPQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 08:15:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FEAC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 05:15:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v11so16426655wro.7
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+SS7ewtHS/8sEt0xCqKB03M+mrlFUzi10kQWVG/aV4=;
        b=TKx81DD3NTG3Va/dDD4oAAdYhlF/c0BITRZf0hfWX5Hq5abdkCbo4FiR8l2T5S/dRj
         tW9JphswLZIGGWDJUc9grlPymyvQDODOMV+BtOZqCDoOrhAg8WXo9f2d6XU7/bgYkrZa
         u+SwBgNccG2oD6Fk9GrrokaJWL1v2Yds3DAU5gWGwnWVRfuxS0OlyCt6QTinVB9FQyhu
         EQooMjzkLdBflrS1dbL1i4S5iZzDa+xQHXbbDG/poTxoD4FujEjsA952oU1hqOvQpjM2
         LHnqHJ19QFlX9mKFDc6YNLS8og9fbvp/4RRqc+KyLFt0W10V4sVO4030xA/3Scdtzn4q
         7HKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y+SS7ewtHS/8sEt0xCqKB03M+mrlFUzi10kQWVG/aV4=;
        b=lkjfl3dHdVIGJi6yvyoq8bU2GCTpeuUN3i7cV/9nVVHzz9Tr00nDcWuy159CxZS2/s
         NTi7QcQXYzm5r4AR9XNfFSYBLy2iGygxiceSK1SCmIHaERFGXSD4fqNWtp1tP8RLwrGC
         hhJPmtSm3wDXn3tyNcid3lDi1wSzn9KNrT48Z6/w6x+54Sw9Ey/UqJuu01/QU4n4CWBC
         UDKFZDrEHRdbulUc7FgkMTfNjjcODQULW2DLetTsu84FE2X75dH0T2qz7abRzgoc6QZR
         nWInSBLez89N3Gfo2otgYlLBLQj6waNV5Lux5mzhCVuVqh+c2QDYZJfsn/ewVQZH9MdI
         a+Vg==
X-Gm-Message-State: AOAM531MTUP3RU0JOH6R51eji1anibILGi2LTEiLl1nCp0Dm8ur8K4gt
        mxvlAwCGm5g5Uq8xzDmnUgY=
X-Google-Smtp-Source: ABdhPJxUBC6T4o0Il6iCfFwo0lQywGgm3bU+ibZ/9psZJ46Xrz5t7Q+HNU8whpE6c1jttcMZX0U3cw==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr18081619wrm.37.1616415314768;
        Mon, 22 Mar 2021 05:15:14 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id i16sm20335568wmq.3.2021.03.22.05.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:15:13 -0700 (PDT)
Date:   Mon, 22 Mar 2021 13:15:31 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de, Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v3] pwm: Soften potential loss of precision in compat code
Message-ID: <YFiKY7nrIDj+ZD47@orome.fritz.box>
References: <20210315080050.2337075-1-u.kleine-koenig@pengutronix.de>
 <YFh7uCgeir4L+ZTf@orome.fritz.box>
 <20210322112947.iru2dj3yggkhecwl@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bBaCeP+6ur3hzXPe"
Content-Disposition: inline
In-Reply-To: <20210322112947.iru2dj3yggkhecwl@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--bBaCeP+6ur3hzXPe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2021 at 12:29:47PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Mar 22, 2021 at 12:12:56PM +0100, Thierry Reding wrote:
> > On Mon, Mar 15, 2021 at 09:00:51AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > The legacy callback .config() only uses int for period and duty_cycle
> > > while the corresponding values in struct pwm_state are u64. To prevent
> > > that a value bigger than INT_MAX is discarded to a very small value,
> > > explicitly check for big values and pass INT_MAX instead of discardin=
g.
> > >=20
> > > Acked-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Changes since v2 (Message-Id: 20210312212119.1342666-1-u.kleine-koeni=
g@pengutronix.de)
> > >=20
> > >  - Fixed indention of comment (noticed by Guru Das)
> > >  - Add Ack for Guru Das.
> > >=20
> > >  drivers/pwm/core.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index 4b3779d58c5a..b1adf3bb8508 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -605,9 +605,18 @@ int pwm_apply_state(struct pwm_device *pwm, cons=
t struct pwm_state *state)
> > > =20
> > >  		if (state->period !=3D pwm->state.period ||
> > >  		    state->duty_cycle !=3D pwm->state.duty_cycle) {
> > > +			int duty_cycle, period;
> > > +
> > > +			/*
> > > +			 * The legacy callbacks use only (signed!) int for
> > > +			 * period and duty_cycle compared to u64 in struct
> > > +			 * pwm_state. So clamp the values to INT_MAX.
> > > +			 */
> > > +			period =3D min(state->period, (u64)INT_MAX);
> > > +			duty_cycle =3D min(state->duty_cycle, (u64)INT_MAX);
> >=20
> > Do we want to highlight this using a WARN()?
>=20
> That would be fine for me, too. In the past you were not happy with
> WARN I added, so I implemented this in a silent way.

The WARN that I remember was in a completely different context. There
are occasions when it's good to be loud. I think this is one of them.

> > It seems to me like doing this would always be a programming error and
> > easy to fix. Silently truncating this to just INT_MAX may not give the
> > desired effect and be actively wrong most of the time.
> >=20
> > Come to think of it: why not just refuse such requests with -EINVAL?
> > That's what drivers already do if they're faced with values that they
> > can't handle.
>=20
> No, the strategy I ask authors of new drivers to implement is to program
> the biggest possible period not bigger than the requested period. So if
> a consumer requests INT_MAX+3 it must already today cope with the case
> that it gets a smaller period.

That just seems wrong. I mean to a degree this might be sensible, but
the way you do this here it's completely out of hands. What if somebody
tries to configure this?

	duty-cycle: 0x0000000100000000
	period:     0x0000000200000000

Clearly what they were aiming for is a 50% duty-cycle, but with your
proposal, this will now result in a 100% duty-cycle, which is cleary not
what's requested here.

That's different, in my opinion, from a case where you may have to round
a little bit and get a deviation of, say, 1% in the resulting signal.

> The underlaying problem can only be solved with a way to query the
> resulting configuration for a given request. I have a prototype I can
> share if you're interested.

I don't think we need to go all the way for this legacy code. But I
think we need to make sure that people get a result that is reasonably
within what they asked for. And I think just flat out rejecting these
kinds of requests that are completely out of bounds of the hardware is
better than silently clamping the values. I'd be surprised if this even
had an impact at all on any existing drivers because it had, the
truncation that's currently happening would've likely already exposed
any of them.

Also, in most of these cases the period has been hand-picked and is part
of device tree (or some legacy PWM lookup table), and it was picked
because it is supported by the hardware. Since the duty-cycle always has
to be smaller than the period (we actively reject configurations if that
is not the case), I don't think it likely that we'd currently hit these
conditions at all.

Thierry

--bBaCeP+6ur3hzXPe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYimAACgkQ3SOs138+
s6FTWw/8D/FL4q2qYBwUN7aYW55KjqjSCeAUTY8OxLoSEWJuFZQkW61O/CNdP5Kb
lKUzFeXTn6+3j4eFug/QFcXhsi205IZCw7WmWZfChxaAOUctfXkwsPXlPpDP+d6T
zTxj05LjcQccpAPTzCU8QTexscE4yGLs3vLLNj+50XIuxiIVacxJyjNkweJXtm4D
OdjAJZG6C1Q3MBbus8aWnF2tpvNXGMCeMgjAAoimrlVxpy9lXYjsRwyL1CV7R0uj
xHrn7rSIe0gQLO2JsP1rVkHQvyiB2Fo4O40+UbL+a7bfJAP+bFw6iw48jb9dIzTT
wpBHyuoCLmSBgQ1gZVahQlEzxH3OJuhUybVoU3Ls0jOK4RnogOwQC6yyccPh4X5U
9g72Jdx+xHgqmRRdGuwiBUcIh1WbslsECtrAJyOVw3q+PhH0cc9NVdT8o5xxYXD+
k8s8uziSqO46owU3xT629FPMw44oKBjEYrrVMHiW/JyzJzvFbaOkQ9xPKbB+mdtr
VTTdANJAooZR8vrx/XKfyLwhNBpNSs0HB8nWUqxQ5wyRcIRD+UYZwWwexfGKdQoF
jiJrT4Gjg306/GChpZHjhIZv6H1Zj8n1AX+qWuyyjrtYezwOX3rvPB0GLSw+TvVP
ANNymmUkiyUORfZOxauPi6PUum5p6p1awBHOIuK8cesxE81tRS0=
=Eaeb
-----END PGP SIGNATURE-----

--bBaCeP+6ur3hzXPe--
