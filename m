Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D30263EEB
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Sep 2020 09:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgIJHsK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Sep 2020 03:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgIJHsE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Sep 2020 03:48:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1DCC061756
        for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2020 00:48:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so5537604wrl.12
        for <linux-pwm@vger.kernel.org>; Thu, 10 Sep 2020 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=EzwOJPxFQZYC72dKxH1QwXbLeAK6MXsJW34CXePZsDk=;
        b=NU3t/lYA4IuNCNtpekqscA2TyplAkzfP+R8MUCR3PvCAb8uJiYk1wOzzb8wwXS4UMr
         DVA4tRl1Ve9Exjbx9S/0pONj/l6Gmg8wchly5ZcfOeQgRhaHAGu83K0TF5f78u/Lc85y
         hkhIHeTu8rvomAvVXj5waA1W35Dcxm1hJK7BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=EzwOJPxFQZYC72dKxH1QwXbLeAK6MXsJW34CXePZsDk=;
        b=IiChgf0tgXYSWnvni1ZbTwplkMRGd+NRgJM2VdRLTmCcpQ5rFjDYiwiiBmyfJtpbgm
         GQyaA9G7LC+enlUvcVhXcUnDUNymyWrpT3PmyO59BOxWoTN8N5iBw8K0B3Wqhm23B6ex
         +RtMcrO+/lC8wPWLNOL5KxguiG6vQTMKyUrj44WX0XCpiyu3MI3pb+rVQtc6Xvh+Y2oa
         FOZ5djwyqd/S08fiJ/sQP64iNeSOSa88GccLAVm/+J6f/FOxVVhTySXTXBfY9OQRa0Yk
         Av+bXHX3h1yRn1qKod9d47t2x03kRhYEO7+drH79TvH5FQGfthjOA2w2LJkb0MSDXn4V
         t2qg==
X-Gm-Message-State: AOAM532T1K9KPemTEmDZX6Um9SwQTfm0FHXiE94MIUtJ9G+TVZl70ju5
        z8MXZCb2kT6c2kUmA7Ydkq2XZA==
X-Google-Smtp-Source: ABdhPJyHnNn0zGerD4FHfuyk3jfmyvmU9pJsJ0jZ9yhN7+q1Nh4texQADwMpFBCQe7+lPrgnAcEOvw==
X-Received: by 2002:a5d:4247:: with SMTP id s7mr7407060wrr.167.1599724079550;
        Thu, 10 Sep 2020 00:47:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h204sm2348153wmf.35.2020.09.10.00.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 00:47:58 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:47:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during
 interpolation
Message-ID: <20200910074756.GE438822@phenom.ffwll.local>
Mail-Followup-To: Daniel Thompson <daniel.thompson@linaro.org>,
        Alexandru Stan <amstan@chromium.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
 <20200904113822.xoyt4w5x7vwvh7cr@holly.lan>
 <20200907075018.GM2352366@phenom.ffwll.local>
 <20200909144537.daq2exfihhxm6bai@holly.lan>
 <CAKMK7uEK5afDHT9n0s+eDYA1Qztf9Xxibz_rZDzy5F6G9EOEVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEK5afDHT9n0s+eDYA1Qztf9Xxibz_rZDzy5F6G9EOEVw@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 09, 2020 at 05:03:37PM +0200, Daniel Vetter wrote:
> On Wed, Sep 9, 2020 at 4:45 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Mon, Sep 07, 2020 at 09:50:18AM +0200, Daniel Vetter wrote:
> > > On Fri, Sep 04, 2020 at 12:38:22PM +0100, Daniel Thompson wrote:
> > > > On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> > > > > Some displays need the low end of the curve cropped in order to make
> > > > > them happy. In that case we still want to have the 0% point, even though
> > > > > anything between 0% and 5%(example) would be skipped.
> > > >
> > > > For backlights it is not defined that 0 means off and, to be honest, 0
> > > > means off is actually rather weird for anything except transflexive
> > > > or front lit reflective displays[1]. There is a problem on several
> > > > systems that when the backlight slider is reduced to zero you can't
> > > > see the screen properly to turn it back up. This patch looks like it
> > > > would make that problem worse by hurting systems with will written
> > > > device trees.
> > > >
> > > > There is some nasty legacy here: some backlight displays that are off
> > > > at zero and that sucks because userspace doesn't know whether zero is
> > > > off or lowest possible setting.
> > > >
> > > > Nevertheless perhaps a better way to handle this case is for 0 to map to
> > > > 5% power and for the userspace to turn the backlight on/off as final
> > > > step in an animated backlight fade out (and one again for a fade in).
> > >
> > > Afaik chromeos encodes "0 means off" somewhere in there stack. We've
> > > gotten similar patches for the i915 backlight driver when we started
> > > obeying the panel's lower limit in our pwm backlight driver thing that's
> > > sometimes used instead of acpi.
> >
> > Out of interest... were they accepted?
> >
> > I did took a quick look at intel_panel.c and didn't see anything
> > that appeared to be special casing zero but I thought I might double
> > check.
> 
> I don't think so. Just figured I bring this up since it might explain
> why this is coming back again from an @chromium.com address.

Thanks to Alexandru pointing at the right code it's clear this got fix,
over 5 years ago:

https://source.chromium.org/chromiumos/_/chromium/chromiumos/platform2/+/6e83a6a8bb772ed8a2f939da1c7a152147c12789

	power: Write to bl_power when backlight reaches or leaves 0.
	
	Make InternalBacklight write FB_BLANK_UNBLANK to bl_power
	just before setting the internal backlight brightness to a
	nonzero value, and FB_BLANK_POWERDOWN to bl_power just
	before setting the brightness to 0.
	
	This is needed for hardware that interprets a brightness
	level of 0 as meaning "dim" rather than "off".
	
	BUG=chromium:396218
	TEST=added unit tests
	
	Change-Id: I914e333ab41db623564d5a67beac89f1a62bce9d
	Reviewed-on: https://chromium-review.googlesource.com/311010
	Commit-Ready: Dan Erat <derat@chromium.org>
	Tested-by: Dan Erat <derat@chromium.org>
	Reviewed-by: Dan Erat <derat@chromium.org>

Cheers, Daniel

> > > There's also the problem that with fancy panels with protocol (dsi, edp,
> > > ...) shutting of the backlight completely out of the proper power sequence
> > > hangs the panel (for some panels at least), so providing a backlight off
> > > that doesn't go through the drm modeset sequence isn't always possible.
> > >
> > > It's a bit a mess indeed :-/
> > > -Daniel
> > >
> > > >
> > > >
> > > > Daniel.
> > > >
> > > > >
> > > > > Signed-off-by: Alexandru Stan <amstan@chromium.org>
> > > > > ---
> > > > >
> > > > >  drivers/video/backlight/pwm_bl.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > > > index 5193a72305a2..b24711ddf504 100644
> > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > @@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
> > > > >                   /* Fill in the last point, since no line starts here. */
> > > > >                   table[x2] = y2;
> > > > >
> > > > > +                 /*
> > > > > +                  * If we don't start at 0 yet we're increasing, assume
> > > > > +                  * the dts wanted to crop the low end of the range, so
> > > > > +                  * insert a 0 to provide a display off mode.
> > > > > +                  */
> > > > > +                 if (table[0] > 0 && table[0] < table[num_levels - 1])
> > > > > +                         table[0] = 0;
> > > > > +
> > > > >                   /*
> > > > >                    * As we use interpolation lets remove current
> > > > >                    * brightness levels table and replace for the
> > > > > --
> > > > > 2.27.0
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
