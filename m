Return-Path: <linux-pwm+bounces-787-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3DD82D5E0
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jan 2024 10:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA7AB20E89
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jan 2024 09:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83588C8EA;
	Mon, 15 Jan 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eM+1O8qo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD069C2CF
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jan 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2dc7827a97so79289766b.2
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jan 2024 01:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705310804; x=1705915604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHhsOVyVdum5BvTOU6puggsd8m+EmQHCPAae0qxBHok=;
        b=eM+1O8qoYVWHLGppTh0DgOpG1prTuSz9KMkLlzq6medGv6IfaprzC5wwrkjJEH2vlr
         ZwTxBpaTuiLYHUjoAhwb9gqBvr8dHOaF5lmDCdmtmJtPNTA+Bro049ivVR4WBa1QkMGC
         xk4quZV3SahIcTmaHv2tlwXR5QT7t2s9HZR3URxJO26vMNaxCNFSynrB56B2dSMxlBCH
         +hOSoTJYoX7/YrOhJWBLxtGAD3h0G3AcJZkP7L1aLuls8dBGh1c4YbKvsFDo5QBxS5/o
         84e1nEfU1tFX9cdgF9s2wYAzPMQUojjcEUkep/28Vpt3EvHfQ53lN3ZlSCMbtoRwNqxQ
         6NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705310804; x=1705915604;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHhsOVyVdum5BvTOU6puggsd8m+EmQHCPAae0qxBHok=;
        b=D57+s8lx9lmioAKOvZo539lUHFG1I0mNHy1PVjQm7BqDO+IjSo+4w/f0z9XtDGxV0M
         9HWnfaPWimKEjZ1SznzMKBEwBnZj04T7mEdExYhcWsj53HJCBc2yTQlbhjhFwVUI0I4j
         z9BssIc5Vf3yjhXgVjpit6ITHJLmjJSI5ePwTW5dvrGATWee1kPNMgL02OOyBt3eYrJI
         K5p53uiAQPcKV7XJ0YPHZPM4wjLCjtbJ1EdL/w66khTCpeXydvqvFGUeOnaH93UI8Hti
         lZTigrOVGLb2Mdmo6UGpb+GtQHx1+f+8WxI4MHvFn9Wobtw+laljoDiUYRrvoyfNw7GI
         DK/Q==
X-Gm-Message-State: AOJu0YwKj28QFOCck3zrcWDDkqGMjd4a0+vZfjocBb35ONLCrOMa1APO
	/b9HEj1FniwDRtZD3RHGoAAvEEna9tIFPA==
X-Google-Smtp-Source: AGHT+IH7cZL8diFYSaoGSTkZ0mpTzMbH5ut90Gi/coaMPo1tndTeyRADHfIre2mkNCxz1dCGRtEkYQ==
X-Received: by 2002:a17:906:360a:b0:a2c:55f1:ca14 with SMTP id q10-20020a170906360a00b00a2c55f1ca14mr2020858ejb.119.1705310804110;
        Mon, 15 Jan 2024 01:26:44 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id ks19-20020a170906f85300b00a2b086c29e1sm5049162ejb.127.2024.01.15.01.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 01:26:43 -0800 (PST)
Message-ID: <c4550e34-17c8-4c67-9483-d654aa051d2d@linaro.org>
Date: Mon, 15 Jan 2024 10:26:41 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Content-Language: en-US
To: Billy Tsai <billy_tsai@aspeedtech.com>, Rob Herring <robh@kernel.org>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "joel@jms.id.au" <joel@jms.id.au>, "andrew@aj.id.au" <andrew@aj.id.au>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "naresh.solanki@9elements.com" <naresh.solanki@9elements.com>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 BMC-SW <BMC-SW@aspeedtech.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>
References: <20240108074348.735014-1-billy_tsai@aspeedtech.com>
 <20240108074348.735014-3-billy_tsai@aspeedtech.com>
 <20240113015556.GA3829553-robh@kernel.org>
 <OSQPR06MB725208AEF8779B0BC971DFF48B6C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <40210196-3852-4c8b-94e6-e744890f003f@linaro.org>
 <OSQPR06MB72520BD77D68B7940273F2498B6C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <OSQPR06MB72520BD77D68B7940273F2498B6C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 09:43, Billy Tsai wrote:
>>>>> +examples:
>>>>> +  - |
>>>>> +    #include <dt-bindings/clock/aspeed-clock.h>
>>>>> +    pwm_tach: pwm-tach-controller@1e610000 {
>>>>> +      compatible = "aspeed,ast2600-pwm-tach";
>>>>> +      reg = <0x1e610000 0x100>;
>>>>> +      clocks = <&syscon ASPEED_CLK_AHB>;
>>>>> +      resets = <&syscon ASPEED_RESET_PWM>;
>>>>> +      #pwm-cells = <3>;
>>>>> +
>>>>> +      fan-0 {
>>>>> +        tach-ch = /bits/ 8 <0x0>;
>>>>> +      };
>>>>> +
>>>>> +      fan-1 {
>>>>> +        tach-ch = /bits/ 8 <0x1 0x2>;
>>>>> +      };
>>>
>>>> NAK on this based on how you are using pwm-fan in v10 discussion. See my
>>>> comments there.
>>>
>>> Okay, I will merge everything from the pwm-fan0 node into the fan-0 node
>>> and add the 'simple-bus' to the compatible string of the pwm_tach node.
> 
>> What simple-bus has anything to do with it? This is not a bus. Just to
>> remind: we talk about bindings, not driver.
> 
> Hi Krzysztof,
> 
> If I want to create a dt-binding to indicate that the child nodes
> should be treated as platform devices, which will be probed based on the

probed? Bindings do not probe. You ignored:
"we talk about bindings, not driver."

> compatible string, can I add "simple-bus" for our pwm_tach node like the
> following?

No, because this is not a bus.

> pwm_tach: pwm-tach-controller@1e610000 {
>         compatible = "aspeed,ast2600-pwm-tach", "simple-bus";
>         reg = <0x1e610000 0x100>;
>         clocks = <&syscon ASPEED_CLK_AHB>;
>         resets = <&syscon ASPEED_RESET_PWM>;
>         #pwm-cells = <3>;
>   
>         fan-0 {
>           tach-ch = /bits/ 8 <0x0>;
>           compatible = "pwm-fan";
>           pwms = <&pwm_tach 0 40000 0>;
>         };
>   
>         fan-1 {
>           tach-ch = /bits/ 8 <0x1 0x2>;
>           compatible = "pwm-fan";
>           pwms = <&pwm_tach 1 40000 0>;
>         };
>       };
> Or do you have any other suggestions for describing this in the dt-bindings?


There is no need to describe it in the bindings. The existing compatible
describes it sufficiently. Your pwms now duplicate the tach-ch... I
don't understand what you want to achieve here in terms of hardware
description (again, please steer away from talking about Linux drivers
and probing, it's not related).

Best regards,
Krzysztof


