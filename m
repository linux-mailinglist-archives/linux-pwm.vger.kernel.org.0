Return-Path: <linux-pwm+bounces-1189-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4C6848735
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Feb 2024 16:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F1FB267EB
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Feb 2024 15:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D295DF2D;
	Sat,  3 Feb 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="A/YndlFE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666975D748
	for <linux-pwm@vger.kernel.org>; Sat,  3 Feb 2024 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706975246; cv=none; b=hsS4/Ee5RkPRsKt/JaK96x3Rg8XkxOWmM8kdnzQCegbyop6Eygh7N6E8XbCfVNrEkfJ4Lbj6B7ODdH0z+72y9giVyOuieV0YQGLEp0SWwOEnGaFPNDLlJszUAf+ZuZ9aeKe9FIS4ENjNjvz//4mb3Ul/7l1T7NXKokL7rmI3UUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706975246; c=relaxed/simple;
	bh=SaFekycQUAlhaMOi8GYbX13HfBZgmgqP7oiL389koow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hf1wpp/OCGIaIgUE5rhOMr8by7PEQnaf+WQi6lm5aRSQHkklcFIWJIgvBaefxGAGMBwmE9xKQXmUsRqfdwiGBrCUO4XazRuwYAkG6oMGylySgHETUxsVZNm/FVYlYEAVqPRcY1ClPAKBdCljgE39cx+1dZQ9QjDPqHunTJ3fi6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=A/YndlFE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a363961b96aso394342766b.3
        for <linux-pwm@vger.kernel.org>; Sat, 03 Feb 2024 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706975242; x=1707580042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7pbMMPF8mQNRywWQfD/HjLQ57Xp2XNOTC7Bl96/4NE=;
        b=A/YndlFEwtDZiHK43R0iHUXci4roe8MM3ulCEFrGE3SPP9ozAwYtEdwur87gGvUHn9
         K1VlyZ9MKlwliU4ziN453anhGu2SA9Rq9UVXHNUAs4mDtnvW/aYGrG68yjqygalB8mwn
         abhSTyax//LrTJjxwKLbCUmlqfprc409/7kH1IRmwdwYWt8J4BJMaDBV/env4Od9lWyB
         bw+U/XTyTf2YfnrukV5ocnacTuQN9vQ3vNsvVDmYOp/JAmo5mdDp8oZ6QoNGaVfTp2BR
         67vlNbjpzGEv76i2BN21Xj8h4ffaJ21LiilCj2MHHElWo3mu/OWu1vWbESJk+QWdSgcg
         cEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706975242; x=1707580042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7pbMMPF8mQNRywWQfD/HjLQ57Xp2XNOTC7Bl96/4NE=;
        b=KeMJepCV3waSSFs5MNF8/kmn2d2tnlmU91pqd1g5XysvYYZQJCMQ953UdSQ1osUIJM
         xHd7kGraH8ZfzB0z9jeB6gGTqg4quarPmb1wmFO5Dx4u0q9u5UgQmLvHLwDBycnsEfvE
         7mxeyLQlH5g1prDAQjVKnhiK++EtOpyLgieQ3PFezp0CCCEACIMPkiKJ/885nJja9d2c
         rOWQki9GbWgwiLrIL82L66BwLfymxJ6F8Y5zLhDYDauNOzNC5gJQ0CwmiduWv9JrLGX5
         xdxOvwKh1UqIjBIii44+/OYvSNhS6uXOBsGzaxloNzRFTAS/0jtE2Ofb+VnVRo6CibR+
         szPA==
X-Gm-Message-State: AOJu0YzbP207Eeyhy9tu0CpYFADmzZsNBoaOagb0t5MegN5wIwJf5qbF
	ZAzsffvDiHwnFqoCTXt0DbYiwg8XcB2kry638bdFHtqjYSuef921vVcYiU31uL8=
X-Google-Smtp-Source: AGHT+IEPo/5jfizQ1jyslzZpg323EvRS56yIHcoRFacyFmdwmLcBhXim6vkvn52sSVmDHypO0DBrKA==
X-Received: by 2002:a17:907:1041:b0:a35:47fe:ed67 with SMTP id oy1-20020a170907104100b00a3547feed67mr4021606ejb.77.1706975242613;
        Sat, 03 Feb 2024 07:47:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXf6wY7MlXUcs7YmeB18dSNFiYpejtCbZUFkO+N60x7tWuU3I9lPqYWz6oNG91dFhxDKKDu0WRxHY2EdmoNMHsIe05IYjt60+k9mpeA7cA5tY1gacjH8hkFBOcTJPLyVfHhgc1QzZIaa9ih3/oZO1HDLDrNbygdJcshC51C6+NmB4y5QO6D68Mu230vvGLheBjBhg2QZ/oJ/81Zu+EyWFobHQqO/JzWVXph95cmR/jbOQ9U9qhBBlZugXLYqtKmT+E6F94mPBBD0tH92wIuQevGxGEy9wyfDA1xZAGzmZhJ5o9dzj9nd/kVFt+cYNC+dtKkMUw=
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id vq11-20020a170907a4cb00b00a36cc8c1bcbsm2119253ejc.173.2024.02.03.07.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 07:47:22 -0800 (PST)
Message-ID: <18179a0b-8ac1-4ec3-9c58-c334356df37d@tuxon.dev>
Date: Sat, 3 Feb 2024 17:47:21 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pwm: atmel-hlcdc: Fix clock imbalance related to
 suspend support
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Boris Brezillon <bbrezillon@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <cover.1706269232.git.u.kleine-koenig@pengutronix.de>
 <b51ea92b0a45eff3dc83b08adefd43d930df996c.1706269232.git.u.kleine-koenig@pengutronix.de>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <b51ea92b0a45eff3dc83b08adefd43d930df996c.1706269232.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26.01.2024 14:04, Uwe Kleine-König wrote:
> The suspend callback disables the periph clock when the PWM is enabled
> and resume reenables this clock if the PWM was disabled before. Judging
> from the code comment it's suspend that is wrong here. Fix accordingly.
> 
> Fixes: f9bb9da7c09d ("pwm: atmel-hlcdc: Implement the suspend/resume hooks")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

I don't have the HW to check it but it looks good to me:
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/pwm/pwm-atmel-hlcdc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
> index 3f2c5031a3ba..1f6fc9a9fcf3 100644
> --- a/drivers/pwm/pwm-atmel-hlcdc.c
> +++ b/drivers/pwm/pwm-atmel-hlcdc.c
> @@ -185,7 +185,7 @@ static int atmel_hlcdc_pwm_suspend(struct device *dev)
>  	struct atmel_hlcdc_pwm *atmel = dev_get_drvdata(dev);
>  
>  	/* Keep the periph clock enabled if the PWM is still running. */
> -	if (pwm_is_enabled(&atmel->chip.pwms[0]))
> +	if (!pwm_is_enabled(&atmel->chip.pwms[0]))
>  		clk_disable_unprepare(atmel->hlcdc->periph_clk);
>  
>  	return 0;

