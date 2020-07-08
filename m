Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32578218585
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2020 13:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGHLGc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jul 2020 07:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgGHLGc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jul 2020 07:06:32 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F54AC08E6DC
        for <linux-pwm@vger.kernel.org>; Wed,  8 Jul 2020 04:06:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so48472833wrm.4
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jul 2020 04:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ImpRCPSvgLqMxrUg0iAeiMjdkq4+obVp/Tu68Rhv9qc=;
        b=dzg63SjeULrmJhDxL8oKzRPZhWxj3EwrGLCJkdfVGWK3+eDZAcBkKKcNi7FhyOsJmR
         R0bT/qSyr/oLnAnTpD7VGWPScsbm6+Tvu71v7v+YL3pHIZnJEH3A1gD7B9DPbkjQ9wPR
         ZzcMGiVya0YZHlGZ40/3T/tYDZLcEWW24sHvnyFrbnuxX379TdFv3OYzLjnU2h2OUCnx
         0l0Y3bkv27deB8KlLWt6wUsz/Nd9Ts5UL+ztgChIt2H7ws+el4VzasVuk0iibQnmX8aZ
         gcYagZ/ED1P+e07pyBdGwMf34U6BPCJvlmQknI7bsFa08ARh+Jtyxbm8EtYa4x9+npH2
         EPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ImpRCPSvgLqMxrUg0iAeiMjdkq4+obVp/Tu68Rhv9qc=;
        b=BrwmhuvBgfYSvs3vKGyiK6R+JYY7ypWU5EHyMH3ASqXRGy4BO9YD6x8M4URqUQNYJj
         k59jLeSudh/1iIrkwhXvIZiBMJlAO1taIf/2caPUfXoz5Bb41DQ4xRh+QVwTJQQgNaXW
         thQ6lTj5gcBLuP4FMK7bnXh70xHiDDg+rUNp17f7BbznCCTOwOB3xj8BBsqC5HF4Cnpx
         KL1wI79Y3Bo5BAGullxcWmyMB9W7Rw+epRSc/bysl2uJYhJUMgmAuj8ZLxAR7SBb5BEQ
         nfnvFiEdL23mPgzi/ez4umnDDC4p+kdRSpMHusR/XELsvApxETTCytKFB4spj3AxcHYj
         HBQw==
X-Gm-Message-State: AOAM5324m4qO5xHzRkwtjF+WjWFNdnYFcgkhzEvNq4NPT7QO4kIz8eRY
        IMg+WuHfnnOiMM11QHthtop2LQ==
X-Google-Smtp-Source: ABdhPJxi7daTZkwF42cpVndoj6tcyAW+kTFLSAwZxlk89Uel0hIhqGsVN4LZGU6LdRiIBXikdzafbw==
X-Received: by 2002:adf:c542:: with SMTP id s2mr31759067wrf.132.1594206390255;
        Wed, 08 Jul 2020 04:06:30 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c25sm5221919wml.46.2020.07.08.04.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:06:29 -0700 (PDT)
Date:   Wed, 8 Jul 2020 12:06:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
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
Subject: Re: [PATCH v4 14/20] backlight: cr_bllcd: introduce
 backlight_is_blank()
Message-ID: <20200708110627.z5ofexh4llk66jey@holly.lan>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-15-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703184546.144664-15-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 03, 2020 at 08:45:40PM +0200, Sam Ravnborg wrote:
> The cr_bllcd uses the FB_BLANK states as brightness.
> This results in brightness value equals 0 that turn on
> the display and 4 that turn off the display.

max_brightness is 0 which makes it impossible to set the brightness to
4.


> Simplify the logic but keep current behaviour
> as userspace may expect brightness set to 0 to turn on the display.

I don't deny the possibility but we'd be talking about a userspace
custom enough to explicitly configure the module loader (otherwise
the module wouldn't load and the backlight would be inherited from
the BIOS) and that also contains an explicit write to the brightness
property that sets it to what is already the default (and only
possible) value.

In other words I'm very sceptical such a userspace exists and would be
happy to see this driver modified to use the new helpers and behave
like gpio-backlight (which can be regarded as our reference 1-bit
backlight driver).


Daniel.

> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/video/backlight/cr_bllcd.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
> index 4624b7b7c6a6..edca5fee9689 100644
> --- a/drivers/video/backlight/cr_bllcd.c
> +++ b/drivers/video/backlight/cr_bllcd.c
> @@ -63,22 +63,16 @@ static int cr_backlight_set_intensity(struct backlight_device *bd)
>  	u32 addr = gpio_bar + CRVML_PANEL_PORT;
>  	u32 cur = inl(addr);
>  
> -	if (bd->props.power == FB_BLANK_UNBLANK)
> -		intensity = FB_BLANK_UNBLANK;
> -	if (bd->props.fb_blank == FB_BLANK_UNBLANK)
> -		intensity = FB_BLANK_UNBLANK;
> -	if (bd->props.power == FB_BLANK_POWERDOWN)
> -		intensity = FB_BLANK_POWERDOWN;
> -	if (bd->props.fb_blank == FB_BLANK_POWERDOWN)
> +	if (backlight_is_blank(bd))
>  		intensity = FB_BLANK_POWERDOWN;
>  
> -	if (intensity == FB_BLANK_UNBLANK) { /* FULL ON */
> +	if (intensity != FB_BLANK_POWERDOWN) { /* FULL ON */
>  		cur &= ~CRVML_BACKLIGHT_OFF;
>  		outl(cur, addr);
> -	} else if (intensity == FB_BLANK_POWERDOWN) { /* OFF */
> +	} else { /* OFF */
>  		cur |= CRVML_BACKLIGHT_OFF;
>  		outl(cur, addr);
> -	} /* anything else, don't bother */
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
