Return-Path: <linux-pwm+bounces-8491-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDYFGaC702mslAcAu9opvQ
	(envelope-from <linux-pwm+bounces-8491-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 15:56:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 076753A3BCE
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74ACD3012C62
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC1352C5B;
	Mon,  6 Apr 2026 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ZkaJuZ4D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297133DEF2
	for <linux-pwm@vger.kernel.org>; Mon,  6 Apr 2026 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483801; cv=none; b=l/s+bOugxdvSxhvblsgLLozkKlchwX5idfUxYRbABua2Vs8FGsiNFoJXMmkBqioB17drcCSpfhTB/pOGxpaxcfvY/+NFO5AI1La6GlwSfZf7z3c1QygdpzoNlpEK0LO0V2nt6Zd6lUVI8TaNFbkk5LbZlLUfFJ39iWCzXT/wLPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483801; c=relaxed/simple;
	bh=iUYTDGXX+u/L0D05BTNCXJnDEK3/glBj6u+Ml4h4iKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUBYsqwj3PzktmKWWe49IRD8LSm0IqRV4Bc+PyjGz0tRvHavSsPLjxX59rl8zM8xb29d9EE6n9n9ORe7xEbrcEM3ZVs/ttstl/FqbXQ6xcgDQIHWuY6fAdQG8nKh7MsUdbdJyDnzsCWMdKjnF/OoRBZzLDOVhAWQ9mq04hUtL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ZkaJuZ4D; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d1872504cbso3779474a34.0
        for <linux-pwm@vger.kernel.org>; Mon, 06 Apr 2026 06:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775483799; x=1776088599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQ3ilv+aCLOmjvw6MQwMUmcVMMKuTIze7YROtn+rRBs=;
        b=ZkaJuZ4DZz0oS2KHBWRIg4QwgyVwhin5y5BSvfC/ynaw7clVCFMCJg8Nk5Jabtpy3n
         sojHMMgygq0yiwGhIEXr30wslfRcABxxPhX5wcCeqn7e/uaX+a6h+rsfBq7HbvZ2IOq1
         JE6wulqsFMQ10LD58ZcUiQ5QEjz1xTGtJvRKJyU9QYThjAKCv5OLAVKASOfMJMy5n9uf
         akQwkisVKGKu0jYYfYJPlocXJShI1+yz71XxJ97unITHXJdQCw8pxoWc34qwUpkZ0k+Q
         iAROll89eA8vYAon66Mlj08tG1xB9gGbcOWOY848FHXxQREnyjaw87dd4zf7KEsvFWpo
         CdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775483799; x=1776088599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nQ3ilv+aCLOmjvw6MQwMUmcVMMKuTIze7YROtn+rRBs=;
        b=i5tkn4XscAi6/650uO8l75ZSnM6J26dUTny/Ssl5kI1//yKmBqbRnfECWNMQTKnHHk
         8gaILoX9os8cieYT9+st58E1llFewucPTCq5rFP6jZLtW7RzphKUpMIW0voocmide4LY
         Mo9YXWfz9vVD4XdJOIrldKmKqQDQVQeVys0VfrYi6UWZxUCZbD6WK16hxgZRAfQ4nD+x
         yeMH2zO5zu+zjN8Iy2Xjw+UTRc8yRRQIT6B1bgXVIYya0b/utM/aY9aTSZ00aAo8Wzmq
         5Svy6Sxmqf1bP75l7etOC+t9hcCO8ZarPr2GxOH3nqud71e2nFTTsZTHn0fWaolZEnVN
         DyOg==
X-Forwarded-Encrypted: i=1; AJvYcCWZbbvpvrAL4K+czgnxHKYITvuuXP9W9KxDVvKy5S0NOAcd3TtVNEKneyULp+MC6o1D7u21mf1xdko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKiQILTl2H/6eBCu09Lz1Z9r2apOjMneT1VIaGfsMCbFMuPWqN
	7zzzFsa4HEC3pEf6NbQS968KhSoKoq9/qDKsEShfKlnZI/BO6vtucxYt+LdSZemzkXI=
X-Gm-Gg: AeBDietynWyoc/uHOk4grStEPkWisTMsmGBCIQVVde0Q+0ZBS3496UFaHNPqWj5tYay
	hQLKcHXlrRXhO9Xtk3ZLj1JS368qotOw+Fbq17wkE8Owv0iMsSxwzHanXBXO4BRMifHS6BtaQpd
	uG6fNbMf24ttRuQgzH+kuD9AcYMuMtbqz6TCQ8DN9pw1F9wlLWgr3GhUHE8SzcdssxpCDBWyvFP
	dhNjneVAfiafSn5BorMhoq1BIChKGXnsc1BBNOzuX/v5fwB5s0QfoRFb64tu44oX4XXMB+G+IVk
	epMVKJoVmyrQKiaVrgTYmlVDGwsKcIwhRM7CaljdhzIgxaj2C+nPQ+lvflvkXN/7+NDxXvN4Qkq
	oyLYGHpe8VQaRM1vmWDQ/If3ui5cxoeg5kFdOXPu2xDYVO1x7X7gxhyJZQvrJhN8NO5OiLJluH5
	BotrMsedwg9WlR2vG972+IWT4p+jLgQDDmspJsTcW+Tw3Xjd7kgeWXoTBK08IuNkhBiAMzyY0=
X-Received: by 2002:a05:6820:4b0d:b0:67e:432a:9c9 with SMTP id 006d021491bc7-6822152ac23mr6124431eaf.31.1775483798638;
        Mon, 06 Apr 2026 06:56:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6874bdf0f3esm261410eaf.4.2026.04.06.06.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 06:56:37 -0700 (PDT)
Message-ID: <83971700-ea17-4fd5-8985-68c798222800@baylibre.com>
Date: Mon, 6 Apr 2026 08:56:36 -0500
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
 <LV9PR03MB8414C570998C4C1EE59ABFBBF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
 <LV9PR03MB8414BB41577A8B5A0432463FF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB8414BB41577A8B5A0432463FF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-8491-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim,baylibre.com:mid]
X-Rspamd-Queue-Id: 076753A3BCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 8:30 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: Sabau, Radu bogdan
>> Sent: Monday, April 6, 2026 2:08 PM
>>
>> ...
>>
>>>>>  #define AD4691_CHANNEL(ch)
>>>> 	\
>>>>>  	{								\
>>>>>  		.type = IIO_VOLTAGE,					\
>>>>> @@ -122,11 +155,9 @@ struct ad4691_chip_info {
>>>>>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),
>>>> 	\
>>>>>  		.channel = ch,						\
>>>>>  		.scan_index = ch,					\
>>>>> -		.scan_type = {						\
>>>>> -			.sign = 'u',					\
>>>>> -			.realbits = 16,					\
>>>>> -			.storagebits = 16,				\
>>>>> -		},							\
>>>>> +		.has_ext_scan_type = 1,
>>>> 	\
>>>>> +		.ext_scan_type = ad4691_scan_types,			\
>>>>> +		.num_ext_scan_type = ARRAY_SIZE(ad4691_scan_types),
>>>> 	\
>>>>
>>>> Usually, we just make two separte ad4691_chip_info structs for offload
>>>> vs. not offload.
>>>>
>>>> ext_scan_type is generally only used when the scan type can change
>>>> dynamically after probe.
>>>>
>>>
>>> So, just to be clear, you are saying I should have different chip_info structs
>>> and change the triggered-buffer for offload ones if offload is present?
>>> I am asking since offload has different scan types as well, and this would
>>> mean 3 different chip_info structs for each chip -> total of 12 chip_info
>> structs,
>>> each with a different channel array, or perhaps there is a more compact way
>>> to have this implemented.
>>> I could make the channel arrays use the same macro and have the scan_type
>>> reversed to storage and shift done as parameters.
>>>
>>
>> I have given this a thought and I think this could be done in a more compact
>> way:
>>
>> 1. Parametrize AD4691_CHANNEL to accept storagebits and shift, then define
>> 4 channel
>> arrays:
>>
>> 	- ad4691_channels[] - 16ch + timestamp (triggered-buffer path)
>> 	- ad4693_channels[] - 8ch + timestamp (triggered-buffer path)
>> 	- ad4691_offload_cnv_channels[] - 16 entries, storagebits=32, shift =
>> 0
>> 	- ad4691_offload_manual_channels[] - 16 entries, storagebits=32,
>> shift=16
>>
>>     The two offload arrays are shared across both chip families. Since
>> num_channels
>>     bound the interation in the IIO core, the 8ch chips simply use the first 8
>> entries of
>>     the 16-entry offload arrays. Triggered-buffer path would need different
>> channel
>>     arrays since the timestamp index would be different, and offload doesn't use
>>     timestamp.
>>
>> 2. chip_info could then stay at 2 structs, and have channels selected at probe
>> for the
>> indio_dev, or have 4 chip info structs each having its own channels assigned,
>> and only
>> num_channels could be changed at probe.
>>
> 
> I also have to mention that the oversampling commit would then implement
> AD4691_MANUAL_CHANNEL macro which would miss the OVERSAMPLING
> infomask, and offload_manual_channels will be declared using it.
> More than this, that commit would also add other ad4691_manual_channels[]
> and ad4693_manual_channels[] arrays that would use that MACRO as well.
> 
> Then, chip_info would have ad4691/93_channels assigned to it by default,
> and indio_dev->channels will later be assigned at probe, depending on the
> mode and offload.
> 
> If different chip_info structs would be wanted still, then my best guess is
> to have different info structures (perhaps new types) in chip_info by default.
> Something like *sw_info and *offload_info.

Yes, this is how I would do it too.

> Each one would contain all the pre-defined channel arrays in them
> (channels and manual_channels) and so have ad4691_sw_info and ad4691_offload_info.
> After so, chip_info will also contain besides these 2 info structures, num_channels and max_rate.
> At probe indio_dev assignments will be made from the chip_info entirely.
> 
> What's your guys take on this? I am keen to hearing your thoughts about this.
> 
> Thanks,
> Radu
>  


