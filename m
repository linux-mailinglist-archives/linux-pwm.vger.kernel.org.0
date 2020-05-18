Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E181D7D77
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 17:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgERPxa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgERPxa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 11:53:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264BAC05BD09
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:53:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so12460823wra.7
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1MOGVGDs5OeGfwi3VK8Xlt79QAxduVVC7NWl7I/nzsM=;
        b=S9NQFwn8O8M7YdxD6fWzC1AmG7i86Q4EXgHk8ojNzkC3dPe8+/OSHtV/OnUOIDek+w
         UXa/JRwiUrejrJTZz7opZIteAnbXftSoS5eCLVCrn/lTpkmuhqsRYq2giOBTYSlZoJez
         xkO/VO5J62rqmTQlA1rBqDEWPf0unLjozixBIKO8pBkVQcPzV+DPRVjGa7bi6Vh0zwlS
         FDtw4i1eWK0ESp9tXdu31UWdtoYYzR68oVj3BZZMxO0o+AeUQvJB6oML5TpGrag6YUhw
         8D5K6ON5x42tIjgaw+HNuZ98FG07B0JmNCcUZ1e13JBD/r6jgsfv+Hp8rRD6Csp+Flqq
         5Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1MOGVGDs5OeGfwi3VK8Xlt79QAxduVVC7NWl7I/nzsM=;
        b=dGc1RJ49SSHSnz2ykyp7safewYb7PRMH1agdnOLjcP1lGPFL71+ZNyILjdskfRY8SC
         ynYDE8ta0eCxTb4+kI9HGUe4NTDRTU3n+7hRZ7J+jKZBeHp+Bhx+FBLjmFSQK32VJRpz
         BL3InivJiHHK6b0a1bQxPGC+hz6Sw6BL1Vk8c/VebBOCFub2JDbxslqdmImCp2M5pML0
         gOQIR1/BSP/lfUJfSmPu2+39s0uDXVg+cM6SWq4AX8L1DTdczolZF9LMoqpLoeb0Auxf
         paqtjUq+WdZGI9bT0sEguvcrCTYUlKT6FJZ0aUkVf0o1uFn0klhfKJ7tNjxARfSqoVqp
         Pdvg==
X-Gm-Message-State: AOAM532Ka+vkqgHELv9aMGT5b25oZLuvuQnJYsvf1byGz4VjxLi5whTi
        2nDqabKbSNJTohABkhJGRzqWRw==
X-Google-Smtp-Source: ABdhPJyHnttLi85aikrcbMslC+yDiCMUkFPHFALi19qf+ZfR5WFpz/Wcso0LxGP5WIJfH2AgY4oYpg==
X-Received: by 2002:a05:6000:1244:: with SMTP id j4mr21070478wrx.189.1589817208789;
        Mon, 18 May 2020 08:53:28 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 128sm17837626wme.39.2020.05.18.08.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:53:28 -0700 (PDT)
Date:   Mon, 18 May 2020 16:53:26 +0100
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
Subject: Re: [PATCH v2 05/16] backlight: improve backlight_properties
 documentation
Message-ID: <20200518155326.a35lny7xtsvynibo@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-6-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-6-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:01:28PM +0200, Sam Ravnborg wrote:
> Improve the documentation for backlight_properties and
> adapt it to kernel-doc style.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Overall looks good but enough nits that I felt compelled to comment!


> ---
>  include/linux/backlight.h | 101 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 90 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 519dc61ce7e4..7f9cef299d6e 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -118,28 +118,107 @@ struct backlight_ops {
>  	int (*check_fb)(struct backlight_device *bd, struct fb_info *info);
>  };
>  
> -/* This structure defines all the properties of a backlight */
> +/**
> + * struct backlight_properties - backlight properties
> + *
> + * This structure defines all the properties of a backlight.
> + */
>  struct backlight_properties {
> -	/* Current User requested brightness (0 - max_brightness) */
> +	/**
> +	 * @brightness:
> +	 *
> +	 * The current requested brightness by the user.

This applies throughout this file (and perhaps I overlooked it in the
previous patc too) but having line breaks after @brightness: differs
from the canonical description of a kerneldoc command in:
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#in-line-member-documentation-comments

Also: s/requested brightness/brightness requested/


> +	 * The backlight core makes sure the range is (0 - max_brightness)

I know this is a copy of the original text but I'd prefer the range not
to use the subtract operator ;-). Maybe 0..max_brightness like the
ranges below?


> +	 * when the brightness is set via the sysfs attribute:
> +	 * /sys/class/backlight/<backlight>/brightness.
> +	 *
> +	 * This value can be set in the backlight_properties passed
> +	 * to devm_backlight_device_register() to set a default brightness
> +	 * value.
> +	 */
>  	int brightness;
> -	/* Maximal value for brightness (read-only) */
> +
> +	/**
> +	 * @max_brightness:
> +	 *
> +	 * The maximum brightness value.
> +	 *
> +	 * This value must be set in the backlight_properties passed
> +	 * to devm_backlight_device_register().
> +	 *
> +	 * This property must not be modified by a driver except
> +	 * before registering the backlight device as explained above.

Perhaps combine these (rather than "as explained above"):

  This value must be set in the backlight_properties passed to
  devm_backlight_device_register() and shall not be modified by the
  driver after registration.


> +	 */
>  	int max_brightness;
> -	/* Current FB Power mode (0: full on, 1..3: power saving
> -	   modes; 4: full off), see FB_BLANK_XXX */
> +
> +	/**
> +	 * @power:
> +	 *
> +	 * The current power mode. User space configure the power mode using

s/configure/can configure/

> +	 * the sysfs attribute: /sys/class/backlight/<backlight>/bl_power
> +	 * When the power property is updated update_status() is called.
> +	 *
> +	 * The possible values are: (0: full on, 1..3: power saving
> +	 * modes; 4: full off), see FB_BLANK_XXX.
> +	 *
> +	 * When the backlight device is enabled @power is set
> +	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
> +	 * @power is set to FB_BLANK_POWERDOWN.
> +	 */
>  	int power;
> -	/* FB Blanking active? (values as for power) */
> -	/* Due to be removed, please use (state & BL_CORE_FBBLANK) */
> +
> +	/**
> +	 * @fb_blank:
> +	 *
> +	 * When the FBIOBLANK ioctl is called fb_blank is set to the
> +	 * blank parameter and the update_status() operation is called.
> +	 *
> +	 * When the backlight device is enabled @fb_blank is set
> +	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
> +	 * @fb_blank is set to FB_BLANK_POWERDOWN.
> +	 *
> +	 * This property must not be modified by a driver.
> +	 * The backlight driver shall never read this variable,
> +	 * as the necessary info is avaialble via the state.

I'd rather be told what to do that what not to do!

Maybe.

  Backlight drivers should avoid using this property. It has been
  replaced by state & BL_CORE_FBLANK (although most drivers should
  use backlight_is_blank() as the preferred means to get the blank
  state.



Daniel.


> +	 *
> +	 * fb_blank is deprecated and will be removed.
> +	 */
>  	int fb_blank;
> -	/* Backlight type */
> +
> +	/**
> +	 * @type:
> +	 *
> +	 * The type of backlight supported.
> +	 * The backlight type allows userspace to make appropriate
> +	 * policy desicions based on the backlight type.
> +	 *
> +	 * This value must be set in the backlight_properties
> +	 * passed to devm_backlight_device_register().
> +	 */
>  	enum backlight_type type;
> -	/* Flags used to signal drivers of state changes */
> +
> +	/**
> +	 * @state:
> +	 *
> +	 * The state property is used to inform drivers of state changes
> +	 * when the update_status() operation is called.
> +	 * The state is a bitmask. BL_CORE_FBBLANK is set when the display
> +	 * is expected to be blank. BL_CORE_SUSPENDED is set when the
> +	 * driver is suspended.
> +	 *
> +	 * This property must not be modified by a driver.
> +	 */
>  	unsigned int state;
> -	/* Type of the brightness scale (linear, non-linear, ...) */
> -	enum backlight_scale scale;
>  
>  #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
>  #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
>  
> +	/**
> +	 * @scale:
> +	 *
> +	 * The type of the brightness scale (linear, non-linear, ...)
> +	 */
> +	enum backlight_scale scale;
>  };
>  
>  struct backlight_device {
> -- 
> 2.25.1
> 
