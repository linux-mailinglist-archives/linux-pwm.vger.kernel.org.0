Return-Path: <linux-pwm+bounces-7821-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D87CD54B7
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Dec 2025 10:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53C0730424AF
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Dec 2025 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A4310647;
	Mon, 22 Dec 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nTppoy4S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D0D31062E
	for <linux-pwm@vger.kernel.org>; Mon, 22 Dec 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766395043; cv=none; b=Qw0lEW48xNOVSxj1fCyUJnRk7BypLIQYYusNvHmlswS+2KHn72bx2OkildYZ/xV8rqu0SWJsbQ5WYzs/IIervWp7/nFUrIXHRqZomSfvmrooHp9xaFREZHFr1ZeaYrH/MaB2cnQ1JfyGvUOerbXhpgT+QPuXKmbR8Ai/icKyiOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766395043; c=relaxed/simple;
	bh=etcQEi1u2eZv7v3+V+6Frxr33eKmWuPk6bov+XKFNn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLIxW1d7EwP9p+s344NLplclDgvzWBERFYm4J6Hp4Kg1oq++mi61U0ydoL3nzTjDPBXlBj24kt+vKBjZTvCdbSbF9db8TUbZ8/XTVqCJg2RniSF5kXjIFEfp5FGH4qnGXTlKruSRWvyuPLLn2MN1aqGVuxhpJco9HbpuFbnWo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nTppoy4S; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 7793D4E41D32;
	Mon, 22 Dec 2025 09:17:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45E13606C1;
	Mon, 22 Dec 2025 09:17:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1A9F10AB0140;
	Mon, 22 Dec 2025 10:17:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766395033; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Nb3n1nsNJMcoSFIkmzKS2rMqgizIUNC22FVriH9Ctx8=;
	b=nTppoy4S3vb8RSx5dHoCVBs3MXIZ2NgxoLdtn1i8P8i1fdxV4vdc4cR2J2qN9amyRoVqXJ
	OBFsKphvKmjZVcVt3RYEywq7VOfV4M3+Y/fxpEmjxj7P0YlIj93AqDO8QtPukY9KNfD+Wt
	B2ETiMQ354F2eq08es+qA/AxHcAlZ5AIWHRY/gL7gtG23KWSLCL2JR+kaqP62I92Zxmzre
	fLtmndNOLpuCnnWD0qA9pJaq9S8kBnNsFLWkQ1eyfWApvjDpZdgYQefCd1FaQcPYSsPy/x
	+nVUdpaHs4vIheaYaHvjJPu5qfRWFGKrTMyVdKfyEPdGjIzLwws2moyJaut9CQ==
Message-ID: <160e221e-98a8-4097-8340-94ac7d208136@bootlin.com>
Date: Mon, 22 Dec 2025 10:17:07 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Introduce Allwinner H616 PWM controller
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251217082504.80226-1-richard.genoud@bootlin.com>
 <6113404.MhkbZ0Pkbq@jernej-laptop>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <6113404.MhkbZ0Pkbq@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jernej,

Le 21/12/2025 à 20:12, Jernej Škrabec a écrit :
> Dne sreda, 17. december 2025 ob 09:25:00 Srednjeevropski standardni čas je Richard Genoud napisal(a):
>> Allwinner H616 PWM controller is quite different from the A10 one.
>>
>> It can drive 6 PWM channels, and like for the A10, each channel has a
>> bypass that permits to output a clock, bypassing the PWM logic, when
>> enabled.
>>
>> But, the channels are paired 2 by 2, sharing a first set of
>> MUX/prescaler/gate.
>> Then, for each channel, there's another prescaler (that will be bypassed
>> if the bypass is enabled for this channel).
>>
>> It looks like that:
>>              _____      ______      ________
>> OSC24M --->|     |    |      |    |        |
>> APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
>>             |_____|    |______|    |________|
>>                            ________
>>                           |        |
>>                        +->| /div_k |---> PWM_clock_x
>>                        |  |________|
>>                        |    ______
>>                        |   |      |
>>                        +-->| Gate |----> PWM_bypass_clock_x
>>                        |   |______|
>> PWM_clock_src_xy -----+   ________
>>                        |  |        |
>>                        +->| /div_k |---> PWM_clock_y
>>                        |  |________|
>>                        |    ______
>>                        |   |      |
>>                        +-->| Gate |----> PWM_bypass_clock_y
>>                            |______|
>>
>> Where xy can be 0/1, 2/3, 4/5
>>
>> PWM_clock_x/y serve for the PWM purpose.
>> PWM_bypass_clock_x/y serve for the clock-provider purpose.
>> The common clock framework has been used to manage those clocks.
>>
>> This PWM driver serves as a clock-provider for PWM_bypass_clocks.
>> This is needed for example by the embedded AC300 PHY which clock comes
>> from PMW5 pin (PB12).
> 
> No. Drop all clocks related code and make this pure PWM driver, like pwm-sun4i
> is. For AC300, AC200 or whatever other device may need clock produced by PWM,
> pwm-clock can be used like this:
> 
> ac300_pwm_clk: ac300-clk {
> 	compatible = "pwm-clock";
> 	#clock-cells = <0>;
> 	clock-frequency = <24000000>;
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pwm1_pin>;
> 	pwms = <&pwm 1 42 0>;
> };
> 
> ac300 {
> 	...
> 	clocks = <&ac300_pwm_clk>;
> 	...
> };
Yes, that was my first move, but after trying quite hard, I came to the 
conclusion that pwm-clock is not fit for this precise case.
If we had only one source clock, this would be a perfect fit though.

Here's the problem: the pwm-clock request a period from the PWM driver, 
without any clue that it actually wants a clock at a specific frequency, 
and not a PWM signal with duty cycle capability.
So, the PWM driver doesn't know if it can use the bypass or not, it 
doesn't even have the real accurate frequency information (23809524 Hz 
instead of 24MHz) because the pwm_apply only deals with periods.
With pwm-clock, we loose a precious information along the way (that we 
actually want a clock and not a PWM signal).
That's ok with simple PWM drivers that don't have multiple input clocks, 
but in this case, without this information, we can't know for sure which 
clock to use.
And here, for instance, if pwm-clock requests 42ns, the logic is to 
select the highest clock (100MHz), with no prescaler, and a duty cycle 
value of 2/4 => we have 25MHz instead of 24MHz.
And that's a perfectly fine choice for a PMW, because we still can 
change the duty cycle in the range [0-4]/4.
But obviously for a clock, we don't care about the duty cycle, but more 
about the clock accuracy.
When I tried to use pwm-clock, I ended up making assumptions on what was 
the intended use (if the asked period is 42 with a duty cycle of 50% 
maybe the consumer wants a clock), but that was too hack-ish.

That's why I put aside the pwm-clock and I went for this instead.


Thanks for the review!

Regards,
Richard

> 
> Best regards,
> Jernej
> 
>>
>> This series is based onto v6.19-rc1
>>
>> Changes since v1:
>> - rebase onto v6.19-rc1
>> - add missing headers
>> - remove MODULE_ALIAS (suggested by Krzysztof)
>> - use sun4i-pwm binding instead of creating a new one (suggested by Krzysztof)
>> - retrieve the parent clocks from the devicetree
>> - switch num_parents to unsigned int
>>
>> Richard Genoud (4):
>>    dt-bindings: pwm: allwinner: add h616 pwm compatible
>>    pwm: sun50i: Add H616 PWM support
>>    arm64: dts: allwinner: h616: add PWM controller
>>    MAINTAINERS: Add entry on Allwinner H616 PWM driver
>>
>>   .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  19 +-
>>   MAINTAINERS                                   |   5 +
>>   .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  47 +
>>   drivers/pwm/Kconfig                           |  12 +
>>   drivers/pwm/Makefile                          |   1 +
>>   drivers/pwm/pwm-sun50i-h616.c                 | 892 ++++++++++++++++++
>>   6 files changed, 975 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/pwm/pwm-sun50i-h616.c
>>
>>
>> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
>>
> 
> 
> 
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

