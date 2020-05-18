Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CD81D7C31
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 17:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgERPCs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 11:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgERPCs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 11:02:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D98C061A0C
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:02:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id v12so12210980wrp.12
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sV0m8WznJVkJ3Rzh1L6PIGB9vtQ6aOFT6kQ9Yk8Eimg=;
        b=mH+fPJSgXfctwApo3TIBm5ZTumxCNETY6kEGEyqQr1/Sc6+ERPZT7j9ACspLXz9t+n
         4jmXHA0qlYkLFzSW2Y9VYutX5td5ApQ/bzlmqwpYeZ5dDnOgoYyY8F+EfUp9WLuMRRJ/
         93Jou3ke8/Op5YwANC5uyYPJboVYA11SMm3lWlZCV+SLo5bm52tfo860huufQyizP5Vg
         lBX3ruwKbWMRQcIqyGtec41Btd+KtyXfaDHDptxqdKQL1wWudpZpHsyTUeW8F2hyoqZ8
         zPJTxetVaGNj9kfL+v/eQhcmkP/dD85RdtvQColXGQM7F3+5WDpbvtu3oU5K4dvYsHM8
         9SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sV0m8WznJVkJ3Rzh1L6PIGB9vtQ6aOFT6kQ9Yk8Eimg=;
        b=bX7cJdv/23c+xJBGXZUdsYRqV+zEHtgkUBEVpI6TH2rumc9e2aIS1DlLPc2xT3nihe
         qDO5bKW9q7jb3qF/dcFyyR3EX2SHHnbqTvTc5momrfQB5z2RWiK5kU9Q7Zjt/XZ/w23V
         gHralKlIcWHA0HEtkoSgCJRoaHlFKEelY9SYBXPfQMlHInnWOM5huM5cYwvUowYVUSk7
         X6LxX06Q7APoT4e5M82Smshu1cUVy6XAzMHwP+M7y+Wl4E/pMcDLS6mqAilglaSW4ydH
         y6OGMnpS4NiNVMOPwSyNsyqzg0rnCHKIUAcvqGfEuUPGBgc+LdOQSaOPyFkF5+rDPG8x
         q/lg==
X-Gm-Message-State: AOAM533JtHJ6EoNDgqzkYeVaxt3Wk2EZ90i2rLPTgOyrHu0TwkQsw1i7
        TAcKgAMVBTMV5Lkr67YzoECXlg==
X-Google-Smtp-Source: ABdhPJwFaOSvYRdYbtjmy6A+WLKjyqk/uu4bblCbZHBXip4YnPSFghLq8RDuiIgsog3a9MA1JOU+tw==
X-Received: by 2002:adf:8302:: with SMTP id 2mr20949388wrd.114.1589814166534;
        Mon, 18 May 2020 08:02:46 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id m1sm18780972wrx.44.2020.05.18.08.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:02:45 -0700 (PDT)
Date:   Mon, 18 May 2020 16:02:43 +0100
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
Subject: Re: [PATCH v2 04/16] backlight: improve backlight_ops documentation
Message-ID: <20200518150243.l3ovckvitwoz4uwy@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-5-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-5-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:01:27PM +0200, Sam Ravnborg wrote:
> Improve the documentation for backlight_ops and
> adapt it to kernel-doc style.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  include/linux/backlight.h | 60 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 54 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index a0a083b35c47..519dc61ce7e4 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -55,19 +55,67 @@ enum backlight_scale {
>  struct backlight_device;
>  struct fb_info;
>  
> +/**
> + * struct backlight_ops - backlight operations
> + *
> + * The backlight operations are specifed when the backlight device is registered.
> + */
>  struct backlight_ops {
> +	/**
> +	 * @options:
> +	 *
> +	 * The options parameter is used to adjust the behaviour of the core.
> +	 * Set BL_CORE_SUSPENDRESUME to get the update_status() operation called
> +	 * upon suspend and resume.
> +	 */
>  	unsigned int options;
>  
>  #define BL_CORE_SUSPENDRESUME	(1 << 0)
>  
> -	/* Notify the backlight driver some property has changed */
> +	/**
> +	 * @update_status:
> +	 *
> +	 * Notify the backlight driver some property has changed.
> +	 * The update_status operation is protected by the update_lock.
> +	 *
> +	 * The backlight driver is expected to use backlight_is_blank()
> +	 * to check if the display is blanked and set brightness accordingly.
> +	 * update_status() is called when any of the properties has changed.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * 0 on sucees, negative error code if any failure occured.
> +	 */
>  	int (*update_status)(struct backlight_device *);
> -	/* Return the current backlight brightness (accounting for power,
> -	   fb_blank etc.) */
> +
> +	/**
> +	 * @get_brightness:
> +	 *
> +	 * Return the current backlight brightness.
> +	 * The driver may implement this as a readback from the HW.
> +	 * This operation is optional and if not present then the current brightness
> +	 * property value is used.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * A brightness value which is 0 or a positive numer.
> +	 * On failure a negative error code is returned.
> +	 */
>  	int (*get_brightness)(struct backlight_device *);
> -	/* Check if given framebuffer device is the one bound to this backlight;
> -	   return 0 if not, !=0 if it is. If NULL, backlight always matches the fb. */
> -	int (*check_fb)(struct backlight_device *, struct fb_info *);
> +
> +	/**
> +	 * @check_fb:
> +	 *
> +	 * Check if given framebuffer device is the one bound to this backlight.
> +	 * This operation is optional and if not implemented it is assumed that the
> +	 * fbdev is always the one bound to the backlight.
> +	 *
> +	 * RETURNS:
> +	 *
> +	 * If info is NULL or the info matches the fbdev bound to the backlight return true.
> +	 * If info does not match the fbdev bound to the backlight return false.
> +	 */
> +	int (*check_fb)(struct backlight_device *bd, struct fb_info *info);
>  };
>  
>  /* This structure defines all the properties of a backlight */
> -- 
> 2.25.1
> 
