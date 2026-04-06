Return-Path: <linux-pwm+bounces-8489-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPO2Aeq402n8kwcAu9opvQ
	(envelope-from <linux-pwm+bounces-8489-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 15:45:14 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7E03A3A94
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D8953011C7C
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C565D309EE9;
	Mon,  6 Apr 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="EpI3IggI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF92EC54A
	for <linux-pwm@vger.kernel.org>; Mon,  6 Apr 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483050; cv=none; b=hl3QyauAZFceY7yZtiiqpHT/3ychCNlwHgF8AE1Q1I0Tbj7ZG2JiQEZd9YyFQ+Vm7nbS21B02VNG3H4eLuuPFLAEBuTTpPO+qXUftjQTUUe+QyJHXX7eLXO8hWH/dOmH4YvRk9fsRtMcoSriU1VqbKtJidMVLjEMPASDsVEyfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483050; c=relaxed/simple;
	bh=hkcM1Omm9OFY6W+niG6QwONEFgv1cJEAMBmp9sPIB5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1keErvBfhjSJs9kqtVL6g9eBALDHn694HrtowhdaSJEdYpBGnd47xcabZy5dd8F7n/J9R4WpSJ6upzB6swaFaDQO4ROuDV7OqcNSv+rsFGva7QhXY6gOsJUwBfGXuzuMN6Q7Djc0oma5hF/shXUSBou8KqZjVIvnZjCpXAPNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=EpI3IggI; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d55b97f358so2556366a34.3
        for <linux-pwm@vger.kernel.org>; Mon, 06 Apr 2026 06:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775483048; x=1776087848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rlQVLfivynUuzRB6dYfCNFOl6c9Ld5CNamz7tvg5f4=;
        b=EpI3IggIGZVVD0vjKmwWONi0EPPwXX3XN7NAEM9b4wDVT6nbv96/CKQ60b7F58WQAa
         +7cCka65EOM8/GcT/IZIf51QBwwSxlDeehg9HV5DuOvkIQ+W3W8Q5FNrxi561AdSyEht
         SLeupVKDHBuRR6zZ0NFzqD+K+ItF0RmdMl3X9Uh7mJo5quxtNlTvQOLYLWtmQ1rr0lgV
         DlZZzrBmKqJQMsXVrAPFBaBXYraeCuZK7J4CBMW4o1Lhx145kILQJn4wOfgSUbcdVm86
         fn1PTaZHfIQxgwUsH8BhHiOYtQrGPphLmdolEW0/05WCbsRUXdrPaVmEdAzTTu+qYzjy
         BxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775483048; x=1776087848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rlQVLfivynUuzRB6dYfCNFOl6c9Ld5CNamz7tvg5f4=;
        b=BrJVM0h9A+6l5uIT/UIxFYqNQz1+32Ni/M7K6XETZoBW10h4hpFIukl+ms/eDmrRNO
         Ste/YIfY5e2eNJkSD/lOPLznfSKDQ6V29f3DSZPhFOfT1+5Wt6/IZxv8TMzTqsaF4FKN
         /SqEeOeJfVKa8GpvfnOfpBx330qSo6VB6gZ2aYFkZRb5tGwVxFtMurlJEWxs2WdSD0ih
         hPjh2vxOE1Izmn26l4Omb+A8fndzP1XmImkOEA8cCUb8EBlkHrAWzDY19VzLEfSzmqnS
         f1w+/XbcJRa+378I5wnxfNPDjv2A+p/atOD6u3CRSBhhTbDi85XrBS+I8u6GdbOEf0cr
         46fQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZdN9K72BexDRGUYE9y9+DBjD63KRNnotKE52pW3oYlcpKhwy/M5vDYyyc8+KjTjeQw3Ku238t7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzse3QOGJEmAw1h2dP9LFSBeV2pC5IQXaF3WilnPSPXANX8Pe1
	bUjXw8UO5iBkIEPAD7EQq1TxS3yPEMICBvUPkH+erAPif0HfAfQnriTa1RbXNxMFN4Y=
X-Gm-Gg: AeBDiev1K81kca5tTj+YqUX5vormVIzwuJbIJnqb/PIc1Y5QRqlxOCWSVmObd71sLz3
	ikLuL8N8l5GiXGn6tePcZ+G9gLHktDHaj6mcOf+DDveyRzs8pgD87o8wAE+uvCHoY9xLFROuLPq
	KwDK09mL4Glo0rkDWMjzjY22/zrZin19/H2m7feCbTfEjozyitiPS1pwicOu9OYE+tmIlNtVKwJ
	7FjmQKUy0u6NQsGHZxiVOwg4dRjCEo/nwz8jgdXbQoXKNmgKkxMEoChPbIvo+T70Pi4cGmplFmx
	Hpz0JGNsxPURF6VWBwL/k15T64R0N8p6k+FV6uG9wt5lorKAymd14FA1fDQgeCQpyE+wHBqW9DQ
	TDsy7N9eDf1IKJg6iwu+1AYDpbhx6x98ckJKulwzigPbhR1opYXmYu+1AVjKqc1ACC6Hfod7aPw
	neu23kZPUs1XB7y47KgQi2OXxJsBL2ILAXAj5it82c0IOI9IPSfgBMe6xMsBZfttnWF4dasWI=
X-Received: by 2002:a05:6820:81c5:b0:685:d2b6:6df7 with SMTP id 006d021491bc7-685d2c5b87emr2235876eaf.9.1775483048117;
        Mon, 06 Apr 2026 06:44:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb42db1bsm12915687fac.17.2026.04.06.06.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 06:44:06 -0700 (PDT)
Message-ID: <420dba4a-0c31-47bc-b84a-5d29702b115e@baylibre.com>
Date: Mon, 6 Apr 2026 08:44:05 -0500
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
 <1d0d41c8-7867-4459-a91a-a2c6774b1885@baylibre.com>
 <LV9PR03MB84145906CC191F6AB8D2D3DAF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84145906CC191F6AB8D2D3DAF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8489-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email,baylibre.com:mid,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5C7E03A3A94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 4:34 AM, Sabau, Radu bogdan wrote:
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, April 4, 2026 6:34 PM
> 

> ...
> 
>>> +Selected when a ``pwms`` property is present in the device tree. The PWM
>> drives
>>> +the CNV pin independently of SPI at the configured conversion rate, and a
>> GP
>>> +pin (identified by ``interrupt-names``) asserts DATA_READY at end-of-burst
>> to
>>> +signal that the AVG_IN result registers are ready to be read.
>>> +
>>> +The IRQ handler stops the PWM, fires the IIO trigger, and the trigger
>> handler
>>
>> If we stop the PWM after an IRQ, then we don't get a consistent sample rate.
>> Ideally, we would leave the PWM running and just pick a rate slow enough
>> that
>> there is plenty of time to read the data. Otherwise, this mode doesn't seem
>> particularly useful.
> 
> Should there also be a condition when setting the sampling frequency, that will
> protect from setting too fast sample rates?

I haven't figured out a good way to do this since the real max rate
depends on a lot of different things and when not using offloading,
the time it takes to do SPI xfers is non-deterministic.


>>> +IIO DMA buffer:
>>> +
>>> +* **CNV Burst offload**: the SPI engine reads AVG_IN registers with a 2-
>> byte
>>> +  address phase followed by a 2-byte data phase; the 16-bit result lands in
>>> +  the lower half of the 32-bit word (``shift=0``).
>>> +* **Manual offload**: each 32-bit SPI word carries the channel byte in the
>>> +  first byte; the 16-bit result is returned in the upper half of the 32-bit
>>
>> I would expect the "first" byte to be in the "upper half" of the 32-bits as
>> well. This layout could be explained better.
>>
>> Also, since extra data has to be read in this mode, does this affect the max
>> conversion rate?
> 
> This is bad documentation on my part. "channel byte" isn't used anymore,
> this is previous version behaviour. Right now, only 16-bits worth of actual
> channel data are used.
> 
Then why do we need the shift if there is no other data? Can't we rework
the SPI message so that there is no shift?

