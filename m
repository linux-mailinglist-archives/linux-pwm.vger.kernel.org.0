Return-Path: <linux-pwm+bounces-7979-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMBPAkE5cGmgXAAAu9opvQ
	(envelope-from <linux-pwm+bounces-7979-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 03:26:09 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0164FBD6
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 03:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C4039AFD5B
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3297E338F45;
	Wed, 21 Jan 2026 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K7EDIs8D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075C2E5D17;
	Wed, 21 Jan 2026 02:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962249; cv=none; b=Ce4mB8oYb5CFq+fheVmHahXhYfJQ0RJoqCCtC8NUlyn1ZsrglZfKqkOWgevClSCV0ZyX7op2/nyXYEM9rFeQ4c6h0J04ClOrmKs7QVQtx+gN3IsX5xkvDjK3s2BcQkd/8Skw2CxEWceQYW9F99L/YtOE1A5EAWtyJhDKMgrpDSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962249; c=relaxed/simple;
	bh=v/yj/kp8r9CBfpaudev5cN6BVipUza/iUdEnMW0awj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPHycjm5oZrSNWNaRmkGKsWwZocJ0eHCawqk2kv7+SzjdRbQIDF0TizztYAb5XTu9LZ4TV+MdTfLdUmf9UtkoluC+6z2Kvd/q3WkdCB7rCpfm7qjH+hcuEr9zInWsXqs1SeTpMd2TDF8I1i93HjNUK6N1tKp1veZEIHnWrGCnu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=K7EDIs8D; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dwp0Y0kbGz9t8q;
	Wed, 21 Jan 2026 03:23:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1768962237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGOYN9i1zWuHV83sK2qXtAETrwGCzCkpmZLOBbcMgNQ=;
	b=K7EDIs8DwVpZ9GZg7hQT4yKuGXRxpm3M+xYjzmYWX8ZnPb0GvaDG4QzwCLXVqjMpCKgN9R
	gT1URbbqXuZ85hfi88ElEf+zR3jnhJC1R6hVyAq06KOJfVtCxi18D93WldN6Zm9leFa1Vn
	a4nwH5Mw3lIHp8e8aEmb5WVCfkI6HoHfYjYQITelyY19pz5oONPuX3ERjMVtdffPAwUrZq
	Gk7LyiYFT41087XvjEYhtZBwb2nWQNs5GiAepWBI8AHfA0A0SEu1yW4YUwL73xBTs39qdP
	lM7GMQWrNl+OECQ4dgbrVQ7Frk+VBVf5KCsN3vXSAt4wmsP2ZY2SHqPv7tI3/w==
Message-ID: <f833d3b6-6a0f-4094-a3ff-7945447a4ecb@mailbox.org>
Date: Tue, 20 Jan 2026 16:55:45 +0100
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
 <6f2b7a15-5d43-4a63-b374-6a452d1ccba7@mailbox.org>
 <CAPY8ntD0Z39aC3j+mpZ-9uF3AysHFBNo4ckuexKRuuLUk+8TcA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAPY8ntD0Z39aC3j+mpZ-9uF3AysHFBNo4ckuexKRuuLUk+8TcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o57fgsckpqjgjrgbyfkdn9bzyxjpqrzq
X-MBO-RS-ID: 76d0d27a89d2d32716f
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-7979-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:mid,mailbox.org:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: EC0164FBD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 4:23 PM, Dave Stevenson wrote:

Hello Dave,

>>>>> On Thu, Jan 15, 2026 at 02:14:15PM +0100, Marek Vasut wrote:
>>>>>> On 1/15/26 11:12 AM, Uwe Kleine-König wrote:
>>>>>>> On Sun, Jan 04, 2026 at 08:41:43PM +0100, Marek Vasut wrote:
>>>>>>>> -  struct regmap *regmap = pwmchip_get_drvdata(chip);
>>>>>>>> -  unsigned int duty;
>>>>>>>> +  u8 *wfhw = _wfhw;
>>>>>>>> +
>>>>>>>> +  if (wf->duty_length_ns > wf->period_length_ns)
>>>>>>>> +          *wfhw = PWM_BL_MASK;
>>>>>>>> +  else
>>>>>>>> +          *wfhw = mul_u64_u64_div_u64(wf->duty_length_ns, PWM_BL_MASK, wf->period_length_ns);
>>>>>>>
>>>>>>> This is wrong. There was already a discussion about this in reply to v2.
>>>>>>> I'll discard this patch from my queue and continue the v2 thread.
>>>>>>
>>>>>> Instead of resuscitating the old thread, could you please tell me how to
>>>>>> make the conversion, so it won't break with existing bindings and the result
>>>>>> would work as well as the current code ?
>>>>>
>>>>> the only way you can do this correctly is to measure or research the
>>>>> actual period length of the device. As this seems hard, the function I
>>>>> suggested in v2 works for me, too.
>>>>
>>>> Sadly, that does not work on the board I use , which is the one below.
>>>>
>>>> I was also hoping that Dave might have some input on the PWM frequency
>>>> of this display.
>>>
>>> Sorry, I don't have that information, which is part of the reason why
>>> I originally wrote the driver as a backlight driver rather than PWM.
>> Is there someone you can ask by any chance? Is this hardware made by
>> waveshare ? Maybe they would know ?
> 
> It's made by a 3rd party we work with. It's not Waveshare.
> I can ask the question,

That would be nice if you could do that.

> although I don't really see the gain in having
> to insert pwm-backlight into the chain when you don't have full
> control over the PWM device.
Because we could reuse the pwm-backlight code, that's the only reason.

