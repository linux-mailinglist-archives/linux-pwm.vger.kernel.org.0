Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BCB76465E
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jul 2023 08:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjG0GAF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jul 2023 02:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjG0GAE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jul 2023 02:00:04 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0392
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jul 2023 23:00:03 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a3efee1d44so527571b6e.3
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jul 2023 23:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690437602; x=1691042402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rE2NQqGLGnt9BT3rKaKR6Wgmu0pu0Ak5Vr77QN2wW80=;
        b=P0k+n/V5o6CRziJFp+7z8ZQpkpSVoI1RAh6SpIl9TZrRE9i+vQXWw3V/i36C8GL19x
         0ACLzTlyM6BiwuWqrDl6soTsb+nfTsBWO3Q7uxSl8skK4SqvtH0b0q8cuVqm4QUmAw0u
         yVCgmMso61ws/auDQbmea+4pu4YIjWSRbIUthCdFIClHmtKXoER/MYk0HgjMB4ajMqoJ
         5VGSe/eAeI6lv+b8u38w7S1Cc63r9REE4qY7WR3VG9zshV7vedZqZ09uc7MUG4gQJb0m
         KqE5pgGDrh+n01YuAsYzZ8CsVQAp1hFyWSbPDkj3Ny1VrYtr55cQk/hNnRYUbgeZqpyP
         Chpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690437602; x=1691042402;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rE2NQqGLGnt9BT3rKaKR6Wgmu0pu0Ak5Vr77QN2wW80=;
        b=TyaueuqOkq/+F0A3XjkH1E+NpDpSNJEH79otANijiWGfBMDZZqzg4Rz87mUd6ID9dt
         ixr8jeXphP+kP3HnxjRBsLU9UUop9TQzEcgNRZWELLzWI7sWZhIHTSn71Ak3fOwF51fy
         +66l3CDfQ1Ojq8i39g4WCtFQANPja0YXS1+mXA9mXPGjg6hGjug/ycLZrDUtiyX9FjJY
         ZkQr90IO18oGt0NmoFCaPTeDfF6ik0BFZu7BXcxSvVuZfKNvD+8IqyiMmfwP7npAHxCx
         1erPTbgBt05ioD2Lklz8QofqovCNYTyjfTu80mkF5XkrfAkejERxDOJgxVTtf1QdE2L0
         M12g==
X-Gm-Message-State: ABy/qLYVfhc+woe5IglGxUAPWy1x0wLmc4kmpkMCSZJBB0Rj0JkbCx2Q
        koithpS/MCDavBzaKSG21JM3Cw==
X-Google-Smtp-Source: APBJJlF7vrHLW5H8YVmD4YsRrGUvUS5ENHJpZJRJvW/f6UBe+dtxlJ6BNhjIwdas3Tv81PMwWI72KA==
X-Received: by 2002:a05:6808:10d4:b0:3a4:3072:e597 with SMTP id s20-20020a05680810d400b003a43072e597mr2168432ois.54.1690437602681;
        Wed, 26 Jul 2023 23:00:02 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090a674700b00263b9e75aecsm463511pjm.41.2023.07.26.22.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 23:00:02 -0700 (PDT)
Message-ID: <3a53c437-80ff-2a35-09f2-fe16377ea829@tuxon.dev>
Date:   Thu, 27 Jul 2023 08:59:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] pwm: atmel-tcb: Put per-channel data into driver data
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
 <20230719192013.4051193-4-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230719192013.4051193-4-u.kleine-koenig@pengutronix.de>
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
> This simplifies the code, reduces the number of memory allocations and
> pointer dereferences.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/pwm/pwm-atmel-tcb.c | 29 +++++++++--------------------
>   1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 2826fc216d29..ae274bd7907d 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -57,7 +57,7 @@ struct atmel_tcb_pwm_chip {
>   	struct clk *clk;
>   	struct clk *gclk;
>   	struct clk *slow_clk;
> -	struct atmel_tcb_pwm_device *pwms[NPWM];
> +	struct atmel_tcb_pwm_device pwms[NPWM];
>   	struct atmel_tcb_channel bkup;
>   };
>   
> @@ -73,7 +73,7 @@ static int atmel_tcb_pwm_set_polarity(struct pwm_chip *chip,
>   				      enum pwm_polarity polarity)
>   {
>   	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> -	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
> +	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
>   
>   	tcbpwm->polarity = polarity;
>   
> @@ -84,19 +84,13 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
>   				 struct pwm_device *pwm)
>   {
>   	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> -	struct atmel_tcb_pwm_device *tcbpwm;
> +	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
>   	unsigned cmr;
>   	int ret;
>   
> -	tcbpwm = devm_kzalloc(chip->dev, sizeof(*tcbpwm), GFP_KERNEL);
> -	if (!tcbpwm)
> -		return -ENOMEM;
> -
>   	ret = clk_prepare_enable(tcbpwmc->clk);
> -	if (ret) {
> -		devm_kfree(chip->dev, tcbpwm);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	tcbpwm->polarity = PWM_POLARITY_NORMAL;
>   	tcbpwm->duty = 0;
> @@ -131,25 +125,20 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
>   	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), cmr);
>   	spin_unlock(&tcbpwmc->lock);
>   
> -	tcbpwmc->pwms[pwm->hwpwm] = tcbpwm;
> -
>   	return 0;
>   }
>   
>   static void atmel_tcb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>   {
>   	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> -	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
>   
>   	clk_disable_unprepare(tcbpwmc->clk);
> -	tcbpwmc->pwms[pwm->hwpwm] = NULL;
> -	devm_kfree(chip->dev, tcbpwm);
>   }
>   
>   static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>   {
>   	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> -	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
> +	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
>   	unsigned cmr;
>   	enum pwm_polarity polarity = tcbpwm->polarity;
>   
> @@ -206,7 +195,7 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>   static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>   {
>   	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> -	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
> +	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
>   	u32 cmr;
>   	enum pwm_polarity polarity = tcbpwm->polarity;
>   
> @@ -291,7 +280,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   				int duty_ns, int period_ns)
>   {
>   	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> -	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
> +	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
>   	struct atmel_tcb_pwm_device *atcbpwm = NULL;
>   	int i = 0;
>   	int slowclk = 0;
> @@ -338,9 +327,9 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   	period = div_u64(period_ns, min);
>   
>   	if (pwm->hwpwm == 0)
> -		atcbpwm = tcbpwmc->pwms[1];
> +		atcbpwm = &tcbpwmc->pwms[1];
>   	else
> -		atcbpwm = tcbpwmc->pwms[0];
> +		atcbpwm = &tcbpwmc->pwms[0];
>   
>   	/*
>   	 * PWM devices provided by the TCB driver are grouped by 2.
