Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05317962F6
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Aug 2019 16:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfHTOtf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Aug 2019 10:49:35 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42238 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfHTOte (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Aug 2019 10:49:34 -0400
Received: by mail-oi1-f193.google.com with SMTP id o6so4273191oic.9
        for <linux-pwm@vger.kernel.org>; Tue, 20 Aug 2019 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=InJwoaapV4AnIQzati3KHt1tSp1I3wIb1tislbP8+E8=;
        b=cpJh5We0ZtOLvr8NkxWDVbL/PTd9rMZFg/5Bo56jZRiJc3+qwo7P6fPEONlHoL7HJs
         IxTxyYE8HZygC+6TypSUbRHHu3S0Zy7r+sHdXM1bZUksi98BFoCHQpD6JsxbhSeGFAHy
         rgt5c3yOg6ipzlt9nXmANI/H7HKTwc1kJPEq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=InJwoaapV4AnIQzati3KHt1tSp1I3wIb1tislbP8+E8=;
        b=GnucC+HGODevM7mvUfksb6FhILhYIBUl6zddLtaomWSkvvXWhbKGc1A9oSlkEacRdE
         QvhCl9Hwyd0lbaKuM2DImEjMnmmIPI//q2IuRsVmCb+yAz0+lfTOs9uNoJIK63zUul28
         Z/srAZvmrUid0OPI9xqlvYRRg48E5ML/u0HL4WqbSMuVI9qWdeTstxYSeCuZi3Y56/R8
         PDaE4P6x+YSttUwx5h9AZ9eIF18CNRTOV2KIvFzyR2TVocNLi/jpUvjpZjGo6QjF8JBw
         7Mib5dFlyPqedweELwfnvWzt3xJd0bAcCzj4U9sUkzvAFmZ6JTHH2V/iBr29Nb6pIGgr
         2nTQ==
X-Gm-Message-State: APjAAAUHWs3YfL7/a252IyvWHU2LeaNc2MY76pfSW5Qm09q1QocXkx5r
        itU/5JIm1I7yVJcA/u42gKABhusKFTaaBdOUHFCxIg==
X-Google-Smtp-Source: APXvYqw/s9CBGCO0WFBZWSeYTJMXMw51fD6PR8ON2kv0QkiaSO5NoMNSmSSRvyDxaeFaIpJO4MeaXcjfESFWlLUWais=
X-Received: by 2002:aca:b104:: with SMTP id a4mr316560oif.14.1566312573423;
 Tue, 20 Aug 2019 07:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190709190007.91260-1-mka@chromium.org> <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de> <20190816175157.GT250418@google.com>
 <20190816194754.ldzjqy2yjonfvaat@pengutronix.de> <20190816211051.GV250418@google.com>
 <20190819054628.asw3cxp46w3rpml7@pengutronix.de> <20190819095037.h3gig3quyhnzshm7@holly.lan>
In-Reply-To: <20190819095037.h3gig3quyhnzshm7@holly.lan>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 20 Aug 2019 16:49:21 +0200
Message-ID: <CAKMK7uEJptKgoAwTO+OuN0HrBiMMG21w0QAdgD=pHBLoKLi38Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through sysfs
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 19, 2019 at 11:50 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Aug 19, 2019 at 07:46:28AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Hello Matthias,
> >
> > On Fri, Aug 16, 2019 at 02:10:51PM -0700, Matthias Kaehlcke wrote:
> > > On Fri, Aug 16, 2019 at 09:47:54PM +0200, Uwe Kleine-K=C3=B6nig wrote=
:
> > > > On Fri, Aug 16, 2019 at 10:51:57AM -0700, Matthias Kaehlcke wrote:
> > > > > Hi Uwe,
> > > > >
> > > > > On Fri, Aug 16, 2019 at 06:51:48PM +0200, Uwe Kleine-K=C3=B6nig w=
rote:
> > > > > > On Tue, Jul 09, 2019 at 12:00:05PM -0700, Matthias Kaehlcke wro=
te:
> > > > > > > Backlight brightness curves can have different shapes. The tw=
o main
> > > > > > > types are linear and non-linear curves. The human eye doesn't
> > > > > > > perceive linearly increasing/decreasing brightness as linear =
(see
> > > > > > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of L=
ED
> > > > > > > linearly to human eye"), hence many backlights use non-linear=
 (often
> > > > > > > logarithmic) brightness curves. The type of curve currently i=
s opaque
> > > > > > > to userspace, so userspace often uses more or less reliable h=
euristics
> > > > > > > (like the number of brightness levels) to decide whether to t=
reat a
> > > > > > > backlight device as linear or non-linear.
> > > > > > >
> > > > > > > Export the type of the brightness curve via the new sysfs att=
ribute
> > > > > > > 'scale'. The value of the attribute can be 'linear', 'non-lin=
ear' or
> > > > > > > 'unknown'. For devices that don't provide information about t=
he scale
> > > > > > > of their brightness curve the value of the 'scale' attribute =
is 'unknown'.
> > > > > > >
> > > > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > >
> > > > > > I wonder what kind of problem you are solving here. Can you des=
cribe
> > > > > > that in a few words?
> > > > >
> > > > > The human eye perceives brightness in a logarithmic manner. For
> > > > > backlights with a linear brightness curve brightness controls lik=
e
> > > > > sliders need to use a mapping to achieve a behavior that is perce=
ived
> > > > > as linear-ish (more details: http://www.pathwaylighting.com/produ=
cts/downloads/brochure/technical_materials_1466797044_Linear+vs+Logarithmic=
+Dimming+White+Paper.pdf)
> > > > >
> > > > > As of now userspace doesn't have information about the type of th=
e
> > > > > brightness curve, and often uses heuristics to make a guess, whic=
h may
> > > > > be right most of the time, but not always. The new attribute elim=
inates
> > > > > the need to guess.
> > > >
> > > > This is about backlights right? So the kernel provides to userspace=
 an
> > > > interval [0, x] for some x and depending on the physics of the the
> > > > backlight configuring x/2 (probably?) either means 50% measured lig=
ht or
> > > > 50% perceived light, right?
> > >
> > > correct
> > >
> > > > I wonder if it would be possible instead of giving different backli=
ght
> > > > implementations the freedom to use either linear or logarithmic (or
> > > > quadratic?) scaling and tell userspace which of the options were pi=
cked
> > > > require the drivers to provide a (say) linear scaling and then user=
space
> > > > wouldn't need to care about the exact physics.
> > >
> > > In an ideal world the backlight interface would be consistent as you
> > > suggest, however there are plenty of existing devices which use the
> > > 'other' scaling (regardless of which is chosen as the 'correct'
> > > one). Userspace still has to deal with these. And changing previously
> > > 'logarithmic' drivers to linear (or viceversa) may 'break' userspace,
> > > when it keeps using its 'old' scaling, which now isn't correct anymor=
e.
> >
> > It might be subjective, or maybe I'm just too optimistic, but I think i=
f
> > there was no policy before about the meaning of
> >
> >       echo 17 > brightness
> >
> > other than "brighter than lower values and darker than higher ones"
> > introducing (say) the scale is intended to represent a linear brightnes=
s
> > curve is ok.
> >
> > Unless userspace jumps through hoops and tries to identify the actual
> > device it is running on it is wrong on some machines anyhow and we're
> > only shifting the set of affected machines with a tighter policy (until
> > that userspace application is fixed).
>
> I believe that there are two common approaches by userspace at present:
>
> 1. Assume the scale is perceptual and we can directly map a slider
>    to the backlight value. This is common simply because most ACPI
>    backlights are perceptual and therefore when tested in a laptop
>    it works OK.
>
> 2. Assume that is max brightness is small (e.g. ACPI) then the
>    scale is perceptual and if the max brightness is large (e.g.
>    a PWM) then the scale is linear and apply a correction
>    function between the slider and the control.
>
> That historic baggage makes is diffcult to "just define a standardized
> scale"... especially given that if we selected a standardized scale we
> would probably want a perceptual scale with lots of steps (e.g. break
> the heuristic).
>
>
> > And the big upside is that in the end (i.e. when all kernel drivers and
> > userspace applications are adapted to provide/consume the "correct"
> > curve) the result is simpler.
>
> My view is that this convergence will eventually be achieved but it will
> happen through the obsolescence of the backlight sysfs interface. The
> sysfs interface has other flaws, in particular no integration with the
> DRM connector API.
>
> Thus I would expect an alternative interface to emerge, most likely as
> part of the DRM connector API. I'd expect such a new API to a
> perceptual scale and to have a fixed max brightness with enough
> steps to support animated backlight effects (IIRC 0..100 has been
> proposed in the past)
>
> In the mean time getting the existing collection of backlight drivers
> marked up as linear/logarithmic/etc will ease the introduction of that
> API because, within the kernel, we might have gathered enough knowledge
> to have some hope of correctly mapping each backlight onto a
> standardized scale.

In case people wonder why the drm connector based backlight interface
hasn't happened ages ago, some more context:

- userspace (well libbacklight) selects the right backlight, using
some priority search. Plus blacklists in drivers to make sure they're
not overriding the real backlight driver (e.g. acpi has higher
priority in libbacklight, but on modern system it's not the backlight
driver you want. If we move that into the kernel it's going to be
somewhat a mess, since defacto you never know when loading is complete
and you actually have the right backlight driver.

This isn't a problem on DT platforms, but really just for x86/acpi
platforms. But if we don't fix them, then userspace adoption of these
new interfaces will likely be too low to matter.

- second issue is that right now the kms client is supposed to handle
backlight around modeset, like fbdev does through the fb notifier.
Except for drivers which do handle the backlight across modesets, but
maybe not the right backlight. If we move the backlight interface to
drm connectors then the right thing would be for the drm driver to
handle backlight enable/disable across modesets. But to make that
work, userspace needs to stop touching it (otherwise userspace first
disables, then the kernel and then on restore the two fight and
usually black screen wins), and that's a bit a tricky uapi problem of
not breaking existing userspace.

- finally there's some userspace which assumes the lowest backlight
setting is actually off, and uses that to do fast modesets. This
doesn't work on most ACPI backlights, so I think that problem isn't
widespread.

Anyway from watching from afar, I think this clarification on what the
backlight scale means internally should at least help us somewhat in
the long term. But the long term solution itself needs someone with
way too much time I fear, so lets not hold up anything on that.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
