Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A651D212
	for <lists+linux-pwm@lfdr.de>; Fri,  6 May 2022 09:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389496AbiEFHTp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 May 2022 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389484AbiEFHTl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 May 2022 03:19:41 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F62866FBE;
        Fri,  6 May 2022 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1651821357; x=1683357357;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYjNWTwSTl8Sd1EMf6HFUKiLN37dMlIe8NLtDfd1oig=;
  b=Qkagnn6UEY9u6A0qKb9U3gm67yCHLUzDr1P0vFOCrXtOsxGH5bgWzIAj
   4AJ7nToHxY4wVBxRCZEjOgpiVe3qMquhvJi+yQ3dkR7inzSJ8LXkoz6aK
   Q+MB4JSZpz7Q3GcHtCSqEjMXebbBI+sNLok3kX2xC+FEz10v2AJvuL1lZ
   hdTV8dQrQ04TU+/+2QQMdTlCuxmDqRJV9iqgP1A84yEZDHQSJmTijVdMD
   gV+187XJMyUBrCWahDFEIL5nzVmdod2jt6orbld7qML6DoAFWdodwvOV6
   PTsddiFKNCifBOstk+2RNPLZ7HYu7KiQrmjp+TNMQRNuYiPlBLGr4o6tM
   g==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="23712034"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 06 May 2022 09:15:55 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 06 May 2022 09:15:55 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 06 May 2022 09:15:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1651821355; x=1683357355;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYjNWTwSTl8Sd1EMf6HFUKiLN37dMlIe8NLtDfd1oig=;
  b=Z5kjAU/qwm/d/OrepsnuPhrAtCfJ8tsd0xnkIzPqGiHIizoOtmaoKoac
   APFvUNmtWe0e3KpKWqdi1rXXk0j2g4KXkXtBTNi3H0tK3e1vJgqwJG3Cm
   /kdP+hF6axARCrK579Ir9xB/JSpXCBDx9OhO2Mu/UynyH1ViezChNTRyc
   aSx8VawWzLkTyOAIHNojEKeZnmQUreh28s0/7rkAEeXONJnYQ0XRNej/v
   KqQgQk5Dmje3Atp4bunltWWrl7hVpeA1Kofb/fMyddHvlrcLGNKvrvEtJ
   XPbdQJ8NCUkeDUQa+3YgwWoYyEBR3QE67PfDwKUUhH5hDNA3psfLAHK0/
   A==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="23712033"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 06 May 2022 09:15:55 +0200
Received: from niebel-ws (unknown [10.123.49.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2CBBC280070;
        Fri,  6 May 2022 09:15:55 +0200 (CEST)
Message-ID: <cbd48a5c66b2fd1ef99f7ddea97edd84e01c549a.camel@ew.tq-group.com>
Subject: Re: (EXT) Re: [PATCH v2 1/1] hwmon: pwm-fan: dynamically switch
 regulator
From:   Markus Niebel <Markus.Niebel@ew.tq-group.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Date:   Fri, 06 May 2022 09:15:52 +0200
In-Reply-To: <20220505220037.GF1988936@roeck-us.net>
References: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
         <20220505220037.GF1988936@roeck-us.net>
Organization: TQ Systems GmbH
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am Donnerstag, den 05.05.2022, 15:00 -0700 schrieb Guenter Roeck:
> On Wed, May 04, 2022 at 02:45:51PM +0200, Alexander Stein wrote:
> > From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > 
> > A pwm value equal to zero is meant to switch off the pwm
> > hence also switching off the fan. Currently the optional
> > regulator is always on. When using this driver on boards
> > with an inverted pwm signal polarity this can cause running
> > the fan at maximum speed when setting pwm to zero.
> > 
> 
> The appropriate solution in this case would be to tell the
> software that the pwm is inverted. Turning off the regulator
> in that situation is a bad idea since setting the pwm value to
> 1 would set it to almost full speed. That does not really make
> sense.
> 
> Guenter
> 

The regulator is inverted by dt settings in this case. This means,
slowing down to 1 works as expected, but going to zero will speed
up to max in our case (The inversion is due to the logic of the
board hardware)

The logic of switching off the regulator is the same as done in
drivers/video/backlight/pwm_bl.c - when brightness is set to zero,
the backlight is switched off. 

Markus

> > The proposed changes switch the regulator off, when PWM is
> > currently enabled but pwm is requested to set to zero
> > and switch der regulator on, when PWM is currently disabled
> > but pwm shall be set to a no zero value.
> > 
> > Add __set_pwm_and_regulator and rewrite __set_pwm to
> > handle regulator switching for the following conditions:
> > 
> > - probe: pwm duty -> max, pwm state is unkwown: use __set_pwm
> >   and enable regulator separately to keep the devm action
> > - off: new pwm duty is zero, pwm currently enabled: disable
> >   regulator
> > - on: new pwm duty is non zero, pwm currently disabled: enable
> >   regulator
> > 
> > Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> > Changes in v2:
> > * Added my own missing S-o-b
> > 
> >  drivers/hwmon/pwm-fan.c | 144 ++++++++++++++++++++++++++--------------
> >  1 file changed, 93 insertions(+), 51 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > index f12b9a28a232..b47d59fbe836 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -97,18 +97,50 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long
> > pwm)
> >  	unsigned long period;
> >  	int ret = 0;
> >  	struct pwm_state *state = &ctx->pwm_state;
> > +	/* track changes of reg_en for error handling */
> > +	enum regulator_change {
> > +		untouched,
> > +		enabled,
> > +		disabled,
> > +	} reg_change = untouched;
> >  
> >  	mutex_lock(&ctx->lock);
> > +
> >  	if (ctx->pwm_value == pwm)
> >  		goto exit_set_pwm_err;
> >  
> > +	if (ctx->reg_en) {
> > +		if (pwm && !state->enabled) {
> > +			reg_change = enabled;
> > +			ret = regulator_enable(ctx->reg_en);
> > +		} else if (!pwm && state->enabled) {
> > +			reg_change = disabled;
> > +			ret = regulator_disable(ctx->reg_en);
> > +		}
> > +		if (ret)
> > +			goto exit_set_pwm_err;
> > +	}
> > +
> >  	period = state->period;
> >  	state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
> >  	state->enabled = pwm ? true : false;
> >  
> >  	ret = pwm_apply_state(ctx->pwm, state);
> > -	if (!ret)
> > +	if (!ret) {
> >  		ctx->pwm_value = pwm;
> > +	} else if (reg_change != untouched) {
> > +		/*
> > +		 * revert regulator changes to keep consistency between
> > +		 * pwm and regulator
> > +		 */
> > +		int err;
> > +
> > +		if (reg_change == enabled)
> > +			err = regulator_disable(ctx->reg_en);
> > +		else if (reg_change == disabled)
> > +			err = regulator_enable(ctx->reg_en);
> > +	}
> > +
> >  exit_set_pwm_err:
> >  	mutex_unlock(&ctx->lock);
> >  	return ret;
> > @@ -280,18 +312,50 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
> >  	return 0;
> >  }
> >  
> > -static void pwm_fan_regulator_disable(void *data)
> > +/*
> > + * disable fan and regulator
> > + * if cleanup is true, disable pwm regardless of regulator disable result
> > + * this makes the function dual use for unloading driver and suspend
> > + */
> > +
> > +static int __pwm_fan_disable_or_cleanup(struct pwm_fan_ctx *ctx, bool cleanup)
> >  {
> > -	regulator_disable(data);
> > +	int ret;
> > +
> > +	if (ctx->pwm_value) {
> > +		/* keep ctx->pwm_state unmodified for pwm_fan_resume() */
> > +		struct pwm_state state = ctx->pwm_state;
> > +
> > +		/* regulator is only enabled if pwm_value is not zero */
> > +		if (ctx->pwm_value && ctx->reg_en) {
> > +			ret = regulator_disable(ctx->reg_en);
> > +			if (ret) {
> > +				pr_err("Failed to disable fan supply: %d\n", ret);
> > +				if (!cleanup)
> > +					return ret;
> > +			}
> > +		}
> > +
> > +		state.duty_cycle = 0;
> > +		state.enabled = false;
> > +		ret = pwm_apply_state(ctx->pwm, &state);
> > +	}
> > +
> > +	return ret;
> >  }
> >  
> > -static void pwm_fan_pwm_disable(void *__ctx)
> > +static void pwm_fan_cleanup(void *__ctx)
> >  {
> >  	struct pwm_fan_ctx *ctx = __ctx;
> > -
> > -	ctx->pwm_state.enabled = false;
> > -	pwm_apply_state(ctx->pwm, &ctx->pwm_state);
> >  	del_timer_sync(&ctx->rpm_timer);
> > +	__pwm_fan_disable_or_cleanup(ctx, true);
> > +}
> > +
> > +static int pwm_fan_disable(void *__ctx)
> > +{
> > +	struct pwm_fan_ctx *ctx = __ctx;
> > +
> > +	return __pwm_fan_disable_or_cleanup(ctx, false);
> >  }
> >  
> >  static int pwm_fan_probe(struct platform_device *pdev)
> > @@ -324,19 +388,14 @@ static int pwm_fan_probe(struct platform_device *pdev)
> >  			return PTR_ERR(ctx->reg_en);
> >  
> >  		ctx->reg_en = NULL;
> > -	} else {
> > -		ret = regulator_enable(ctx->reg_en);
> > -		if (ret) {
> > -			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> > -			return ret;
> > -		}
> > -		ret = devm_add_action_or_reset(dev, pwm_fan_regulator_disable,
> > -					       ctx->reg_en);
> > -		if (ret)
> > -			return ret;
> >  	}
> >  
> >  	pwm_init_state(ctx->pwm, &ctx->pwm_state);
> > +	/*
> > +	 * Ensure the PWM is switched on (including the regulator),
> > +	 * independently from any previous PWM state
> > +	 */
> > +	ctx->pwm_state.enabled = false;
> >  
> >  	/*
> >  	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
> > @@ -348,14 +407,17 @@ static int pwm_fan_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	/* Set duty cycle to maximum allowed and enable PWM output */
> > +	/*
> > +	 * Set duty cycle to maximum allowed and enable PWM output as well as
> > +	 * the regulator. In case of error nothing is changed
> > +	 */
> >  	ret = __set_pwm(ctx, MAX_PWM);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to configure PWM: %d\n", ret);
> >  		return ret;
> >  	}
> >  	timer_setup(&ctx->rpm_timer, sample_timer, 0);
> > -	ret = devm_add_action_or_reset(dev, pwm_fan_pwm_disable, ctx);
> > +	ret = devm_add_action_or_reset(dev, pwm_fan_cleanup, ctx);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -461,42 +523,22 @@ static int pwm_fan_probe(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > -static int pwm_fan_disable(struct device *dev)
> > -{
> > -	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> > -	int ret;
> > -
> > -	if (ctx->pwm_value) {
> > -		/* keep ctx->pwm_state unmodified for pwm_fan_resume() */
> > -		struct pwm_state state = ctx->pwm_state;
> > -
> > -		state.duty_cycle = 0;
> > -		state.enabled = false;
> > -		ret = pwm_apply_state(ctx->pwm, &state);
> > -		if (ret < 0)
> > -			return ret;
> > -	}
> > -
> > -	if (ctx->reg_en) {
> > -		ret = regulator_disable(ctx->reg_en);
> > -		if (ret) {
> > -			dev_err(dev, "Failed to disable fan supply: %d\n", ret);
> > -			return ret;
> > -		}
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> >  static void pwm_fan_shutdown(struct platform_device *pdev)
> >  {
> > -	pwm_fan_disable(&pdev->dev);
> > +	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
> > +
> > +	pwm_fan_cleanup(ctx);
> >  }
> >  
> >  #ifdef CONFIG_PM_SLEEP
> >  static int pwm_fan_suspend(struct device *dev)
> >  {
> > -	return pwm_fan_disable(dev);
> > +	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = pwm_fan_disable(ctx);
> > +
> > +	return ret;
> >  }
> >  
> >  static int pwm_fan_resume(struct device *dev)
> > @@ -504,6 +546,9 @@ static int pwm_fan_resume(struct device *dev)
> >  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> >  	int ret;
> >  
> > +	if (ctx->pwm_value == 0)
> > +		return 0;
> > +
> >  	if (ctx->reg_en) {
> >  		ret = regulator_enable(ctx->reg_en);
> >  		if (ret) {
> > @@ -512,9 +557,6 @@ static int pwm_fan_resume(struct device *dev)
> >  		}
> >  	}
> >  
> > -	if (ctx->pwm_value == 0)
> > -		return 0;
> > -
> >  	return pwm_apply_state(ctx->pwm, &ctx->pwm_state);
> >  }
> >  #endif
> > -- 
> > 2.25.1
> > 

