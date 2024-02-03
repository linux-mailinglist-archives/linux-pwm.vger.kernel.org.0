Return-Path: <linux-pwm+bounces-1188-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CA0848734
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Feb 2024 16:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C529B2617B
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Feb 2024 15:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A867F5F54B;
	Sat,  3 Feb 2024 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UrB1La01"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D035F549
	for <linux-pwm@vger.kernel.org>; Sat,  3 Feb 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975178; cv=none; b=Ie96f5P5FV21wvo95A5aVZEKmcaaF93YTYVXia07aS/QKgfW2mF07YFjWw+IbkTZYGLwPiuhgh8OUEauwVURJbNcKp9CLy3hJ9igqY2T98h8yw2YIr5JOP2ZScPpAThmGHrS5srkNnyWn7VuXC7d7Tr5AE4p8hp+mKtCsp2/CW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975178; c=relaxed/simple;
	bh=7eP2F/L9TLzuO6WPCFaU+EBuewOfepEsUqq3ELYX6IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKcd58fbIWrHOcyzB1AfrO82S/vUR22KDi74c/j1dOGEHpFfa45BijaExpBmYhDNVXFmng1joY/9V37at5yOzXPQL5RKuoS87bxDURwdqYVPJPkyqeArcym22LZU6XecuptO+PstrLfv5D6WDJE1JdXrUubD8OlDd9SYz3zVpxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UrB1La01; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so3503119a12.1
        for <linux-pwm@vger.kernel.org>; Sat, 03 Feb 2024 07:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706975175; x=1707579975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBWYFCyIDMD8ZqtAvrmEuXdTTGmaxkm+loGCU6m/f5Q=;
        b=UrB1La01+Z8PLW9ZFvT9W3htCV5EIrUOJd+ZNFBHCmu4PktCLMzJhukavEmtFC3RvC
         3wuiXTIY96zgHQZSlHuvl+RHCXRsE8xa7+g+aJies2O5PMfLHmWVGUqurl3fYAEV/5+l
         cx/B1j7xz4wtqZ+RapyGz9R9miSrbCSFp0dQ2UWvHc5dtRTcQ5Kj60QBaozMWA5unm93
         mC66BAk0wid00s/6zVTn4TpuDEnJpqRIuDBqPjSSYn7q8kM3D6FldZLV9X65PLx7rWS5
         hDswNaRlUtUxS0vgqz4fq92PL55MIjUlOXbw20j7U2nxroXVmyuQp+cDCyqFxDonKpbe
         ipWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706975175; x=1707579975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBWYFCyIDMD8ZqtAvrmEuXdTTGmaxkm+loGCU6m/f5Q=;
        b=kGsd3bO+wWTGrRm12wGyiZezGnsw1UQme/O1o4+l8GF0G39YE5PuOh6s0NT3sJ8LRl
         O6oeBbJ4u8WoAvAoqmSZlZfrgYuVCpT+gGnaqVQ1cQ3iA1N5MkPYd3IC6goUDzfRZM9P
         XaiFfGvX5HjVmkBVeN9tHPZ4NqsWFTM1FxKGxg2AgpqDp9zk8kH5TDSF7zctUqv+zF5D
         +Es0wJAC7rVB0aqXNIuNp1OVuiLj8aOhIsSGf7Qt3R02PsqayD7ZfAh0DXxJLP+y/iXw
         0nRyUtXHd20yyc3qEkN5CtUfiubaN4/oOqIzX7xni20o4CY/P0AzhSzoja092qtz356T
         7MsA==
X-Gm-Message-State: AOJu0Ywgxf6JyXyRbPEFWQfmFk4WN4gFNQpBSSOsTG/DvTYv+/pJOQ6R
	XI5Zyngbt6/96t7OvGLC5TwugiSSW4CcC2e+nzuhzriykEINKSl+qS1ecuifW14=
X-Google-Smtp-Source: AGHT+IFC+1vRGimGlEzRTWKLwvNas7+igYODxdkY2YuVCUklRVipVCoPTsinaJ3IZJLwzqi2fmo20w==
X-Received: by 2002:a17:907:111b:b0:a36:2da9:987e with SMTP id qu27-20020a170907111b00b00a362da9987emr5938068ejb.5.1706975174727;
        Sat, 03 Feb 2024 07:46:14 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVupK8XlLiXcE1ngohAdb8R1BJqM9C12tvwUeGjaCmdP1FxUe2a+uUPS347jGGQBHl1jt51b3brh+cvfC8yxxX9n51Fcb7N41pPqlwq/sxPTBFt1rmwB4L8z1F/L6IfjBHq3JWPKLuXEA3xKDfeTKPMWNLSQoVmQQ132wAMbAF0GJiSn3vMCAEmbsG9aTTZ5ho3I+5mXO0gaV7e1rKte8Uh37DJ2oG0147dg8Tjq4V5bcS0kV0PUw==
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id vq11-20020a170907a4cb00b00a36cc8c1bcbsm2119253ejc.173.2024.02.03.07.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 07:46:14 -0800 (PST)
Message-ID: <9e5c0d29-dc4e-4864-ab1c-e65bbc25430f@tuxon.dev>
Date: Sat, 3 Feb 2024 17:46:13 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: atmel: Don't use pwm consumer API
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 kernel@pengutronix.de
References: <20240129085627.2386470-2-u.kleine-koenig@pengutronix.de>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240129085627.2386470-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 29.01.2024 10:56, Uwe Kleine-König wrote:
> Lowlevel driver callbacks are not supposed to use the consumer API
> functions. Currently this works, but with the upcoming locking changes
> this probably results in dead locks.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/pwm/pwm-atmel.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 47bcc8a3bf9d..26573829e391 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -294,19 +294,16 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			   const struct pwm_state *state)
>  {
>  	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
> -	struct pwm_state cstate;
>  	unsigned long cprd, cdty;
>  	u32 pres, val;
>  	int ret;
>  
> -	pwm_get_state(pwm, &cstate);
> -
>  	if (state->enabled) {
>  		unsigned long clkrate = clk_get_rate(atmel_pwm->clk);
>  
> -		if (cstate.enabled &&
> -		    cstate.polarity == state->polarity &&
> -		    cstate.period == state->period) {
> +		if (pwm->state.enabled &&
> +		    pwm->state.polarity == state->polarity &&
> +		    pwm->state.period == state->period) {
>  			u32 cmr = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
>  
>  			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
> @@ -328,7 +325,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  		atmel_pwm_calculate_cdty(state, clkrate, cprd, pres, &cdty);
>  
> -		if (cstate.enabled) {
> +		if (pwm->state.enabled) {
>  			atmel_pwm_disable(chip, pwm, false);
>  		} else {
>  			ret = clk_enable(atmel_pwm->clk);
> @@ -348,7 +345,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
>  		atmel_pwm_set_cprd_cdty(chip, pwm, cprd, cdty);
>  		atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
> -	} else if (cstate.enabled) {
> +	} else if (pwm->state.enabled) {
>  		atmel_pwm_disable(chip, pwm, true);
>  	}
>  

