Return-Path: <linux-pwm+bounces-1902-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 417D88A1F3D
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 21:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE49C1F268CE
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 19:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494421754B;
	Thu, 11 Apr 2024 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wa5izdlx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43D205E35
	for <linux-pwm@vger.kernel.org>; Thu, 11 Apr 2024 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712862658; cv=none; b=Y56HXa2lDqg6cHy7gVJoJk2mC82SdujsgU9ygCxNYh2612zq6e4BVbKJ1xM8Ewar3mtdJi+lo/elL7P7Q172qTtzIbL+nx+lREtFdal3Roesw8nKlpA/gY6cSIEuLHaUvzdPgMth+6/zmwzo21EDCy17PKXypggz7dOrYwAfzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712862658; c=relaxed/simple;
	bh=fuQvFrGXXjJVqZYrBWPT8FzS4z7oPtg+2qAYwRGI3p8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCDXsdsDmUkmDQX5R37IMk4gGLjwOXE/ovjeW52OoEOzBHCtajllxAfYLKXBaYZKrSmneBdUeePsn2cX2lXUp/hNYChQ/M8eQWE/MbjSuj+sa7lCZKXCMAsR8Ae4/ePLA1Lr1RFzNEiqpuALkokB1VTFR/UDKgssoEDF4wa+DHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wa5izdlx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4167fce0a41so7162465e9.0
        for <linux-pwm@vger.kernel.org>; Thu, 11 Apr 2024 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712862653; x=1713467453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BoYaazQjD0tvXqOZypnTJqg/fbRzZsuu2W5M8fTRcss=;
        b=wa5izdlxojI+6goDY+YAlrc2JTfy56azsyfRBA/dXYX9oAE80T0ogiSocJfu3sOGER
         OwaFnqGXdpPN7GZrg6X3VQF2dGzxYjyRSPU+d5j/mPEalv78QiXXzyCMp+uyiEeuJVjV
         ZLWU6NBOm3lG+Y4U/smEZBSDyxIUSW2wFXeFneITG9u4ZNgSJC8V2kfUH0Hpb78KQEcO
         k9urSH8ZDxZVM6RTtV7ZW9X8Tl5/xfF6/adawBmHCCfJ17O6x6gec9BHjZHTp2U1DbVG
         KGoX1KWoEgRONlpCiHwhetZb3ZTu4BtnOhiPUhbfHHJS5dUtUeY1FxVi37eezmMaPB3d
         nPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712862653; x=1713467453;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoYaazQjD0tvXqOZypnTJqg/fbRzZsuu2W5M8fTRcss=;
        b=e4KvPOZXJxVHqIvk9loAsDJNPhLb03nrWGixBFwonwRJ9sL8cPSQnKa88HYwHZOZ5K
         IT/FomcxCIOx9I7ILhj07bA+dA0OrbFGHbsk3aRQESzqCW7NyZq2essmzrjRnXDPGO6s
         5Pc9mmyFQMtEPtr+978rrSs3CNHsNck9gqowrfvIdPJRhrFGzPXtqdTOSedP6QAYFjOG
         Mw4ZnB/GcwHKW9/JcDP5qcBfqTLy+cmrM7rNlpqEAFcasvQ91T/aM6H3UaxA7eQ/PVyM
         +VgP2fbg5FyvP6JnxXUVmrZ0mHYIgTzzY/2I3zqS5cAKlQmhSxN9ldqSbqGuGOJpz2VH
         qjIg==
X-Forwarded-Encrypted: i=1; AJvYcCVfFmpOT2r2tjzeqvc20Fn4NI9Ug2rv+9pX9XxArLWeF8GRoFSVG0Trtftg11ndEEcVV+XWmEfNCQZlaZf0tabIAzVJjWsaCBGw
X-Gm-Message-State: AOJu0Yyy3GrAG7g96ACOCs7smy42GMIMZQFpQMK72ItBKLY9BhsdCs9u
	p6Cpa9+J940z1iJ2hiBMK3Jyt6HZGKBhTcYLAHVuYRyfqBVA14Ei9ga9WcH3RKQ=
X-Google-Smtp-Source: AGHT+IGNwRUeyUvir55Byrpd3SEPNB7KQCbiphw8y28HpOspgFi8BwSF67pPoL4qOgdRrKMeeL3lOw==
X-Received: by 2002:a05:600c:35c5:b0:416:69cf:d5f8 with SMTP id r5-20020a05600c35c500b0041669cfd5f8mr3467918wmq.6.1712862653510;
        Thu, 11 Apr 2024 12:10:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b00415dfa709dasm3185355wmq.15.2024.04.11.12.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:10:52 -0700 (PDT)
Message-ID: <bb250368-d1d2-41dd-abef-ae505a4a5d33@linaro.org>
Date: Thu, 11 Apr 2024 21:10:51 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add Loongson PWM controller
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Binbin Zhou
 <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Juxin Gao <gaojuxin@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, loongson-kernel@lists.loongnix.cn,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
References: <cover.1712732719.git.zhoubinbin@loongson.cn>
 <38c234d548b4b9c334cda6e7664a803896b31f6f.1712732719.git.zhoubinbin@loongson.cn>
 <c1399191-6c6d-4eb4-b05b-f87a9f2b4152@linaro.org>
 <CAMpQs4JiLGJ-nBDmj1pe0SCqKeCnz5DrybJAKE8_6up293YNpw@mail.gmail.com>
 <98d12a5e-e291-40f9-8334-3b5f53ed79a8@linaro.org>
 <CAMpQs4KgzOjJe52BAhTb5P4t5ZynkW9AUEzPBkX_1h5XHuk5Ew@mail.gmail.com>
 <b551f712-ed95-4d90-b0fd-7cf471bc9eee@linaro.org>
 <k2v7ibfc5vjprfw6gvrcelbknhxqf7mnybsnbb2avj6qblkmqz@graeaj372hcg>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <k2v7ibfc5vjprfw6gvrcelbknhxqf7mnybsnbb2avj6qblkmqz@graeaj372hcg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/04/2024 17:21, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Apr 11, 2024 at 04:44:37PM +0200, Krzysztof Kozlowski wrote:
>> On 11/04/2024 16:35, Binbin Zhou wrote:
>>> On Thu, Apr 11, 2024 at 5:07 PM Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 11/04/2024 13:01, Binbin Zhou wrote:
>>>>> On Thu, Apr 11, 2024 at 4:26 PM Krzysztof Kozlowski
>>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>>
>>>>>> On 11/04/2024 11:16, Binbin Zhou wrote:
>>>>>>> Add Loongson PWM controller binding with DT schema format using
>>>>>>> json-schema.
>>>>>>>
>>>>>>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>>>>>>
>>>>>>
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    oneOf:
>>>>>>> +      - const: loongson,ls7a-pwm
>>>>>>> +      - items:
>>>>>>> +          - enum:
>>>>>>> +              - loongson,ls2k0500-pwm
>>>>>>> +              - loongson,ls2k1000-pwm
>>>>>>> +              - loongson,ls2k2000-pwm
>>>>>>> +          - const: loongson,ls7a-pwm
>>>>>>> +
>>>>>>> +  reg:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  interrupts:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  clocks:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  '#pwm-cells':
>>>>>>> +    description:
>>>>>>> +      The first cell must have a value of 0, which specifies the PWM output signal;
>>>>>>
>>>>>> If you have always the same value in PWM phandle, why encoding it in the
>>>>>> phandle in the first place? What's the benefit of passing 0?
>>>>>
>>>>> Hi Krzysztof:
>>>>>
>>>>> My thoughts are:
>>>>> First of all, our pwm has only one output signal, so it can only be 0.
>>>>> Also, as you know from the pwm xlate function, the first cell is the
>>>>> pwm index, so I fixed it to be 0 here.
>>>>>
>>>>> The xlate function:
>>>>> https://elixir.bootlin.com/linux/v6.8/source/drivers/pwm/core.c#L106
>>>>
>>>> You refer for xlate for PWM with three cells. You do not have three
>>>> cells, as you have only on signal, so why insisting on using other
>>>> xlate? Do you do the same for clocks? Or resets?
>>>>
>>>> I don't think you use appropriate argument in this discussion. We talk
>>>> about hardware and your argument "I don't want to use my own xlate in
>>>> the driver" is about driver.
>>>>
>>> Hi Krzysztof:
>>>
>>> Thanks for your comments.
>>>
>>> Emm... Indeed, I used to think about it from the driver's perspective.
>>> From the binding perspective, two cells really should be more appropriate.
>>> I try to make the following changes in the next version patchset:
>>>
>>>   '#pwm-cells':
>>>     description:
>>>       The first cell is the period in nanoseconds;
>>>       The second cell flag supported by this binding is PWM_POLARITY_INVERTED.
>>>     const: 2
>>>
>>> Accordingly, the custom xlate function will be used in the driver.
>>
>> If your other, upcoming variants had more PWM outputs, then I would find
>> reasonable keeping cells=3 to have one approach for all of them. But I
>> guess that's not the case here.
> 
> There is an easy way to get rid of the 0, just use chip->of_xlate =
> of_pwm_single_xlate; Having said that, I don't particularily like that.
> If it wasn't for dt bindings being stable I'd argue for all PWM chips to
> use #pwm-cells = <3>; and accept that the 2nd field is zero for
> consistency.
> 
> Some statistics:
> 
> There are only two drivers that use of_pwm_single_xlate:
>  - drivers/pwm/pwm-pxa.c
>  - drivers/gpu/drm/bridge/ti-sn65dsi86.c
> 
> There is one driver that uses a completely custom xlate function (and
> #pwm-cells = <1>, to specify the pwmid; the period is fixed):
>  - drivers/pwm/pwm-cros-ec.c
> 
> All 65 other drivers use #pwm-cells = <3> with the "usual" semantic. At
> least 21 among them only have a single output and so always use 0 in the
> 2nd cell.
> 
> So I'm all in favour to stick to the approach used in this binding for
> the sake of consistency among the drivers^Wbindings.

Seems fine, thanks for the explanation.

Best regards,
Krzysztof


