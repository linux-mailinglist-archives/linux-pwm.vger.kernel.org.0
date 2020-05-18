Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D841D7DB7
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 18:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgERQD3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgERQD3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 12:03:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAD3C05BD09
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:03:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u188so87192wmu.1
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ecSXsQvIgVKx2CnvVEKEY28m8eCL4Ahrzs7wwcHakZY=;
        b=fIksCWZ3vAnb0g8NSSRrNtrtGHGNWC2FoiKZBSTLJHpVT/03Sfjce+PjK8DcPC3r9q
         yOtVBzrL3+4izdDqzWYr6vKJXk3McXVZZWhRhj5chIxSZ25GEq29mlpqF3OkW0os3J+9
         ahy8bD0j3PO+OLKFZODf9FAPhFHjIc3wt5HddyHVu5AzoPeCAZ65mBpzv5hNRJekl8ST
         pQrymwzaZ46zN9Ke5kxTCbnhNehSgvbuNMSjrmD4SG4YeFzcPW1LV1OH1Mw6MHHETGuM
         N90F6hrB3jTfi8S7Aw3E92m/XqEhkwLdHJuXS3lJN3HVJpTNXtBYeyHI65RxDOBqjtK+
         lpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ecSXsQvIgVKx2CnvVEKEY28m8eCL4Ahrzs7wwcHakZY=;
        b=Q94GDu1Q81uwl+oEBnT6SronlpBC/W+6KZmM0Q7IyoC+Zd9r/4Kck24ADNIKIxiNXN
         /mOQLV0wNlo2cLUFm12hv4WEO7lOoTs0dh4P8+dHDuZiYS4luSvNrbh6iQwUP/z98/q0
         XmCW6CjeXfRahuwgbZ6rsvAuLO+ZU8ya40s18EGxpV1GZ9IPKp8VajDJq71C/CSgPv+r
         H/ltMmrfG1D4WoyGRuGtIpLHZF/A6QF/agq5Wkgt5ktpQCwOsJ4hvsA7KAOG+wu0aEYi
         LxU04QMOrMsbo7/myHaPLIHDYXKH1j8ysHBevAD5WXuAQbMwZM1l817uI0TP6IDHn8b0
         uZmw==
X-Gm-Message-State: AOAM533ZEmu4+p3l4ceDWJB9kp7E0mM5X+FzHx6bLg+y1UbCtTbIy+f+
        TRlDJ+wqf8QCTfPx8+/LDCZNJQ==
X-Google-Smtp-Source: ABdhPJxFgNO9b9jlLxpfUXNaNfUUnCRDLCIAOn/J8fn7iQhxyB1B5pJXyH5klpegs358QA3oeUa1+Q==
X-Received: by 2002:a1c:3585:: with SMTP id c127mr114635wma.34.1589817807441;
        Mon, 18 May 2020 09:03:27 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id a74sm11197wme.23.2020.05.18.09.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:03:26 -0700 (PDT)
Date:   Mon, 18 May 2020 17:03:24 +0100
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
Subject: Re: [PATCH v2 06/16] backlight: improve backlight_device
 documentation
Message-ID: <20200518160324.mak4mhgyrgdbr7ww@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-7-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-7-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:01:29PM +0200, Sam Ravnborg wrote:
> Improve the documentation for backlight_device and
> adapt it to kernel-doc style.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  include/linux/backlight.h | 81 ++++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 7f9cef299d6e..e2d72936bf05 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -14,21 +14,6 @@
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>  
> -/* Notes on locking:
> - *
> - * backlight_device->ops_lock is an internal backlight lock protecting the
> - * ops pointer and no code outside the core should need to touch it.
> - *
> - * Access to update_status() is serialised by the update_lock mutex since
> - * most drivers seem to need this and historically get it wrong.
> - *
> - * Most drivers don't need locking on their get_brightness() method.
> - * If yours does, you need to implement it in the driver. You can use the
> - * update_lock mutex if appropriate.
> - *
> - * Any other use of the locks below is probably wrong.
> - */
> -
>  enum backlight_update_reason {
>  	BACKLIGHT_UPDATE_HOTKEY,
>  	BACKLIGHT_UPDATE_SYSFS,
> @@ -221,30 +206,80 @@ struct backlight_properties {
>  	enum backlight_scale scale;
>  };
>  
> +/**
> + * struct backlight_device - backlight device data
> + *
> + * This structure holds all data required by a backlight device.
> + */
>  struct backlight_device {
> -	/* Backlight properties */
> +	/**
> +	 * @props:
> +	 *

As last patch. Why no brief descriptions?


> +	 * Backlight properties
> +	 */
>  	struct backlight_properties props;
>  
> -	/* Serialise access to update_status method */
> +	/**
> +	 * @update_lock:
> +	 *
> +	 * update_lock is an internal backlight lock that serialise access
> +	 * to the update_status() method. The iupdate_lock mutex shall not be used
> +	 * by backlight drivers.

In addition to the typo this directly contradicts the advice in the
original "Notes on locking".

A change this dramatic needs to be fully explaining in the patch
description.


Daniel.


> +	 */
>  	struct mutex update_lock;
>  
> -	/* This protects the 'ops' field. If 'ops' is NULL, the driver that
> -	   registered this device has been unloaded, and if class_get_devdata()
> -	   points to something in the body of that driver, it is also invalid. */
> +	/**
> +	 * @ops_lock:
> +	 *
> +	 * ops_lock is an internal backlight lock that protects the ops pointer
> +	 * and is used around all accesses to ops and when the operations are
> +	 * invoked. The mutex shall not be used by backlight drivers.
> +	 */
>  	struct mutex ops_lock;
> +
> +	/**
> +	 * @ops:
> +	 *
> +	 * Pointer to the backlight operations. If ops is NULL, the driver that
> +	 * registered this device has been unloaded, and if class_get_devdata()
> +	 * points to something in the body of that driver, it is also invalid.
> +	 */
>  	const struct backlight_ops *ops;
>  
> -	/* The framebuffer notifier block */
> +	/**
> +	 * @fb_notif:
> +	 *
> +	 * The framebuffer notifier block
> +	 */
>  	struct notifier_block fb_notif;
>  
> -	/* list entry of all registered backlight devices */
> +	/**
> +	 * @entry:
> +	 *
> +	 * List entry of all registered backlight devices
> +	 */
>  	struct list_head entry;
>  
> +	/**
> +	 * @dev:
> +	 *
> +	 * Parent device.
> +	 */
>  	struct device dev;
>  
> -	/* Multiple framebuffers may share one backlight device */
> +	/**
> +	 * @fb_bl_on:
> +	 *
> +	 * Multiple fbdev's may share one backlight device. The fb_bl_on
> +	 * records the state of the individual fbdev.
> +	 */
>  	bool fb_bl_on[FB_MAX];
>  
> +	/**
> +	 * @use_count:
> +	 *
> +	 * The number of uses of fb_bl_on.
> +	 */
>  	int use_count;
>  };
>  
> -- 
> 2.25.1
> 
