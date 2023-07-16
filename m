Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE59E754EBC
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Jul 2023 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjGPNEL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 16 Jul 2023 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPNEK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 16 Jul 2023 09:04:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77EE4F
        for <linux-pwm@vger.kernel.org>; Sun, 16 Jul 2023 06:04:08 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b703d7ed3aso53130201fa.1
        for <linux-pwm@vger.kernel.org>; Sun, 16 Jul 2023 06:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1689512647; x=1692104647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G3n+3010zhKb1pnD0LKYZeehoFtnJlRKO7p/WM8vcyI=;
        b=auO2QudwRc2bDYoFXfyMmMFqsVnRRQKZc7NZXc5eqF13KqWAxSkyiQ6RzKpAmS7UIa
         H6AafNocV7hqSABp5xDy+wouki1S4p5esht27fcDdV5pHY0cpddotIUS+wX0ijfshklV
         xc87fR1oKhzteE3Fkqy32O2I6Mb/DjDflIRNy9SMiHeoT2vF2fQmezyInJmose8fvzlO
         g2ntZLvVKwiRKSStnjC1+/W8qCeaJXTBSoWREsZLIcOfznIyZXjaJsALL4fvQSvtAZxN
         vJP9ITer0mwMeaSars6Q3XrNQmhL+S2lOr9k/zQGRvnt3Iw3SH+mPEQukIyBobL2723o
         wdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689512647; x=1692104647;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3n+3010zhKb1pnD0LKYZeehoFtnJlRKO7p/WM8vcyI=;
        b=jKyNLmYoxOVCkJhucTIXwNGGYBuOvglp59nOt20YiZh14QvSTJswgmnHkMwlk0tLA1
         tWER9JeD8usCrCok48scSgMKbMuwKjBzRmEObR4DDvd06NGUMeE5UxtIb9HABO29wV/U
         /r6obQ6XqGTE41en0ZHPa9WqH2MELcZRQYKdLHcNHRImgy00AeY43Z+9/Ow4tqOe/Nlo
         VJFwDG9MKjMgH3yqllmddsYnNYcrDNfji63XtaoG8ZWd0EY3TEsXMi+sOHdYnceWzxin
         e9aBUtM2kODQe03SSyaAqJgGNpplgTs4TNuAHjK8jjsgmaQo9sgFyA/GdP88UOaw/rlx
         KBiw==
X-Gm-Message-State: ABy/qLbD9/gFJvRqKOiBROdnt0ox2BY0HeeQwdcxhBSeYOc7W18kB+yZ
        gDvHeoYrQQTQaZKNYbEG8WeSvVgNZEV+wIk3o7KLkGK8
X-Google-Smtp-Source: APBJJlFgEkwbmPnyBlSb/oVIB9UtXQ21fc9/h04Lo2tsEC5yKbiJWiCiXAv2pHKAVBtywgqdE11Psg==
X-Received: by 2002:a2e:2c05:0:b0:2b7:842:a64c with SMTP id s5-20020a2e2c05000000b002b70842a64cmr6516526ljs.5.1689512646612;
        Sun, 16 Jul 2023 06:04:06 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id y24-20020a170906471800b00992b71d8f19sm7910025ejq.133.2023.07.16.06.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 06:04:06 -0700 (PDT)
Message-ID: <9a0cb190-9344-dc26-b3dd-9895690e886f@tuxon.dev>
Date:   Sun, 16 Jul 2023 16:04:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/10] pwm: atmel-hlcdc: Use consistent variable naming
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
 <20230714205623.2496590-3-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230714205623.2496590-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 14.07.2023 23:56, Uwe Kleine-König wrote:
> In pwm drivers the variable name "chip" is usually only used for struct
> pwm_chip pointers. This driver however used "chip" for its driver data
> and pwm_chip pointers are named "chip", too, when there is no driver
> data around and "c" otherwise. Instead use "ddata" for driver data and
> always "chip" for pwm_chips.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/pwm/pwm-atmel-hlcdc.c | 64 +++++++++++++++++------------------
>   1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index 96a709a9d49a..9b0165d61c49 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -38,11 +38,11 @@ static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
>   	return container_of(chip, struct atmel_hlcdc_pwm, chip);
>   }
>   
> -static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
> +static int atmel_hlcdc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   				 const struct pwm_state *state)
>   {
> -	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
> -	struct atmel_hlcdc *hlcdc = chip->hlcdc;
> +	struct atmel_hlcdc_pwm *ddata = to_atmel_hlcdc_pwm(chip);
> +	struct atmel_hlcdc *hlcdc = ddata->hlcdc;
>   	unsigned int status;
>   	int ret;
>   
> @@ -54,7 +54,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>   		u32 pwmcfg;
>   		int pres;
>   
> -		if (!chip->errata || !chip->errata->slow_clk_erratum) {
> +		if (!ddata->errata || !ddata->errata->slow_clk_erratum) {
>   			clk_freq = clk_get_rate(new_clk);
>   			if (!clk_freq)
>   				return -EINVAL;
> @@ -64,7 +64,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>   		}
>   
>   		/* Errata: cannot use slow clk on some IP revisions */
> -		if ((chip->errata && chip->errata->slow_clk_erratum) ||
> +		if ((ddata->errata && ddata->errata->slow_clk_erratum) ||
>   		    clk_period_ns > state->period) {
>   			new_clk = hlcdc->sys_clk;
>   			clk_freq = clk_get_rate(new_clk);
> @@ -77,8 +77,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>   
>   		for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
>   		/* Errata: cannot divide by 1 on some IP revisions */
> -			if (!pres && chip->errata &&
> -			    chip->errata->div1_clk_erratum)
> +			if (!pres && ddata->errata &&
> +			    ddata->errata->div1_clk_erratum)
>   				continue;
>   
>   			if ((clk_period_ns << pres) >= state->period)
> @@ -90,7 +90,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>   
>   		pwmcfg = ATMEL_HLCDC_PWMPS(pres);
>   
> -		if (new_clk != chip->cur_clk) {
> +		if (new_clk != ddata->cur_clk) {
>   			u32 gencfg = 0;
>   			int ret;
>   
> @@ -98,8 +98,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>   			if (ret)
>   				return ret;
>   
> -			clk_disable_unprepare(chip->cur_clk);
> -			chip->cur_clk = new_clk;
> +			clk_disable_unprepare(ddata->cur_clk);
> +			ddata->cur_clk = new_clk;
>   
>   			if (new_clk == hlcdc->sys_clk)
>   				gencfg = ATMEL_HLCDC_CLKPWMSEL;
> @@ -160,8 +160,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
>   		if (ret)
>   			return ret;
>   
> -		clk_disable_unprepare(chip->cur_clk);
> -		chip->cur_clk = NULL;
> +		clk_disable_unprepare(ddata->cur_clk);
> +		ddata->cur_clk = NULL;
>   	}
>   
>   	return 0;
> @@ -183,31 +183,31 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
>   #ifdef CONFIG_PM_SLEEP
>   static int atmel_hlcdc_pwm_suspend(struct device *dev)
>   {
> -	struct atmel_hlcdc_pwm *chip = dev_get_drvdata(dev);
> +	struct atmel_hlcdc_pwm *ddata = dev_get_drvdata(dev);
>   
>   	/* Keep the periph clock enabled if the PWM is still running. */
> -	if (pwm_is_enabled(&chip->chip.pwms[0]))
> -		clk_disable_unprepare(chip->hlcdc->periph_clk);
> +	if (pwm_is_enabled(&ddata->chip.pwms[0]))
> +		clk_disable_unprepare(ddata->hlcdc->periph_clk);
>   
>   	return 0;
>   }
>   
>   static int atmel_hlcdc_pwm_resume(struct device *dev)
>   {
> -	struct atmel_hlcdc_pwm *chip = dev_get_drvdata(dev);
> +	struct atmel_hlcdc_pwm *ddata = dev_get_drvdata(dev);
>   	struct pwm_state state;
>   	int ret;
>   
> -	pwm_get_state(&chip->chip.pwms[0], &state);
> +	pwm_get_state(&ddata->chip.pwms[0], &state);
>   
>   	/* Re-enable the periph clock it was stopped during suspend. */
>   	if (!state.enabled) {
> -		ret = clk_prepare_enable(chip->hlcdc->periph_clk);
> +		ret = clk_prepare_enable(ddata->hlcdc->periph_clk);
>   		if (ret)
>   			return ret;
>   	}
>   
> -	return atmel_hlcdc_pwm_apply(&chip->chip, &chip->chip.pwms[0], &state);
> +	return atmel_hlcdc_pwm_apply(&ddata->chip, &ddata->chip.pwms[0], &state);
>   }
>   #endif
>   
> @@ -244,14 +244,14 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
>   {
>   	const struct of_device_id *match;
>   	struct device *dev = &pdev->dev;
> -	struct atmel_hlcdc_pwm *chip;
> +	struct atmel_hlcdc_pwm *ddata;
>   	struct atmel_hlcdc *hlcdc;
>   	int ret;
>   
>   	hlcdc = dev_get_drvdata(dev->parent);
>   
> -	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
> -	if (!chip)
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
>   		return -ENOMEM;
>   
>   	ret = clk_prepare_enable(hlcdc->periph_clk);
> @@ -260,31 +260,31 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
>   
>   	match = of_match_node(atmel_hlcdc_dt_ids, dev->parent->of_node);
>   	if (match)
> -		chip->errata = match->data;
> +		ddata->errata = match->data;
>   
> -	chip->hlcdc = hlcdc;
> -	chip->chip.ops = &atmel_hlcdc_pwm_ops;
> -	chip->chip.dev = dev;
> -	chip->chip.npwm = 1;
> +	ddata->hlcdc = hlcdc;
> +	ddata->chip.ops = &atmel_hlcdc_pwm_ops;
> +	ddata->chip.dev = dev;
> +	ddata->chip.npwm = 1;
>   
> -	ret = pwmchip_add(&chip->chip);
> +	ret = pwmchip_add(&ddata->chip);
>   	if (ret) {
>   		clk_disable_unprepare(hlcdc->periph_clk);
>   		return ret;
>   	}
>   
> -	platform_set_drvdata(pdev, chip);
> +	platform_set_drvdata(pdev, ddata);
>   
>   	return 0;
>   }
>   
>   static void atmel_hlcdc_pwm_remove(struct platform_device *pdev)
>   {
> -	struct atmel_hlcdc_pwm *chip = platform_get_drvdata(pdev);
> +	struct atmel_hlcdc_pwm *ddata = platform_get_drvdata(pdev);
>   
> -	pwmchip_remove(&chip->chip);
> +	pwmchip_remove(&ddata->chip);
>   
> -	clk_disable_unprepare(chip->hlcdc->periph_clk);
> +	clk_disable_unprepare(ddata->hlcdc->periph_clk);
>   }
>   
>   static const struct of_device_id atmel_hlcdc_pwm_dt_ids[] = {
