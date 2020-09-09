Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25B92632A2
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Sep 2020 18:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgIIQsg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Sep 2020 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgIIQHj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Sep 2020 12:07:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96682C061233
        for <linux-pwm@vger.kernel.org>; Wed,  9 Sep 2020 07:45:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q9so2554917wmj.2
        for <linux-pwm@vger.kernel.org>; Wed, 09 Sep 2020 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5VKePPT3rsU28wXCAu1Xs2KBd1A5X4Nlem8vFp45sFs=;
        b=N+MbeIjrkaWZSL1rnQBBMQ3t8EgtJ5pPqrCari+s74htlzysCeT43xiaa6jOYcy32h
         4CDd9PSLQ49+GE9aRevle7XYa++OWOquZVftThJ4b3J3mk7MOdGIvX/YVJ4/atzSziBT
         QHOhNZJHMYRC2WOAByxQXcbJ/TxQLqB4Sr3+9q2HGHmYaySmzrk2sQUUz+Kpl7Ek4wAU
         cKekwJ1cvRmuB3pCyekrgNUPB9OXHj9eOSQD19+VXVp1lZB1x9oVUJJXVhHAbiYN+eAf
         kA4jU0llu01THgYWYLbkq9qRnuFNG/4WMZXx0YeYtEuuVct/E2BvPHB6tDgTCXe1CJoG
         BVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5VKePPT3rsU28wXCAu1Xs2KBd1A5X4Nlem8vFp45sFs=;
        b=lRgcifYpHASFGOYQzJ/As1F7VxA2/KkCEbYwZBfWJeJAyz7jv+OOn94rEioq1nV+XF
         putsJs2HdCsZaK/EUQmDbdL+SGCsYxWCq/AVxXrnyUkxd8fwXDGbxMghU1fkLXqOksWV
         LC4/1epj113hc5UJsw5XWgmoEdH9OoKc7TogPFdiFPJXcMq9MnQ5IiPP/iO5y1BtGw1f
         8qd5RoYLflqlsr9sXHJ5zTj5W1urFvgifJwmih9UlMwjCuDNGzR9pikH5rmItQwdQkpI
         uh82chA+akvXVpm2hvGCL0tq6IwZCj8CllezKfuAMdWIcaKw/zxlLpOecxLk5caGKjlL
         s20A==
X-Gm-Message-State: AOAM530ox4kyWuxK7mb8uHVdZip7zfEHEysmQBnA6B3xkvthjaie0z7e
        cBpZ4Ky9YFsF2m0rXD1TCwXPsTR81CBk/ljG
X-Google-Smtp-Source: ABdhPJxqI/pYnfEs6qSjztlLK9/QHes6XgHB85V3brQWGlC3Taa9IcIFuEaRLZOMRfZ2rAfTnQSxVA==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr3865768wmz.119.1599662741033;
        Wed, 09 Sep 2020 07:45:41 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v2sm4773397wrm.16.2020.09.09.07.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:45:39 -0700 (PDT)
Date:   Wed, 9 Sep 2020 15:45:37 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Stan <amstan@chromium.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during
 interpolation
Message-ID: <20200909144537.daq2exfihhxm6bai@holly.lan>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
 <20200904113822.xoyt4w5x7vwvh7cr@holly.lan>
 <20200907075018.GM2352366@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907075018.GM2352366@phenom.ffwll.local>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 07, 2020 at 09:50:18AM +0200, Daniel Vetter wrote:
> On Fri, Sep 04, 2020 at 12:38:22PM +0100, Daniel Thompson wrote:
> > On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> > > Some displays need the low end of the curve cropped in order to make
> > > them happy. In that case we still want to have the 0% point, even though
> > > anything between 0% and 5%(example) would be skipped.
> > 
> > For backlights it is not defined that 0 means off and, to be honest, 0
> > means off is actually rather weird for anything except transflexive
> > or front lit reflective displays[1]. There is a problem on several
> > systems that when the backlight slider is reduced to zero you can't
> > see the screen properly to turn it back up. This patch looks like it
> > would make that problem worse by hurting systems with will written
> > device trees.
> > 
> > There is some nasty legacy here: some backlight displays that are off
> > at zero and that sucks because userspace doesn't know whether zero is
> > off or lowest possible setting.
> > 
> > Nevertheless perhaps a better way to handle this case is for 0 to map to
> > 5% power and for the userspace to turn the backlight on/off as final
> > step in an animated backlight fade out (and one again for a fade in).
> 
> Afaik chromeos encodes "0 means off" somewhere in there stack. We've
> gotten similar patches for the i915 backlight driver when we started
> obeying the panel's lower limit in our pwm backlight driver thing that's
> sometimes used instead of acpi.

Out of interest... were they accepted?

I did took a quick look at intel_panel.c and didn't see anything
that appeared to be special casing zero but I thought I might double
check.


Daniel.


> There's also the problem that with fancy panels with protocol (dsi, edp,
> ...) shutting of the backlight completely out of the proper power sequence
> hangs the panel (for some panels at least), so providing a backlight off
> that doesn't go through the drm modeset sequence isn't always possible.
> 
> It's a bit a mess indeed :-/
> -Daniel
> 
> > 
> > 
> > Daniel.
> > 
> > > 
> > > Signed-off-by: Alexandru Stan <amstan@chromium.org>
> > > ---
> > > 
> > >  drivers/video/backlight/pwm_bl.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > index 5193a72305a2..b24711ddf504 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
> > >  			/* Fill in the last point, since no line starts here. */
> > >  			table[x2] = y2;
> > >  
> > > +			/*
> > > +			 * If we don't start at 0 yet we're increasing, assume
> > > +			 * the dts wanted to crop the low end of the range, so
> > > +			 * insert a 0 to provide a display off mode.
> > > +			 */
> > > +			if (table[0] > 0 && table[0] < table[num_levels - 1])
> > > +				table[0] = 0;
> > > +
> > >  			/*
> > >  			 * As we use interpolation lets remove current
> > >  			 * brightness levels table and replace for the
> > > -- 
> > > 2.27.0
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
