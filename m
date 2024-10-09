Return-Path: <linux-pwm+bounces-3572-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BF1996ED0
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 16:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C282842FB
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA56199FB4;
	Wed,  9 Oct 2024 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GQk9j3dN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5289B1A303E
	for <linux-pwm@vger.kernel.org>; Wed,  9 Oct 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485640; cv=none; b=bzlyGOzG9SlsikrJGJ6lTohiM0ucG9SumKsJc/ZHj2IlPckeXq+ZtsSRreTXWyEYMmS8I1qx44ZRTKxownSwXdwfmGJgp9AeLP9W3xq41vk7ob8f9F14PZSh2XTSTNj8+m0PNED+A/GTn1HKS4abYiP12SFTofbZNw4qluauA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485640; c=relaxed/simple;
	bh=Wcp+GqMmu1q63H/YE6QHbhgPAIl3ZjKVz6SCpWyow9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cML1vG99eUlZ9QaG8cctMrCEDpqNytqWWJIbwd8nEO5BYQb+aBYqS4IJmAWcRiVW1krKy5LWyMv+aTP2GUgaiDmfMRIgsHHo/jvvS2q7gyuP4GEDjrVsuw5s0BLzhZV7Iot2MleYvgsKYBbk7723O0l+dARfF8My/NqrBowHoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GQk9j3dN; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c924667851so566337a12.3
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2024 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728485636; x=1729090436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+H0kOFP4T6igJRfk2BDJYURUAXD48fpn61B4tvG4AaA=;
        b=GQk9j3dNZD8m37cnWnX8dl3uhCDRwTxXvvkI0LffXg3uHbvkhXPlMMNACl7/1oJTRN
         yiVjoAUWDBunpylxOVj8pfD6wzFZA7Tl0Fdr0kX/NUnfey/qOclZplOjCvNOZtguXC9F
         piQXEirzYCvDtHopOptlVJ7KHL0hlNM9p8TaWJw/Q7pOFUhVqoNrldyHio2KhD179+d+
         YD0xJN6YYQlXEFVPSYMItFqIMxTvCf1vtBbyI9R80lNL8albUhn7PysZZJ/UobtDq7V5
         9ii/lo0gMCDej1l0OBW0dLwiECrvn2s77cu1/I6aiI9bT/ha5fLRJyh9sVc4L59J1I9O
         CzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485636; x=1729090436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+H0kOFP4T6igJRfk2BDJYURUAXD48fpn61B4tvG4AaA=;
        b=jT8Wv4XsY8oYIMj8934JdB9Feav8riYTBPcqwh30DoOGwgYu/HRFu4A0qbMRmJoE9V
         RXzwrjRm5zT2+gnSukb2VFUxfkEui3vMypIJzU6fOGl7LPr6Vy0Ab2Qo21OvJHkkWEmk
         P+GojQBQZ/t/FQnxNNOPGaF3dCsIDnvivzko7lETlGgb7JVwATJr9lucHBxgXI9KEdEx
         6aJC2C53aTRQWpDD6/Uq3ZamJf4AiLYYKKdjTpXQKo8uTd3q192KJ5aLktg261eZNGhN
         9xzuAWdnkD8Uxs/68GiDIDoVU0Hcmitw4jASM7wB3UMFsjPVxcBG17WA7ocbabyTVzCm
         9J8A==
X-Gm-Message-State: AOJu0YxMfJcnqZOvmoaUEUToyN4k54L5dP5PyDEjBSM+FKMEzHe8X6RN
	mdN/GulbVuGVvMIq3VRSZnlRvwjOuM1jbi7fgvVgaDYfFyIbNTlT90arMgoRwYg=
X-Google-Smtp-Source: AGHT+IEmgayneaJS0wgjiRp3q+Nwt/ZLsb7/5QU2fJv3JVDDkUIOa2C5YBb0EWyjxUDT/pKbrEA38A==
X-Received: by 2002:a17:907:1c18:b0:a99:4d7f:138f with SMTP id a640c23a62f3a-a999e6e1ba1mr35003766b.29.1728485635259;
        Wed, 09 Oct 2024 07:53:55 -0700 (PDT)
Received: from ?IPV6:2a04:cec2:b:1ea2:d913:e3ce:8fdf:8180? ([2a04:cec2:b:1ea2:d913:e3ce:8fdf:8180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9958923911sm403787966b.190.2024.10.09.07.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 07:53:54 -0700 (PDT)
Message-ID: <d1229162-b97b-4261-9c4a-e1f83ef14378@baylibre.com>
Date: Wed, 9 Oct 2024 16:53:52 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] iio: adc: ad7606: Add compatibility to fw_nodes
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
 <20241009-ad7606_add_iio_backend_support-v4-5-6971a8c0f1d5@baylibre.com>
 <facfe06f51a815f4ff5604aeacd8bd6ed0629be4.camel@gmail.com>
Content-Language: en-US
From: Guillaume Stols <gstols@baylibre.com>
In-Reply-To: <facfe06f51a815f4ff5604aeacd8bd6ed0629be4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/9/24 16:39, Nuno Sá wrote:
> On Wed, 2024-10-09 at 09:19 +0000, Guillaume Stols wrote:
>> On the parallel version, the current implementation is only compatible
>> with id tables and won't work with fw_nodes, this commit intends to fix
>> it.
>>
>> Doing so required to declare ad7606_chip_info structures in the .h file
>> so to make them accessible to all the driver files that can set a
>> pointer to the corresponding chip as the driver data.
>>
>> Signed-off-by: Guillaume Stols <gstols@baylibre.com>
>> ---
>>   drivers/iio/adc/ad7606.c     | 283 ++++++++++++++++++++++++-------------------
>>   drivers/iio/adc/ad7606.h     |  32 +++--
>>   drivers/iio/adc/ad7606_par.c |  30 +++--
>>   drivers/iio/adc/ad7606_spi.c |  96 +++++++++------
>>   4 files changed, 254 insertions(+), 187 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
>> index 5b276d087ec3..dfbdea8c28ba 100644
>> --- a/drivers/iio/adc/ad7606.c
>> +++ b/drivers/iio/adc/ad7606.c
>> @@ -78,6 +78,155 @@ static const unsigned int ad7616_oversampling_avail[8] = {
>>
> ...
>
>> +const struct ad7606_chip_info ad7616_info = {
>> +	.channels = ad7616_channels,
>> +	.init_delay_ms = 15,
>> +	.name = "ad7616",
>> +	.num_channels = 17,
>> +	.oversampling_avail = ad7616_oversampling_avail,
>> +	.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
>> +	.os_req_reset = true,
>> +	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
>> +};
>> +EXPORT_SYMBOL_NS_GPL(ad7616_info, IIO_AD7606);
>>
> Maybe my eyes are tricking me but I'm not seeing any MODULE_IMPORT_NS() in the
> drivers?

Hi Nuno,

The ad7606_spi.c and ad7606_par.c use MODULE_IMPORT_NS(IIO_AD7606).

Chip infos are used in the "coupling" structures, e.g:

  static const struct ad7606_bus_info ad7616_bus_info = {
      .chip_info = &ad7616_info,¬
      .bops = &ad7616_spi_bops,¬
  };¬

Guillaume

> - Nuno Sá
>
>

