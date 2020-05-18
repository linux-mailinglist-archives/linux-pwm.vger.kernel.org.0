Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5371D7F55
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgERQ4y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 12:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgERQ4x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 12:56:53 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97F6C061A0C
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:56:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l18so12716731wrn.6
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MI77nvduHcUEFR5h39BzcKEVaiC5rMh/0ylmJoyI1Vs=;
        b=VZWgVl1KvLlwIX3XrdZCLQKZkHIivxsfSRdtvNdwsNHbcFWc6qkNFzGAeOfVdkNGrB
         gBTfikOmQSYAmSgWGrNmf8zRL2dRv6gxWDmFkamshug52waAMtbKNUVit0mPUztiO/T1
         Z1q2ICpInHqTjREWBgA3ftowAVaBHv+Y0nuyfMeXxMMdV936xkeJrQ/W1Glq3M+ycr9v
         DW9yMc993zWeKmuhy/+KPCe/vS9+nEtpKrj7lIBnN30QTMJxZwtVpIelAepMmxdklyod
         6Zpt5t9HANOq56zupfI2xqR1byQevmWR74fEZH3TynfwILGrXcIhzS5D8cumOAjEWSL2
         A6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MI77nvduHcUEFR5h39BzcKEVaiC5rMh/0ylmJoyI1Vs=;
        b=TcUIQsuNK6AnBchPz7BeKZg4N92G30F9rPkhKvAIq6xv3PS/8M3C8jN44hAeVfbWOI
         sUrykNhmJuo/JIJJXhOdcGXA1Kv7vV2nzHQYhiCZJf3avAbLong9TT+ueMO75vxNKewh
         hSSZFnZR+4DxRYt7x7pp2y5aEFMEFuOJjK1EmS9zuhu4MZvHOfbEkotrT88P/41J8BPU
         tRz8mXFcksBJUtm3woAEnJZHJWtZIEda8/3IwzPZTU1hXcWZlwfJx9UYNYOYnx4zgzOO
         KZJx7S3zwZCbvIIX++xoRCkpgLvJEAdhVjZ/cM4cSta/60T+k0PoRejhbtuockqSEsjY
         yKdg==
X-Gm-Message-State: AOAM531/ZTijZBIn/93CmHMdR0W+Ycne8lh9ERfr/uUmfgrvFNKpKq5E
        3Ibd1wD+eff8bdaCQqdgtKj1uQ==
X-Google-Smtp-Source: ABdhPJwsLOgKVS1hifBRbXRWcQPAiQ+mQn9zlFvWVEvr1FCeXG5OKvyMJpSPopHmvFfle26BUkevGw==
X-Received: by 2002:adf:e688:: with SMTP id r8mr20448984wrm.274.1589821011478;
        Mon, 18 May 2020 09:56:51 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c140sm213453wmd.18.2020.05.18.09.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:56:50 -0700 (PDT)
Date:   Mon, 18 May 2020 17:56:48 +0100
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
Subject: Re: [PATCH v2 15/16] backlight: make of_find_backlight_by_node()
 static
Message-ID: <20200518165648.ltgtofjsteyyse4j@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-16-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-16-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:01:38PM +0200, Sam Ravnborg wrote:
> There are no external users of of_find_backlight_by_node().
> Make it static so we keep it that way.
> 
> v2:
>   - drop EXPORT of of_find_backlight_by_node
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Assuming the 0day-ci comments are because some of the patches have
already been sucked up in a different tree then:

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> ---
>  drivers/video/backlight/backlight.c | 23 +++++++++--------------
>  include/linux/backlight.h           | 10 ----------
>  2 files changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 7f3eecaf8317..3fa29330a820 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -627,19 +627,9 @@ static int of_parent_match(struct device *dev, const void *data)
>  	return dev->parent && dev->parent->of_node == data;
>  }
>  
> -/**
> - * of_find_backlight_by_node() - find backlight device by device-tree node
> - * @node: device-tree node of the backlight device
> - *
> - * Returns a pointer to the backlight device corresponding to the given DT
> - * node or NULL if no such backlight device exists or if the device hasn't
> - * been probed yet.
> - *
> - * This function obtains a reference on the backlight device and it is the
> - * caller's responsibility to drop the reference by calling put_device() on
> - * the backlight device's .dev field.
> - */
> -struct backlight_device *of_find_backlight_by_node(struct device_node *node)
> +/* Find backlight device by device-tree node */
> +static struct backlight_device *
> +of_find_backlight_by_node(struct device_node *node)
>  {
>  	struct device *dev;
>  
> @@ -647,7 +637,12 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
>  
>  	return dev ? to_backlight_device(dev) : NULL;
>  }
> -EXPORT_SYMBOL(of_find_backlight_by_node);
> +#else
> +static struct backlight_device *
> +of_find_backlight_by_node(struct device_node *node)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  static struct backlight_device *of_find_backlight(struct device *dev)
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index d92e523650ec..1e29ab43f4f6 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -473,16 +473,6 @@ static inline void * bl_get_data(struct backlight_device *bl_dev)
>  	return dev_get_drvdata(&bl_dev->dev);
>  }
>  
> -#ifdef CONFIG_OF
> -struct backlight_device *of_find_backlight_by_node(struct device_node *node);
> -#else
> -static inline struct backlight_device *
> -of_find_backlight_by_node(struct device_node *node)
> -{
> -	return NULL;
> -}
> -#endif
> -
>  #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
>  struct backlight_device *devm_of_find_backlight(struct device *dev);
>  #else
> -- 
> 2.25.1
> 
