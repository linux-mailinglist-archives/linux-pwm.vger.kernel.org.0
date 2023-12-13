Return-Path: <linux-pwm+bounces-549-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F572810C2B
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 09:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053D71F21118
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0BA1C6B0;
	Wed, 13 Dec 2023 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6svnmOL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A3EA
	for <linux-pwm@vger.kernel.org>; Wed, 13 Dec 2023 00:15:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40c31f18274so61776545e9.0
        for <linux-pwm@vger.kernel.org>; Wed, 13 Dec 2023 00:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702455301; x=1703060101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qg3/WicGNss8PVwXMd3IQ5VkA5POBdOm00ZLLplNk0c=;
        b=V6svnmOL88xQzTZfH519kujJKQ/gTVu8lmwnjaJR2LnQ3uTyeUn0aiboWiBWvbZPHx
         6vdkmLZsWIkN/eZgKj1Du23S/jf25C08D3DkdENAUphWIKvWdsmUxQ1jIbzaYW5YkYo8
         VeztNJuR0CYhRawGkoPRL8Gqi4K5tfdyafwxHkGr8vTXcTESLPGjTGNDu31ECCxXWKnW
         cr1vu3IWanxmIfpu8618HVilEzmDqKxSEMyAAvyNTotClKP+Ko0FdRUWR57OvvvD7w4M
         WtQ5js74bwbVxwZhBirWT62wMnOFRnoFbu4LYqUbRCPItzMD3KMAGcxgC822Hfl8Ke5d
         btcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702455301; x=1703060101;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg3/WicGNss8PVwXMd3IQ5VkA5POBdOm00ZLLplNk0c=;
        b=NuXHynSBuaP92RgHs2UPBZ2okaihQdEcumgJSvYiMCrYQBInG924D2lkYW7p+1LGlf
         ScWkdajFe1jtnNlHwRZqr9lw5oS3lMiaEgHcSDZ2l56kkzlEJOn1o1fiXwEEboMxvMAv
         IOv04/PooF32sdSZi4zloLLn3mq4GZTIRovSLJWxEanPeepjO3yTLe3IF0VVHAFY2DNH
         Pfm5I55J6URH+xJKNa1qR2B4dCYD2uNVFHskLLGTtPrPb5e+P/Ku9UxbJny4rx/Wi6fR
         1fJbS9utpCHCEwjYZFMMQ8P35hOyrvdoaxo5r51FMyWESdSuoz3qAJc9Kj9x8HLbcHvW
         P15w==
X-Gm-Message-State: AOJu0YyqHp85vuldprFWFECQBWwsnQiU0HSHwRv/35Bym7oF4IJA1wSB
	aqn2DY6CWGxhg6h5vi/tfbAX4w==
X-Google-Smtp-Source: AGHT+IE+1ybGpmC3Q6g+PK76bHek4m+qQOoFEixKP3L8sgol4mgPhnbNJ71Wa2eZphaS9dfl9+twmQ==
X-Received: by 2002:a05:600c:3589:b0:40c:35b3:b7a5 with SMTP id p9-20020a05600c358900b0040c35b3b7a5mr3710867wmq.11.1702455301066;
        Wed, 13 Dec 2023 00:15:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id l12-20020a05600c4f0c00b0040b4b2a15ebsm19441678wmq.28.2023.12.13.00.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 00:15:00 -0800 (PST)
Message-ID: <a26032ca-1a05-43a9-b6e6-7240193db79c@linaro.org>
Date: Wed, 13 Dec 2023 09:14:58 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] pinctrl: samsung: add exynosautov920 pinctrl
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
References: <20231211114145.106255-1-jaewon02.kim@samsung.com>
 <CGME20231211114216epcas2p300bbf4c592d495991c6cc2d96e0b1f85@epcas2p3.samsung.com>
 <20231211114145.106255-3-jaewon02.kim@samsung.com>
 <68a36910-e528-45ff-8b59-e7cd95aaef0b@linaro.org>
 <2b72464e-d60a-6adc-0ef7-ed92ff495859@samsung.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2b72464e-d60a-6adc-0ef7-ed92ff495859@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/12/2023 09:10, Jaewon Kim wrote:
> 
> On 23. 12. 13. 16:52, Krzysztof Kozlowski wrote:
>> On 11/12/2023 12:41, Jaewon Kim wrote:
>>> Add pinctrl data for ExynosAutov920 SoC.
>>> It has a newly applied pinctrl register layer for ExynosAuto series.
>>>
>>> Pinctrl data for ExynosAutoV920 SoC.
>>>   - GPA0,GPA1 (10): External wake up interrupt
>>>   - GPQ0 (2): SPMI (PMIC I/F)
>>>   - GPB0,GPB1,GPB2,GPB3,GPB4,GPB5,GPB6 (47): I2S Audio
>>>   - GPH0,GPH1,GPH2,GPH3,GPH4,GPH5,GPH6,GPH8 (49): PCIE, UFS, Ethernet
>>>   - GPG0,GPG1,GPG2,GPG3,GPG4,GPG5 (29): General purpose
>>>   - GPP0,GPP1,GPP2,GPP3,GPP4,GPP5,GPP6,GPP7,GPP8,GPP9,GPP10 (77): USI
>>>
>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>>> ---
>>>   .../pinctrl/samsung/pinctrl-exynos-arm64.c    | 140 ++++++++++++++++++
>>>   drivers/pinctrl/samsung/pinctrl-exynos.c      |  23 ++-
>>>   drivers/pinctrl/samsung/pinctrl-exynos.h      |  25 ++++
>>>   drivers/pinctrl/samsung/pinctrl-samsung.c     |   2 +
>>>   drivers/pinctrl/samsung/pinctrl-samsung.h     |   1 +
>>>   5 files changed, 190 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>>> index cb965cf93705..a998c296dd05 100644
>>> --- a/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm64.c
>>> @@ -796,3 +796,143 @@ const struct samsung_pinctrl_of_match_data fsd_of_data __initconst = {
>>>   	.ctrl		= fsd_pin_ctrl,
>>>   	.num_ctrl	= ARRAY_SIZE(fsd_pin_ctrl),
>>>   };
>>> +
>>> +/* pin banks of exynosautov920 pin-controller 0 (ALIVE) */
>>> +static const struct samsung_pin_bank_data exynosautov920_pin_banks0[] = {
>>> +	EXYNOSV920_PIN_BANK_EINTW(8, 0x0000, "gpa0", 0x18, 0x24, 0x28),
>>> +	EXYNOSV920_PIN_BANK_EINTW(2, 0x1000, "gpa1", 0x18, 0x20, 0x24),
>>> +	EXYNOS850_PIN_BANK_EINTN(2, 0x2000, "gpq0"),
>>> +};e
>> Applied with re-ordering it, to keep it after ExynosAutov9. For the
>> future: don't add entries to the end of lists because it causes exactly
>> this issue we have here: unnecessary conflicts. Please keep this rule
>> for entire development, not only pinctrl.
>>
>> If both you and Peter were observing this basic rule, I would not have
>> work of reshuffling and fixing conflicts.
>>
>> Please check the result if I reshuffled/solved conflicts correctly.
>>
> 
> I thought the new SoC should go to the end, but I was wrong.
> 

Peter's Google's structures went to the end, which was actually
alphabetical. You also added to the end thus git could not apply the
patch. Even cherry-pick had troubles, so I need to manually copy code
from downloaded patch. That's the main reason of not putting stuff to
the end, but to some logical place, usually alphabetical.

Best regards,
Krzysztof


