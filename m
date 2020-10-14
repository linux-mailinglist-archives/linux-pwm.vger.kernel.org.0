Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220F828DFCE
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Oct 2020 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgJNL0u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Oct 2020 07:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730587AbgJNL0u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Oct 2020 07:26:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D4C061755
        for <linux-pwm@vger.kernel.org>; Wed, 14 Oct 2020 04:26:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h7so3390546wre.4
        for <linux-pwm@vger.kernel.org>; Wed, 14 Oct 2020 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W1Xb3EWi6oK1/DaQpKgXiT3NvJEd5yovI30IklakN70=;
        b=GL3cQIAWf+VkmTeQG0gsRX2Df5rOkHjVJgrZqtAvyztHNcswl+uQuyzfuCGZ28KJkL
         YAVgHVyzwVNQnjrp/DnSi4KG5rjbY8W869ipmyC/6FFxwG69MB3cvEUntMDLrJfv61Hw
         IpruzSz+SkXcFjCOe6Xm/pUOha4tQ5ZpAuWK2gC43lYOrlBc4GC9zhTwC5ZV3nWapFoi
         Ieizbagbsy8em+AlXNhlaurWUvIxETXGz7dpGQxQtNVNgUoWpJIgAdli2zVdRjF80fir
         F/XuWKaYccCX4k+QWfqdZatva20JKp+pUz2zjHWuwyq2HrWYNg9h6DhmNy8Le/89diCc
         QHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W1Xb3EWi6oK1/DaQpKgXiT3NvJEd5yovI30IklakN70=;
        b=HHiX3rxHQvR/VAoLEbcg2P8GnFUfK/LlYarHrFijJONckiljYNUL9aGmJ6Ac6E/xAc
         6S66W0faMn5tCnhYxd+Dmhg7Mt961ag44B2RCOBm3LhrPoo/+LAC6NiqnC0/PmN3xNmD
         tc+qEuBqYRcvNEKRyK6SGCEBnApdHQfWb4C+1kkN2al0i2PYSgM7OK7q2ZIx0clO4J1O
         IAhf8omW9oav96qsyR1h+egaiM/lK5NQeD0X1dVdQqH/X1mb4MFZUQTcZQFswUOuudm1
         uuKXi5lLe4RbvL0dT3vag7grbdByMWPvGdjFl2A3qWIrdsiuYultgQFRDpJTo/74ZMFZ
         rL0Q==
X-Gm-Message-State: AOAM5334zIhF9ynf00xhVr6dqN+2FMT6xdCsl/T1MscCKBcQbsGOrY5P
        NRJey3V8dKs8aEQUVY9TBeBnnQ==
X-Google-Smtp-Source: ABdhPJxgbrMq6ekWxBaMVjFkqS5MobV4c/7LwKcL+o1Ew8C+9mI/Vc0Clz/IN3aydIhGSZtLH/UCfA==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr5235113wro.326.1602674806848;
        Wed, 14 Oct 2020 04:26:46 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f7sm4690901wrx.64.2020.10.14.04.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 04:26:45 -0700 (PDT)
Date:   Wed, 14 Oct 2020 12:26:43 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Stan <amstan@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] backlight: pwm_bl: Fix interpolation
Message-ID: <20201014112643.grd2x5jj33turihb@holly.lan>
References: <20201013080103.410133-1-amstan@chromium.org>
 <20201013010056.v2.1.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013010056.v2.1.I4dcea1c90e9da3902d466033aa73351e19e49c49@changeid>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Oct 13, 2020 at 01:01:01AM -0700, Alexandru Stan wrote:
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

Both comments a perilously close to nitpicking but enough that I wanted
to reply...

I'd suggest that the current behaviour as having two properties.

1. It was designed to generate strictly increasing tables (no repeated
   values).

2. It's implementation contains quantization errors when calculating the
   step size. This results in both the discards of some interpolated
   steps you mentioned (it is possible to insert extra steps between 4
   and 8 whilst retaining a strictly increasing table). It also
   results in a potentially large undershoot when multiplying a step
   size (64 interpolated steps and a gap of 127 is likely to get a visual
   jump as we hop through 63 physical steps in one go).

#1 can is a policy that can be changed. #2 is a bug that could be fixed.

To be clear I don't object to generating a monotonically increasing
table but I'd prefer the policy change to be explicitly described in
the description.


> Let's change it so there's always interpolation happening, even if
> there's no enough points available (read: values in the table would
> appear more than once). This should match the expected behavior much
> more closely.
> 
> Signed-off-by: Alexandru Stan <amstan@chromium.org>
> ---
> 
>  drivers/video/backlight/pwm_bl.c | 70 ++++++++++++++------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index dfc760830eb9..3e77f6b73fd9 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -230,8 +230,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  				  struct platform_pwm_backlight_data *data)
>  {
>  	struct device_node *node = dev->of_node;
> -	unsigned int num_levels = 0;
> -	unsigned int levels_count;
> +	unsigned int num_levels;
>  	unsigned int num_steps = 0;
>  	struct property *prop;
>  	unsigned int *table;
> @@ -260,12 +259,11 @@ static int pwm_backlight_parse_dt(struct device *dev,
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
> @@ -273,7 +271,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  
>  		ret = of_property_read_u32_array(node, "brightness-levels",
>  						 data->levels,
> -						 data->max_brightness);
> +						 num_levels);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -298,7 +296,13 @@ static int pwm_backlight_parse_dt(struct device *dev,
>  		 * between two points.
>  		 */
>  		if (num_steps) {
> -			if (data->max_brightness < 2) {
> +			unsigned int num_input_levels = num_levels;
> +			unsigned int i;
> +			u32 x1, x2, x, dx;
> +			u32 y1, y2;
> +			s64 dy;
> +
> +			if (num_input_levels < 2) {
>  				dev_err(dev, "can't interpolate\n");
>  				return -EINVAL;
>  			}
> @@ -308,14 +312,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
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
> @@ -327,24 +324,25 @@ static int pwm_backlight_parse_dt(struct device *dev,
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
> +				dy = (s64)y2 - y1;
> +
> +				for (x = x1; x < x2; x++) {
> +					table[x] = y1 +
> +						div_s64(dy * ((s64)x - x1), dx);

I don't think it is possible for x - x1 to be negative (e.g. what is the
s64 for). Obviously it makes little functional difference whether the
cast is there or not but I don't like fixed point code that has been
written with "just in case" casts.


Daniel.


>  				}
>  			}
> -			table[levels_count] = data->levels[i];
> +			/* Fill in the last point, since no line starts here. */
> +			table[x2] = y2;
>  
>  			/*
>  			 * As we use interpolation lets remove current
> @@ -353,15 +351,9 @@ static int pwm_backlight_parse_dt(struct device *dev,
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
> 2.28.0
> 
