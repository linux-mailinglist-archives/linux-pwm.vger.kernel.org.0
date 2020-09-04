Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A5325D799
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Sep 2020 13:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgIDLjK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgIDLif (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Sep 2020 07:38:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265D4C061244
        for <linux-pwm@vger.kernel.org>; Fri,  4 Sep 2020 04:38:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u18so5767041wmc.3
        for <linux-pwm@vger.kernel.org>; Fri, 04 Sep 2020 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zBTRNjzB5mPzhMVyXQWz7MNu1O+zSDEFEFHnoBhDYZc=;
        b=WtXR/0sltULRHVCaC8HhLbBR6SIHL5piDWOv3CHxtHHHPnSqQYEf25q1QTSFYE5zf7
         gdWSs8a+2WHWhbJHSIBA1GkGmShfElAMK7OVV9CUYUBgk9R6/BkndkZ+llRZRKOCjgdY
         QuYRCjx+JGzaomOmsTvuvLaLt/FWRjGb6H0U7xOWxh8TQpnhDUykaRdcZGX2lifAbDKo
         3t+uVzuMJydLR8u7eonGsIYYfPje0wKasCBg1diomCO/dcYyU5MfVzqY0uXMkdoXk2Yu
         cdoSyzhfjwQ5WxrXfjAgoTvLYoHlW8zWTZ5egE9QOdCcVOW04/EMMiJX781OkiYDi2UO
         Oahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zBTRNjzB5mPzhMVyXQWz7MNu1O+zSDEFEFHnoBhDYZc=;
        b=c9EVz5j3SFoPhj3+HjUmMP+JzznNn/9nETZinr2aB+CIXMzKdvgF0mvv/HReaoH9FX
         7a4FTck5x/46PSvtUczvRKrCm/D0wD7w4PrDA4fzblJsTa5+rB1C2ok9PIqu8HpZ13jO
         4QxB3eFMi9aC+H4nTgajXy5cEJnj1Ib4LjDY34ZKJa5HpAFNigBUmPK66ZtFP6bkhmyC
         emkjtJ+jWxuf+GZatV15mYPZmj+CFTY3geQ8cwM1MnKe9pESNu6pYynZx5AXoCahdxP8
         NisxYaJZOgKuOQyzbHv3NiGt5A2/MakAaQF0x6IQud/mRnxm4yrnPC2WwJNBZ2l5JKlC
         1xIw==
X-Gm-Message-State: AOAM533jaskVvzpzhdguYu5h4o6DusYEh9KfuX4RpP5R2kOXzUGJZKsL
        LsusEumq8yPA3J9NoXsIcd+T5A==
X-Google-Smtp-Source: ABdhPJx8d1p6vyslMOjVsOadjvrrKIpOa1vfRvm5f4PLcqxuLfSM0sJjG+WOSWjoXpgYJJW1oaxM+g==
X-Received: by 2002:a1c:1b8f:: with SMTP id b137mr7618389wmb.151.1599219505621;
        Fri, 04 Sep 2020 04:38:25 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j14sm11125993wrr.66.2020.09.04.04.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:38:24 -0700 (PDT)
Date:   Fri, 4 Sep 2020 12:38:22 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Stan <amstan@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/3] backlight: pwm_bl: Artificially add 0% during
 interpolation
Message-ID: <20200904113822.xoyt4w5x7vwvh7cr@holly.lan>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720212502.2.Iab4d2192e4cf50226e0a58d58df7d90ef92713ce@changeid>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 20, 2020 at 09:25:21PM -0700, Alexandru Stan wrote:
> Some displays need the low end of the curve cropped in order to make
> them happy. In that case we still want to have the 0% point, even though
> anything between 0% and 5%(example) would be skipped.

For backlights it is not defined that 0 means off and, to be honest, 0
means off is actually rather weird for anything except transflexive
or front lit reflective displays[1]. There is a problem on several
systems that when the backlight slider is reduced to zero you can't
see the screen properly to turn it back up. This patch looks like it
would make that problem worse by hurting systems with will written
device trees.

There is some nasty legacy here: some backlight displays that are off
at zero and that sucks because userspace doesn't know whether zero is
off or lowest possible setting.

Nevertheless perhaps a better way to handle this case is for 0 to map to
5% power and for the userspace to turn the backlight on/off as final
step in an animated backlight fade out (and one again for a fade in).


Daniel.

> 
> Signed-off-by: Alexandru Stan <amstan@chromium.org>
> ---
> 
>  drivers/video/backlight/pwm_bl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 5193a72305a2..b24711ddf504 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -349,6 +349,14 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  			/* Fill in the last point, since no line starts here. */
>  			table[x2] = y2;
>  
> +			/*
> +			 * If we don't start at 0 yet we're increasing, assume
> +			 * the dts wanted to crop the low end of the range, so
> +			 * insert a 0 to provide a display off mode.
> +			 */
> +			if (table[0] > 0 && table[0] < table[num_levels - 1])
> +				table[0] = 0;
> +
>  			/*
>  			 * As we use interpolation lets remove current
>  			 * brightness levels table and replace for the
> -- 
> 2.27.0
