Return-Path: <linux-pwm+bounces-1207-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E7849440
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 08:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2439A1F243E5
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 07:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358ACC147;
	Mon,  5 Feb 2024 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UR3yZbFA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98491C153;
	Mon,  5 Feb 2024 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117387; cv=none; b=RSZY9bTK+qr3CtOE7M/AYCkopP/uchWyB15qUb1u4awBSgZTrBPSQDe+JWMMOQSipypZPgcBNmJJewPFbbP7VMKNnv1pXoG4BK1/Q+E3XezauhcVsKdzJHaaH0NREh/+itOS3WH33/eyteFT+UePdN4NwAxwAcqgXVJmri8yNkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117387; c=relaxed/simple;
	bh=LzczV6ttlx1uBbAa9GF6DEJ9VQqoG5A1V8orZVOJ78c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ek17LS6GFEkaklEe9afqHyHdBsxAyDXL9KutvuKksqH0aKxML7y7LtmY3w7sUE1cIBtLrR8vJaqezUJPuEuWohoxtw/QEwwJByfyYTT4Y16Cr4NtB0WZwJDVp5ROi4Ci2phJv/+1rhOTmxXmmQn9vdTAPsjxZAWj+WyklVBbwd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UR3yZbFA; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707117371; x=1707722171; i=wahrenst@gmx.net;
	bh=LzczV6ttlx1uBbAa9GF6DEJ9VQqoG5A1V8orZVOJ78c=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=UR3yZbFAoLyj4i40Gh7S8janFp6f0kq7BTZ/0RB59eiyvkEIFFFSW3E/OnMtokg+
	 ///oq5dD4bHOAKQsVy/G3xKj5o4bxE5/v+WmlkaIyWSEK9xcQOgsb9wWpLy3quwUB
	 5Z7l7pMhbXMdmFsxJo8m3iuizXKx/imRHSzCTvTJJ8V7xXUJ8qdNIpFlMKCGvtqTy
	 KOmopHngUG1QoURStFpNW+AH+qOcIy/EHw3o4ZhZk3Lsupu8QOpdjvfRh32I0Qaqc
	 bPlC7LC1KAOZwyr8pT/RweOVfXW5qbi6HSKxSuPEcF0ZumkEEnPPvVWFaIvNRGaWT
	 Im/wWNOvX7t5BoDvCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlw3X-1r7D5t4C2N-00iz5j; Mon, 05
 Feb 2024 08:16:11 +0100
Message-ID: <182bf1bb-cc90-4fe8-a226-1cfd5c10e41f@gmx.net>
Date: Mon, 5 Feb 2024 08:16:09 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
Content-Language: en-US
To: Dhruva Gole <d-gole@ti.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, andy.shevchenko@gmail.com,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>,
 Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-3-wahrenst@gmx.net>
 <20240205061129.gdwzmpuxrzxj5cov@dhruva>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240205061129.gdwzmpuxrzxj5cov@dhruva>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7TrENmu4IOvu/3zEJyrB0jqd6OSDq3O3QR9sA16rV+sENiR3fwY
 y3isJB9IW9bIhZosKH/TtjgAVzeWQJmAGuac0fd5EKuQwlLFby3yDT6v2LvZAMLTyBjNPJF
 tMz/nIuvFuugprneAHkRyGdElW+66/cs5iRiK0UbxM4f/pJTF3H/y9MBsiJhYvcYGtDnzLy
 JP2pzc7id7W+IC3cPgv8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W2f8Ei940Vo=;xh1GJNUpTpDslOEbDaXw5OWUMc6
 /D3tfsJhYN2KO1x5s0alq8NTdvzyyMkELu1GEqTGvKcYV1eaDpEa88CeZ2/bEHACRSasoIb6P
 2FAWdQ1pzGT3M5Ao9xGmXqRUh92wFFA8ZVQj1oQ6olVhxSIDciwvOHg1knKJoVuPhnbqhKDiF
 +cVEyj3oy3dMKxq8iId7KhopTjbQEJPs3Kiktj4NrNSBrM6uF5v/tgWJhvCuVZimVG7ntzYsn
 9fcG6+rlCSrHOTpquUCK28txknOwyGFaOgWgSlshn5udnVr/K98v5qx13aS2qIJLh8tRWQNAx
 JbkkWjxrG5F13XboBxcE1RY/EqAqfhVyW9VH35FHYHIbOH7RA41RN3m52HsP2U/HrSvrdN8qG
 Y2188iYFA8pbLS+V8FUok6daEnUrOgF2hah7+19idle3KHYOFzk0Pon3PW4ZGGORyr7YH42kX
 VX7gV8+nEOk2652sauNpunbkKK8pQ72i3D9IGjONWFSTzwj5cuDYL9eVxTaZz5zwZWYnxkhzz
 fbNKjPUj8PovL6u+htmm3lzvq1Eq1nE41ErO3uoLH0eEAXqMT4vv3g80EQfTFtsl9x/FUOkvE
 vM+7R2et+zN2GXHbqkHWnDu41A9Zb0GCmE69iEZcXLNCjJwqSvB6KCJ0/7SqeJrHjX8fcgs3c
 9y9Gqm/GpkXYWKB57zbov7ZWGcwHVO22uguDoq1eNXDRkErRpfXJgpNtOfQpEERo7GhBLOJ9S
 skEjCbcqnUwGiddRNMwqX0Gw8aK9ngioroPbtG8ykuLrOWtOBUdDAAjkCljJGqhlpFWQhqJZk
 lDPeB2T8JibfRAm5jaEUe9d7FJQZxJn50HI+5tTMPZ3gc=

Hi Dhruva,

[drop Vincent's address because it bounces]

Am 05.02.24 um 07:11 schrieb Dhruva Gole:
> On Feb 04, 2024 at 23:08:51 +0100, Stefan Wahren wrote:
>> From: Vincent Whitchurch <vincent.whitchurch@axis.com>
>>
>> Add a software PWM which toggles a GPIO from a high-resolution timer.
>>
>> This will naturally not be as accurate or as efficient as a hardware
>> PWM, but it is useful in some cases.  I have for example used it for
>> evaluating LED brightness handling (via leds-pwm) on a board where the
>> LED was just hooked up to a GPIO, and for a simple verification of the
>> timer frequency on another platform.
>>
>> Since high-resolution timers are used, sleeping gpio chips are not
>> supported and are rejected in the probe function.
>>
>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>> Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>> ---
>>   drivers/pwm/Kconfig    |  11 ++
>>   drivers/pwm/Makefile   |   1 +
>>   drivers/pwm/pwm-gpio.c | 228 ++++++++++++++++++++++++++++++++++++++++=
+
>>   3 files changed, 240 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-gpio.c
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 4b956d661755..7cfda2cde130 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -227,6 +227,17 @@ config PWM_FSL_FTM
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-fsl-ftm.
>>
>> +config PWM_GPIO
>> +	tristate "GPIO PWM support"
>> +	depends on GPIOLIB
>> +	depends on HIGH_RES_TIMERS
>> +	help
>> +	  Generic PWM framework driver for a software PWM toggling a GPIO pin
>>> a software PWM
> Nit: remove the "a", as it's not required.
thanks will fix this.
>
>> +	  from kernel high-resolution timers.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-gpio.
>> +
> [..snip..]
>> +
>> +static int pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
>> +			       struct pwm_state *state)
>> +{
>> +	struct pwm_gpio *gpwm =3D container_of(chip, struct pwm_gpio, chip);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&gpwm->lock, flags);
>> +
>> +	if (gpwm->changing)
>> +		*state =3D gpwm->next_state;
>> +	else
>> +		*state =3D gpwm->state;
>> +
>> +	spin_unlock_irqrestore(&gpwm->lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops pwm_gpio_ops =3D {
>> +	.apply =3D pwm_gpio_apply,
> Kinda looks like this is setting state? Can we be consistent with the
> naming then, like pwm_gpio_set_state?
The pwm_op is called apply, so the expected suffix would be _apply like
all the other PWM driver does.

grep ".apply =3D" drivers/pwm/*
drivers/pwm/pwm-ab8500.c:=C2=A0=C2=A0=C2=A0 .apply =3D ab8500_pwm_apply,
drivers/pwm/pwm-apple.c:=C2=A0=C2=A0=C2=A0 .apply =3D apple_pwm_apply,
drivers/pwm/pwm-atmel.c:=C2=A0=C2=A0=C2=A0 .apply =3D atmel_pwm_apply,
...

> This will help those contributing to the driver or referring to it to
> understand better what each function is doing exactly.
Using ...set_state here would confuse all the experienced kernel developer=
.
>
>> +	.get_state =3D pwm_gpio_get_state,
>> +};
> Otherwise, driver looks good to me,
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>


