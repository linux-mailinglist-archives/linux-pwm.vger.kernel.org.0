Return-Path: <linux-pwm+bounces-7910-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1BAD24E75
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 15:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 392EE30155AC
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB18308F28;
	Thu, 15 Jan 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="b8Pej4fN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F5F24DFF3;
	Thu, 15 Jan 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768486739; cv=none; b=j3AbG44IhO6dZJmPSKxtcut0ToXb8wvR0+AkhXY8TgcK63QZHQdAjmAlQhRQnaMfZ7VKRuWrWwuwbjweAlDkAYQRmdREUNku3SXrRXtJ3eihLfHp4EdgZ/1zOlSh/XqI5io0iiUSiKHxeBtv4FfP84iLnLXpdV+7yOZUlfcrjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768486739; c=relaxed/simple;
	bh=xpyU9zcUbmshcLKlsAbdYRqBeQX3o5N+9k9R5x5sNYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BR4guHfl8ktGUacESO0kkp6ajucmcsNyVFM5P9tBG67j25yVSQdxsokIlYsmTvVoHE7aq6IWRHYduRzyasjGIwRgyinAIHdW1KdmH94vPLohXTQSmu0EReuYZnjOeu0hCdNbTd3E4207gIqoTYjuODQJVo0Ax7rp0glGBp9i7kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=b8Pej4fN; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dsQ8D5Vfgz9tvl;
	Thu, 15 Jan 2026 15:18:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1768486732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sI940SyMyOcigxQb/EA7c1M4MnBebpW8r2OlWJz2Kh0=;
	b=b8Pej4fNb4YW5B/VxGxk9Hz84qbnjee4Db7FD4cBAjsS2orXnRtt/tFBRDxe6tcoLTl5RR
	KiuerrWx8AT6zrRaQnc7pSFNy398qRZV8P+KIKlTPc8DYXfxabv82mbNNHNkhJ+4JOmIs3
	bJlMOKYKLf7sjDyGUFYfNyeWvRJQYptMpZ/uZnLMEnygQipafZw1tcra5xN1ZqnFWWQcva
	ctfvZi/S0IvOpCAhujIBvLPUv9kLg4WijPDOYW85K1Fb0W+ODm7xiM0iHV1vErQCd258Za
	ONQT5Dyt3mOIN6jtTGMwpeZo0TYRVOf2C3nQ8w6obaUczICtTqq+79m7MqG1VQ==
Message-ID: <797047eb-e422-4a8b-80eb-ab130066c1d7@mailbox.org>
Date: Thu, 15 Jan 2026 14:14:15 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
References: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
 <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b796058aedba4aef996
X-MBO-RS-META: bcj9i3gmcwfckpxqnokhq6ywuor176gd

On 1/15/26 11:12 AM, Uwe Kleine-König wrote:
> On Sun, Jan 04, 2026 at 08:41:43PM +0100, Marek Vasut wrote:
>> Convert the driver from legacy PWM apply ops to modern waveform ops.
>> There is no functional change.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
>> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Cc: Liam Girdwood <lgirdwood@gmail.com>
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: linux-pwm@vger.kernel.org
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> V2: - Safeguard against wf->duty_length_ns > wf->period_length_ns
> 
> I would claim that this is a bug in the core if a driver sees such a wf
> variable.
> 
>> V3: - Use PWM_BL_MASK as the maximum period length
>> ---
>> Note this now generates warnings:
>> pwm pwmchip5: Wrong rounding: requested 162/255 [+0], result 19000/31000 [+0]
> 
> So the driver is wrong, see below.
> 
>> ---
>>   drivers/regulator/rpi-panel-v2-regulator.c | 53 +++++++++++++++++-----
>>   1 file changed, 42 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/regulator/rpi-panel-v2-regulator.c b/drivers/regulator/rpi-panel-v2-regulator.c
>> index 30b78aa75ee38..e5e12ff649804 100644
>> --- a/drivers/regulator/rpi-panel-v2-regulator.c
>> +++ b/drivers/regulator/rpi-panel-v2-regulator.c
>> @@ -35,24 +35,55 @@ static const struct regmap_config rpi_panel_regmap_config = {
>>   	.can_sleep = true,
>>   };
>>   
>> -static int rpi_panel_v2_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> -				  const struct pwm_state *state)
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
>> +		*wfhw = PWM_BL_MASK;
>> +	else
>> +		*wfhw = mul_u64_u64_div_u64(wf->duty_length_ns, PWM_BL_MASK, wf->period_length_ns);
> 
> This is wrong. There was already a discussion about this in reply to v2.
> I'll discard this patch from my queue and continue the v2 thread.
Instead of resuscitating the old thread, could you please tell me how to 
make the conversion, so it won't break with existing bindings and the 
result would work as well as the current code ?

