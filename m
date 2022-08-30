Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86F85A65A9
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Aug 2022 15:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiH3Nx5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Aug 2022 09:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiH3NxZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Aug 2022 09:53:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF204BD0B;
        Tue, 30 Aug 2022 06:52:40 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b196so1046178pga.7;
        Tue, 30 Aug 2022 06:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=LsQvkkBwqpCPWPEpJm/sUipddksYBBUlHF82z+MFhDk=;
        b=CTfOxo58PZssr8GJaYNrQPOVxKsBbLNEQfQpK15POVXwnzfgGPQp1f2DoGs9VkdwHK
         1mLDkOXgrr+78qnFTV5F7eHzR0Vr7Jd6x98w2OOpZFEXr4tIW9YIF9bK816rh0htr1q8
         0AZtRr/0XZckr2o10BpAXMJ3sGyD6RTGeAj9wuE7Ihrx3y/CSjHnPi+6LqE8rS7ifj/T
         2UnQPRweZYUsvpFMoGXWqfsZwwsfwOKl0SF6+P5APqf/b+3js1hdwexAaePzlkNtqp1P
         BwGPCIDl0s7r2MWM0+WaWq0pnihOcjfBtz+mpbl2+6A4LFYiM0Mb0V6W5W5O9GVctK38
         TUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=LsQvkkBwqpCPWPEpJm/sUipddksYBBUlHF82z+MFhDk=;
        b=ZVlYCk6vgYDWtX2/3Ke13bT4DkFQFgPHlmMAFMlGPxe6VvRTM4TGpsqnXDKj+u3y+C
         wycTkxL4Z+XO0s7rlH8NDW4TQdHt/78ncsnpMAo4wwzTLlzP2u7UcdElKuof9OKc1C2O
         0FD9Bg4FAGHdLLIqeu0bxSRzoX01eaVrWHxhQ5gty1kkVtMU47xOH/uQjoM99rLS/caM
         /JeewNHAQ+K8HfDxVkYg1X2NE1CCt/oXiXe+SbEzpnODTxlDcApbGrlLBG69Tph2nLlq
         GXhNLG83H0k+c16I/AhR3k0flVZT710r27MHVp6FLe1vLYTCpCQ/7eBcL3TnzRZuLJ8k
         pQvw==
X-Gm-Message-State: ACgBeo1T6LEW9Ufm0dqbiz9uGnOjKs4priau+OK+5PEpcDKWhOoyZ1fg
        4ZVbF9327YfMqlxM7lHCRCI=
X-Google-Smtp-Source: AA6agR6oEAT8v5bnNX7uJgm6GV4N9PZra/C2qfdzpmIswlB8xLZGpu+Y52gGcp4KY3VSjlDnJOU33A==
X-Received: by 2002:a63:7d58:0:b0:42b:484c:979f with SMTP id m24-20020a637d58000000b0042b484c979fmr18284611pgn.7.1661867560255;
        Tue, 30 Aug 2022 06:52:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902d64b00b0016d88dc7745sm9561397plh.259.2022.08.30.06.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:52:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Aug 2022 06:52:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v4 4/6] hwmon: pwm-fan: split __set_pwm into
 locked/unlocked functions
Message-ID: <20220830135238.GA230167@roeck-us.net>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
 <20220523110513.407516-5-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523110513.407516-5-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 23, 2022 at 01:05:11PM +0200, Alexander Stein wrote:
> Regular calls to set_pwm don't hold the mutex, but the upcoming
> update_enable support needs to call set_pwm with the mutex being held.
> So provide the previous behavior in set_pwm (handling the lock), while
> adding __set_pwm which assumes the lock being held.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/pwm-fan.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 04af24268963..fcc1b7b55a65 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -152,14 +152,12 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>  	unsigned long period;
>  	int ret = 0;
>  
> -	mutex_lock(&ctx->lock);
> -
>  	if (pwm > 0) {
>  		period = state->period;
>  		state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
>  		ret = pwm_apply_state(ctx->pwm, state);
>  		if (ret)
> -			goto exit_set_pwm_err;
> +			return ret;
>  		ret = pwm_fan_power_on(ctx);
>  	} else {
>  		ret = pwm_fan_power_off(ctx);
> @@ -167,8 +165,17 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>  	if (!ret)
>  		ctx->pwm_value = pwm;
>  
> -exit_set_pwm_err:
> +	return ret;
> +}
> +
> +static int set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> +{
> +	int ret;
> +
> +	mutex_lock(&ctx->lock);
> +	ret = __set_pwm(ctx, pwm);
>  	mutex_unlock(&ctx->lock);
> +
>  	return ret;
>  }
>  
> @@ -192,7 +199,7 @@ static int pwm_fan_write(struct device *dev, enum hwmon_sensor_types type,
>  	if (val < 0 || val > MAX_PWM)
>  		return -EINVAL;
>  
> -	ret = __set_pwm(ctx, val);
> +	ret = set_pwm(ctx, val);
>  	if (ret)
>  		return ret;
>  
> @@ -280,7 +287,7 @@ pwm_fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
>  	if (state == ctx->pwm_fan_state)
>  		return 0;
>  
> -	ret = __set_pwm(ctx, ctx->pwm_fan_cooling_levels[state]);
> +	ret = set_pwm(ctx, ctx->pwm_fan_cooling_levels[state]);
>  	if (ret) {
>  		dev_err(&cdev->device, "Cannot set pwm!\n");
>  		return ret;
> @@ -400,7 +407,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	pwm_init_state(ctx->pwm, &ctx->pwm_state);
>  
>  	/*
> -	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
> +	 * set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
>  	 * long. Check this here to prevent the fan running at a too low
>  	 * frequency.
>  	 */
> @@ -410,7 +417,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Set duty cycle to maximum allowed and enable PWM output */
> -	ret = __set_pwm(ctx, MAX_PWM);
> +	ret = set_pwm(ctx, MAX_PWM);
>  	if (ret) {
>  		dev_err(dev, "Failed to configure PWM: %d\n", ret);
>  		return ret;
