Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA27EA445
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Nov 2023 21:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjKMUHZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Nov 2023 15:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKMUHY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Nov 2023 15:07:24 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FF510E0
        for <linux-pwm@vger.kernel.org>; Mon, 13 Nov 2023 12:07:18 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77897c4ac1fso312798485a.3
        for <linux-pwm@vger.kernel.org>; Mon, 13 Nov 2023 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699906037; x=1700510837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1jEPxeJGtmfYQcT6WJ61rN62rCZrCVcvumNLFWoazM=;
        b=lpnWA4rrbI4/BxmLreczJpZj2sAnKeZJ9JkwPIoDFobq3hil9xvq7VVuwpr04YTqMP
         5Ob2TsQZSLYGg+IoIXyz+smur7MOrv62y5/nToPh5+96Jtf1w3CQcmWPWPxoqYzm+9Gk
         5C0DVYwk1lrxTSs/yywgxnJX/hHwIA/RK2sb2aAJlrIA2eP0ekwO7KPcuTeLQqVh58HU
         ZfcsunrOBkKuv4RdBJIT4SlHh8L3ynSCCr8Pz4/Dz6gu90EiHiwdn3L7cU9aY3jk0P7u
         VLQ3g827nqGeEhVgTNK1PQc3bRov7R08oCv+t1vxE9K1q8iBAHFFKwGi6p1cAjFrx5Zu
         5lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699906037; x=1700510837;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1jEPxeJGtmfYQcT6WJ61rN62rCZrCVcvumNLFWoazM=;
        b=PBQVMQcsyyZoM8UiRxyuowyGiDIg58pP6sd8nn92q+g4IdRojJsvw69stHVTnHKk1g
         5QvIxovpmEE+TjyOXmHpVvaeJhhUGOpn+2qR+G+ztEnAaj0blcdwIPFCPUDd4RjV/0RN
         /nLN7Mr0qypl861cdEYMgYboeMZPDTIFvBiJ5pwM+98P8iBOD7GIbxLJ1F/3j00yX4zm
         c79wAd6bvV+vAdOlFIAuFn5jffSVrtU6E+nXDeolKU9fvHx4Xtybhl4ckj7HBHgVERkz
         QAt6hdsmz9+dmkeOCCDmh9A5HBd92YacaQow7JNpHSODPBHvcS6r8ogDdR4527HRdvQY
         ++2w==
X-Gm-Message-State: AOJu0YzURmD3nYdATM1gFRNNPU6DuX9PxM/STX6QclFlU8N5LChtoOOk
        0cd9pm5WdZND2bp766pDfuaWKw==
X-Google-Smtp-Source: AGHT+IEi078hI6JWHsulI1eD2jNU1SLFI6/KtYGd73pb83dy6qFl+RSYFhxfbPVwwrRCGYycNcy0vg==
X-Received: by 2002:a05:620a:c42:b0:775:d7d7:cdbb with SMTP id u2-20020a05620a0c4200b00775d7d7cdbbmr263450qki.38.1699906037501;
        Mon, 13 Nov 2023 12:07:17 -0800 (PST)
Received: from [172.25.83.73] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id h27-20020a05620a21db00b00767dba7a4d3sm2107467qka.109.2023.11.13.12.07.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 12:07:17 -0800 (PST)
Message-ID: <824cee7b-e4d3-461a-8bfb-4ad095c240fd@linaro.org>
Date:   Mon, 13 Nov 2023 21:07:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] dt-bindings: pwm: Add OpenCores PWM module
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
References: <20231110062039.103339-1-william.qiu@starfivetech.com>
 <20231110062039.103339-2-william.qiu@starfivetech.com>
 <afce202d-6234-4c5f-9018-facd9a56b5eb@linaro.org>
 <f4551a7a-61e6-4d97-94c2-da2e4e9e8cb3@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f4551a7a-61e6-4d97-94c2-da2e4e9e8cb3@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 13/11/2023 10:42, William Qiu wrote:
> Will update.
>>> +
>>> +allOf:
>>> +  - $ref: pwm.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - starfive,jh7100-pwm
>>> +              - starfive,jh7110-pwm
>>> +          - const: opencores,pwm
>>
>> That's a very, very generic compatible. Are you sure, 100% sure, that
>> all designs from OpenCores from now till next 100 years will be 100%
>> compatible?
>>
> My description is not accurate enough, this is OpenCores PTC IP, and PWM
> is one of those modes, so it might be better to replace compatible with
> "opencores, ptc-pwm"
> 
> What do you think?

Sorry, maybe this answers maybe doesn't. What is "PTC"?

Best regards,
Krzysztof

