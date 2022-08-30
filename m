Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD215A659A
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Aug 2022 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiH3NwX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Aug 2022 09:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiH3Nv7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Aug 2022 09:51:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75D079ECB;
        Tue, 30 Aug 2022 06:50:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u22so11158777plq.12;
        Tue, 30 Aug 2022 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=JuSkhF9/SslkchqMZNYzukk/FMrzbiZOARTrRN80cJ4=;
        b=lujovqEW+kQbMKYlvgwI34ODD1IH4LUSX31k+YjyXcOQr7ymA6oIr+uLtAkqr1pRBR
         AkBVDT6aI1hMbOoIu+aBigujKOVFQ9KDt/Q6Yqst1JMOgZymtVqvSHYgexWzEilxCNbn
         63whUhKU3pxZcTarwfAFNaMdzqMJ+lGe6WWg4DZAeNHzvdvII+ykWOO6AsMBxTYkEjVE
         caL/9SBeXKrl1vq0Nx4fYEngukcCZ1FadOXesQ9tvqiSnjyKJ1bSXbNxZzpsdYjvkiTg
         ieaNhaxwWak3+BA4x/tHq++KOSCT+8K3Jd7Vil91dc51cyPown+uEnHbnkuFwcPVur1i
         7oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=JuSkhF9/SslkchqMZNYzukk/FMrzbiZOARTrRN80cJ4=;
        b=qJ0R+rHnTT2TEcBdpA1yvvmWpPA+bplomWuAkE6UUC5ED+IRDOTtgj058iqZI1lj3n
         kko03XKJrvPA+uOI18Qmpao2xPWZJBV67HHbkhugr3/gf7g48NRkP4R6oFeAkmPQ4Mg5
         +sNRJEiM+zJLQq59aLcCTXnTjp7LzeZsXJ44YiEnStTKP3n6/Q0yFmtn77ZpZ2ApKJVA
         apBSh0AczYFSe7+3OViwx0JtTp3wJX0U8EC/gcvCBS8VptJmUdl+QsGqFEgYAudqEd/m
         1XLbPRhGycTq+Cw7sUy3co9z2q8QdkCXzNbhmpVgPEFzw9tVjhEu5dvlwOKmZH6PQ5hE
         g96w==
X-Gm-Message-State: ACgBeo1LECTvVXqsLSOx+kpMhfisJGr0CgSrJhehRmvi+b9N033ZkCyF
        ThL2XR2MTHYibEUnFTMmyik=
X-Google-Smtp-Source: AA6agR6xy6hV+ZqAOQETA+y96+fkILby1CCk75SAbbTT8RU/5TqiQRmnlk8OROScotVpwBBwYlEXZA==
X-Received: by 2002:a17:90a:d994:b0:1fd:78f9:4717 with SMTP id d20-20020a17090ad99400b001fd78f94717mr20159154pjv.72.1661867415142;
        Tue, 30 Aug 2022 06:50:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c7-20020a624e07000000b0052d417039c2sm9346756pfb.133.2022.08.30.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:50:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 Aug 2022 06:50:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v4 3/6] hwmon: pwm-fan: Add dedicated power switch
 function
Message-ID: <20220830135013.GA229925@roeck-us.net>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
 <20220523110513.407516-4-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523110513.407516-4-alexander.stein@ew.tq-group.com>
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

On Mon, May 23, 2022 at 01:05:10PM +0200, Alexander Stein wrote:
> This handles enabling/disabling the regulator in a single function, while
> keeping the enables/disabled balanced. This is a preparation when
> regulator is switched from different code paths.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  drivers/hwmon/pwm-fan.c | 52 +++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> index 96b10d422828..04af24268963 100644
> --- a/drivers/hwmon/pwm-fan.c
> +++ b/drivers/hwmon/pwm-fan.c
> @@ -35,6 +35,7 @@ struct pwm_fan_ctx {
>  	struct pwm_device *pwm;
>  	struct pwm_state pwm_state;
>  	struct regulator *reg_en;
> +	bool regulator_enabled;
>  	bool enabled;
>  
>  	int tach_count;
> @@ -85,6 +86,29 @@ static void sample_timer(struct timer_list *t)
>  	mod_timer(&ctx->rpm_timer, jiffies + HZ);
>  }
>  
> +static int pwm_fan_switch_power(struct pwm_fan_ctx *ctx, bool on)
> +{
> +	int ret = 0;
> +
> +	if (!ctx->reg_en)
> +		return ret;
> +
> +	if (ctx->regulator_enabled && on) {
> +		ret = 0;

ret is already 0 here.

> +	} else if (!ctx->regulator_enabled && on) {
> +		ret = regulator_enable(ctx->reg_en);
> +		if (ret == 0)
> +			ctx->regulator_enabled = true;
> +	} else if (ctx->regulator_enabled && !on) {
> +		ret = regulator_disable(ctx->reg_en);
> +		if (ret == 0)
> +			ctx->regulator_enabled = false;
> +	} else if (!ctx->regulator_enabled && !on) {
> +		ret = 0;

ret is already 0 here.

> +	}
> +	return ret;
> +}
> +
>  static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
>  {
>  	struct pwm_state *state = &ctx->pwm_state;
> @@ -316,7 +340,9 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
>  
>  static void pwm_fan_regulator_disable(void *data)
>  {
> -	regulator_disable(data);
> +	struct pwm_fan_ctx *ctx = data;
> +
> +	pwm_fan_switch_power(ctx, false);

You can directly pass 'data' as argument here; there is no need
for the extra variable.

>  }
>  
>  static void pwm_fan_pwm_disable(void *__ctx)
> @@ -360,13 +386,13 @@ static int pwm_fan_probe(struct platform_device *pdev)
>  
>  		ctx->reg_en = NULL;
>  	} else {
> -		ret = regulator_enable(ctx->reg_en);
> +		ret = pwm_fan_switch_power(ctx, true);
>  		if (ret) {
>  			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
>  			return ret;
>  		}
>  		ret = devm_add_action_or_reset(dev, pwm_fan_regulator_disable,
> -					       ctx->reg_en);
> +					       ctx);
>  		if (ret)
>  			return ret;
>  	}
> @@ -512,12 +538,10 @@ static int pwm_fan_disable(struct device *dev)
>  			return ret;
>  	}
>  
> -	if (ctx->reg_en) {
> -		ret = regulator_disable(ctx->reg_en);
> -		if (ret) {
> -			dev_err(dev, "Failed to disable fan supply: %d\n", ret);
> -			return ret;
> -		}
> +	ret = pwm_fan_switch_power(ctx, false);
> +	if (ret) {
> +		dev_err(dev, "Failed to disable fan supply: %d\n", ret);
> +		return ret;
>  	}
>  
>  	return 0;
> @@ -539,12 +563,10 @@ static int pwm_fan_resume(struct device *dev)
>  	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
>  	int ret;
>  
> -	if (ctx->reg_en) {
> -		ret = regulator_enable(ctx->reg_en);
> -		if (ret) {
> -			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> -			return ret;
> -		}
> +	ret = pwm_fan_switch_power(ctx, true);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable fan supply: %d\n", ret);
> +		return ret;
>  	}
>  
>  	if (ctx->pwm_value == 0)
