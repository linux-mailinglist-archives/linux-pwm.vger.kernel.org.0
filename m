Return-Path: <linux-pwm+bounces-6070-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58441ABF791
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 16:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6098C26BA
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364E125A630;
	Wed, 21 May 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nLoqpwz+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F519C55E
	for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836730; cv=none; b=lKvnn/pQJeViWLxu+Ow0fADP8+P5By8BaJ2lledd+ZkxIBhArceDIwtVJB7umggmG9b2KM0x9j8t368ytBsEwV2TRbaGNwZ7BhUVDXUZXDo5C6zM02FQDtvHPmoG6+gWdf8wP7r+bDJxP0d/UdGxOrhdzVyZUl4cUMYNx2MzmU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836730; c=relaxed/simple;
	bh=odsaSqefquxp3EMnxzFyTlzs+P6tOxwI1Uga5f5WlgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vrr9e9Fa+6+xNbah3P5FW7+Hw9lozeYIEUXhisHYywxl64I7bDHGUJjv0X7/TLe+8/3VVTuZnl/qgrts2ETsEzrXi7F6sVUmJh/vRzeJKiI5rmIOUaIyey2EvBzz5e8s7+XhKeYxgUMac1ajv9JGreO8v/ph5Hc8/tCR0hZ1kvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nLoqpwz+; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2db78ef7f69so3253619fac.1
        for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747836727; x=1748441527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYTDDF5UU1bTZpFDre3P+poUO7y3Ub4h619aw333K6I=;
        b=nLoqpwz+1l+0GgT5dslf8/b04vpVxd21VmG+2EOcHnhColudaYAgUkLlIW/vAs5NIQ
         qKdnNKch6c89GRSR7d3XOLHDdDQjmkGbuUD4yoBgRC2L2TNh08bqCw2v8MAc1vSG13re
         75gZCwT5Hp8yQByKnrHTuq29qUN6OCBwOAlVASufN0OE4KXKXUC20DhjA4WI7lWNWNRh
         422MeGgg7E3ibvjJEzL4R204EYIsgAjVhNY9rmhz8nED2u0bf1LDhc6mNJWto7wVy9HQ
         ye48C4Nl41bNrNqZbaD3YiMpV5kQ6dMj174jpbde18EsNyxcHftXneh2D+1PgqRaPW8P
         kXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747836727; x=1748441527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYTDDF5UU1bTZpFDre3P+poUO7y3Ub4h619aw333K6I=;
        b=wuWqZFCdzdsVflbKjfaNaCgT14TpaNa4Uji8nl2xNyX/T+aFAdUZBiMjkkfZvx2jf7
         akj+MH+TWV0SaXioVbmtTnrZuXQ4tXFjQ7YvLz5RQj/pqfN6Wq4wYQ9HAs4xjMYtjCZU
         3pakyiyLokb3ZHtzjAwXptGmzrfccrw8bLmZlntlzk50wLIF0oOzTP2TDgNMsrFaatCf
         GpR2zU/RhRf64gPyIE5zMx0GCZ9jym7JLBRm4E4C40HUsxvgmGrWQU86EKpupLRtG3gx
         su77kgVYubCocc+6//XDmUmoYWieUhotsepGKEwCWWQF8eLFqZbkUtwoJRy5Se5NOA1E
         YVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNCy1mSC7cl1oGiQjKoy2AQdlV2aiFwWtFQMJyfxfg12RvteundzlxlEVPRR7cMeDTH3rZg/LJJIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9+Hq2U8ORO6/6CgLGD0U7//BKGwplv0GMuLvKiKS0zHyM7HT
	td+sRz/vn+y5gDEmV6jW0Ew8hIPEzJkGuN66yK+LL0DnixKLNy3tyT9957i48B15qXc=
X-Gm-Gg: ASbGnctbscDIYxqxAeWvckp7xlU/JJ3xFwaG/k/Hzk8t9xmwaUgpVnBQ5zl456Eujcp
	Os+MY+gkjYJ5Pi9+hZHxC5Oz8vHP2YT8lyrquPgWauN21PoI8JDMbDdlo5SBU11ihwEbWXCZKGh
	sJx7Unjyd5WYqJB+5GS66pMK5D9tlkuLq/n24IH2faLt1Ug+ngRX2+UCHy+cQYTIMhiN/WyoR/O
	rVTXB1VpNt81PJC8r7e9w1yvHpJZbEiZsRbSQFRR2UB5zx8LDAH7h05JmFXjtTve8b/2Eg+0i/E
	WGz9mSF8FNCRMgFvdcYSJHPQnh3GoPdkusLmGvZClZnwOWOMhj7T87S4TKb+kCBvbdxUX2XJpUW
	vMC3Oiij8uEw3PlwWR6BcsbIq8A==
X-Google-Smtp-Source: AGHT+IFZ2dh+kUDz4CadhBuUt+VbW2XvI2VqdXWMjeSLEb0HI1UL7Tc8JFlMvCWqx445ddJxdyhZjw==
X-Received: by 2002:a05:6870:7994:b0:2c2:541d:2cd6 with SMTP id 586e51a60fabf-2e3c1b61385mr14163348fac.6.1747836727294;
        Wed, 21 May 2025 07:12:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff? ([2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6b5f68asm2146882a34.66.2025.05.21.07.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 07:12:05 -0700 (PDT)
Message-ID: <14a80484-5cfa-49bb-9608-12f25a113b23@baylibre.com>
Date: Wed, 21 May 2025 09:12:05 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <p3ejuwktdxcjwv43nnap5tin33ziimgxfan2xoghtaaubsxgy7@tjmwjpwy6yy5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/21/25 8:54 AM, Uwe Kleine-König wrote:
> Hello David,
> 
> On Wed, May 21, 2025 at 08:19:51AM -0500, David Lechner wrote:
>> On 5/21/25 4:22 AM, Uwe Kleine-König wrote:
>>> Can you achieve the same effect with the (IMHO slightly nicer but
>>> hand-crafted) following patch:
>>>
>>>  	ddata = pwmchip_get_drvdata(chip);
>>>  	ddata->regmap = regmap;
>>>  
>>> -	clk = devm_clk_get_enabled(dev, NULL);
>>> -	if (IS_ERR(clk))
>>> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
>>> +	axi_clk = devm_clk_get_enabled(dev, "axi");
>>> +	if (IS_ERR(axi_clk))
>>> +		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get axi clock\n");
>>>
>>> +	clk = devm_clk_get_enabled_optional(dev, "ext");
>>> +	if (IS_ERR(clk))
>>> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext clock\n");
>>> +	}
>>
>> The trouble with this is that it would not work with existing .dtbs
>> that don't have clock-names set. I think it would need to be more like this:
>>
>>
>> 	axi_clk = devm_clk_get_enabled(dev, NULL);
>> 	if (IS_ERR(axi_clk))
>> 		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get axi clock\n");
>>
>> 	clk = devm_clk_get_enabled_optional(dev, "ext");
>> 	if (IS_ERR(clk))
>> 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext clock\n");
>>
>> 	if (!clk)
>> 		clk = axi_clk
>>
> 
> If there are no clock-names, the parameter is ignored. (I didn't test,
> only quickly checked the code.) So passing "axi" instead of NULL should
> work and yield a more robust solution.
> 
> Best regards
> Uwe


I didn't know that. So with your suggestion, I guess we would get/enable
the same clock twice. I guess that doesn't hurt anything. I will try it.

