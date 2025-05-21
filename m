Return-Path: <linux-pwm+bounces-6073-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B60ABF8E1
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 17:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0AA189C68D
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F261DB548;
	Wed, 21 May 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Sv/YSHew"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53491DE884
	for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839960; cv=none; b=dS0yWTziMf8KdxPT0z8UmbrWGHS5hIi50Zy/Z1E0WxFm0TOvBxRVKd4DGiwRX8l9y8gOjtdueBki6ejjqEU+ZeTw+XwdlLnnp/bz0zN7OlnC7mveRIcBQsVZBujYTWiqieapV8q+CZWMCLJ13Ep+ji1TDu2iQZtwb2qO4LN2mE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839960; c=relaxed/simple;
	bh=Ir2MVdbmo/b4UDviWzXQ71fWGSN2ZSG7Gn5CR39TeO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oX3fj6eDrUSqgXxLhvfPvvRxvXzNQkVAUnY3t1pwH8x9APM+1DA8C9vP2SaPn8GiNoHTko1M4XxNIS8Veojka0FpQ9klyonNJ4TZINSVMXHI6UMPcSm8EjEQHqgAwnc6CY3FrRdg33YkUw+O41f+9MV6G583IuBPcKdCmVhJNjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Sv/YSHew; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c76a1b574cso1623065fac.2
        for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747839958; x=1748444758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FNM4AdBa+GtBGS+Rm/l5dOnnE3L33VAp4Mn0qr/3Iw0=;
        b=Sv/YSHewOXOWpnSaPD3aVcnWkykaJjnsls86+P3izQxFiI2QX4N1+WKgWLi6Okf9K0
         Ee9Ek7CDFeH5rkqqmDMzpiX/+W1GlVnlEu3BIGIwJWMWaPPHizBPCRqrYqtmpNX0a2Sy
         IbbzM7O1XKwrTWXLPR8YbOCRkY62S6KPGtLlr6SlkwY6sYhNUkubdwiXzAH/ILUpZ39u
         UTTQ6eXNFgQ1P/klefde944nzeYdvQIJSkIt/xkpiC5OeiI14V6/ofNQVMXj2+4wtP+R
         2cHkiFpn/bOhLaMbopy/4xjgsiPCwhcs9ntLo1fcmP7V/LNTJeSS4wTDksX6p//gVmI+
         5Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747839958; x=1748444758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNM4AdBa+GtBGS+Rm/l5dOnnE3L33VAp4Mn0qr/3Iw0=;
        b=OFL6Ky/16EDmYGQvqbBBwHpTNQyD9Auu/UP5jCzoeiNBwaaUoecxNnDk9EphWGlnYx
         cTQikiAWk0Wudfjzh4FmJ6lsTQNLSSrqXeTOGDrx0e7zlBNi7w7GEifqReUDE6+b8FNb
         OqUX3/+0JpyRZ678/ONaZLPqW5VTTtJcSWq+8RygY2djEP2OQUbZq3+p8Ej8pfEPkk0P
         bGG4ZFsz3mX/FOQ1LsYN3XoxYTLgQq3x8oxGI4pIgNgYpxl5wxDUsl2DFfEFM/JSEljD
         lRdT2rCFbKFU5iqbabrSZ/S3WiNPDvaM6FXuemoZcRIohnS6l+8oBTpzasm6YTWWBweQ
         Rv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXD842bvuGxWKVu5zmr5CEKVrqqnYfc1+FLscDss0WsBGL3Q5cwIUIg12pqwkUUtDZlz1fbAgJSVtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCBqaqQazNDcpIKspZids4IghnPUiQdjzEosRiD9aEQdu5KRH
	QYSKa6yx3oL495SsWR4wj/czXz4yjcrgrLOaeAxpEAAK+p1VWegoEujAdtpk0qZ5mHA=
X-Gm-Gg: ASbGncsS6DtVGTZdSN6VZ3gPh2ALQnFkwXbtSEWhiBmDR2bDrX32rlCLmHWuX35SsXd
	IOjBFvmOWAbCe5H1eSKvVgg/0cZIl0MqM+BDW723meaBVEk+pbbdlwVVuwFj4rd6ViwMIROulwK
	vP+4pjhmnYPCHYUJDubLLfpLPIKQq/dDPKDG/aW2tI+PAmlvP0Ks9OWpbT2TR1z9Uea9M8c/EuY
	vfdqtWQVCony9NuyffCuzp++68ZmPXZhseIhlVt3gpqUNRzt0wzKb3qwrbl3H/Axk4lCypQxCH9
	oxd246jX5mWmEKZWA/aVXNJjsp1skNrGd6FSDo/kIyxTZHwWaImA5WkdcbNXLiyzbAwlMuLrF49
	XiouQcb6YGK+FIFKY4jVplsR80A==
X-Google-Smtp-Source: AGHT+IFnZRH+Hh5lq3DEVSL/82U18YO7cHWK19WHaRYgQFCSmEQepHDCKm6lJxK/KahPr8I4MbpEwQ==
X-Received: by 2002:a05:6870:fe81:b0:29e:6f32:6d91 with SMTP id 586e51a60fabf-2e3c8566451mr12486245fac.33.1747839957682;
        Wed, 21 May 2025 08:05:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff? ([2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e3c0b2c853sm2681647fac.50.2025.05.21.08.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 08:05:57 -0700 (PDT)
Message-ID: <d2803c4a-d4ee-47e6-9bba-2d042051f980@baylibre.com>
Date: Wed, 21 May 2025 10:05:56 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
 <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>
 <zdltaexty6pzbqesoluuyluygyt6w7nq7r2wccmtfktppwuw3e@qb36fsu3jq4k>
 <0dd1a97e-ff7c-4d09-b18e-5df9944488c6@baylibre.com>
 <p3ejuwktdxcjwv43nnap5tin33ziimgxfan2xoghtaaubsxgy7@tjmwjpwy6yy5>
 <6b72e9dc9d574aa1f025c0f5d317dcec1d729ba9.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <6b72e9dc9d574aa1f025c0f5d317dcec1d729ba9.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/21/25 9:22 AM, Nuno Sá wrote:
> On Wed, 2025-05-21 at 15:54 +0200, Uwe Kleine-König wrote:
>> Hello David,
>>
>> On Wed, May 21, 2025 at 08:19:51AM -0500, David Lechner wrote:
>>> On 5/21/25 4:22 AM, Uwe Kleine-König wrote:
>>>> Can you achieve the same effect with the (IMHO slightly nicer but
>>>> hand-crafted) following patch:
>>>>
>>>>  	ddata = pwmchip_get_drvdata(chip);
>>>>  	ddata->regmap = regmap;
>>>>  
>>>> -	clk = devm_clk_get_enabled(dev, NULL);
>>>> -	if (IS_ERR(clk))
>>>> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
>>>> clock\n");
>>>> +	axi_clk = devm_clk_get_enabled(dev, "axi");
>>>> +	if (IS_ERR(axi_clk))
>>>> +		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to
>>>> get axi clock\n");
>>>>
>>>> +	clk = devm_clk_get_enabled_optional(dev, "ext");
>>>> +	if (IS_ERR(clk))
>>>> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
>>>> ext clock\n");
>>>> +	}
>>>
>>> The trouble with this is that it would not work with existing .dtbs
>>> that don't have clock-names set. I think it would need to be more like this:
>>>
>>>
>>> 	axi_clk = devm_clk_get_enabled(dev, NULL);
>>> 	if (IS_ERR(axi_clk))
>>> 		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get
>>> axi clock\n");
>>>
>>> 	clk = devm_clk_get_enabled_optional(dev, "ext");
>>> 	if (IS_ERR(clk))
>>> 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext
>>> clock\n");
>>>
>>> 	if (!clk)
>>> 		clk = axi_clk
>>>
>>
>> If there are no clock-names, the parameter is ignored. (I didn't test,
>> only quickly checked the code.) So passing "axi" instead of NULL should
>> work and yield a more robust solution.
>>
>>
> 
> Are you sure? If there are no clock-names and you pass an id, you should get an
> error back:
> 
> https://elixir.bootlin.com/linux/v6.14.7/source/drivers/clk/clk.c#L5198
> 
> 
> I know it's not exactly the same we're discussing but of_property_match_string()
> return -EINVAL if the property is not found which leads to an index < 0 and thus
> of_parse_phandle_with_args() also returns an error back.
> 
> I think I'm not missing anything but it's always a possibility.
> 
> - Nuno Sá

Testing agrees:

Given:

	clocks = <&some_clock>;
	/delete-property/clock-names;

And:

	axi_clk = devm_clk_get_enabled(dev, "axi");

We get:

[    1.190040] axi-pwmgen 44b00000.pwm: error -ENOENT: failed to get axi clock


