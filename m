Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388A21D7C23
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgERPBB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 11:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERPBB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 11:01:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8402C05BD09
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:01:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z4so8462294wmi.2
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8++mCf4jSObKvczsPrCihMEuKhSX0mbSobsPe+OlqoE=;
        b=b1KoRPzh9KeASUfJshq63jbOp9jg3g/1rpHNd1w/o+KQuz4BhUdHMX05yfqVsWYET4
         HWW1Mpp4YrWFk67arh4A2bp+D+x9YrUAJr/tgsIAjZJUb6vepsGF6L3fMH55zsUrFIJJ
         0mSRpAxHlAsHOcYM7awxP5nAJX3vNXuaewFgbEE/Hvb/P6FI263krXKqG4gsb/p58602
         4K8Vm/tZRVERoDDdHDD4wyRS1FQHHf2xLhg532Qj8v0QFQpgmlSBqNl6gRqp2Yf+6yyv
         4yJ79yABAK+WKH83YZfPZ9vmS3WqBCP17g2A7bVa+J/erzwnI8YSkmsnjUUgCuiCKS2S
         jqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8++mCf4jSObKvczsPrCihMEuKhSX0mbSobsPe+OlqoE=;
        b=KXKJ+8fThc+ZMVEsh2gxmFVhTrbiql8KDy3TUXzkBWmKApnsPDJ4WJQAZNsZK/Tv6K
         zZ3WpxGA2SHNeRIDzdpIwisNJULoWFAlVXvFOt6zZjniYfK5YXdv+HeFqwuGkCaCsCjm
         sEi3ikHX9DHhP5j4WGJErIh5DwpJM1jl0BqlG8OILjEuRmnHz+OBvgDWCw+VZ0F/HwlI
         Ls7Bov9q2HgS7/WoCFdWjv6I/Rs+7YH2n8FdNW5V5yVs9oOuBU20s6oBiiXUaikxNqKu
         d0U0mlym+0XD1X2EZePhIJsjBYzgTy5K0iEr1Q0lrzfk0s7IRXTY76KnaJWGhibekq/P
         wjkA==
X-Gm-Message-State: AOAM530RRiCDOJucX1xSom4EBNGTdIFVtE0aw5OkouYTJsQwh/Q8bj3W
        CSdX4vR97qmL1eDX2VXZB/UnhQ==
X-Google-Smtp-Source: ABdhPJwVYyW+g2DU5vF2SFs8kROpaXsS+0st9Moezr7mqbpA2jZeUyxRLI/bkAyeZ7mLDzH+DnX7+w==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr20423003wmi.86.1589814058651;
        Mon, 18 May 2020 08:00:58 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j2sm16678993wrp.47.2020.05.18.08.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:00:57 -0700 (PDT)
Date:   Mon, 18 May 2020 16:00:55 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Russell King <linux@armlinux.org.uk>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 03/16] backlight: add backlight_is_blank()
Message-ID: <20200518150055.2vaaoucf4nodwoz5@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-4-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-4-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:01:26PM +0200, Sam Ravnborg wrote:
> The backlight support has two properties that express the state:
> - power
> - state
> 
> It is un-documented and easy to get wrong.
> Add backlight_is_blank() helper to make it simpler for drivers
> to get the check of the state correct.
> 
> A lot of drivers also includes checks for fb_blank.
> This check is redundant when the state is checked
> and thus not needed in this helper function.
> But added anyway to avoid introducing subtle bug
> due to the creative use in some drivers.
> 
> Rolling out this helper to all relevant backlight drivers
> will eliminate almost all accesses to fb_blank.
> 
> v2:
>   - Added fb_blank condition (Daniel)
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  include/linux/backlight.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index c7d6b2e8c3b5..a0a083b35c47 100644
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
> +static inline bool backlight_is_blank(struct backlight_device *bd)
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
