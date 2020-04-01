Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF419B7B9
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Apr 2020 23:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbgDAVhp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Apr 2020 17:37:45 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:35441 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAVho (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Apr 2020 17:37:44 -0400
Received: by mail-wm1-f42.google.com with SMTP id i19so1443160wmb.0;
        Wed, 01 Apr 2020 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YsfqtH5etvutHP159Pjpxy9NIWhuknmNi6KImMhfQ6I=;
        b=oV/LqFtE9E8GWf7pqPsIM443c3qV3yPAv1X90zrDzV5u3Bi1+lSWaIToIIdDpBdH8N
         s0Nq9YkCWzok0HuBikR/70wYsLmfejX8VE63O1SOYsm7+RPDGQL0gaM/DAvoEkTgYYWv
         82v3sPeT8B9K8K7RBv1y/j6/lTtNWyb7CnzL6tC2h0kPonpYP5NzWgfn+5gjJ03AuVhJ
         YXRTNtoV9me/YJA35JBRDxPEP9CY5drE1SwW4+LJyFwnkTB6p1G4mzMhl31mJuHPD0qT
         g7+zVVyNO6YoaOPI6wGDfn5ko2LPY+CRxyVNBi7QypzDNN0ciIDivMljPNeEFfa3Oslc
         zDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YsfqtH5etvutHP159Pjpxy9NIWhuknmNi6KImMhfQ6I=;
        b=JijuwEwwgGudrtj3JLc+CouIt/4bc9ekUhxLVRWC3SOb4StOPYMgZAK0v+RvsdD6c4
         dnfWtCePlmB/C35C7u2acu9y/9AFJcBQrHYQhMSy/Mk5Txf8+oOcC3U3WtNcnpj0rCXj
         DKickJd7Kma/gNnMeoaH2tm43pRB5LPoAAw7V9dSFV5H3hMIKNKiDu+TSYARie6BpkDv
         Cp626ECgVvFbLrKrCIUQJPf2CGvTscBg1sU3s4J9vny/6KitS9IuhXR7SEzooZWAS/u0
         fi2EZmWLnL3wrxCyH/du1kAnMPYj6e1uSrTwbkPHAQMRrZusjk9mmmCHAGNMzKAokICi
         virw==
X-Gm-Message-State: AGi0Puan4tU3Q1YZ6nI4e2J7j2AuB6DKqzHnJUeh9S79CPZES5fii2/z
        dmJsdWKbw3YxXQefQyipghU=
X-Google-Smtp-Source: APiQypLI2wGNgUA3PzfkjwVRHHqHyhZdVLog1shJ3IGHEHTs49t2uHEqKw+msim34m0Zc9G0mK7Lpw==
X-Received: by 2002:a1c:4805:: with SMTP id v5mr42955wma.98.1585777061276;
        Wed, 01 Apr 2020 14:37:41 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id t5sm4804582wrr.93.2020.04.01.14.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 14:37:39 -0700 (PDT)
Date:   Wed, 1 Apr 2020 23:37:38 +0200
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
Message-ID: <20200401213738.GA3052587@ulmo>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
 <20200330191654.waoocllctanh5nk5@pengutronix.de>
 <20200331204559.GB2954599@ulmo>
 <20200401082227.sxtarbttsmmhs2of@pengutronix.de>
 <20200401182833.GB2978178@ulmo>
 <20200401203156.d7x5ynnnhob3jyoo@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20200401203156.d7x5ynnnhob3jyoo@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 10:31:56PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Apr 01, 2020 at 08:28:33PM +0200, Thierry Reding wrote:
> > On Wed, Apr 01, 2020 at 10:22:27AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > On Tue, Mar 31, 2020 at 10:45:59PM +0200, Thierry Reding wrote:
> > > > I think there's a fine line to be walked here. I agree that we shou=
ld
> > > > aim to have as much consistency between drivers as possible. At the=
 same
> > > > time I think we need to be pragmatic. As Lokesh said, the particula=
r use
> > > > case here requires this type of on-the-fly adjustment of the PWM pe=
riod
> > > > without stopping and restarting the PWM. It doesn't work otherwise.=
 So
> > > > th alternative that you're proposing is to say that we don't support
> > > > that use-case, even though it works just fine given this particular
> > > > hardware. That's not really an option.
> > >=20
> > > I understand your opinion here. The situation now is that in current
> > > mainline the driver stops the hardware for reconfiguration and it
> > > doesn't fit Lokesh's use case so he changed to on-the-fly update
> > > (accepting that maybe a wrong period is emitted). What if someone rel=
ies
> > > on the old behaviour? What if in a year someone comes and claims the
> > > wrong period is bad for their usecase and changes back to
> > > stop-to-update?
> >=20
> > Relying on that old behaviour is wrong.  If you really need to rely on
> > the PWM being stopped before reconfiguration, then you should
> > explicitly request that by first disabling the PWM, then reconfiguring
> > it and then reenabling it.
>=20
> You got me wrong here. See below.
>=20
> > > When I write a consumer driver, do I have a chance to know how the PW=
M,
> > > that I happen to use, behaves? To be able to get my consumer driver
> > > reliable I might need to know that however.
> >=20
> > No, there's currently no way of knowing. As such, I think the most
> > sensible thing to do at this point is to work with the API in order to
> > get the behaviour that you want.
>=20
> I want to switch from (duty_cycle, period) =3D (d1, p1) to
> (duty_cycle, period) =3D (d2, p2) without seeing (d1, p2) or (d2, p1) on
> the wire. How do I do this with Lokesh's patch applied?
>=20
> In my eyes this is something sensible to rely on. I agree that relying
> on a stop implemented by the driver is broken, but not wanting to seeing
> a (d1, p2) is sane.

I suppose it could be a sane requirement under some circumstances. In
other circumstances it may not matter. Making it a hard requirement
unconditionally would preclude the driver's usage in cases where it
doesn't matter.

Now, for many cases that als can never happen because the period is
always fixed. For example, the PWM consumer bindings specify that a
consumer should provide a fixed period in device tree. So once the
PWM has been configured that will never change, so you can only ever
be in a situation where you want to go from (d1, p) to (d2, p), so
there won't actually be a glitch.

That's certainly not true for all cases, and specifically with sysfs
you can always change the period as well as the duty-cycle.

> > Now if you're unlucky the driver won't support that and you'll notice
> > eventually. But there's also nothing you can do about that if the
> > hardware doesn't work that way. Even if the PWM framework had a way of
> > querying these types of peculiarities it wouldn't really proved much of
> > an advantage since the driver would just refuse to probe rather than
> > attempting to do this and maybe succeeding because you got lucky.
>=20
> It depends on the use case. If it's about a display that then has no
> backlight the damage is limited. If however I drive a step motor that
> rotates a laser some unexpected behaviour that only happens once in
> 100000 cases and so isn't catched during development is quite bad.

You probably wouldn't be using sysfs to control the PWM in such a case.
My understanding is that stepper motors also typically use either a
fixed duty-cycle or a fixed period. I would also think that it wouldn't
matter if you stopped a PWM, reconfigured it and then started it again
for that particular application.

So I understand that there can be situations where this kind of glitch
isn't optimal, but I think we also need to be pragmatic and see what the
real use-cases are. I doubt that anyone trying to control a potentially
lethal laser would be using some standard PWM IP and run Linux to
control it. There are just too many things that could go wrong
(scheduling interfering, kernel crashing, ...) for that to be a good
idea.

> > > > > > I know this is perhaps cheating a little, or turning a blind ey=
e, but I
> > > > > > don't know what the alternative would be. Do we want to tell pe=
ople that
> > > > > > a given PWM controller can't be used if it doesn't work accordi=
ng to our
> > > > > > expectations? That's hard to argue if that controller works jus=
t fine
> > > > > > for all known use-cases.
> > > > >=20
> > > > > I'd like have some official policy here which of the alternatives=
 is the
> > > > > preferred cheat.
> > > > >=20
> > > > > The situation here is that period and duty_cycle cannot be updated
> > > > > atomically. So the two options are:
> > > > >=20
> > > > >  - stop shortly
> > > > >  - update with hardware running and maybe emit a broken period
> > > >=20
> > > > I think we can already support both of those with the existing API.=
 If
> > > > a consumer wants to stop the PWM while reconfiguring, they should be
> > > > able to do pwm_enable(), pwm_config(), pwm_enable() (or the atomic
> > > > equivalent) and for the second case they can just do pwm_config() (=
or
> > > > the atomic equivalent).
> > >=20
> > > Yes, the consumer can force the stop and update. But assume I'm "only=
" a
> > > consumer driver author and I want: atomic update and if this is not
> > > possible I prefer "stop-to-update" over "on-the-fly-and-maybe-faulty".
> > > So I cannot benefit from a good driver/hardware that can do atomic
> > > updates? Or I have to patch each driver that I actually use to use
> > > stop-to-update?
> >=20
> > You could do what everybody does and just assume that atomic update
> > works.
>=20
> There are people out there that are more demanding. If you have 1000000
> machines in the field and only then find out that they all fail to
> operate correctly with a certain small but positive probability and you
> have to send someone to each machine to fix that, that's bad.

Agreed. But that's not really what we're talking about here, right? This
isn't some undefined behaviour that would spontaneously trigger. We're
still talking about deterministic behaviour that's going to be the same
whether you do it once in a test lab or a million times in the field. A
PWM-controlled backlight that you adjust the brightness of in the lab is
going to work the same way as in the field. Any potential glitch would
be happening in the lab as well. It would in fact, constantly happen.

> > If it works with the particular PWM device/driver that you
> > have that may be all you care about. Obviously that may not be true
> > for a different chip.
> >=20
> > On the other hand, if you absolutely must ensure that there must never
> > be any glitches whatsoever but don't care whether the PWM goes through a
> > disable/enable sequence, then doing so explicitly is going to be your
> > best bet. From a consumer driver point of view it isn't going to matter
> > because even if we had a way of distinguishing between these
> > capabilities you'd still have to have code to deal with both.
>=20
> There is a nice upside however: You have a good chance to notice this
> problem before the 1000000 devices are shipped to production and then
> escalate the problem and let the responsible people make an informed
> choice.

I suspect that what will really happen is that somebody will just hack
the driver and remove the restriction, check that it works and ship it.

> > So the only relevant use-case here would be if you had a requirement to
> > perform on-the-fly-and-strictly-correct updates. The API doesn't give
> > those kinds of guarantees. So we would need an extension that consumers
> > can query to determine whether what they want to do will work.
> >=20
> > But like I said above, the chances that you will run into this are slim
> > because use-cases are typically known ahead of time and devices are
> > designed to be able to support them. So if you build a device that needs
> > to support these strict requirements, then you need to make sure the
> > hardware supports it, too. And when the hardware supports it, then the
> > driver should implement ->config() or ->apply() in a way that allows
> > this.
>=20
> In my bubble that sometimes fails. The hardware is done and only then
> someone notices that a certain case wasn't considered.

Of course this sometimes happens. And then it's actually great if the
API isn't all too pedantic and still allows you to adjust that backlight
brightness rather than flatout refusing to do anything, leaving you with
a bunch of devices that you have to scrap and then do a redesign.

So ultimately you end up "faking it", but if it works, it works.

For the rare cases where you can't fake it, it doesn't really matter
whether the framework refuses to do something because it knows that the
hardware isn't capable of doing it, or whether the driver will simply
try its best to do what it was asked to do and fails to deliver. You'll
notice one way or another and then you need to go back to the drawing
board and redo the design.

> > > > Some hardware may actually require the PWM to be disabled before
> > > > reconfiguring, so they won't be able to strictly adhere to the seco=
nd
> > > > use-case.
> > > >=20
> > > > But as discussed above, I don't want to strive for a lowest common
> > > > denominator that would preclude some more specific use-cases from
> > > > working if the hardware supports it.
> > > >=20
> > > > So I think we should aim for drivers to implement the semantics as
> > > > closely as possible. If the hardware doesn't support some of these
> > > > requirements strictly while a particular use-case depends on that, =
then
> > > > that just means that the hardware isn't compatible with that use-ca=
se.
> > > > Chances are that the system just isn't going to be designed to supp=
ort
> > > > that use-case in the first place if the hardware can't do it.
> > > >=20
> > > > The sysfs interface is a bit of a special case here because it isn't
> > > > possible to know what use-cases people are going to come up with.
> > >=20
> > > In my eyes the sysfs interface isn't special here. You also don't know
> > > what the OMAP PWM hardware is used for.
> >=20
> > But platform designers will know what their device will be used for.
>=20
> Right. But if you rely on the people chosing the components for the
> platform to notice that the SoC's PWM has a glitch that is bad for the
> use case I think that's naive.

See above. If the glitch is bad enough to make it unusable you're going
to notice and you have to redesign, whether the PWM framework rejects a
configuration or not.

My point is that if the glitch is minor enough not to be noticed, the
PWM framework not getting in the way may make you (and whoever's got
their money in this) very happy.

> > > > It's most likely that they'll try something and if it doesn't work
> > > > they can see if a driver patch can improve things.
> > >=20
> > > So either the group who prefers "stop-to-update" or the group who
> > > prefers "on-the-fly-and-maybe-faulty" has to carry a system specific
> > > driver patch?
> >=20
> > No, the group that prefers "stop-to-update" should make that explicit
> > and write a consumer driver that first disables, then reconfigured and
> > then reenables the PWM.
>=20
> Both groups prefer atomic updates, and just prefer different cluches if
> atomic isn't possible. So doing an explicit stop is bad. Also I'd expect
> the timing of a driver doing the stop is better than when the consumer
> explicitly stops.

Yes, perhaps. It obviously depends a lot on what exactly the time is
that we're talking about here. If we're talking about a single pulse
every second, whether the driver stops and restarts or whether the
consumer does is probably negligible.

But again, I think if we really run into cases where the consumer knows
exactly which behaviour it wants, then I think we need to extend the API
to enable it to transport such notions.

We currently can't, and assumptions baked into the API are bound to be
the wrong ones every now and then.

> > If they don't *need* to update the PWM on the fly, then performing two
> > additional steps that would be happening anyway won't matter, right?
>=20
> I don't agree here. Moreover the consumer might be preempted between
> stop and reconfiguration. (And you don't want to disable preemption over
> a pwm-API calls as they might take quite some time assuming they block
> until periods are completed.)

I hate to break it to you, but if timing is really that critical, you're
probably better off not using Linux.

> > > > One possible extension that I can imagine would be to introduce some
> > > > sort of capability structure that drivers can fill in to describe t=
he
> > > > behaviour of the hardware. Drivers like pwm-omap-dmtimer, for examp=
le,
> > > > could describe that they are able to change the period and/or duty =
cycle
> > > > while the PWM is on. There could be another capability bit that says
> > > > that the current period will finish before new settings are applied=
=2E Yet
> > > > another capability could describe that duty-cycle and period can be
> > > > applied atomically. Consumers could then check those capabilities t=
o see
> > > > if they match their requirements.
> > > >=20
> > > > But then again, I think that would just make things overly complica=
ted.
> > > > None of the existing consumers need that, so it doesn't seem like t=
here
> > > > is much demand for that feature. In practice I suspect most consume=
rs
> > > > work fine despite potentially small deviations in how the PWM behav=
es.
> > >=20
> > > I think the status quo is what I asked about above: People use sysfs =
and
> > > if the PWM behaves different than needed, the driver is patched and m=
ost
> > > of the time not mainlined. If your focus is to support a certain
> > > industrial system with a defined use case, this is fine. If however y=
ou
> > > target for an universal framework that works for any combination of
> > > consumer + lowlevel driver without patching (that at least is able to
> > > diagnose: This PWM cannot provide what my consumer needs), this is ba=
d.
> >=20
> > Again, my response to this is: how is this going to be beneficial? In
> > practice the way that this would work is that the consumer driver would
> > fail if presented with a PWM that doesn't meet the strict requirements.
> > Now if the requirements really are that strict, then that sounds like a
> > good idea.
> >=20
> > But one issue I foresee with this is that we'll end up giving consumers
> > too much of a toolkit to restrict things. What if the consumer driver
> > author assumes wrongly that a given set of requirements exists?
>=20
> If you want to catch usage errors you're doomed anyhow.
>=20
> > What if for some combination of hardware that doesn't strictly conform
> > to those requirements it might still work?
>=20
> Then this is a bug that can be fixed. And it's a bug that is not in the
> PWM framework's area, so we even don't really have to care.

It's still the responsibility of the PWM framework to provide the knobs
that make sense in terms of what the hardware capabilities are.

> > Sometimes you may not notice the difference, at other times there may
> > be some impact like a visual glitch or so, but that may be something
> > that users are willing to accept rather than not have support at all.
>=20
> If laxer requirements are ok, they shouldn't request strict ones.

Well yeah. That's exactly why I'm pushing back on this. So far I haven't
yet seen a case where there actually were any such strict requirements.

> > > Also this means that whenever a system designer changes something on
> > > their machine (kernel update, different hardware, an new usecase for a
> > > PWM) they might have to reverify if the given PWM driver behaves as
> > > needed.
> >=20
> > I don't expect this type of change to happen very often.
>=20
> Yeah, I also expect that most things don't break on such a change. But
> Lokesh's patch is an example that justifies to be vigilant because the
> implemented change in behaviour is a good one for Lokesh but might break
> things for someone else. And I don't expect that the common test
> coverage to be that good to catch the glitch during test.

That's certainly true, but so far nobody's complained about this patch
breaking their use-case, so I'm going to assume for now that it's
harmless. If that changes at some point we need to revisit this of
course.

However, it's no use sitting on patches waiting for somebody to report a
regression, otherwise we could never make changes to a driver. Does the
absence of a regression report mean that there is no regression, or that
the regression just hasn't been noticed yet?

> > There's always going to be some type of fine-tuning before a driver's
> > behaviour is completely stabilized. And then there could still always
> > be other factors impacting behaviour that aren't even related to the
> > PWM framework.
>=20
> I think I don't get what you intend to say here. I understand "As
> updating the kernel might make a PLL unstable, changing behaviour for
> the PWM is fine."

What I'm trying to say is that it's normal for a driver to go through
these kinds of changes. It used to work for some use-cases, now it's
being extended to work for one more. The behaviour is now slightly
different, but hopefully it won't impact existing use-cases.

That's in contrast to saying that we can never change existing drivers
because it may cause existing use-cases to fail.

Furthermore there are so many moving parts in Linux that upgrading to a
new kernel always requires you to revalidate functionality.

> > I suspect that most people will have an array of tests to validate that
> > everything still works after a kernel update. Obviously we don't want a
> > new kernel to behave completely differently, but we're not talking about
> > that here. This is merely dropping a needless disable/enable from a
> > configuration. If somebody was relying on this happening they were wrong
> > to rely on it to begin with because the API does not guarantee it.
> >=20
> > > My suggestion for now is to start documenting how the drivers behave
> > > expanding how limitations are documented in some drivers. So maybe
> > > change from "Limitations" to "Implementation and Hardware Details"?
> >=20
> > Yes, collecting such information is always a good idea.
>=20
> So Lokesh's patch should at least be amended to add something like
>=20
>  * Limitations:
>  * - When changing both duty cycle and period, we cannot prevent in
>  *   software that the output might produce a period with mixed
>  *   settings (new period length and old duty cycle) without stopping
>  *   the hardware.
>=20
> at the top of the driver.

Something to that effect already exists in the driver.

Thierry

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6FCaAACgkQ3SOs138+
s6Hs9A//Uec27DZLWlC5SsaL+l31lqIKEJgqph4BgNj1IOAqvREFUZr3SsHcJUiU
Uoa3+EklPRiYBr/0DVL86AsvddHt32G8QkKswzB07I8EwkfxqvPewCO9HGa5Yxao
xE5tqtwtjC8pRb9e99YWahemXbnEw+E2BNULrrz9B/VIY+mS9dMWiOH6DfEDCTxl
EgUlYuZPF+iZ9HI3ario+dwjETrzK6S2c3IPvgvhvvWUaOUuDO3JDvJsLLWdu9zf
yB4j2q+BlnCMNs1SDjEkL05TVuF9m0KmXJ+j405Yk5Trrw1/+F2uvSybKzVBAx/T
WHWuXMZeg2zO5Ozrm97u+KnZUz/eV4cANbec92PtoFiNn4hy5Om9luMasgTT3YFR
6O3BeiAGIaLOMel/0FCqulpNTcNzJcKJfecX+V3Rtak/qpLbO3QQsxlw9F5ncp/7
By5nU3qUoFDkPD7S/XrKCl4PBqXK7Km4PO9pa5xEFviuKFYQdUCl9NKvp2nlLVmL
eWowT41dKD5JRJVGvY7QQHC5BuStd/rBWIqpJYr00IiB0N1aYvAhqkuOxP6rejYe
W0BZAjJ55WJSgNuCt22BFul/kvYWCxVNx1ItcXP2fd5ZBBdadOPIYyGffbbOs5db
SpOpkQ/vA5CrubI/uWWzZ+fvPfuKrJ1H32RRb6Yb4qanr1QYWWw=
=s2SI
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
