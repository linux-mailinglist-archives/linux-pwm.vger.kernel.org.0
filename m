Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA9C5A65D8
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Aug 2022 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiH3OBu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Aug 2022 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiH3OBm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Aug 2022 10:01:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD0E1AD9C;
        Tue, 30 Aug 2022 07:01:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so4915792pja.4;
        Tue, 30 Aug 2022 07:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=6MNWEmHa8eRGKEXKJCkeEjP3/DCIyAQRsF9u2znFLEk=;
        b=n9mM8XKvSuw11MN0++5hOMwoOu/fZkPCbxbDxRragvXv5IwB31EjT5qb/KpAuaIrgi
         ChlPAgWEHxdZlnSr83IggvspwpPa7+yzhdxg9HTV1qt9WbRSnk6upC15aPSL/yO8O+oZ
         xI/Pnr9MHtelsaC5WmUgZOHcXf1gG5l6gQ4whpPQhRy4WQ3MAqis/4rU0re3TTm2G/jb
         E5XiZDmZOeR4RPeMrVMvJtdR5O6pDCleEumoAHuCl+l+SyPDHwALIApfyl5v5eSbBdLB
         5DJcoF/bggLdXDb6bH6GEDk8k4IYWThWP+TFqROvvT1s08TRwLH7HIjyeYZW+GFRxF8S
         6Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=6MNWEmHa8eRGKEXKJCkeEjP3/DCIyAQRsF9u2znFLEk=;
        b=svrQlk5hmPa8oQEJ0MGiS8DdNiHlucttA+kT5lKAgpj+34qxWIoYRiRIKOjuDLUJNF
         VmbS98RNOy8YEOtbTAfTI4hSTu9bpUtVu+qFL/Z2i+8L7daN9I4YDgMFL1oqpUygO6NB
         BLKXf4ll2Xp0DtqxP9ZBtAvbOsXarK7L+tVXZQARmK4a8UqiN/DfhZy9lePOdR+W1Wpl
         iNlwkmmqv5a4NMg0pZLXoN/MJePCIss11locy/MT5mqAkEiYhs66WnthCyqPSfdL3AG5
         41YSTs4yS7bDgjdVKmZK2PLnR/hmUJ3f5e1q56c4XWp8jaYqMvZAfszAjhxXodsEIsNp
         KqTQ==
X-Gm-Message-State: ACgBeo1Aan/RNAXhoPFGOoewAw+owy9RrKBdtDygqixP9SQPkokzrxsG
        BehsNExxtdb1aTbtgFscE7s=
X-Google-Smtp-Source: AA6agR46qliSLzUX6ZK5ZNf3HOjNMs0eT3RzpbYtTSUNsFDi0CqnKVcp2bSzhGZFKHkSav7/IHpalQ==
X-Received: by 2002:a17:90b:1810:b0:1fd:b639:fd99 with SMTP id lw16-20020a17090b181000b001fdb639fd99mr13003941pjb.78.1661868099386;
        Tue, 30 Aug 2022 07:01:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e13-20020a65478d000000b004114cc062f0sm1627139pgs.65.2022.08.30.07.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 07:01:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Aug 2022 07:01:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v4 5/6] hwmon: pwm-fan: Switch regulator dynamically
Message-ID: <20220830140137.GA230531@roeck-us.net>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
 <20220523110513.407516-6-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523110513.407516-6-alexander.stein@ew.tq-group.com>
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

On Mon, May 23, 2022 at 01:05:12PM +0200, Alexander Stein wrote:
> This adds the enable attribute which is used to select if zero PWM duty
> means to switch off regulator and PWM or to keep them enabled but
> at inactive PWM output level.
> Depending on the select enable mode, turn off the regulator and PWM if
> the PWM duty is zero, or keep them enabled.
> This is especially important for fan using inverted PWM signal polarity.
> Having regulator supplied and PWM disabled, some PWM controllers provide
> the active, rather than inactive signal.
> 
> With this change the shutdown as well as suspend/resume paths require
> modifcations as well.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

This patch is too complex to review as diff. Please resend the series with
the changes requested so I can apply and review the result.

Thanks,
Guenter

> ---
>  Documentation/hwmon/pwm-fan.rst |  12 ++
>  drivers/hwmon/pwm-fan.c         | 213 +++++++++++++++++++++-----------
>  2 files changed, 154 insertions(+), 71 deletions(-)
> 
> diff --git a/Documentation/hwmon/pwm-fan.rst b/Documentation/hwmon/pwm-fan.rst
> index 82fe96742fee..f77998b204ef 100644
> --- a/Documentation/hwmon/pwm-fan.rst
> +++ b/Documentation/hwmon/pwm-fan.rst
> @@ -18,3 +18,15 @@ the hwmon's sysfs interface.
>  
>  The fan rotation speed returned via the optional 'fan1_input' is extrapolated
>  from the sampled interrupts from the tachometer signal within 1 second.
> +
> +The driver provides the following sensor accesses in sysfs:
> +
> +=============== ======= =======================================================
> +fan1_input	ro	fan tachometer speed in RPM
> +pwm1_enable	rw	keep enable mode, defines behaviour when pwm1=0
> +			0 -> disable pwm and regulator
> +			1 -> enable pwm; if pwm==0, disable pwm, keep regulator enabled
> +			2 -> enable pwm; if pwm==0, keep pwm and regulator enabled
> +			3 -> enable pwm; if pwm==0, disable pwm and regulator
> +pwm1		rw	relative speed (0-255), 255=max. speed.
> +=============== ======= =======================================================
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index fcc1b7b55a65..e5d4b3b1cc49 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -28,6 +28,13 @@ struct pwm_fan_tach {
>  	u8 pulses_per_revolution;
>  };
>  
> +enum pwm_fan_enable_mode {
> +	pwm_off_reg_off,
> +	pwm_disable_reg_enable,
> +	pwm_enable_reg_enable,
> +	pwm_disable_reg_disable,
> +};
> +
>  struct pwm_fan_ctx {
>  	struct device *dev;
>  
> @@ -35,6 +42,7 @@ struct pwm_fan_ctx {
>  	struct pwm_device *pwm;
>  	struct pwm_state pwm_state;
>  	struct regulator *reg_en;
> +	enum pwm_fan_enable_mode enable_mode;
>  	bool regulator_enabled;
>  	bool enabled;
>  
> @@ -86,6 +94,29 @@ static void sample_timer(struct timer_list *t)
>  	mod_timer(&ctx->rpm_timer, jiffies + HZ);
>  }
>  
> +static void pwm_fan_enable_mode_2_state(int enable_mode,
> +					struct pwm_state *state,
> +					bool *enable_regulator)
> +{
> +	switch (enable_mode) {
> +	case pwm_disable_reg_enable:
> +		/* disable pwm, keep regulator enabled */
> +		state->enabled = false;
> +		*enable_regulator = true;
> +		break;
> +	case pwm_enable_reg_enable:
> +		/* keep pwm and regulator enabled */
> +		state->enabled = true;
> +		*enable_regulator = true;
> +		break;
> +	case pwm_off_reg_off:
> +	case pwm_disable_reg_disable:
> +		/* disable pwm and regulator */
> +		state->enabled = false;
> +		*enable_regulator = false;
> +	}
> +}
> +
>  static int pwm_fan_switch_power(struct pwm_fan_ctx *ctx, bool on)
>  {
>  	int ret = 0;
> @@ -117,30 +148,46 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
>  	if (ctx->enabled)
>  		return 0;
>  
> +	ret = pwm_fan_switch_power(ctx, true);
> +	if (ret < 0) {
> +		dev_err(ctx->dev, "failed to enable power supply\n");
> +		return ret;
> +	}
> +
>  	state->enabled = true;
>  	ret = pwm_apply_state(ctx->pwm, state);
>  	if (ret) {
>  		dev_err(ctx->dev, "failed to enable PWM\n");
> -		goto err;
> +		goto disable_regulator;
>  	}
>  
>  	ctx->enabled = true;
>  
> -err:
> +	return 0;
> +
> +disable_regulator:
> +	pwm_fan_switch_power(ctx, false);
>  	return ret;
>  }
>  
>  static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
>  {
>  	struct pwm_state *state = &ctx->pwm_state;
> +	bool enable_regulator = false;
>  
>  	if (!ctx->enabled)
>  		return 0;
>  
> +	pwm_fan_enable_mode_2_state(ctx->enable_mode,
> +				    state,
> +				    &enable_regulator);
> +
>  	state->enabled = false;
>  	state->duty_cycle = 0;
>  	pwm_apply_state(ctx->pwm, state);
>  
> +	pwm_fan_switch_power(ctx, enable_regulator);
> +
>  	ctx->enabled = false;
>  
>  	return 0;
> @@ -153,6 +200,10 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>  	int ret = 0;
>  
>  	if (pwm > 0) {
> +		if (ctx->enable_mode == pwm_off_reg_off)
> +			/* pwm-fan hard disabled */
> +			return 0;
> +
>  		period = state->period;
>  		state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
>  		ret = pwm_apply_state(ctx->pwm, state);
> @@ -190,20 +241,76 @@ static void pwm_fan_update_state(struct pwm_fan_ctx *ctx, unsigned long pwm)
>  	ctx->pwm_fan_state = i;
>  }
>  
> +static int pwm_fan_update_enable(struct pwm_fan_ctx *ctx, long val)
> +{
> +	int ret = 0;
> +	int old_val;
> +
> +	mutex_lock(&ctx->lock);
> +
> +	if (ctx->enable_mode == val)
> +		goto out;
> +
> +	old_val = ctx->enable_mode;
> +	ctx->enable_mode = val;
> +
> +	if (val == 0) {
> +		/* Disable pwm-fan unconditionally */
> +		ret = __set_pwm(ctx, 0);
> +		if (ret)
> +			ctx->enable_mode = old_val;
> +		pwm_fan_update_state(ctx, 0);
> +	} else {
> +		/*
> +		 * Change PWM and/or regulator state if currently disabled
> +		 * Nothing to do if currently enabled
> +		 */
> +		if (!ctx->enabled) {
> +			struct pwm_state *state = &ctx->pwm_state;
> +			bool enable_regulator = false;
> +
> +			state->duty_cycle = 0;
> +			pwm_fan_enable_mode_2_state(val,
> +						    state,
> +						    &enable_regulator);
> +
> +			pwm_apply_state(ctx->pwm, state);
> +			pwm_fan_switch_power(ctx, enable_regulator);
> +			pwm_fan_update_state(ctx, 0);
> +		}
> +	}
> +out:
> +	mutex_unlock(&ctx->lock);
> +
> +	return ret;
> +}
> +
>  static int pwm_fan_write(struct device *dev, enum hwmon_sensor_types type,
>  			 u32 attr, int channel, long val)
>  {
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>  	int ret;
>  
> -	if (val < 0 || val > MAX_PWM)
> -		return -EINVAL;
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		if (val < 0 || val > MAX_PWM)
> +			return -EINVAL;
> +		ret = set_pwm(ctx, val);
> +		if (ret)
> +			return ret;
> +		pwm_fan_update_state(ctx, val);
> +		break;
> +	case hwmon_pwm_enable:
> +		if (val < 0 || val > 3)
> +			ret = -EINVAL;
> +		else
> +			ret = pwm_fan_update_enable(ctx, val);
>  
> -	ret = set_pwm(ctx, val);
> -	if (ret)
>  		return ret;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  
> -	pwm_fan_update_state(ctx, val);
>  	return 0;
>  }
>  
> @@ -214,9 +321,15 @@ static int pwm_fan_read(struct device *dev, enum hwmon_sensor_types type,
>  
>  	switch (type) {
>  	case hwmon_pwm:
> -		*val = ctx->pwm_value;
> -		return 0;
> -
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			*val = ctx->pwm_value;
> +			return 0;
> +		case hwmon_pwm_enable:
> +			*val = ctx->enable_mode;
> +			return 0;
> +		}
> +		return -EOPNOTSUPP;
>  	case hwmon_fan:
>  		*val = ctx->tachs[channel].rpm;
>  		return 0;
> @@ -345,20 +458,14 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
>  	return 0;
>  }
>  
> -static void pwm_fan_regulator_disable(void *data)
> -{
> -	struct pwm_fan_ctx *ctx = data;
> -
> -	pwm_fan_switch_power(ctx, false);
> -}
> -
> -static void pwm_fan_pwm_disable(void *__ctx)
> +static void pwm_fan_cleanup(void *__ctx)
>  {
>  	struct pwm_fan_ctx *ctx = __ctx;
>  
> -	ctx->pwm_state.enabled = false;
> -	pwm_apply_state(ctx->pwm, &ctx->pwm_state);
>  	del_timer_sync(&ctx->rpm_timer);
> +	/* Switch off everything */
> +	ctx->enable_mode = pwm_disable_reg_disable;
> +	pwm_fan_power_off(ctx);
>  }
>  
>  static int pwm_fan_probe(struct platform_device *pdev)
> @@ -392,16 +499,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  			return PTR_ERR(ctx->reg_en);
>  
>  		ctx->reg_en = NULL;
> -	} else {
> -		ret = pwm_fan_switch_power(ctx, true);
> -		if (ret) {
> -			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> -			return ret;
> -		}
> -		ret = devm_add_action_or_reset(dev, pwm_fan_regulator_disable,
> -					       ctx);
> -		if (ret)
> -			return ret;
>  	}
>  
>  	pwm_init_state(ctx->pwm, &ctx->pwm_state);
> @@ -416,14 +513,19 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	/* Set duty cycle to maximum allowed and enable PWM output */
> +	ctx->enable_mode = pwm_disable_reg_enable;
> +
> +	/*
> +	 * Set duty cycle to maximum allowed and enable PWM output as well as
> +	 * the regulator. In case of error nothing is changed
> +	 */
>  	ret = set_pwm(ctx, MAX_PWM);
>  	if (ret) {
>  		dev_err(dev, "Failed to configure PWM: %d\n", ret);
>  		return ret;
>  	}
>  	timer_setup(&ctx->rpm_timer, sample_timer, 0);
> -	ret = devm_add_action_or_reset(dev, pwm_fan_pwm_disable, ctx);
> +	ret = devm_add_action_or_reset(dev, pwm_fan_cleanup, ctx);
>  	if (ret)
>  		return ret;
>  
> @@ -455,7 +557,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	if (!channels)
>  		return -ENOMEM;
>  
> -	channels[0] = HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT);
> +	channels[0] = HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE);
>  
>  	for (i = 0; i < ctx->tach_count; i++) {
>  		struct pwm_fan_tach *tach = &ctx->tachs[i];
> @@ -529,57 +631,26 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int pwm_fan_disable(struct device *dev)
> -{
> -	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> -	int ret;
> -
> -	if (ctx->pwm_value) {
> -		/* keep ctx->pwm_state unmodified for pwm_fan_resume() */
> -		struct pwm_state state = ctx->pwm_state;
> -
> -		state.duty_cycle = 0;
> -		state.enabled = false;
> -		ret = pwm_apply_state(ctx->pwm, &state);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	ret = pwm_fan_switch_power(ctx, false);
> -	if (ret) {
> -		dev_err(dev, "Failed to disable fan supply: %d\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static void pwm_fan_shutdown(struct platform_device *pdev)
>  {
> -	pwm_fan_disable(&pdev->dev);
> +	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
> +
> +	pwm_fan_cleanup(ctx);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
>  static int pwm_fan_suspend(struct device *dev)
>  {
> -	return pwm_fan_disable(dev);
> +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> +
> +	return pwm_fan_power_off(ctx);
>  }
>  
>  static int pwm_fan_resume(struct device *dev)
>  {
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> -	int ret;
> -
> -	ret = pwm_fan_switch_power(ctx, true);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> -		return ret;
> -	}
> -
> -	if (ctx->pwm_value == 0)
> -		return 0;
>  
> -	return pwm_apply_state(ctx->pwm, &ctx->pwm_state);
> +	return set_pwm(ctx, ctx->pwm_value);
>  }
>  #endif
>  
