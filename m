Return-Path: <linux-pwm+bounces-484-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AEA80BADA
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Dec 2023 14:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5413C1F20EF9
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Dec 2023 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E515C158;
	Sun, 10 Dec 2023 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlc8w8ZY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E9ADB
	for <linux-pwm@vger.kernel.org>; Sun, 10 Dec 2023 05:23:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c32df9174so27591215e9.3
        for <linux-pwm@vger.kernel.org>; Sun, 10 Dec 2023 05:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702214595; x=1702819395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ys6A2Bha0yXRtHll/HjqncAoUZWbU49gkCF565FWhL4=;
        b=xlc8w8ZY0JO1ZQkG1n0GDDaOBWAxdOHDr/fYWPjsNoQg/7HufUKNqf/pmBiqWnMtOy
         3NY6tZffAiU2V9aaLJxFKbU7mMov2ecCIN1xvIOvy953JLyCf4vHW31QaaJT3XhqQX5L
         DGy4bGQTiCAm1VOZy8Xp0sMPDBoyQh/sc7iqfsZf8BucuOX1CMfYrYM4sunx4s8wlitW
         Uuugb/YhJH6wIfuSygg6+55RczlFDXBik7mTn+yKpeBu8IAGNm1y+5wRYUpl/cum8Sne
         tN6WmrO4P9GjtAcxZpiPNo+PhyYwkyGNxEg4oLAqs5buE8AMNkxVCdmf2TJ4BF2bP5fG
         srBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702214595; x=1702819395;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ys6A2Bha0yXRtHll/HjqncAoUZWbU49gkCF565FWhL4=;
        b=u84NVZvkxKUE9cMYnfNTAtLMC1czQeVtZOW94n+a7BVVh1lngh37oYCaYqYAEs0L15
         rgaKFhHnKFFaU1YC113YjPnjiT5cH7vHUmjFkYWuttnpkGF5xjf6FlRuRbBUrlKkuv8Z
         NQ53HOM1yMxWip6r48m3z16YW+Q+1j8g4qSIuc+4PbdCqvCs+xtzoAPOGx5lQuUmT3MP
         6M09CI59kQsto9v1lxbG5BT2kWYEhWnaUrF/2rmTRtEjwm5uFjnm1MGKUrgY99TJHnuO
         x0U6+b+8fQ9mMpawjGqD1rh3DpRYUIHzc3HpVzAkrf1/VW7zvT38oqxrZJYEj8KWbkI2
         yQ4g==
X-Gm-Message-State: AOJu0YxlCb9KYkjmUMSnQePy/LzLLfiKk5Yo0A7VrTJOUepZapz6GIKc
	FHiegIMMMT2it2ew5aJ0SSyCDg==
X-Google-Smtp-Source: AGHT+IHE+XN8qqfjxDFnbAFUBq0Iq6eZyQgnmvFnK1gHzcckGLMGEufL81rQf6ChstDr5+/uXcV2TA==
X-Received: by 2002:a05:600c:12c6:b0:40c:293b:ad47 with SMTP id v6-20020a05600c12c600b0040c293bad47mr1055887wmd.234.1702214595553;
        Sun, 10 Dec 2023 05:23:15 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id n2-20020a05640205c200b0055122551f98sm167656edx.6.2023.12.10.05.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 05:23:15 -0800 (PST)
Message-ID: <9d496fb5-25b4-4f1a-9652-4c54cf2d59a1@linaro.org>
Date: Sun, 10 Dec 2023 14:23:12 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] pinctrl: samsung: support ExynosAuto GPIO
 structure
Content-Language: en-US
To: Jaewon Kim <jaewon02.kim@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
 <CGME20231208075020epcas2p260c65fa8d33e0cd97806f065bb8a044d@epcas2p2.samsung.com>
 <20231208074527.50840-4-jaewon02.kim@samsung.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231208074527.50840-4-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/12/2023 08:45, Jaewon Kim wrote:
> New ExynosAuto series GPIO have a different register structure.
> In the existing Exynos series, EINT control register enumerated after

Missing verb... or enumerated is past tense? I just don't get entire
sentence.

> a specific offset (e.g EXYNOS_GPIO_ECON_OFFSET, EXYNOS_GPIO_EMASK_OFFSET).
> However, from ExynosAutov920 SoC, the register that controls EINT belongs
> to each GPIO bank, and each GPIO bank has 0x1000 align.
> 
> This is a structure to protect the GPIO bank using S2MPU in VM environment,
> and will only be applied in ExynosAuto series SoCs.
> 
> -------------------------------------------------
> | original		| ExynosAutov920	|
> |-----------------------------------------------|
> | 0x0	GPIO_CON	| 0x0	GPIO_CON	|
> | 0x4	GPIO_DAT	| 0x4	GPIO_DAT	|
> | 0x8	GPIO_PUD	| 0x8	GPIO_PUD	|
> | 0xc	GPIO_DRV	| 0xc	GPIO_DRV	|
> | 0x10	GPIO_CONPDN	| 0x10	GPIO_CONPDN	|
> | 0x14	GPIO_PUDPDN	| 0x14	GPIO_PUDPDN	|
> | 0x700	EINT_CON	| 0x18	EINT_CON	|

This suggests there is EINT_CON per bank in old and new register layout.
I don't think it's true, so probably this could look like:

| ---                           | 0x18	EINT_CON (per_bank) |
| ---                           | 0x18	EINT_FLTCON0 (per_bank) |
| ---                           | 0x18	EINT_FLTCON1 (per_bank) |
| ---                           | 0x18	EINT_MASK (per_bank) |
| 0x700	EINT_CON (global)       | 0x18	EINT_CON	|

etc..

Also, please use spaces for alignment in the table.



Best regards,
Krzysztof


