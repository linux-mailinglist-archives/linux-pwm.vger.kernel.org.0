Return-Path: <linux-pwm+bounces-8283-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMnBDn80uGnXaQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8283-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 17:49:03 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9463729DA02
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 17:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 238623071F0D
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE003CD8B8;
	Mon, 16 Mar 2026 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iTFuv01s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03838E5D1
	for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2026 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679489; cv=none; b=Tz/HuD0/JgFVRXvxylTIKnwGGZFhK8ZfiaEATW8etUqlLkWbmlaFXyHs3Bieu/+22z8ua0eVZNsxKpLXn+i5nWr5UKVt/kQhB6BF3U5eciq+uVJ62vOPGCbG66ix5gwyJg4+W1jzcDLmDm4pilV8lo4zHnb7ewAbJnJoeqRcDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679489; c=relaxed/simple;
	bh=Tkdt6e6cnfyPY0SugtxYloHST0stO69sHMglYRTuOi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9QTNWhgoT7W+AFUPqXNP/RRQ9edu8/htee5vrU/VmiDiMRoNcc8473tER88JAnzAtYRhS19rS3pduzd2kylgDv5OqZe19BIagDMWfAU79M77STNDaseya18E+DfNoXgSWBmUJiwP4tg7CeVMzXGvpkKfTBh0bBY3quE/3kTelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iTFuv01s; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4138136f02eso3287993fac.2
        for <linux-pwm@vger.kernel.org>; Mon, 16 Mar 2026 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773679486; x=1774284286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4AJTku3OJZDZ6/Kpiw5pDXaqosol7el2TXJoCn2CGLI=;
        b=iTFuv01sWYT+Kv5MkQyWtJ5hj1yeq4H2sWPcTmnOjZwRc+VRQZ7HLoo2fAUEjJa8a/
         I4yhutovyrIh0Dog60nItEsnan7+/ELbTB6P39HRFPutA0L8dFvynDwjMhb62zXzDEWD
         BS4lYWyhk7AGsCOkEZPwBzG6N0PAyGTe2N60Vb/vbyecUzjYi/+48yd82Alg4IMdw4pm
         0OLfZMCubL00ZTG7wVAhIEOHX1R0WqCIlOedtQw6oebgcXqKQvlviYMZoxB39oC3D/ox
         KDa2sDZ7yrwt5sfO5JWymdSFM6P1uAGIkFlVoawdP+6UG49eY58kesVfjfH41MBQTljF
         GreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773679486; x=1774284286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AJTku3OJZDZ6/Kpiw5pDXaqosol7el2TXJoCn2CGLI=;
        b=s1HBPptROD9eqhduxIlCwdHaAdvES0hOg0UuaVp1wZSGR4CERw2crIcrmAxQnH1bqW
         4+/YRRXwuARbHW/5/vMiv4Kwwr13IzfrUnViFTp5iw/BVWYmlsrVNSi9FMcuzzRoFRIq
         pCkFM/6wQT00g9+ZBLVRyN6aVuVzdQCzeHDKqar01F99/7UitGWtIlT6Z0NoyQ+xB92x
         7491dKJgFL8T2O3ai94bszzOsMyp/rbaGCu7UITW/6WXRhGLHAvAc3tFo7xMDRRXhulZ
         NP/47js4r6sgM+kc48PGaxtseLXDdYmUXy86keDDn2OWu1ohPluFCzCm/YlqFo9BPEhJ
         a8OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnYq+yUm5eFzfuUz2vBijAjPvXuXFUzVXRckJ3s3LyjIPF1Vac+n74QRMc6SiXs6q2Bij2sF6nCo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywyZ+GyyAqkPr16JhQTgmwLwVcR1UUinficr3izkl4lDy6zLgb
	tQpkeUEektibUGwzEioRs3Ou8cpbTBN70y6YuLKiTLeSkPWK5hz+d0Mxc/wvGV3oBCQ=
X-Gm-Gg: ATEYQzxbq0LxHuSfL8NRVUzyuL8ne+9kpZlOsh8zzWVZQqIekNgWIdFGxAnO/ujX6+E
	ncU4zBTPDoeJ0WpSLGoxcrW7Af2c9wQMQ7F9haih2yVo1Z3V3JBLWgePQCpcSiQgOTgH2mxRvGb
	80rGGf9FOxkT5aPvSfACBZu+sxtEcuoLOsX1aWEXi1BM2t2u6VEz2azfmwp6Z0rZtiVSJguGWtV
	OJ0i8nHG1RKkwcik11aSnNc4UwC7hUL1xl4POCD6QJV14cjRZqV8OJen3bbymoZbViBMZmAhpgs
	qncOb97HF3zD2XN4E041gcx7gu2CWH/tVmUc3t5F6xqox139ChejGbCJ4lgCwJgvBdSRZlwH3H3
	BDzfG0SPp3F6pbE6jqVx3S5ox3CR4h9xjo73zQqISLhVCSUqY/PZo3kJwY9ibkyAsZaBX8mqpuV
	bqm1OtgZDvWqLQqrBw7JCxRu9LmCo6R4yOYu2/J0QZPvcuujEypx1msYVQKK/1nfel16P86dJIU
	g==
X-Received: by 2002:a05:6870:3b8e:b0:417:22c9:a311 with SMTP id 586e51a60fabf-417b902ecbcmr8375036fac.6.1773679486349;
        Mon, 16 Mar 2026 09:44:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664? ([2600:8803:e7e4:500:e504:a034:1152:a664])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e69c79dsm15440675fac.15.2026.03.16.09.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 09:44:45 -0700 (PDT)
Message-ID: <06b48810-f997-40a4-86db-d3b7db9dfc18@baylibre.com>
Date: Mon, 16 Mar 2026 11:44:44 -0500
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
 <7251a53a-100c-4867-ab4e-b7d2d019b26b@baylibre.com>
 <LV9PR03MB84146ADC269645000849795AF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB84146ADC269645000849795AF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
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
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8283-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9463729DA02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/26 10:56 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Monday, March 16, 2026 5:38 PM
>> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen
>> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
>> Jonathan Cameron <jic23@kernel.org>; Sa, Nuno <Nuno.Sa@analog.com>;
>> Andy Shevchenko <andy@kernel.org>; Rob Herring <robh@kernel.org>;
>> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
>> <conor+dt@kernel.org>; Uwe Kleine-König <ukleinek@kernel.org>; Liam
>> Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Linus
>> Walleij <linusw@kernel.org>; Bartosz Golaszewski <brgl@kernel.org>; Philipp
>> Zabel <p.zabel@pengutronix.de>
>> Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-pwm@vger.kernel.org; linux-
>> gpio@vger.kernel.org
>> Subject: Re: [PATCH v3 3/4] iio: adc: ad4691: add triggered buffer support
>>
>> [External]
>>
>> On 3/16/26 8:22 AM, Sabau, Radu bogdan wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: David Lechner <dlechner@baylibre.com>
>>>> Sent: Saturday, March 14, 2026 8:38 PM
>>>
>>> ...
>>>
>>>>> Both operating modes share a single IIO trigger and trigger handler.
>>>>> The handler builds a complete scan — one u32 slot per channel at its
>>>>> scan_index position, followed by a timestamp — and pushes it to the
>>>>> IIO buffer in a single iio_push_to_buffers_with_ts() call.
>>>>
>>>> It would really help here to see some timing diagrams to know if we
>>>> are implementing this right.
>>>>
>>>> For example, it isn't clear that in clocked mode if CNV triggers a
>>>> single conversion in the sequencer (i.e. IIO_SAMP_FREQ should be
>>>> info_mask_separate) or if it triggers the sequence (i.e. IIO_SAMP_FREQ
>>>> should be info_mask_shared_by_all).
>>>>
>>>
>>> The CNV triggers the sequence and IIO_SAMP_FREQ is
>> info_mask_shared_by_all.
>>>
>>> As per datasheet page 31 (Accumulator Section), when each accumulator
>>> receives a sample, the ACC_COUNT is increased. In clocked mode we
>>> are setting the ACC_COUNT limit to 1, therefore having one sample per
>>> channel (no oversampling as discussed in previous versions). So each
>>> period of the CNV PWM is respective to one sample of a channel.
>>
>> Assuming that "a" channel means "one" channel...
>>
>> In this case then sampling_frequency should be per channel (separate).
>>
>> A sampling_frequency that is shared_by_all means that each period of
>> CNV should trigger one sample each for _all_ channels. In other words,
>> the sampling frequency gives one complete set of samples for all enabled
>> channels pushed to the buffer.
>>
> 
> Oh, ok then, will have them separate. I assumed that since the PWM period
> is constant with each pulse, then the sampling rate will be the same for
> each channel, thus having them as shared_by_all, but I assume you are
> right about this in this case, I will have them as separate in this case, the
> update will happen in the previous patch upon next version.
> 
Does the sampling stop after one "burst" (reading each enabled channel once)?

If yes, then what controls when the next set of samples starts?

Looking at Figure 63 in the datasheet for CNV Clock mode, it looks like it
depends entirely on how long the SPI message takes. So the actual sample rate
is going to be quite random instead of the sum of each channel as the IIO ABI
says it should. It seems a waste of the PWM to do it this way since we end
up with a random sample rate.

It seems to me like the CNV Burst mode would actually be better suited to
how IIO usually does things. In this case, the PWM frequency would control
the effective sample rate (one PWM pulse triggers one complete set of
samples) and the internal oscillator controls triggering each individual
conversion.

In this setup, we would still have the info_mask_separate IIO_SAMP_FREQ,
but it would control the internal oscillator. Then we would have a separate
buffer0/sampling_frequency attribute that controlled the PWM frequency.

Then, as long as the PWM frequency was slow enough that the SPI message
can be done, it can make samples with almost no jitter. This is why I would
expect PWM to almost always be used with SPI offload though, otherwise
it has to be quite slow compared to what the chip is capable of.

I suppose the CNV Clock mode could also be made to work with the typical
IIO trigger so that we could control the actual sample rate. It just
wouldn't be as precise.



If you have some examples of how this chip should actually be used in the
real world, that could help pick what is the right thing to do here.


