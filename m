Return-Path: <linux-pwm+bounces-8597-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFKSLbKd4GlKkQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8597-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 10:28:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB4340B894
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 10:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E72319FEBC
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 08:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65951391513;
	Thu, 16 Apr 2026 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IQOoASDj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327938837B
	for <linux-pwm@vger.kernel.org>; Thu, 16 Apr 2026 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327781; cv=none; b=JUL+4wDvxmSHwrYqjc2nMpEBcYjw8OBSzHSqaXCSQSWMlLPPO63/enxDQ+tZqeGOHsu+9AaAt3kDXpO+cHMkzumXmgXP7gMRe3eGEgLW8g3bG6OrJmxu2P20HcKH9/RLUedJ7YEr51kWnqBEPqctdO7h6G+QpPFGK0lhR1Lrb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327781; c=relaxed/simple;
	bh=I4Pcx3qfaVoC2hcfxf/U4ng8T/3Ds1K0AUyybcgED0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcKIrIJVfyb6Y9GTJEdKC+Rke+pl8OYQYF9NgUsRvjChGG8Omi2SaryoXKTB13JJamJVS7Hv/wPyM8vFN8rXA9SC1dWhFWgi9zU3wtGfT7iLF4I8TnS89vsEt0uo06PGICT23e4F8hVmzuai73rIxB7DNyuXqet+1qMtHvX9coM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IQOoASDj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DC6284E42A15;
	Thu, 16 Apr 2026 08:22:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9605B5FDEB;
	Thu, 16 Apr 2026 08:22:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB1FD10459ECE;
	Thu, 16 Apr 2026 10:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776327775; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=vf1NAEo8S9OwitHAGAehGzHb+5Xj0NkwKk+qLaje2K4=;
	b=IQOoASDjygSK/g57J/TKAASub60SdimIF6ESLFnep0UEYz75Noo9cFiE+IeunJPxCsUH6W
	PVLAv7DRh04P+0Pli7o7n/QeXE7ojTi2BVzWzgehw2bGWPal4dqx7oekXOgHs4ldQ4Rn8E
	l3jBqsY34iqG1U2AlGSipzQ945alsXEJmLzJaHOEo9c7FieaLiPSMH3mv9QBb/W72DnLUg
	1B9bSOWckxHBmYXvyDKkNxvy66UYIicEXq8TUOPIE4dAZu8oPzbId01oQ7F71Itq6b6zan
	Ju5h9IKbufhA05Jk3mCng0d4mUulXbzE4QxLKTjEx5hrnRjA4H3F3FVmvjeZCg==
Message-ID: <068e2f41-33fd-4627-826f-83eb0770cc3c@bootlin.com>
Date: Thu, 16 Apr 2026 10:22:42 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Introduce Allwinner H616 PWM controller
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260305091959.2530374-1-richard.genoud@bootlin.com>
 <adfe2z2YeBxm_6oR@shepard>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <adfe2z2YeBxm_6oR@shepard>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8597-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,csie.org,gmail.com,sholland.org,pengutronix.de,bootlin.com,google.com,schimsalabim.eu,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DB4340B894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 09/04/2026 à 19:16, Paul Kocialkowski a écrit :
> Hi Richard,
> 
> On Thu 05 Mar 26, 10:19, Richard Genoud wrote:
>> Allwinner H616 PWM controller is quite different from the A10 one.
> 
> As I've mentionned before, this PWM controller is not specific to the H616
> but also appears in other chips, so the name of the driver and registers
> should not mention H616.
> 
> After further investigation, I can see multiple versions of this new PWM IP
> being used in different chips, starting with the R40/V40 (sun8iw11) in 2016.
> 
> The latest downstream BSP driver has a list of the different generations:
> https://github.com/radxa/allwinner-bsp/blob/cubie-aiot-v1.4.6/drivers/pwm/pwm-sunxi.c#L1901
> 
> We have a first generation called v100/v101 for the following chips:
> H616, R328 and R40. A second generation is called v200 and brings slight
> register layout differences for A133, D1/T113-S3 and V851. Subsequent
> iterations (v201-5) are used in more recent chips like A527 and A733 and
> seem register-compatible with v200 (from a quick look).
> 
> So what I suggest here is to rename the driver "sun8i-pwm" and eventually add
> a list of generations to the driver and different registers when needed, with
> an appropriate suffix in their name.
> 
> But since you're currently only dealing with H616, this work can be done later
> when introducing support for more chips.
ok, I'm fine with that :)

> 
>> It can drive 6 PWM channels, and like for the A10, each channel has a
>> bypass that permits to output a clock, bypassing the PWM logic, when
>> enabled.
>>
>> But, the channels are paired 2 by 2, sharing a first set of
>> MUX/prescaler/gate.
>> Then, for each channel, there's another prescaler (that will be bypassed
>> if the bypass is enabled for this channel).
>>
>> It looks like that:
>>              _____      ______      ________
>> OSC24M --->|     |    |      |    |        |
>> APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
>>             |_____|    |______|    |________|
>>                            ________
>>                           |        |
>>                        +->| /div_k |---> PWM_clock_x
>>                        |  |________|
>>                        |    ______
>>                        |   |      |
>>                        +-->| Gate |----> PWM_bypass_clock_x
>>                        |   |______|
>> PWM_clock_src_xy -----+   ________
>>                        |  |        |
>>                        +->| /div_k |---> PWM_clock_y
>>                        |  |________|
>>                        |    ______
>>                        |   |      |
>>                        +-->| Gate |----> PWM_bypass_clock_y
>>                            |______|
>>
>> Where xy can be 0/1, 2/3, 4/5
>>
>> PWM_clock_x/y serve for the PWM purpose.
>> PWM_bypass_clock_x/y serve for the clock-provider purpose.
>> The common clock framework has been used to manage those clocks.
>>
>> This PWM driver serves as a clock-provider for PWM_bypass_clocks.
>> This is needed for example by the embedded AC300 PHY which clock comes
>> from PMW5 pin (PB12).
>>
>> Usually, to get a clock from a PWM driver, we use the pwm-clock driver
>> so that the PWM driver doesn't need to be a clk-provider itself.
>> While this works in most cases, here it just doesn't.
>> That's because the pwm-clock request a period from the PWM driver,
>> without any clue that it actually wants a clock at a specific frequency,
>> and not a PWM signal with duty cycle capability.
> 
>  From what I understand the pwm-clock driver will either assume a fixed rate
> set in device-tree or deduce the rate from the pwm period. In any case it will
> check that the pwm period (which it cannot change) is the same as the requested
> clock period.
> 
> So I agree that pwm-clock is unable to change the clock rate at runtime and will
> just use whatever frequency the pwm is running at (which is typically set
> in the device-tree consumer property).
> 
>> So, the PWM driver doesn't know if it can use the bypass or not, it
>> doesn't even have the real accurate frequency information (23809524 Hz
>> instead of 24MHz) because PWM drivers only deal with periods.
> 
> I agree that the driver needs to register as a proper clock provider in
> addition to pwm. But what happens if the same PWM clock is requested both from
> the clk side and the pwm side?

The first to request it is the winner :)
The other ones will receive a -EBUSY
In h616_pwm_request() and h616_pwm_of_clk_get(), the channel mode is 
checked, and if it's free to use, it's set as either PWM or CLK mode so 
that it can't be requested a second time.

> 
>> With pwm-clock, we loose a precious information along the way (that we
>> actually want a clock and not a PWM signal).
>> That's ok with simple PWM drivers that don't have multiple input clocks,
>> but in this case, without this information, we can't know for sure which
>> clock to use.
>> And here, for instance, if we ask for a 24MHz clock, pwm-clock will
>> requests 42ns (assigned-clocks doesn't help for that matter). The logic
>> is to select the highest clock (100MHz) with no prescaler and a duty
>> cycle value of 2/4 => we have 25MHz instead of 24MHz.
>> And that's a perfectly fine choice for a PMW, because we still can
>> change the duty cycle in the range [0-4]/4.
>> But obviously for a clock, we don't care about the duty cycle, but more
>> about the clock accuracy.
>>
>> And actually, this PWM is really a PWM AND a real clock when the bypass
>> is set.
> 
> Make sense to me.
> 
>> This series is based onto v6.19-rc4
>>
>> NB: checkpatch is not happy with patch 2, but it's a false positive.
>> It doesn't detect that PWM_XY_SRC_MUX/GATE/DIV are structures, but as
>> it's more readable like that, I prefer keeping it that way.
>>
>> NB2: for geopolitical reasons, I didn't re-use the old series that Paul
>> was referring to.
>>
>> Changes since v3:
>> - gather Acked-by/Tested-by
>> - fix cast from pointer to integer of different size (kernel test robot
>>    with arc platform)
>> - add devm_action for clk_hw_unregister_composite as suggested by Philipp
>> - remove now unused pwm_remove as suggested by Philipp
>>
>> Changes since v2:
>> - use U32_MAX instead of defining UINT32_MAX
>> - add a comment on U32_MAX usage in clk_round_rate()
>> - change clk_table_div_m (use macros)
>> - fix formatting (double space, superfluous comma, extra line feed)
>> - fix the parent clock order
>> - simplify code by using scoped_guard()
>> - add missing const in to_h616_pwm_chip() and rename to
>> h616_pwm_from_chip()
>> - add/remove missing/superflous error messages
>> - rename cnt->period_ticks, duty_cnt->duty_ticks
>> - fix PWM_PERIOD_MAX
>> - add .remove() callback
>> - fix DIV_ROUND_CLOSEST_ULL->DIV_ROUND_UP_ULL
>> - add H616_ prefix
>> - protect _reg in macros
>> - switch to waveforms instead of apply/get_state
>> - shrink struct h616_pwm_channel
>> - rebase on v6.19-rc4
>>
>> Changes since v1:
>> - rebase onto v6.19-rc1
>> - add missing headers
>> - remove MODULE_ALIAS (suggested by Krzysztof)
>> - use sun4i-pwm binding instead of creating a new one (suggested by Krzysztof)
>> - retrieve the parent clocks from the devicetree
>> - switch num_parents to unsigned int
>>
>> Richard Genoud (4):
>>    dt-bindings: pwm: allwinner: add h616 pwm compatible
>>    pwm: sun50i: Add H616 PWM support
>>    arm64: dts: allwinner: h616: add PWM controller
>>    MAINTAINERS: Add entry on Allwinner H616 PWM driver
>>
>>   .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml |  19 +-
>>   MAINTAINERS                                   |   5 +
>>   .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  47 +
>>   drivers/pwm/Kconfig                           |  12 +
>>   drivers/pwm/Makefile                          |   1 +
>>   drivers/pwm/pwm-sun50i-h616.c                 | 936 ++++++++++++++++++
>>   6 files changed, 1019 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/pwm/pwm-sun50i-h616.c
>>
>>
>> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> 

Regards,
Richard

