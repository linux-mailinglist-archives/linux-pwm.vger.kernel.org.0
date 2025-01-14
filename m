Return-Path: <linux-pwm+bounces-4628-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EF2A10B7B
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93BE163D87
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01FA156991;
	Tue, 14 Jan 2025 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="D5FRSsbH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C915E5CA
	for <linux-pwm@vger.kernel.org>; Tue, 14 Jan 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869891; cv=none; b=HUze/bSupRzBxc46bZN68v+uLyf9rlrHDGZkPLF8pCQ4CGldB/Aw5TMcaelM5qlyuzv6i9rNigz16b0zPYCIxh+ZURVrvAfN0nEKJ/nt22VoJZGlPvAluJaeD/cYDVxF3KSfcPLrax4WYDJKs1qODcLFydV04fXxaMf8q9N1S1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869891; c=relaxed/simple;
	bh=L74jRs1dONVGrPeAHFmIlQs5fRrA3AGMZqSCnDcXEwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCi0CXE4tmdQYisYVAa6FFQdakoK3x3tP7xcjZGdrJOnKJCsFEcMzf+RQTZOw1teZwmIOp6YPP1vFtFy5c/cxHvhXAoEaynbd2P/MN0sy9bQ2SraaSp/6qT9Zeai4G74avz1PmkPDyqIFkT+qKLvoFooPvWzLjoUEA1ZByRLLmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=D5FRSsbH; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a0206590a7so2943523fac.0
        for <linux-pwm@vger.kernel.org>; Tue, 14 Jan 2025 07:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736869889; x=1737474689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tvuSSpwSkjYIraUioNxnd9y7q+DAaxVqELrz32e6A30=;
        b=D5FRSsbH/jrCcfFa2WYsYzDjkWv36q/hxECbF70hmKaDwSXVx+QCVJP1zX3lr7R+xc
         4N+ID4JPy898pe4AoZcfXaltMcK/R5DP0+KaINBUincts41pd6m2qUrQFQ1Odf8e5AeB
         sR28AcczQvh/fojL6YKYrkoKxNV/WmZm5LBf+SdtyzgpnOq3xZRF1rN5jEk5sbEb9LWu
         l18pv0RXzi+Y4QQKGYs/0hLmthWsV2Uv5K7Kj2VmA3Pg/UaCoYsd8+vvbv2276vaZX1X
         OQx/PnDmmlOUZageQlcxvTlO+aaMI+0nN8V2CikIHg1NatauPOC6R63DwfSx3UEj5XBM
         Nyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736869889; x=1737474689;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tvuSSpwSkjYIraUioNxnd9y7q+DAaxVqELrz32e6A30=;
        b=QRoXvOmRH5WatlhlAYdAb/8YeYmZWQwKIjKcs8gmi6pGjThcacQy0iqSNa2N1CdShr
         DpCLqrIfD06NWQuJHA70gO4QbUhpvlxH8jio2WPqg3HYzzPE0Gi01rTJ6YiqP7AsZkve
         01FumSZqbco1o83NetrA4lt7jPgYOiT+91d1MrCJMCtkmItIXEbm3LSzuvf/m5mihbSh
         vkSRN/T2L1R4dVFPn8UmPztcwB/bP/auFXibWkUhtRxH147As7zf34o1Frp7vts5TMdc
         LI5RkFNYdl+mUuVehvU9QvKwbGlIjBIMj1VjxRY9Nxh34sTU1G7peY6iSFuauTrCcSGP
         cJAg==
X-Forwarded-Encrypted: i=1; AJvYcCWRmpLi9HTE5xbXU7M1+09qvkm+69Q7iEBakbKgJbOUCFelvubMSekifgIJ6fFMnmXVtXu/XFPE+r0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DqspheWkwBCL+Inii8PfAtpDTa3F3vJbeXdT6SlzvZGNkten
	FRJiL1JcblsR20J6hk0tum+tNq2S/5O1zdvR9NA55jnHgHCbiMR75R9XHnUMMn8=
X-Gm-Gg: ASbGncu+Ob2EA29nZLKHUBSlt577PsXOpoZTZZ/URu5YjmOnb8yFFHhKVcEb3kdYVG8
	G7x0Chz3tnNvXV/6m/NOEExO6V1RQ4WLT3cpv21SpsMJdEho/pTzsc9cHwGSepelwtMi88FiulA
	57HIoYl1QwGC0qQwzNpJcpPLcOXoFNTxVCM8pk6uaoBpWxcPZGKYOUTrem08fsxQzY84pt4P0yR
	QQTf5VRAozBUg6p0TrEh+f6uQFwFucWjtc9ptA9TnNgJqqs2IbBqv22ZyCSsW+LJ1gL3klt1OhU
	8viyMQn7iwCUuGO3Ng==
X-Google-Smtp-Source: AGHT+IGALdOvjLIjRKcsuyz9XUa9hgth8o9CIfqhXL6qycHUaaR7ZJ3MTLSS5iUrarkgheuuDhPueA==
X-Received: by 2002:a05:6870:2007:b0:29e:5297:a2a7 with SMTP id 586e51a60fabf-2aa068d657fmr16043927fac.30.1736869888835;
        Tue, 14 Jan 2025 07:51:28 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ad8017c2d0sm5093216fac.0.2025.01.14.07.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 07:51:27 -0800 (PST)
Message-ID: <95e54ca0-041e-4e6e-8364-d22d6d2e16a5@baylibre.com>
Date: Tue, 14 Jan 2025 09:51:26 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/8] iio: adc: ad4851: add ad485x driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
 <20241220120134.42760-8-antoniu.miclaus@analog.com>
 <37fcda1c-0051-4a8c-b61c-583a1b8faa1e@baylibre.com>
 <CY4PR03MB3399F8E7AFA00340321BB2A69B182@CY4PR03MB3399.namprd03.prod.outlook.com>
 <20250114132035.00004abd@huawei.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250114132035.00004abd@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 7:20 AM, Jonathan Cameron wrote:
> 
> Hi Antoniu
> 
> For future replies please crop to only the bits you are reply to.
> Took me a couple of goes to find the reply, so in some cases
> the important parts can be completely missed by a reader if
> the rest isn't cropped down.
> 
> ...
> 
>>>> +static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
>>>> +					 const struct iio_chan_spec *chan,
>>>> +					 unsigned int osr)
>>>> +{
>>>> +	struct ad4851_state *st = iio_priv(indio_dev);
>>>> +	int val, ret;
>>>> +
>>>> +	guard(mutex)(&st->lock);
>>>> +
>>>> +	if (osr == 1) {
>>>> +		ret = regmap_clear_bits(st->regmap,  
>>> AD4851_REG_OVERSAMPLE,  
>>>> +					AD4851_OS_EN_MSK);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	} else {
>>>> +		val = ad4851_osr_to_regval(osr);
>>>> +		if (val < 0)
>>>> +			return -EINVAL;
>>>> +
>>>> +		ret = regmap_update_bits(st->regmap,  
>>> AD4851_REG_OVERSAMPLE,  
>>>> +					 AD4851_OS_EN_MSK |
>>>> +					 AD4851_OS_RATIO_MSK,
>>>> +					 FIELD_PREP(AD4851_OS_EN_MSK,  
>>> 1) |  
>>>> +  
>>> FIELD_PREP(AD4851_OS_RATIO_MSK, val));  
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>> +
>>>> +	ret = iio_backend_oversampling_ratio_set(st->back, osr);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	switch (st->info->resolution) {
>>>> +	case 20:
>>>> +		switch (osr) {
>>>> +		case 0:
>>>> +			return -EINVAL;
>>>> +		case 1:
>>>> +			val = 20;
>>>> +			break;
>>>> +		default:
>>>> +			val = 24;
>>>> +			break;
>>>> +		}
>>>> +		break;
>>>> +	case 16:
>>>> +		val = 16;
>>>> +		break;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	ret = iio_backend_data_size_set(st->back, val);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (osr == 1 || st->info->resolution == 16) {
>>>> +		ret = regmap_clear_bits(st->regmap, AD4851_REG_PACKET,
>>>> +					AD4851_PACKET_FORMAT_MASK);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		st->resolution_boost_enabled = false;
>>>> +	} else {
>>>> +		ret = regmap_update_bits(st->regmap, AD4851_REG_PACKET,  
>>>
>>> regmap_set_bits  
>>
>> Why? Packet format is two bits wide according to the register map.

Oops, I was expecting it to be symmetric with regmap_clear_bits() above. But
of course you are correct.

>>
>>>> +					 AD4851_PACKET_FORMAT_MASK,
>>>> +  
>>> FIELD_PREP(AD4851_PACKET_FORMAT_MASK, 1));  
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		st->resolution_boost_enabled = true;
>>>> +	}
>>>> +
>>>> +	if (st->osr != osr) {
>>>> +		ret = ad4851_scale_fill(indio_dev);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>> +		st->osr = osr;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
> ...
> 
>>>> +static int ad4851_setup(struct ad4851_state *st)
>>>> +{
>>>> +	unsigned int product_id;
>>>> +	int ret;
>>>> +
>>>> +	if (st->pd_gpio) {
>>>> +		/* To initiate a global reset, bring the PD pin high twice */
>>>> +		gpiod_set_value(st->pd_gpio, 1);
>>>> +		fsleep(1);
>>>> +		gpiod_set_value(st->pd_gpio, 0);
>>>> +		fsleep(1);
>>>> +		gpiod_set_value(st->pd_gpio, 1);
>>>> +		fsleep(1);
>>>> +		gpiod_set_value(st->pd_gpio, 0);
>>>> +		fsleep(1000);
>>>> +	} else {
>>>> +		ret = regmap_set_bits(st->regmap,  
>>> AD4851_REG_INTERFACE_CONFIG_A,  
>>>> +				      AD4851_SW_RESET);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>> +
>>>> +	if (st->vrefbuf_en) {
>>>> +		ret = regmap_set_bits(st->regmap,  
>>> AD4851_REG_DEVICE_CTRL,  
>>>> +				      AD4851_REFBUF_PD);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}
>>>> +
>>>> +	if (st->vrefio_en) {
>>>> +		ret = regmap_set_bits(st->regmap,  
>>> AD4851_REG_DEVICE_CTRL,  
>>>> +				      AD4851_REFSEL_PD);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +	}  
>>>
>>> PD stands for power down, so should we be powering down if not enabled?
>>> (i.e.
>>> if is missing !)  
>> We power down the internal reference if the external one is used. Not sure what is wrong here.


I see. The macro name is wrong, which made me think it was doing something
different. It should be AD4851_REF_SEL rather than AD4851_REFSEL_PD.


>>>> +
>>>> +	ret = regmap_write(st->regmap,  
>>> AD4851_REG_INTERFACE_CONFIG_B,  
>>>> +			   AD4851_SINGLE_INSTRUCTION);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(st->regmap,  
>>> AD4851_REG_INTERFACE_CONFIG_A,  
>>>> +			   AD4851_SDO_ENABLE);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
> 
> Thanks,
> 
> Jonathan


