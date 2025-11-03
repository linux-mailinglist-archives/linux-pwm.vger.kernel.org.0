Return-Path: <linux-pwm+bounces-7585-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1BAC2D5A8
	for <lists+linux-pwm@lfdr.de>; Mon, 03 Nov 2025 18:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F9FB4E82FA
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Nov 2025 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160C572610;
	Mon,  3 Nov 2025 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="R1/fQrYZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72927FB0E
	for <linux-pwm@vger.kernel.org>; Mon,  3 Nov 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189543; cv=none; b=b+nwu62qZaPyDcnY2iDrLHukVpb5pZrY7OUh08YRjzXDYhYvDRPc5Zdrp5cwEkBKYcXRuIY5f0dmsxG4wPvlQOgwkOq8JGnfOrxDVsTKlb4uRNMOTwq/USfFqqU2I51MLp1BHaiPmmp2wlDQA5qnc0iY56JpTJ5IsTyeYbfF3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189543; c=relaxed/simple;
	bh=eHiQmNfat5j+rsNL2+fIJqS2GhD/xOmU7zU6vNDIkUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YbJ3lm172FBttt7/YFwhpVB35Ym2GNzrUtXqMX8DSHiZPHs90OOTziqhi7PypbCASdM4ywG3G/G3IDaE/FCpwb3dgOHA7AMLqKxgSFctOKblL3N7jKXNz93FNxFp9Hg8OdMO8htTfpdKw51QQJv+X6e01TBeCmmbQPCdb1i3PNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=R1/fQrYZ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d0dJB4sJ1z9tTL;
	Mon,  3 Nov 2025 18:05:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762189530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FLHE+h0BIH97NFsgWYh6DbC9vNGpWS/oDK3tIPpm4Sk=;
	b=R1/fQrYZX6YBMi0UnBLXLMKb3x96FNcEgixabg8h3flCWVE5bYdUW7IDiGdcA51ikjVQGC
	squLf1iufdVcX7MjUod/MyeZ3BjWUMHmashoWwMGIAMVRyvEXjLkEwsf3cJhv1P4KINvR+
	krZTgC9qMBJ4Z2H3YvfH0EydcDi6AeAc+Uhqvdl4DlSr2EVQX8ieC0nXDdhY0NiljiSneS
	PXOWsh0hslDSDLh5awGUJupVfKEpZ089fE2tFvtBi7JyzoohDrLVfQEhFx4FLYX8tQ0BW4
	1fe7KJptbQ5flsSlaDw15gorEr4IcPfLn2NJQGPjrFnwCUrOw6yVH4BIg99Z+w==
Message-ID: <643bb99a-4d0e-47bc-a60e-208dcc151034@mailbox.org>
Date: Mon, 3 Nov 2025 18:05:29 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] pwm: argon-fan-hat: Add hardware dependency
To: Jean Delvare <jdelvare@suse.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org
References: <20251103164752.533aee39@endymion>
 <05b5b096-33cd-45c4-9d9c-286d743c6916@mailbox.org>
 <f6c2d892b64057c079662e8bd64060d45c156288.camel@suse.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f6c2d892b64057c079662e8bd64060d45c156288.camel@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dzjcfa5kfwgmb8uudgog64r5mh4sq3kp
X-MBO-RS-ID: 0d5cef609890db20581

On 11/3/25 5:21 PM, Jean Delvare wrote:

Hello Jean,

> On Mon, 2025-11-03 at 16:55 +0100, Marek Vasut wrote:
>> On 11/3/25 4:47 PM, Jean Delvare wrote:
>>> The Argon fan hat is designed to be connected to Raspberry Pi 3+
>>> systems, so only offer this option when building a kernel which
>>> supports this architecture (unless build-testing). Also extend the
>>> description to reflect that.
>>>
>>> Signed-off-by: Jean Delvare <jdelvare@suse.de>
>>> ---
>>>    drivers/pwm/Kconfig |    4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> --- linux-6.17.orig/drivers/pwm/Kconfig
>>> +++ linux-6.17/drivers/pwm/Kconfig
>>> @@ -68,9 +68,11 @@ config PWM_APPLE
>>>    
>>>    config PWM_ARGON_FAN_HAT
>>>    	tristate "Argon40 Fan HAT support"
>>> +	depends on ARCH_BCM2835 || COMPILE_TEST
>>
>> NAK, this is wrong.
>>
>> This fan plugs into any arbitrary board with compatible 2x20 connector,
>> not only RPi. That connector is present on all kinds of fruitboards with
>> different non-BCM2835 SoCs.
> 
> Yet the company who builds and sells this fan device, markets it as
> compatible with Raspberry Pi 3 and Raspberry Pi 4 only:
> 
> https://argon40.com/products/argon-fan-hat

I don't think 5V , GND , and 3V3 I2C signals are in any way special to 
RPi , so that statement seems to be only marketing .

> Which other "fruitboards" would be supported, and what SoCs are they
> using?

I know of at least one Retronix R-Car Sparrow Hawk board (currently 
upstream including DTO for this fan, uses Renesas R-Car V4H SoC), ST 
STM32MP13xx DHCOM DHSBC board also works with this fan (tested locally).

The 2x20 RPi-like connector is increasingly present on those evaluation 
boards, with matching pinout, to be compatible with all those expansion 
modules, like this fan.

-- 
Best regards,
Marek Vasut

