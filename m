Return-Path: <linux-pwm+bounces-6064-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F38ABF5FE
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C329C188E951
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C944274FFB;
	Wed, 21 May 2025 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lqS5gWCU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D026560A
	for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747833801; cv=none; b=KlOFLSymMeYLoKdSbULpxwXcVFt0mTjHfq3Sb6XMvEQ9fWnnamQ1AENUrYlJwceljvYQGcWvPyMLjufsJSTo5gMyxZN4facIIsS577UNPF+qM3iL1Y0q58SOYYynk7QoYJooiOiH2WSxGFKjkgG32wtZBSB37auN80d+XmMTB08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747833801; c=relaxed/simple;
	bh=w73AQw8+g5fBpedRVPUGGRopTEwJA46061csugvI/zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQdxme4bbsdSAV3BIRsaXo8EC9FhxIrxcVZtN5Gd4UWB/RpMA05rXkGeYOksS3ai/kIxIcy5d8jIt6LicnqBYvmIDZwrO70ypoZf4wv9VXhEsI5G4EjogoRn/tcfP6aXUoJcv27DiB3JbabP0TXzr313dvETJ+rExigYND+K4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lqS5gWCU; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3fbaa18b810so2197997b6e.2
        for <linux-pwm@vger.kernel.org>; Wed, 21 May 2025 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747833797; x=1748438597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=73+Ub5D7zbTT7WbMLp31ncO7kWmhvFAqTPjsH0ZsZhs=;
        b=lqS5gWCUR4SPY9ewYeFIUWBdlTIFTKDNqHLML7XSuNWvilvicm29/SevLvdA7rPT/v
         /o2OIM2fTYfIYmqRkhHgICFHkKzk9ho+Hqzbqrcg0+zvx7ws3z/fVY06kfWFqJ4lfEef
         tyqeGx+qF2u10PgiGo72FzrcubSnhuzw2C9E9xh5XjkNR55z/6+NUMGha8ihdpteGHLB
         Q6aEj/UTi9mqop2itFHRJt6jMr8GuigOFgHfrGnUimRYB38kP9lhoGyhEm4iksDuC9Ql
         Bz3H4MxvnYUnpiPCjHyNKJ5uYVhRX55osI+N2whlZLToTW7PNIocZaesSR9h7Ha+9+MX
         zhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747833797; x=1748438597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73+Ub5D7zbTT7WbMLp31ncO7kWmhvFAqTPjsH0ZsZhs=;
        b=dk0lO5GCq0Jcrl7Lg0kdqVbHlk0LrCqiWI7a06XaihRPlg+/lYqQAAqF93flznCx6i
         hDCDh9uK9JhY3mRPpHx5pxj6ppzREsg5QsTcMorAPvn/E3KeAszi0Ut84IL+xHg1GXAC
         UuLZOLS/1lYwN6v79qGDpOzmNQClr7If4AVWlob1QSGf0FTirNxThIhIAwbddFPaGHdi
         AJoz+dS3WWT3O9ob7M8Vfwuu+2hlf5n1FU2Xf2Qb6B7x7gMcnblTEdR2Q3dxoW4TTa10
         /oB2ayt5X6/3OAcMFnAU8WethswZI5mW2sypwJDm47hhl1jlhjbddYivoq9wejVfkH1q
         M71g==
X-Forwarded-Encrypted: i=1; AJvYcCU7rCQe4QoZNEluiUl1yO4c/rEj+dMIBtPID1kS62/bdD2tPdd/fRnQlks1al4ymB32Xn/wfnOZljM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuO0fpeoxm3OYVaSR5H4jT5bosmk1q2O0s9iGFHq0tCjVYE+rV
	ptY9GYr60GqUtKIjdgR+NIjP4zfYDbr2qD44F7NumEW44bCy+ZJv79n/Y4F4zhHfKAI=
X-Gm-Gg: ASbGncvwhKaBMGUFHWngmawqQ2yMUH/nbqSiIVvyViKAP3TS6q93QX9R7nSN7vtBmhP
	hH5VCrIYagOaXdTnPFjW7Q958An8WMeMbrdKxXSY6GSpMTQdIAFXjbLiOfQcZtpqF57ahlLJyXM
	1i3i5zzrzZzv6r1RJLpRvfrc3naiTHD9SMJwPugph5x3WGMPTt3YrMwk6fwXTbu3bzJO3dd1XvP
	JEGyonuVAJHfgUck2MDD6un+62NnHSUPARYqt0K+Umj4DuASuMPl9V3vUy8pMj+SlQDEIsIFuo3
	LAUP8zN9KePMKnRv4qzJD2+TY8HHc2HcYhk4GUkBjwdu059B1yU6mEU15ByDRA7Wky3OARvHm5n
	D4X4Bh3Pt4Yh6PLoyBmjPPgO0gQ==
X-Google-Smtp-Source: AGHT+IHvmT2xe5UfsGuH7VhuaUgi4gdIlcSV03RlKzpEU+TwayEelqHe5C4jtIcDiTOXtQ/wc9WNfw==
X-Received: by 2002:a05:6808:338b:b0:403:3521:2475 with SMTP id 5614622812f47-404da826d65mr13000543b6e.37.1747833797424;
        Wed, 21 May 2025 06:23:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff? ([2600:8803:e7e4:1d00:d77b:6acc:2ad1:8ff])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-404d98060ecsm2154491b6e.27.2025.05.21.06.23.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 06:23:16 -0700 (PDT)
Message-ID: <dc9c370c-e1e7-4ef9-8738-e6ac8887ee61@baylibre.com>
Date: Wed, 21 May 2025 08:23:14 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
 <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>
 <20250521-nostalgic-pretty-hedgehog-d08a77@kuoka>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250521-nostalgic-pretty-hedgehog-d08a77@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 5:10 AM, Krzysztof Kozlowski wrote:
> On Tue, May 20, 2025 at 04:00:46PM GMT, David Lechner wrote:
>> Add support for external clock to the AXI PWM generator driver.
>>
>> In most cases, there is a separate external clock that drives the PWM
>> output separate from the peripheral clock. This allows enabling both
>> clocks.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>  drivers/pwm/pwm-axi-pwmgen.c | 23 ++++++++++++++++++++---
>>  1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
>> index 4337c8f5acf055fc87dc134f2a70b99b0cb5ede6..67992a7561ec0440b1c1fa327f844a0602872771 100644
>> --- a/drivers/pwm/pwm-axi-pwmgen.c
>> +++ b/drivers/pwm/pwm-axi-pwmgen.c
>> @@ -280,9 +280,26 @@ static int axi_pwmgen_probe(struct platform_device *pdev)
>>  	ddata = pwmchip_get_drvdata(chip);
>>  	ddata->regmap = regmap;
>>  
>> -	clk = devm_clk_get_enabled(dev, NULL);
>> -	if (IS_ERR(clk))
>> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
>> +	/* When clock-names is present, there is a separate ext clock. */
>> +	if (device_property_present(dev, "clock-names")) {
> 
> No. List is ordered, you do not need such dance at all.

I should have added more to the comment here. This is also needed for
backwards compatibility where only what should be the "ext" clock is
given as clocks = <&spi_clk>; and the AXI clock was missing.

> 
>> +		struct clk *axi_clk;
>> +
>> +		axi_clk = devm_clk_get_enabled(dev, "axi");
>> +		if (IS_ERR(axi_clk))
>> +			return dev_err_probe(dev, PTR_ERR(axi_clk),
>> +					     "failed to get axi clock\n");
>> +
>> +		clk = devm_clk_get_enabled(dev, "ext");
> 
> So that's messing the order, which confirms my question from the
> binding.
> 
> No. List has a strict order, you cannot change it just because you want
> to add optional clock.
> 
> Best regards,
> Krzysztof
> 


