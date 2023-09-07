Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A643797D59
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Sep 2023 22:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjIGU0i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 7 Sep 2023 16:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjIGU0h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Sep 2023 16:26:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C251BCE
        for <linux-pwm@vger.kernel.org>; Thu,  7 Sep 2023 13:26:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52c74a2e8edso1881032a12.1
        for <linux-pwm@vger.kernel.org>; Thu, 07 Sep 2023 13:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694118389; x=1694723189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nQbuLcA/mdrJIiZfYZbG0aXkMvUaPLHwLalgOdmCPQs=;
        b=qVk/ZJImh7iZoNAFpSnjkDnhIsthtirjAmVwC8vNS0e1I5UxqHhD1ARuC6m8b/qqaz
         8re276+6Ensr2OfSVkaspU2VfAqO4zxh4dqDRYIdK06/aJ1VDBjk3Elt5MT/j1WzQn0t
         yNlGBc92LGg/rfb6EI/9EOhb3m7OglPb0ffxJjZA6Nv/lqFeG2x2IxIBpvrLmXLP4b6W
         3eVQ44Ux0LUVKGAsKltRgAhyFGBWMj/OoqodCTtCrKQqq5TYIFgNK24tHom7YDQr+wVI
         1W9HbD2IUpyZzTVGuNlB+vkjWiTiYq2ii/YlUQtmvniS7QfEy3nDqUIcPY1U9kJBjd5F
         DVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694118389; x=1694723189;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQbuLcA/mdrJIiZfYZbG0aXkMvUaPLHwLalgOdmCPQs=;
        b=tVS/3QKWIcGAHWdhM2rTPybz1lK08xDCG6i4M7/HDAfmXH+J7OXqrY9pUC+HjiWTGp
         8oHYR756oycJdkBBUypmLsaR5KHbvmIelSqxcZoiP/HMn31Kumsd/UYsJ7icwj0Zv6vE
         fNhh/C7UvXfTuUttS3zNSSvI7+OPBVPqhSDg2tmRsIuERmNqu7rg08Z3N3TLThHjpiQx
         JbOgxx2FsllhAUjWiia4hNXZwrtf09WuPlUyn0iVFhIaEkix2YGD3FwFgWaV8Y/A1RzJ
         kyWvlJjwAKVDLr9qPRaJUA7vyzZN1KRg+BelqoxA8cR7CL6AkZoblIVVolfQKL/dUROW
         G+YQ==
X-Gm-Message-State: AOJu0YwV0iezwJo0jtnHW5aNtDzoXNYTM5F07FkJZvG420c+VfTADekn
        Od8JKRKXLptJjorsk1p8vyqUeg==
X-Google-Smtp-Source: AGHT+IGpt5ai8rmJuk04exyN/+5f5XxCj4SdePbKlyIVOeKUOvpWCZX9QEl/HZ+ID138nsQTMFNOBA==
X-Received: by 2002:a05:6402:1801:b0:51d:d30d:a037 with SMTP id g1-20020a056402180100b0051dd30da037mr290389edy.10.1694118389225;
        Thu, 07 Sep 2023 13:26:29 -0700 (PDT)
Received: from [192.168.37.234] (178235177164.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.164])
        by smtp.gmail.com with ESMTPSA id g16-20020aa7c590000000b0051e1660a34esm196815edq.51.2023.09.07.13.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 13:26:28 -0700 (PDT)
Message-ID: <ab237850-4724-48a8-bea8-f1287445358f@linaro.org>
Date:   Thu, 7 Sep 2023 22:26:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data
 to support PPG
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     luca.weiss@fairphone.com, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, quic_gurus@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@quicinc.com
References: <20230830180600.1865-2-quic_amelende@quicinc.com>
 <20230830180600.1865-8-quic_amelende@quicinc.com>
 <951a2f24-931a-4a25-a3b7-c3009e135d7d@linaro.org>
 <ca451c20-57c1-6fb4-8c8e-b3446944a0f6@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ca451c20-57c1-6fb4-8c8e-b3446944a0f6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7.09.2023 21:54, Anjelique Melendez wrote:
> 
> 
> On 8/30/2023 11:34 AM, Konrad Dybcio wrote:
>> On 30.08.2023 20:06, Anjelique Melendez wrote:
>>> Update the pmi632 lpg_data struct so that pmi632 devices use PPG
>>> for LUT pattern.
>>>
>>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>>> ---
>>>  drivers/leds/rgb/leds-qcom-lpg.c | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
>>> index 90dc27d5eb7c..0b37d3b539f8 100644
>>> --- a/drivers/leds/rgb/leds-qcom-lpg.c
>>> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
>>> @@ -1672,11 +1672,14 @@ static const struct lpg_data pm8994_lpg_data = {
>>>  static const struct lpg_data pmi632_lpg_data = {
>>>  	.triled_base = 0xd000,
>>>  
>>> +	.lut_size = 64,
>>> +	.lut_sdam_base = 0x80,
>> Is that a predefined space for use with LPG?
>>
>> Or can it be reclaimed for something else?
>>
>> Konrad
> Yes, this is a predefined space for use with LPG
We represent the SDAM as a NVMEM device, generally it would
be nice to add all regions within it as subnodes in the devicetree.

Krzysztof, opinions?

Konrad
