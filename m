Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322383CD3C1
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Jul 2021 13:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhGSKms (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 19 Jul 2021 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbhGSKlb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 19 Jul 2021 06:41:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E83CC061762
        for <linux-pwm@vger.kernel.org>; Mon, 19 Jul 2021 03:32:53 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r11so21555417wro.9
        for <linux-pwm@vger.kernel.org>; Mon, 19 Jul 2021 04:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=19Ti1NA8xVHCqT+B8GYPMXpjdTLfZFTkg7dVmDYiAEs=;
        b=jAyCwfKi2yqyRkfxA82+bQyCTExzPurK7LDyypufme3eSHYHBzPBWBBBnUzo9GBfRs
         NJ3jnlfG8TJxNXEc/L4SnQfF9D7h7uBmkJLc1cdMiJ7RbSW4WKDeZpSy9zsDkUjHxqmb
         8nrIEwuTsY4HuqFcbixvcihqEuKWBMazj63bwpma3KAtWLMewuGZZJq2u4pH2tQaznkh
         nJiP/BSTiYrXkBeS5bWQcjpr5T8xEePeNmxEmxVEpmqHWjOFynRLzTAQMTrsBNumWF9g
         6iAReWVOaKoSOJpTMYTewADer5Nk0IgOlnR1I+sw76QkwhtfZzvMNtas7DZebVVSdYNo
         QzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=19Ti1NA8xVHCqT+B8GYPMXpjdTLfZFTkg7dVmDYiAEs=;
        b=cUcfouzTjWM13wUn6g8RST3Y69O0niIsPHUMYzYCHX+p6YFXkMpZJtalbOvijELwIa
         HU/lmnNoMELmTHHBWQnDc2tTu5b2/eILXI/spMF/LSJv4oNdwn+umK/03uJnkizXlNTk
         I/8F5I7k+Y7F5IspSiE/ZA9B8fcJ+U4maRRCbYgQjnmXE19gy6Ul2Xsw4+UY/3qAauw4
         tgXGJGEMgLtVxTUE/CnK4rYjj0BSUmGHmNf/aK8H2MLTW15jXJHTEpLWsBzp7Fusqah9
         LvU+KjpotSzUE43yWamWp4zNhwFKTUU2uNYV/NyQeHxgFDQgmC7V/vQ85zNra95QpZhd
         /KRA==
X-Gm-Message-State: AOAM531LBle44ypp4EMSUM6353qsUBS4eg0dJFYSvteJCX9HdsuM+zjn
        GlAndT4oaYLiPox2tF2DqAbWng==
X-Google-Smtp-Source: ABdhPJx1HmRU4Pb7pJdzPw2qozjXr9k8BAezOmNqwPaNbmc9C7dUNiBMx3ODTUPKpcXItKDcBZArEg==
X-Received: by 2002:a05:6000:1867:: with SMTP id d7mr29237501wri.199.1626693725475;
        Mon, 19 Jul 2021 04:22:05 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id d67sm20703707wmd.9.2021.07.19.04.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 04:22:04 -0700 (PDT)
Date:   Mon, 19 Jul 2021 12:22:02 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marek Vasut <marex@denx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Avoid backlight flicker if backlight
 control GPIO is input
Message-ID: <20210719112202.4fvmn57ibgy3yesa@maple.lan>
References: <20210718211415.143709-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718211415.143709-1-marex@denx.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jul 18, 2021 at 11:14:15PM +0200, Marek Vasut wrote:
> If the backlight enable GPIO is configured as input, the driver currently
> unconditionally forces the GPIO to output-enable. This can cause backlight
> flicker on boot e.g. in case the GPIO should not be enabled before the PWM
> is configured and is correctly pulled low by external resistor.
> 
> Fix this by extending the current check to differentiate between backlight
> GPIO enable set as input and set as direction unknown. In case of input,
> read the GPIO value to determine the pull resistor placement, set the GPIO
> as output, and drive that exact value it was pulled to. In case of unknown
> direction, retain previous behavior, that is set the GPIO as output-enable.
> 
> Fixes: 3698d7e7d221 ("backlight: pwm_bl: Avoid backlight flicker when probed from DT")
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: linux-pwm@vger.kernel.org
> Cc: linux-fbdev@vger.kernel.org
> To: dri-devel@lists.freedesktop.org
> ---
> NOTE: I think this whole auto-detection scheme should just be replaced by a
>       DT prop, because it is very fragile.

I have some sympathy for this view... although I think the boat has
already set sail.

However, on the basis of making things less fragile, I think the
underlying problem here is the assumption that it is safe to modify
enable_gpio before the driver has imposed state upon the PWM (this
assumption has always been made and, in addition to systems where the BL
has a phandle will also risks flicker problems on systems where
power_pwm_on_delay is not zero).

This patch does not change the assumption that we can configure the
GPIO before we modify the PWM state. This means it won't fix the problem
for cases there the pin is HiZ by default but whose GPIOD_ASIS state is
neither input nor output.

I wonder if it might be better to move the code to configure the
direction of enable_gpio out of the probe function and into
pwm_backlight_power_on():

	if (pb->enable_gpio) {
		if (gpiod_get_direction(pb->enable_gpio) != 0))
			gpiod_direction_output(pb->enable_gpio, 1);
		else
			gpiod_set_value_can_sleep(pb->enable_gpio, 1);
	}

By the time we reach this function the driver explicitly applies state
to the GPIO then we know what the value must be.


Daniel.

> ---
>  drivers/video/backlight/pwm_bl.c | 35 +++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index e48fded3e414..7ec992b722eb 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -445,7 +445,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	struct device_node *node = pdev->dev.of_node;
>  	struct pwm_bl_data *pb;
>  	struct pwm_state state;
> -	unsigned int i;
> +	unsigned int i, dir, val;
>  	int ret;
>  
>  	if (!data) {
> @@ -487,16 +487,31 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	}
>  
>  	/*
> -	 * If the GPIO is not known to be already configured as output, that
> -	 * is, if gpiod_get_direction returns either 1 or -EINVAL, change the
> -	 * direction to output and set the GPIO as active.
> -	 * Do not force the GPIO to active when it was already output as it
> -	 * could cause backlight flickering or we would enable the backlight too
> -	 * early. Leave the decision of the initial backlight state for later.
> +	 * If the GPIO is not known to be already configured as output, then:
> +	 * - if the GPIO direction is input, read its current value to find out
> +	 *   whether the pin is pulled high or low (it is backlight control, so
> +	 *   it cannot be floating), change the direction to output and set the
> +	 *   GPIO such that it drives this strapped value.
> +	 *   Do not force the GPIO to state which is different than that to
> +	 *   which the GPIO was pulled to, this could cause backlight flicker
> +	 *   on boot e.g. in case the PWM is not ready yet.
> +	 * - if the GPIO direction is unknown, tahat is, if gpiod_get_direction
> +	 *   returns -EINVAL, change the direction to output and set the GPIO
> +	 *   as active.
> +	 *   Do not force the GPIO to active when it was already output as it
> +	 *   could cause backlight flickering or we would enable the backlight
> +	 *   too early. Leave the decision of the initial backlight state for
> +	 *   later.
>  	 */
> -	if (pb->enable_gpio &&
> -	    gpiod_get_direction(pb->enable_gpio) != 0)
> -		gpiod_direction_output(pb->enable_gpio, 1);
> +	if (pb->enable_gpio) {
> +		dir = gpiod_get_direction(pb->enable_gpio);
> +		if (dir != 0) {
> +			val = 1;
> +			if (dir == 1)
> +				val = gpiod_get_value_cansleep(pb->enable_gpio);
> +			gpiod_direction_output(pb->enable_gpio, val);
> +		}
> +	}
>  
>  	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
>  	if (IS_ERR(pb->power_supply)) {
> -- 
> 2.30.2
> 
