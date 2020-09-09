Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375A9263130
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Sep 2020 18:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgIIQCU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Sep 2020 12:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbgIIQCP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Sep 2020 12:02:15 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF0DC06123F
        for <linux-pwm@vger.kernel.org>; Wed,  9 Sep 2020 08:03:50 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t76so2652984oif.7
        for <linux-pwm@vger.kernel.org>; Wed, 09 Sep 2020 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XqgUisCv6O6AIe2HSHhoMaBFAHa4ETHNWOlkQljBJ8A=;
        b=BRT9Vi4VBHt950UmvglmwImZSM4kL3ilDGd58qK07Eo89lRCG7hrMJ5v2fKeNK8UXZ
         mZLdMBMk12yoKK2uXeOkGlvQeQJvJZmzdNJ04oJpSZucuLlQMSslsP/qVgoNsYapeaEy
         3wpaj+nh0NeqwJlRpoCiPfrIGDoCd7GLIzy/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XqgUisCv6O6AIe2HSHhoMaBFAHa4ETHNWOlkQljBJ8A=;
        b=EmBk/88jb33zKe2gEoGZJtAimOUjxpFUjp4h20jWRasbMTsNGDvqZbVndp5uccFOsy
         LR5NE1GsgzvrgPkzZmpxlMOQncaxIYodAqEmBfIVUh5sU+RNYO+TfIdJSLyyo21TrqE7
         FJuhjFGIaQPIhs9rkGuHuZad0p+2ENgY2v+xbPq5Exftolwqwd/pf4DERLbZEIttTaHr
         EUAYLhfSEVxYk20qSFghAdUi7CIoQRK6EO75wOGUVY6YcosGdu+XrFmAu+GBRizXJOqB
         eUzke1vJEjDDC6z4SeiEwNdzhG/Sp34kSlHhgKa5eTqQIzNrieO/Kw+MKiWV/jlRcTXE
         O2SQ==
X-Gm-Message-State: AOAM530W6092oZqKCcEzw3bwpnahm6CXjIgFZ0YSmXU2uzZ1KL7J6fCK
        14SDh2gCTuy/nPd8Pv3wAPxbDDLTLOojAPSv2ITebw==
X-Google-Smtp-Source: ABdhPJzV6KFL4kNw0JMMTwGtLRSVvE2e3kcoWpzF0VGT7IKBd/vRbzuUSWeECw2RPuAZ9KHggkot6bIzZex5xMKydis=
X-Received: by 2002:aca:5106:: with SMTP id f6mr875834oib.101.1599663828682;
 Wed, 09 Sep 2020 08:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200721042522.2403410-1-amstan@chromium.org> <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
 <20200904113822.xoyt4w5x7vwvh7cr@holly.lan> <20200907075018.GM2352366@phenom.ffwll.local>
 <20200909144537.daq2exfihhxm6bai@holly.lan>
In-Reply-To: <20200909144537.daq2exfihhxm6bai@holly.lan>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 9 Sep 2020 17:03:37 +0200
Message-ID: <CAKMK7uEK5afDHT9n0s+eDYA1Qztf9Xxibz_rZDzy5F6G9EOEVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during interpolation
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Alexandru Stan <amstan@chromium.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 9, 2020 at 4:45 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Sep 07, 2020 at 09:50:18AM +0200, Daniel Vetter wrote:
> > On Fri, Sep 04, 2020 at 12:38:22PM +0100, Daniel Thompson wrote:
> > > On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> > > > Some displays need the low end of the curve cropped in order to make
> > > > them happy. In that case we still want to have the 0% point, even though
> > > > anything between 0% and 5%(example) would be skipped.
> > >
> > > For backlights it is not defined that 0 means off and, to be honest, 0
> > > means off is actually rather weird for anything except transflexive
> > > or front lit reflective displays[1]. There is a problem on several
> > > systems that when the backlight slider is reduced to zero you can't
> > > see the screen properly to turn it back up. This patch looks like it
> > > would make that problem worse by hurting systems with will written
> > > device trees.
> > >
> > > There is some nasty legacy here: some backlight displays that are off
> > > at zero and that sucks because userspace doesn't know whether zero is
> > > off or lowest possible setting.
> > >
> > > Nevertheless perhaps a better way to handle this case is for 0 to map to
> > > 5% power and for the userspace to turn the backlight on/off as final
> > > step in an animated backlight fade out (and one again for a fade in).
> >
> > Afaik chromeos encodes "0 means off" somewhere in there stack. We've
> > gotten similar patches for the i915 backlight driver when we started
> > obeying the panel's lower limit in our pwm backlight driver thing that's
> > sometimes used instead of acpi.
>
> Out of interest... were they accepted?
>
> I did took a quick look at intel_panel.c and didn't see anything
> that appeared to be special casing zero but I thought I might double
> check.

I don't think so. Just figured I bring this up since it might explain
why this is coming back again from an @chromium.com address.
-Daniel

>
>
> Daniel.
>
>
> > There's also the problem that with fancy panels with protocol (dsi, edp,
> > ...) shutting of the backlight completely out of the proper power sequence
> > hangs the panel (for some panels at least), so providing a backlight off
> > that doesn't go through the drm modeset sequence isn't always possible.
> >
> > It's a bit a mess indeed :-/
> > -Daniel
> >
> > >
> > >
> > > Daniel.
> > >
> > > >
> > > > Signed-off-by: Alexandru Stan <amstan@chromium.org>
> > > > ---
> > > >
> > > >  drivers/video/backlight/pwm_bl.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > > index 5193a72305a2..b24711ddf504 100644
> > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > @@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
> > > >                   /* Fill in the last point, since no line starts here. */
> > > >                   table[x2] = y2;
> > > >
> > > > +                 /*
> > > > +                  * If we don't start at 0 yet we're increasing, assume
> > > > +                  * the dts wanted to crop the low end of the range, so
> > > > +                  * insert a 0 to provide a display off mode.
> > > > +                  */
> > > > +                 if (table[0] > 0 && table[0] < table[num_levels - 1])
> > > > +                         table[0] = 0;
> > > > +
> > > >                   /*
> > > >                    * As we use interpolation lets remove current
> > > >                    * brightness levels table and replace for the
> > > > --
> > > > 2.27.0
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
