Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A6E4CC8A0
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Mar 2022 23:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiCCWLs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Mar 2022 17:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbiCCWLs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Mar 2022 17:11:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F183E5D8
        for <linux-pwm@vger.kernel.org>; Thu,  3 Mar 2022 14:11:01 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id dr20so13602929ejc.6
        for <linux-pwm@vger.kernel.org>; Thu, 03 Mar 2022 14:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O15QTD4cJWZUCrV53Q7o/AL5EB1oKwJTXEHaA5LT8Z8=;
        b=LArKsEtR2mGirSRnS4QPB7n7g9uLcdhGS2kHqFIb8XMf4LzumrX1fTUWS3uLd0WvY7
         WLmzhRTfJFRSwidr8ido80GjMNVcP71/BhUV6EopxiDenC4YhqBj6Dwh6h95iQIK1orX
         IVEDLOvBMjjsnhO237DselDbca8Q8omBwAy+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O15QTD4cJWZUCrV53Q7o/AL5EB1oKwJTXEHaA5LT8Z8=;
        b=3DODOXx5KMxWt4vKcjkn5iXiAhfvWmNjFHjq9l3HtTeZo8uXKerwoTXRRjS+kW4wMx
         WBvhhDN/bdJNdjDtaQpYB0vn6tA29a1X1R54ZNwy9A9PF+/om/SQTBPqDoGIW8Xg+wl5
         pb9McOhXxL8gHuGVvbKj4UdEkuMaLLY9Fxj8ERak62skHB1utQHgdMXarcjanS7ysMLD
         kec9ZbJKhjPQmNYf0BmGXA129KpPDjpVifFAX/qR4jcCc8xuAId9qwMkQDiQWBDpoMgm
         SqOJkutHdz7i3dIllyZBhJwjKDNZYUYiUN3zP9zRMLUcPO7DRkBpV9UNaimlFFTgowt7
         BSUQ==
X-Gm-Message-State: AOAM530I3tt56y5mHuhIY41pEmUI5xo4VxMHNQBkVq68KB6GH9kULP66
        t8+BM5YMnyIYEPB7+oaCVhJfp9R3OwHbZg==
X-Google-Smtp-Source: ABdhPJzpCKihX5QEhuQfHxd0XyDXtKagp008+7ewd2+ce5722HQFdJ845L5X+YYBFBEofNjQC9w6BQ==
X-Received: by 2002:a17:906:69ce:b0:6a7:8c03:3caa with SMTP id g14-20020a17090669ce00b006a78c033caamr28870195ejs.335.1646345459630;
        Thu, 03 Mar 2022 14:10:59 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id cf17-20020a170906b2d100b006daa59af421sm532601ejb.149.2022.03.03.14.10.57
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 14:10:58 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so6166687wmj.0
        for <linux-pwm@vger.kernel.org>; Thu, 03 Mar 2022 14:10:57 -0800 (PST)
X-Received: by 2002:a7b:c0c1:0:b0:385:be1b:e6a with SMTP id
 s1-20020a7bc0c1000000b00385be1b0e6amr5367480wmh.73.1646345456912; Thu, 03 Mar
 2022 14:10:56 -0800 (PST)
MIME-Version: 1.0
References: <20220303214300.59468-1-bjorn.andersson@linaro.org> <20220303214300.59468-2-bjorn.andersson@linaro.org>
In-Reply-To: <20220303214300.59468-2-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Mar 2022 14:10:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WkgcJA6-niUh0L5_jLNSS=Hv0xrR5QZghPmNriekH7XA@mail.gmail.com>
Message-ID: <CAD=FV=WkgcJA6-niUh0L5_jLNSS=Hv0xrR5QZghPmNriekH7XA@mail.gmail.com>
Subject: Re: [PATCH v14 2/2] leds: Add driver for Qualcomm LPG
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Thu, Mar 3, 2022 at 1:41 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> with their output being routed to various other components, such as
> current sinks or GPIOs.
>
> Each LPG instance can operate on fixed parameters or based on a shared
> lookup-table, altering the duty cycle over time. This provides the means
> for hardware assisted transitions of LED brightness.
>
> A typical use case for the fixed parameter mode is to drive a PWM
> backlight control signal, the driver therefor allows each LPG instance
> to be exposed to the kernel either through the LED framework or the PWM
> framework.
>
> A typical use case for the LED configuration is to drive RGB LEDs in
> smartphones etc, for which the driver supports multiple channels to be
> ganged up to a MULTICOLOR LED. In this configuration the pattern
> generators will be synchronized, to allow for multi-color patterns.
>
> The idea of modelling this as a LED driver ontop of a PWM driver was
> considered, but setting the properties related to patterns does not fit
> in the PWM API. Similarly the idea of just duplicating the lower bits in
> a PWM and LED driver separately was considered, but this would not allow
> the PWM channels and LEDs to be configured on a per-board basis. The
> driver implements the more complex LED interface, and provides a PWM
> interface on the side of that, in the same driver.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v13:
> - Fixed mixed space/tab indentation in documentation
> - Added 0 as to lpg_clk_rates[] to match the hardware state, to avoid + 1 in
>   lpg_apply_freq() and - 1 in lpg_pwm_get_state()
> - Don't divide with 0 if current clock is 0 in lpg_pwm_get_state(), just return
>   period = duty = 0 in this case
> - Renamed "clk" in struct lpg_channel to clk_sel
> - Renamed "pre_div" in struct lpg_channel to pre_div_sel
>
> Changes since v12:
> - Initialize ret in lpg_pwm_apply()
>
> Changes since v11:
> - Extended commit message to cover decision to put pwm_chip in the LED driver
> - Added Documentation, in particular for the hw_pattern format
> - Added a lock to synchronize requests from LED and PWM frameworks
> - Turned out that the 9bit selector differs per channel in some PMICs, so
>   replaced bitmask in lpg_data with lookup based on QPNP SUBTYPE
> - Fixed kerneldoc for the struct device pointer in struct lpg
> - Rewrote conditional in lut_free() to make it easier to read
> - Corrected and deduplicated max_period expression in lpg_calc_freq()
> - Extended nom/dom to numerator/denominator in lpg_calc_freq()
> - Replaced 1 << 9 with LPG_RESOLUTION in one more place in lpg_calc_freq()
> - Use FIELD_PREP() in lpg_apply_freq() as masks was introduced for reading the
>   same in get_state()
> - Cleaned up the pattern format, to allow specifying both low and high pause
>   with and without pingpong mode.
> - Only update frequency and pwm_value if PWM channel is enabled in lpg_pwm_apply
> - Make lpg_pwm_get_state() read the hardware state, in order to pick up e.g.
>   bootloader backlight configuration
> - Use devm_bitmap_zalloc() to allocate the lut_bitmap
> - Use dev_err_probe() in lpg_probe()
> - Extended Kconfig help text to mention module name and satisfy checkpatch
>
>  Documentation/leds/leds-qcom-lpg.rst |   76 ++
>  drivers/leds/Kconfig                 |    3 +
>  drivers/leds/Makefile                |    3 +
>  drivers/leds/rgb/Kconfig             |   18 +
>  drivers/leds/rgb/Makefile            |    3 +
>  drivers/leds/rgb/leds-qcom-lpg.c     | 1405 ++++++++++++++++++++++++++
>  6 files changed, 1508 insertions(+)

Gets rid of the KASAN error and PWM still works for me, so happy to add back:

Tested-by: Douglas Anderson <dianders@chromium.org>

I haven't done a full review of the driver but I did a once-over of
the changes between v12 and v13 and they look good to me.

-Doug
