Return-Path: <linux-pwm+bounces-6494-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41B3AE4E4B
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 22:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63454175633
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91F2D5C7B;
	Mon, 23 Jun 2025 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LxcRn7Wy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F492D4B68;
	Mon, 23 Jun 2025 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750711476; cv=none; b=E3X7MSoS4FU0yq814tBjkS6MVLQpYKhWU/mwcJoVSTQ0axLFZEzNfrqTHqnq2afKnvjKdS1UvSOhZ7eCtX3hQm9611yJfgYN2FilCcBx+7jO42UWgS419X5hKuj+Oim9p6I0Nt2VZyiSXnk+5Z0VwF14fmUcX9fIZkZ0kJgYxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750711476; c=relaxed/simple;
	bh=CB7BEmuMIG+McnmrZDtHUFTPvu0ph/3el0m1uADrtnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qgtuw46Plx0tjkpGNDECdJ9av4wSWwK35MVC7AFKDfeZrFTD8wcXul4XQw/YvUg+og1yU2Ch0W9glERaEeaL1v/U2UnR1OGU/ld8mezSXAim4gqK/xp9PhoGsAK9sCe1OIhwKyOTiHoCBg7NMGpKGqJttOgJOlcUwGV8ESKW5Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LxcRn7Wy; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bR0SG02bwz9sWc;
	Mon, 23 Jun 2025 22:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750711470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VHihW110j+ZG4NGZgu02etFf31LpWSQLQKAK3V32HE=;
	b=LxcRn7WyAyHiYyJNR7M7J9AwthjyCJisFTlAXEd3OUdk/99/qQdjySsqxa/utNjp8CsFgV
	bOnkIbytp9PstgAIWJKgcCGCRpC3Pj+bEoEW2XRA4Lf0Q1xMljbbnXN4GUhSTepv4y1IoQ
	7MrqpLUwo6+VzhqYd2u2D5ZLVa5SEl/nWKk6+kiql+Hr4ybeKF77DTQa/qIDXtB57A6awz
	HzgeADlTiHhlTASoC2U74MAu3Qt45+YVp/JyA9wb3/93JQ2sMZVWjf2P9Uk6VlobCDnMcT
	5z8euQa+YNBIdu14ZBhi2IjqFA+OatVqYKdTYlghyL5eRS6ibEVDwfd4HFFMPg==
Message-ID: <033bbb7d-ab00-467e-ab21-877f76d027a2@mailbox.org>
Date: Mon, 23 Jun 2025 22:44:28 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
 <20250621172056.160855-3-marek.vasut+renesas@mailbox.org>
 <purpjdp72jw2rok5ihyua635izyih54ufom2knsbaiwdd3jzgk@6wjf364fao2g>
 <dbec18f0-5df4-4eb8-93ab-da6ccfedf8ab@mailbox.org>
 <apbocxuzcptlpghphh7nchnwyxpfhmiwosgxrt4y5awsb67ar3@fbskfbulwsma>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <apbocxuzcptlpghphh7nchnwyxpfhmiwosgxrt4y5awsb67ar3@fbskfbulwsma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7kzmi57c3ooazz3eg5cmxaab41mjxpj6
X-MBO-RS-ID: 96e805e878dddce9f91

On 6/23/25 9:53 PM, Uwe Kleine-König wrote:
> Hello Marek,

Hello Uwe,

> On Mon, Jun 23, 2025 at 07:30:33PM +0200, Marek Vasut wrote:
>> On 6/23/25 11:11 AM, Uwe Kleine-König wrote:
>>> when I replied to v3 this v4 was already on the list which I missed. My
>>> concern applies here, too, though.
>>>
>>> On Sat, Jun 21, 2025 at 07:19:56PM +0200, Marek Vasut wrote:
>>>> +static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
>>>> +{
>>>> +	argon_fan_hat_write(i2c, 100);
>>>> +}
>>>
>>> If you drop this, I'm willing to apply.
>>
>> Dropping this would make the hardware which uses this device more
>> susceptible to thermal damage, e.g. in case it gets stuck during reboot and
>> does not boot Linux afterward. I don't want to risk such thermal damage.
> 
> We agree here. But the right place to address this is the pwm-fan
> driver. A PWM is supposed to do exactly and only what its consumer wants
> it to do (in the limits set by hardware). Officially a PWM driver
> doesn't know the polarity of a fan, so `argon_fan_hat_write(i2c, 100)`
> might fully enable or complete disable the fan. The fan-driver knows the
> polarity. The PWM driver doesn't even know that it controls a fan. And
> the next guy takes the argon device and controls a motor with it --- and
> wonders that the vehicle gives full-speed at shutdown.

I suspect this cannot happen without non-standard hardware change of 
this device, see the link which shows what this device is, it is an 
integrated PWM+fan device:

Argon Fan HAT https://argon40.com/products/argon-fan-hat

> So I hope we also agree that the pwm-fan driver (or an even more generic
> place if possible that applies to all fan drivers) is the right layer to
> fix this. And note that the pwm-fan driver already has such a decision
> implemented, it's just the wrong one from your POV as it disables the
> fan at shutdown. For me this is another confirmation that having a
> shutdown callback in the PWM driver is wrong. The two affected drivers
> shouldn't fight about what is the right policy.

I would fully agree with this argument for a generic PWM controller, but 
this isn't one, this is a combined PWM+fan device.

The PWM driver is the last one that is being shut down, it is being shut 
down after the pwm-fan driver. If the pwm-fan driver fails for whatever 
reason, the PWM driver -- in this case driver for a combined PWM+fan 
device -- should make sure that the hardware does not melt. So I would 
argue that, for this specific device, the shutdown hook here is correct.

I would propose to keep the shutdown hook here, and extend the pwm-fan 
driver to be aligned with the behavior of the shutdown hook here. Does 
that work for you ?

