Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A584425F451
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Sep 2020 09:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgIGHuc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Sep 2020 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgIGHuY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Sep 2020 03:50:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1AAC061573
        for <linux-pwm@vger.kernel.org>; Mon,  7 Sep 2020 00:50:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c15so14661175wrs.11
        for <linux-pwm@vger.kernel.org>; Mon, 07 Sep 2020 00:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lgdO+wcLjjr5/DOIRw2FqQVZyOMD3aT5rG4YxEdLkHI=;
        b=GkPf9CMa12TsOMNNJBhObX69nm4V7Y0Xa2p/7XNbxitfct8Q1DryNblIAOzMbOxw6Y
         jcADz/kmPW8+B5VhR/JqxzVB1RSEADWmflOJPo4Tccb7Tmo5ZpoXPvUNtijUtv9TPuD/
         +vMwTwyBQWCEbnbF69nTs4adshQcK3+J52FkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lgdO+wcLjjr5/DOIRw2FqQVZyOMD3aT5rG4YxEdLkHI=;
        b=ElDLTmfKtG4+nF9tpbh5I3A8KHuM42GUrvvbxj2kyzqYd5qMDq36+WL4cvzn1Tdl5g
         Q9trm2FOwG8ZQYGZZN3LO5FwmvG8GbXuqQf8+y44Ird/LPdxbpzn+buX5VoQbmMNGfqU
         L/7LgeGRks3MhQpGydY4pdSINwLTu2bqzQTTPimWp+HM8JQH6pL0emUqIsu2vfpqLhn+
         3t+vX8gBin1abGPscNeuYL0W8jqJdvzHe7ryoEzq/I3Ir/iQegxpEZ6sdfOaRWYIlhyC
         3CcLQuAAHqKyz7ae+uPNZf8un59g1RblgUIk0t8INkyKkerhiO22QWkJsZR9dJP3wqft
         0ywg==
X-Gm-Message-State: AOAM532Bnll5ePR3E+onoIPAWWNyLli+uyAPbKH4nQLVPD+hgkvJsi03
        pv2x1JQR3GZn3fMF6Z37R+qN3w==
X-Google-Smtp-Source: ABdhPJz2hCEhRCwXanS9ojpHGz4IM7r4firNCEytShrviFkem7VHOQUejqamyg5Ug83QblsoT0n85Q==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr20057301wrt.70.1599465021254;
        Mon, 07 Sep 2020 00:50:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 70sm27928097wme.15.2020.09.07.00.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:50:20 -0700 (PDT)
Date:   Mon, 7 Sep 2020 09:50:18 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Alexandru Stan <amstan@chromium.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during
 interpolation
Message-ID: <20200907075018.GM2352366@phenom.ffwll.local>
Mail-Followup-To: Daniel Thompson <daniel.thompson@linaro.org>,
        Alexandru Stan <amstan@chromium.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
 <20200904113822.xoyt4w5x7vwvh7cr@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904113822.xoyt4w5x7vwvh7cr@holly.lan>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 04, 2020 at 12:38:22PM +0100, Daniel Thompson wrote:
> On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> > Some displays need the low end of the curve cropped in order to make
> > them happy. In that case we still want to have the 0% point, even though
> > anything between 0% and 5%(example) would be skipped.
> 
> For backlights it is not defined that 0 means off and, to be honest, 0
> means off is actually rather weird for anything except transflexive
> or front lit reflective displays[1]. There is a problem on several
> systems that when the backlight slider is reduced to zero you can't
> see the screen properly to turn it back up. This patch looks like it
> would make that problem worse by hurting systems with will written
> device trees.
> 
> There is some nasty legacy here: some backlight displays that are off
> at zero and that sucks because userspace doesn't know whether zero is
> off or lowest possible setting.
> 
> Nevertheless perhaps a better way to handle this case is for 0 to map to
> 5% power and for the userspace to turn the backlight on/off as final
> step in an animated backlight fade out (and one again for a fade in).

Afaik chromeos encodes "0 means off" somewhere in there stack. We've
gotten similar patches for the i915 backlight driver when we started
obeying the panel's lower limit in our pwm backlight driver thing that's
sometimes used instead of acpi.

There's also the problem that with fancy panels with protocol (dsi, edp,
...) shutting of the backlight completely out of the proper power sequence
hangs the panel (for some panels at least), so providing a backlight off
that doesn't go through the drm modeset sequence isn't always possible.

It's a bit a mess indeed :-/
-Daniel

> 
> 
> Daniel.
> 
> > 
> > Signed-off-by: Alexandru Stan <amstan@chromium.org>
> > ---
> > 
> >  drivers/video/backlight/pwm_bl.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > index 5193a72305a2..b24711ddf504 100644
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
> >  			/* Fill in the last point, since no line starts here. */
> >  			table[x2] = y2;
> >  
> > +			/*
> > +			 * If we don't start at 0 yet we're increasing, assume
> > +			 * the dts wanted to crop the low end of the range, so
> > +			 * insert a 0 to provide a display off mode.
> > +			 */
> > +			if (table[0] > 0 && table[0] < table[num_levels - 1])
> > +				table[0] = 0;
> > +
> >  			/*
> >  			 * As we use interpolation lets remove current
> >  			 * brightness levels table and replace for the
> > -- 
> > 2.27.0
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
