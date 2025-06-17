Return-Path: <linux-pwm+bounces-6396-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14732ADC600
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 11:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EB91898EC2
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jun 2025 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622E28DB46;
	Tue, 17 Jun 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="I2UcXARc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="o+9TuroN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035E23B601;
	Tue, 17 Jun 2025 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151944; cv=none; b=AdOkTVSSvJmT19om+78G+04y3mdZeTGyXa/SfkjuCRM/u+M4zCjrLw6K30KGe3JV0AyoqUGG3qdiVwDJ891IBkqaI7GdcxbMKS0c1Hiz+cnVxUeKNvBTAQ7pM5BfY2mjKxRukN9m0Zjy/0TWyU+aGpfPgP8ao4mvbZ/UfZWr0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151944; c=relaxed/simple;
	bh=XlmDEhCLj896EF5CXpue1pz3jWwV/+WeCegTcO2O7fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r89hGPyhJIxxfz0De6tJ6NzHXSihgA/FHtIAkBXPt9FxrWYVgC2pNc7YSxPykO1mXcysVIQLWszB6753nLtJmUaebkEO1+jKCGUeZ9CSPG0LK3O6G9rE02XZrwGmtYuXMV8K8nN96eSRsB9Fb3SzIEMWhJYnqUbGOIEsnanul8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=I2UcXARc; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=o+9TuroN; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bM1X45Xlpz9sv3;
	Tue, 17 Jun 2025 11:19:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750151940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BtQVcBjH7jNp1ePYyBGsH21Pel14Dm9n9MFKiVjzLs=;
	b=I2UcXARcfaNeo2VKTFXbSBq99fD9B3UBTQ3hAD/3FPXo8MgksZUmf2MHvb1M8aLCTkkklv
	4rWCUfwGiq89opDxpkEvnORS7HoidZ8gmXmrl4YFwZnw94VCkSoPpaelpQmRi2E2okbB1+
	5mm1oMPAypm7gfn7fhcLR3QwFggargHdTDAwfqGqtJZpbjcW5Jvo5R0sSR/+fq6UU2ZStX
	0+14kLe1GUpyArDS+jNA2LvID+ZGBcH3M23pmCf9J95FTF/vD+M4VHMeYOhhbdgCm8aw/f
	Ayk4axPRuAgM89uk9Fcect/fqCWaSQbnO6bCOhxiWEdzC9NV0lJjeutIrbBo0A==
Message-ID: <1698313a-1fd8-4c30-8ceb-a95461edccb4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1750151938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BtQVcBjH7jNp1ePYyBGsH21Pel14Dm9n9MFKiVjzLs=;
	b=o+9TuroNimNA9wjdkppM5wAhHtURmzBVZrr4XclSWjaBKqx8p9pBlVViEJ9Bw+AUIvCId7
	x6LsDOaK0mTz1pT+4+zNBVXgwy8b2DvFli2PmBOMD1UubkIpCCJ+pWZR2u3TjpBhFqW62d
	DsRE6ntZfsF0MZy8Y2tFxn/WYxGh0/8DfHBDIWaNF577d0haU8+wTMl2vaJctlsx8M+rZ7
	T6fO8BFGZOhzzVfE43HbkOz3Lffb3tKs/J7Hvnw3Soe3MIZotGtAIR7I0lVFC2rb2tFYR7
	+N126K22jMimL1Kj0U5sbuT/VAhpzFCLfnJq2g456/uJLCx/8wJOX99/Fl8fVw==
Date: Tue, 17 Jun 2025 11:18:56 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250617002852.606409-1-marek.vasut+renesas@mailbox.org>
 <20250617002852.606409-3-marek.vasut+renesas@mailbox.org>
 <47s4qjr7iujql36opgkp3cniq46oc4p72aaewzs3i3oxp4tcgn@ikrczuyxcqwb>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <47s4qjr7iujql36opgkp3cniq46oc4p72aaewzs3i3oxp4tcgn@ikrczuyxcqwb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8n69xspdyca6bzoefomy9396ybydb5im
X-MBO-RS-ID: ec261980d1a03845eca
X-Rspamd-Queue-Id: 4bM1X45Xlpz9sv3

On 6/17/25 9:59 AM, Uwe Kleine-König wrote:
> Hello Marek,

Hi,

[...]

>> +static int argon_fan_hat_round_waveform_fromhw(struct pwm_chip *chip,
>> +					       struct pwm_device *pwm,
>> +					       const void *_wfhw,
>> +					       struct pwm_waveform *wf)
>> +{
>> +	const u8 *wfhw = _wfhw;
>> +
>> +	/* 1 step of this hardware is cca. 1200 Hz increase in frequency */
>> +	wf->period_length_ns = DIV64_U64_ROUND_UP(NSEC_PER_SEC, *wfhw * 1200);
>> +	wf->duty_length_ns = wf->period_length_ns / 10;
>> +	wf->duty_offset_ns = 0;
> 
> How extraordinary, so the relative duty cycle is always 10%? In the
> binding patch you claimed duty cycle was constant?

I actually found a fixed 30 kHz period PWM at the underside of the 
device, with configurable duty cycle, so this will be fixed in V3.

The rest should be fixed in V3, thanks.

