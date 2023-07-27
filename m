Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728E276465F
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Jul 2023 08:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjG0GAQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Jul 2023 02:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjG0GAQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Jul 2023 02:00:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915A3BF
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jul 2023 23:00:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f25d045cso227963b3a.0
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jul 2023 23:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690437614; x=1691042414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NR+Pyc56T+/iAAep6nb3yRDcLYOleBxpEHT7wYkk8g4=;
        b=RWAlW5S6zgY4ip66LzSvG/KN0PsDlJi5/hrc5e1EnAv+gixLQZWksk3EQDfDwIRgJd
         HBJvmH/Vw3fhsDYgYxKqqgUAcpAKLYaP1l0iHyq6A37Udsd1LzIIM1mV4vS1rNxX00V3
         yesZppryxbbZoyF4les4ZLJXwVXj6CG5WVpJy22/YqVU182zZXqYNfBGtH4pJuLG/Kcg
         RrTRvwI3dTaCFLqpBsXsQ6s5sNQFOgBjqMLOWBfW3emAE/kGeu8ZQp/izni1z1ECv+nl
         3VyzVzQ3k/L0EtDWmkfVCe7riXBkDI3RDQbzdapkYlGsNwhuiO4Kq28dhk/DzU+/pQCf
         Luhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690437614; x=1691042414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NR+Pyc56T+/iAAep6nb3yRDcLYOleBxpEHT7wYkk8g4=;
        b=SyZg5wlHA22mxF02XCKikVeyXD+VcZmZEhyT5Hy9iDtvTB1w6rIiJzHxxdNLTzLfeZ
         sa5hWfcc9iBZNpruiqbuGmfWOJL2pyeHCdgwtO4UVzUSA0DsI/DAkbx77EY54Q2E8BI2
         KB8Tw2DSNEAZjfitImX0r5PRhzT2N1mtAC+4AY8WqWbSKzwUvQpYYXVzOL9TSjanpnde
         4f+P0sPtyLmz25jgWPi461bja6LANVR55xzV8xVVwJnBJCuE3Klfz3KVJSuyJO3rHDJe
         0zpZ/Lp/xdi6KtNe0EE86SCkhLMQSNkuYtSgz421zYRMrZVpj7koo9+aXhi+18jWY+p1
         4ccQ==
X-Gm-Message-State: ABy/qLarCrd6bBX+h7OSPo18z/E1OyHceEN9JXKqF8oqKkiewUKlrUIi
        hF8WEMLm2XcTAUNA6xnYy5RmIw==
X-Google-Smtp-Source: APBJJlGeJxaEx9k1ToWM2PqfkDQCZlCeT+k7Q61htwCju8IiXupJgjAB9LN4mK3cTbzUxBMgzW+4sw==
X-Received: by 2002:a05:6a00:c93:b0:67e:bf65:ae68 with SMTP id a19-20020a056a000c9300b0067ebf65ae68mr4434885pfv.3.1690437614093;
        Wed, 26 Jul 2023 23:00:14 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id l15-20020a63700f000000b00563a565e5fbsm547385pgc.9.2023.07.26.23.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 23:00:13 -0700 (PDT)
Message-ID: <21d8c545-2872-3fcc-44fc-3106d4b8def8@tuxon.dev>
Date:   Thu, 27 Jul 2023 09:00:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/5] pwm: atmel-tcb: Fix resource freeing in error path
 and remove
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
 <20230719192013.4051193-3-u.kleine-koenig@pengutronix.de>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230719192013.4051193-3-u.kleine-koenig@pengutronix.de>
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
> Several resources were not freed in the error path and the remove
> function. Add the forgotten items.
> 
> Fixes: 34cbcd72588f ("pwm: atmel-tcb: Add sama5d2 support")
> Fixes: 061f8572a31c ("pwm: atmel-tcb: Switch to new binding")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/pwm/pwm-atmel-tcb.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index 613dd1810fb5..2826fc216d29 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -450,16 +450,20 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>   	tcbpwm->clk = of_clk_get_by_name(np->parent, clk_name);
>   	if (IS_ERR(tcbpwm->clk))
>   		tcbpwm->clk = of_clk_get_by_name(np->parent, "t0_clk");
> -	if (IS_ERR(tcbpwm->clk))
> -		return PTR_ERR(tcbpwm->clk);
> +	if (IS_ERR(tcbpwm->clk)) {
> +		err = PTR_ERR(tcbpwm->clk);
> +		goto err_slow_clk;
> +	}
>   
>   	match = of_match_node(atmel_tcb_of_match, np->parent);
>   	config = match->data;
>   
>   	if (config->has_gclk) {
>   		tcbpwm->gclk = of_clk_get_by_name(np->parent, "gclk");
> -		if (IS_ERR(tcbpwm->gclk))
> -			return PTR_ERR(tcbpwm->gclk);
> +		if (IS_ERR(tcbpwm->gclk)) {
> +			err = PTR_ERR(tcbpwm->gclk);
> +			goto err_clk;
> +		}
>   	}
>   
>   	tcbpwm->chip.dev = &pdev->dev;
> @@ -470,7 +474,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>   
>   	err = clk_prepare_enable(tcbpwm->slow_clk);
>   	if (err)
> -		goto err_slow_clk;
> +		goto err_gclk;
>   
>   	spin_lock_init(&tcbpwm->lock);
>   
> @@ -485,6 +489,12 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
>   err_disable_clk:
>   	clk_disable_unprepare(tcbpwm->slow_clk);
>   
> +err_gclk:
> +	clk_put(tcbpwm->gclk);
> +
> +err_clk:
> +	clk_put(tcbpwm->clk);
> +
>   err_slow_clk:
>   	clk_put(tcbpwm->slow_clk);
>   
> @@ -498,8 +508,9 @@ static void atmel_tcb_pwm_remove(struct platform_device *pdev)
>   	pwmchip_remove(&tcbpwm->chip);
>   
>   	clk_disable_unprepare(tcbpwm->slow_clk);
> -	clk_put(tcbpwm->slow_clk);
> +	clk_put(tcbpwm->gclk);
>   	clk_put(tcbpwm->clk);
> +	clk_put(tcbpwm->slow_clk);
>   }
>   
>   static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
