Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB58535559D
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 15:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbhDFNqy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 09:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhDFNqy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 09:46:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D49FC06174A;
        Tue,  6 Apr 2021 06:46:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u17so15774212ejk.2;
        Tue, 06 Apr 2021 06:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jEXNCWbPtcTszsy+iZu9mciJinXFU2BKs4Y5TkOllSI=;
        b=viKS8nDLdtds4FAWbPCZQ/2vF36iBQUIpC+BBu3mX9WPv/dGHeF9iggjdrm7tOb8tw
         ASXkA/H+T8LaZiwBS8TbS8mm2ddkJxkzn1pLHBhS/Cdp/YTYrCWtmxmRR3yaJ7D+Cfxw
         1B7rWrWtfZJWRzusB54L1Zsbmb2AK4eyeTLBeMyCcI4x1WEF4ps/bRvvd1CzvkBJ9ku4
         hJLLwwg6L/ZJmBZ4H6kqL7ckOXmRLanJDrt0E6T6gaDgEHrlZ+YJqMdd+ozm7m8qDXOq
         kiZBMtPp/GaAUXoZMuiKpMyvJQLoG4ClnoPW9CK7ZvsnojFovK9BlwzE7f8kKL3DiQUT
         Bi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jEXNCWbPtcTszsy+iZu9mciJinXFU2BKs4Y5TkOllSI=;
        b=m1GVXfbNJ+h21vnVqwIm/Z+qyrbunOFGRn483Q+BLmsi+zMlR8TRM9ApztrFOfgESV
         pKTAj7xNdT8i0KHP0TzBZJ61ryddlKxAgbP6bPqlZoPps/wtsPG9t2yOmM3r7KM1il1B
         wNOy72N2d2aHkGzHOyZxjiREpvGI7z7dadM70oV0poxaEJYkjm5VXahCQDzKVG/pYnrR
         7tN1te1dkL5wR/K9at1TlKJ9WK30GaMVYdvKqRuus8OFInFrIHjgURLl+6805xJ+PDGb
         JeG+rJPSHj5tHhMmYVYhvtu/CkQfqdE9M00ZDr3W6AlmblL/VuwPz3Aw/dz5TYWAxTMi
         V/gA==
X-Gm-Message-State: AOAM531l03fivi15UM+llqoADY3Ar4v82tcJ3B5MjSXKGFRZOJkluLCN
        ZuFGxvUx/NJmsCIQU7pwInc=
X-Google-Smtp-Source: ABdhPJwzbSyFGnMxMW4FqqRJbYBB4nZMdgPIFcho+DdH/eGNQ+GTlY4ktooZi69HAj/Ro5uqfajpnQ==
X-Received: by 2002:a17:906:4bce:: with SMTP id x14mr33530314ejv.383.1617716804562;
        Tue, 06 Apr 2021 06:46:44 -0700 (PDT)
Received: from localhost (p2e5be490.dip0.t-ipconnect.de. [46.91.228.144])
        by smtp.gmail.com with ESMTPSA id e15sm7297384ejr.66.2021.04.06.06.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 06:46:42 -0700 (PDT)
Date:   Tue, 6 Apr 2021 15:47:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YGxmY3xYLoX+PW5E@orome.fritz.box>
References: <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
 <X/H5CqcRHelg5M4p@workstation.tuxnet>
 <20210111204350.k2bhpdj7xnnqkfi3@pengutronix.de>
 <YFhWjXAF/D6oBpGE@orome.fritz.box>
 <20210331102543.adefgrpkuaqkbg3x@pengutronix.de>
 <YGSazQSm+xPtbjCX@orome.fritz.box>
 <20210406063357.x6ty25eiamu44lev@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fvqiFcT5UFAxbUXa"
Content-Disposition: inline
In-Reply-To: <20210406063357.x6ty25eiamu44lev@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fvqiFcT5UFAxbUXa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 06, 2021 at 08:33:57AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Mar 31, 2021 at 05:52:45PM +0200, Thierry Reding wrote:
> > On Wed, Mar 31, 2021 at 12:25:43PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Mar 22, 2021 at 09:34:21AM +0100, Thierry Reding wrote:
> > > > On Mon, Jan 11, 2021 at 09:43:50PM +0100, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Sun, Jan 03, 2021 at 06:04:10PM +0100, Clemens Gruber wrote:
> > > > > > Another point is the period: Sven suggested we do not read out =
the
> > > > > > period at all, as the PWM is disabled anyway (see above).
> > > > > > Is this acceptable?
> > > > >=20
> > > > > In my eyes consumers should consider the period value as "don't c=
are" if
> > > > > the PWM is off. But this doesn't match reality (and maybe also it
> > > > > doesn't match Thierry's opinion). See for example the
> > > > > drivers/video/backlight/pwm_bl.c driver which uses the idiom:
> > > > >=20
> > > > > 	pwm_get_state(mypwm, &state);
> > > > > 	state.enabled =3D true;
> > > > > 	pwm_apply_state(pb->pwm, &state);
> > > > >=20
> > > > > which breaks if .period is invalid. (OK, this isn't totally accur=
ate
> > > > > because currently the .get_state callback has only little to do w=
ith
> > > > > pwm_get_state(), but you get the point.)
> > > >=20
> > > > The idea behind atomic states in the PWM API is to provide accurate
> > > > snapshots of a PWM channel's settings. It's not a representation of
> > > > the PWM channel's physical output, although in some cases they may
> > > > be the same.
> > >=20
> > > I think the pwm_state returned by .get_state() should be an accurate
> > > representation of the PWM channel's physical output.
> >=20
> > Yeah, like I said, in most cases that will be true. However, as
> > mentioned below, if there's no 1:1 correspondence between the settings
> > and what's actually coming out of the PWM, this isn't always possible.
> > But yes, it should always be as accurate as possible.
>=20
> It should always be true, not only in most cases. For any given PWM
> output you can provide a pwm_state that describes this output (unless
> you'd need a value bigger than u64 to describe it or a higher precision
> as pwm_state only uses integer values). So it's a 1:n relation: You
> should always be able to provide a pwm_state and in some cases there are
> more than one such states (and you should still provide one of them).

My point is that the correspondence between the pwm_state and what's
programmed to hardware can't always be read back to unambiguously give
the same result. As you mentioned there are these cases where the PWM
channel doesn't have a separate enable bit, in which case it must be
emulated by setting the duty cycle to 0.

In such cases it doesn't make sense to always rely on ->get_state() to
read back the logical state because it just can't. How is it supposed to
know from reading that 0 duty cycle whether that means the PWM is on or
off? So for the initial read-out we can't do any better so we have to
pick one. The easiest would probably be to just assume PWM disabled when
duty cycle is 0 and in most cases that will be just fine as the
resulting PWM will be the same regardless of which of the two options we
pick.

However, what I'm also saying is that once the consumer has called
pwm_apply_state(), there's no reason to read back the value from
hardware and potentially loose information about the state that isn't
contained in hardware. If the consumer has applied this state:

	{
		.period =3D 100,
		.duty_cycle =3D 0,
		.polarity =3D PWM_POLARITY_NORMAL,
		.enabled =3D true,
	}

then why would we want to have it call ->get_state() and turn this into:

	{
		.period =3D 100,
		.duty_cycle =3D 0,
		.polarity =3D PWM_POLARITY_NORMAL,
		.enabled =3D false,
	}

? If pwm_apply_state() has properly applied the first state there's no
reason for the consumer to continue using either its own cache or the
PWM framework's cache (via pwm_get_state()) and just toggle the bits as
necessary.

> > > > However, given that we want a snapshot of the currently configured
> > > > settings, we can't simply assume that there's a 1:1 correspondence =
and
> > > > then use shortcuts to simplify the hardware state representation be=
cause
> > > > it isn't going to be accurate.
> > >=20
> > > When we assume that pwm_get_state returns the state of the hardware,
> > > relying on these values might be too optimistic. Consider a hardware
> > > (e.g.  pwm-cros-ec) that has no disable switch. Disabling is modeled =
by
> > > .duty_cycle =3D 0. So after:
> > >=20
> > > 	pwm_apply_state(mypwm, { .period =3D 1000, .duty_cycle =3D 500, .ena=
bled =3D false })
> > >=20
> > > doing:
> > >=20
> > > 	pwm_get_state(pwm, &mystate);
> > > 	mystate.enabled =3D true;
> > > 	pwm_apply_state(pwm, &mystate);
> > >=20
> > > the PWM stays configured with .duty_cycle =3D 0.
> >=20
> > Uhm... no, that's not what should be happening.
>=20
> Agreed, it shouldn't be happening. Note the paragraph started with "When
> we assume that pwm_get_state returns the state of the hardware" and with
> that my statement is correct. And so the conclusion is that calculations
> by the consumer should always be done based on requested states, not on
> actually implemented settings.
>=20
> > pwm_get_state() copies the PWM channel's internal software state. It
> > doesn't actually go and read the hardware state. We only ever read the
> > hardware state when the PWM is requested. After that there should be
> > no reason to ever read back the hardware state again because the
> > consumer owns the state and that state must not change unless
> > explicitly requested by the owner.
>=20
> I have problems to follow your reasoning. What is the semantic of "PWM
> channel's internal software state"? What is "currently configured
> setting"?
>=20
> There are two different possible semantics for pwm_get_state():
>=20
>  a) The state that was passed to pwm_apply_state() before.
>  b) What is actually configured in hardware.
>=20
> Currently the implemented semantic is a). (Apart from the very beginning
> when there wasn't anything applied before.) And there is no way for a
> consumer to get b). If you only ever want to yield a) there is indeed
> no need to read the state from hardware.

b) should only ever be necessary the first time a PWM is used. We
currently do that at request time because then we always guarantee that
the PWM state is up to date for every new consumer.

=46rom a consumer point of view the difference between a) and b) shouldn't
matter. b) is the driver-specific representation of a), taking into
account any of the device's restrictions. So in order to be truly
agnostic of the underlying PWM controller, consumers should only ever
work with a).

Note that there's technically also:

	c) the driver-specific representation of what was passed to
	   pwm_apply_state()

The difference to a) being that it may have adjusted values for period
and duty cycle depending on any scaler restrictions and such. There's
also a difference to b) in that we can have information that the
hardware is not able to contain (such as the difference between duty
cycle =3D 0 and "off" by the presence of that extra "enabled" field).

> > So in the above case, mystate.duty_cycle should be 500 after that call
> > to pwm_get_state(). The fact that the hardware can't explicitly disable
> > a PWM and needs to emulate that by setting duty-cycle =3D 0 is a driver
> > implementation detail and shouldn't leak to the consumer.
> >=20
> > > [...]
> > >
> > > So I think calculating the state from the previously implemented state
> > > has too many surprises and should not be the recommended way.
> > > Consumers should just request what they want and provide this state
> > > without relying on .get_state(). And then the needs to cache the
> > > duty_cycle for a disabled PWM or reading the period for a disabled PWM
> > > just vanish in thin air.
> >=20
> > Again, note that ->get_state() and pwm_get_state() are two different
> > things.
>=20
> I'm aware and interpret your statement here as confirmation that the
> function that consumers base their calculations on should always return
> the state that was requested before.

Yes.

> > The naming is perhaps a bit unfortunate...
>=20
> What about renaming pwm_get_state() then, to pwm_get_last_applied_state()?

I replied to that patch earlier and I don't think it's worth the churn
and it just makes the API more cumbersome to use. If there's any
confusion we can clarify with better kerneldoc.

> > But also, the above should never happen because drivers are not supposed
> > to modify the software state and the core will never use ->get_state()
> > to read back the hardware state.
>=20
> Agreed. So .get_state() is only ever called at driver load time. (Well,
> there is the PWM_DEBUG stuff, but that doesn't leak to the consumer.)

No that's not correct. ->get_state() can also be called when the
consumer changes.

> Then I think low level drivers should be allowed to make use of this
> fact and drop all caching of data between .apply() and .get_state(), for
> example for pwm-cros-ec:

No, I don't think there's a need to remove that code. It's entirely
reasonable to keep this extra information if it helps to more accurately
reflect the hardware state.

Thierry

>=20
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index c1c337969e4e..fb865f39da9f 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -38,26 +38,6 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_e=
c_pwm(struct pwm_chip *c)
>  	return container_of(c, struct cros_ec_pwm_device, chip);
>  }
> =20
> -static int cros_ec_pwm_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
> -{
> -	struct cros_ec_pwm *channel;
> -
> -	channel =3D kzalloc(sizeof(*channel), GFP_KERNEL);
> -	if (!channel)
> -		return -ENOMEM;
> -
> -	pwm_set_chip_data(pwm, channel);
> -
> -	return 0;
> -}
> -
> -static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
> -{
> -	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
> -
> -	kfree(channel);
> -}
> -
>  static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16=
 duty)
>  {
>  	struct {
> @@ -116,7 +96,6 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  			     const struct pwm_state *state)
>  {
>  	struct cros_ec_pwm_device *ec_pwm =3D pwm_to_cros_ec_pwm(chip);
> -	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
>  	u16 duty_cycle;
>  	int ret;
> =20
> @@ -134,8 +113,6 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  	if (ret < 0)
>  		return ret;
> =20
> -	channel->duty_cycle =3D state->duty_cycle;
> -
>  	return 0;
>  }
> =20
> @@ -143,7 +120,6 @@ static void cros_ec_pwm_get_state(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
>  				  struct pwm_state *state)
>  {
>  	struct cros_ec_pwm_device *ec_pwm =3D pwm_to_cros_ec_pwm(chip);
> -	struct cros_ec_pwm *channel =3D pwm_get_chip_data(pwm);
>  	int ret;
> =20
>  	ret =3D cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
> @@ -154,20 +130,7 @@ static void cros_ec_pwm_get_state(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> =20
>  	state->enabled =3D (ret > 0);
>  	state->period =3D EC_PWM_MAX_DUTY;
> -
> -	/*
> -	 * Note that "disabled" and "duty cycle =3D=3D 0" are treated the same.=
 If
> -	 * the cached duty cycle is not zero, used the cached duty cycle. This
> -	 * ensures that the configured duty cycle is kept across a disable and
> -	 * enable operation and avoids potentially confusing consumers.
> -	 *
> -	 * For the case of the initial hardware readout, channel->duty_cycle
> -	 * will be 0 and the actual duty cycle read from the EC is used.
> -	 */
> -	if (ret =3D=3D 0 && channel->duty_cycle > 0)
> -		state->duty_cycle =3D channel->duty_cycle;
> -	else
> -		state->duty_cycle =3D ret;
> +	state->duty_cycle =3D ret;
>  }
> =20
>  static struct pwm_device *
>=20
> > Basically that means that pwm_get_state(), followed by
> > pwm_apply_state() called on the same PWM and the same state object
> > should be an idempotent operation.
>=20
> Agreed.
>=20
> > Well, it's possible for a driver to have to modify the software state to
> > more accurately reflect what has been configured to hardware. So the
> > pwm_get_state()/pwm_apply_state()/pwm_get_state() sequence may give you
> > a different state from the initial state. However it must not be to a
> > degree that would make a subsequent pwm_apply_state() change the values
> > again.
>=20
> Now you lost me. If pwm_get_state() has semantic a) (i.e. return the
> pwm_state that was passed before to pwm_apply_state()) there is no
> deviation necessary or possible. So I don't see how the state could ever
> change in the pwm_get_state()/pwm_apply_state()/pwm_get_state()
> sequence. Please explain in more detail.

I don't think this is still a bit of a grey area, though admittedly I'm
not sure if there are any drivers that currently do this. I recall that
there had been discussions at some point whether it was a good idea to
let drivers update pwm->state to reflect the state that was actually
programmed. If so, it'd mean that pwm_get_state() could yield a state
that is slightly different from a) (this is basically the c) case that I
described above). However, it represents the exact same settings that
would have been applied with the state that was originally specified.

To pick up the idempotency rule from below, this is what would happen:

	1. pwm_apply_state(pwm, &state);
	2. pwm_get_state(pwm, &state);
	3. pwm_apply_state(pwm, &state);

The driver may have to adjust parameters slightly when applying the
state passed in during step 1. If it chooses to update the internal
state, then the state returned in step 2 may differ from the state
passed in during step 1. However, since it's the driver-specific
representation of the original state, when applying it again in step 3,
the PWM output should be exactly the same as after step 1.

> > So I guess the idempotency rule really is more like this: the following
> > sequence must always yield the same PWM signal:
> >=20
> > 	pwm_apply_state(pwm, &state);
> > 	pwm_get_state(pwm, &state);
> > 	pwm_apply_state(pwm, &state);
>=20
> This is just another idempotency rule.  So there isn't "the" idempotency
> rule, in my eyes both should apply. That is:
>=20
>  1) ("your" idempotency rule) Applying a state returned by pwm_get_state()
>     should not modify the output. (Note: True for both semantics a) and b=
))
>  2) ("my" idempotency rule) When a state that was returned by
>     .get_state() (i.e. semantic b) only) is applied, .get_state() should
>     return the same state afterwards.

That's exactly what I described above as the first idempotency rule. And
yes, I agree that both of those rules should hold true.

> > > > It is entirely expected that consumers will be able to use an exist=
ing
> > > > atomic state, update it and then apply it without necessarily havin=
g to
> > > > recompute the whole state. So what pwm-backlight is doing is expres=
sly
> > > > allowed (and in fact was one specific feature that we wanted to hav=
e in
> > > > the atomic API).
> > > >
> > > > Similarly it's a valid use-case to do something like this:
> > > >=20
> > > > 	/* set duty cycle to 50% */
> > > > 	pwm_get_state(pwm, &state);
> > > > 	state.duty_cycle =3D state.period / 2;
> > > > 	pwm_apply_state(pwm, &state);
> > >=20
> > > The cost to continue doing that is that the consumer has to cache the
> > > state. Then the idiom looks as follows:
> > >=20
> > > 	state =3D &driver_data->state;
> > > 	state->duty_cycle =3D state->period / 2;
> > > 	pwm_apply_state(pwm, state);
> >=20
> > Sorry but no. Consumers have no business reaching into driver-data and
> > operating on the internal state objects.
>=20
> I wouldn't call a struct pwm_state driver-data. This is the way to
> communicate between driver and consumer and so also with your idiom the
> consumer has to use it. But ok, we can continue caching the last
> requested pwm_state.

struct pwm_state is not data at all, it's a definition. But once you
embed a struct pwm_state into a driver-specific structure and you
instantiate that data, then the embedded struct pwm_state also becomes
driver-specific data. Your example showed that the consumer was reaching
into driver-specific data to obtain the state and that's what I objected
to.

> > > which=20
> > >=20
> > >  - allows to drop caching in the PWM layer (which is good as it
> > >    simplifies the PWM framework and saves some memory for consumers t=
hat
> > >    don't need caching)
> >=20
> > What exactly is complicated in the PWM framework that would need to be
> > simplified. This is really all quite trivial.
>=20
> Even dropping trivial stuff is nice in my eyes.
>=20
> > >  - doesn't accumulate rounding errors
> >=20
> > See above, if rounding errors accumulate then something is wrong. This
> > shouldn't be happening.
> >=20
> > Now, the above idempotency rule does not rule out rounding that can
> > occur due to consumer error.
> >=20
> > So consumers need to be aware that some
> > hardware state may not be applied exactly as specified. Reusing too
> > much of the state may introduce these rounding errors.
>=20
> Yes, if you start not to return the last requested state and consumers
> make calculations based on that, you indeed get rounding errors.=20
>=20
> > So yes, if you want to toggle between 50% and 75% duty cycles,
> > consumers should spell that out explicitly, perhaps by caching the PWM
> > args and reusing period from that, for example.
>=20
> You really confuse me. The obvious way to cache the PWM args is using a
> pwm_state, isn't it? So you're saying exactly what I proposed?!

See the "So yes" confirmation at the beginning of that sentence? Looks
like I did agree with what you were proposing, although, admittedly, I'm
having trouble finding in the backlog what exactly that proposal was.

Thierry

--fvqiFcT5UFAxbUXa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBsZmEACgkQ3SOs138+
s6GrcxAAkj3f2NYz2pj1QiejIhQ+gP/IiKXWC1dUehK/uep/iJOxgWlrO/agVe+z
CvMakAIsqW9gUye0bx43e1/qWQE0BZ2FzWdrQGE3BriYELqxpBbr3ZE0HyM3PG4p
SiU9WImS8wDhxpDAfP7SwL80HNW41Zj69CXWWb2JQWip4bEHAf1NdziFo8f8JMFi
Kjj8YYG1/i+EhXmEc2Sqw2RHKicKGydFRkCLEwdaMs0a5+YlngGw6S+WWnq1iJJQ
0WpNneierI+0UUFX2D4XoKi1EXV0S/2YXA8iSTA0SCM0UrFcX148ds68IkdZCt+d
Z1qNpFGbJyYTqM3Z2cDU4g32CbVmJlwQbpg908YwnMGehWDeCV5LVXlqSfZ+bDgk
Kp5DU47XNVsLKdOzY5/KmictFQPGRToqt7l0Qh6Q4qs6TV3zP90+lkk9XTbNk/ge
BplPigBIIlBBKvy8xT+19Mn2VKjiYFDw4VNqXAT/mKzqtRK9gd/lMYws26k7YJW3
Q7Fx5FGXmp9W2uC9vgrNUq9nQUcQnBntKNVbESEM+3YeuY7M102j56B+97imwtpJ
GlySUuBtkmt/jLZROaqXuFfDxfOyir4bxnzTXDpUSG7/XbT0USusnLMaS9cm+vKy
7jVFj8LM1RR2R1BJ7ai59QPiSGIAvG2b1hHQFmlCUEI6xgeTUsk=
=HEDq
-----END PGP SIGNATURE-----

--fvqiFcT5UFAxbUXa--
