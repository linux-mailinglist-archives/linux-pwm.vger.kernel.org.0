Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2698275629F
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Jul 2023 14:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjGQMXF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Jul 2023 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQMXE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 17 Jul 2023 08:23:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D535CD8
        for <linux-pwm@vger.kernel.org>; Mon, 17 Jul 2023 05:23:02 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9891c73e0fbso910223866b.1
        for <linux-pwm@vger.kernel.org>; Mon, 17 Jul 2023 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689596581; x=1692188581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vhwu1zp3S5PiRdDu32pUjkHXYPNpSh6XO9BtN9Bqmk=;
        b=x8Kpuu7atosaYgXr1dMB4cVtN0RBwRi9X2gwVon76DSiXtTX2vvl23/e5Svst2LMSL
         ixVyWJ/mvM/mxMBMFHgiGZuxaXrxuce+QMW3iFsWK/5UHiLWpPvQ30p2fPuXezclwT5u
         JwQ9JD+HZhA24SSm73STxLXKlzHYSGgSDoXy7pemnb7O2TCa/HkDGYY+Mu9SVen1VfHJ
         R2T80S64RwZy9CXAlDjxrDJzVxxQuPSWzhFeDlrqIJoVxpqeSVssAbIhDRcsYgPmviyO
         /+2IHLKIEd4GFmKMwaJBHMZvV1G8BNagDL4NRvHx+PO5KQnBlcJQ11fFwvvybNrFxVEs
         fxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689596581; x=1692188581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vhwu1zp3S5PiRdDu32pUjkHXYPNpSh6XO9BtN9Bqmk=;
        b=JF7JSs+FfeuNU0ST/gUw9DqjxQHvGJlJJgvh1gzDQS1+Cq6pwy3muSgcLVCM8thmZL
         Ms42sNfOKHn4u24DXQm0aUk6lc2up/JkVZ/fgR+TgI4DyQl8QCGX+/CnokFadSHmKlt8
         +Doqg5AXPYnv4Mu30fKTrkYNoEWweFeD29IJsLCPNluAZI+sPXtS+0/Sj8ujB0JkPA9r
         p+j5IJlB5CoKGFagIVsjsdUKMsqdv/NpCG9mzOPDuK7iQ198J9+st2uwehtbgn3IhDqp
         iqognoYP3AD17hZ1ASDgcIot5qAkSdgL0dESvO5oe8jkoQ7cEjh4zJmaBeR++bmBv7SK
         mjuw==
X-Gm-Message-State: ABy/qLYMsgXgIFc1kxFDGiRW1CFZC6R9gCWLJfCXpNyjAD4SSdBEmXW2
        niHEDqPgLr94cxHEV+jtpE69Hw==
X-Google-Smtp-Source: APBJJlHPBiZufczBjnjB/8OgazGqsfTjzsPvN3r4urbCM8aFAGsuynBEWcPDR8TS01nu7v5Oot8HmA==
X-Received: by 2002:a17:906:2d1:b0:994:5457:269e with SMTP id 17-20020a17090602d100b009945457269emr9126055ejk.0.1689596581219;
        Mon, 17 Jul 2023 05:23:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y27-20020a1709063a9b00b00992ca779f42sm9171089ejd.97.2023.07.17.05.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 05:23:00 -0700 (PDT)
Message-ID: <5b5299b6-a0b9-2ece-6c8c-5374ec18cd1c@linaro.org>
Date:   Mon, 17 Jul 2023 14:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: samsung: add exynosautov9
 compatible
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230717094202.18296-1-jaewon02.kim@samsung.com>
 <CGME20230717094721epcas2p1c5c1254e24d4a1d0fb366e1b4d551536@epcas2p1.samsung.com>
 <20230717094202.18296-2-jaewon02.kim@samsung.com>
 <9b09afec-4e0e-a600-92e1-2104a1b2e36e@linaro.org>
 <68aacadd-f27d-76d3-36a1-78f5662ecb97@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <68aacadd-f27d-76d3-36a1-78f5662ecb97@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17/07/2023 13:26, Jaewon Kim wrote:
> 
> On 23. 7. 17. 19:59, Krzysztof Kozlowski wrote:
>> On 17/07/2023 11:42, Jaewon Kim wrote:
>>> Add samsung,exynosautov9-pwm compatible string to binding document.
>>>
>>> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
>>> ---
>>>   .../devicetree/bindings/pwm/pwm-samsung.yaml     | 16 ++++++++++------
>>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>>> index fe603fb1b2cc..6f65e2b52f52 100644
>>> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
>>> @@ -20,12 +20,16 @@ description: |+
>>>   
>>>   properties:
>>>     compatible:
>>> -    enum:
>>> -      - samsung,s3c2410-pwm             # 16-bit, S3C24xx
>>> -      - samsung,s3c6400-pwm             # 32-bit, S3C64xx
>>> -      - samsung,s5p6440-pwm             # 32-bit, S5P64x0
>>> -      - samsung,s5pc100-pwm             # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
>>> -      - samsung,exynos4210-pwm          # 32-bit, Exynos
>>> +    oneOf:
>>> +      - const: samsung,s3c2410-pwm        # 16-bit
>>> +      - const: samsung,s3c6400-pwm        # 32-bit, S3C64xx
>>> +      - const: samsung,s5p6440-pwm        # 32-bit, S5P64x0
>>> +      - const: samsung,s5pc100-pwm        # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
>>> +      - const: samsung,exynos4210-pwm     # 32-bit, Exynos
>> These are still an enum.
> Okay I will change const to enum.
>>
>>> +      - items:
>>> +          - enum:
>>> +              - samsung,exynosautov9-pwm  # 32-bit, ExynosAutov9
>> Let's drop the comment?
> 
> Should I just delete this comment or delete all comments in the 
> enum(16-bit,S3C24xx, .....).

No, the other can stay. Here it is redundant, since Autov9 is obvious -
comes from compatible - and rest is coming from compatibility with older
models.

Best regards,
Krzysztof

