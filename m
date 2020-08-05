Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B28423D378
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Aug 2020 23:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHEVLk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Aug 2020 17:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVLj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Aug 2020 17:11:39 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A49C061575
        for <linux-pwm@vger.kernel.org>; Wed,  5 Aug 2020 14:11:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so25813700ljc.3
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2020 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2PZXILdefiTwwzfO5OUUQBgzK17xy7UQ4vY/f0A1uM=;
        b=aPqJee4+/II1pDeHm6YJT9N8szJtyfH8/u0a/mb/rUh0XKwrO9/lI6mAKg/YUjZsap
         p0B7nL/zuMyT3EsRGWbvq29/0Lc9irQLp5boKwUO0dgr7wICe4bQ/VVNo2zfxFQFtKUF
         aTAuAP1cEHDioLUgDXQmFNnV10RJlUC2CPrZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2PZXILdefiTwwzfO5OUUQBgzK17xy7UQ4vY/f0A1uM=;
        b=dvgwOICDC+O+Q6VtjNh89WVYoIVxDiSWX6r0HndpTZ9uNRTK87zgpXZTEBrY5GpnHm
         FEX7em1krGC455WrVPTM+Wy9Eb1qgmpjQWA8xVf0aoNt3qs4E0Mpw2VBue/WiiiVMcJI
         4+FV3XT6EYj0Px6QY2bRgIgdmZ5vcI7VSTcesudy9M+7l7J6/hcQO96+gfmcPmgWGrtb
         xVXR59Rg6g02kueNfoz/ylXj8c60XuPfi1Wptksu/0G55Krmk/HppVttGyN4zbwpGPr+
         20var0YYQuyVWRlQQMeJNFU+PfNhUvqRft1O05e9gTY0KfRNpY7+t+UtRdE+CPYzYd6z
         fTCA==
X-Gm-Message-State: AOAM531bfxCB41t4CKwjcxLxxxPCUh0RE+fYkTuXfXb1QqIlWAc8fEOU
        Lsy5aqkxTpQyhzZxd2Nku/W7B5l9tHlxRA==
X-Google-Smtp-Source: ABdhPJxq8512WZgDidqQKmM6hJz+cW15Hzqt+wjfUa8xpuul4nTBF2E3Con1haOwvmR9iAmklC2CMw==
X-Received: by 2002:a2e:8853:: with SMTP id z19mr2512472ljj.267.1596661897151;
        Wed, 05 Aug 2020 14:11:37 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id e12sm1366621ljk.74.2020.08.05.14.11.37
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 14:11:37 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id c15so7704809lfi.3
        for <linux-pwm@vger.kernel.org>; Wed, 05 Aug 2020 14:11:37 -0700 (PDT)
X-Received: by 2002:a05:6402:28f:: with SMTP id l15mr1118783edv.233.1596661486208;
 Wed, 05 Aug 2020 14:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200721042522.2403410-1-amstan@chromium.org>
In-Reply-To: <20200721042522.2403410-1-amstan@chromium.org>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Wed, 5 Aug 2020 14:04:09 -0700
X-Gmail-Original-Message-ID: <CAHNYxRzwQ2jx99M0oyNv8CDE4h051jcdAdYFjRd8mhNjB19FgA@mail.gmail.com>
Message-ID: <CAHNYxRzwQ2jx99M0oyNv8CDE4h051jcdAdYFjRd8mhNjB19FgA@mail.gmail.com>
Subject: Re: [PATCH 0/3] PWM backlight interpolation adjustments
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 20, 2020 at 9:27 PM Alexandru Stan <amstan@chromium.org> wrote:
>
> I was trying to adjust the brightness for a new chromebook:
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2291209
> Like a lot of panels, the low end needs to be cropped,
> and now that we have the interpolation stuff I wanted to make use of it
> and bake in even the curve.
>
> I found the behavior a little unintuitive and non-linear. See patch 1
> for a suggested fix for this.
>
> Unfortunatelly a few veyron dts files were relying on this
> (perhaps weird) behavior. Those devices also want a minimum brightness.
> The issue is that they also want the 0% point for turning off the
> display.
> https://github.com/torvalds/linux/commit/6233269bce47bd450196a671ab28eb1ec5eb88d9#diff-e401ae20091bbfb311a062c464f4f47fL23
>
> So the idea here is to change those dts files to only say <3 255> (patch
> 3), and add in a virtual 0% point at the bottom of the scale (patch 2).
>
> We have to do this conditionally because it seems some devices like to
> have the scale inverted:
>   % git grep "brightness-levels\s*=\s*<\s*[1-9]"|cat
>   arch/arm/boot/dts/tegra124-apalis-eval.dts:             brightness-levels = <255 231 223 207 191 159 127 0>;
>
>
> Alexandru Stan (3):
>   backlight: pwm_bl: Fix interpolation
>   backlight: pwm_bl: Artificially add 0% during interpolation
>   ARM: dts: rockchip: Remove 0 point in backlight
>
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts    |  2 +-
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts |  2 +-
>  arch/arm/boot/dts/rk3288-veyron-tiger.dts  |  2 +-
>  drivers/video/backlight/pwm_bl.c           | 78 +++++++++++-----------
>  4 files changed, 42 insertions(+), 42 deletions(-)
>
> --
> 2.27.0
>

Hello,

Friendly ping.
Let me know if you would like me to make any changes to my patches.

Thanks,
Alexandru M Stan
