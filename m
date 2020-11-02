Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34902A3362
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Nov 2020 19:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgKBSx3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Nov 2020 13:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBSx2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Nov 2020 13:53:28 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1C2C0617A6
        for <linux-pwm@vger.kernel.org>; Mon,  2 Nov 2020 10:53:28 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id i19so9301084ejx.9
        for <linux-pwm@vger.kernel.org>; Mon, 02 Nov 2020 10:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlGtTyawZz1U+foaHuQJleVoISpzv2DwJ6xp8D1Hwk4=;
        b=dIaNxAccndYlWhHDapF/MDgfnKgAGECRY/zIOGm650eR7riKJDY+LJNCZbF3ThLlRr
         +jEuZq6zopeOu3FTISuAv02VhSA429Uhgs7h9o100X+Jy67bARpU0p7k6SJahy6TgPZQ
         vl8C5qfffPSjxCQ+Z0E5TUGJki8xexMTou9E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlGtTyawZz1U+foaHuQJleVoISpzv2DwJ6xp8D1Hwk4=;
        b=q1c7z/M2JQQkEZwUZCzryaMUd21rHRMaYvsLcTNkQCrMuK2+xvMaNQHX/xS9zOwWSC
         t8FhUjKa9i2ytLcUOP5tCacbKKxjBK5BDh+Gk0kwBqq0XjBXsDw9Ry5sf5cbinmPcU0X
         V+y86C1FFUpIRkFWWX3KvCpemnaeaxwMBhmFAz3c7Djy2sdJvAcDDcQJvq0PmZrjM7YL
         f6+ps+BxVXhBzMoaSdFuFou4zYgJDJldp4UxCohtjTGKPJibVQs5DyHlAf5tFnA4P6+U
         jMh5UADPbxXf2LMllfF0U651VVSnmYE+ax3iJmM14AJK5yWyfdVE4/XxuPVDzIYtUHqd
         NQ3Q==
X-Gm-Message-State: AOAM533/IaHyZSgmvFtUXLSu7/GiSPpIJWa+AY1cyPO9sQAn0CRAp32I
        naFh0SxIC2xAt2bTd+q64FXVkzi7IR2tmA==
X-Google-Smtp-Source: ABdhPJzJzLmV7Z89k2bGzcAwjspNHP0l37puVhvzu0WTq8NARB9kgrIMemE4wVNC5mFb0ybWoeQVWg==
X-Received: by 2002:a17:907:2712:: with SMTP id w18mr7466107ejk.130.1604343206599;
        Mon, 02 Nov 2020 10:53:26 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id s3sm1643532ejv.97.2020.11.02.10.53.25
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 10:53:25 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id o18so15445030edq.4
        for <linux-pwm@vger.kernel.org>; Mon, 02 Nov 2020 10:53:25 -0800 (PST)
X-Received: by 2002:a05:6402:a57:: with SMTP id bt23mr6977135edb.62.1604343204920;
 Mon, 02 Nov 2020 10:53:24 -0800 (PST)
MIME-Version: 1.0
References: <20201022050445.930403-1-amstan@chromium.org> <20201021220404.v3.3.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
 <20201028151210.7e765hbq2k7i3url@holly.lan>
In-Reply-To: <20201028151210.7e765hbq2k7i3url@holly.lan>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Mon, 2 Nov 2020 10:52:49 -0800
X-Gmail-Original-Message-ID: <CAHNYxRy4hg4rZsc-xi3MzK+RapMq76+=hGj0_E-aGcFUPB1wMA@mail.gmail.com>
Message-ID: <CAHNYxRy4hg4rZsc-xi3MzK+RapMq76+=hGj0_E-aGcFUPB1wMA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] backlight: pwm_bl: Fix interpolation
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 28, 2020 at 8:12 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Oct 21, 2020 at 10:04:45PM -0700, Alexandru Stan wrote:
> > The previous behavior was a little unexpected, its properties/problems:
> > 1. It was designed to generate strictly increasing values (no repeats)
> > 2. It had quantization errors when calculating step size. Resulting in
> > unexpected jumps near the end of some segments.
> >
> > Example settings:
> >       brightness-levels = <0 1 2 4 8 16 32 64 128 256>;
> >       num-interpolated-steps = <16>;
> >
> > Whenever num-interpolated-steps was larger than the distance
> > between 2 consecutive brightness levels the table would get really
> > discontinuous. The slope of the interpolation would stick with
> > integers only and if it was 0 the whole line segment would get skipped.
> >
> > The distances between 1 2 4 and 8 would be 1 (property #1 fighting us),
> > and only starting with 16 it would start to interpolate properly.
> >
> > Property #1 is not enough. The goal here is more than just monotonically
> > increasing. We should still care about the shape of the curve. Repeated
> > points might be desired if we're in the part of the curve where we want
> > to go slow (aka slope near 0).
> >
> > Problem #2 is plainly a bug. Imagine if the 64 entry was 63 instead,
> > the calculated slope on the 32-63 segment will be almost half as it
> > should be.
> >
> > The most expected and simplest algorithm for interpolation is linear
> > interpolation, which would handle both problems.
> > Let's just implement that!
> >
> > Take pairs of points from the brightness-levels array and linearly
> > interpolate between them. On the X axis (what userspace sees) we'll
> > now have equally sized intervals (num-interpolated-steps sized,
> > as opposed to before where we were at the mercy of quantization).
> >
> > END
>
> INTERESTING.
>
> I guess this a copy 'n paste error from some internal log book?
> Better removed... but I won't lose sleep over it.

Sorry! Yeah, I mistakenly duplicated the "END" line in patman.

>
>
> > Signed-off-by: Alexandru Stan <amstan@chromium.org>
>
> I've waited a bit to see how strong the feelings were w.r.t. getting rid
> of the division from the table initialization. It was something I was
> aware of during an earlier review but it was below my personal nitpicking
> threshold (which could be badly calibrated... hence waiting). However
> it's all been quiet so:
>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
>
> Daniel.


Alexandru Stan (amstan)
