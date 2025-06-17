Return-Path: <linux-pwm+bounces-6388-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 908E9ADBDEC
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 02:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F0C160BCD
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 00:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA97483;
	Tue, 17 Jun 2025 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EaXvgmtC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Owlek8XE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302315D1;
	Tue, 17 Jun 2025 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750118865; cv=none; b=n/3akOqQwKY+cYE8dqeevTkhlIBqXdH1ZhVobpKTQWe8XGfHcRmkj3LS1FX6wpzbZ0BCEoaAdR5RhXSKDIplAUmYBQEwL3pRPS8oyEk3S8/5wPoXuTq1mwj0stpKpSqjKTY29Gmf3k6boBNR8s7zucZ781ONyCgE77yN7ctIxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750118865; c=relaxed/simple;
	bh=+GOSnPA+f9Trr5CeE6V0npPlUTWzgrSNCL2ruCZqQWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8JwuYloru0sL5uRqshWS2t1LaSWppryrI2bscWT6Wekff6iG0pkTEURzB9MCzAZhiQ+VGJEVVSIzctS8r60km4OYTQRMhtn1E0PZf4CpkE1HqgSmXLtZav95wYIZzIf8H7ulwKkWhCZmrvOXEEOnykdzUux92ydv1aFBP6lWfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EaXvgmtC; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Owlek8XE; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bLnHx0K4Fz9tTf;
	Tue, 17 Jun 2025 02:07:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750118861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnsIyW9tv0sGXNtyowY3m/tCK7SsmF8uHZkFxsRk0JA=;
	b=EaXvgmtCce17StNGPYwn24Hc27mpZJ3tkEaaJqAE+hCgJn1i1Qo5IQ/ThV7GIwFFle4dF4
	u/HKtLJPi9ujH896vhkqXyPAGHcQG2QjESYGRMSDTgrEeZiVH4LMd9cfuzp4cf9ROvHMKt
	G3eOsyDT3yEGzm+9+W36uBEu5J2NRaSUWwykeqA7Ti8gQaqWQUvqMFU81n7JM+lV0YIMCv
	LjX0Rvppwv6C4iaN2lCOruTvA6XGayk6sQco9pT4UL1nnW+zRD+8F+I1R9FZ3SfvFZKTb7
	8ReeGMQFEglFt4MXK562tmBG+pBm86CK26z8xfvsBTSVy7i2+7cg6afGHZHwVQ==
Message-ID: <b04c3e8b-531d-4990-8e26-b00c9531700b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750118859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnsIyW9tv0sGXNtyowY3m/tCK7SsmF8uHZkFxsRk0JA=;
	b=Owlek8XEHGk+/8i3uQo83VXByhiaGBzDCFZ5MGbjSf92XauzuvfY8tQaYRTEhjRknSzRr+
	vyqXg8vvv7w+otnXLfPKpOcYN+kwSZSQZC8viE15UFBS2BDXv1/adKE6aERi4ZB30R/xre
	XO50ouH3oMSCjudpmspmPsNSVS7MIt8Xdx+QTwD+RCePmzK5fTdTd+qY84Oe8gTqFKEj35
	x9K0BGeqpxk3I1DsTUOOTrNJZxpKXSsietjQ0fhrS1cSNBf3up7uEzEhkjVYO0QjGK8j7P
	6Dju/TBDBYQIPCQSmB0iKpAZhiyjMg8r/2N6HfxVZ7Weh7P0mcJVgJy4wVAH/Q==
Date: Tue, 17 Jun 2025 02:07:37 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250610220814.167318-1-marek.vasut+renesas@mailbox.org>
 <20250610220814.167318-3-marek.vasut+renesas@mailbox.org>
 <3vfic5s64fzs5e4k33dik74rrwpsivj6fiwzdy5xckald43y4c@kcalsxmse6mp>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3vfic5s64fzs5e4k33dik74rrwpsivj6fiwzdy5xckald43y4c@kcalsxmse6mp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sykr4yh4d7cpkyajqprfanpep19hzct3
X-MBO-RS-ID: 7573945765a46f24491
X-Rspamd-Queue-Id: 4bLnHx0K4Fz9tTf

On 6/11/25 7:55 AM, Uwe Kleine-König wrote:
> Hello Marek,

Hi,

> I wonder how this device works in rpios, I didn't find a matching driver
> (but I also didn't try more than two minutes).

The installation guide is here, download the PDF:

https://argon40.com/blogs/argon-resources/argon-fan-hat-installation-guide

Which leads to this script, which you download on the RPI and (better 
not without reading it first and understanding it) run:

https://download.argon40.com/argonfanhat.sh

Which downloads more scripts, installs systemd services which run other 
scripts, but ultimately this convoluted scripting leads to a single 
register write for this fan.

> On Wed, Jun 11, 2025 at 12:07:27AM +0200, Marek Vasut wrote:
>> diff --git a/drivers/pwm/pwm-argon-fan-hat.c b/drivers/pwm/pwm-argon-fan-hat.c
>> new file mode 100644
>> index 000000000000..3d04abdbd349
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-argon-fan-hat.c
>> @@ -0,0 +1,64 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2025 Marek Vasut
>> + */
> 
>   * Limitations:
>   * - fixed period (which?)
>   * - no support for offset/polarity
> 
> If you can find out if it completes a period when reconfigured that
> would also be nice to document.
> 
> This device is really trivial, but for completeness' sake: If there is a
> data sheet publicly available, please add a link here.

There is nuvoton MS51FB9AE microcontroller on the underside of the 
board, which I think does the I2C communication and PWM generation. The 
firmware source does not seem available.

I can see some signal on the FAN itself, it is horribly noisy, but with 
sufficient filtering I can see they change the PWM period, from some 0 
Hz to 120 kHz , with duty cycle being some 10% (but I might be wrong, 
the signal is not great).

> 
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/pwm.h>
>> +
>> +static int argon_fan_hat_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +				   const struct pwm_state *state)
> 
> Can you please implement the new-style callbacks?

Sure

[...]

>> +static const struct pwm_ops argon_fan_hat_pwm_ops = {
>> +	.apply = argon_fan_hat_pwm_apply,
> 
> Can you read back the configuration? If yes then please implement
> .read_waveform().

Nope, reading from the I2C device stops the fan.

Rest is fixed in V2, thanks.

-- 
Best regards,
Marek Vasut

