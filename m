Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD550BB61
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Apr 2022 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449266AbiDVPOO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Apr 2022 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449248AbiDVPOK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Apr 2022 11:14:10 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA315C644
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 08:11:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lc2so16919381ejb.12
        for <linux-pwm@vger.kernel.org>; Fri, 22 Apr 2022 08:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SeO0vNa1HE4HcltpbkqIZSKEWB47bbqKOHu5Xk37zAA=;
        b=xxUN49VNwEnek9favYympNNETThqPVPrMnobuHO2Yqg/GRztc9VaKGKUhE71kEQ2Mk
         BaHClyKQ+uejt9e2ChZZKHXMxQTsfX/OHveBeITpfgtJgNqXkICJXDN+X99J0qxhsZrV
         BJiUlopGwPArZNk2EII1zKeyYBuRnNpHsm/DKXWLIJvih1EplTNsmbLT6Sa3unRLAbeK
         13IOkC2QDmBg43PHTS6vZMUE8RJGJqqOphq8sCDx5B5tMM9773U+/bAd1fIlF+9EX7yO
         V4v/KhOf/ZvQJvprYBnWorzKFtZbNI8cF2JY/zvmcgt+faq5r+57zWNFDpTns2EOSTR/
         sB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SeO0vNa1HE4HcltpbkqIZSKEWB47bbqKOHu5Xk37zAA=;
        b=aVjCui0+WjNLxpW8cSwPZPBLnPh1lFUj9jmXrY/OMhwG5+uXjGv92TQCeErPGWscF0
         AlP1e6uHDHREvtfV2b7PFlEx9ULRK6ciekKh7ZpCXNwaumGgtgnrGus6ZKWSpuhUq8Jy
         /hLhT0AMIlRU5S3K1VulO+QarFcFgmnobk9CWr51gkiCQCsHcfWKIjKTF6ORVXrkhcfK
         48uilbbi2df4AJgY2ty5ellCBYHBFCxwwas4Jn60jNOIKdr5TZ6hUZ2wYDKeWDjKI0fg
         X53aMFlB61E48HhW524MRu1IMpsy2b6+8NqCZmiGjRg3EBC1TlHbIBbBLVFBJZVWxz8b
         SXTA==
X-Gm-Message-State: AOAM5321JlhT0UqKUez3TIMeYNLwor+/8aZq97OKUE2yZw/f35I9AcHY
        gR76EfwOVSFWdMnPyQS32Pvudw==
X-Google-Smtp-Source: ABdhPJwVbSVzyNaErXBXSs9R0PZZIBlze+R+lG7jet6UNScP2xYcw1IBd3+dZu5c16FNTJYIBIhxUw==
X-Received: by 2002:a17:907:d8c:b0:6f0:1091:de34 with SMTP id go12-20020a1709070d8c00b006f01091de34mr4579605ejc.376.1650640264000;
        Fri, 22 Apr 2022 08:11:04 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id l19-20020a1709067d5300b006e8488d9a80sm844351ejp.59.2022.04.22.08.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:11:03 -0700 (PDT)
Message-ID: <d7030fc5-3165-0255-0055-b2bc2e387d53@linaro.org>
Date:   Fri, 22 Apr 2022 17:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] pwm: samsung: Implement .apply() callback
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
References: <20220328073434.44848-1-u.kleine-koenig@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220328073434.44848-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 28/03/2022 09:34, Uwe Kleine-König wrote:
> To eventually get rid of all legacy drivers convert this driver to the
> modern world implementing .apply().
> 
> The size check for state->period is moved to .apply() to make sure that
> the values of state->duty_cycle and state->period are passed to
> pwm_samsung_config without change while they are discarded to int.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/pwm-samsung.c | 54 ++++++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index 0a4ff55fad04..9c5b4f515641 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -321,14 +321,6 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	struct samsung_pwm_channel *chan = pwm_get_chip_data(pwm);
>  	u32 tin_ns = chan->tin_ns, tcnt, tcmp, oldtcmp;
>  
> -	/*
> -	 * We currently avoid using 64bit arithmetic by using the
> -	 * fact that anything faster than 1Hz is easily representable
> -	 * by 32bits.
> -	 */
> -	if (period_ns > NSEC_PER_SEC)
> -		return -ERANGE;
> -
>  	tcnt = readl(our_chip->base + REG_TCNTB(pwm->hwpwm));
>  	oldtcmp = readl(our_chip->base + REG_TCMPB(pwm->hwpwm));
>  
> @@ -438,13 +430,51 @@ static int pwm_samsung_set_polarity(struct pwm_chip *chip,
>  	return 0;
>  }
>  
> +static int pwm_samsung_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	int err, enabled = pwm->state.enabled;
> +
> +	if (state->polarity != pwm->state.polarity) {
> +		if (enabled) {
> +			pwm_samsung_disable(chip, pwm);
> +			enabled = false;
> +		}
> +
> +		err = pwm_samsung_set_polarity(chip, pwm, state->polarity);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (!state->enabled) {
> +		if (enabled)
> +			pwm_samsung_disable(chip, pwm);
> +
> +		return 0;
> +	}
> +
> +	/*
> +	 * We currently avoid using 64bit arithmetic by using the
> +	 * fact that anything faster than 1Hz is easily representable
> +	 * by 32bits.
> +	 */
> +	if (state->period > NSEC_PER_SEC)

Isn't this changing a bit logic in case of setting wrong period and
inverted signal?

Before, the config would return early and do nothing. Now, you disable
the PWM, check the condition here and exit with PWM disabled. I think
this should reverse the tasks done, or the check should be done early.

> +		return -ERANGE;
> +
> +	err = pwm_samsung_config(chip, pwm, state->duty_cycle, state->period);
> +	if (err)
> +		return err;

Best regards,
Krzysztof
