Return-Path: <linux-pwm+bounces-4076-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 714849C624B
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Nov 2024 21:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299741F223BE
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Nov 2024 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1E2219CB2;
	Tue, 12 Nov 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PimX1dvG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E3217F28
	for <linux-pwm@vger.kernel.org>; Tue, 12 Nov 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442348; cv=none; b=T5Ui+VfJIhSly5cXhfRWBoa8L9NEUpijcoSlr9oY7WbmZfzUJpHUieEYJrOwS45CvEVqh7eZnE5Jf6LDdz8Y5WBkBYc9B5xW7yw+1SpghtBm3VeQp5Rn2z4V8mTQ1NbaRSAUwUr7nPAuSWhOToRYZRPuCxF4nj65H/OSae4holM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442348; c=relaxed/simple;
	bh=bPv/feaj5Glj0pCE0a7gtustT0zmFafSOmethJidReU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uvuUcrMztdw56a0LOYjflSgk0Ub9pLkiVzNF5XrC6B6NDy4H+gBQmow2f/XgEEHpssCmGJzWJIs/OKUkqMeXtI0cXP8lcbXuVWRRsScOnedDDzfT9vfy3sHhvG8J68tPYtDsJwSAuGKLWn7m4Vkl444LFdhIVhYivPmchTle0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PimX1dvG; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e60d3adecbso3268674b6e.2
        for <linux-pwm@vger.kernel.org>; Tue, 12 Nov 2024 12:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731442345; x=1732047145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dl6oW+royBVKzJh6c3nIJ5U6CjfR2o5cVhOS2LXCTeg=;
        b=PimX1dvG4+SY+HOhJqrNDzieDq007r98POZ9V4XmKYNGB3Eh9R1XmfKUXb5dgxfPaP
         w2i5UK7WMfg046ERjmeILTQOTTCQi7jmID5T3FnUOEs0Euk7bel3HThScgpHi7Mpxu+A
         3AirrmeEmB9fG5KKGfahPXtyqmMU0kUBcPVpZu7NZOxJIQt+GA+FYRd8y/tgALk1bfKH
         3ZmzK0NJ2xi1J1IFxxd3DtmwZ1ImrC2zIDJft38iPoC9YlmHp39+JhGpC5kF25ij/4l5
         fUeXmHUKHlr+YkTu4VXCgCdpDlCfBvu6K6sPq/fMxZVgAhVXzDgPOi8fkg99+w0y0He0
         xt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731442345; x=1732047145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl6oW+royBVKzJh6c3nIJ5U6CjfR2o5cVhOS2LXCTeg=;
        b=B6DrWTQrhcIFGTgX6M5LOUz0//wuLbdder8acP3SQVmJEX11CwF3yXDEYBgxcX8I/P
         ukUlLKUFuJlkoOJCFXepjxaD0OdyHJJGRwCdV/ck+xWtaBAkuT+DRCifQPujI6LRZHMo
         rARK25UDUiMMZ1ZZ+J16SSqV5LssUd5IiF4RWDF5JzfWDr7p9tMlKRluWUXao7p08uSc
         vPLqJgk8OB2cp913E440FK32td7/bycUd6ddgKaaSCEQpOlE9TlsLgLZpUnl1fSaNWXf
         3cn7w2I2ldhsyoHpTzNPEYMIe3LBflSNdT2Fgt6QQ7fx+Gqf3jl4SBRgTNh74Vtgiy8t
         jPWA==
X-Forwarded-Encrypted: i=1; AJvYcCV9FYiegaaCdKG5cIFP0IvuahQhpPdrybyHlSsGVzwm34FXlJpM+jzFZknYIoX103OnSII50KE+ixk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgMzjUyUquMq+LZW5j5C5eaUjnLDnbAM5Z2lEwuQEMdf5EHMnU
	yw5E/viJsWcVadr/m0BGj1czmdhfc+RyRusNUSdsrCAzYWr//nq2gpILXEw6j/g=
X-Google-Smtp-Source: AGHT+IEUK1lwL53dpSjHoatFyNXNN93/2KKOkopUDAWIapQKMOXvlEOPLtpAZYQbhUpekTLpeop8UA==
X-Received: by 2002:a05:6808:11c7:b0:3e5:d591:c9a9 with SMTP id 5614622812f47-3e7947031famr17094130b6e.26.1731442345040;
        Tue, 12 Nov 2024 12:12:25 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7b096b5dcsm47591b6e.20.2024.11.12.12.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 12:12:24 -0800 (PST)
Message-ID: <35d88f91-b4bd-426e-aa75-40741b8c3bd0@baylibre.com>
Date: Tue, 12 Nov 2024 14:12:22 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] iio: adc: adi-axi-adc: add oversampling
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
 <20241111121203.3699-7-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241111121203.3699-7-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 6:12 AM, Antoniu Miclaus wrote:
> Add support for enabling/disabling oversampling.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6:
>  - add support for oversampling enable/disable.
>  drivers/iio/adc/adi-axi-adc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 9bf967d5b730..8ec668f59c88 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -46,6 +46,7 @@
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
>  #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define   AD485X_CNTRL_3_CUSTOM_CTRL_OS_EN_MSK	BIT(2)
>  #define   AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK	GENMASK(1, 0)
>  #define   AD485X_PACKET_FORMAT_20BIT		0x0
>  #define   AD485X_PACKET_FORMAT_24BIT		0x1
> @@ -341,6 +342,14 @@ static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
>  				  AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK, val);
>  }
>  
> +static int axi_adc_oversampling_en(struct iio_backend *back, bool en)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +
> +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				  AD485X_CNTRL_3_CUSTOM_CTRL_OS_EN_MSK, en);

This needs FIELD_PREP() to apply the correct shift to en.

> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -390,6 +399,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.chan_status = axi_adc_chan_status,
>  	.interface_type_get = axi_adc_interface_type_get,
>  	.data_size_set = axi_adc_data_size_set,
> +	.oversampling_en = axi_adc_oversampling_en,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


