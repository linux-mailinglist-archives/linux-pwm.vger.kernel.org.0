Return-Path: <linux-pwm+bounces-8490-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP71I/G602m5lAcAu9opvQ
	(envelope-from <linux-pwm+bounces-8490-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 15:53:53 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69EC3A3B71
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 15:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63319300B44F
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFFD2C17B3;
	Mon,  6 Apr 2026 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="TKygYbmD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F53D2BD00C
	for <linux-pwm@vger.kernel.org>; Mon,  6 Apr 2026 13:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483629; cv=none; b=gcZGmMn6BbBdg6kDiXeEsgUM6SxaM/ZMGcq11Eg77CYSh58ds35hywrZ/eRSTLOKpNPPuOF7DxK/IN0GQ0JMb1OA+jaqEcMoh/Z96CAU230Kk5HRJR5RAXiBK3PBGPMH+nEMUSSroGXlKeTo0vtPpUGwKBlv/KC2Pg0k63TyBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483629; c=relaxed/simple;
	bh=8E0gZkdG4c0YopafJxSjMTrvidvcWXJRzc/8t96tM+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFUcCKlskmaX6tLLQmAzInRf94muIWYJ0voQMaklipOR99l+H7MGkAqpYejuZsDws9WovYLGHOCXB7GxYlYLaq5NtVLYkAXUgKiTn7LyaPiLq14wRHcGAMlMhhnbjW2rbZzgwBtRUBQbAoPnTsVScvGgTGoHg630TR2pFxjkUxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=TKygYbmD; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-47018d34159so1600546b6e.2
        for <linux-pwm@vger.kernel.org>; Mon, 06 Apr 2026 06:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775483625; x=1776088425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qZkHoAKs9K95rEZ/p1pw2V52NRGwXxeKKingUw5vg0=;
        b=TKygYbmDhM383eYJXPTgV0ZE4tTdYBJSljN4cAyFip9GETCkk/f53wTR9860F5AnlZ
         NMSBfbwEdUd0gkz/hqhrszoxYrDiQDGR8CqwqoYr1vh/YYVDiM1wTgHoF8cr8aYS93mE
         ogvm5F2lQKovoY4wzPhnaQj5x9uuxKkwbs+3W78BFSI5nuxCMdHyMtzuKUv8p3ncAcaW
         7L9H28bdjP2G/dVon7Z2pI8af3DHhlHajfrueGib/s7+0youSo1K1oZ/sXT7/sKDJy8s
         K49iACHfvTvcnkZ2pxxTZol0w/tA4bmUP+r7J9vZOTRjr+byDl+YAtCMZS4pPqoltxnI
         jmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775483625; x=1776088425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qZkHoAKs9K95rEZ/p1pw2V52NRGwXxeKKingUw5vg0=;
        b=l5hBgSM60i3VKcYfF8Y9QOHevzdTMLXmERyONhR8l342Okg1so/DLWAGIO+AhvFHmC
         Su+srHP/5/5xnNdu/heI5qsa+ZCBpgV4OFm07KsVxBoeOwNsWUYpjrAjSMdrun29KkjQ
         34zPJJTHnA5mdIRC4JI8Oiw3HX4Nq3CfPrvomDxSqI0GkhGxxYojCy0Eu1Mw5sveee6x
         /SPcy5skopzxIkAz+FlXSZdN19G4ZRJx+P/tYBQMtsYSUAiLprziZU5nQcGhCQZlzIHU
         142THG9/+s9fY0A3LGW2dGlhE6yXmXEyh12Mxyt9YZI8huXvsHSQYQDWnadtVUUQXBd6
         Ta/g==
X-Forwarded-Encrypted: i=1; AJvYcCUc2L2YwMcluPnh8CUAFWrTL11U5aTDYMMTTsDY0tjEJiT04KEGxmSHi+vXaY+7ZAgyVQexjEgMQqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+eLyPXrFV93sIJ/Ba8y0ktDSBtDGqxpi3vC2etKC+ohx9GvR2
	HB67XS8EBun9DeZ+PxQoMbMBFe4p6LClQTatQSPe5j/amO3cM80PgLkAY9X5g9GanZA=
X-Gm-Gg: AeBDieuOK7YIzdWz5oIdG1gHXzG+au5djU59NZmC81/wemnTtqPOQGpXyoUGO6wqT2z
	o8ul+1x7doaNK6wKB8TZnMA8aZCWZOKVtOUuukA8mr3It37O7h/31wDCFj8s56wPxmPCAcakmZJ
	wLGvoJ/Diyxz/vyW98Be1yKYh4hQSvlccRTnZZQuynG4V6oiukNpTFBIGyiSa7QsG7cVyrKEwUF
	mPbElZtRsUyBl7urc7WCjHwgcWKVwdxkPsZ89H9kY1R9CGJC2DPAJnfzmqubZiHqLodT7mzZ9oE
	KhmASxz0iPqERSURTPjGWd5TeYA3XW9XI6AWClsoOmVBDg0jmbEP8jaH1z+hH80o0CNhcjS36Nf
	1zRdMftSLGorN+KYwdBRBe3zEV0vOX/GCC+YD1WaBW110XlF26npPs4vHmGogL20CM+GwnvgiXe
	FbGOhraFzYLbZ55pK0kNgtOYenRki+v4hP9hqWCoUG0tQ+K/fI+/x/49yIEeBhnp3IlR2g8R0=
X-Received: by 2002:a05:6808:5386:b0:46e:c1cd:98bf with SMTP id 5614622812f47-46ef790f056mr6336170b6e.25.1775483625412;
        Mon, 06 Apr 2026 06:53:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46ef5bfe815sm6313412b6e.6.2026.04.06.06.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 06:53:43 -0700 (PDT)
Message-ID: <0192c4d2-5adf-434e-9b58-4843f5ffa68a@baylibre.com>
Date: Mon, 6 Apr 2026 08:53:42 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <22b44acb-bfb5-4b97-8fa2-aeb4aec704c2@baylibre.com>
 <LV9PR03MB8414CB6B07EA81FB5A42436AF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB8414CB6B07EA81FB5A42436AF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8490-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,baylibre.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: E69EC3A3B71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 5:39 AM, Sabau, Radu bogdan wrote:
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, April 4, 2026 6:57 PM
> 
> ...
> 
>>> +
>>>  #define AD4691_CHANNEL(ch)
>> 	\
>>>  	{								\
>>>  		.type = IIO_VOLTAGE,					\
>>> @@ -122,11 +155,9 @@ struct ad4691_chip_info {
>>>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),
>> 	\
>>>  		.channel = ch,						\
>>>  		.scan_index = ch,					\
>>> -		.scan_type = {						\
>>> -			.sign = 'u',					\
>>> -			.realbits = 16,					\
>>> -			.storagebits = 16,				\
>>> -		},							\
>>> +		.has_ext_scan_type = 1,
>> 	\
>>> +		.ext_scan_type = ad4691_scan_types,			\
>>> +		.num_ext_scan_type = ARRAY_SIZE(ad4691_scan_types),
>> 	\
>>
>> Usually, we just make two separte ad4691_chip_info structs for offload
>> vs. not offload.
>>
>> ext_scan_type is generally only used when the scan type can change
>> dynamically after probe.
>>
> 
> So, just to be clear, you are saying I should have different chip_info structs
> and change the triggered-buffer for offload ones if offload is present?
> I am asking since offload has different scan types as well, and this would
> mean 3 different chip_info structs for each chip -> total of 12 chip_info structs,
> each with a different channel array, or perhaps there is a more compact way
> to have this implemented.
> I could make the channel arrays use the same macro and have the scan_type
> reversed to storage and shift done as parameters.
> 
> Please let me know your thoughts on this.

If it gets too complex, we can dynamically create the chip info
struct during probe. But in general we prefer to statically define
them even if it gets a little verbose. Macros usually help here.


>>>  }
>>>
>>> @@ -883,6 +1184,20 @@ static ssize_t sampling_frequency_store(struct
>> device *dev,
>>>  	if (iio_buffer_enabled(indio_dev))
>>>  		return -EBUSY;
>>>
>>> +	if (st->manual_mode && st->offload) {
>>> +		struct spi_offload_trigger_config config = {
>>> +			.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
>>> +			.periodic = { .frequency_hz = freq },
>>> +		};
>>
>> Same comment as other patches. This needs to account for oversampling
>> ratio.
>>
> 
> I am thinking that since we would have different chip_info structs, manual
> mode channels could omit the oversampling attribute, since it is not supported
> by the chip on this mode.

Yes, this would be ideal.


>> SPI_OFFLOAD_TRIGGER_PERIODIC);
>>> +		if (IS_ERR(offload->trigger))
>>> +			return dev_err_probe(dev, PTR_ERR(offload->trigger),
>>> +					     "Failed to get periodic offload
>> trigger\n");
>>> +
>>> +		offload->trigger_hz = st->info->max_rate;
>>
>> I think I mentioned this elsewhere, but can we really get max_rate in manual
>> mode
>> due to the extra SPI overhead? Probably safer to start with a lower rate.
> 
> You are right a slower rate would be nicer, from my tests 311kHz worked perfect
> with a 10MHz SPI frequency, but perhaps these numbers are a bit "odd".
> 
> How do you feel about 100kHz for a starting sample rate?

Sounds reasonable.


>> IIO_BUFFER_DIRECTION_IN);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	indio_dev->buffer->attrs = ad4691_buffer_attrs;
>>
>> Should including ad4691_buffer_attrs depend on st->manual_mode?
>>
>> I thought it was only used when PWM is connected to CNV.
>>
> 
> For offload manual mode, I thought buffer sampling frequency should also be available,
> since the offload trigger's frequency is accessible.

Ah right. Not sure what I was thinking when I wrote that.

> 
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static int ad4691_probe(struct spi_device *spi)
>>>  {
>>>  	struct device *dev = &spi->dev;
>>> +	struct spi_offload *spi_offload;
>>>  	struct iio_dev *indio_dev;
>>>  	struct ad4691_state *st;
>>>  	int ret;
>>> @@ -1232,6 +1626,13 @@ static int ad4691_probe(struct spi_device *spi)
>>>  	if (ret)
>>>  		return ret;
>>>
>>> +	spi_offload = devm_spi_offload_get(dev, spi,
>> &ad4691_offload_config);
>>> +	ret = PTR_ERR_OR_ZERO(spi_offload);
>>> +	if (ret == -ENODEV)
>>> +		spi_offload = NULL;
>>> +	else if (ret)
>>> +		return dev_err_probe(dev, ret, "Failed to get SPI offload\n");
>>> +
>>>  	indio_dev->name = st->info->name;
>>>  	indio_dev->info = &ad4691_info;
>>>  	indio_dev->modes = INDIO_DIRECT_MODE;
>>> @@ -1239,7 +1640,10 @@ static int ad4691_probe(struct spi_device *spi)
>>>  	indio_dev->channels = st->info->channels;
>>>  	indio_dev->num_channels = st->info->num_channels;
>>
>> As mentioned earlier, we generally want separate channel structs
>> for SPI offload. These will also have different num_channels because
>> there is no timestamp channel in SPI offload.
> 
> If different chip_info structs will be used, wouldn't they already have specific
> channels attached to them?
> 

Yes.

