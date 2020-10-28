Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C983329D78D
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Oct 2020 23:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbgJ1WZd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Oct 2020 18:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732921AbgJ1WZc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Oct 2020 18:25:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA8AC0613D1
        for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2020 15:25:32 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d24so920688ljg.10
        for <linux-pwm@vger.kernel.org>; Wed, 28 Oct 2020 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l4u4x3wqcamFjVhNhf6xSDsxJDF4ia7ZULeYQGII8mw=;
        b=ILXuE1FuPImvS0DqL5IMRBIlL6RZds+hGRxbUKX2fa3Jb+p0i0FfZNnJbTmkYt64BZ
         IkBsZrgp2cHPDVPsSjnIKqN1/P4dJLa0IwrECAb23FygPzfJRHZ/TqvwLlSC+OYLopST
         mfZn/1onAzkuNMiuX+7fJo9bwL6hP0R8JObt3U6IID7loQ4hX1w7QFMw3tUm6koym7hw
         EwdWEE7k8ny3zQeSSZLwuWBrKgTCDDAVsOg+Sjxd2sy3jS9T6gTXbCA2TZLmddXiOWUa
         PG9DUcWHtS11SC1hHzAy/UElkE9HmhHcxPVrEM9fBOj4yvK6Fill0qfq3iJIcENygqOT
         lu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l4u4x3wqcamFjVhNhf6xSDsxJDF4ia7ZULeYQGII8mw=;
        b=kujQIJHY4KVhh8Lkb4rx91FW9IzhiKd3C8Sc/UBo7dtfVM7SbgkXSLKm6IikbiYDDS
         pci7QQ1WHqP33GjM3xoqtjnqan7N1533YF2xDWIqB0V7lL1PmPwWWRn9EVZzu13Jx2l/
         +Gbrtm5CKc0GyozeY5V0MOWke+e9h5vn168zzLMqSgAC0jqsjNL2jTHM/6lNefqKyhq2
         S3q5Fzhn70jmnOJJc/ZTRPy9d9aZZTV8wwSVC2HInCWNckVQzsj0d7JXInUG3C7t2CYY
         STqgBIyeb59DoUss4AXLnzYVtcrHF1EL5yfya6H7o4K3kFG4isX56NbicfK4BKCfSbG9
         mX8g==
X-Gm-Message-State: AOAM533OC8ZD0Bing4DKDSYFuvxtmhVfI6rB4h9r5xR1P67vYMiuvMVs
        9xitkXe78J8l1+zt6RwLVffRXg6a0Z/syA==
X-Google-Smtp-Source: ABdhPJwyi+wHXJ2cOvhZn68n5CD1XcT8uEuh3II80NOAVMoEVT9S3UDw7HAkoUOuK4zYQVybjj4JCA==
X-Received: by 2002:adf:80c8:: with SMTP id 66mr9768069wrl.415.1603897934446;
        Wed, 28 Oct 2020 08:12:14 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id u5sm8619996wru.63.2020.10.28.08.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 08:12:13 -0700 (PDT)
Date:   Wed, 28 Oct 2020 15:12:10 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Stan <amstan@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] backlight: pwm_bl: Fix interpolation
Message-ID: <20201028151210.7e765hbq2k7i3url@holly.lan>
References: <20201022050445.930403-1-amstan@chromium.org>
 <20201021220404.v3.3.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021220404.v3.3.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 21, 2020 at 10:04:45PM -0700, Alexandru Stan wrote:
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

INTERESTING.

I guess this a copy 'n paste error from some internal log book?
Better removed... but I won't lose sleep over it.


> Signed-off-by: Alexandru Stan <amstan@chromium.org>

I've waited a bit to see how strong the feelings were w.r.t. getting rid
of the division from the table initialization. It was something I was
aware of during an earlier review but it was below my personal nitpicking
threshold (which could be badly calibrated... hence waiting). However
it's all been quiet so:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
