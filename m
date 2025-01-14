Return-Path: <linux-pwm+bounces-4631-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A10A1153B
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2025 00:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775B43A0FC1
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 23:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12582135BC;
	Tue, 14 Jan 2025 23:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn2EkO2c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429041C3BEB;
	Tue, 14 Jan 2025 23:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896757; cv=none; b=outbfDFrUJLXE3fUduk+gDWkJrKA4ymgoa3/pjv8NVHLrr3O+TBY6G3a3Yu3P8P8pyj/2Wnkmjtc3fSf5w9lemngeNTLHrBomT6uDPBYGyowsoaukF+efoPoscBGfYSQ0UWWsxL3m64PNNLh3QQQeVZf1OiceaKOiya1/KtFTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896757; c=relaxed/simple;
	bh=wCQCL7h8Rcfaq/OxBE75HxEi4RpscdUKW0u1K6btrOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N/Yf6i66wTRyDp4frE18ypCyUjjFb2tCjeK9LQT8+xaJjYcaVpi7VKyLEKHjyiEWTbBDy08ApiSwEEA5OvxOwGSozfQ5QmunhxG1yh4LtrtDFYePsBkIZ0INmCe2HOC1lgovzverdANxpKO8wBHvLxIc9+BKi0YnUAz2Yp0jfZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn2EkO2c; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166f1e589cso130233965ad.3;
        Tue, 14 Jan 2025 15:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736896755; x=1737501555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f5eTKAbfNWbx/YU36/7otlGNMn3vJ1aSKnUDn2lnA00=;
        b=Gn2EkO2c3XvGemt2jemmdxP/5ac2lq5PsFFtJnOC6l5O0w7Q0jaPcQWTZEqNbfkRkD
         1OD4docNjOkv62SHi/YoRwXdv9MIxMIs+3c2KdmQjKpMKg079tjVOpO0rx3pcM63GUMI
         vRSLOrjzCG9d5HdZ8d7ySSDG0Pzu8f5oq+UcWNNfmD64/IGKe+nKgTtmXpB6xx9rS15o
         ulC00pWvbnkCknQmei778ZK0GlIdjxe3EHKf+hHfGbTzXKoQhmDg8+/9XkuXR72TIQjW
         WArw80IFWIObB8MwT85olkBhmiZF3OuBVplOCIxA45PN+ypaz0gEfnY7EVzJvKHiMsIt
         F01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896755; x=1737501555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5eTKAbfNWbx/YU36/7otlGNMn3vJ1aSKnUDn2lnA00=;
        b=TJOVOoiWgxshuATA0qb4RMLAFIYs3gcnhavWhYnrAagQ+aKYIC20bfDWuB4WXuyUlf
         C2MgFz46IqEWB9WYeeNd8vBeo3oBGzBRZt4DKO4aY7BDpZaZF9ZPcgSfDZO3OEalHOG6
         zEMYQZyXNm+tqvKs0oqErivcxLPwdUeq2pgybXCrbTc3aBeMjI2nhPJrxweHZW8z51X3
         HGvETK08NbK/b58ZNF3NAJm4L5Z96Y0lWw1F4qkKyT1ovG8TlL4e2S2q1lX+79mKMaPq
         2nxILwoUnka+4xN20NY4PVSmhV1wQlczZQHmoi2mS+CauUrAnuWdpfHXU/IcHHyS4RAO
         fosA==
X-Forwarded-Encrypted: i=1; AJvYcCVoB2ouCWYlU+3V/iBManYsEgaN1wtboxUDnCDV7GUnVcNaoS5zn1TLH01RqiuH3BEF4U84n5REh3Kv@vger.kernel.org, AJvYcCWLjbfRjYfMl9YVQo+nhOB4d5kUJvYLlMGuRXDAiSvuqI3MZCHPgBhXFQzZvs9/E2DwEaE2tpN/8wng@vger.kernel.org, AJvYcCWzU3Ey9yTGZCnio33nNSWFthed2varAkSz8ZdJwEFyvC/ToUnLTjyKgtzRgJyQ0/IfG/MgsFQ6+ZYkjElj@vger.kernel.org
X-Gm-Message-State: AOJu0YykLWrVZQfkRa3S7jU3NIa1SYs7W76zNfWmbjMAiAGL16c38kcy
	uvufuaJgIq+sx2PD7qInIpZopt3jHvzC/Dj+M3jqPROe9y5IC25i
X-Gm-Gg: ASbGncufRgH5N+tq4dXOMx+Cr0BdMznEFNfQd6JCm8gD8G3O6hL3YkvlusTnu2zq44q
	hV7zQSZM9D4oIEoaxRVySbbC7s0QsKkRZRcMSkk3BoEFFM33XmARRAw4HKxDqKUhdT9XR0mSbkl
	iioQ38ahWVxb+7M2nrbyBxrVokTVlr2KWAn+uvX7I7AV1qWISJmT4GBglYWLVj8+UoDTYB00xo4
	pVxOjprcMWKSQvgkaGdnpVNPv9INPqahOSYd9oygEmNvFik/T9a1hJk52nwe7cfYg1L
X-Google-Smtp-Source: AGHT+IHvhFzdOuZJhvs41X/8XrZF9xVo0QVuW5f8A1eRLQV4vZJgXFT2cldJ2dy/GO1Wh/lGLTu/Og==
X-Received: by 2002:a17:902:f68b:b0:216:32c4:f807 with SMTP id d9443c01a7336-21a83fdea82mr421041255ad.45.1736896755413;
        Tue, 14 Jan 2025 15:19:15 -0800 (PST)
Received: from [10.69.47.104] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f256b4csm71720915ad.215.2025.01.14.15.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 15:19:15 -0800 (PST)
Message-ID: <c48d6cda-8508-46f9-92b9-6621b335b565@gmail.com>
Date: Tue, 14 Jan 2025 15:19:11 -0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpio: Use str_enable_disable-like helpers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Nandor Han <nandor.han@ge.com>, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 patches@opensource.cirrus.com
References: <20250114191438.857656-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <20250114191438.857656-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/2025 11:14 AM, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>     operator has three arguments and with wrapping might lead to quite
>     long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>     file.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v2:
> 1. Many more files changed.
> ---
>   drivers/gpio/gpio-brcmstb.c     | 3 ++-
>   drivers/gpio/gpio-crystalcove.c | 3 ++-
>   drivers/gpio/gpio-grgpio.c      | 3 ++-
>   drivers/gpio/gpio-mvebu.c       | 7 ++++---
>   drivers/gpio/gpio-nomadik.c     | 3 ++-
>   drivers/gpio/gpio-stmpe.c       | 6 +++---
>   drivers/gpio/gpio-wcove.c       | 3 ++-
>   drivers/gpio/gpio-wm831x.c      | 3 ++-
>   drivers/gpio/gpio-xra1403.c     | 3 ++-
>   drivers/gpio/gpiolib.c          | 3 ++-
>   10 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
> index 491b529d25f8..ca3472977431 100644
> --- a/drivers/gpio/gpio-brcmstb.c
> +++ b/drivers/gpio/gpio-brcmstb.c
> @@ -9,6 +9,7 @@
>   #include <linux/irqchip/chained_irq.h>
>   #include <linux/interrupt.h>
>   #include <linux/platform_device.h>
> +#include <linux/string_choices.h>
>   
>   enum gio_reg_index {
>   	GIO_REG_ODEN = 0,
> @@ -224,7 +225,7 @@ static int brcmstb_gpio_priv_set_wake(struct brcmstb_gpio_priv *priv,
>   		ret = disable_irq_wake(priv->parent_wake_irq);
>   	if (ret)
>   		dev_err(&priv->pdev->dev, "failed to %s wake-up interrupt\n",
> -				enable ? "enable" : "disable");
> +			str_enable_disable(enable));
>   	return ret;
>   }
>   
For gpio-brcmstb:
Acked-by: Doug Berger <opendmb@gmail.com>


