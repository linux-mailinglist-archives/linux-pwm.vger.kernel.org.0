Return-Path: <linux-pwm+bounces-7436-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA7BCDF12
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 18:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A14189F43F
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Oct 2025 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CB72FC00F;
	Fri, 10 Oct 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k7VErcXi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A991F37DA
	for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760113109; cv=none; b=q5AiigsOKbn1rDUrDe4x9ad3KRGYdedEWswBLDv2mqFDGR4fVkPwur52ezcGEbs6v4/bWz9ESC2RGSelupcbRk/zRw6ND6kESfoYM9hNiglqVsluAjsitzWiozpGl/wANftmjUxTRYIfCZ1JLH0NA8ApJBSuob1EpDDoHCOzzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760113109; c=relaxed/simple;
	bh=FdYPXGm9deiD/Trs9cMfHlp7XbwPhfQIT9v/Wdt5nis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eq/QS6/7nxMNbsVuyZU03C33m5GWOiqUuXBJA7Wk6IFShXb5OgCsLLbK7d82Zt9j0f9iPfyZSWMRfaHXE83We0P88qWJw2v5biWqJ2jY6LcjTa8tFJFsWcCb6WH9vi/995pwDicFmduG5OgPoUKQDwIpHaZHbb3O8KnovIKQsww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k7VErcXi; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-649a715fcaeso581030eaf.3
        for <linux-pwm@vger.kernel.org>; Fri, 10 Oct 2025 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760113105; x=1760717905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9w68CQXC1xPR3gkxyDZirmm/itUJmtRYjrTWc5to35A=;
        b=k7VErcXiTSdSzA6bGBoScVNFENhUJPpJdaonLVk1Ps7NKthqAs3DTmZDCzckX/9dZ9
         gSHcKUynJ/G9OXQmWDE7pyKmvpPSJqihJsM6bEWkHAV3hCWq9kDE0ZuEWrjRK+PvEDxo
         zRqc/M/biXlD9FKLj2nHqIbxYAq7pjIt+AmLyk9U/hpPxKB2QyoD1Qfni+cmwNTd7KJe
         BiCdQ1DXKh6/smn0eWVowYxolCtYC6ZNHRL6nPWLp9dwWO6/6U+inw2iO7WuG7zmKhsP
         2x5ohFXFx53uczpwjTAXhfKiNfhC0atvYktW4UhPheAvh8cNVv9RG/7PmtMvsdncyTi7
         ZvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760113105; x=1760717905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9w68CQXC1xPR3gkxyDZirmm/itUJmtRYjrTWc5to35A=;
        b=IRHGk/k9MTuO+29wUz/abr27Vdz/Q8e3RoK0VrgkAUI8slj3TYpXWZNt3Ca3WoYxwa
         2gpX0piCnZ3ruv+AwjbCeEoInCzgDzzwBOEt3MGhpIroK68t6yL7jeWK1175oq0443cb
         abxtdGz0ul/VKU2gdae3dWNuPcdBa6FUsU7Ad5JhTq7Kh+zL8Wm7ai+zdVtw3IVGZrsD
         pDt75zdtqDDf7MgeGaR9PvbvaSsH3ajqPXGJSG0jmpAkHKCtFqGoMzNWrfZlUTWG9epf
         ZBR7enisNLroRgm5KSsxCfc5iepp/W8Bf7YRU8uQwDPPWGU88ihGMO9BM1NKBwCv72Ay
         xUHw==
X-Forwarded-Encrypted: i=1; AJvYcCUTPtBovnwO9Du5bf77cxaMXMSdWjN2P0GJ3VoQhg8XgEUTvgZe2Gk0E3vi0TdL7iV2ytYnxXrc/PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzNjPgKgrIjdEayWADJuroeRDFtNT/gx1Q19bUKUgnkmvJ7+h
	vF3xw9nxfy+8jfrkTAENnhSBGwmtuWXieVOP79PbnGrwOxcVZcH+27l/S+W2GGP02vA=
X-Gm-Gg: ASbGncutoPIQ4KSVI+e4mQTf3mOB24r1XDAWhGAFpP6cHW0kvS51OlkW5fdKQ5COgtu
	WgkUxsr7oeU/7m6oZb/Ux68mTeOhzCQGxI6gKUk4gDH25P/r/zj8GKtPrLbCISOO3SzCbxoCDG5
	zUkftbm/0pZgfyPzXYfugARE3JFiKC7L9JjSG2VDxvYCi1Er7OVF3Wu95Ol+F05Yq2l46Rv02Ce
	2IR6fIMQXRRiEkQyy7RZ172li2bgl9f2/1sbj93glUz4UuUvNDMMV3HlzSYL3dCWnN793FW1+FI
	z8xyFUWdYB943m2G4xj2sA3p1u0FyeheLrl3wrDaUwMCDn8qHWXlT5dnGZx3adl4hsWuRi1L5Ys
	ifmF8IfIlhYKg0TGuiJSAaT5HA8yF1dml2eMK2AZQu2cTj/yzF9ERSREwfqUVinwsUE14POYWLP
	UhYAUqngo4nMsJxEg=
X-Google-Smtp-Source: AGHT+IHd0omg/rlvWPFBEqlcSVQAWZIDB8yoaKyD9jCTVYWmDrXVdGmrtHcE+pAoTAHuCLm4ZKiTag==
X-Received: by 2002:a05:6871:6d12:b0:31d:7326:c3a7 with SMTP id 586e51a60fabf-3c0f9e6cf08mr5691630fac.41.1760113104781;
        Fri, 10 Oct 2025 09:18:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6d3b:e3bd:4210:32e2? ([2600:8803:e7e4:500:6d3b:e3bd:4210:32e2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c8c8ae1de8sm1007500fac.4.2025.10.10.09.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 09:18:24 -0700 (PDT)
Message-ID: <576b582e-7388-4ee4-9a4c-4f7e04fc3fda@baylibre.com>
Date: Fri, 10 Oct 2025 11:18:22 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] iio: adc: ad4030: Add SPI offload support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com,
 nuno.sa@analog.com, eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
 marcelo.schmitt1@gmail.com, Trevor Gamblin <tgamblin@baylibre.com>,
 Axel Haslam <ahaslam@baylibre.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
 <a86007ab148f9556af032f5ba61991a74a5641c0.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a86007ab148f9556af032f5ba61991a74a5641c0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/10/25 6:19 AM, Nuno Sá wrote:
> On Wed, 2025-10-08 at 10:51 -0300, Marcelo Schmitt wrote:
>> AD4030 and similar ADCs can capture data at sample rates up to 2 mega
>> samples per second (MSPS). Not all SPI controllers are able to achieve such
>> high throughputs and even when the controller is fast enough to run
>> transfers at the required speed, it may be costly to the CPU to handle
>> transfer data at such high sample rates. Add SPI offload support for AD4030
>> and similar ADCs to enable data capture at maximum sample rates.
>>
>> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>> ---
>> Change log v3 -> v4
>> - Applied code adjustments suggested to SPI offload patch.
>> - Only select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM).
>>
>>  drivers/iio/adc/Kconfig  |   3 +
>>  drivers/iio/adc/ad4030.c | 504 +++++++++++++++++++++++++++++++++++----
>>  2 files changed, 465 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 58a14e6833f6..1ed091b6731a 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -62,7 +62,10 @@ config AD4030
>>  	depends on GPIOLIB
>>  	select REGMAP
>>  	select IIO_BUFFER
>> +	select IIO_BUFFER_DMA
>> +	select IIO_BUFFER_DMAENGINE
>>  	select IIO_TRIGGERED_BUFFER
>> +	select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
> 
> Two things as I mentioned in [1]:
> 
> 1) Wouldn't 'imply SPI_OFFLOAD_TRIGGER_PWM' accomplish the same?
> 2) Don't we also need stubs for spi/offload/consumer.h?

It doesn't hurt to enable SPI offload support even if no controller
supports it, so I would prefer that drivers that use it just select
SPI_OFFLOAD.

> 
> [1]: https://lore.kernel.org/linux-pwm/2e82eaf275b5c8df768c8b842167c3562991e50c.camel@gmail.com/T/#t
> - Nuno Sá
>  

