Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E975825D730
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Sep 2020 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgIDL1q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 07:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730218AbgIDL1j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Sep 2020 07:27:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BB2C061246
        for <linux-pwm@vger.kernel.org>; Fri,  4 Sep 2020 04:27:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so6402842wrm.2
        for <linux-pwm@vger.kernel.org>; Fri, 04 Sep 2020 04:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=erzVCkG6u4B8KH8TDdWQurkzlfyvvTZQMwD1DF4GTNA=;
        b=EMjTlfHuyvDcRxyjY9iQJUH7v3QH6uHOF5whif6JAm7KZKiX2+MN2Xdd8loS/OERcq
         sfxPHVS//O1wfzaQwir2aQY3LnpWzGmxXw9elj2ATmbC8eZzM3rYj/vOaVainYJtDOoZ
         n16B1RA9G6kM5vqHot0cK5z1wlMcL6zqw0hynHPOnGsHcfP1gNssyZSU15gHHyIxpfwT
         MWI3Suzlv7yndH/GhN8WFoZKZL+zaJAT2KDInBYJQCj1j6fwTZ53Lb0+AziTQqcGzJZN
         p8+vyeWjI4nOhRhqZZ/cq+IvZ3WAKqIdfLQos3a9DpmKcfIr/r+v5mrvqFqC/PcR6GWf
         pPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=erzVCkG6u4B8KH8TDdWQurkzlfyvvTZQMwD1DF4GTNA=;
        b=crO6oFw8c7Q7X03oJzZMFJPmse2VFyGgGgcj9HEP+cyzOFl85odSrRgixr3rivJL49
         dmX9I/pKXXBPo/p2N/jI2/oOioWmi3JGEkp9OJILmLtd/gag1j10jtus+Y5mtvakQiVF
         1KjNnzXPwKMMC6FtHj6U8r6cRL3cAVIfKvOJi8GSveNZR1BxV5/d65IsXJyL4Psuhwdn
         SG4J3s0XaKefNpFlquiL+pAHn5xCbyL0wzGrHy+SCJosFDh6ZrR1lxd96+op9TXvPWfe
         GzDrL1LUcxSK/5J+tO8YoXBAjlTw6n7Zt9NdVRKNJMjD7eqJ/i4cSEhzvIgiKrvYOnIj
         J3nA==
X-Gm-Message-State: AOAM533+06uPpAWGQxYZcWwWAEJjt4u3KxPJMHqiSeXJzogHqyXpqis9
        BjJ7GvMW0WRWl/Czr2dNK2r4jg==
X-Google-Smtp-Source: ABdhPJyrZ5pJE+dIVFGKrNJPZj3nIy0bgU/ZTsDc1WNBe8iYX+nzI/nCpe2pQKdaVOs04X6cacTeVA==
X-Received: by 2002:a5d:6852:: with SMTP id o18mr7062275wrw.113.1599218855784;
        Fri, 04 Sep 2020 04:27:35 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id 124sm10860162wmd.31.2020.09.04.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:27:34 -0700 (PDT)
Date:   Fri, 4 Sep 2020 12:27:32 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Stan <amstan@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/3] backlight: pwm_bl: Fix interpolation
Message-ID: <20200904112732.zdfzmjgpcds3jpzo@holly.lan>
References: <20200721042522.2403410-1-amstan@chromium.org>
 <20200720212502.1.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720212502.1.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 20, 2020 at 09:25:20PM -0700, Alexandru Stan wrote:
> Whenever num-interpolated-steps was larger than the distance
> between 2 consecutive brightness levels the table would get really
> discontinuous. The slope of the interpolation would stick with
> integers only and if it was 0 the whole line segment would get skipped.
> 
> Example settings:
> 	brightness-levels = <0 1 2 4 8 16 32 64 128 256>;
> 	num-interpolated-steps = <16>;
> 
> The distances between 1 2 4 and 8 would be 1, and only starting with 16
> it would start to interpolate properly.
> 
> Let's change it so there's always interpolation happening, even if
> there's no enough points available (read: values in the table would
> appear more than once). This should match the expected behavior much
> more closely.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Alexandru Stan <amstan@chromium.org>

Apologies for the delay. Patch 2/3 meant I had some thinking to do...
and then the holiday's took their toll.

Overall this looks good, just some quibbles about broken 64-bit maths.


> ---
> 
>  drivers/video/backlight/pwm_bl.c | 70 ++++++++++++++------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 82b8d7594701..5193a72305a2 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -235,8 +235,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  				  struct platform_pwm_backlight_data *data)
>  {
>  	struct device_node *node = dev->of_node;
> -	unsigned int num_levels = 0;
> -	unsigned int levels_count;
> +	unsigned int num_levels;
>  	unsigned int num_steps = 0;
>  	struct property *prop;
>  	unsigned int *table;
> @@ -265,12 +264,11 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  	if (!prop)
>  		return 0;
>  
> -	data->max_brightness = length / sizeof(u32);
> +	num_levels = length / sizeof(u32);
>  
>  	/* read brightness levels from DT property */
> -	if (data->max_brightness > 0) {
> -		size_t size = sizeof(*data->levels) * data->max_brightness;
> -		unsigned int i, j, n = 0;
> +	if (num_levels > 0) {
> +		size_t size = sizeof(*data->levels) * num_levels;
>  
>  		data->levels = devm_kzalloc(dev, size, GFP_KERNEL);
>  		if (!data->levels)
> @@ -278,7 +276,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  
>  		ret = of_property_read_u32_array(node, "brightness-levels",
>  						 data->levels,
> -						 data->max_brightness);
> +						 num_levels);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -303,7 +301,13 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  		 * between two points.
>  		 */
>  		if (num_steps) {
> -			if (data->max_brightness < 2) {
> +			unsigned int num_input_levels = num_levels;
> +			unsigned int i;
> +			u32 x1, x2, x;
> +			u32 y1, y2;
> +			s64 dx, dy;

dx should be 32-bit. It will be truncated to 32-bit when passed to
div_s64() so this type is actively misleading about how the maths
works.


> +
> +			if (num_input_levels < 2) {
>  				dev_err(dev, "can't interpolate\n");
>  				return -EINVAL;
>  			}
> @@ -313,14 +317,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  			 * taking in consideration the number of interpolated
>  			 * steps between two levels.
>  			 */
> -			for (i = 0; i < data->max_brightness - 1; i++) {
> -				if ((data->levels[i + 1] - data->levels[i]) /
> -				   num_steps)
> -					num_levels += num_steps;
> -				else
> -					num_levels++;
> -			}
> -			num_levels++;
> +			num_levels = (num_input_levels - 1) * num_steps + 1;
>  			dev_dbg(dev, "new number of brightness levels: %d\n",
>  				num_levels);
>  
> @@ -332,24 +329,25 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  			table = devm_kzalloc(dev, size, GFP_KERNEL);
>  			if (!table)
>  				return -ENOMEM;
> -
> -			/* Fill the interpolated table. */
> -			levels_count = 0;
> -			for (i = 0; i < data->max_brightness - 1; i++) {
> -				value = data->levels[i];
> -				n = (data->levels[i + 1] - value) / num_steps;
> -				if (n > 0) {
> -					for (j = 0; j < num_steps; j++) {
> -						table[levels_count] = value;
> -						value += n;
> -						levels_count++;
> -					}
> -				} else {
> -					table[levels_count] = data->levels[i];
> -					levels_count++;
> +			/*
> +			 * Fill the interpolated table[x] = y
> +			 * by draw lines between each (x1, y1) to (x2, y2).
> +			 */
> +			dx = num_steps;
> +			for (i = 0; i < num_input_levels - 1; i++) {
> +				x1 = i * dx;
> +				x2 = x1 + dx;
> +				y1 = data->levels[i];
> +				y2 = data->levels[i + 1];
> +				dy = y2 - y1;

This is an u32 expression being assigned to a s64. I could be rusty on
my fixed point maths but won't this promote too late for the 64-bitness
of dy to be useful?


Daniel.

> +
> +				for (x = x1; x < x2; x++) {
> +					table[x] = y1 +
> +						div_s64(dy * (x - x1), dx);
>  				}
>  			}
> -			table[levels_count] = data->levels[i];
> +			/* Fill in the last point, since no line starts here. */
> +			table[x2] = y2;
>  
>  			/*
>  			 * As we use interpolation lets remove current
> @@ -358,15 +356,9 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  			 */
>  			devm_kfree(dev, data->levels);
>  			data->levels = table;
> -
> -			/*
> -			 * Reassign max_brightness value to the new total number
> -			 * of brightness levels.
> -			 */
> -			data->max_brightness = num_levels;
>  		}
>  
> -		data->max_brightness--;
> +		data->max_brightness = num_levels - 1;
>  	}
>  
>  	return 0;
> -- 
> 2.27.0
