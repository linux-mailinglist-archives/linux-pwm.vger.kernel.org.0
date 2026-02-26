Return-Path: <linux-pwm+bounces-8161-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAw2LvILoGnbfQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8161-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 10:01:38 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C61A30E7
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 10:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 131223019E02
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D9A396B8E;
	Thu, 26 Feb 2026 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ceyG5wRz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A0396B67;
	Thu, 26 Feb 2026 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095976; cv=none; b=QvcsuvTQKNTiuwD7jWvEXYnYEEtsVihbbwetrXhS0aPVmnUOstSIboTKUPgBxx/dNG6/721DkaumVKlYilLOKrpCMgKDFQzgOe7gcgWdiSA0qCN1Mhu3W1wQ1/U4+kDfIUVT3mVhYGJjRfYz1OS5eCPrZ1NW6JCVosMF5pC6xQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095976; c=relaxed/simple;
	bh=6LepYetcEvvYeNsMc1g2YwHGOaL/4U001M8haNVtWRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kcv9CfHZ5+kSgXnvqGy/+Q5n28EG9Qm/+sZixlBeNRI/1A0r1TcxH76QAXuMymL0J/jxTvgM0U0iaeodQtpSPC1hxq08m5YVnU2aML4k9gajCzDLmt77yHwT1L9wMepOfLgErnZDRIWolIGa9dTvs0D//RjYjb8yRgLpZOmfaHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ceyG5wRz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E4EDD1A13A9;
	Thu, 26 Feb 2026 08:52:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0D955FDEB;
	Thu, 26 Feb 2026 08:52:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D60A9103686A8;
	Thu, 26 Feb 2026 09:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772095969; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cqoaeSOvXhitA2HXEQSMccZTdcMAnAelkKxEfxzuAyU=;
	b=ceyG5wRzBUSZDZJd8vq7QFyD7UyDmJWfbAJfQwYXtJD5prIhqEEhLjgfJAd91y1drMc6ok
	5joGS6f7f7IZw+nshB+ezUhebo+tXOx9SWIMOZzgHJy4iT0fgqjqq6xW9JcuWTQ0m//H+S
	rs0bxqV8/j1NBG7vicb5BdxG7z3LOTnrhB4jL1kVWwXm0xbaoRkMoCY7S8X+CwWL08o9Im
	IIho6/U9V1KZ1GhuS8YjOT2lPxuIVXxfTseoQMd+fODg52SyC+8/MgPXm8w+7xWcA8e2pA
	7oVSpwrAYVkmsDZgVFn/tlXtI71scFC9fhjX6bEwIDlFn/fBzfXZtgFhNGXkog==
Message-ID: <11efec54-6d13-4ca1-a11b-f91da9e1306b@bootlin.com>
Date: Thu, 26 Feb 2026 09:52:43 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Introduce Allwinner H616 PWM controller
To: John Stultz <jstultz@google.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Paul Kocialkowski <paulk@sys-base.io>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260123093322.1327389-1-richard.genoud@bootlin.com>
 <CANDhNCrSjp1F0PifJXmxrAbRiTC=d_ZXeiiT5kGuM=gNke7ebA@mail.gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <CANDhNCrSjp1F0PifJXmxrAbRiTC=d_ZXeiiT5kGuM=gNke7ebA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,csie.org,gmail.com,sholland.org,pengutronix.de,sys-base.io,bootlin.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-8161-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[bootlin.com:query timed out];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[richard.genoud.bootlin.com:query timed out,jstultz.google.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:url,bootlin.com:email]
X-Rspamd-Queue-Id: 919C61A30E7
X-Rspamd-Action: no action

Le 23/02/2026 à 21:14, John Stultz a écrit :
> On Fri, Jan 23, 2026 at 1:33 AM Richard Genoud
> <richard.genoud@bootlin.com> wrote:
>>
>> Allwinner H616 PWM controller is quite different from the A10 one.
>>
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
>> So, the PWM driver doesn't know if it can use the bypass or not, it
>> doesn't even have the real accurate frequency information (23809524 Hz
>> instead of 24MHz) because PWM drivers only deal with periods.
>>
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
> During my free/personal time this weekend I was tinkering with Orange
> Pi Zero 2w and was able to use this patch series (along with an
> hdmi-phy patch and some dts changes) to get HDMI working on the
> device.
> I'm eager to see these land!
> 
> Tested-by: John Stultz <jstultz@google.com>

That's great, thanks for testing!

> 
> thanks
> -john
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

