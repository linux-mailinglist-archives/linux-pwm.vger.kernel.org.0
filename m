Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F375A6567
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Aug 2022 15:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiH3NsN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Aug 2022 09:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiH3Nrm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Aug 2022 09:47:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0739811C162;
        Tue, 30 Aug 2022 06:45:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id z187so11365717pfb.12;
        Tue, 30 Aug 2022 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=uMH1DBfZlD5R3dkilR2h+BwCxQ/ReIy31JPPO3vYJBo=;
        b=n241ulwrYlUwMDCcmMzYBhejA6NyC6IO6Fe0Ouv7GEwYpinouInITqEZsheuLhnHAD
         x94WmIqSAw8/K0VkF+s1uwxPsNYS2468qBJwqUiin8jiEjlmflbc78lXb61ei4UvVvZc
         htlN4ws5UKdZ8BFgj8kDai0ITvMoBUDw6/y2y/CwJ/cxnYNJUSYX6D2KC82vJMWJeWzZ
         l/ImyDcV1haxxRjVvxioDGhmR0O9i/k1r6pqacUtRHugx2nwogxtW/I56njmoJgzDIa0
         gF9AdQYUJEL2QsstwjbMZ99FxMZAbkSmtSsI70i0+0j3UbG98GHjTdgbjHoXYcE35+4W
         gzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=uMH1DBfZlD5R3dkilR2h+BwCxQ/ReIy31JPPO3vYJBo=;
        b=cQpY9qIVGsY1ueXQn3l3FINfnbB3kLWGHyYfgunKQZxt2vUk6zpro80Z6tpPiRVFXT
         wzWV/PsBvCU6Soc9a84gfVH8HiNDBDcDlx5pyg4XRsVklkqNi4tQEfzvqmZxQ2eN1FGV
         FZG3ITLIg1JMi1V7SC5r6CHvDtV+oUuQs1S5Vx0xkZOZV5BDXxfCD1tuhYpzseILNDey
         M+hzPjn03BQw+oGfkmqu0a+ab3XGIO0bggH67skn+yl5RmIMtgrAamz3LFYG2H/gbFfq
         1jGWqN6yeUZBMnQFWewOs8fCct1Rlao29bbN4FJiC1l9NnPJF0s0NrUkuTjHejic8xZk
         YGoQ==
X-Gm-Message-State: ACgBeo1ExBvuZwH/kcZ9EJMa9USKOwXesO0LWoApswiPATKUe7htn+4T
        KuNevVSzsMGNEMmb5fsZ98w=
X-Google-Smtp-Source: AA6agR6Jnbi6dTLKaY7MWOYpHTWNHj0kYdpW4iIvJeqx60Pc9evFf7q1BaFYVDhUOYkB/fnNBcyxYQ==
X-Received: by 2002:a63:d409:0:b0:429:8f3f:82fc with SMTP id a9-20020a63d409000000b004298f3f82fcmr18580871pgh.591.1661867110448;
        Tue, 30 Aug 2022 06:45:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a85-20020a621a58000000b00537bdc9c2f2sm9654881pfa.170.2022.08.30.06.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:45:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Aug 2022 06:45:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v4 1/6] hwmon: pwm-fan: Refactor fan power on/off
Message-ID: <20220830134508.GA229842@roeck-us.net>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
 <20220523110513.407516-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523110513.407516-2-alexander.stein@ew.tq-group.com>
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

On Mon, May 23, 2022 at 01:05:08PM +0200, Alexander Stein wrote:
> In preparation for dynamically switching regulator, split the power on
> and power off sequence into separate functions.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/pwm-fan.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 6c08551d8d14..831878daffe6 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -82,23 +82,47 @@ static void sample_timer(struct timer_list *t)
>  	mod_timer(&ctx->rpm_timer, jiffies + HZ);
>  }
>  
> -static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> +static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
>  {
> +	struct pwm_state *state = &ctx->pwm_state;
>  	unsigned long period;
> -	int ret = 0;
> +	int ret;
> +
> +	period = state->period;
> +	state->duty_cycle = DIV_ROUND_UP(ctx->pwm_value * (period - 1), MAX_PWM);
> +	state->enabled = true;
> +	ret = pwm_apply_state(ctx->pwm, state);
> +
> +	return ret;
> +}
> +
> +static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
> +{
>  	struct pwm_state *state = &ctx->pwm_state;
>  
> +	state->enabled = false;
> +	state->duty_cycle = 0;
> +	pwm_apply_state(ctx->pwm, state);
> +
> +	return 0;
> +}
> +
> +static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> +{
> +	int ret = 0;
> +
>  	mutex_lock(&ctx->lock);
>  	if (ctx->pwm_value == pwm)
>  		goto exit_set_pwm_err;
>  
> -	period = state->period;
> -	state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
> -	state->enabled = pwm ? true : false;
> +	if (pwm > 0)
> +		ret = pwm_fan_power_on(ctx);
> +	else
> +		ret = pwm_fan_power_off(ctx);
>  
> -	ret = pwm_apply_state(ctx->pwm, state);
>  	if (!ret)
>  		ctx->pwm_value = pwm;
> +
>  exit_set_pwm_err:
>  	mutex_unlock(&ctx->lock);
>  	return ret;
