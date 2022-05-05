Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D110B51CBCB
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 00:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245627AbiEEWEY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 May 2022 18:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiEEWEW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 May 2022 18:04:22 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3BF2D1F2;
        Thu,  5 May 2022 15:00:39 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n24so5727431oie.12;
        Thu, 05 May 2022 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cGqwZ+MurLuF+6+C7VAFY3bMj4Mfo5qjjgNeYm16yHQ=;
        b=ebi5F5iJN8bs6OKnKddbp99XnUnx5A9FzFpwOCk/4rAsfSkiJ/ggme+mOA0tTNr9Mu
         tnC0QeuXDnDfUPvLg/U0jgBQHL4CuPyTYUPtLvQEMjGJ0yb5yjB2hk5RVqBapyP0JH5t
         QUwQAn9ECic2SuF+mj6sImSRA9kvjL/NAXGiBJH/zeJPsZ+xRZ32Xqwzm7ARKgiwoyjW
         rN15AGha5WZVHmZ1Z8AAvUxd18Onx4fKmZ9GgR4XEZ3usaTdxcKhEkY4b6ouPe8XPGap
         8Mqciy00omljTf03N0j0og8AvIF1jfxd9eghB3AuiQ1PcYHGctjoznKo1qW7z/WliS9J
         pufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cGqwZ+MurLuF+6+C7VAFY3bMj4Mfo5qjjgNeYm16yHQ=;
        b=uq0R91NXIEllfq87nT6dtT/Jo2X3OzWTdlkTBYL97xmE2RGBGeQXd2ttDcEyFU5uSI
         nrUc3HU4Ak2SyarKI/QzfclzSQTLcXUO6OUWhfyAwt8x+5/w4DlNR7xb/1fJCE6vOAx8
         Lsswv5HqVaQlQbikj0F+TSxfsjdRMKM2x/UxnnCqKSw5eIYdL/Wvk7a7aozL5xhYe/6m
         zT0HZFFX+KlND++FPVM+udCCqniCd0f0Ay+sy9zFnHBNjFh3ov9Nw5+mv5KFb345i26W
         xQdcxXc8MylWjyyseLPqO4aOP2Cak58sHjaX1DgiRMVaAZOGRO+ba8bWpkimiMVtmYmQ
         UMXg==
X-Gm-Message-State: AOAM531MBTRce7vGwETPjJ3ztbQ7XEMctJ6EEJee9QrVWsa4Z2qqAK08
        PN7cT3kWE6u1rLS7EI0UAiA=
X-Google-Smtp-Source: ABdhPJxOFHZG0E5qacFRJs5SRVLmlf/+hkbzPBD9+UOKEq7oa+Si+tMp9WB6xOwSfIMSDjDAMcSDhQ==
X-Received: by 2002:a05:6808:2099:b0:326:6079:8229 with SMTP id s25-20020a056808209900b0032660798229mr146113oiw.197.1651788038916;
        Thu, 05 May 2022 15:00:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x47-20020a056830246f00b0060603221236sm1042734otr.6.2022.05.05.15.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:00:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 May 2022 15:00:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hwmon: pwm-fan: dynamically switch regulator
Message-ID: <20220505220037.GF1988936@roeck-us.net>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
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

On Wed, May 04, 2022 at 02:45:51PM +0200, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> A pwm value equal to zero is meant to switch off the pwm
> hence also switching off the fan. Currently the optional
> regulator is always on. When using this driver on boards
> with an inverted pwm signal polarity this can cause running
> the fan at maximum speed when setting pwm to zero.
> 

The appropriate solution in this case would be to tell the
software that the pwm is inverted. Turning off the regulator
in that situation is a bad idea since setting the pwm value to
1 would set it to almost full speed. That does not really make
sense.

Guenter

> The proposed changes switch the regulator off, when PWM is
> currently enabled but pwm is requested to set to zero
> and switch der regulator on, when PWM is currently disabled
> but pwm shall be set to a no zero value.
> 
> Add __set_pwm_and_regulator and rewrite __set_pwm to
> handle regulator switching for the following conditions:
> 
> - probe: pwm duty -> max, pwm state is unkwown: use __set_pwm
>   and enable regulator separately to keep the devm action
> - off: new pwm duty is zero, pwm currently enabled: disable
>   regulator
> - on: new pwm duty is non zero, pwm currently disabled: enable
>   regulator
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * Added my own missing S-o-b
> 
>  drivers/hwmon/pwm-fan.c | 144 ++++++++++++++++++++++++++--------------
>  1 file changed, 93 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index f12b9a28a232..b47d59fbe836 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -97,18 +97,50 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>  	unsigned long period;
>  	int ret = 0;
>  	struct pwm_state *state = &ctx->pwm_state;
> +	/* track changes of reg_en for error handling */
> +	enum regulator_change {
> +		untouched,
> +		enabled,
> +		disabled,
> +	} reg_change = untouched;
>  
>  	mutex_lock(&ctx->lock);
> +
>  	if (ctx->pwm_value == pwm)
>  		goto exit_set_pwm_err;
>  
> +	if (ctx->reg_en) {
> +		if (pwm && !state->enabled) {
> +			reg_change = enabled;
> +			ret = regulator_enable(ctx->reg_en);
> +		} else if (!pwm && state->enabled) {
> +			reg_change = disabled;
> +			ret = regulator_disable(ctx->reg_en);
> +		}
> +		if (ret)
> +			goto exit_set_pwm_err;
> +	}
> +
>  	period = state->period;
>  	state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
>  	state->enabled = pwm ? true : false;
>  
>  	ret = pwm_apply_state(ctx->pwm, state);
> -	if (!ret)
> +	if (!ret) {
>  		ctx->pwm_value = pwm;
> +	} else if (reg_change != untouched) {
> +		/*
> +		 * revert regulator changes to keep consistency between
> +		 * pwm and regulator
> +		 */
> +		int err;
> +
> +		if (reg_change == enabled)
> +			err = regulator_disable(ctx->reg_en);
> +		else if (reg_change == disabled)
> +			err = regulator_enable(ctx->reg_en);
> +	}
> +
>  exit_set_pwm_err:
>  	mutex_unlock(&ctx->lock);
>  	return ret;
> @@ -280,18 +312,50 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
>  	return 0;
>  }
>  
> -static void pwm_fan_regulator_disable(void *data)
> +/*
> + * disable fan and regulator
> + * if cleanup is true, disable pwm regardless of regulator disable result
> + * this makes the function dual use for unloading driver and suspend
> + */
> +
> +static int __pwm_fan_disable_or_cleanup(struct pwm_fan_ctx *ctx, bool cleanup)
>  {
> -	regulator_disable(data);
> +	int ret;
> +
> +	if (ctx->pwm_value) {
> +		/* keep ctx->pwm_state unmodified for pwm_fan_resume() */
> +		struct pwm_state state = ctx->pwm_state;
> +
> +		/* regulator is only enabled if pwm_value is not zero */
> +		if (ctx->pwm_value && ctx->reg_en) {
> +			ret = regulator_disable(ctx->reg_en);
> +			if (ret) {
> +				pr_err("Failed to disable fan supply: %d\n", ret);
> +				if (!cleanup)
> +					return ret;
> +			}
> +		}
> +
> +		state.duty_cycle = 0;
> +		state.enabled = false;
> +		ret = pwm_apply_state(ctx->pwm, &state);
> +	}
> +
> +	return ret;
>  }
>  
> -static void pwm_fan_pwm_disable(void *__ctx)
> +static void pwm_fan_cleanup(void *__ctx)
>  {
>  	struct pwm_fan_ctx *ctx = __ctx;
> -
> -	ctx->pwm_state.enabled = false;
> -	pwm_apply_state(ctx->pwm, &ctx->pwm_state);
>  	del_timer_sync(&ctx->rpm_timer);
> +	__pwm_fan_disable_or_cleanup(ctx, true);
> +}
> +
> +static int pwm_fan_disable(void *__ctx)
> +{
> +	struct pwm_fan_ctx *ctx = __ctx;
> +
> +	return __pwm_fan_disable_or_cleanup(ctx, false);
>  }
>  
>  static int pwm_fan_probe(struct platform_device *pdev)
> @@ -324,19 +388,14 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  			return PTR_ERR(ctx->reg_en);
>  
>  		ctx->reg_en = NULL;
> -	} else {
> -		ret = regulator_enable(ctx->reg_en);
> -		if (ret) {
> -			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> -			return ret;
> -		}
> -		ret = devm_add_action_or_reset(dev, pwm_fan_regulator_disable,
> -					       ctx->reg_en);
> -		if (ret)
> -			return ret;
>  	}
>  
>  	pwm_init_state(ctx->pwm, &ctx->pwm_state);
> +	/*
> +	 * Ensure the PWM is switched on (including the regulator),
> +	 * independently from any previous PWM state
> +	 */
> +	ctx->pwm_state.enabled = false;
>  
>  	/*
>  	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
> @@ -348,14 +407,17 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	/* Set duty cycle to maximum allowed and enable PWM output */
> +	/*
> +	 * Set duty cycle to maximum allowed and enable PWM output as well as
> +	 * the regulator. In case of error nothing is changed
> +	 */
>  	ret = __set_pwm(ctx, MAX_PWM);
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
> @@ -461,42 +523,22 @@ static int pwm_fan_probe(struct platform_device *pdev)
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
> -	if (ctx->reg_en) {
> -		ret = regulator_disable(ctx->reg_en);
> -		if (ret) {
> -			dev_err(dev, "Failed to disable fan supply: %d\n", ret);
> -			return ret;
> -		}
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
> +	int ret;
> +
> +	ret = pwm_fan_disable(ctx);
> +
> +	return ret;
>  }
>  
>  static int pwm_fan_resume(struct device *dev)
> @@ -504,6 +546,9 @@ static int pwm_fan_resume(struct device *dev)
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>  	int ret;
>  
> +	if (ctx->pwm_value == 0)
> +		return 0;
> +
>  	if (ctx->reg_en) {
>  		ret = regulator_enable(ctx->reg_en);
>  		if (ret) {
> @@ -512,9 +557,6 @@ static int pwm_fan_resume(struct device *dev)
>  		}
>  	}
>  
> -	if (ctx->pwm_value == 0)
> -		return 0;
> -
>  	return pwm_apply_state(ctx->pwm, &ctx->pwm_state);
>  }
>  #endif
> -- 
> 2.25.1
> 
