Return-Path: <linux-pwm+bounces-1800-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FCA87EDCC
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 17:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C621F21C6F
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 16:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB22548EE;
	Mon, 18 Mar 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS2R7G1v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9726654F88;
	Mon, 18 Mar 2024 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780338; cv=none; b=RcLfTdFPDhyF7EbdJq/Qme48uxJFvSoeHMyQvDG09o2eZZ1sPGj44wH3eiDR1WlPDgKDwftcxWrGQGSXI9WBY8cvC9bUoRDFHZeAzTAaF/6grvbNAQTCKfnJu9xgWIfI6WKm7236Ewr1YGvgxLhHUXGWe4r105JB8V5DaTa4suQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780338; c=relaxed/simple;
	bh=sABFKBg5L4LevrgQ94GaraCqZCtwFRrk6I13qKPWYV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+rVlQAUst/Uua71MsgyazSOnjOaF3NNXCeWkoxjOSEvnDdf1sB5j5wisli9LoAPkYNJQfs3xloDc44KCUk6/leR9B48bCDoOm/TBVIcI6AL7gQO2aim2q8s1xPVEf/s1dH+3XuJ2oqumYjAmBJ1UZWv2KQvI/GwvI1B1zSjFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS2R7G1v; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29fb7e52731so700852a91.2;
        Mon, 18 Mar 2024 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710780336; x=1711385136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RIAmxMfGxmKF/2fO5lCEP9y+H3IyDxkrQtEBRJf8D24=;
        b=OS2R7G1vRp8szGQWT0mXZCo7Gg3QIWcVZsDRLD1sQpinFOSR+V248UtOD+Tjp3p8fs
         67oo+ZiJNhAyhhOC7sqRf/esMIN2+cbpZIlqYGM8Kw4r+zLxzuVDC52xcmbqMpY9n78G
         YAnecNrlvsrof4TkU5kqaTSdbrHLye0KrGUsQaCnzyM3XBVdd/OOFEyPiVArEjd3aMlI
         w7hfNg6yMVonyctU859xzsjG1OmAw+Z44ceXZBk+on7BE4acspJXQzxIOOTjovf99XYr
         eL0S8i5jUGkTyCsBlHi4g9RB80HJn8ZGXpFf53pIFA7MvtKY8ZJ/gt4w0/zr6ewtVFAj
         QTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780336; x=1711385136;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIAmxMfGxmKF/2fO5lCEP9y+H3IyDxkrQtEBRJf8D24=;
        b=eEXnAaOtaBwk4fJSJgQlYQ6yQZcjS4cO31WG8YHizZes+l2wYyhelPQS1/JUcEW4wx
         PjvFmG6sC+WfEZHuR542kR+UaR9P5o/Ydqn/W12dQTTDjdQHmyOeU4NoFrWXBD0XApd9
         0ZwTR1YYWoT0SsMWKqd60UnEF+CDXe1qoz5ieKf91+2uaCwgS6CPks3AQBNbbVLxigwM
         Vm3wLJVXWzjCoato1qQ+PEcdOqWDYkyD3UZcyw2EvJeP0nyi5G2d9gqcxMgThinbEIF5
         E5uTQ9wRKr/rvkYzWbzD9X0Tp1kJDozu4D6wjjRjHIqYpd/SSX7YUK/PRf65sCCq+hvv
         UYqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG6GsDZK461mmbYlyTsH20aPK44W604Awp9Edawlec+FdWYVPKEWCyxRx7VIiBjvzcJMzSVM3CAfvTk4pZ/5klvaDkEt4yUzbIj51kE8OArzT1j+um0uctMM2+vHLhRrt8CxozHnw=
X-Gm-Message-State: AOJu0YwBOf683Stf0upfaF50eD74mzXvN2ZLLzqOsqbvHVaxMTe/Ek1g
	AHtK2cQMHot6qVPZ0Lv10n60kBQV1pF6ymea2LCakPvwAl49K/f+rm5RmXFa
X-Google-Smtp-Source: AGHT+IGgowlilkJ3K7SQPHRQGwkmCkG6yPMWjsZrl6pn2FQFmDC8YkOEad9BoD7RmztczbFttM0yhg==
X-Received: by 2002:a17:90a:8044:b0:29e:5c51:28c5 with SMTP id e4-20020a17090a804400b0029e5c5128c5mr119719pjw.44.1710780335817;
        Mon, 18 Mar 2024 09:45:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r91-20020a17090a43e400b0029c14758eb4sm8859430pjg.8.2024.03.18.09.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 09:45:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b07680fe-969a-49aa-9995-aa51261f1bee@roeck-us.net>
Date: Mon, 18 Mar 2024 09:45:34 -0700
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwmon: (aspeed-g6-pwm-tacho): Make use of
 devm_pwmchip_alloc() function
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-pwm@vger.kernel.org,
 kernel@pengutronix.de
References: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
 <e95e41eea5a138ae206c9116ba3cb1d9e0178284.1710777536.git.u.kleine-koenig@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <e95e41eea5a138ae206c9116ba3cb1d9e0178284.1710777536.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 09:09, Uwe Kleine-König wrote:
> This prepares the aspeed-g6-pwm-tacho driver to further changes of the
> pwm core outlined in the commit introducing devm_pwmchip_alloc(). There
> is no intended semantical change and the driver should behave as before.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/aspeed-g6-pwm-tach.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
> index 64def5e4cdf6..332c02216668 100644
> --- a/drivers/hwmon/aspeed-g6-pwm-tach.c
> +++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
> @@ -136,7 +136,6 @@ struct aspeed_pwm_tach_data {
>   	struct clk *clk;
>   	struct reset_control *reset;
>   	unsigned long clk_rate;
> -	struct pwm_chip chip;
>   	bool tach_present[TACH_ASPEED_NR_TACHS];
>   	u32 tach_divisor;
>   };
> @@ -144,7 +143,7 @@ struct aspeed_pwm_tach_data {
>   static inline struct aspeed_pwm_tach_data *
>   aspeed_pwm_chip_to_data(struct pwm_chip *chip)
>   {
> -	return container_of(chip, struct aspeed_pwm_tach_data, chip);
> +	return pwmchip_get_drvdata(chip);
>   }
>   
>   static int aspeed_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> @@ -459,6 +458,7 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
>   	int ret;
>   	struct device_node *child;
>   	struct aspeed_pwm_tach_data *priv;
> +	struct pwm_chip *chip;
>   
>   	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -487,11 +487,14 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	priv->chip.dev = dev;
> -	priv->chip.ops = &aspeed_pwm_ops;
> -	priv->chip.npwm = PWM_ASPEED_NR_PWMS;
> +	chip = devm_pwmchip_alloc(dev, PWM_ASPEED_NR_PWMS, 0);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
>   
> -	ret = devm_pwmchip_add(dev, &priv->chip);
> +	pwmchip_set_drvdata(chip, priv);
> +	chip->ops = &aspeed_pwm_ops;
> +
> +	ret = devm_pwmchip_add(dev, chip);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
>   


