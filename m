Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF12956F5
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 05:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895545AbgJVDv2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Oct 2020 23:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895547AbgJVDv2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Oct 2020 23:51:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C829C0613CF
        for <linux-pwm@vger.kernel.org>; Wed, 21 Oct 2020 20:51:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h20so392529lji.9
        for <linux-pwm@vger.kernel.org>; Wed, 21 Oct 2020 20:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD2SvaRXRa5aFA9Su8qEUKHMqaQeb26WVVxFKHUZW3o=;
        b=jfgSPQOr4A8ebu6KBlDk6MVbrQROb/hEns797rAciUFVjjjM1+dq5LVdJCXy3WghwY
         9gS9spxOQBcQHGuSZ2cyV8hC/P5UUyKbnNkcbmoR9mgY4VjuMWbqcSU+8FxV0dtbmNbu
         YEhi1JNjHbsoy/LEP916piSbHkl85J5z38ud8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD2SvaRXRa5aFA9Su8qEUKHMqaQeb26WVVxFKHUZW3o=;
        b=U4XetBcAkKElstlBMtsN+nBeyTPg6nvzNFsGlPPh7FgiqbnhfA8TyvjzfgFA4qtGf9
         ot5kTWLbhcDEo2+tVsiQqW9UMScR29nbCEK1TSe8WsmGG9PkTktIXYfZMv3fOqFzS9Sh
         Pkl/7oreHdx8i6Y+XrSzWeSTmocdruAQPVoWS3QC5HPTTfYJ0f6tx8D88QmD+tHeOVD3
         zq9GGTGaNmA7TLCa9/v7eqAtpA1wceKpaTmBK1xvTgHMEQTkja61X0grcCEf91iIK+Y6
         LB+kw3Y/LP4ZtOIJlPDuoe3LPNeKCc6oYgcnVaw0lBnSLI9ziUYPb105UGXXQ9jdcmFo
         o4aA==
X-Gm-Message-State: AOAM532IoFZudgXkNA1X7+jmKaL6R3xNR5F0uSPeMIyQIimZF80URvjb
        2mPRvNVuLabucqZ9TovaLjAW34R9T53oKojIDDXOAA==
X-Google-Smtp-Source: ABdhPJzI3iojCVEEsrR4EWPLL1+OUZ0aJmGz6MfnAFQAPlQ8DvOjyxFr8weFl2uvrryY5VT3YyjqrgUwXOyKCwzJIVY=
X-Received: by 2002:a2e:8108:: with SMTP id d8mr254498ljg.96.1603338685764;
 Wed, 21 Oct 2020 20:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201013080103.410133-1-amstan@chromium.org> <20201013010056.v2.1.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
 <CAMuHMdUSWWSVQCxX-rv3MCvw59q+dscQ3bC4yysVCPyxdaEi6w@mail.gmail.com>
In-Reply-To: <CAMuHMdUSWWSVQCxX-rv3MCvw59q+dscQ3bC4yysVCPyxdaEi6w@mail.gmail.com>
From:   Alexandru Stan <amstan@chromium.org>
Date:   Wed, 21 Oct 2020 20:51:15 -0700
Message-ID: <CAGF9J3t4_Ru10=x3awb7MeueC3JGhjE4=EfTv7CfU_7tZVFFkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] backlight: pwm_bl: Fix interpolation
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 14 Oct 2020 at 23:55, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Alexandru,
>
> On Tue, Oct 13, 2020 at 1:57 PM Alexandru Stan <amstan@chromium.org> wrote:
> > Whenever num-interpolated-steps was larger than the distance
> > between 2 consecutive brightness levels the table would get really
> > discontinuous. The slope of the interpolation would stick with
> > integers only and if it was 0 the whole line segment would get skipped.
> >
> > Example settings:
> >         brightness-levels = <0 1 2 4 8 16 32 64 128 256>;
> >         num-interpolated-steps = <16>;
> >
> > The distances between 1 2 4 and 8 would be 1, and only starting with 16
> > it would start to interpolate properly.
> >
> > Let's change it so there's always interpolation happening, even if
> > there's no enough points available (read: values in the table would
> > appear more than once). This should match the expected behavior much
> > more closely.
> >
> > Signed-off-by: Alexandru Stan <amstan@chromium.org>
>
> Thanks for your patch!

Thanks for your reply!

I'm sorry I haven't replied earlier. Looks like your reply was marked as spam.
Rest be assured my spam filter has been disciplined! :D

>
> > --- a/drivers/video/backlight/pwm_bl.c
> > +++ b/drivers/video/backlight/pwm_bl.c
> > @@ -327,24 +324,25 @@ static int pwm_backlight_parse_dt(struct device *dev,
> >                         table = devm_kzalloc(dev, size, GFP_KERNEL);
> >                         if (!table)
> >                                 return -ENOMEM;
> > -
> > -                       /* Fill the interpolated table. */
> > -                       levels_count = 0;
> > -                       for (i = 0; i < data->max_brightness - 1; i++) {
> > -                               value = data->levels[i];
> > -                               n = (data->levels[i + 1] - value) / num_steps;
> > -                               if (n > 0) {
> > -                                       for (j = 0; j < num_steps; j++) {
> > -                                               table[levels_count] = value;
> > -                                               value += n;
> > -                                               levels_count++;
> > -                                       }
> > -                               } else {
> > -                                       table[levels_count] = data->levels[i];
> > -                                       levels_count++;
> > +                       /*
> > +                        * Fill the interpolated table[x] = y
> > +                        * by draw lines between each (x1, y1) to (x2, y2).
> > +                        */
> > +                       dx = num_steps;
> > +                       for (i = 0; i < num_input_levels - 1; i++) {
> > +                               x1 = i * dx;
> > +                               x2 = x1 + dx;
> > +                               y1 = data->levels[i];
> > +                               y2 = data->levels[i + 1];
> > +                               dy = (s64)y2 - y1;
> > +
> > +                               for (x = x1; x < x2; x++) {
> > +                                       table[x] = y1 +
> > +                                               div_s64(dy * ((s64)x - x1), dx);
>
> Yummy, 64-by-32 divisions.
> Shouldn't this use a rounded division?

It won't hurt. But it really doesn't make much of a difference either way.

>
> Nevertheless, I think it would be worthwhile to implement this using
> a (modified) Bresenham algorithm, avoiding multiplications and
> divisions, and possibly increasing accuracy as well.
>
> https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm

Sure, it might be a little faster to use Bresenham's line algorithm.
Looks like to implement it I would have to deal with some fixed point
math and still have to do divisions occasionally.
I don't think performance is critical here, the values get calculated
only once when the driver loads, and the algorithm's accuracy
improvements might be at most 1 LSB.

Meanwhile the formula I already implemented is almost the same as the
formulas found at
https://en.wikipedia.org/wiki/Linear_interpolation#:~:text=gives
I would like to keep it as is, as straightforward as possible.

>
> >                                 }
> >                         }
> > -                       table[levels_count] = data->levels[i];
> > +                       /* Fill in the last point, since no line starts here. */
> > +                       table[x2] = y2;
> >
> >                         /*
> >                          * As we use interpolation lets remove current
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Alexandru Stan (amstan)
