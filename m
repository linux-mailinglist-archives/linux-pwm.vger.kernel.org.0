Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB042165EF
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2020 07:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGGFmW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Jul 2020 01:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgGGFmV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jul 2020 01:42:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A3FC061794
        for <linux-pwm@vger.kernel.org>; Mon,  6 Jul 2020 22:42:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so934058wmm.0
        for <linux-pwm@vger.kernel.org>; Mon, 06 Jul 2020 22:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WHUZR2EXdhW5czPcHt04KOGgCe/6SbN/TGw1pfVyle4=;
        b=aTHuMDpSIuntpboIlpD3+77prmvJYYBBCxxD8NinelcUFG+j+dj3KN9GoisfRWfdS5
         8DT2xsmwMpRRwEGaZffv128mMoXufFWvGv/mGoFtuO8pHa5b2EaJRMF60gQCwpnnCuqf
         wX8vfS3h5dhWybSyzG9dP/DbtH+U1M75DY9HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WHUZR2EXdhW5czPcHt04KOGgCe/6SbN/TGw1pfVyle4=;
        b=g/7+R2PvwDUAzNGvObkK1ZpTuWl4qmKKSNMytP8IzVuZ6j6wLzx3ojrmDqtfp+z50v
         hjbZuetbCJWXxpAGqs2XMsX3ZrrD288TMTDh/kEkBMl20LId+0WpUeRMUZ8q1WW5ueuW
         0EiwjqIBbonDnJ/DoOi+vkgYIYJFQ0WcEnBIwANoIZ+Bmk9AS0Z1I1oKOqw+r8TjMDtU
         +bZiDrh+4ffsFC0W6ieIfF22UhIrtn2c5US7R+jgpALcT5lnNJD0cmzkJ7OO0XC9peuW
         GKl/E1XHSVl7cSsz9bL7yVu4SKRyK2FfcOdpL6wXYIqVT0Gt3ySdjR4A44HX1ILsS1cx
         qOWQ==
X-Gm-Message-State: AOAM5333g65SMReRokJM6BSP2Qjt1GG+11XrzzAFxgDNmuWttJh/+GcE
        sK/O24tay+X72C0owC/bCYT1JQ==
X-Google-Smtp-Source: ABdhPJxkzyQbd3f6f/x660/A1DZO543mIEmlw2oJzEFOVcvYB/zIx1BH7NEm8rYT7UByGGvzuOEFfw==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr2297120wma.73.1594100539918;
        Mon, 06 Jul 2020 22:42:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 65sm2051126wma.48.2020.07.06.22.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 22:42:19 -0700 (PDT)
Date:   Tue, 7 Jul 2020 07:42:16 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4 02/20] backlight: add backlight_is_blank()
Message-ID: <20200707054216.GE3278063@phenom.ffwll.local>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-3-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703184546.144664-3-sam@ravnborg.org>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 03, 2020 at 08:45:28PM +0200, Sam Ravnborg wrote:
> The backlight support has two properties that express the state:
> - power
> - state

Tiny nit, but please add "fb_blank" here too, commit message doesn't match
the code anymore. With that:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> 
> It is un-documented and easy to get wrong.
> Add backlight_is_blank() helper to make it simpler
> for drivers to get the check of the state correct.
> 
> A lot of drivers also includes checks for fb_blank.
> This check is redundant when the state is checked
> and thus not needed in this helper function.
> But added anyway to avoid introducing subtle bugs
> due to the creative use of fb_blank in some drivers.
> Introducing this helper will for some drivers results in
> added support for fb_blank. This will be a change in
> functionality, which will improve the backlight driver.
> 
> Rolling out this helper to all relevant backlight drivers
> will eliminate almost all accesses to fb_blank.
> 
> v4:
>   - struct backlight_device * is now const
> 
> v3:
>   - Clarified that the fb_blank support in
>     backlight_is_blank() may result in functionality
>     changes for the users (Emil)
> 
> v2:
>   - Added fb_blank condition (Daniel)
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  include/linux/backlight.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 56e4580d4f55..56e51ebab740 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -175,6 +175,25 @@ static inline void backlight_put(struct backlight_device *bd)
>  		put_device(&bd->dev);
>  }
>  
> +/**
> + * backlight_is_blank - Return true if display is expected to be blank
> + * @bd: the backlight device
> + *
> + * Display is expected to be blank if any of these is true::
> + *
> + *   1) if power in not UNBLANK
> + *   2) if fb_blank is not UNBLANK
> + *   3) if state indicate BLANK or SUSPENDED
> + *
> + * Returns true if display is expected to be blank, false otherwise.
> + */
> +static inline bool backlight_is_blank(const struct backlight_device *bd)
> +{
> +	return bd->props.power != FB_BLANK_UNBLANK ||
> +	       bd->props.fb_blank != FB_BLANK_UNBLANK ||
> +	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
> +}
> +
>  extern struct backlight_device *backlight_device_register(const char *name,
>  	struct device *dev, void *devdata, const struct backlight_ops *ops,
>  	const struct backlight_properties *props);
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
