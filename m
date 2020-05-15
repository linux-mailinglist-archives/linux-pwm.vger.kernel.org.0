Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8C1D5ACE
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2020 22:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEOUm7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 May 2020 16:42:59 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:40020 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOUm6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 May 2020 16:42:58 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 61A66804E6;
        Fri, 15 May 2020 22:42:47 +0200 (CEST)
Date:   Fri, 15 May 2020 22:42:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Allison Randal <allison@lohutok.net>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Weigelt <info@metux.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Jyri Sarha <jsarha@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Russell King <linux@armlinux.org.uk>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>,
        Zheng Bin <zhengbin13@huawei.com>
Subject: Re: [PATCH v1 06/18] backlight: make of_find_backlight_by_node()
 static
Message-ID: <20200515204245.GA543522@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
 <20200514191001.457441-7-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514191001.457441-7-sam@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
        a=7mnRyIj4PDRz4dp46dkA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi myself and others.

On Thu, May 14, 2020 at 09:09:49PM +0200, Sam Ravnborg wrote:
> There are no external users of of_find_backlight_by_node().
> Make it static so we keep it that way.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---
>  drivers/video/backlight/backlight.c | 22 +++++++++-------------
>  include/linux/backlight.h           | 10 ----------
>  2 files changed, 9 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> index 547aa3e1a03a..91dfcf4a2087 100644
> --- a/drivers/video/backlight/backlight.c
> +++ b/drivers/video/backlight/backlight.c
> @@ -577,19 +577,9 @@ static int of_parent_match(struct device *dev, const void *data)
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
> @@ -598,6 +588,12 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
>  	return dev ? to_backlight_device(dev) : NULL;
>  }
>  EXPORT_SYMBOL(of_find_backlight_by_node);
Dropped this EXPORT in v2.

	Sam

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
> index 3d757a850b88..b7839ea9d00a 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -198,16 +198,6 @@ struct generic_bl_info {
>  	void (*kick_battery)(void);
>  };
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
