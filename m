Return-Path: <linux-pwm+bounces-6464-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631CCAE2AA2
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 19:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D273BD1BC
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Jun 2025 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793FE23643F;
	Sat, 21 Jun 2025 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G7CU0G7r";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eBYFpmja"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4622222CE;
	Sat, 21 Jun 2025 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526399; cv=none; b=R72v+gMgy0ODhNZS5Q0LvITWCqvq6YT0QfdOmuLNNuL9P7gg3sOOXYCDSx/NFrIqDNNgYEBBa2u9PAmjkf49tOyyrPkyHv8lvBIOYLRlZg6gQeTuf4qdBuOT0y24R5vXTl1eP2ktk0Cl0OybHgM8ilr/McSf+M3poeer1UVgjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526399; c=relaxed/simple;
	bh=/rYtmmNYw+6vj67WCLNmPW917Q0ItenIXSAMMVkiZHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fg7veqjZWBHxgYs+L2MEExSR/brVXdKtlBmcwyP06ULtvakRdt2xDNgbjy/VTFy5iP8ak1zwwMbF/PsSd+6+5gYJClRIRGDvmv5TwE348YsgsJVK5Z4tHzq2LKfvpHLUNxP3es/ZxkAIPA13HpAd4vtv/8vdexPzP+5nfWcYVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=G7CU0G7r; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=eBYFpmja; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bPh171g6rz9smF;
	Sat, 21 Jun 2025 19:19:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750526395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/o8SytGqLrPW++cgqD523xjz89j9jqhYkyN19k+2To=;
	b=G7CU0G7r4VS/cavdQvqq67jdI+e0mR2eJwNu/zQDi4g4IM9K6BuNzza3ghswmzBTlVHeLb
	cUpK8dPt13AUTQ8S2J+xFOpa0e+AnXA2vI2xDt7FpSPHPMAzMH8L64iryyu55fL+bauwxm
	XtpwTCraNce7i4FEt0mfdHJt88ss64ZCuQsMF4LY+/gkyhXglm0NyVjt2Myolu11Dze+j/
	dqH6OB0e8VIum4qVDG1rgGwgLIDy7ikkZuv9KhpJDREm6piHVMM9k/3KWL2HgolkfHRo4c
	mRgV5LDy35DxMtLt+A2itYj5vpUjdqPbI+tKbp/+4ZI5OxPKCbf1VtoKGciFUw==
Message-ID: <7ed914a7-8a40-4e13-8783-0fc2c01546e5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750526393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/o8SytGqLrPW++cgqD523xjz89j9jqhYkyN19k+2To=;
	b=eBYFpmjakuZnWQDC555gHSe2TpGnpktAqBtYgr983PEcj8o31tQqANwYfkYFqYagche2gi
	zCOT5sjJAZrvJFyieVtnOmZ4FTMG8z4u1UH/tdb7BFImUyteBGOLrblLgXuqjxuTikTTey
	k+VfU6GihXR2SaFcBodtAt7cMyf7/0sNfHJfk6hGqkuFn8EYMvKUv07MQLcVlGH0+qoQDF
	rKXs/Eh8cU9KHfeKtWcX66Ufd+vwnuCcBnF9WXDbopMBKW8Q3ax9I6RVW/wuAmHJaoIq9o
	dIkgeuDO5o4pAhyammCGgR7mymDD8JNalVMpRPbotbR1Zqh+GWxegXXZ6035Nw==
Date: Sat, 21 Jun 2025 19:19:51 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250617092037.37229-1-marek.vasut+renesas@mailbox.org>
 <20250617092037.37229-3-marek.vasut+renesas@mailbox.org>
 <fhns5fnckokwsb572kge6tmqaaoholzvgncdctj7vskigytvmu@3uirsrszul36>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <fhns5fnckokwsb572kge6tmqaaoholzvgncdctj7vskigytvmu@3uirsrszul36>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: adnbsmabp7tfe8umzehd83rnr4ery46f
X-MBO-RS-ID: 0fb01e9de8abf08b292
X-Rspamd-Queue-Id: 4bPh171g6rz9smF

On 6/17/25 4:02 PM, Uwe Kleine-König wrote:
> Hello Marek,

Hi,

>> +static int argon_fan_hat_write(struct i2c_client *i2c, const u8 wfhw)
>> +{
>> +	u8 tx[2] = { 0x80, wfhw };
> 
> The vendor "driver" has `ADDR_ARGONONEREG_DUTYCYCLE=0x80`, maybe put that
> into a define, too?
> 
>> +	struct i2c_msg msg = {
>> +		.addr = i2c->addr,
>> +		.len = 2,
>> +		.buf = tx,
>> +	};
>> +
>> +	return (i2c_transfer(i2c->adapter, &msg, 1) == 1) ? 0 : -EINVAL;
> 
> The vendor driver uses smbus stuff. I suggest to use
> i2c_smbus_write_byte_data() here, too.
> 
> I also found that the vendor driver reads the duty-cycle register (using
> i2c_smbus_read_byte_data()). Strange that this stops the fan.

So it seems.

[...]

>> +static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
>> +{
>> +	argon_fan_hat_write(i2c, 100);
>> +}
> 
> Isn't that something that the fan driver should cope for? PWM drivers
> usually do nothing on shutdown.
It's probably best to force the blower fan to maximum before 
reboot/shutdown. The firmware might not handle the fan and the SoC might 
get very hot before Linux boots again.

The rest is addressed in V4.

