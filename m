Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C87592715
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Aug 2022 02:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiHOA2f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Aug 2022 20:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiHOA2e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Aug 2022 20:28:34 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6557211C17;
        Sun, 14 Aug 2022 17:28:33 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id u6so6243742ljk.8;
        Sun, 14 Aug 2022 17:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wVGrDx7bU3n8ZRW+AvMmVZX6ojYLgjzVC65SOElFzvo=;
        b=ln2RfCZsX6OjdcZAxfxA5aVak2ihaSLbhmDAwRFx6N0EvYyNCHxYLb9JU07ngGvzjL
         IukSUotVEoe7C6Vj8klHPnDvLgPl4BISbEU8Ec02ECuhSKXc93lqAPAbqoZLJ+VlDAcZ
         Y1P80x3VaPH8Gt6z+ozv0waiSdV70ajiY2qYRsCtDsXq/tzxJBivDRinxCZ1MIXgBT+i
         6GiX7EC6HIHHj2YhRins/BytPn9BDZr3/DBjWDjBdZfmDSitywePNo6uXoizzN3vKgCc
         WXLUExj354s/54mDudL5spIYD+C/m8SSLfP9DRDVljbbFTXsl4SX7henTzUIinI9ELAY
         /bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wVGrDx7bU3n8ZRW+AvMmVZX6ojYLgjzVC65SOElFzvo=;
        b=kVbOMpjnatNBxT7PR7UL+GboJvNUeof9V7jKW1ow6pum6leOXUWatL1MspqLGaXD+E
         EZyi3boYOjFAtbtQDdtAXVy+uDg07IBDBWxZOSbJBh/jIS/ukMnxzVyVoXLyKd2SlJhr
         HcuLjT8w4ddoJMeu1KAKxXwuh+VzPmILfoWxUva8qyCbbyiCXsR+WGc4O4+0TuNqdOuc
         02DOsGsmIPHkLg9EIq7HrHgv7qZmajQUvFr7w2dGG5eEt5I3MRvqpEiSij8FCyW1VqNT
         soeA424jWnVXmsqA1JFPKuTjXfD2ZQafZS16ww8PHTPGtkN/dvED7URsku7YVg9Xn61M
         TXfg==
X-Gm-Message-State: ACgBeo2kLTwIdOtI4cSkyzSVtR/AIPp54RrWpiW8ZYJTI5EAta7KzGPO
        WghAecJAU0HQxHXBBrs+sN8=
X-Google-Smtp-Source: AA6agR7O++NYO5xMUwV6kEnlkvfpRZWADLjxGvnmLPMR8uwkUGwPdvX7DvsMk4dhxuyegXLg9h34Jw==
X-Received: by 2002:a2e:3112:0:b0:24f:132a:fd71 with SMTP id x18-20020a2e3112000000b0024f132afd71mr3962021ljx.522.1660523311732;
        Sun, 14 Aug 2022 17:28:31 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.119.13])
        by smtp.googlemail.com with ESMTPSA id z7-20020a2eb527000000b0025e337443dcsm1233333ljm.87.2022.08.14.17.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 17:28:31 -0700 (PDT)
Message-ID: <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
Date:   Mon, 15 Aug 2022 03:28:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

25.04.2022 16:22, Uwe Kleine-König пишет:
> Dividing by the result of a division looses precision because the result is
> rounded twice. E.g. with clk_rate = 48000000 and period = 32760033 the
> following numbers result:
> 
> 	rate = pc->clk_rate >> PWM_DUTY_WIDTH = 187500
> 	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns) = 3052
> 	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz) = 6144
> 
> The exact result would be 6142.5061875 and (apart from rounding) this is
> found by using a single division. As a side effect is also a tad
> cheaper to calculate.
> 
> Also using clk_rate >> PWM_DUTY_WIDTH looses precision. Consider for
> example clk_rate = 47999999 and period = 106667:
> 
> 	mul_u64_u64_div_u64(pc->clk_rate >> PWM_DUTY_WIDTH, period_ns,
> 			    NSEC_PER_SEC) = 19
> 
> 	mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> 			    NSEC_PER_SEC << PWM_DUTY_WIDTH) = 20
> 
> (The exact result is 20.000062083332033.)
> 
> With this optimizations also switch from round-closest to round-down for
> the period calculation. Given that the calculations were non-optimal for
> quite some time now with variations in both directions which nobody
> reported as a problem, this is the opportunity to align the driver's
> behavior to the requirements of new drivers. This has several upsides:
> 
>  - Implementation is easier as there are no round-nearest variants of
>    mul_u64_u64_div_u64().
>  - Requests for too small periods are now consistently refused. This was
>    kind of arbitrary before, where period_ns < min_period_ns was
>    refused, but in some cases min_period_ns isn't actually implementable
>    and then values between min_period_ns and the actual minimum were
>    rounded up to the actual minimum.
> 
> Note that the duty_cycle calculation isn't using the usual round-down
> approach yet.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> changes since (implicit) v1: Updated changelog to explain why rate = 0
> is refused now.
> 
> Best regards
> Uwe
> 
>  drivers/pwm/pwm-tegra.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index e5a9ffef4a71..7fc03a9ec154 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -99,7 +99,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			    int duty_ns, int period_ns)
>  {
>  	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
> -	unsigned long long c = duty_ns, hz;
> +	unsigned long long c = duty_ns;
>  	unsigned long rate, required_clk_rate;
>  	u32 val = 0;
>  	int err;
> @@ -156,11 +156,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		pc->clk_rate = clk_get_rate(pc->clk);
>  	}
>  
> -	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
> -
>  	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> -	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
> -	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
> +	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> +				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
>  
>  	/*
>  	 * Since the actual PWM divider is the register's frequency divider
> @@ -169,6 +167,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 */
>  	if (rate > 0)
>  		rate--;
> +	else
> +		return -EINVAL;

This patch broke backlight on Asus Transformer tablets, they are now
getting this -EINVAL. The root of the problem is under investigation.

Should we revert this patch meantime or maybe you (Uwe/Thierry) have an
idea about what actually has gone wrong here? Thanks in advance.

>  	/*
>  	 * Make sure that the rate will fit in the register's frequency
> 
> base-commit: 2bf8ee0faa988b5cec3503ebf2f970a0e84d24ee

