Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58476465A
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jul 2023 07:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjG0F7n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jul 2023 01:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjG0F7m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jul 2023 01:59:42 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4324F94
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jul 2023 22:59:41 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1a28de15c8aso522122fac.2
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jul 2023 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690437580; x=1691042380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gt22TqQ8ghDnrhlwqflaEUuOLAWst+A9lTaKuY+EuqQ=;
        b=KfhYiOiaezJr/Ibb9qovf6fhc2BoeqJnKJB9ModdeDrsf28AdK+HuFQU6fyIWla9Zl
         pu5GtMoWnFSW6qa7+MIED/hWMBf3sWDECi2CgUkv/wpaDJlCDp80tc7xId7GU6XEU722
         ld0BeG+4Dz+lxhy/RilxgQkdRwn3XIHlyNaeZXuM92uQZ9YJdHkd+GaIq8G/MxJPHyq2
         Nwp15DDkcvcO++tOAXunx2TUPcRO947mVwFYp9W33jCnxBwoq1CNMoxv8eiVhhxKcNbi
         fnmowA9UViEDjDkvWxYcIjoQ1shN98strLz7ysmoqpGDyQjXjrb0pCksS88kJjn8gMwc
         AzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690437580; x=1691042380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gt22TqQ8ghDnrhlwqflaEUuOLAWst+A9lTaKuY+EuqQ=;
        b=GRg72qss5qiNdcWgEVEKuKxPiiQlMQLFOU6ffaGzB0NTpa+TB8pSTXjvfQpwURQxDl
         WkWyIFqXXgAkw5wWiPDVqKw1DKlggwuNdg8vJdXVBDKAdOw+jSeUdhspry16T/EwZ3+t
         08akaGuARIUHAZhJ4+1TswSQdbpyWFXjc3+4u6xa/WFCiz2UEUpUI6hwWQMzTVyZ9dxb
         ymRDv1KnbQToLC2fMvted1rjmsh5g75JneMt6pOTjEV/dEC4+EVeAgn/KLZBcO4Xj6oi
         SKZMBQ/EW9xYNkGyD2LI6BPhdoh/X80ZA+WM2AFOvCJdz0ErjINyS1zLEsazGOHh3PQ3
         m4Lg==
X-Gm-Message-State: ABy/qLZkjD3og5GJER6v75y44XqA79h2TuwJGjjpdxcvGYdAfbThKbSC
        BGjZP1DboeW+5lDqLqG4W8Ky1g==
X-Google-Smtp-Source: APBJJlF0WWfDysWyFbO+9gAdMR/2+zWRKGY3DewsMjdCIAkRZixXfAcqDzX1r3RK3useuKJrRjwcvQ==
X-Received: by 2002:a05:6870:c1d4:b0:1bb:d808:da72 with SMTP id i20-20020a056870c1d400b001bbd808da72mr1162974oad.57.1690437580561;
        Wed, 26 Jul 2023 22:59:40 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090a024600b002682392506bsm507688pje.50.2023.07.26.22.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 22:59:40 -0700 (PDT)
Message-ID: <7027b456-8f77-56d7-f6a2-89049685244a@tuxon.dev>
Date:   Thu, 27 Jul 2023 08:59:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/5] pwm: atmel-tcb: Don't track polarity in driver data
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
 <20230719192013.4051193-6-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230719192013.4051193-6-u.kleine-koenig@pengutronix.de>
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
> struct atmel_tcb_pwm_device::polarity is only used in atmel_tcb_pwm_enable
> and atmel_tcb_pwm_disable(). These functions are only called by
> atmel_tcb_pwm_apply() after the member variable was assigned to
> state->polarity. So the value assigned in atmel_tcb_pwm_request() is
> never used and the member can be dropped from struct atmel_tcb_pwm_device.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/pwm/pwm-atmel-tcb.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 32a60d7f8ed2..30c966238e41 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -34,7 +34,6 @@
>   				 ATMEL_TC_BEEVT | ATMEL_TC_BSWTRG)
>   
>   struct atmel_tcb_pwm_device {
> -	enum pwm_polarity polarity;	/* PWM polarity */
>   	unsigned div;			/* PWM clock divider */
>   	unsigned duty;			/* PWM duty expressed in clk cycles */
>   	unsigned period;		/* PWM period expressed in clk cycles */
> @@ -80,7 +79,6 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
>   	if (ret)
>   		return ret;
>   
> -	tcbpwm->polarity = PWM_POLARITY_NORMAL;
>   	tcbpwm->duty = 0;
>   	tcbpwm->period = 0;
>   	tcbpwm->div = 0;
> @@ -123,12 +121,12 @@ static void atmel_tcb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>   	clk_disable_unprepare(tcbpwmc->clk);
>   }
>   
> -static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> +static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
> +				  enum pwm_polarity polarity)
>   {
>   	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
>   	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
>   	unsigned cmr;
> -	enum pwm_polarity polarity = tcbpwm->polarity;
>   
>   	/*
>   	 * If duty is 0 the timer will be stopped and we have to
> @@ -180,12 +178,12 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>   	spin_unlock(&tcbpwmc->lock);
>   }
>   
> -static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
> +				enum pwm_polarity polarity)
>   {
>   	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
>   	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
>   	u32 cmr;
> -	enum pwm_polarity polarity = tcbpwm->polarity;
>   
>   	/*
>   	 * If duty is 0 the timer will be stopped and we have to
> @@ -345,15 +343,11 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   			       const struct pwm_state *state)
>   {
> -	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
> -	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
>   	int duty_cycle, period;
>   	int ret;
>   
> -	tcbpwm->polarity = state->polarity;
> -
>   	if (!state->enabled) {
> -		atmel_tcb_pwm_disable(chip, pwm);
> +		atmel_tcb_pwm_disable(chip, pwm, state->polarity);
>   		return 0;
>   	}
>   
> @@ -364,7 +358,7 @@ static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (ret)
>   		return ret;
>   
> -	return atmel_tcb_pwm_enable(chip, pwm);
> +	return atmel_tcb_pwm_enable(chip, pwm, state->polarity);
>   }
>   
>   static const struct pwm_ops atmel_tcb_pwm_ops = {
