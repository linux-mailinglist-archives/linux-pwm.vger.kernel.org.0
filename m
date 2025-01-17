Return-Path: <linux-pwm+bounces-4668-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6CFA155F7
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 18:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6954216870B
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 17:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D401A23B5;
	Fri, 17 Jan 2025 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IcoxvDp/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C053197A6C
	for <linux-pwm@vger.kernel.org>; Fri, 17 Jan 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737136229; cv=none; b=IXT0x1HNk5U0/XMFlN6StyuXueFEXthyonHYjHYbWXqoxkccXvucDxM4OfQ7hjhnpLqmN9HRCfUW8AnBe5y4FsTRGNZD0rbMTFFVnjcyOrs/M5gvT8qlvJXWny1+/oD96Yk7+WaEwES0FX39y9QYtvrywb/ozw+k/ioeli1L3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737136229; c=relaxed/simple;
	bh=+9qcZ+G6muG6oYLwzmZnKY2Ey6qVz8s2rUDziVD4AvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bxLgM3pEfqvH6LzKcuHVS2ZwzXx7IN7js/ji/zPzHq7tRL/CM+KXM5OJvvRLyyM3pc2ugIVaGzYeAOF36M9SFxTs702g7Y5WClcKYBZ8Tkd8EalzVkmNCKf9QM29606qKySAXej4FhoLHYHB9SB86NxBkMP4L0oZP1Sb6KQLysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IcoxvDp/; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb9ba53f90so761922b6e.1
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jan 2025 09:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737136224; x=1737741024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qNLPTBAt6DnkKOKkxEsp/OA05XLjPDskIGtlDK8C6dY=;
        b=IcoxvDp/606Gn6R1LQcEGked9FNWZ/RE8MAPmqMbk+4GZ+fgnk7MNUQl3KpKPhzDPp
         u/9123XH0/vPmDKYi634xCZqG1qoJzenIJ15oVRIPFTTGeAk52rQQj2FuzhKeMuMJJOa
         fCR8K08AsA8gKp8Q7zLtmllsTj/N8bIbsc1RreezihPUkxr6nne8tFEJpKNMgFqgpF3V
         FBlAhq/8qpVSa7GQU13+uWWog7R8lhZ/b66NYSya+CWy0wggvUij0+9rUkwmTbk0hyjp
         z6IJjppbFTCLc/zjgDgBjFozil8tD/M/qehIlYxw5o72lhw7TYzzITG4FrMvMP2NL/Xs
         y8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737136224; x=1737741024;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNLPTBAt6DnkKOKkxEsp/OA05XLjPDskIGtlDK8C6dY=;
        b=g+7LpENFsV4JjwvAYdMeo0BlZ12AxP8HslzvTQsNmqBdcw2jdAll7Cj8gxwsHfq9oy
         29r33DXuHsGkv7FN8sdFnCOj7TLS+U90S7bsNLnxgeuvJiC5lmRDXIA4mYmy7xMZsvrn
         zVfrh4WAPIjRt3F9wFOE1o221gluTJHUs+W8mYYLBk37bLUxFTCDeF2FmJxEOHVOz0Qd
         g0+YXD+NXYsu1SCb4irk6A9xGpABIMelbdbX9Rwg5K0nTTVz7Zy69c1jtnevAqaUF0Ux
         po14O5+TKbn5MEuIujbPEkPIqJvmdfQlm73CMrcOcAxOLknr9AQR7sVq4XANHo0yQDNx
         yr2w==
X-Forwarded-Encrypted: i=1; AJvYcCXD9eekeNzpdT/f6UnTZeOT+DimxElA9aQLX0o9nkjVfvYFi32/YP4Je+mAE28tStarN1LIEXou/nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrI8cPsQHIxZlPkOXwvQKeYx2xY3nt2//5ReS7axvvqwSN7aOv
	o7wqnAn4g1VywR82JoCx2vzs0XxHNz+ovYvnKMe+okd6FfMEylzxcp3EAuO0H9c=
X-Gm-Gg: ASbGnctNQ6uGE/tfcESbCoPkiUukAz4KE2e6DC3VfB/5BrQX2krCqV8u9I/oBjexBx/
	qC0ghzzL/3qruQY/aX7ChQxzgAEA4Cvdy3u1NR9HZvFqYMb+3lYzZU0dZezJ4ASUiCAswu3HjRL
	I+DR+whF9ll5mZa96TTmL/77Wc1/Z3eDBNgnazDMrBtRpb4XATwqek28LHB7FF6y58iWdhs50m0
	Lfen0Fu3pPA27P/tLYNGealPVpfc+dNIUCFH1QWFDydFZYvNaJ4VygPivhC0P4VgRi4wq2opxy9
	rMtKCNq9g9i6d3HgAA==
X-Google-Smtp-Source: AGHT+IFAE6Sn6ehxUhbxa1hhXPYtJRLeTycA+9uEO9r6sLALqgmws+wrmwT6XDj6fMYz7tvaubE3iw==
X-Received: by 2002:a05:6808:3403:b0:3e7:bcab:8f11 with SMTP id 5614622812f47-3f19fc84c34mr2086333b6e.18.1737136224641;
        Fri, 17 Jan 2025 09:50:24 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fa35fe0ad0sm863321eaf.31.2025.01.17.09.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 09:50:23 -0800 (PST)
Message-ID: <c7778b8d-abaa-47b7-834b-e62c30f6b8d9@baylibre.com>
Date: Fri, 17 Jan 2025 11:50:21 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/8] iio: adc: adi-axi-adc: set data format
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
 <20250117130702.22588-6-antoniu.miclaus@analog.com>
 <87a7f003f3b53c6b8fe762dbaa542111e57538fe.camel@gmail.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <87a7f003f3b53c6b8fe762dbaa542111e57538fe.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/17/25 10:20 AM, Nuno Sá wrote:
> On Fri, 2025-01-17 at 15:06 +0200, Antoniu Miclaus wrote:
>> Add support for selecting the data format within the AXI ADC ip.
>>
>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>> ---
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> 
>> no changes in v10.
>>  drivers/iio/adc/adi-axi-adc.c | 46 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
>> index d2e1dc63775c..3c213ca5ff8e 100644
>> --- a/drivers/iio/adc/adi-axi-adc.c
>> +++ b/drivers/iio/adc/adi-axi-adc.c
>> @@ -45,6 +45,12 @@
>>  #define ADI_AXI_ADC_REG_CTRL			0x0044
>>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>>  
>> +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
>> +#define   AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
>> +#define   AD485X_PACKET_FORMAT_20BIT		0x0
>> +#define   AD485X_PACKET_FORMAT_24BIT		0x1
>> +#define   AD485X_PACKET_FORMAT_32BIT		0x2
>> +
>>  #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
>>  #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
>>  
>> @@ -312,6 +318,45 @@ static int axi_adc_interface_type_get(struct iio_backend
>> *back,
>>  	return 0;
>>  }
>>  
>> +static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
>> +{
>> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
>> +	unsigned int val;
>> +
>> +	switch (size) {
>> +	/*
>> +	 * There are two different variants of the AXI AD485X IP block, a 16-
>> bit
>> +	 * and a 20-bit variant.
>> +	 * The 0x0 value (AD485X_PACKET_FORMAT_20BIT) is corresponding also
>> to
>> +	 * the 16-bit variant of the IP block.
>> +	 */
>> +	case 16:
>> +	case 20:
>> +		val = AD485X_PACKET_FORMAT_20BIT;
>> +		break;
>> +	case 24:
>> +		val = AD485X_PACKET_FORMAT_24BIT;
>> +		break;
>> +	/*
>> +	 * The 0x2 (AD485X_PACKET_FORMAT_32BIT) corresponds only to the 20-
>> bit
>> +	 * variant of the IP block. Setting this value properly is ensured by
>> +	 * the upper layers of the drivers calling the axi-adc functions.
>> +	 * Also, for 16-bit IP block, the 0x2 (AD485X_PACKET_FORMAT_32BIT)
>> +	 * value is handled as maximum size available which is 24-bit for
>> this
>> +	 * configuration.
>> +	 */
>> +	case 32:
>> +		val = AD485X_PACKET_FORMAT_32BIT;
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
>> +				  AD485X_CNTRL_3_PACKET_FORMAT_MSK,
>> +				 
>> FIELD_PREP(AD485X_CNTRL_3_PACKET_FORMAT_MSK, val));
>> +}
>> +
>>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>>  						 struct iio_dev *indio_dev)
>>  {
>> @@ -360,6 +405,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>>  	.test_pattern_set = axi_adc_test_pattern_set,
>>  	.chan_status = axi_adc_chan_status,
>>  	.interface_type_get = axi_adc_interface_type_get,
>> +	.data_size_set = axi_adc_data_size_set,
>>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>>  	.debugfs_print_chan_status =
>> iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>>  };
> 
> 

Since these register values are specific to the AD485X variant of the AXI ADC,
I still feel like it would be better if we added a new compatible string like
we did for AD355X on the AXI DAC.

These functions accessing the CNTRL_3 register aren't applicable to the generic
AXI ADC IP block, but only to the AXI AD485X IP core [1]. The AXI AD7606X IP
core [2] that we are working on also uses this same register for other purposes,
so we will have a conflict. We are planning on adding a new AXI ADC compatible
string for AD7606X [3], so I think we should do the same here.

[1]: http://analogdevicesinc.github.io/hdl/library/axi_ad485x/index.html
[2]: http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
[3]: https://lore.kernel.org/linux-iio/20241210-ad7606_add_iio_backend_software_mode-v2-2-6619c3e50d81@baylibre.com/


