Return-Path: <linux-pwm+bounces-8967-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G63BzEsC2opEQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8967-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:11:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D5656FA76
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B08F3035B7A
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 15:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD857347BD9;
	Mon, 18 May 2026 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ewYfBRk3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E3D7081F
	for <linux-pwm@vger.kernel.org>; Mon, 18 May 2026 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116713; cv=none; b=rmzjqth1GFDPuNM5fH5P1gR1uoyFa8/Zg14ddcev8bDtXvpeanHxODH7X4FQjyWKsADKTbRkqe7IEkds5PYUgKE/0NJ4j8jKsuxJu2DPWtbPhUCgSsyUEP31tNAscEnQ/xm+MvdBFso90DRaCF7CX/e38b+G2JzZmAwBCW5SCRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116713; c=relaxed/simple;
	bh=DrQFqVK7ClQwUsYNDfngLJu8LH50pdn60WsQM9mVJjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vl2AbEbli0+MVU0ht+H/8lGu1tSWyyk4PrZGdEyHfb2ESpFY5e+WRXGHlLNvKWdhVZkdSEaNfE7hf42dxK6smDf3drclUzGMj6EMJMQN0MZ75qbGdjo16QhSn4cvpdVeose5Pl0MZkUX0YKinXHQvuCEtd0q/KpvNJ4E4b8sI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ewYfBRk3; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7de4e6c5a30so3230479a34.0
        for <linux-pwm@vger.kernel.org>; Mon, 18 May 2026 08:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779116711; x=1779721511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vzeCgn9mFtApC0ztEgdeNOw9BPgUS/EnSmz8TCLSDFQ=;
        b=ewYfBRk3g81dHYnO16Ez41aN6rGoZpbIREqK1Vz66bGFuC87V98aZpv4kzpfFyLQC8
         ihv6/d1Ji5Xpx55PVndkVaRPrAbqTIk1tFYuXSGd6sLUzB07YRhVT/UNoTVmef+rpaTm
         x44atynP9lTgnWFixWOjLDvsMOiYjHmXrLSyMrBig3glDAfdl8mBwbRYMWiotL3ZjPR7
         rKtP+g6Nu/1YlfD0AISW/xEefihRpXMqHwC3uhb/fLht3AZU0KLdWpflf74uZNGSDD6d
         UmA9/PXY3GJxeW+pGDqselprahwvRMx4Jfg4gvJekqMuKxViDcIE00LvCWWQYHFU6VJ6
         dmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779116711; x=1779721511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzeCgn9mFtApC0ztEgdeNOw9BPgUS/EnSmz8TCLSDFQ=;
        b=rxvhoF9gbrmqf1XDDldS6HPW8X+kdPSlvEHvNbr50qEt6asQvUx/DHw70/NjgKEawi
         fuguiluOpdQOhZRD94IOPcU+eCUs5Ay1LPMRS+QBRv8FxZm1asY9W4NXMSETrUhXsliL
         xHSkY0dCqyUSLIKxmcOF9n/HOnm+z9/eeLALo7UCQxy1A3NGRWl1mCGMFHHP5sbtQ0bx
         z8CWjmm7zK5hCrHMHX24Ofj8OWbYmbgG0CMis+tkII+ww1kXqVrxNb9jp4MVqh0jiYc3
         wetSXJKHVUvmcmmh1IDWYXcbJn2olVRH5ksgWY71JZVloTkN8feJu6xlchqkGRZq8crD
         hpdw==
X-Forwarded-Encrypted: i=1; AFNElJ9uLKeVANoCPNahWvWZxevtMbKApKznXSgzs6rbd1MT7dVG+wQroOy2o+k7ruw2oH54sZUVTHrT4ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9C3KYj4Yh8XjFfaNC9EPPDdzH0KFp5ijIXJVu1X2E/fEY0Aq0
	11YybR621ByOnKhSIsliH61xnrpIiwdMKLbl9g1ZrIjs/RaQL6biKtQjKHfbPEuxhYI=
X-Gm-Gg: Acq92OFHqZ4pp7r7Wjg2ZbynkZY+AsXeQelxd6bIpZJCvath57R5IEfYTWIeUj51eMg
	CR50mZb/eUyR3DhRhw+VtMbSJUPUFiNjCuLdvCFy126E2YcqBqwUGJ5KmE9/EDWuqG2nyQE/Bfr
	8gMVDD4N2bQSx0nSXcmS29lWhYdmSug9ZBI7LWY4WKWI2R5n/psYdQ6scQxG38ykLRnBqJeNTup
	xO0u060A1lQfPQJtYcfhE9/TtpRbg6Krx15csIy5N2aXurnzquG1ZOzICaTdJweZamVzL21EB3b
	Hc1obZO1diIbnaaOaR7onTQbCbjeZ78vrwgngsA1pbq5eB7kP7OzCZ/yEA8pJlJZLSETW0znqjk
	x/WeYhT+cJLwP/2zp5ziFDXlaWsIjm/ZesOk2kP528F3nPiXmohfJ5FSiiEkODYVK29y29W/Uvk
	XKvIdQ1bZ2b+C6rl5f0rjjHyvz6h2I7hnKjXBjYowg+LnAg928JMO7baAh23237aHkb7CMA9K2y
	Q==
X-Received: by 2002:a05:6830:3903:b0:7d7:ef0a:1ce5 with SMTP id 46e09a7af769-7e4ea07e9demr10482946a34.9.1779116710621;
        Mon, 18 May 2026 08:05:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3be6:1187:fed4:378b? ([2600:8803:e7e4:500:3be6:1187:fed4:378b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b81c8a0sm7696080a34.10.2026.05.18.08.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 08:05:10 -0700 (PDT)
Message-ID: <7d338351-5f1f-4eb8-a266-b8756d0e60f5@baylibre.com>
Date: Mon, 18 May 2026 10:05:09 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
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
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
 <20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
 <0696b662-f478-4d1a-95e0-0338bbdb719e@baylibre.com>
 <LV9PR03MB841445D5BD1087FB3204EBD9F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB841445D5BD1087FB3204EBD9F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8967-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlechner@baylibre.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 77D5656FA76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 9:59 AM, Sabau, Radu bogdan wrote:
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Saturday, May 16, 2026 8:11 PM
> 
> ...
> 
>>> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int
>> *val)
>>> +{
>>> +	struct spi_device *spi = context;
>>> +	u8 tx[2], rx[4];
>>> +	int ret;
>>> +
>>> +	/* Set bit 15 to mark the operation as READ. */
>>
>> Can't we just set read_flag_mask in the regmap config?
>>
> 
> As far as I can tell read_flag_mask is applied by the standard SPI regmap bus
> backend, which constructs and sends the address byte itself before reading
> the response. When using devm_regmap_init() with custom reg_read/reg_write
> callbacks, the regmap core calls those callbacks directly with the raw register
> address - it never touches read_flag_mask.
> 
>>> +	put_unaligned_be16(0x8000 | reg, tx);
>>> +
>>> +	switch (reg) {
>>> +	case 0 ... AD4691_OSC_FREQ_REG:
>>> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_MASK_REG - 1:
> 
> ...
> 
>>> +static int ad4691_write_raw(struct iio_dev *indio_dev,
>>> +			    struct iio_chan_spec const *chan,
>>> +			    int val, int val2, long mask)
>>> +{
>>> +	switch (mask) {
>>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>>
>> Should we aquire direct mode so that we can't change the rate during
>> buffered read?
>>
> 
> It is in set_sampling_freq already. Do you think it would make more sense
> to move it here in order to help readability?
> 

IIRC, I think it was resolved in a later patch in the series. So
could just be a problem of it not getting added in the right patch.

In general though, yes it would make it easier review if the
direct mode claim was made here.

