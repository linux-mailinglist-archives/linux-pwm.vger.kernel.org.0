Return-Path: <linux-pwm+bounces-7840-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515ACF1439
	for <lists+linux-pwm@lfdr.de>; Sun, 04 Jan 2026 20:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 687523003F84
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Jan 2026 19:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8CD222597;
	Sun,  4 Jan 2026 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MzNKUOhT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECCE1F1932;
	Sun,  4 Jan 2026 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767555696; cv=none; b=niBpBU6VwcgcZ5FqMzhCzEZJ7x1UKNQVxtL5RdNWhQJPIg/bStAi+l/YDzCVwMKcnp5xly+G009u8CUSLh7/AJXirIPil4GaJBMgo15hcPbnvV2krGK0AF89LgvPyDKf1T8LKXpB0oQuvD+xG3TFuUNmOZ3fpbNXc2PsqesEy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767555696; c=relaxed/simple;
	bh=Ynk5OxtPNwgAvkiiZxJuRuxbyHsWeP/2+tzoXDiYumw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQsRLOwHTbdhONgvQEoBZa5b9H/OsrdA00AbCkGp00aHoycLFJJWVyrPp5sgEYFU51/5np+Pmi3XTBovN999atx8vQcmz/zONbKSB858MizGIVPtN/CBNa5I9Wo+3HPO//vqWb4aApSTkBV/7ks8smElQou5joqj9ptf3esRtZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=MzNKUOhT; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dknqT3DYqz9sp7;
	Sun,  4 Jan 2026 20:41:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767555685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SRS9TyAMZ+rFEqTCIHNBv2bs+sN2Ifp8XRQss5Lw82k=;
	b=MzNKUOhTyzg/Vv0L3xDcU9JAH/wHUychBZFKBPm9XzuBxF4JpAMcKvWz+DZp0dtqHmUhzK
	Y72vhi8qqpKeumBR0Y33L210KcipIpSV19B+rnaCz/0d4dI7SPfNuJOEbUdBaz+yKyqP+m
	bzNpzqpUspNhpMgLfvj5OYW7QbTlChQp0wuXu1/tAlRausW0JqB3F9Mx/od3MTz0WpYd2U
	phgJutdrUxXpyWoJ4LsrOV3YhM75oMv20PuMBzK6MXlRm5qROVH6/qFOKliGSHyzsjHy9a
	pp7vP7k0Tg18CI1RjQeOphT7Da7pwvVBtpYsyXiyZeFVm8tZPG0A46lBdTARaA==
Message-ID: <05bf0e18-68dd-4eab-b4d2-05af5f8d1ef7@mailbox.org>
Date: Sun, 4 Jan 2026 20:41:22 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
References: <20250904210604.186893-1-marek.vasut+renesas@mailbox.org>
 <qdqla4f5nfccqg2vdwkshzo6znwfizqizsyhfs7ksp6znja7uv@u4uwzvx7pgn6>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <qdqla4f5nfccqg2vdwkshzo6znwfizqizsyhfs7ksp6znja7uv@u4uwzvx7pgn6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: yyscz3n45dewp6c8n84c389itx569fu1
X-MBO-RS-ID: f71df8b8488cc31bedd

On 9/12/25 11:45 AM, Uwe Kleine-König wrote:

Hi,

sorry for the late reply.

>> +static int rpi_panel_v2_pwm_round_waveform_tohw(struct pwm_chip *chip,
>> +						struct pwm_device *pwm,
>> +						const struct pwm_waveform *wf,
>> +						void *_wfhw)
>>   {
>> -	struct regmap *regmap = pwmchip_get_drvdata(chip);
>> -	unsigned int duty;
>> +	u8 *wfhw = _wfhw;
>> +
>> +	if (wf->duty_length_ns > wf->period_length_ns)
>> +		*wfhw = 100;
>> +	else
>> +		*wfhw = mul_u64_u64_div_u64(wf->duty_length_ns, 100, wf->period_length_ns);
> 
> If I understand correctly the device has a fixed period length but the
> actual length is unknown and so assumed to be 100 ms, right?

The period is not known, but the fixed 100ms does not work either, the 
period has to come from DT pwm property to cater for various DTs.

I'll send a V3 now, but even revisiting it at this point, the waveform 
API does not seem to be the right fit for this device.

