Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6541B1D7F3F
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2020 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgERQxz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 May 2020 12:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgERQxy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 May 2020 12:53:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60567C061A0C
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:53:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g14so426544wme.1
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2020 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JZljDjXdGvVcob0eXcjhvZ4PFqonlurPBCPzjrXqKZA=;
        b=hZzUaez0ovSogobBcHeVE3JqvDDeQMiT2oySUlSbDtmIyawYcpRbOxI8hmJl6s0c7y
         SMDE9ezNqr+N/9vHDKmKtscSIV3/46SmW1u6Vq++dUh+uhgOUuHX6Xj04Q3aVGrwaB5m
         iazdzARoDWGjOdFQArlRlraF18SoTNOim4fkNXz02bTpTJFWq05pigk2PHK4c1Y7ujnx
         l71NFbdDYj1OEGBd+ZaW3ES3Yxcyjj1cCXJf7RofcMVwCMaPoGKxjOXhIp3vvjlx8Pok
         5DsBbZ0E3vC9mwPJTNG/O57sHnsAYbhj+DxU62Dq0t1KXAYfdrvDIXb0PEw3ZP81v+7Y
         0ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JZljDjXdGvVcob0eXcjhvZ4PFqonlurPBCPzjrXqKZA=;
        b=kWKsr18q66IBrQqi6LZsyeWZNlIGYv8V9AH1JFYLV/dYjPQCSNDCLbA2S3s5Ndv3gi
         FxfqMi9yuBTRhs4ZvkOwCZJWRvk1nrsm9hDh9sfrmMYrqQc2Rv9RwARfAgGSl1Bx/XJB
         xecU1VNZ2m8WmJgDNVCrmsrd3KcHU1h+cmqTrRew9Fhw4OTjmRy4mZMCznT7s4nFWBM8
         75Ow7z7+U/wQtQ3fteESf+YqkZBaYK+MUyrip9e0lwefkjx4szCONZ1wJ7I+euJfLRmU
         ofUNHVGzeppVnpIJ4T95YY2+OH9iY6q1jKbwpqxZqrIT2wWRljRdkDyg9Z9SLUzv+Kfu
         fWSg==
X-Gm-Message-State: AOAM530MULpUoAgtUwILor53/ya9B4ZpH5PszITlZa41BUx2rMHP/ZrG
        VwQxz4P33g59wHdiTBeGqENAsg==
X-Google-Smtp-Source: ABdhPJwhRx8RRhwphNyGm2WHfgeB6JDjOUORJEh8rgps117/wjR+DQtjjESzr3UU9vVN/OuGBYL+hg==
X-Received: by 2002:a05:600c:147:: with SMTP id w7mr273163wmm.89.1589820833064;
        Mon, 18 May 2020 09:53:53 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id m23sm146314wmg.45.2020.05.18.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 09:53:52 -0700 (PDT)
Date:   Mon, 18 May 2020 17:53:50 +0100
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
Subject: Re: [PATCH v2 14/16] backlight: drop backlight_put()
Message-ID: <20200518165350.batfdp2tp4rvamzb@holly.lan>
References: <20200517190139.740249-1-sam@ravnborg.org>
 <20200517190139.740249-15-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517190139.740249-15-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, May 17, 2020 at 09:01:37PM +0200, Sam Ravnborg wrote:
> There are no external users of backlight_put().
> Drop it and open code the two users in backlight.c.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/backlight.c |  7 +++++--
>  include/linux/backlight.h           | 10 ----------
>  2 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index e23b09d03a65..7f3eecaf8317 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -679,7 +679,10 @@ static struct backlight_device *of_find_backlight(struct device *dev)
>  
>  static void devm_backlight_release(void *data)
>  {
> -	backlight_put(data);
> +	struct backlight_device *bd = data;
> +
> +	if (bd)
> +		put_device(&bd->dev);
>  }
>  
>  /**
> @@ -707,7 +710,7 @@ struct backlight_device *devm_of_find_backlight(struct device *dev)
>  		return bd;
>  	ret = devm_add_action(dev, devm_backlight_release, bd);
>  	if (ret) {
> -		backlight_put(bd);
> +		put_device(&bd->dev);
>  		return ERR_PTR(ret);
>  	}
>  	return bd;
> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 99e7cdace2be..d92e523650ec 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -415,16 +415,6 @@ static inline int backlight_disable(struct backlight_device *bd)
>  	return backlight_update_status(bd);
>  }
>  
> -/**
> - * backlight_put - Drop backlight reference
> - * @bd: the backlight device to put
> - */
> -static inline void backlight_put(struct backlight_device *bd)
> -{
> -	if (bd)
> -		put_device(&bd->dev);
> -}
> -
>  /**
>   * backlight_is_blank - Return true if display is expected to be blank
>   * @bd: the backlight device
> -- 
> 2.25.1
> 
