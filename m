Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F411619B5AE
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Apr 2020 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbgDASj0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Apr 2020 14:39:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55850 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDASj0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Apr 2020 14:39:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id r16so807159wmg.5;
        Wed, 01 Apr 2020 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0NXw4aGj0V8gMorYxhrv+9nn6LYwz2TkaA+ZgOaVdd0=;
        b=CaqP/E6LWMkL5FtmSQ4U1LSrzJkSof/BU8AYT3KRzsoHauarQi5NHaQD42efOJiDS4
         +UKBuI8Po55Zcm+5tz0y3nWqj4h2Y4BL88CsMWpA8yrMNMCgNbm/eRiXGY9TffqcwF0c
         Sbst0w083oMzpUtCm/DO7ANaAfNERClAGP5xBp+doAEHn23k3bMXR9HpAY/UDGzaqNSN
         lKFf/PbxUGBudh97YhikA3aE09fibbj4hxtFydZXg0fwDO50MrNEiKFpucvRJrvv9ryc
         eiGaoqKUF4AsrcCaXvhUryz5h73cdmwgc8nSgmgh1xujmuqf4BiuD79YH4vkV506VBol
         zZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0NXw4aGj0V8gMorYxhrv+9nn6LYwz2TkaA+ZgOaVdd0=;
        b=F49534Au5cQ7H79lcXBYmhcaTDltqVmS4L3RH9mkHil2/MhtjQxI3mzagskte4OizD
         9qFIeeqN0RatCL2HfoJsuUpxH7UEMah6nlMSN4Emie517d2IAzRVo1YWBRT8uwIlhgmJ
         rTyHYz7rylJk3E1fvwIfu0tgMNPkRIIbE7YnhDhtZHOZ/5TL1EanV/8CEsY30wFBL0uM
         Op2yhTrWXHq8jH7bhEmqb/mfXhlfCwDi9iGGAe9Hkj0zM0qrHXP//vKDAIX5MIx0S/Bv
         Fig4AN9xU2KTpRAvWiBIUUbQr9MzCXB5ceh+qeP0irlZQ+oSTprQXCPylNcbNwOJc80H
         TYIg==
X-Gm-Message-State: AGi0Pub8+7vmdSOTddfkaF3hWGuw6gZu0JN7NkfVWS5uywBJUGLJ5VjK
        22IeWnJOaRZgdEsICatHwFM=
X-Google-Smtp-Source: APiQypI/IwyM5QjA0R/2v2iCOyFE3LEgKgnlrcduAwYMVH0XNHMTNih52a72POtS6CZcD/BEbaN7Aw==
X-Received: by 2002:a05:600c:21d4:: with SMTP id x20mr5645750wmj.77.1585766361844;
        Wed, 01 Apr 2020 11:39:21 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id n7sm3762011wmf.4.2020.04.01.11.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 11:39:20 -0700 (PDT)
Date:   Wed, 1 Apr 2020 20:39:19 +0200
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
Message-ID: <20200401183919.GC2978178@ulmo>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
 <20200330191654.waoocllctanh5nk5@pengutronix.de>
 <20200331204559.GB2954599@ulmo>
 <20200401082227.sxtarbttsmmhs2of@pengutronix.de>
 <c1785cf8-4231-feb5-9a54-2374df85c33b@ti.com>
 <20200401114732.cxy3fsluzag7pxff@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Uq4LBwYP4y1W6pO"
Content-Disposition: inline
In-Reply-To: <20200401114732.cxy3fsluzag7pxff@pengutronix.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 01:47:32PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Apr 01, 2020 at 03:52:21PM +0530, Lokesh Vutla wrote:
> > Hi Uwe,
> >=20
> > On 01/04/20 1:52 PM, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello Thierry,
> > >=20
> > > On Tue, Mar 31, 2020 at 10:45:59PM +0200, Thierry Reding wrote:
> > >> On Mon, Mar 30, 2020 at 09:16:54PM +0200, Uwe Kleine-K=C3=B6nig wrot=
e:
> > >>> On Mon, Mar 30, 2020 at 04:14:36PM +0200, Thierry Reding wrote:
> > >>>> On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-K=C3=B6nig wr=
ote:
> > >>>>> On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
> > >>>>>> Only the Timer control register(TCLR) cannot be updated when the=
 timer
> > >>>>>> is running. Registers like Counter register(TCRR), loader regist=
er(TLDR),
> > >>>>>> match register(TMAR) can be updated when the counter is running.=
 Since
> > >>>>>> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
> > >>>>>> timer for period/duty_cycle update.
> > >>>>>
> > >>>>> I'm not sure what is sensible here. Stopping the PWM for a short =
period
> > >>>>> is bad, but maybe emitting a wrong period isn't better. You can h=
owever
> > >>>>> optimise it if only one of period or duty_cycle changes.
> > >>>>>
> > >>>>> @Thierry, what is your position here? I tend to say a short stop =
is
> > >>>>> preferable.
> > >>>>
> > >>>> It's not clear to me from the above description how exactly the de=
vice
> > >>>> behaves, but I suspect that it may latch the values in those regis=
ters
> > >>>> and only update the actual signal output once a period has finishe=
d. I
> > >>>> know of a couple of other devices that do that, so it wouldn't be
> > >>>> surprising.
> > >>>>
> > >>>> Even if that was not the case, I think this is just the kind of th=
ing
> > >>>> that we have to live with. Sometimes it just isn't possible to hav=
e all
> > >>>> supported devices adhere strictly to an API. So I think the best w=
e can
> > >>>> do is have an API that loosely defines what's supposed to happen a=
nd
> > >>>> make a best effort to implement those semantics. If a device devia=
tes
> > >>>> slightly from those expectations, we can always cross fingers and =
hope
> > >>>> that things still work. And it looks like they are.
> > >>>>
> > >>>> So I think if Lokesh and Tony agree that this is the right thing t=
o do
> > >>>> and have verified that things still work after this, that's about =
as
> > >>>> good as it's going to get.
> > >>>
> > >>> I'd say this isn't for the platform people to decide. My position h=
ere
> > >>> is that the PWM drivers should behave as uniform as possible to min=
imize
> > >>> surprises for consumers. And so it's a "PWM decision" that is to be=
 made
> > >>> here, not an "omap decision".
> > >>
> > >> I think there's a fine line to be walked here. I agree that we should
> > >> aim to have as much consistency between drivers as possible. At the =
same
> > >> time I think we need to be pragmatic. As Lokesh said, the particular=
 use
> > >> case here requires this type of on-the-fly adjustment of the PWM per=
iod
> > >> without stopping and restarting the PWM. It doesn't work otherwise. =
So
> > >> th alternative that you're proposing is to say that we don't support
> > >> that use-case, even though it works just fine given this particular
> > >> hardware. That's not really an option.
> > >=20
> > > I understand your opinion here. The situation now is that in current
> > > mainline the driver stops the hardware for reconfiguration and it
> > > doesn't fit Lokesh's use case so he changed to on-the-fly update
> > > (accepting that maybe a wrong period is emitted). What if someone rel=
ies
> > > on the old behaviour? What if in a year someone comes and claims the
> > > wrong period is bad for their usecase and changes back to
> > > stop-to-update?
> > >=20
> > > When I write a consumer driver, do I have a chance to know how the PW=
M,
> > > that I happen to use, behaves? To be able to get my consumer driver
> > > reliable I might need to know that however.
> > >=20
> > >>>> I know this is perhaps cheating a little, or turning a blind eye, =
but I
> > >>>> don't know what the alternative would be. Do we want to tell peopl=
e that
> > >>>> a given PWM controller can't be used if it doesn't work according =
to our
> > >>>> expectations? That's hard to argue if that controller works just f=
ine
> > >>>> for all known use-cases.
> > >>>
> > >>> I'd like have some official policy here which of the alternatives i=
s the
> > >>> preferred cheat.
> > >>>
> > >>> The situation here is that period and duty_cycle cannot be updated
> > >>> atomically. So the two options are:
> > >>>
> > >>>  - stop shortly
> > >>>  - update with hardware running and maybe emit a broken period
> > >>
> > >> I think we can already support both of those with the existing API. =
If
> > >> a consumer wants to stop the PWM while reconfiguring, they should be
> > >> able to do pwm_enable(), pwm_config(), pwm_enable() (or the atomic
> > >> equivalent) and for the second case they can just do pwm_config() (or
> > >> the atomic equivalent).
> > >=20
> > > Yes, the consumer can force the stop and update. But assume I'm "only=
" a
> > > consumer driver author and I want: atomic update and if this is not
> > > possible I prefer "stop-to-update" over "on-the-fly-and-maybe-faulty".
> > > So I cannot benefit from a good driver/hardware that can do atomic
> > > updates? Or I have to patch each driver that I actually use to use
> > > stop-to-update?
> > >=20
> > >> Some hardware may actually require the PWM to be disabled before
> > >> reconfiguring, so they won't be able to strictly adhere to the second
> > >> use-case.
> > >>
> > >> But as discussed above, I don't want to strive for a lowest common
> > >> denominator that would preclude some more specific use-cases from
> > >> working if the hardware supports it.
> > >>
> > >> So I think we should aim for drivers to implement the semantics as
> > >> closely as possible. If the hardware doesn't support some of these
> > >> requirements strictly while a particular use-case depends on that, t=
hen
> > >> that just means that the hardware isn't compatible with that use-cas=
e.
> > >> Chances are that the system just isn't going to be designed to suppo=
rt
> > >> that use-case in the first place if the hardware can't do it.
> > >>
> > >> The sysfs interface is a bit of a special case here because it isn't
> > >> possible to know what use-cases people are going to come up with.
> > >=20
> > > In my eyes the sysfs interface isn't special here. You also don't know
> > > what the OMAP PWM hardware is used for.
> > >=20
> > >> It's most likely that they'll try something and if it doesn't work
> > >> they can see if a driver patch can improve things.
> > >=20
> > > So either the group who prefers "stop-to-update" or the group who
> > > prefers "on-the-fly-and-maybe-faulty" has to carry a system specific
> > > driver patch?
> > >=20
> > >> One possible extension that I can imagine would be to introduce some
> > >> sort of capability structure that drivers can fill in to describe the
> > >> behaviour of the hardware. Drivers like pwm-omap-dmtimer, for exampl=
e,
> > >> could describe that they are able to change the period and/or duty c=
ycle
> > >> while the PWM is on. There could be another capability bit that says
> > >> that the current period will finish before new settings are applied.=
 Yet
> > >> another capability could describe that duty-cycle and period can be
> > >> applied atomically. Consumers could then check those capabilities to=
 see
> > >> if they match their requirements.
> > >>
> > >> But then again, I think that would just make things overly complicat=
ed.
> > >> None of the existing consumers need that, so it doesn't seem like th=
ere
> > >> is much demand for that feature. In practice I suspect most consumers
> > >> work fine despite potentially small deviations in how the PWM behave=
s.
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
> > > Also this means that whenever a system designer changes something on
> > > their machine (kernel update, different hardware, an new usecase for a
> > > PWM) they might have to reverify if the given PWM driver behaves as
> > > needed.
> > >=20
> > > My suggestion for now is to start documenting how the drivers behave
> > > expanding how limitations are documented in some drivers. So maybe
> > > change from "Limitations" to "Implementation and Hardware Details"?
> >=20
> > Does it help if a new DT property is introduced across PWM subsystem,
> > representing dynamic period/duty-cycle updates. Based on this property =
driver
> > can handle the updates. If the property is not present existing behavio=
ur can be
> > restored. This way based on the use-case things can be changed and need=
 not
> > patch the driver :). Does this sound good or you have other thoughts?
>=20
> That's something that I'd rather see in the pwm API. (Either by a rule
> that drivers should prefer one or the other, or by making it
> configurable.) IMHO this property doesn't belong into the hardware
> description as it is a software property.
>=20
> That's not constructive though as I don't have an idea how to map this
> into the API.

We can already enforce disable/config/enable with the existing API. The
only think that we can't enforce is that a configuration will always be
applied atomically or without disabling and reenabling the PWM.

One possible solution would be to extend struct pwm_state with a set of
flags that can be set. For that PTP kind of applications, consumers
could set some pwm_state.strict (or whatever) flag and then a driver
could fail ->apply() if it doesn't support changing the period/duty-
cycle atomically and without disabling the PWM first. Or it could be
more fine-grained, like:

	state.on_the_fly =3D true;
	state.consistent =3D true;

To specify that the PWM needs to be changed on the fly (i.e. without
disabling and reenabling) and duty-cycle and period must be consistent
(i.e. be applied to the signal at the same time).

Some driver may be able to only respect state.on_the_fly =3D=3D true but not
state.consistent =3D=3D true.

But then again, I don't think we'll see those cases in practice, since
no hardware designer is going to make a board for a PTP use-case with a
PWM that doesn't support it.

That said, if somebody sees value in that and can come up with a good
series of patches and concrete use-cases to show how this would be
useful, I'd be willing to take those patches.

Thierry

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6E39QACgkQ3SOs138+
s6HF9g/9GQqSiX1cfKVWYdJdSuQY1Q42mTqYxoJgkJ3d5QFZFpUsxnNPpuxNvTET
wcpCrCYbitHSkx4JgKtxFzhsvj2hqOQ9HPme+7fXILLVAgrK9X7NeppUG5twuM8R
nPGAoKq/qXMVbeyKcdpR2wJOSvUCV8Rl5Ib3dg6maundA8NF22aLs6i/1SRSleMw
UikVEZna3mVAGRhvgn4GQaEnT47reaV7HBk5ncjvfi/kNAcIt/ybgFU7m7HylSVy
G0F9tu9DnqILLppnkB+mBuPYd568YoaS6MhhBOYBDc+MiU4H/3riktf/PvnVyg3L
nwniVmcaPvaseBX9cl+fmGrCrOwkNLCXigrzNqs2g4bmpYcoxjoIB35DTvJLKH2v
y2gz3BBiIiYKRh1lbrCF7gmdpfrQmsYSpwxqAnSpQ1ykHpDwnfCU+pGOzrJzle6u
jGT0+d4UDXeP7ZqSPVZuEjyKQMYPr0UkVpvGlAbzw9sATixKliUlOdhCw0pZ/CLU
/rOJmCJ1rsPSnQAHf7PdXToY8oAaCJrZtW9AseqktxA7wQRir7H7uu38lzCCROtI
A8vRT4YAL+JUR/haDGG2O5/GN01+wcmvALnmhx+zHFkuImJlARB7EuZ4MC36x2Xo
vagxGMOuHJaJywrmYKhfPJsivjYYngiP+wrAFmDufqp5lqDTsng=
=lRJV
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
