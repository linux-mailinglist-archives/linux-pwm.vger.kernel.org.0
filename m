Return-Path: <linux-pwm+bounces-689-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE618263C2
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Jan 2024 11:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26516282183
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Jan 2024 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E612B92;
	Sun,  7 Jan 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B5zJxXaU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6C2CA5
	for <linux-pwm@vger.kernel.org>; Sun,  7 Jan 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d8e7a50c1so12905095e9.2
        for <linux-pwm@vger.kernel.org>; Sun, 07 Jan 2024 02:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704623417; x=1705228217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6FcraxlGE1/DMmhL0QqfoIXdq5XuF0l5shF76vlze0=;
        b=B5zJxXaUNnMM58P/gKXyvZK5I1kqK/D70SfXFq2MdXIHp9viHySxODcCELxSwioc3+
         ooPocT1GrrD+/CKv6g0Qrf4Y3TsgVbZDYtPUmNXJz1ZN9Z3qr/Oe+g21z4lCN1TshrLq
         BGH5Xo214HWPrMZSdj17YderosXIN3sXoBgEHxCedObajVjcrjaTooaNlSP1uJX7lQxC
         e6CgOvEazUOD2fdubp/y2G8zNADQ0cy425haxeF+oODR2OkFc0nhU3RM+7Z6XoJN3j+f
         gg5cEvEKL23dowJ0/IGwwcQjB0GTKZoq/9Y21EyCENjP82GTp7vjmUuTOVZ12CHcJgMM
         BDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704623417; x=1705228217;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6FcraxlGE1/DMmhL0QqfoIXdq5XuF0l5shF76vlze0=;
        b=C++Fek/lAHaTAAJDa2IeJV8Owrdu6uYxDA7/kV7S3D+kw2E8NYDVJwsrNzGeqVkfkP
         7/mNIhbCZ9AoJogYc6y0ATTCZoMnyDLJbZb2dfM8LHYCcOCno7wDynFnY0Bk38tBc3zG
         IHVhiuU6r0+eh8cAo1NrKWGH7pdQ4XXvff1o4t4wfn0VKCwPcYysji1joyoc/O2BJsXe
         I6kLZ3CR40+kBOxZ+zR3JgSp/dm/g4g4FM0gEj1BoYPtJrGXxvlhHnBAlF5IVBPuApq3
         j/li+FI50AV7MssYzmud6CbrxaiDdRNB20HCDjTnE6RMEJWH4o8bNO5+AGTPbQrWVKVV
         V2YQ==
X-Gm-Message-State: AOJu0YyA8zvhUVIgjXccyk/QSaNQ3AE9PMod1Q60hrI+0qrIlGn6EaGz
	BUTRtMNaQdoVE8VJFiYvPsBmJc+vyr4L51iHI1P4mXWi5GQr2w==
X-Google-Smtp-Source: AGHT+IH6RM5E1nwg/foTgnT2LoBhhDt/Lz5BV6jgjqYVzskptkwkhVI2cX2dwIC0HCiRt3QB/gWadA==
X-Received: by 2002:a7b:cc99:0:b0:40d:88ba:130a with SMTP id p25-20020a7bcc99000000b0040d88ba130amr881874wma.206.1704623416863;
        Sun, 07 Jan 2024 02:30:16 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906615200b00a28ec89674bsm2918334ejl.173.2024.01.07.02.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 02:30:16 -0800 (PST)
Message-ID: <210132de-a46b-4f9f-8546-0c36d8a34665@linaro.org>
Date: Sun, 7 Jan 2024 11:30:14 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pwm: rockchip: Allow "interrupts" prooperty
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Johan Jonker <jbx6244@yandex.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-pwm@vger.kernel.org, linux-rockchip@lists.infradead.org,
 kernel@pengutronix.de, devicetree@vger.kernel.org
References: <20240106142654.1262758-2-u.kleine-koenig@pengutronix.de>
 <7dea73a6-d733-4cd2-b2d5-02f09e2a6dd9@linaro.org>
 <94ad0f59-4095-40ee-963d-4ac379fc8852@yandex.com>
 <cvvifoctmgdsgqfadqbhgywfw2ff57fz33w26hghf5kyo5j5sw@mj75xtvczr2h>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <cvvifoctmgdsgqfadqbhgywfw2ff57fz33w26hghf5kyo5j5sw@mj75xtvczr2h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/01/2024 00:25, Uwe Kleine-König wrote:
> Hello,
> 
> On Sat, Jan 06, 2024 at 10:25:10PM +0100, Johan Jonker wrote:
>> On 1/6/24 18:10, Krzysztof Kozlowski wrote:
>>> On 06/01/2024 15:26, Uwe Kleine-König wrote:
>>>> This fixes the dtbs_check error
>>>>
>>>> 	arch/arm/boot/dts/rockchip/rv1108-elgin-r1.dtb: pwm@10280030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>> 	from schema $id: http://devicetree.org/schemas/pwm/pwm-rockchip.yaml#
>>>>
>>>> in several device trees.
>>>>
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> NAK
>>
>> There's a reason why this isn't implemented before:
>>
>> [RFC PATCH v1 1/2] dt-bindings: pwm: rockchip: add interrupts property <https://lore.kernel.org/linux-rockchip/ed3df2c8-ffb5-1723-0ed7-3a2721972852@gmail.com/#r>
>>
>> https://lore.kernel.org/linux-rockchip/ed3df2c8-ffb5-1723-0ed7-3a2721972852@gmail.com/
>>
>> [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for rk3588 <https://lore.kernel.org/linux-rockchip/20220901135523.52151-1-sebastian.reichel@collabora.com/#r>
>>
>> https://lore.kernel.org/linux-rockchip/66b5b616-ae9f-a1aa-e2b5-450f570cfcdd@gmail.com/
>>
>> [PATCH v1 03/11] dt-bindings: pwm: rockchip: add rockchip,rk3128-pwm <https://lore.kernel.org/linux-rockchip/f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com/>
>>
>> https://lore.kernel.org/linux-rockchip/946d8ac2-6ff2-093a-ad3c-aa755e00d1dd@arm.com/
>>
>>
>> On how to correctly model the DT with common interrupts , PWM and one shot as a sort of MFD etc there's no consensus yet.
>>
>> Leaf it as it is till someone made a working driver demo, so that the coder is free to model a DT solution that fits to him/her.
> 
> Having the warnings until this happens is bad though. If describing the
> irqs in the schema is considered wrong, we should remove the interrupts
> properties from the device tree sources.

I think the previous thread mixes bindings with driver. Does the
hardware have interrupt? Yes? Add it to the bindings. No? Don't add it.

However Johan's reply is saying something about driver, so how is it
related?


Best regards,
Krzysztof


