Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC1F2E7B13
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Dec 2020 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgL3QgE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Dec 2020 11:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgL3QgD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Dec 2020 11:36:03 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545EBC06179B;
        Wed, 30 Dec 2020 08:35:23 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id o5so3785135oop.12;
        Wed, 30 Dec 2020 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Y07RsNtYzIcLbWsOcRNA+KuuGregYtN+2nNbxBDK31c=;
        b=qpcATyTIak7kWBxK6/ACktC0ddyoVvp5SUyfx/9WmH+cnasVqfbhKk9YW/4qK3PXi4
         RIQz1RqUgl9p1Kom0dp/iOhgu93Qtddwj6eKBn/eQsk5AtGcQJhcER2EALyObpiuezgM
         Ye+QpxDvp7evtYSe6nPM0Hv4SsV5hQJ9kz3tdn90CX+xueTi5zHmRWoMZm9hPoKhoCwc
         kX2AWC/SSNK/8Qn3zcdMFTz/UAIerl9MnHYQTjaJuc/gOcz4JLADEco+gUA+sE9ng0ob
         vQuCTRjmd7326Q+EGL7YCsfwF7CCCMKRaRp2hbTi2ZGtkXvtFhVPiGTXskQpJ9Qec1gF
         At5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Y07RsNtYzIcLbWsOcRNA+KuuGregYtN+2nNbxBDK31c=;
        b=F79E9BFLomAIbdVYNfIlymWuI4RCQLfWn3xI/Bg+kXrtKWBfuol4cA9CL5JssYhBaa
         yWnyLpLhChvbju1ZVqH2n1ms70fbdos80kEo2owmQ+3SwtPHjZ047olFHoiMS0mo5zR7
         rk4SRXAVyjSwsLl3mFQDI6S8aTKgPS52KrXfA9gvB1uAqcGy0EU6l23yHuGGaiit2c4A
         8uP6ZZfAGE2QOWzEI2m5nVzf8kDk3FpVtYws1uL8at6FUF4mAfRriVK6R13YIyOgytdb
         GoZymmTTAMNjzENC4tsnLnvhRu1UoZkYYnC/3GI3SWNxu0+B138a4kephCXuNlOGZDWR
         Eb7g==
X-Gm-Message-State: AOAM530/L/vnTKQJV5FRfqYVpwEcoeWEw+6F/jQ6VqUHip3t5knL8i1e
        7elhw2T6gaeF+dwiCL0kGj0=
X-Google-Smtp-Source: ABdhPJyN9FH/11QhQE09CdVjZcZYQESiKNRxgQv/kWLmsCV6mgKiT7pIbK/GMGaX3cvVx+mXnSszOQ==
X-Received: by 2002:a4a:e9a7:: with SMTP id t7mr37199457ood.31.1609346122727;
        Wed, 30 Dec 2020 08:35:22 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h2sm10606099otn.15.2020.12.30.08.35.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Dec 2020 08:35:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Dec 2020 08:35:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/2] hwmon: pwm-fan: stop using legacy PWM functions and
 some cleanups
Message-ID: <20201230163520.GA103560@roeck-us.net>
References: <20201215092031.152243-1-u.kleine-koenig@pengutronix.de>
 <20201215092031.152243-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201215092031.152243-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Dec 15, 2020 at 10:20:31AM +0100, Uwe Kleine-König wrote:
> pwm_apply_state() does what the legacy functions pwm_config() and
> pwm_{en,dis}able() do in a single function call. This simplifies error
> handling and is more efficient for new-style PWM hardware drivers.
> 
> Instead of repeatedly querying the PWM framework about the initial PWM
> configuration, cache the settings in driver data.
> 
> Also use __set_pwm() in .probe() to have the algorithm calculating the PWM
> state in a single place.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Can you rebase this patch on top of hwmon-next ?

Thanks,
Guenter

> ---
>  drivers/hwmon/pwm-fan.c | 47 +++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index ec171f2b684a..4ccad5a87019 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -25,6 +25,7 @@
>  struct pwm_fan_ctx {
>  	struct mutex lock;
>  	struct pwm_device *pwm;
> +	struct pwm_state pwm_state;
>  	struct regulator *reg_en;
>  
>  	int irq;
> @@ -73,18 +74,17 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
>  {
>  	unsigned long period;
>  	int ret = 0;
> -	struct pwm_state state = { };
> +	struct pwm_state *state = &ctx->pwm_state;
>  
>  	mutex_lock(&ctx->lock);
>  	if (ctx->pwm_value == pwm)
>  		goto exit_set_pwm_err;
>  
> -	pwm_init_state(ctx->pwm, &state);
> -	period = ctx->pwm->args.period;
> -	state.duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
> -	state.enabled = pwm ? true : false;
> +	period = state->period;
> +	state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
> +	state->enabled = pwm ? true : false;
>  
> -	ret = pwm_apply_state(ctx->pwm, &state);
> +	ret = pwm_apply_state(ctx->pwm, state);
>  	if (!ret)
>  		ctx->pwm_value = pwm;
>  exit_set_pwm_err:
> @@ -274,7 +274,9 @@ static void pwm_fan_regulator_disable(void *data)
>  static void pwm_fan_pwm_disable(void *__ctx)
>  {
>  	struct pwm_fan_ctx *ctx = __ctx;
> -	pwm_disable(ctx->pwm);
> +
> +	ctx->pwm_state.enabled = false;
> +	pwm_apply_state(ctx->pwm, &ctx->pwm_state);
>  	del_timer_sync(&ctx->rpm_timer);
>  }
>  
> @@ -285,7 +287,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	struct pwm_fan_ctx *ctx;
>  	struct device *hwmon;
>  	int ret;
> -	struct pwm_state state = { };
>  	u32 ppr = 2;
>  
>  	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> @@ -324,22 +325,20 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  	ctx->pwm_value = MAX_PWM;
>  
> -	pwm_init_state(ctx->pwm, &state);
> +	pwm_init_state(ctx->pwm, &ctx->pwm_state);
> +
>  	/*
>  	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
>  	 * long. Check this here to prevent the fan running at a too low
>  	 * frequency.
>  	 */
> -	if (state.period > ULONG_MAX / MAX_PWM + 1) {
> +	if (ctx->pwm_state.period > ULONG_MAX / MAX_PWM + 1) {
>  		dev_err(dev, "Configured period too big\n");
>  		return -EINVAL;
>  	}
>  
>  	/* Set duty cycle to maximum allowed and enable PWM output */
> -	state.duty_cycle = ctx->pwm->args.period - 1;
> -	state.enabled = true;
> -
> -	ret = pwm_apply_state(ctx->pwm, &state);
> +	ret = __set_pwm(ctx, MAX_PWM);
>  	if (ret) {
>  		dev_err(dev, "Failed to configure PWM: %d\n", ret);
>  		return ret;
> @@ -399,17 +398,16 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  static int pwm_fan_disable(struct device *dev)
>  {
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> -	struct pwm_args args;
>  	int ret;
>  
> -	pwm_get_args(ctx->pwm, &args);
> -
>  	if (ctx->pwm_value) {
> -		ret = pwm_config(ctx->pwm, 0, args.period);
> +		/* keep ctx->pwm_state unmodified for pwm_fan_resume() */
> +		struct pwm_state state = ctx->pwm_state;
> +		state.duty_cycle = 0;
> +		state.enabled = false;
> +		ret = pwm_apply_state(ctx->pwm, &state);
>  		if (ret < 0)
>  			return ret;
> -
> -		pwm_disable(ctx->pwm);
>  	}
>  
>  	if (ctx->reg_en) {
> @@ -437,8 +435,6 @@ static int pwm_fan_suspend(struct device *dev)
>  static int pwm_fan_resume(struct device *dev)
>  {
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> -	struct pwm_args pargs;
> -	unsigned long duty;
>  	int ret;
>  
>  	if (ctx->reg_en) {
> @@ -452,12 +448,7 @@ static int pwm_fan_resume(struct device *dev)
>  	if (ctx->pwm_value == 0)
>  		return 0;
>  
> -	pwm_get_args(ctx->pwm, &pargs);
> -	duty = DIV_ROUND_UP_ULL(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
> -	ret = pwm_config(ctx->pwm, duty, pargs.period);
> -	if (ret)
> -		return ret;
> -	return pwm_enable(ctx->pwm);
> +	return pwm_apply_state(ctx->pwm, &ctx->pwm_state);
>  }
>  #endif
>  
