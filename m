Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAD05A6562
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Aug 2022 15:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiH3Nqx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Aug 2022 09:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiH3Nqh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Aug 2022 09:46:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0B69FFF;
        Tue, 30 Aug 2022 06:44:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r69so10730693pgr.2;
        Tue, 30 Aug 2022 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=oCIsO1zFT4sNPk8m8B+Y1915JA7j6F66jpDd4LMEBNc=;
        b=B0WUu+7s/IbVAd1BajljB7nhL1wUf1JBA0digbBAUjslG4CBU689m9a18EQ5PTyfvK
         tgvrlWC99lnFu29EWXrDZ00jSX0C/VKx+qSYbKf61XrDJCJeW6mS5eeqWdf290PlS8mx
         08/B4tJNISSUAtQgecR3LjERv/XAwNGC7gEfsK1rwebBOES3HaD1cFr1z6/TyGkFGcOa
         EDgGrhm+UBBGQLxz5eyDHdqGhsFx33aQcQXYEepiad/Jo/TRfU+X8fxbMVNsvKjzMTHY
         GbjYkqpygjRSREwulzY7INyEnYCdRxsFuATsmFpYhE5elkTaLwFOtv2QiWHCxgzIi3lW
         IK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=oCIsO1zFT4sNPk8m8B+Y1915JA7j6F66jpDd4LMEBNc=;
        b=TcnGmWqYjgY7C1If1t/WoRCB8UKz/OmqDGlLaScBwcFKzh+u45AeNzDyM2IMol4cbp
         aZTTSXJ4s+mDGXmW2hniMbgM2Gf5RDTC4foBxzKr/JeYciYxAnZFkNCsVQAX+seEZB+o
         ah/U6aAzU7IdeCZz1ZA6Fwc4761nen8YhDhFSIlE4voIKNY8Cl3hHwHJpgtTl1Rs00D9
         ywWgJyCrMTdi1vxFWXq+izdHYsYregRpPy1aDkbjnlg5sBMRFzDHWmmdssHeOvWBrRBJ
         c3sWZbjvdbnSHebv5sH8RV82sVcZBkWVAs0QYp/5ElsYxXZaHRfxOlrRVuTZMXWZlR0g
         E23Q==
X-Gm-Message-State: ACgBeo3AqCjweWEWsFNUX1rea/khFxpo2vPEyuXHaQ6ZdZatJ83g9qpO
        q6nPh9NP4+stwPWGYRoJBbE=
X-Google-Smtp-Source: AA6agR5do7cF7DM4AFdTv6G/KWcF9SU+bRxVm07kTk0R1DZgTuwgKzCfwUMjjhlHxIhwMKXgac7QmA==
X-Received: by 2002:a63:8243:0:b0:42b:1d94:3c66 with SMTP id w64-20020a638243000000b0042b1d943c66mr18339319pgd.278.1661867020255;
        Tue, 30 Aug 2022 06:43:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79f98000000b00537f9e32b00sm6898584pfr.37.2022.08.30.06.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:43:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Aug 2022 06:43:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v4 2/6] hwmon: pwm-fan: Simplify enable/disable check
Message-ID: <20220830134338.GA229551@roeck-us.net>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
 <20220523110513.407516-3-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523110513.407516-3-alexander.stein@ew.tq-group.com>
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

On Mon, May 23, 2022 at 01:05:09PM +0200, Alexander Stein wrote:
> Instead of comparing the current to the new pwm duty to decide whether to
> enable the PWM, use a dedicated flag. Also apply the new PWM duty in any
> case. This is a preparation to enable/disable the regulator dynamically.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/hwmon/pwm-fan.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 831878daffe6..96b10d422828 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -29,10 +29,13 @@ struct pwm_fan_tach {
>  };
>  
>  struct pwm_fan_ctx {
> +	struct device *dev;
> +
>  	struct mutex lock;
>  	struct pwm_device *pwm;
>  	struct pwm_state pwm_state;
>  	struct regulator *reg_en;
> +	bool enabled;
>  
>  	int tach_count;
>  	struct pwm_fan_tach *tachs;
> @@ -85,14 +88,21 @@ static void sample_timer(struct timer_list *t)
>  static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
>  {
>  	struct pwm_state *state = &ctx->pwm_state;
> -	unsigned long period;
>  	int ret;
>  
> -	period = state->period;
> -	state->duty_cycle = DIV_ROUND_UP(ctx->pwm_value * (period - 1), MAX_PWM);
> +	if (ctx->enabled)
> +		return 0;
> +
>  	state->enabled = true;
>  	ret = pwm_apply_state(ctx->pwm, state);
> +	if (ret) {
> +		dev_err(ctx->dev, "failed to enable PWM\n");
> +		goto err;

There is no reason for this goto. Just return directly.

> +	}
>  
> +	ctx->enabled = true;
> +
> +err:
>  	return ret;
>  }
>  
> @@ -100,26 +110,36 @@ static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
>  {
>  	struct pwm_state *state = &ctx->pwm_state;
>  
> +	if (!ctx->enabled)
> +		return 0;
> +

ctx->enabled will initially be false. How is it known that pwm is
disabled when the driver is loaded ? At the very least that warrants
an explanation.

>  	state->enabled = false;
>  	state->duty_cycle = 0;
>  	pwm_apply_state(ctx->pwm, state);

This code is a bit inconsistent with pwm_fan_power_on(). Why check for
error there, but not here ?

>  
> +	ctx->enabled = false;
> +
>  	return 0;
>  }
>  
>  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>  {
> +	struct pwm_state *state = &ctx->pwm_state;
> +	unsigned long period;
>  	int ret = 0;
>  
>  	mutex_lock(&ctx->lock);
> -	if (ctx->pwm_value == pwm)
> -		goto exit_set_pwm_err;
>  
> -	if (pwm > 0)
> +	if (pwm > 0) {
> +		period = state->period;
> +		state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
> +		ret = pwm_apply_state(ctx->pwm, state);
> +		if (ret)
> +			goto exit_set_pwm_err;
>  		ret = pwm_fan_power_on(ctx);
> -	else
> +	} else {
>  		ret = pwm_fan_power_off(ctx);
> -
> +	}
>  	if (!ret)
>  		ctx->pwm_value = pwm;
>  
> @@ -326,6 +346,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	mutex_init(&ctx->lock);
>  
> +	ctx->dev = &pdev->dev;
>  	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
>  	if (IS_ERR(ctx->pwm))
>  		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
