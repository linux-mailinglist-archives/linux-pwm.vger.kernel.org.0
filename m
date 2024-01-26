Return-Path: <linux-pwm+bounces-1095-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA8083DCB0
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 15:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD951C21C55
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jan 2024 14:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213841C69F;
	Fri, 26 Jan 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="W7f4f7O3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744481C692
	for <linux-pwm@vger.kernel.org>; Fri, 26 Jan 2024 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280381; cv=none; b=cqCM3IY9hyYWP9FhOVBnTEFL7w1ghcQaOLwulW6qOrOi00t5ZeD1CUaDi5RP+x96SRbm//XZB24gVb3lAcVR//qpyfAgFfaijzf5K0fdPkVcXzi5yTdX8O57pyBWCzXfznydpEJOlU/0P8bSyByFeOP8vMIR49lx9EVABpALwWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280381; c=relaxed/simple;
	bh=0V8JBIlo3s3yy0bsJM3VckFK6/jXB/aOGdamcekgcPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRfwjHqi3sEVVKVdts0pBjPWuz2Jw8Nb8Zsu3My55WqjBPgJK6NA2uARPHHY0+HrfHDW6OKGGhm+AQLq/UiZE0dlBjOnI/JE+oXoCpKuoLo3tDcvhfwhGgXnX0+IaGwLsGLE64Ra6C9XJaR1JzQR35seoD/shTm8PpclU6ddKpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=W7f4f7O3; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bfd0e99154so4096339f.1
        for <linux-pwm@vger.kernel.org>; Fri, 26 Jan 2024 06:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1706280377; x=1706885177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+fOeMhswGKKywc98Ol+L/tQdueW05KSRu1NRm5hdKMU=;
        b=W7f4f7O3s/YUo8zsgBrnlSRE+K5FgNIcfFxNK/AlVTzQn7kZEPRbp5F8vmN00PDJOy
         VsSw7meGIBDQCQJxZRadhTiYYzMcmgV8Hj4xId8Gr2HtvF7S/a1MCgzugva04ylLvGYo
         V8jLVRK+UiFkjGqYPajI2nYLmYdVWpF8NZTzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706280377; x=1706885177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+fOeMhswGKKywc98Ol+L/tQdueW05KSRu1NRm5hdKMU=;
        b=RQfFTgzkHAUGqpsOBdI84G8bcO3MqC69K17LJ2I4ry3ckkXEEbnqee7rt26dJlKAGK
         R+9uwQdEHnpz/04j9eSNX9E2IpiHzecjteCUUEqt2eTQIGUQfG8biXjtUlXeEm2QkLrU
         OeiHrM8qEgkTSc6jtpuuMNwVsdR3UUcLKj5srxLgvweOK+T6MyLD0orcu3VpYy7dbCfQ
         ahp75RV6qU5DHLfuCo7bUUDQFrXNtjTPUwiczUfTch9yEWFf7ymOQFTQSB6KfcmgpVDv
         lnpX/Dze9n6N4QaPn9RHhLpqTc73Bp6Xq9vtmpuKBioFJrjJUyy1eyyVftBObdZy7adU
         qxHg==
X-Gm-Message-State: AOJu0YyCPcM3p5zNUAASbWvUiu6Je2Y1TmS3xWaYAWbAY4wD6Rye3wB6
	qaUhdPkjoZeccFrkTEJUlSxQUwFQpyOA7S1j2E8ZQaKk425FBc9Ffwozl3U0VA==
X-Google-Smtp-Source: AGHT+IHPKNTTIuqxmxUXX+GYDw5eJqWPMSNjv7gvon8UkNl63wZGZwG0UoFW7ov83g+zHjLtZvF2MQ==
X-Received: by 2002:a5e:870d:0:b0:7bf:1ddd:b900 with SMTP id y13-20020a5e870d000000b007bf1dddb900mr2060688ioj.8.1706280377416;
        Fri, 26 Jan 2024 06:46:17 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id n13-20020a5ed90d000000b007befaf58e52sm396589iop.30.2024.01.26.06.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 06:46:16 -0800 (PST)
Message-ID: <c796d34c-0076-488b-9643-8ecfdaa2a32b@ieee.org>
Date: Fri, 26 Jan 2024 08:46:15 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 038/111] staging: greybus: pwm: Make use of
 pwmchip_parent() macro
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pwm@vger.kernel.org
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 kernel@pengutronix.de
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
 <57b2e034d878c39d472d9dfc86b2c39272e4eabf.1706182805.git.u.kleine-koenig@pengutronix.de>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <57b2e034d878c39d472d9dfc86b2c39272e4eabf.1706182805.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/25/24 6:09 AM, Uwe Kleine-König wrote:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the macro
> provided for exactly this purpose.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I think I'd rather see the footprint of your change be much
smaller than it is.  Please see below.

					-Alex

> ---
>   drivers/staging/greybus/pwm.c | 55 +++++++++++++++++------------------
>   1 file changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> index a3cb68cfa0f9..75e0518791d8 100644
> --- a/drivers/staging/greybus/pwm.c
> +++ b/drivers/staging/greybus/pwm.c
> @@ -17,7 +17,6 @@
>   struct gb_pwm_chip {
>   	struct gb_connection	*connection;
>   	u8			pwm_max;	/* max pwm number */
> -
>   	struct pwm_chip		chip;
>   };
>   
> @@ -39,9 +38,9 @@ static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
>   	return 0;
>   }
>   
> -static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
> -				     u8 which)
> +static int gb_pwm_activate_operation(struct pwm_chip *chip, u8 which)

Why change the type of the argument here?

>   {
> +	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>   	struct gb_pwm_activate_request request;
>   	struct gbphy_device *gbphy_dev;
>   	int ret;
> @@ -51,7 +50,7 @@ static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
>   
>   	request.which = which;
>   
> -	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
> +	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));

Just make this line look like this:

	gbphy_dev = to_gbphy_dev(pwmchip_parent(&pwmc->chip));

>   	ret = gbphy_runtime_get_sync(gbphy_dev);
>   	if (ret)
>   		return ret;
> @@ -64,9 +63,10 @@ static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
>   	return ret;
>   }
>   
> -static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
> +static int gb_pwm_deactivate_operation(struct pwm_chip *chip,
>   				       u8 which)

Same question here.

>   {
> +	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>   	struct gb_pwm_deactivate_request request;
>   	struct gbphy_device *gbphy_dev;
>   	int ret;
> @@ -76,7 +76,7 @@ static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
>   
>   	request.which = which;
>   
> -	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
> +	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));

	gbphy_dev = to_gbphy_dev(pwmchip_parent(&pwmc->chip));

>   	ret = gbphy_runtime_get_sync(gbphy_dev);
>   	if (ret)
>   		return ret;
> @@ -89,9 +89,10 @@ static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
>   	return ret;
>   }
>   
> -static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
> +static int gb_pwm_config_operation(struct pwm_chip *chip,
>   				   u8 which, u32 duty, u32 period)

And here.

>   {
> +	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>   	struct gb_pwm_config_request request;
>   	struct gbphy_device *gbphy_dev;
>   	int ret;
> @@ -103,7 +104,7 @@ static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
>   	request.duty = cpu_to_le32(duty);
>   	request.period = cpu_to_le32(period);
>   
> -	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
> +	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));

	gbphy_dev = to_gbphy_dev(pwmchip_parent(&pwmc->chip));

>   	ret = gbphy_runtime_get_sync(gbphy_dev);
>   	if (ret)
>   		return ret;
> @@ -116,9 +117,10 @@ static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
>   	return ret;
>   }
>   
> -static int gb_pwm_set_polarity_operation(struct gb_pwm_chip *pwmc,
> +static int gb_pwm_set_polarity_operation(struct pwm_chip *chip,
>   					 u8 which, u8 polarity)

And here.

>   {
> +	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>   	struct gb_pwm_polarity_request request;
>   	struct gbphy_device *gbphy_dev;
>   	int ret;
> @@ -129,7 +131,7 @@ static int gb_pwm_set_polarity_operation(struct gb_pwm_chip *pwmc,
>   	request.which = which;
>   	request.polarity = polarity;
>   
> -	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
> +	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));

	gbphy_dev = to_gbphy_dev(pwmchip_parent(&pwmc->chip));

>   	ret = gbphy_runtime_get_sync(gbphy_dev);
>   	if (ret)
>   		return ret;
> @@ -142,9 +144,9 @@ static int gb_pwm_set_polarity_operation(struct gb_pwm_chip *pwmc,
>   	return ret;
>   }
>   
> -static int gb_pwm_enable_operation(struct gb_pwm_chip *pwmc,
> -				   u8 which)
> +static int gb_pwm_enable_operation(struct pwm_chip *chip, u8 which)

And on and on.

>   {
> +	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>   	struct gb_pwm_enable_request request;
>   	struct gbphy_device *gbphy_dev;
>   	int ret;
> @@ -154,7 +156,7 @@ static int gb_pwm_enable_operation(struct gb_pwm_chip *pwmc,
>   
>   	request.which = which;
>   
> -	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
> +	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
>   	ret = gbphy_runtime_get_sync(gbphy_dev);
>   	if (ret)
>   		return ret;
> @@ -167,9 +169,9 @@ static int gb_pwm_enable_operation(struct gb_pwm_chip *pwmc,
>   	return ret;
>   }
>   
> -static int gb_pwm_disable_operation(struct gb_pwm_chip *pwmc,
> -				    u8 which)
> +static int gb_pwm_disable_operation(struct pwm_chip *chip, u8 which)
>   {
> +	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>   	struct gb_pwm_disable_request request;
>   	struct gbphy_device *gbphy_dev;
>   	int ret;
> @@ -182,7 +184,7 @@ static int gb_pwm_disable_operation(struct gb_pwm_chip *pwmc,
>   	ret = gb_operation_sync(pwmc->connection, GB_PWM_TYPE_DISABLE,
>   				&request, sizeof(request), NULL, 0);
>   
> -	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
> +	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
>   	gbphy_runtime_put_autosuspend(gbphy_dev);
>   
>   	return ret;
> @@ -190,19 +192,15 @@ static int gb_pwm_disable_operation(struct gb_pwm_chip *pwmc,
>   
>   static int gb_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>   {

I guess my question now is, why don't this function and the
next one take a gb_pwm_chip pointer as argument like the rest...
(Not your problem--don't "fix" this in this series.)

> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
> -
> -	return gb_pwm_activate_operation(pwmc, pwm->hwpwm);
> +	return gb_pwm_activate_operation(chip, pwm->hwpwm);
>   };
>   
>   static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>   {
> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
> -
>   	if (pwm_is_enabled(pwm))
> -		dev_warn(chip->dev, "freeing PWM device without disabling\n");
> +		dev_warn(pwmchip_parent(chip), "freeing PWM device without disabling\n");
>   
> -	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
> +	gb_pwm_deactivate_operation(chip, pwm->hwpwm);
>   }
>   
>   static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -212,22 +210,21 @@ static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	bool enabled = pwm->state.enabled;
>   	u64 period = state->period;
>   	u64 duty_cycle = state->duty_cycle;
> -	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
>   
>   	/* Set polarity */
>   	if (state->polarity != pwm->state.polarity) {
>   		if (enabled) {
> -			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> +			gb_pwm_disable_operation(chip, pwm->hwpwm);
>   			enabled = false;
>   		}
> -		err = gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, state->polarity);
> +		err = gb_pwm_set_polarity_operation(chip, pwm->hwpwm, state->polarity);
>   		if (err)
>   			return err;
>   	}
>   
>   	if (!state->enabled) {
>   		if (enabled)
> -			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
> +			gb_pwm_disable_operation(chip, pwm->hwpwm);
>   		return 0;
>   	}
>   
> @@ -243,13 +240,13 @@ static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (duty_cycle > period)
>   		duty_cycle = period;
>   
> -	err = gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_cycle, period);
> +	err = gb_pwm_config_operation(chip, pwm->hwpwm, duty_cycle, period);
>   	if (err)
>   		return err;
>   
>   	/* enable/disable */
>   	if (!enabled)
> -		return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
> +		return gb_pwm_enable_operation(chip, pwm->hwpwm);
>   
>   	return 0;
>   }


