Return-Path: <linux-pwm+bounces-7796-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA56CB854F
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Dec 2025 09:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 679A8305B7D4
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Dec 2025 08:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7A30ACEB;
	Fri, 12 Dec 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M1yjPg9J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25430B511
	for <linux-pwm@vger.kernel.org>; Fri, 12 Dec 2025 08:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765529573; cv=none; b=YCCMSdxwneafIfkJxCmfDegUZhi14Pl9U1vn8uhCXVAGP5WL0B99/esSN9SyxLnQKM/e1IC57vLGnhHUExR+QE94f+vDYklQrP1DNYGbJWKmgeELW/FSYKPDHGjZWHClCk5450aqQCYo6790K0tY+49XaIlOOgk2LTdyZFB+g8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765529573; c=relaxed/simple;
	bh=guyZbBQHrFcxrRkwkYTczuuu6O76dEdlDJHFch5+Vv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhMtiqY9O+oaIBaZ57Ve34HUeU+2MMVrC8SGRKQkpqk2GV1tNXInCCNOTa+NmZMS6YMYkOpmFwaRybx7MYZCULi53tAa0rHsqOSrLrzKvjJxhtDZjmEyG0aypX3heNFMVfzcApWYDaEsdUMYPdidLo9Ckbidzm+A+pa75pLcmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M1yjPg9J; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AD5224E41BAA;
	Fri, 12 Dec 2025 08:52:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 81504606DF;
	Fri, 12 Dec 2025 08:52:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EB3A103C8C8B;
	Fri, 12 Dec 2025 09:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765529567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dpnbMKxrEd/92FzSGRgQG+BUDZSd3g31Xk5DTCxA3Fo=;
	b=M1yjPg9J+9muV+mGaXWjHEpEB8kPYNU0mxz3j2MPylOHDAf1GZIVKa3XR/Uq1wdQxphknu
	8WK9IWMYyYUnEZe++tinnnDQCnGb54YGG4k5gtvfoWE0jD8h/Fnt0aPHIsPpQH//5rS+ZW
	hZR+5HL9zSgHdJ2sPwT13beOMHP8RXEkeBDhfsHMYvD/Ir4GZQzV4oPc4atqBsHNF5YVGJ
	svOFwmOmtL+JxmBQgTmVoZ4zqQpAkZ4YE3+YXKsRkO9PvU0ngBLGZCkgmOoJj63m932sDG
	GJp6FKJ1BoJ2SAa/wdo3zwpsNRsBnVEA1tfAVL4xAM4g1/QKX6DYo5sEevh+Eg==
Message-ID: <1c8fe534-4b87-46a7-9806-9cbbe5560545@bootlin.com>
Date: Fri, 12 Dec 2025 09:52:41 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: pwm: sunxi: add PWM controller for
 Allwinner H616
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251205100239.1563353-1-richard.genoud@bootlin.com>
 <20251205100239.1563353-2-richard.genoud@bootlin.com>
 <20251208-gorgeous-capuchin-of-protection-4ad0c2@quoll>
 <4d34658b-874d-4681-95c1-616f5b385550@bootlin.com>
 <93224408-6b09-4cec-8e84-a66d9ef138e6@kernel.org>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <93224408-6b09-4cec-8e84-a66d9ef138e6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 12/12/2025 à 09:25, Krzysztof Kozlowski a écrit :
> On 12/12/2025 08:50, Richard GENOUD wrote:
>>>> +
>>>> +  clocks:
>>>> +    items:
>>>> +      - description: Bus Clock
>>>> +
>>>
>>> Are you sure there is no first clock? Really, really sure? If you add it
>>> later, I would be pretty sad, because that's unnecessary duplication of
>>> binidngs....
>> I surely don't want to make you sad :)
>>
>> Having a second look at the sun4i binding, I think there's a way to use it.
>> The sun4i, as you said, has a module clock (OSC24M) and an optional bus
>> clock.
>> Here, the bus clock is mandatory, but the H616 PWM uses OSC24M and APB1
>> as clock sources.
>>
>> So, I guess that if we add something like that:
>>      clocks:
>>        minItems: 1
>>        items:
>>          - description: Module Clock
>>          - description: Bus Clock
>> +      - description: APB Clock
>>
>>      clock-names:
>>        minItems: 1
>>        items:
>>          - const: mod
>>          - const: bus
>> +      - const: apb
>>
>>      resets:
>>        maxItems: 1
>>
>> In the sun4i pwm binding, we could re-use it for the H616 pwm right?
>> (APB clock is maybe not the best name, could be secondary module clock)
> 
> 
> apb is probably the bus clock, so you don't need to change the bindings
> at all.
Indeed, your're right!
So the only difference will the the #clock-cells for h616.
I'll send a v2 using the sun4i binding.

Thanks!

Regards,
Richard

> 
> Best regards,
> Krzysztof


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

