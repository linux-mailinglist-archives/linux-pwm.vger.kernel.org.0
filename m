Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F151EBE1C
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jun 2020 16:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFBO2R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 10:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBO2R (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 10:28:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0BEC08C5C0;
        Tue,  2 Jun 2020 07:28:15 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p30so5137479pgl.11;
        Tue, 02 Jun 2020 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s2IOnX3zKkXIUT6wUoKoBXlyqx0Y+I+17VfSpIhvk84=;
        b=lMybFZ4lq31Vu+6iGZMhjnJdfelS+yMicHgS9k6rcFyDPcksw+cB0dMB4GMD5Rtzos
         z+RE+5kq7GhE/2LqSrle2ePeoLu/y6yEi9z0K+Wu8cNxxW+IFWiFwYR55S2ZUwOe+hYn
         ZKUCCWVyKgSOjPFcudx4Z6tl9nf4ucxnXZw8H0uD9TbNTFylXVeshDsf+vXafH9b825r
         deOUQ9Ph1GEuA7O8TuIbWhuYACyKpFjlfFvfmOKoMlh32u9F6v2+W90SCV5KGwzt3qtj
         g+qN8Z7zNdsLH6DLgTET56UExItKTKczu+Cs+GEIavBGETYXGztfwjtuOwTJAr9sUVG0
         3GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=s2IOnX3zKkXIUT6wUoKoBXlyqx0Y+I+17VfSpIhvk84=;
        b=BBY0lOLgGmpcM6e3r69lvlMm3o/7kHGR3/HsGUcmM8EzMs1Yvx0dvTbmD3bAOI50yF
         5d8x2Jul+1fwVco6pmpsJJ+4/NuC/JQFxOvAw3wWSyG3Dwrq/9DQV5tJLYA59bw0uLBv
         YjBroiHurgy8x1e+6P+pxrwMOiL11N0OVi37No31A8IE/nxvVcINWHODs2040dXsJsVf
         mR7/AWg7Bb4TaAyax8BlApcX1D36vSVEeEhDe2jH4eFuWlO5ZY1ClOnzSzJXXDFzCeDk
         uxeyV95mbN2Qh43lK8qoFf0M63fqXq5qRT9MCSeld43LH1r3JkXwKuKDMp9zj1EtzPWz
         6VBQ==
X-Gm-Message-State: AOAM530rjTuQNaLAp5zfjIRe3CyDcB8eLq9mDP1dRIkQ6j9Qz+NHMZa9
        hA5W2QsIHi+zVwwudYTttks=
X-Google-Smtp-Source: ABdhPJxnY5n/XEXbe6QNCKZgfgv/GfeUAJ7hPqaxvxWT3ckpmGAVELrBYpUF9lWr0W/v4lw+qIlctw==
X-Received: by 2002:a63:b95a:: with SMTP id v26mr24029030pgo.196.1591108095140;
        Tue, 02 Jun 2020 07:28:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2sm2562982pfj.142.2020.06.02.07.28.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 07:28:14 -0700 (PDT)
Date:   Tue, 2 Jun 2020 07:28:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     treding@nvidia.com, jonathanh@nvidia.com, kamil@wypas.org,
        jdelvare@suse.com, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de, bbasu@nvidia.com,
        bbiswas@nvidia.com, kyarlagadda@nvidia.com,
        linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] hwmon: pwm-fan: Add profile support and add
 remove module support
Message-ID: <20200602142813.GA54592@roeck-us.net>
References: <1590992354-12623-1-git-send-email-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590992354-12623-1-git-send-email-spatra@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 01, 2020 at 11:49:13AM +0530, Sandipan Patra wrote:
> Add support for profiles mode settings.
> This allows different fan settings for trip point temp/hyst/pwm.
> Tegra194 has multiple fan-profiles support.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>

The subject says "remove module support". What is this supposed to be
about ?

The code adds support for multiple cooling "profiles" but, unless I am
really missing something, no means to actually select a profile.
This adds a lot of complexity to the code with zero value.

Either case, and I may have mentioned this before, functionality like this
should really reside in the thermal core and not in individual drivers.

> ---
> 
> PATCH V2:
> 	Cleaned pwm_fan_remove support as it is not required.
> 
>  drivers/hwmon/pwm-fan.c | 92 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 80 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 30b7b3e..1d2a416 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -3,8 +3,10 @@
>   * pwm-fan.c - Hwmon driver for fans connected to PWM lines.
>   *
>   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2020, NVIDIA Corporation.
>   *
>   * Author: Kamil Debski <k.debski@samsung.com>
> + * Author: Sandipan Patra <spatra@nvidia.com>

You can not claim authorship for a driver by adding a few lines of code
to it.

>   */
>  
>  #include <linux/hwmon.h>
> @@ -21,6 +23,8 @@
>  #include <linux/timer.h>
>  
>  #define MAX_PWM 255
> +/* Based on OF max device tree node name length */
> +#define MAX_PROFILE_NAME_LENGTH	31
>  
>  struct pwm_fan_ctx {
>  	struct mutex lock;
> @@ -38,6 +42,12 @@ struct pwm_fan_ctx {
>  	unsigned int pwm_fan_state;
>  	unsigned int pwm_fan_max_state;
>  	unsigned int *pwm_fan_cooling_levels;
> +
> +	unsigned int pwm_fan_profiles;
> +	const char **fan_profile_names;
> +	unsigned int **fan_profile_cooling_levels;
> +	unsigned int fan_current_profile;
> +
>  	struct thermal_cooling_device *cdev;
>  };
>  
> @@ -227,28 +237,86 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
>  				       struct pwm_fan_ctx *ctx)
>  {
>  	struct device_node *np = dev->of_node;
> +	struct device_node *base_profile = NULL;
> +	struct device_node *profile_np = NULL;
> +	const char *default_profile = NULL;
>  	int num, i, ret;
>  
> -	if (!of_find_property(np, "cooling-levels", NULL))
> -		return 0;
> +	num = of_property_count_u32_elems(np, "cooling-levels");
> +	if (num <= 0) {
> +		base_profile = of_get_child_by_name(np, "profiles");

You can not just add new properties like this without documenting it
and getting approval by devicetree maintainers.

Guenter

> +		if (!base_profile) {
> +			dev_err(dev, "Wrong Data\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (base_profile) {
> +		ctx->pwm_fan_profiles =
> +			of_get_available_child_count(base_profile);
>  
> -	ret = of_property_count_u32_elems(np, "cooling-levels");
> -	if (ret <= 0) {
> -		dev_err(dev, "Wrong data!\n");
> -		return ret ? : -EINVAL;
> +		if (ctx->pwm_fan_profiles <= 0) {
> +			dev_err(dev, "Profiles used but not defined\n");
> +			return -EINVAL;
> +		}
> +
> +		ctx->fan_profile_names = devm_kzalloc(dev,
> +			sizeof(const char *) * ctx->pwm_fan_profiles,
> +							GFP_KERNEL);
> +		ctx->fan_profile_cooling_levels = devm_kzalloc(dev,
> +			sizeof(int *) * ctx->pwm_fan_profiles,
> +							GFP_KERNEL);
> +
> +		if (!ctx->fan_profile_names
> +				|| !ctx->fan_profile_cooling_levels)
> +			return -ENOMEM;
> +
> +		ctx->fan_current_profile = 0;
> +		i = 0;
> +		for_each_available_child_of_node(base_profile, profile_np) {
> +			num = of_property_count_u32_elems(profile_np,
> +							"cooling-levels");
> +			if (num <= 0) {
> +				dev_err(dev, "No data in cooling-levels inside profile node!\n");
> +				return -EINVAL;
> +			}
> +
> +			of_property_read_string(profile_np, "name",
> +						&ctx->fan_profile_names[i]);
> +			if (default_profile &&
> +				!strncmp(default_profile,
> +				ctx->fan_profile_names[i],
> +				MAX_PROFILE_NAME_LENGTH))
> +				ctx->fan_current_profile = i;
> +
> +			ctx->fan_profile_cooling_levels[i] =
> +				devm_kzalloc(dev, sizeof(int) * num,
> +							GFP_KERNEL);
> +			if (!ctx->fan_profile_cooling_levels[i])
> +				return -ENOMEM;
> +
> +			of_property_read_u32_array(profile_np, "cooling-levels",
> +				ctx->fan_profile_cooling_levels[i], num);
> +			i++;
> +		}
>  	}
>  
> -	num = ret;
>  	ctx->pwm_fan_cooling_levels = devm_kcalloc(dev, num, sizeof(u32),
>  						   GFP_KERNEL);
>  	if (!ctx->pwm_fan_cooling_levels)
>  		return -ENOMEM;
>  
> -	ret = of_property_read_u32_array(np, "cooling-levels",
> -					 ctx->pwm_fan_cooling_levels, num);
> -	if (ret) {
> -		dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
> -		return ret;
> +	if (base_profile) {
> +		memcpy(ctx->pwm_fan_cooling_levels,
> +		  ctx->fan_profile_cooling_levels[ctx->fan_current_profile],
> +						num);
> +	} else {
> +		ret = of_property_read_u32_array(np, "cooling-levels",
> +				ctx->pwm_fan_cooling_levels, num);
> +		if (ret) {
> +			dev_err(dev, "Property 'cooling-levels' cannot be read!\n");
> +			return -EINVAL;
> +		}
>  	}
>  
>  	for (i = 0; i < num; i++) {
