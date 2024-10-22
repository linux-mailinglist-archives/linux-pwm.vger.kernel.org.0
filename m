Return-Path: <linux-pwm+bounces-3757-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D80D9AB869
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 23:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B421F23F85
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 21:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D536C1CCEED;
	Tue, 22 Oct 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fqsh8Esd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13104130AF6
	for <linux-pwm@vger.kernel.org>; Tue, 22 Oct 2024 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632140; cv=none; b=t+UrCWYrKjUGeGDs4xX4G/AWzjv2UYQCdc+dyTdii0B1RZelqOgjGfUbTKexftPlROhwNS/jtc+19nS0tJZdGKElpkUBJLIPmDaDiTFbqixcwIeIifH4DKId0fukD0wnFXPh35qk1vUlvfrNk1x5AlsUbzkumZiMLxh9g9J5mUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632140; c=relaxed/simple;
	bh=+YYH5lgcgAAaWaHi+QEZ+cdfVTHaJNkCs4qgJ5a/kQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=diberuKV0dCKLEbJ37GWyhSWvXeUYKk6quQ7oMwrvyS8MKP0SJNh/hvlvMiz0q1AipSj/rRenvMIzUjV3W3LYBj0MRnil/JNttkj43v8mqp20Y1LqJsYN6VUmiT894JdxqT1rqRpAUect4SfdVeRk3XHWE7PfaD9yiy6lT0zKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fqsh8Esd; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-718123ec383so3103085a34.3
        for <linux-pwm@vger.kernel.org>; Tue, 22 Oct 2024 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729632137; x=1730236937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kRXTgQ4kD13MzuhZYlApMraa0F9l/eY7TJeEM2D+iLw=;
        b=fqsh8EsdQBerPS2D0z7zu3qr4h5LJDlvdDYscINk7WggoFfEMxJGneRbUjvv+si82H
         dLIBLS+jZnukIYI641NVQlF3jn6rQorjF2vsHIXUuTWtuwkhGVcN5NuDs0ur2M7D3G+N
         SxuhchHep3dHHZOQF9sTGoH8zUCqcU9FPUFnUctz+OkfXvnAMRM5fyhMyQactrP3Suic
         FxKhGjKLdXUzqoeBolWXvsLm+6BwficOxfeQjpuAPsxzJd8TuNv7drj2UatX1B16q3Br
         q7AHyHC+ivWSkiSBtZNzESHKI01/2ex+yyt03Cc/AAaKf5YakZ+2ktUvnqmrKy+hEa7v
         jE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632137; x=1730236937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kRXTgQ4kD13MzuhZYlApMraa0F9l/eY7TJeEM2D+iLw=;
        b=KfkpzuLI6zOxXgeGgiJYb3wzS0A5lWE4uiixotzBsOd0VNogBX8fbP800Nv9K0IpBQ
         BPpf5LwnPSmmZ1UDi7Y9cChIePbkCMgedbLyrhjYiYIPGrYahFTNbc8X6iaKcPycHKiN
         NMUTZz6Eytlo83R8XrYU9JBOZv1Dc9Ez+d+APUDyE1lw/QlXLNZOd8srjCV4EKeSga3N
         HX7L8dzYhLk88NN0wciOeR2oXu9It0DZHW2qv65J30BnXqLLG8fr4ztN5viRNFVWLgGN
         DhTJ9KLsg+XJmrI2Vi2t9GBf7efT/g9DErhDLIpNnFu13TKIQj6n9LwAVnxI+50zTtPE
         WnhA==
X-Forwarded-Encrypted: i=1; AJvYcCUN3Z01//jPS1rQxppWPWD16vh7GBF5HOU8KFfSL5p2h/RrTLCs+3O7Cw7E5FW2rOF2aBPTMjBIyg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/mwoWopooOC8gXsYTpYgE6K4q9oO63cfiT5UzDozjPl26Z0nI
	kOzeTFnLa5f583/DEaJNkeLxD8Ozt0NxsaO7gYDwd0ceJpdhk/3X0BvWUTcNXFU=
X-Google-Smtp-Source: AGHT+IE8vnvbyO1Ahx+nEmiTVW8i0jHcIewmd1FWR1wF8TmYYeJLFJS/8BBtpEfwgmyTIgpcHmpmCw==
X-Received: by 2002:a05:6808:4482:b0:3e6:0:f47c with SMTP id 5614622812f47-3e6244eeb13mr509721b6e.9.1729632137230;
        Tue, 22 Oct 2024 14:22:17 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6102e26f5sm1475150b6e.19.2024.10.22.14.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 14:22:15 -0700 (PDT)
Message-ID: <4d32a462-7a9d-4170-a01d-9de258231fd1@baylibre.com>
Date: Tue, 22 Oct 2024 16:22:14 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] iio: adc: adi-axi-adc: add interface type
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, nuno.sa@analog.com,
 conor+dt@kernel.org, ukleinek@kernel.org, dragos.bogdan@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241018104210.51659-1-antoniu.miclaus@analog.com>
 <20241018104210.51659-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241018104210.51659-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/24 5:42 AM, Antoniu Miclaus wrote:
> Add support for getting the interface (CMOS or LVDS) used by the AXI ADC
> IP.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

> +static int axi_adc_interface_type_get(struct iio_backend *back,
> +				      enum iio_backend_interface_type *type)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_CONFIG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val & ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N)
> +		*type = IIO_BACKEND_INTERFACE_CMOS;
> +	else
> +		*type = IIO_BACKEND_INTERFACE_LVDS;

These should be the more specific IIO_BACKEND_INTERFACE_SERIAL_CMOS
and IIO_BACKEND_INTERFACE_SERIAL_LVDS.

> +
> +	return 0;
> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -285,6 +307,7 @@ static const struct iio_backend_ops adi_axi_adc_generic = {
>  	.iodelay_set = axi_adc_iodelays_set,
>  	.test_pattern_set = axi_adc_test_pattern_set,
>  	.chan_status = axi_adc_chan_status,
> +	.interface_type_get = axi_adc_interface_type_get,
>  };
>  
>  static int adi_axi_adc_probe(struct platform_device *pdev)


