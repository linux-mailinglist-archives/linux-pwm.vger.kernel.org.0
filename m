Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846AC764660
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jul 2023 08:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjG0GAj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jul 2023 02:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjG0GAj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jul 2023 02:00:39 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111F992
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jul 2023 23:00:38 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a3efebcc24so550718b6e.1
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jul 2023 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690437637; x=1691042437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWbRFJ7royzJOKQhz+S4nL0akbmDK8kUbllxZrHnppw=;
        b=dk8/Mi2XcwcOhhDzcfLgz1qV9OKNI/E9nA4R72SIvxGNzo3ItUVWILsFhxvUYnhhnk
         i4bbJvYcB41lZfu/WcFHv8z6ZF+kv7cmOIIgE8EIDhoVt6kIq4FtxZUA0DJjm5vtiRcW
         zQVIbowhjGU0AQKOv07xm6Ho9hUzi+Lu7OFPwKP8oxyfuHNAnI14vRWU6HGtoXVK398Z
         VQxQgWUApfqsMniJLFg3SZ8sLE939W0FMpCLmj7v9cebrttfYFmvuitMJytHLKQJ1izU
         rKq44TagWNBuCS2p516CIA03OhmvjZ52U4I+043i3NCWDOQ3oSoDO2UebfnvfsZxYKvI
         9cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690437637; x=1691042437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWbRFJ7royzJOKQhz+S4nL0akbmDK8kUbllxZrHnppw=;
        b=WpX0lmjZWyqx8xX6dmU0FXV7F7OnXV88L7tyu9YMZFVyMNN4xC4JCUcP4RxmpmDSz7
         Yw19hkPHalU0Q2e4rJAf65NAZCXmuAJyU7i3muSIQwgUB5psEx1Q/J47FIvVCnTfY1yH
         IJDLUYavhuTist3veRedB6crrmTEf+YoD5vxzhTJ8jQVSucqD8McPIXSceYhazG3nH0h
         VlN/WSHpB5RF6KDXZKHyKxESbs+9oSPVyV9G3cj0jZAs7+QmA+eWw+XYJdO7PVej3vz+
         1602zZkqaMA265lMgaBSMHA6pInXzF6o61FoXYo5ZppUe19GO9hfZ/s0UzeA+xB514yv
         wJjw==
X-Gm-Message-State: ABy/qLav7HLEFnPqZ3oKrg1qx+36gQuA37ceAl2Q+JzJKzAYCoMQmNxO
        24seBAMeQ3Eo+sCBo+mzZFJtAQ==
X-Google-Smtp-Source: APBJJlG35JxdnR70vF29eIeajKtcagJpcqbWRh+9OrFhDN2Ptvis7yZuOFQiG/9t8wZH2VlzdFFM4Q==
X-Received: by 2002:a05:6808:1cb:b0:3a3:eceb:7bbc with SMTP id x11-20020a05680801cb00b003a3eceb7bbcmr1871989oic.54.1690437637393;
        Wed, 26 Jul 2023 23:00:37 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id bu30-20020a63295e000000b004ff6b744248sm543480pgb.48.2023.07.26.23.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 23:00:37 -0700 (PDT)
Message-ID: <7890a50f-48dc-0179-c08b-7f351f42cd1e@tuxon.dev>
Date:   Thu, 27 Jul 2023 09:00:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/5] pwm: atmel-tcb: Harmonize resource allocation order
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
 <20230719192013.4051193-2-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230719192013.4051193-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 19.07.2023 22:20, Uwe Kleine-König wrote:
> Allocate driver data as first resource in the probe function. This way it
> can be used during allocation of the other resources (instead of assigning
> these to local variables first and update driver data only when it's
> allocated). Also as driver data is allocated using a devm function this
> should happen first to have the order of freeing resources in the error
> path and the remove function in reverse.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/pwm/pwm-atmel-tcb.c | 49 +++++++++++++++----------------------
>   1 file changed, 20 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 4a116dc44f6e..613dd1810fb5 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -422,13 +422,14 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>   	struct atmel_tcb_pwm_chip *tcbpwm;
>   	const struct atmel_tcb_config *config;
>   	struct device_node *np = pdev->dev.of_node;
> -	struct regmap *regmap;
> -	struct clk *clk, *gclk = NULL;
> -	struct clk *slow_clk;
>   	char clk_name[] = "t0_clk";
>   	int err;
>   	int channel;
>   
> +	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
> +	if (tcbpwm == NULL)

I know this was previously but maybe we can change it like this now:
	if (!tcbpwm)

this is how is done in most of the memory alloc failure checks (AFAICT).

> +		return -ENOMEM;
> +
>   	err = of_property_read_u32(np, "reg", &channel);
>   	if (err < 0) {
>   		dev_err(&pdev->dev,
> @@ -437,47 +438,37 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>   		return err;
>   	}
>   
> -	regmap = syscon_node_to_regmap(np->parent);
> -	if (IS_ERR(regmap))
> -		return PTR_ERR(regmap);
> +	tcbpwm->regmap = syscon_node_to_regmap(np->parent);
> +	if (IS_ERR(tcbpwm->regmap))
> +		return PTR_ERR(tcbpwm->regmap);
>   
> -	slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
> -	if (IS_ERR(slow_clk))
> -		return PTR_ERR(slow_clk);
> +	tcbpwm->slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
> +	if (IS_ERR(tcbpwm->slow_clk))
> +		return PTR_ERR(tcbpwm->slow_clk);
>   
>   	clk_name[1] += channel;
> -	clk = of_clk_get_by_name(np->parent, clk_name);
> -	if (IS_ERR(clk))
> -		clk = of_clk_get_by_name(np->parent, "t0_clk");
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> +	tcbpwm->clk = of_clk_get_by_name(np->parent, clk_name);
> +	if (IS_ERR(tcbpwm->clk))
> +		tcbpwm->clk = of_clk_get_by_name(np->parent, "t0_clk");
> +	if (IS_ERR(tcbpwm->clk))
> +		return PTR_ERR(tcbpwm->clk);
>   
>   	match = of_match_node(atmel_tcb_of_match, np->parent);
>   	config = match->data;
>   
>   	if (config->has_gclk) {
> -		gclk = of_clk_get_by_name(np->parent, "gclk");
> -		if (IS_ERR(gclk))
> -			return PTR_ERR(gclk);
> -	}
> -
> -	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
> -	if (tcbpwm == NULL) {
> -		err = -ENOMEM;
> -		goto err_slow_clk;
> +		tcbpwm->gclk = of_clk_get_by_name(np->parent, "gclk");
> +		if (IS_ERR(tcbpwm->gclk))
> +			return PTR_ERR(tcbpwm->gclk);
>   	}
>   
>   	tcbpwm->chip.dev = &pdev->dev;
>   	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
>   	tcbpwm->chip.npwm = NPWM;
>   	tcbpwm->channel = channel;
> -	tcbpwm->regmap = regmap;
> -	tcbpwm->clk = clk;
> -	tcbpwm->gclk = gclk;
> -	tcbpwm->slow_clk = slow_clk;
>   	tcbpwm->width = config->counter_width;
>   
> -	err = clk_prepare_enable(slow_clk);
> +	err = clk_prepare_enable(tcbpwm->slow_clk);
>   	if (err)
>   		goto err_slow_clk;
>   
> @@ -495,7 +486,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>   	clk_disable_unprepare(tcbpwm->slow_clk);
>   
>   err_slow_clk:
> -	clk_put(slow_clk);
> +	clk_put(tcbpwm->slow_clk);
>   
>   	return err;
>   }
