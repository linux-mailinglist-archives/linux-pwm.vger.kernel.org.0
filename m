Return-Path: <linux-pwm+bounces-8275-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGylEsoluGmNZgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8275-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:46:18 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E672029CB10
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB8BC3037D78
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482843A0EB1;
	Mon, 16 Mar 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1T9Ctlz0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C31318BB8
	for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2026 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675464; cv=none; b=Os26ya4NnFai1YYnlMQTd0t70mwD2MhYJ0jblXgoPdUAXX27uApDkbgX6+2F5jXPq4d7o35sn6v2Ra4HIBeNiKEAuQ6oDzOzBs1s33Aw42WSG5SdhZJE8RmKd8oeEOjeBVBPmVzdRDyxPhCxVrA5IFCHKE0+PV1iZTwYT2b2hNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675464; c=relaxed/simple;
	bh=ZFFqpYZm8iqLOnVuOx7a8iZ1sMD3XmR5DnrngPCaH1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKwLAaBVEg8D0A6iZFoRoJR3PrDuGY0dtVAANEr54LGmBTmZeG/4+juOF6CyI1R3WM3s6/LH4JbV57wLrFiGqlPfy3v6aLxVgIQBZfva79OBeU2grBXNFZHwQVM0GZ9nHkFhclY+3BYRv/pCVqHOiUjh5AJVyHNXRn9fn09iuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1T9Ctlz0; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7422b4ff1so2036113a34.3
        for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2026 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773675461; x=1774280261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZOES8KP7138RCfnWFB8Je+zzCaH1fPa0eOTWPtFvWs=;
        b=1T9Ctlz06E11ixwHcE9deVzEf4l0tIN+z3tBT2wF95e1veWRphknJfGPS8vJ+CF80B
         13hK7UnCAVmHcAiGTvIhbq1aTwg9cl7c3zlYmmmeKSQBBAOBy0Uqj+7ELS+LyJyKnDaV
         pzX0tCl3wCbQV1l1popy6Gu74Vlp+ANxgk2h0LmAZPPffiCVmODSdTAeTwVeDotUf+ps
         n1gzuZJuTs9+YwvBS3L7GVzFEU5emSCrBHoBS+SsaWcmQFjIEP/XdQIGAfcPYWZUX8a3
         b/x9a6pa+6DDLA38jhw1R3T4sNruiey4YAetLJShO4txJeAenxhM71xGnZPwNEOvpF1P
         gDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773675461; x=1774280261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZOES8KP7138RCfnWFB8Je+zzCaH1fPa0eOTWPtFvWs=;
        b=FXgJFGpngK22+bMKHQNJm721MrHXynra/RkYWtqvgJ2Do7dS9aLf9DF48/Qk8rTX3X
         gGlANxAGr3h0wAq44KKKjonGRnFGxFA2gyt1j82XxifEffk+bUyxA6byyCURWqLzCIdl
         FMbxRW4S/PMK9wpL586iq+QymAhXfn2KNqKdhqiIZxGTuLNxgPyKKvsjTthFvmEtORj/
         7SfKxJAMbvECrBLHs+e2MskEwgv8FtyRw0Q105WyH+0A3nALLBdk54qtBvEAGQacdXql
         +TZVgZ2Vx813ARL3JYQykQaX5PeBznoMevtGkVDI/BUh9Gw4srcydE1F4Vb7TUUNsGjA
         d1Og==
X-Forwarded-Encrypted: i=1; AJvYcCV+seLLQje7wn4jwdxNuETuFTutV37qw3hZmUbLyQzWg15opqIz7m2JW0blVlgJFyD8YqPjLKeI+2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywis9OTWvRO11Ht1/pFHDqcbhf0+0GNdiG3xM0Guug7cvyD5xPy
	dtewqTXxTM5GRiDj6boHMeLtz06WnFMeMe/qAaPruJOZVjaG2LwYqmkiNLhyH/IlK5xK8X4UVWF
	cZLRf
X-Gm-Gg: ATEYQzw11Vjx5PqCAs2sK1w/V5mWBrAbGHrVcUY2rT2CJcoaeyKbaMPrdGmNNV+lxfC
	w4VjCeZjKnMQSmdkOKkMdmfVrayk2puC1RBai6Up7Uc0xE2myRFafb+N7QgFRAflGYerj/+A6bB
	gD6PD+JvkTATuJkt1sBAdonYJ6pfUy/xNaNQTOoR8EdaY5IcUW5I2BVFBHdfk4Tn+IbArQHYUDb
	mlXPqNfcPtdaBReA4VYS+76zhkBK2AzTB0XMWyOtRMR4ZRT0AsYTIodW4DzfXU5I8wjqRiZkZrC
	A61a2cFKYT82OViY6iGC6csdZsUBO0ZBxNAvR8zSQAymZdRgtc1EQpL2Bl4ksCbam+KXV+92nJp
	UjIJ+t6NumZQBrmxseRkwligqKIWEw1/bAGpqEX7okNGhQpBoxJ9QZulM7iIakIgWaaOxa/jMpU
	NoLvJrqMUhEkSArO/larsKzNl430pwNFcCa+hgKWOkRBo/5mzMqpD/JMq8oWCGlfLUTblEU1AvX
	OCzoviQ2kGP
X-Received: by 2002:a05:6830:44ac:b0:7d7:3c44:c6e with SMTP id 46e09a7af769-7d782577164mr9906238a34.32.1773675461141;
        Mon, 16 Mar 2026 08:37:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ac30bbasm12273543a34.3.2026.03.16.08.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:37:39 -0700 (PDT)
Message-ID: <7251a53a-100c-4867-ab4e-b7d2d019b26b@baylibre.com>
Date: Mon, 16 Mar 2026 10:37:37 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-3-b4d14d81a181@analog.com>
 <0bca5313-a968-48a1-9245-aeae25ab4187@baylibre.com>
 <LV9PR03MB8414E82D015E615DD64ADEFAF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB8414E82D015E615DD64ADEFAF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8275-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E672029CB10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 8:22 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, March 14, 2026 8:38 PM
> 
> ...
> 
>>> Both operating modes share a single IIO trigger and trigger handler.
>>> The handler builds a complete scan — one u32 slot per channel at its
>>> scan_index position, followed by a timestamp — and pushes it to the
>>> IIO buffer in a single iio_push_to_buffers_with_ts() call.
>>
>> It would really help here to see some timing diagrams to know if we
>> are implementing this right.
>>
>> For example, it isn't clear that in clocked mode if CNV triggers a
>> single conversion in the sequencer (i.e. IIO_SAMP_FREQ should be
>> info_mask_separate) or if it triggers the sequence (i.e. IIO_SAMP_FREQ
>> should be info_mask_shared_by_all).
>>
> 
> The CNV triggers the sequence and IIO_SAMP_FREQ is info_mask_shared_by_all.
> 
> As per datasheet page 31 (Accumulator Section), when each accumulator
> receives a sample, the ACC_COUNT is increased. In clocked mode we
> are setting the ACC_COUNT limit to 1, therefore having one sample per
> channel (no oversampling as discussed in previous versions). So each
> period of the CNV PWM is respective to one sample of a channel.

Assuming that "a" channel means "one" channel...

In this case then sampling_frequency should be per channel (separate).

A sampling_frequency that is shared_by_all means that each period of
CNV should trigger one sample each for _all_ channels. In other words,
the sampling frequency gives one complete set of samples for all enabled
channels pushed to the buffer.

> 
>>>
>>> For CNV Clock Mode the GP0 pin is configured as DATA_READY output. The
>>> IRQ handler stops conversions and fires the IIO trigger; the trigger
>>> handler reads accumulated results from the AVG_IN registers via regmap
>>> and restarts conversions for the next cycle.
>>
>> This seems OK, but I would kind of would expect that PWM as CNV to
>> only be used for SPI offloading and not without SPI offloading.
>>
>> The ADC also has an internal oscillator, so it seems like it would
>> be more useful to use that as a conversion trigger rather than
>> requiring external hardware.
>>
> 
> This CNV is used in triggered buffer mode as well, not only in offload.
> In this mode, CNV replaces the internal oscillator so CNV is the
> conversion trigger (offload or not), which also introduces the advantage
> of having a more flexible sampling rate.

Yes, I understand that. We just never did that for any other chip yet.
Usually, we would just use the internal oscillator on the chip instead
for this sort of thing. But if you have applications engineers telling
you that this is a setup they want to support, then we can do it.

>>>
>>> Manual mode channels use storagebits=32 (shift=8, realbits=16) so all
>>> channel slots in the scan buffer are uniformly sized regardless of the
>>> SPI wire format (24-bit transfer, 16-bit ADC data in bits[23:8]).
>>
>> I also don't understand why we are including the status bits in manual
>> mode but not in CNV clock mode.
>>
> 
> In Manual Mode, status bits are received through SPI, because that's how
> the hardware works. However, they are masked by the driver and thus not used.

Usually there are registers to turn status on and off independently. If
there isn't it could be helpful to add some comments in the code to
remind us.


