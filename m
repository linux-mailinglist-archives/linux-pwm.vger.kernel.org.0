Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55F41EA1C5
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 12:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgFAKX2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgFAKX2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 06:23:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112F0C061A0E
        for <linux-pwm@vger.kernel.org>; Mon,  1 Jun 2020 03:23:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so10953591wrt.5
        for <linux-pwm@vger.kernel.org>; Mon, 01 Jun 2020 03:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPc1R/og9Ir+04CfSDJxIvgAkJNVAC0c3KZrKXKoWzg=;
        b=Z/bIM47Mizdtdj/uOdxE/1RhoF2OX7Q6jlW2/vIHMTxzspS85xMpNn4K1UsKfX+itO
         o/0zHpe9wqa2HLNSMFusvrYHG4t7ePFxR7yI/ms9UFGh8okBly2KQcutfSkKdT1lVmSp
         qPqbn3KAe/LcxFpiwiTAS66/+hJsWxywRXU7VzKugpWGm+i5Na7tbOP8oltwZx4p6Quk
         7xlKBDVaiGaMUYamH4TgaKHNe7qr+VMXnwFZcocjnLILpkLcZ0Q/qS0d0bZQbc5A5E9H
         WkC/6DI1sdwwgUyMTw6qETIB6dUOmCL9yS5yNlnEOoya+NqFQvC5dP6fXxU7EKDb9Q88
         m3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPc1R/og9Ir+04CfSDJxIvgAkJNVAC0c3KZrKXKoWzg=;
        b=BYGsMDiF14N9REGBoKWS/m/u++BSRLQ9qq9PnpsfQWce8gkD3LaVlCZ1Qigc0pQYTE
         9fLGVIjBntbYGosyoSBD/503tAMa0Mz9bvm4T4NWkqXY5pUkDyDTrJb+NmdwP95j1947
         sCrPpzn7ahffpYq0gxhalr7arWuZsSlVGjbDebYzZf1ntok5idSaHvpWrqGZcOWoCQfI
         fx/etkLFPBRD5jwx2L5rDbia7/M+m6JFcwXSDFxc4yQUyXpuUmq+7mJjgLTvZ/0Pc5Ma
         iBJYgiXKM9/abuUvWSgvrPGoHv14miUOAHAvILZCurw8C0afx5JM3pgTVXenKVf7kU5h
         Kk8Q==
X-Gm-Message-State: AOAM532jVFRy5Lg8gNaecEZFZKsBL7VoEExHrnAqxSTNKcoYZ89nUswv
        rK8K4Y09pU9JSv6wmRKceRw5lw==
X-Google-Smtp-Source: ABdhPJxduDFWZYw55mR6zACeXe5BRP+IR314xF0zucWIp6f/MuTvYFlD/fNqCRkBomnRimP0y6j7vg==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr21066277wrt.193.1591007005699;
        Mon, 01 Jun 2020 03:23:25 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b14sm2591090wmj.47.2020.06.01.03.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 03:23:25 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:23:23 +0100
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
Subject: Re: [PATCH v3 05/13] backlight: improve backlight_device
 documentation
Message-ID: <20200601102323.5wmnr7pj653zy3t5@holly.lan>
References: <20200601065207.492614-1-sam@ravnborg.org>
 <20200601065207.492614-6-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601065207.492614-6-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 01, 2020 at 08:51:59AM +0200, Sam Ravnborg wrote:
> Improve the documentation for backlight_device and
> adapt it to kernel-doc style.
> 
> v2:
>   - Add short intro to all fields (Daniel)
>   - Updated description of update_lock (Daniel)

I like the update... but it doesn't cover what I was commenting on.


> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 69a20da03035..cae1af95dd9d 100644
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

This explicitly says that drivers are permitted to use update_lock in
their get_brightness() method.


> - *
> - * Any other use of the locks below is probably wrong.
> - */
> -
>  enum backlight_update_reason {
>  	BACKLIGHT_UPDATE_HOTKEY,
>  	BACKLIGHT_UPDATE_SYSFS,
> @@ -215,30 +200,71 @@ struct backlight_properties {
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
> +	 * @props: Backlight properties
> +	 */
>  	struct backlight_properties props;
>  
> -	/* Serialise access to update_status method */
> +	/**
> +	 * @update_lock: The lock used when calling the update_status() operation.
> +	 *
> +	 * update_lock is an internal backlight lock that serialise access
> +	 * to the update_status() operation. The backlight core holds the update_lock
> +	 * when calling the update_status() operation. The update_lock shall not
> +	 * be used by backlight drivers.
> +	 */

This contradicts the original comment about locking.

I'm fairly neutral about the change (AFAICT no driver actually ever
uses update_lock from get_brightness) but if we add new documentation
that flatly contradicts old documentary comments then I'd expect to
see something in the patch description explaining that the change
really is deliberate (and why it is a good change).


Daniel.
