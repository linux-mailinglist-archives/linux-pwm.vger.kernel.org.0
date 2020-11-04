Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670282A6879
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Nov 2020 16:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbgKDPyV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 10:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731252AbgKDPyR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Nov 2020 10:54:17 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99495C061A4C
        for <linux-pwm@vger.kernel.org>; Wed,  4 Nov 2020 07:54:16 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id w1so22625898wrm.4
        for <linux-pwm@vger.kernel.org>; Wed, 04 Nov 2020 07:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cpjrvx5xa5Fub2SmSs5NxCIt1AtREI63BVQTX9fsjLc=;
        b=kmf1Z0yeNpYCwPXqysU9kiSujnzjdXKIk8+vE0x44SjNDiibKhNKdvM5DYwJvPv9BP
         uyTmaIN6g08I7LE1TSotYiRlsqez5OlMd8VdA7Wvqt1o94N7yywzGxi18DlbPu2frcbU
         UPX4K6ffl5hpw/wWewB4vegS9SjGz/YB1Sag9vLtCsmWpxdvdjJLW4LZUj09EXiUZd15
         BCZWtGxHuAJBWzgOusXVeUzhNClzoyi4/4FJDp8BdlfPbeMW9yVwD21iRSg8e0O6iycV
         QKF+XTr/zgsxmxz8jW9vwtA3usnrYac8tlSTIij782QzZwWQGrv1xkhb0om5/c81EElx
         ZmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cpjrvx5xa5Fub2SmSs5NxCIt1AtREI63BVQTX9fsjLc=;
        b=exDZZsbsYBW5NfWZshZJ5RcqG/nTNGpStgAqkISRqF5zM42ne1wGne8qkGPlvttIzz
         o6F/GqqoTeThfD55pTuIJDolHVsIOGTPh8Y1sYk+RzzdNn8ooRZJY9KwD/8MjdF5mEIv
         r/PmLfPq9OhO65SGelMI0rxfrXVksscyScdnkWoNJ0h9Sv4gwlpgb/wQLAA6sRik1F7z
         dy2Ao3S5YRi3xT7v2c0DrBf87Y7oFvM2r+HH8BkncMqOQFz7/p0L9UJlNhx4vCCvK+w0
         zArXT/u7SCuskD1k1EgCdI/2QZY9LyorXlKBee3ks55PEMZe1bsLiqN/CWgSAOWYz786
         TdlQ==
X-Gm-Message-State: AOAM533j6GBz4TtdyineG9R3rFZxwK/yd9RhxAyP8hU3f0RfuF1gN4zG
        updv9z+9TuFQZNYwTSNvqUw5Lg==
X-Google-Smtp-Source: ABdhPJwrgUZlnu1TW1h3xBXhxKSzhI+viPcm0Js1YrAFKDpqC8wX2kbdVSVE5rj9s6G+jL0loLWHTA==
X-Received: by 2002:adf:dd90:: with SMTP id x16mr19148018wrl.47.1604505255361;
        Wed, 04 Nov 2020 07:54:15 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id w11sm3022885wmg.36.2020.11.04.07.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:54:14 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:54:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alexandru Stan <amstan@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] backlight: pwm_bl: Fix interpolation
Message-ID: <20201104155412.GR4488@dell>
References: <20201022050445.930403-1-amstan@chromium.org>
 <20201021220404.v3.3.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201021220404.v3.3.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 21 Oct 2020, Alexandru Stan wrote:

> The previous behavior was a little unexpected, its properties/problems:
> 1. It was designed to generate strictly increasing values (no repeats)
> 2. It had quantization errors when calculating step size. Resulting in
> unexpected jumps near the end of some segments.
> 
> Example settings:
> 	brightness-levels = <0 1 2 4 8 16 32 64 128 256>;
> 	num-interpolated-steps = <16>;
> 
> Whenever num-interpolated-steps was larger than the distance
> between 2 consecutive brightness levels the table would get really
> discontinuous. The slope of the interpolation would stick with
> integers only and if it was 0 the whole line segment would get skipped.
> 
> The distances between 1 2 4 and 8 would be 1 (property #1 fighting us),
> and only starting with 16 it would start to interpolate properly.
> 
> Property #1 is not enough. The goal here is more than just monotonically
> increasing. We should still care about the shape of the curve. Repeated
> points might be desired if we're in the part of the curve where we want
> to go slow (aka slope near 0).
> 
> Problem #2 is plainly a bug. Imagine if the 64 entry was 63 instead,
> the calculated slope on the 32-63 segment will be almost half as it
> should be.
> 
> The most expected and simplest algorithm for interpolation is linear
> interpolation, which would handle both problems.
> Let's just implement that!
> 
> Take pairs of points from the brightness-levels array and linearly
> interpolate between them. On the X axis (what userspace sees) we'll
> now have equally sized intervals (num-interpolated-steps sized,
> as opposed to before where we were at the mercy of quantization).
> 
> END

I removed this.

> Signed-off-by: Alexandru Stan <amstan@chromium.org>
> ---
> 
>  drivers/video/backlight/pwm_bl.c | 70 ++++++++++++++------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
