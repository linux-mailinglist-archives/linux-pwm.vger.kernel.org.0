Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2CE1EA1E7
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 12:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgFAKex (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 06:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKex (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 06:34:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A9AC061A0E
        for <linux-pwm@vger.kernel.org>; Mon,  1 Jun 2020 03:34:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so10935677wrr.10
        for <linux-pwm@vger.kernel.org>; Mon, 01 Jun 2020 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JidvYeolwIHHbSD2dDiX8SlqkpHUDFdvt+ZtADCzORs=;
        b=gQScQ5ASX+l03rLLw1IDbJtfol85yOgpw9R75C7PidYwlC/x30RgwNUhqbCbS2yREs
         r8GiGL//zIY2JYo7jyDaO4pyDfzds3LtxZO+i/QvGmHhaGs6Hxs328E6nH0ZyV2+JI0a
         pXqOgLHik9CSps7h/GKkOdPcQfy+NUK4ktZMS0ILuK8c+wZpxs7DQBGuUX6Ja2dACY9S
         LO0JL/GOLumZfQ79A7KboowZ5Cx/rkoNWAGnBu/Jclq6MXPnzdW9zelmYMbwiX5RW0rE
         ae4e2GjO2e7eqftnuESlrPSQ1W5uIhDd7LAyWxQ9NxEiSlzRe5rAQJ5r3xI5YQzLGCAl
         wSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JidvYeolwIHHbSD2dDiX8SlqkpHUDFdvt+ZtADCzORs=;
        b=UcBrKtYApMa+oLFwxq+prwLx/FvDK2h+5ivXGcWJ3El93+SqjMJn0/tLEYnwYxH57z
         3CVX8Jac5hiHLgBGC/LcDTulRx++TBKSzEA8CnJNzNNw/WQAr3DIW1xP3adl7SlJ7SwE
         xywObeJyOnXSpXEb1Z6XPsdFOJ1SzTwu16H0x9qC9UrPYmC6c7glrwXXwqCgv+UidxxQ
         e5c43sUnhG/Xg2BGA7XrnnR9yBy7492qDWOvM02NCDDun/uh88Fz2ZjYlVNXZkWyaJ+w
         wFI0mIHjnMrattC+/RyxNJXuOdEjv7RzrtEX7GC/7ntDyWKoLw4AfTTXkHk+vbBW+sMv
         eMKw==
X-Gm-Message-State: AOAM532lXwOb55Oh/O9Xy9TejKSiMp5DYBNYABvCnWOP2bqfF36djHdX
        eV6J72KvOmNW/39W4PwJsU6T9g==
X-Google-Smtp-Source: ABdhPJy3kJjFUIdPrCL4G600SdyYUYbk1bQbHphYEEeIpH5/bz+K4VH3AL5Rt1TdJQprGD8QoffbOA==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr21059500wrq.259.1591007690282;
        Mon, 01 Jun 2020 03:34:50 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 30sm20824732wrd.47.2020.06.01.03.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 03:34:49 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:34:47 +0100
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
Subject: Re: [PATCH v3 10/13] backlight: add overview and update existing doc
Message-ID: <20200601103447.eybuy6cuzey6fak5@holly.lan>
References: <20200601065207.492614-1-sam@ravnborg.org>
 <20200601065207.492614-11-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601065207.492614-11-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 01, 2020 at 08:52:04AM +0200, Sam Ravnborg wrote:
> Add overview chapter to backlight.c.
> Update existing kernel-doc to follow a more consistent
> style and drop kernel-doc for deprecated functions.
> 
> v2:
>   - Sevaral editorial corrections that makes reading
>     much easier (Daniel)
>   - Spelling fixes (Daniel)
>   - updated intro chapter with a little more info
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Two very small nits... but one will affect formatted output so I had to
raise it. Feel free add my Reviewed-by: when recirculating!


Daniel.


> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/video/backlight/backlight.c | 131 +++++++++++++++++++---------
>  1 file changed, 90 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 17f04cff50ab..06bcddd76a7e 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -22,6 +22,46 @@
>  #include <asm/backlight.h>
>  #endif
>  
> +/**
> + * DOC: overview
> + *
> + * The backlight core supports implementing backlight drivers.
> + *
> + * A backlight driver registers a driver using
> + * devm_backlight_device_register(). The properties of the backlight
> + * driver such as type and max_brightness must be specified.
> + * When the core detect changes in for example brightness or power state
> + * the update_status() operation is called. The backlight driver shall
> + * implement this operation and use it to adjust backlight.
> + *
> + * Several sysfs attributes are provided by the backlight core::
> + *
> + * - brightness         R/W, set the requested brightness level
> + * - actual_brighness   RO, the brightness level used by the HW
> + * - max_brightness     RO, the maximum  brightness level supported
> + *
> + * See Documentation/ABI/stable/sysfs-class-backlight for the full list.
> + *
> + * The backlight can be adjusted using the sysfs interface, and
> + * the backlight driver may also support adjusting backlight using
> + * a hot-key or some other platfrom or firmware specific way.
> + *
> + * The driver shall implement the get_brightness() operation if

I overlooked this before but this reads better with "must" rather
than "shall". It's not wrong to use shall but I think it is more
idiomatic to use "must".


> + * the HW do not support all the levels that can be specified in
> + * brightness, thus providing user-space access to the actual level
> + * via the actual_brightness attribute.
> + * When the backlight changes this is reported to user-space using

Missing newline between paragraphs...


> + * an uevent connected to the actual_brightness attribute.
> + * When brightness is set by platform specific means, for example
> + * a hot-key to adjust backlight, the driver must notify the backlight
> + * core that brightness has changed using backlight_force_update().
> + *
> + * The backlight driver core receives notifications from fbdev and
> + * if the event is FB_EVENT_BLANK and if the value of blank, from the
> + * FBIOBLANK ioclt, results in a change in the backlight state the
> + * update_status() operation is called.
> + */
> +
>  static struct list_head backlight_dev_list;
>  static struct mutex backlight_dev_list_mutex;
>  static struct blocking_notifier_head backlight_notifier;
> @@ -40,9 +80,17 @@ static const char *const backlight_scale_types[] = {
>  
>  #if defined(CONFIG_FB) || (defined(CONFIG_FB_MODULE) && \
>  			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
> -/* This callback gets called when something important happens inside a
> - * framebuffer driver. We're looking if that important event is blanking,
> - * and if it is and necessary, we're switching backlight power as well ...
> +/*
> + * fb_notifier_callback
> + *
> + * This callback gets called when something important happens inside a
> + * framebuffer driver. The backlight core only cares about FB_BLANK_UNBLANK
> + * which is reported to the driver using backlight_update_status()
> + * as a state change.
> + *
> + * There may be several fbdev's connected to the backlight device,
> + * in which case they are kept track of. A state change is only reported
> + * if there is a change in backlight for the specified fbdev.
>   */
>  static int fb_notifier_callback(struct notifier_block *self,
>  				unsigned long event, void *data)
> @@ -318,12 +366,15 @@ static struct attribute *bl_device_attrs[] = {
>  ATTRIBUTE_GROUPS(bl_device);
>  
>  /**
> - * backlight_force_update - tell the backlight subsystem that hardware state
> - *   has changed
> + * backlight_force_update - force an update due to a hardware change
>   * @bd: the backlight device to update
> + * @reason: the method used for the backlight update
>   *
>   * Updates the internal state of the backlight in response to a hardware event,
> - * and generate a uevent to notify userspace
> + * and generates an uevent to notify userspace. A backlight driver shall call
> + * backlight_force_update() when the backlight is changed using, for example,
> + * a hot-key. The updated brightness is read using get_brightness() and the
> + * brightness value is reported using an uevent.
>   */
>  void backlight_force_update(struct backlight_device *bd,
>  			    enum backlight_update_reason reason)
> @@ -336,19 +387,7 @@ void backlight_force_update(struct backlight_device *bd,
>  }
>  EXPORT_SYMBOL(backlight_force_update);
>  
> -/**
> - * backlight_device_register - create and register a new object of
> - *   backlight_device class.
> - * @name: the name of the new object(must be the same as the name of the
> - *   respective framebuffer device).
> - * @parent: a pointer to the parent device
> - * @devdata: an optional pointer to be stored for private driver use. The
> - *   methods may retrieve it by using bl_get_data(bd).
> - * @ops: the backlight operations structure.
> - *
> - * Creates and registers new backlight device. Returns either an
> - * ERR_PTR() or a pointer to the newly allocated device.
> - */
> +/* deprecated - use devm_backlight_device_register() */
>  struct backlight_device *backlight_device_register(const char *name,
>  	struct device *parent, void *devdata, const struct backlight_ops *ops,
>  	const struct backlight_properties *props)
> @@ -415,6 +454,15 @@ struct backlight_device *backlight_device_register(const char *name,
>  }
>  EXPORT_SYMBOL(backlight_device_register);
>  
> +/** backlight_device_get_by_type - find first backlight device of a type
> + * @type: the type of backlight device
> + *
> + * Look up the first backlight device of the specified type
> + *
> + * RETURNS:
> + *
> + * Pointer to backlight device if any was found. Otherwise NULL.
> + */
>  struct backlight_device *backlight_device_get_by_type(enum backlight_type type)
>  {
>  	bool found = false;
> @@ -433,12 +481,7 @@ struct backlight_device *backlight_device_get_by_type(enum backlight_type type)
>  }
>  EXPORT_SYMBOL(backlight_device_get_by_type);
>  
> -/**
> - * backlight_device_unregister - unregisters a backlight device object.
> - * @bd: the backlight device object to be unregistered and freed.
> - *
> - * Unregisters a previously registered via backlight_device_register object.
> - */
> +/* deprecated - use devm_backlight_device_unregister() */
>  void backlight_device_unregister(struct backlight_device *bd)
>  {
>  	if (!bd)
> @@ -486,10 +529,12 @@ static int devm_backlight_device_match(struct device *dev, void *res,
>   * backlight_register_notifier - get notified of backlight (un)registration
>   * @nb: notifier block with the notifier to call on backlight (un)registration
>   *
> - * @return 0 on success, otherwise a negative error code
> - *
>   * Register a notifier to get notified when backlight devices get registered
>   * or unregistered.
> + *
> + * RETURNS:
> + *
> + * 0 on success, otherwise a negative error code
>   */
>  int backlight_register_notifier(struct notifier_block *nb)
>  {
> @@ -501,10 +546,12 @@ EXPORT_SYMBOL(backlight_register_notifier);
>   * backlight_unregister_notifier - unregister a backlight notifier
>   * @nb: notifier block to unregister
>   *
> - * @return 0 on success, otherwise a negative error code
> - *
>   * Register a notifier to get notified when backlight devices get registered
>   * or unregistered.
> + *
> + * RETURNS:
> + *
> + * 0 on success, otherwise a negative error code
>   */
>  int backlight_unregister_notifier(struct notifier_block *nb)
>  {
> @@ -513,20 +560,22 @@ int backlight_unregister_notifier(struct notifier_block *nb)
>  EXPORT_SYMBOL(backlight_unregister_notifier);
>  
>  /**
> - * devm_backlight_device_register - resource managed backlight_device_register()
> + * devm_backlight_device_register - register a new backlight device
>   * @dev: the device to register
>   * @name: the name of the device
> - * @parent: a pointer to the parent device
> + * @parent: a pointer to the parent device (often the same as @dev)
>   * @devdata: an optional pointer to be stored for private driver use
>   * @ops: the backlight operations structure
>   * @props: the backlight properties
>   *
> - * @return a struct backlight on success, or an ERR_PTR on error
> + * Creates and registers new backlight device. When a backlight device
> + * is registered the configuration must be specified in the @props
> + * parameter. See description of &backlight_properties.
>   *
> - * Managed backlight_device_register(). The backlight_device returned
> - * from this function are automatically freed on driver detach.
> - * See backlight_device_register() for more information.
> - */
> + * RETURNS:
> + *
> + * struct backlight on success, or an ERR_PTR on error
> +*/
>  struct backlight_device *devm_backlight_device_register(struct device *dev,
>  	const char *name, struct device *parent, void *devdata,
>  	const struct backlight_ops *ops,
> @@ -553,13 +602,13 @@ struct backlight_device *devm_backlight_device_register(struct device *dev,
>  EXPORT_SYMBOL(devm_backlight_device_register);
>  
>  /**
> - * devm_backlight_device_unregister - resource managed backlight_device_unregister()
> + * devm_backlight_device_unregister - unregister backlight device
>   * @dev: the device to unregister
>   * @bd: the backlight device to unregister
>   *
> - * Deallocated a backlight allocated with devm_backlight_device_register().
> + * Deallocates a backlight allocated with devm_backlight_device_register().
>   * Normally this function will not need to be called and the resource management
> - * code will ensure that the resource is freed.
> + * code will ensure that the resources are freed.
>   */
>  void devm_backlight_device_unregister(struct device *dev,
>  				struct backlight_device *bd)
> @@ -650,8 +699,8 @@ static void devm_backlight_release(void *data)
>  }
>  
>  /**
> - * devm_of_find_backlight - Resource-managed of_find_backlight()
> - * @dev: Device
> + * devm_of_find_backlight - find backlight for a device
> + * @dev: the device
>   *
>   * Device managed version of of_find_backlight().
>   * The reference on the backlight device is automatically
> -- 
> 2.25.1
> 
