Return-Path: <linux-pwm+bounces-7587-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 261B3C2E1FE
	for <lists+linux-pwm@lfdr.de>; Mon, 03 Nov 2025 22:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA5524E1018
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Nov 2025 21:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8323A191F84;
	Mon,  3 Nov 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Sux7xlVU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05A1DFF7
	for <linux-pwm@vger.kernel.org>; Mon,  3 Nov 2025 21:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204618; cv=none; b=PN0lALpzBWgtwjmBRiereOWiTdu5QML04HVOeOJ5b/cMNu9lCv12+Fqrzek7AN5ESNU7dOhZa8riP9jLpLV7FsvrTosc7a6xPP/i3M/BXQxrsdXA+BzBHoc6cnFL5S53dZlpB5Np7NRk7Qg7W6eAfyKI/Ugepf7pav58Q2vL+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204618; c=relaxed/simple;
	bh=lJVb+UIKWPtrPyyrCyGJU+tiUCvOUrQkW1RggUFqsDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyjEI1dwbcnCISZ9/PNbLWmlEteMrFb07bpD8YSY1bWQvqURBBljxaUPagLcALSFYl8PYSKgs9ckreAh6TWlIh+5LhO23UzDy1zwDdvBpHwsuDGySeiMifTcx7iUE03B0U0aGHcKsup+ypzryeiIszfmwI37PKqETN0EvrgNW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Sux7xlVU; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d0ktD5HT7z9ttV;
	Mon,  3 Nov 2025 22:16:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762204612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hZnDAZW0C4dHckVBS1uSBPnsCVim+50VaoGHUMFe+0=;
	b=Sux7xlVUi7lwYKKuPNlHW4dW+rHNHqvxBNyuyw+9EFIa5hQwsaxbgARKuKotjDhdAv+AEV
	63LYgDegXSuGVMVS6hLBlCvnqPw9YavkSxjFXDXO0rUDeUrtZtMyt1BpmlQelyCsIu8u4s
	zt8tIe8kVr74GjP9ksqWrzZioUVGPRDhS3edUwO8QhIm8Fe4y4G7qrq6TsxqtHWt0fKcZD
	Y33sbpw5Dqgr5kPtRMBMUYCj1JKCONanNCk4+xeHP8ZnZx2HBgDI0sA+T3tEBb1uPjjO6k
	uh4UIgeO31mV+W75wnzlOEGk2t511/W/gY9P5W7EaePijvYpeNSBRRtJht/QEQ==
Message-ID: <99609491-10bf-46f0-8178-a3c3d375b742@mailbox.org>
Date: Mon, 3 Nov 2025 22:16:51 +0100
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
 <643bb99a-4d0e-47bc-a60e-208dcc151034@mailbox.org>
 <65639f87c800a1ffcd60d20bb9915772a0d7f456.camel@suse.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <65639f87c800a1ffcd60d20bb9915772a0d7f456.camel@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8c98d2641ca013f0f40
X-MBO-RS-META: zrqma9dcuepheit4nbkcu1zku7whknzy

On 11/3/25 10:06 PM, Jean Delvare wrote:
> On Mon, 2025-11-03 at 18:05 +0100, Marek Vasut wrote:
>> On 11/3/25 5:21 PM, Jean Delvare wrote:
>>> On Mon, 2025-11-03 at 16:55 +0100, Marek Vasut wrote:
>>>> This fan plugs into any arbitrary board with compatible 2x20 connector,
>>>> not only RPi. That connector is present on all kinds of fruitboards with
>>>> different non-BCM2835 SoCs.
>>>
>>> Yet the company who builds and sells this fan device, markets it as
>>> compatible with Raspberry Pi 3 and Raspberry Pi 4 only:
>>>
>>> https://argon40.com/products/argon-fan-hat
>>
>> I don't think 5V , GND , and 3V3 I2C signals are in any way special to
>> RPi , so that statement seems to be only marketing .
> 
> Might be because they also sell compatible casings for Raspberry Pi 3+
> where this fan fits nicely.

I _think_ that the Argon fan/case combo has different firmware than the 
fan, and different I2C commands are used to control the case. It does 
not seem to be very consistent:

https://github.com/Argon40Tech/Argon-ONE-i2c-Codes/issues/1

>>> Which other "fruitboards" would be supported, and what SoCs are they
>>> using?
>>
>> I know of at least one Retronix R-Car Sparrow Hawk board (currently
>> upstream including DTO for this fan, uses Renesas R-Car V4H SoC), ST
>> STM32MP13xx DHCOM DHSBC board also works with this fan (tested locally).
>>
>> The 2x20 RPi-like connector is increasingly present on those evaluation
>> boards, with matching pinout, to be compatible with all those expansion
>> modules, like this fan.
> 
> Does this connector have a name? If so, it could be included in the
> description. And even if not, maybe we can extend the description to
> make it clear that more boards might use this fan hat?
I don't know, various pages call it differently, Raspberry Pi 2x20 pin 
header or some such. I don't think it is in any way "industry standard" 
, but various fruitboard vendors implement it to be compatible with the 
various "hat"s that are on the market, and in the process avoid calling 
it Raspberry anything, because that is I think a trademark or some such 
thing.

