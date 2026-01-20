Return-Path: <linux-pwm+bounces-7967-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD2yNxzAb2kOMQAAu9opvQ
	(envelope-from <linux-pwm+bounces-7967-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:49:16 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A634648D7B
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EA8A0760B17
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 15:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FBB43DA44;
	Tue, 20 Jan 2026 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xg6Q/50E"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4631335FF47;
	Tue, 20 Jan 2026 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920924; cv=none; b=q5Lc0xepEEn5yXgg7VUIv69ldr1/2vXCSkX+QIXR4CMTVrC6GE0RprkQr7CkQf1Zg+EJO6mu9pp5HeqNvRHs8mvb27aqy5J/dhw+OhPBYVJy9q3yO8WjUOzsNWoqLn+xBycO/gG2uRI7ARJ320Fz9UyUkDfCCrsdgQO32W1A724=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920924; c=relaxed/simple;
	bh=L5WFAOB92nyW0Q54sPrHqzKx+kgCiTHOP124BL6cjcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyHFqBoojChedd+rkJGwtv+fCweHmBRAb7o7WtYfyMKpyuEXxxtVaWD9vvscQYil49bflO122rgdsy6Jct5hys6XDsLviA1p699KdrEmrHwLDHJfQjMFXcUvPTLxu41unZJ5k/V7p7MwRLRVT5pdYahduQe+TAfKtYFAlNCsW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xg6Q/50E; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dwVjz37pwz9v0t;
	Tue, 20 Jan 2026 15:55:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1768920919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpc1SDn2qhCusp6Gb2ZoVVuFPour3yCpuH5Nk4o3jcc=;
	b=xg6Q/50EJPBVGETsSzG+aWApaCCLy1haUfr6IicMD455bY8tgF1j2X3Kjhy0udkNFaAOD6
	DnOA5AaVGznPrjmaMQitJihF2kb426Kgm3CvKwRrqRj/xvoIf8DUQvzUXjQOgmJf5sHtIh
	RmMVvF/knRYgBN88p6U1xevUSLx9eQii+x18C4ylF1cDApE1Zx4b+0YBKmkeRkAfxrKw3p
	0tJkkD2KLrkdd7zwN8o/8heDQl84ZPZoZkqwDVYmNybm4j0rHDkRFjF6ly6hukrSLXfdIz
	vfl5ILeX/R5hX/xkmbuk7zbL6RAjjj3Sk25C8Nwjo3tQeQjF7VgBbI5Tsl3lZQ==
Message-ID: <6f2b7a15-5d43-4a63-b374-6a452d1ccba7@mailbox.org>
Date: Tue, 20 Jan 2026 15:52:41 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
References: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
 <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
 <797047eb-e422-4a8b-80eb-ab130066c1d7@mailbox.org>
 <xsjwvmlqclctnf6dgwyuoi7zits27is2s7r7taprb2w2lhsf7i@uiljd7o3ivbk>
 <855e5015-98c8-48f6-9320-ca8163591940@mailbox.org>
 <CAPY8ntACxpoZV2_8-9028AaA1mBScUOuK06a6x-XwdSeobiauw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAPY8ntACxpoZV2_8-9028AaA1mBScUOuK06a6x-XwdSeobiauw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1wimnp1x37mihjn1ognx35xa1xwm847i
X-MBO-RS-ID: 92f34e3b36060c25839
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-7967-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[mailbox.org,reject];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mailbox.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: A634648D7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 3:41 PM, Dave Stevenson wrote:

Hello Dave,

>>> On Thu, Jan 15, 2026 at 02:14:15PM +0100, Marek Vasut wrote:
>>>> On 1/15/26 11:12 AM, Uwe Kleine-König wrote:
>>>>> On Sun, Jan 04, 2026 at 08:41:43PM +0100, Marek Vasut wrote:
>>>>>> -  struct regmap *regmap = pwmchip_get_drvdata(chip);
>>>>>> -  unsigned int duty;
>>>>>> +  u8 *wfhw = _wfhw;
>>>>>> +
>>>>>> +  if (wf->duty_length_ns > wf->period_length_ns)
>>>>>> +          *wfhw = PWM_BL_MASK;
>>>>>> +  else
>>>>>> +          *wfhw = mul_u64_u64_div_u64(wf->duty_length_ns, PWM_BL_MASK, wf->period_length_ns);
>>>>>
>>>>> This is wrong. There was already a discussion about this in reply to v2.
>>>>> I'll discard this patch from my queue and continue the v2 thread.
>>>>
>>>> Instead of resuscitating the old thread, could you please tell me how to
>>>> make the conversion, so it won't break with existing bindings and the result
>>>> would work as well as the current code ?
>>>
>>> the only way you can do this correctly is to measure or research the
>>> actual period length of the device. As this seems hard, the function I
>>> suggested in v2 works for me, too.
>>
>> Sadly, that does not work on the board I use , which is the one below.
>>
>> I was also hoping that Dave might have some input on the PWM frequency
>> of this display.
> 
> Sorry, I don't have that information, which is part of the reason why
> I originally wrote the driver as a backlight driver rather than PWM.
Is there someone you can ask by any chance? Is this hardware made by 
waveshare ? Maybe they would know ?

