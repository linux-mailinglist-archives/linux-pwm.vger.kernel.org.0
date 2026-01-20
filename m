Return-Path: <linux-pwm+bounces-7964-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LWuCuaqb2lmEwAAu9opvQ
	(envelope-from <linux-pwm+bounces-7964-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 17:18:46 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 983214749C
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 17:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EA2986AB95
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF3342EECD;
	Tue, 20 Jan 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fS7jlfXh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855F63D2FF5;
	Tue, 20 Jan 2026 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917022; cv=none; b=er78fxY5mnEzbJZwB84U0avuXPAUg+N7NPb5U7Yxx3Yk+0FVGmYdeH/mM2AYufuy31ILGwAPaBLfQVvTyn8Cx7BzaJk/Si5yzEd5QbrtD9OcTgCFMAGoFcsRTQWfDh4YxTFvLf8mA8W+NyrleQcZm0L3OlhyJ2ezJ/9OdykanFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917022; c=relaxed/simple;
	bh=tb/mZBgWelT7j440LDyIqgNZGwJvvBU1c5q/Dag7OWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsB8n+iVzFSFUsQY256D1G6OAAvqqfb6Kvy/6vlYiyY127wS9RTqULDfpj15rxMbsZ+DXudk/KcORcO6p9UAZCslVURO7IsbQbx9ldYq2qxCn+o1k6rxSjtek3iydCWxhDJR18Yvyepx6KspNg2hpq899tKi+/2zWqXk0ZV9i2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fS7jlfXh; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dwTGw4kmLz9v0r;
	Tue, 20 Jan 2026 14:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1768917016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LjI1ZwWChctZwvG2XgbtTRcxw9ddO25I8Lmr6l/5/e8=;
	b=fS7jlfXhs6Z2n/X93O/cUS4hJgRz37us6HWwX/GdCLSRxIT8/nYKhwDu1i/3VR7wNoJ77L
	mwNmvcLnF0E6DQNM/WaUDXv802TXuaqswWxgvINiAsrQQP2U40f0me0d2GCvvYV50yuA3A
	sfIXfBUY1979EdvffPTs0Az+B2eLjMmc0l1Pg9IV/LadouH1iffJNgoM+l0nMO5pRWxuYC
	CprKCgR/7jE8R3OT2zKpnoQmliHxDve2PQ5rYTtlqmUB0xguRbwJJAhmAaent25n6nhGzO
	RwYSY2pbd9wPE1p5oIeiL2XPZxLVyaDGQnYDgbOJ+MHO73tB3z/7yiWWuffc8Q==
Message-ID: <855e5015-98c8-48f6-9320-ca8163591940@mailbox.org>
Date: Tue, 20 Jan 2026 14:50:03 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
References: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
 <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
 <797047eb-e422-4a8b-80eb-ab130066c1d7@mailbox.org>
 <xsjwvmlqclctnf6dgwyuoi7zits27is2s7r7taprb2w2lhsf7i@uiljd7o3ivbk>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <xsjwvmlqclctnf6dgwyuoi7zits27is2s7r7taprb2w2lhsf7i@uiljd7o3ivbk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rrce844ya4hmwrc668xzwr3cn8aiwzjh
X-MBO-RS-ID: c9cf938311497a81b56
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-7964-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[mailbox.org,reject];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[mailbox.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.45:email];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: 983214749C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/15/26 5:37 PM, Uwe Kleine-König wrote:

Hello Uwe,

> On Thu, Jan 15, 2026 at 02:14:15PM +0100, Marek Vasut wrote:
>> On 1/15/26 11:12 AM, Uwe Kleine-König wrote:
>>> On Sun, Jan 04, 2026 at 08:41:43PM +0100, Marek Vasut wrote:
>>>> -	struct regmap *regmap = pwmchip_get_drvdata(chip);
>>>> -	unsigned int duty;
>>>> +	u8 *wfhw = _wfhw;
>>>> +
>>>> +	if (wf->duty_length_ns > wf->period_length_ns)
>>>> +		*wfhw = PWM_BL_MASK;
>>>> +	else
>>>> +		*wfhw = mul_u64_u64_div_u64(wf->duty_length_ns, PWM_BL_MASK, wf->period_length_ns);
>>>
>>> This is wrong. There was already a discussion about this in reply to v2.
>>> I'll discard this patch from my queue and continue the v2 thread.
>>
>> Instead of resuscitating the old thread, could you please tell me how to
>> make the conversion, so it won't break with existing bindings and the result
>> would work as well as the current code ?
> 
> the only way you can do this correctly is to measure or research the
> actual period length of the device. As this seems hard, the function I
> suggested in v2 works for me, too.

Sadly, that does not work on the board I use , which is the one below.

I was also hoping that Dave might have some input on the PWM frequency 
of this display.

> The specified binding is unaffected by that. The only dts I found using
> this device
> (arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk-rpi-display-2.dtsi)
> has
> 
> 	backlight {
> 		compatible = "pwm-backlight";
> 		pwms = <&mcu 0 255 0>;
> 	};
> 
> 	mcu: gpio@45 {
>                  compatible = "raspberrypi,touchscreen-panel-regulator-v2";
> 		...
> 	};
> 
> . Given that the dt specifies something made up and the driver was
> written in a way that is wrong but does the right thing in combination
> with the made up .dts, you cannot fix the driver to be a correct PWM
> driver without having to adapt the invented values in the .dts, too.

I think this is what this V3 does. Would that be an option here ?

> (An option would be to adapt the pwm-backlight driver to ignore the
> provided period, but I think that isn't sensible and badly affects many
> other machines that have a working PWM driver. Or assume the PWM's
> period is 255 ns which is probably wrong, but so is 100 ms (the latter
> probably to a lesser extend).)
> 
> Maybe the lesson to take away here is: if a driver implements a PWM, Cc:
> the linux-pwm list and the pwm maintainer on the submission. And let me
> point out that even get-maintainers.pl knows about that:
> 
> 	$ git format-patch -1 --stdout d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4 | scripts/get_maintainer.pl
> 	...
> 	"Uwe Kleine-König" <ukleinek@kernel.org> (maintainer:PWM SUBSYSTEM:Keyword:pwm_(config|apply_might_sleep|apply_atomic|ops))
> 	...
> 	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM:Keyword:pwm_(config|apply_might_sleep|apply_atomic|ops))
> 	...
I do use get_maintainer to CC people when sending patches, hmmmm.

