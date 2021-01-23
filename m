Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604763016E2
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Jan 2021 17:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbhAWQil (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 Jan 2021 11:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWQil (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 Jan 2021 11:38:41 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2762DC06174A;
        Sat, 23 Jan 2021 08:37:54 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id h6so8425299oie.5;
        Sat, 23 Jan 2021 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=S66JbbCJAizFcdCxgV9qPMrfZrUnSYbLlEI9uZ3ew9A=;
        b=ly9k1Hn5qcg77PQUfWp1+5M0exhCbuBnBXNOxcXqsnR/q+eS4U+UPS7i4njwLMNsKu
         HY/04SBgQXYTHP/GzWBWLSM5g6piXEqWUG9sDePEuHGd++So95lyJ2egioqXhfIBhfQw
         zpMJqtgqLLk/6DX1sW+03dbZQj9ESEARpmoH8eWKNWFM3xQUGtFi+D3wBIjfaKO2wr0k
         RmY1ih0xQ5k4CHOyRCQqsTGrlDJBFdHlnyzYrMZU+EI7DQ1WVzABKh3LaD+U0wkCNzdg
         X24HWE6uQRkq71fb/7CpTPiOC+JeBkE2vCHJY5l8F8fvVzU18ctl3U/2WZDOIxQRsmCu
         dsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S66JbbCJAizFcdCxgV9qPMrfZrUnSYbLlEI9uZ3ew9A=;
        b=PDUUm4ecQR/8o70JKBXTu/Mw5cgandXF9Rj9KjaczwxpbvXuaGUyqCUsniseQkZqn+
         aS+XjJhUYVvhG5uDdDrDGBiHle4g49M3wJzyxFMfbC1izVKLWAgOEXf+wRhPuKll9wbu
         ZaGKv+okmjSROw7iEf8AXkUIsQucSR5hsavc8xsnt5MsFmsSpWNKBIO3rD+c74RdhVW6
         DLK9qlNOzCRewbLvXyEvL6nlMHNP+FyrMs8AHBetNxHx9B1P06JmgieOqi6bNz4jOQlT
         t0Eot260h0EIp/e0/yK36LxSOV91bOPm+/F1plUboABQi3CTM42ZmyXN1VJXhqVW7qT+
         abXA==
X-Gm-Message-State: AOAM53027nuW1ab4f9O4pkdSjmoBpC3/ziVaLqxJOxgepmPrW1RPcPZY
        udb793Rt6RbwA3NCggXVLeA=
X-Google-Smtp-Source: ABdhPJxOUcdninoKnsSen04M2U48XWI/EoDhB7iVzNTGwEw54LCdUAVfiaigY5VFkgBbg7nKOqzp9g==
X-Received: by 2002:a54:4694:: with SMTP id k20mr6750093oic.64.1611419873549;
        Sat, 23 Jan 2021 08:37:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z20sm1385397oth.55.2021.01.23.08.37.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Jan 2021 08:37:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 23 Jan 2021 08:37:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de,
        Paul Barker <pbarker@konsulko.com>
Subject: Re: [PATCH] hwmon: pwm-fan: stop using legacy PWM functions and some
 cleanups
Message-ID: <20210123163751.GA53511@roeck-us.net>
References: <20201230163520.GA103560@roeck-us.net>
 <20210112191314.124686-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112191314.124686-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jan 12, 2021 at 08:13:14PM +0100, Uwe Kleine-König wrote:
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

Applied.

Thanks,
Guenter

> ---
> 
> On Wed, Dec 30, 2020 at 08:35:20AM -0800, Guenter Roeck wrote:
> > Can you rebase this patch on top of hwmon-next ?
> 
> Sure, here it is.
> 
> Best regards
> Uwe
> 
>  drivers/hwmon/pwm-fan.c | 47 +++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 28 deletions(-)
> 
> 
> base-commit: d1f7b079ce5b69c88c813439eea6a9c133f0846b
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index b5204aeb8085..41cb829784a2 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -31,6 +31,7 @@ struct pwm_fan_tach {
>  struct pwm_fan_ctx {
>  	struct mutex lock;
>  	struct pwm_device *pwm;
> +	struct pwm_state pwm_state;
>  	struct regulator *reg_en;
>  
>  	int tach_count;
> @@ -95,18 +96,17 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
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
> @@ -288,7 +288,9 @@ static void pwm_fan_regulator_disable(void *data)
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
> @@ -299,7 +301,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  	struct pwm_fan_ctx *ctx;
>  	struct device *hwmon;
>  	int ret;
> -	struct pwm_state state = { };
>  	const struct hwmon_channel_info **channels;
>  	u32 *fan_channel_config;
>  	int channel_count = 1;	/* We always have a PWM channel. */
> @@ -337,22 +338,20 @@ static int pwm_fan_probe(struct platform_device *pdev)
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
> @@ -468,17 +467,16 @@ static int pwm_fan_probe(struct platform_device *pdev)
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
> @@ -506,8 +504,6 @@ static int pwm_fan_suspend(struct device *dev)
>  static int pwm_fan_resume(struct device *dev)
>  {
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
> -	struct pwm_args pargs;
> -	unsigned long duty;
>  	int ret;
>  
>  	if (ctx->reg_en) {
> @@ -521,12 +517,7 @@ static int pwm_fan_resume(struct device *dev)
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
