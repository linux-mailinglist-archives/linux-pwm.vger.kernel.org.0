Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B233219B578
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Apr 2020 20:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgDAS2k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Apr 2020 14:28:40 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:44834 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732550AbgDAS2k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Apr 2020 14:28:40 -0400
Received: by mail-wr1-f42.google.com with SMTP id m17so1202901wrw.11;
        Wed, 01 Apr 2020 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZncHyOoJjkFmS+sQOOqUPobNWn7RtQeut3He9rdTvyM=;
        b=D36D2ETg4uIrll8PwB6hfLXp6jQ9nceJX01rX/252zuScsGY9+4KBXulhsafVhSMQN
         ymRvzZNhb8iZhct+9SNEgqkPsPNt68m41GDCo3rBnIg094NIJVygKzfz2lp8RSEl8MDd
         5a+NXMoLtoGnlgZYHI7no9sh/MIEYJ3f2Rd2Jb24EyAbJQJPPG3GoCgMsipdr+NmOMxw
         +RhgsxIIGtGOvOk25Zbao9hWi34rbZT12BHjTildY1ecT+LAajJFf2HAJscxwmKKqd9L
         RGtH2R/+a+O+0Jtz6J1fQw6UqNRz+s2ny64aYECPclGjndFr9jBE6+qPUFaY/oT4YXob
         nUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZncHyOoJjkFmS+sQOOqUPobNWn7RtQeut3He9rdTvyM=;
        b=Fa6MqY6niIYZgabh+aqS8272pqfDosBZoh8IoeKDRvdhGfer0oIeLXMlz1+mkda0S8
         X94PeRBDDOREkKtBQPDefnwh7Jt0PueY4+MeteH6mW/COJMNg/6POl8jGKN34905yEWk
         7tSRWTHTcEm3DOVzMrcZ29unAEIbOF7z+IsMtoXbhFnzHWGqwLDdgjPYeY345cXbIF1G
         +JRk01g59Oa97y4G74hbx8qLL8rJSKIdLn6FAMShpDoccEEVtWTHfRPS/cDZZ/rSmn3f
         8LlhEW1vqUAxbjfT5jg5flY9scH8iVI2JYM69IeM789LCy5pGO3402tdzvkme3DfipFL
         0kfQ==
X-Gm-Message-State: ANhLgQ3wm5h1EDYawwL+C/3rqZ5YbKoWkl4QWlnF3yDpxkrz0eI9t+DM
        ghnEfKYyKO3urIYcePdIbc4=
X-Google-Smtp-Source: ADFU+vtpE8mOpHGPcWQl3Li68+mEyamIjX88KweJNLyHPn+MnChuhIdF2CVJf5rmUaTC8XU525hl5A==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr26978145wrs.391.1585765716435;
        Wed, 01 Apr 2020 11:28:36 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id c85sm3662379wmd.48.2020.04.01.11.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 11:28:34 -0700 (PDT)
Date:   Wed, 1 Apr 2020 20:28:33 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
Message-ID: <20200401182833.GB2978178@ulmo>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
 <20200330191654.waoocllctanh5nk5@pengutronix.de>
 <20200331204559.GB2954599@ulmo>
 <20200401082227.sxtarbttsmmhs2of@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <20200401082227.sxtarbttsmmhs2of@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 10:22:27AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Tue, Mar 31, 2020 at 10:45:59PM +0200, Thierry Reding wrote:
> > On Mon, Mar 30, 2020 at 09:16:54PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Mon, Mar 30, 2020 at 04:14:36PM +0200, Thierry Reding wrote:
> > > > On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-K=C3=B6nig wro=
te:
> > > > > On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> > > > > > Only the Timer control register(TCLR) cannot be updated when th=
e timer
> > > > > > is running. Registers like Counter register(TCRR), loader regis=
ter(TLDR),
> > > > > > match register(TMAR) can be updated when the counter is running=
=2E Since
> > > > > > TCLR is not updated in pwm_omap_dmtimer_config(), do not stop t=
he
> > > > > > timer for period/duty_cycle update.
> > > > >=20
> > > > > I'm not sure what is sensible here. Stopping the PWM for a short =
period
> > > > > is bad, but maybe emitting a wrong period isn't better. You can h=
owever
> > > > > optimise it if only one of period or duty_cycle changes.
> > > > >=20
> > > > > @Thierry, what is your position here? I tend to say a short stop =
is
> > > > > preferable.
> > > >=20
> > > > It's not clear to me from the above description how exactly the dev=
ice
> > > > behaves, but I suspect that it may latch the values in those regist=
ers
> > > > and only update the actual signal output once a period has finished=
=2E I
> > > > know of a couple of other devices that do that, so it wouldn't be
> > > > surprising.
> > > >=20
> > > > Even if that was not the case, I think this is just the kind of thi=
ng
> > > > that we have to live with. Sometimes it just isn't possible to have=
 all
> > > > supported devices adhere strictly to an API. So I think the best we=
 can
> > > > do is have an API that loosely defines what's supposed to happen and
> > > > make a best effort to implement those semantics. If a device deviat=
es
> > > > slightly from those expectations, we can always cross fingers and h=
ope
> > > > that things still work. And it looks like they are.
> > > >=20
> > > > So I think if Lokesh and Tony agree that this is the right thing to=
 do
> > > > and have verified that things still work after this, that's about as
> > > > good as it's going to get.
> > >=20
> > > I'd say this isn't for the platform people to decide. My position here
> > > is that the PWM drivers should behave as uniform as possible to minim=
ize
> > > surprises for consumers. And so it's a "PWM decision" that is to be m=
ade
> > > here, not an "omap decision".
> >=20
> > I think there's a fine line to be walked here. I agree that we should
> > aim to have as much consistency between drivers as possible. At the same
> > time I think we need to be pragmatic. As Lokesh said, the particular use
> > case here requires this type of on-the-fly adjustment of the PWM period
> > without stopping and restarting the PWM. It doesn't work otherwise. So
> > th alternative that you're proposing is to say that we don't support
> > that use-case, even though it works just fine given this particular
> > hardware. That's not really an option.
>=20
> I understand your opinion here. The situation now is that in current
> mainline the driver stops the hardware for reconfiguration and it
> doesn't fit Lokesh's use case so he changed to on-the-fly update
> (accepting that maybe a wrong period is emitted). What if someone relies
> on the old behaviour? What if in a year someone comes and claims the
> wrong period is bad for their usecase and changes back to
> stop-to-update?

Relying on that old behaviour is wrong. If you really need to rely on
the PWM being stopped before reconfiguration, then you should explicitly
request that by first disabling the PWM, then reconfiguring it and then
reenabling it.

> When I write a consumer driver, do I have a chance to know how the PWM,
> that I happen to use, behaves? To be able to get my consumer driver
> reliable I might need to know that however.

No, there's currently no way of knowing. As such, I think the most
sensible thing to do at this point is to work with the API in order to
get the behaviour that you want. If you need to be able to reconfigure
the PWM without stopping it, then just call pwm_config(), or preferably
pwm_apply_state() with only the duty-cycle and/or period (or perhaps
even polarity) changed but keeping the PWM enabled.

Now if you're unlucky the driver won't support that and you'll notice
eventually. But there's also nothing you can do about that if the
hardware doesn't work that way. Even if the PWM framework had a way of
querying these types of peculiarities it wouldn't really proved much of
an advantage since the driver would just refuse to probe rather than
attempting to do this and maybe succeeding because you got lucky.

I suppose one variant that we could implement is to have drivers return
an error if they are being asked to reconfigure while the PWM remains
on. But then again, it's hard to know whether the driver writer really
depends on the PWM remaining on the whole time and seamlessly
transitioning to the new period/duty-cycle, or whether they just do it
out of convenience.

Take for example a backlight driver. Ideally you'd be able to seamlessly
change the brightness by just modifying the duty-cycle while the PWM is
enabled. If you have to turn the PWM off, reconfigure it and then turn
it back on, it could always happen that the backlight may flicker
because it actually goes completely dark for a little bit. In practice I
would expect the delay to be negligible because this is ultimately
converted to an analog power and hence the small dip to 0 isn't going to
matter very much. So if we change the API to refuse to reconfigure at
runtime for cases where the PWM has to be disabled and enabled during
reconfiguration, that may all of a sudden cause failures where none were
observed before.

> > > > I know this is perhaps cheating a little, or turning a blind eye, b=
ut I
> > > > don't know what the alternative would be. Do we want to tell people=
 that
> > > > a given PWM controller can't be used if it doesn't work according t=
o our
> > > > expectations? That's hard to argue if that controller works just fi=
ne
> > > > for all known use-cases.
> > >=20
> > > I'd like have some official policy here which of the alternatives is =
the
> > > preferred cheat.
> > >=20
> > > The situation here is that period and duty_cycle cannot be updated
> > > atomically. So the two options are:
> > >=20
> > >  - stop shortly
> > >  - update with hardware running and maybe emit a broken period
> >=20
> > I think we can already support both of those with the existing API. If
> > a consumer wants to stop the PWM while reconfiguring, they should be
> > able to do pwm_enable(), pwm_config(), pwm_enable() (or the atomic
> > equivalent) and for the second case they can just do pwm_config() (or
> > the atomic equivalent).
>=20
> Yes, the consumer can force the stop and update. But assume I'm "only" a
> consumer driver author and I want: atomic update and if this is not
> possible I prefer "stop-to-update" over "on-the-fly-and-maybe-faulty".
> So I cannot benefit from a good driver/hardware that can do atomic
> updates? Or I have to patch each driver that I actually use to use
> stop-to-update?

You could do what everybody does and just assume that atomic update
works. If it works with the particular PWM device/driver that you have
that may be all you care about. Obviously that may not be true for a
different chip.

On the other hand, if you absolutely must ensure that there must never
be any glitches whatsoever but don't care whether the PWM goes through a
disable/enable sequence, then doing so explicitly is going to be your
best bet. From a consumer driver point of view it isn't going to matter
because even if we had a way of distinguishing between these
capabilities you'd still have to have code to deal with both.

So the only relevant use-case here would be if you had a requirement to
perform on-the-fly-and-strictly-correct updates. The API doesn't give
those kinds of guarantees. So we would need an extension that consumers
can query to determine whether what they want to do will work.

But like I said above, the chances that you will run into this are slim
because use-cases are typically known ahead of time and devices are
designed to be able to support them. So if you build a device that needs
to support these strict requirements, then you need to make sure the
hardware supports it, too. And when the hardware supports it, then the
driver should implement ->config() or ->apply() in a way that allows
this.

> > Some hardware may actually require the PWM to be disabled before
> > reconfiguring, so they won't be able to strictly adhere to the second
> > use-case.
> >=20
> > But as discussed above, I don't want to strive for a lowest common
> > denominator that would preclude some more specific use-cases from
> > working if the hardware supports it.
> >=20
> > So I think we should aim for drivers to implement the semantics as
> > closely as possible. If the hardware doesn't support some of these
> > requirements strictly while a particular use-case depends on that, then
> > that just means that the hardware isn't compatible with that use-case.
> > Chances are that the system just isn't going to be designed to support
> > that use-case in the first place if the hardware can't do it.
> >=20
> > The sysfs interface is a bit of a special case here because it isn't
> > possible to know what use-cases people are going to come up with.
>=20
> In my eyes the sysfs interface isn't special here. You also don't know
> what the OMAP PWM hardware is used for.

But platform designers will know what their device will be used for. If
they know that it will be used for a case that the OMAP PWM doesn't
support, then they had better choose a different chip. Or add an extra
IC that provides a PWM that can do what they need.

> > It's most likely that they'll try something and if it doesn't work
> > they can see if a driver patch can improve things.
>=20
> So either the group who prefers "stop-to-update" or the group who
> prefers "on-the-fly-and-maybe-faulty" has to carry a system specific
> driver patch?

No, the group that prefers "stop-to-update" should make that explicit
and write a consumer driver that first disables, then reconfigured and
then reenables the PWM.

If they don't *need* to update the PWM on the fly, then performing two
additional steps that would be happening anyway won't matter, right?

> > One possible extension that I can imagine would be to introduce some
> > sort of capability structure that drivers can fill in to describe the
> > behaviour of the hardware. Drivers like pwm-omap-dmtimer, for example,
> > could describe that they are able to change the period and/or duty cycle
> > while the PWM is on. There could be another capability bit that says
> > that the current period will finish before new settings are applied. Yet
> > another capability could describe that duty-cycle and period can be
> > applied atomically. Consumers could then check those capabilities to see
> > if they match their requirements.
> >=20
> > But then again, I think that would just make things overly complicated.
> > None of the existing consumers need that, so it doesn't seem like there
> > is much demand for that feature. In practice I suspect most consumers
> > work fine despite potentially small deviations in how the PWM behaves.
>=20
> I think the status quo is what I asked about above: People use sysfs and
> if the PWM behaves different than needed, the driver is patched and most
> of the time not mainlined. If your focus is to support a certain
> industrial system with a defined use case, this is fine. If however you
> target for an universal framework that works for any combination of
> consumer + lowlevel driver without patching (that at least is able to
> diagnose: This PWM cannot provide what my consumer needs), this is bad.

Again, my response to this is: how is this going to be beneficial? In
practice the way that this would work is that the consumer driver would
fail if presented with a PWM that doesn't meet the strict requirements.
Now if the requirements really are that strict, then that sounds like a
good idea.

But one issue I foresee with this is that we'll end up giving consumers
too much of a toolkit to restrict things. What if the consumer driver
author assumes wrongly that a given set of requirements exists? What if
for some combination of hardware that doesn't strictly conform to those
requirements it might still work? Sometimes you may not notice the
difference, at other times there may be some impact like a visual glitch
or so, but that may be something that users are willing to accept rather
than not have support at all.

> Also this means that whenever a system designer changes something on
> their machine (kernel update, different hardware, an new usecase for a
> PWM) they might have to reverify if the given PWM driver behaves as
> needed.

I don't expect this type of change to happen very often. There's always
going to be some type of fine-tuning before a driver's behaviour is
completely stabilized. And then there could still always be other
factors impacting behaviour that aren't even related to the PWM
framework.

I suspect that most people will have an array of tests to validate that
everything still works after a kernel update. Obviously we don't want a
new kernel to behave completely differently, but we're not talking about
that here. This is merely dropping a needless disable/enable from a
configuration. If somebody was relying on this happening they were wrong
to rely on it to begin with because the API does not guarantee it.

> My suggestion for now is to start documenting how the drivers behave
> expanding how limitations are documented in some drivers. So maybe
> change from "Limitations" to "Implementation and Hardware Details"?

Yes, collecting such information is always a good idea.

Thierry

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6E3U8ACgkQ3SOs138+
s6Hhmw//UJatpUX+ELWVQDNxgMjGIaJwzsZjo6eMonGgKpZPrh/EmpGzKzl61oFE
Hj8eKxhGce4bYNjowK0MkqGHngbAPXPq6vShtr8JOey3kOIeFTMknTJLyAH2L6x3
E4c9cyopOj31V1BxwzJwkj0ztAS0HV20otAOb5/qfvAM49XtyFTBMT8aYEzDeQ+1
hWUTgQ5TjizdzqcdHJvK8uIwdxgYyzHXtvxu1qsJzyZA/4laWuBdM94bOvyeQeyv
/tHxhB2z4IF7r/Gtvd1IfQF3Df9Od+dRhHzFCVB5jtRL9gMqzy4fduRkKm/b3ODL
OE/y/K1G24XEGiz7fsaOq0anf1a/R2OG4MTxoPR/2Ml6mnJhiWpAUx5w/BiWGUHe
hk5UveFmT70/biVeEI2wnj9UHpkDB55+2dUNJWipCEvp+7TvX6a+Oohoge424U+A
NVq9ej6fN0XHsleibJ7fRhGM9v1l0LMQ86RP/aoVMjM/rprsZrG+b0sDE1HEZwZB
G7dF0uCmK/7AksR+Eze7vaNgijm07gPovafdOAHb8tUTuzbGLf3rkZmukyHtRJ4F
4ZlBCQKq7nn3cC/Rlv7UaaV0O9SnHCwDd1a1JE4UYI4cig/lnZxGBrJmSmSNu9hF
sjE+pHl0SdrZCa192pjWhp03LJmEGEAGq+mXT6CgNjTOyEOa3Pc=
=f6Ur
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
