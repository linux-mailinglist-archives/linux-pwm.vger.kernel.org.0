Return-Path: <linux-pwm+bounces-5930-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA4AB3BC1
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2063B6BA7
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5146322A801;
	Mon, 12 May 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X6Q0cNIx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C341EF09C
	for <linux-pwm@vger.kernel.org>; Mon, 12 May 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747062946; cv=none; b=BiIrIAOok16aZXfB6oQikiovDNnsytSDVh4fiM7/w8m9SZ4TphS9FMzvru5MEl2a6K9zgW4O4IaX2TAvcdT2wRo2QkT2AyGtnGIRsidKQnsZuMU8ADl8F5atcG6MlftxShWoQBtUp7a9Xi/bbEUPy9FXyCWEPJLe4Uxi6IsisJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747062946; c=relaxed/simple;
	bh=zF4PQS8RQFM30N3ao4kEuN2RsoQHNBfVK/8QGFaitO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjaHdJKkQvAYUnAW4l61ga9sL4lRDy8l8lnjyScPcqu/JLv6R5Xn2yZGW9znc4XvpaC5oycc6p+OgFXzEmnfkE8xADOxCI3NKL28wpmhsXyk1HKnkPh05tSma1H4fFPKFtKp8FHK0DR6OZdy/FQeDmXZ+bRRPU5vr5/RoFoYZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X6Q0cNIx; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b268e4bfd0dso2185128a12.2
        for <linux-pwm@vger.kernel.org>; Mon, 12 May 2025 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747062944; x=1747667744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0n+Mfncf1dF7UbdvMh/Y3Vkt6ppEmOAhKQI7/Xctfs=;
        b=X6Q0cNIxd650TbJ3+C16tdoIHcelXc4Go4sMm4iVA+lSi4T4cuhUL7v89ECkbXOAi0
         pmyC0zogwwrbTFsEeeFSM8C77vJGWGvX1I2u13zitf0QIhJh37LGqxzWd6/o0z+xRZnA
         gAohUaHdfO5RZdgiqqDUK9LT7dJef4wsjcVZnhbhexX2yBbamnXgF+JMuJMrag5rOHyx
         Jgf/Am/YY3pkXKddWVFq1i6xqHrKSq3weHCXY/cxodjuiSch/4Blf38kXWbIlTfaeHIR
         myr33ZNo+uXsF4V1xQcgamLL8FNV2N+y+SON9opLGmKGQ/7YPQJC80wKUJ/VIGQ6nLPq
         DsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747062944; x=1747667744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0n+Mfncf1dF7UbdvMh/Y3Vkt6ppEmOAhKQI7/Xctfs=;
        b=C8q30INWpi4iocSpBIOOi1dnqWiQvtoOfgmr3iWmgWyPKAbl6GUq5a+6MxYhQws0XX
         QjAI/aN4Pi0W0s56YmJCQ/nOlqBRfA7Q6VKxO79kUl4F4mFA+FTyFgp6Loitc2i282xM
         KScKYYqurRLJjKwxsYDeW1k15YP2TCBw66ZafG6AvZ8xuPTERkRsfdUmDKS4O6e5TK4U
         KLGokZjHFxlXgvR+iDkYqloXStfqjz2y8NdpuQNBLymYgse/0wNUQEthjbDKk6neq7rx
         1qP3V/py+Lu9XYRDsI7q4a4KaSHjD1deaHNM8Wko0cwSpyjL+8mGxt1bT0Vueox8w6r0
         oGNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX/C74nBLVanBIdCLfE12QwQ23O9vunUy+yCuf4HfTEZHmu6cLpdp2DPhF72/OIReUOfzRY5TT0w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVM/QcTMVrt67Bf6spCrhmeJrGW4s7vxsbj6A3GMK4A9SGSg1
	u4Y5IaiLHjRADzv5OiYaY/XcTC0FI2+mVl0VUvSPAfKYKE0E8fx7ZXjIxwtAfpz0STLnP7m8d82
	y
X-Gm-Gg: ASbGncu5ROiAaD+fYppFHz8wgYTxKewEBV90CweypjhzowV6LT6QTp211xkmS0M8Fs2
	xG0l1f2flVX8ClZjzzDhrfvFIM5u8QuXE6tuNAjthZk9nc2FpW9ETSxbwlvMt3SuV03kV88VZqY
	eGz6mPtkI1GdJy+2z601V/U57YlhlbLtKNYFa9sjPEVVpGW2YKO9tMp6wLGzBPU2Yul/0UyAvi5
	JJhP6ChFserookSxh53hf6mtd1agMWfh59LG34KB2Xk78ezkb0H9ohUm+GnhauDPFQZexEsJYiS
	u4vllVywOOXyw0Sa+jmpXOpcrbKDxhVVCuNw29UI9gECUS/AQjBw3nbodgGE4v/zSPCCenM266S
	XWM2GW3MkokCf7pJyzvNEmlBN5fkGOP7YDXwuIj8=
X-Google-Smtp-Source: AGHT+IHZGDRNs+8vOMkC0p04fQzG/ssmfSh7XZKqv3ixjm0TN3TuT3LuzzKvBaCQb7HZ2b2RSV9r0w==
X-Received: by 2002:a05:6808:1582:b0:400:fa6b:dc93 with SMTP id 5614622812f47-4037fec216emr8370575b6e.39.1747062932740;
        Mon, 12 May 2025 08:15:32 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314? ([2600:8803:e7e4:1d00:fd2e:ffda:4c42:b314])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-403802d369fsm1565218b6e.17.2025.05.12.08.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 08:15:31 -0700 (PDT)
Message-ID: <44929bd2-4abf-4c7b-b3c0-382bd030800f@baylibre.com>
Date: Mon, 12 May 2025 10:15:29 -0500
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] include: linux: move adi-axi-common.h out of fpga
To: nuno.sa@analog.com, linux-clk@vger.kernel.org,
 linux-fpga@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Moritz Fischer
 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Tom Rix <trix@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com>
 <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250512-dev-axi-clkgen-limits-v5-3-a86b9a368e05@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/25 9:46 AM, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The adi-axi-common.h header has some common defines used in various ADI
> IPs. However they are not specific for any fpga manager so it's
> questionable for the header to live under include/linux/fpga. Hence
> let's just move one directory up and update all users.
> 
> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/clk/clk-axi-clkgen.c              | 2 ++
>  drivers/dma/dma-axi-dmac.c                | 2 +-
>  drivers/hwmon/axi-fan-control.c           | 2 +-
>  drivers/iio/adc/adi-axi-adc.c             | 3 +--
>  drivers/iio/dac/adi-axi-dac.c             | 2 +-
>  drivers/pwm/pwm-axi-pwmgen.c              | 2 +-
>  drivers/spi/spi-axi-spi-engine.c          | 2 +-
>  include/linux/{fpga => }/adi-axi-common.h | 0
>  8 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
> index 2a95f9b220234a1245024a821c50e1eb9c104ac9..31915f8f5565f2ef5d17c0b4a0c91a648005b3e6 100644
> --- a/drivers/clk/clk-axi-clkgen.c
> +++ b/drivers/clk/clk-axi-clkgen.c
> @@ -16,6 +16,8 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/err.h>
>  
> +#include <linux/adi-axi-common.h>
> +

This one is adding, not changing. Was it supposed to be in a later patch?

>  #define AXI_CLKGEN_V2_REG_RESET		0x40
>  #define AXI_CLKGEN_V2_REG_CLKSEL	0x44
>  #define AXI_CLKGEN_V2_REG_DRP_CNTRL	0x70

