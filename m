Return-Path: <linux-pwm+bounces-4068-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3858B9C4356
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 18:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9DE28298D
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8ED1A9B37;
	Mon, 11 Nov 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vP/sPaGN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D11A725E
	for <linux-pwm@vger.kernel.org>; Mon, 11 Nov 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345248; cv=none; b=FLDnWBkpd0WbFlcH5h/SSm6l802WguXiyGF6PIUlGxCHRJ9QUN5VNHvr9pPSgXhEDy8CNHV8n3OlVeoqu4X5krHkvSYelWgjiOQwePcSUPyZejVwyUbVHDTAm991O81ZSMqjK7vCiK3dx/KlQLAmGJPukLnQ04chc4kPu6fGPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345248; c=relaxed/simple;
	bh=3Q6uao6+hgf+7cigQULGQb1eC8zzAjVmlImprrPNtzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W9+NB5NPe4vZlX+k4ayUiLLLsoW4LjWXdOS+BpeyQ+bzB/l8psYGFM0skxx9YP5j+mXD88RxexuTCiO71Z90jBA3rCH1wvpHL214h3/+uKwVTh9hxS0PZp1xyM8lQD/zIcMSNRVEnWcQhhytkijQzQvsTN5N6aUUx6MGnqjGQqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vP/sPaGN; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ec4a40e95bso2138345eaf.1
        for <linux-pwm@vger.kernel.org>; Mon, 11 Nov 2024 09:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731345245; x=1731950045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHhQX9dLBXKUZ4ddho1L9OkyErwYL/K98ij6HZC9tXE=;
        b=vP/sPaGNvx7/JZ2s6B8A3tuoVFOk/HmiRoDniCZKagcUlX9iJR0+hb+aamlmx37RJM
         SGW9214YoxjwmpqcMY/+ILdA22HOoJXJR9R/odOWP+qAdLv1kx4Rza8TgdzPX+gcnuDY
         /Zi+zF1AUi0hbNurxi1Oe5sSqc+y6t42l4uaoaYsEggtNCN4xMHHSujI69GsimI0YFD/
         RZCAnV1LZ4na/f543PWameCQAdjofAlMQU1IYlAf2per7vnyg6EQyj49LfI/YZnIY2ai
         YkxorNwTaslEz8f4S1RvTWxM9tk//XvDDzepqXsCLBH34H0iR3EAmNl6Pve8xxhe+KWD
         a7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345245; x=1731950045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHhQX9dLBXKUZ4ddho1L9OkyErwYL/K98ij6HZC9tXE=;
        b=DxmqP6gf6JUSncdJdsAzLGdROPfnBjJbvJod4bgueC+10ZkuPh14xJHj5DFbOd3fps
         wUctrnIas7fEuDi3VDovz7+rVvOSpThD6nsmm3kt8cc2RWfrmuxZJ+VjtC1ngEBUi7PJ
         eVPYo5nbu2a9lreWOiXQ1Z1iMGE61tmIHSVOmr3abcfBzdpoI8O/IqA5Hp612g3D93k5
         RMGTx9En0ug4xJIiv077RtKsYBIYfUJLYTJ1GBlqSGY2NXGWalfxoe8o6oWfWYWkGn5o
         If5qjUeERbaTfWP6NHRz8sLNC1lzA4mHcanvquILthdAol/4dvn1t8Ht/hij4NN/1dDp
         osuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb10soMhiB5sjlD+V7dvHh2EFznGwYEKGwJhNL4zSgtZFzBcEOZJr0wZQ8P1/5y7Vd4XeNHEHuTPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjnLcLSmrP+g4Ao20yAugTMqy2Zb8WLu93Fig70n0v+XfXQ/c
	4Emgx/EUoi0x4MAtkmEmFaVVGIGZE+IcZoEHqbHt8jQeRPSZJMcm6YNaRVxd1j0=
X-Google-Smtp-Source: AGHT+IF3GCiZjWfr7xWBoGgZ81GYnxm9pAH/iF3fOY2T/R1DiZIJojhpwe+oKLoYI62MFyjsBFrMIQ==
X-Received: by 2002:a05:6820:1f08:b0:5e1:e748:7ad with SMTP id 006d021491bc7-5ee57c77c36mr8888000eaf.7.1731345244850;
        Mon, 11 Nov 2024 09:14:04 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ee496afdd5sm1993171eaf.31.2024.11.11.09.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:14:03 -0800 (PST)
Message-ID: <66b3e462-bb17-4806-b991-8f0eb33b1233@baylibre.com>
Date: Mon, 11 Nov 2024 11:14:01 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 02/15] spi: add basic support for SPI offloading
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
 <20241026160521.52205cb0@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241026160521.52205cb0@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/24 10:05 AM, Jonathan Cameron wrote:
> On Wed, 23 Oct 2024 15:59:09 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> 

...

>> +struct spi_offload *devm_spi_offload_get(struct device *dev,
>> +					 struct spi_device *spi,
>> +					 const struct spi_offload_config *config)
>> +{
>> +	struct spi_offload *offload;
>> +	int ret;
>> +
>> +	if (!spi || !config)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if (!spi->controller->get_offload)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	offload = spi->controller->get_offload(spi, config);
> 
> Why let this return an offload that is already in use?
> Maybe make that a problem for the spi controller
> Seems odd to pass it spi then set it later.
> 
> I.e. have this return ERR_PTR(-EBUSY);

I would expect that to effectively be handled by the
if (IS_ERR(offload)) below. Only the controller can
know which offloads are already in use, so the callback
should return the appropriate -EBUSY in that case.

> 
> 
>> +	if (IS_ERR(offload))
>> +		return offload;
>> +
>> +	if (offload->spi)
>> +		return ERR_PTR(-EBUSY);
>> +
>> +	offload->spi = spi;
>> +	get_device(offload->provider_dev);
>> +
>> +	ret = devm_add_action_or_reset(dev, spi_offload_put, offload);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	return offload;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_spi_offload_get);


