Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C57EF12F
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Nov 2023 11:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345973AbjKQK5l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Nov 2023 05:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbjKQK5j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Nov 2023 05:57:39 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3519D4D
        for <linux-pwm@vger.kernel.org>; Fri, 17 Nov 2023 02:57:34 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9e623356d5dso259959966b.3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Nov 2023 02:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700218653; x=1700823453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7+0aqbL1GUW2uOUHinN7TVWlVf7xDbT0umbdNRYkjI=;
        b=H72T+FNbpFlSFdOZ/X1Ej8M02sj/GMhhlDSvQrhUYTXggtYGB+szF/l3jHSvDmlFTR
         WnhSANY+FD1hueVAJOaJbr5H5rqHJtQbEZcDqNpF09DTiSYenpEu+rPBEazT15LZgNpO
         Zh4VAF/Y4p2ML8fLvDOyQsQW98k/DwwzmmVT03y4JUnFm28I6xgWitilyylBJOSCS2xm
         wlwFvRDd8R6ypStIM3nzIzklnRpHpF4uhd0su0OtnWU8cqgKUyVl/bHUCLW/yee6oO2Q
         Uc5gjJnTelPvWii0luNCAIrBas7jidV13XCuFuVuof0FuDOPiyi1xCbRvaK9T18/vfJG
         BKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218653; x=1700823453;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7+0aqbL1GUW2uOUHinN7TVWlVf7xDbT0umbdNRYkjI=;
        b=Ba6YeabFx47WOnFGiE0tPMenogKu2J/Kgc/gu269KCCYiGIz+macQpXHlqxhMAHror
         oulCcwuSnlRfNaJJp0v5U/wSNvfa0jsa+iDu38XPd2BGYDdB4aXLGQoyUwolZpZNRMeV
         cPOsP/ASf/pGqhwxrjcPJKpABuyz14Qng68stK+1emb3MzMtPFGq2lTnnzkLBA27yD3s
         wHnZUdV7bSq1DXi9+0fFdepn6FuBL9n1h+j2TCfrkR2a5E5Rkw8Vu30vstJaLnlnXJNX
         7t/7B3LFA7cZZNIY6fg7vrvqWbKrENh4EMsK0NjsYBNknmcJ0J9HZZdyWaJQUaWGrqsq
         9fqw==
X-Gm-Message-State: AOJu0YxDngJuNUih0kCkbuUi1KfAlV0vekLjH2qbna4npl1BWpCU+zZG
        bdJNZaNZIQhX8mSIDYSQG3QxNw==
X-Google-Smtp-Source: AGHT+IHXP2YaW9B3fqSoTooJZbPpDTIMwfN0a+ksm058nEWX4ZGbOPl1OjB0YO3ORx8B0yU1sGZkaA==
X-Received: by 2002:a17:907:da5:b0:9e8:f669:4763 with SMTP id go37-20020a1709070da500b009e8f6694763mr13123149ejc.43.1700218652959;
        Fri, 17 Nov 2023 02:57:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906b28200b009ad8acac02asm664229ejz.172.2023.11.17.02.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 02:57:32 -0800 (PST)
Message-ID: <2febc62c-c763-42ae-b649-2ca284543cc0@linaro.org>
Date:   Fri, 17 Nov 2023 11:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] Introduce ExynosAutov920 SoC and SADK board
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
References: <CGME20231115095852epcas2p21e067efe75275c6abd2aebf04c5c6166@epcas2p2.samsung.com>
 <20231115095609.39883-1-jaewon02.kim@samsung.com>
 <170005362858.21132.4200897251821879805.b4-ty@linaro.org>
 <6e69df6c-10fa-404a-ac02-4880723b8c50@linaro.org>
 <55a0f27c-ea46-40ae-b1e5-e650802b89a8@linaro.org>
 <d6f3d451-6a53-46b6-2263-cc071a9dc44c@samsung.com>
 <d8fbd100-2351-4dbe-ae7f-d98a84432589@linaro.org>
 <af102ef7-aa34-1b9d-c39c-228729fef015@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <af102ef7-aa34-1b9d-c39c-228729fef015@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17/11/2023 08:19, Jaewon Kim wrote:
> 
> On 23. 11. 16. 20:17, Krzysztof Kozlowski wrote:
>> On 16/11/2023 04:32, Jaewon Kim wrote:
>>> On 23. 11. 16. 06:17, Krzysztof Kozlowski wrote:
>>>> On 15/11/2023 22:11, Krzysztof Kozlowski wrote:
>>>>> On 15/11/2023 14:08, Krzysztof Kozlowski wrote:
>>>>>> On Wed, 15 Nov 2023 18:55:56 +0900, Jaewon Kim wrote:
>>>>>>> ExynosAutov920[1] is ARMv8-based automotive-oriented SoC.
>>>>>>> This SoC is the next generation of exynosautov9 and AE(Automotive Enhanced)
>>>>>>> IPs are used for safety.
>>>>>>>
>>>>>>> This patchset is the minimal set for ExynosAutov920 SoC and SADK board.
>>>>>>> Currently, ramdisk console is available and Clock, UFS, and USI will be
>>>>>>> added after this patchset.
>>>>>>>
>>>>>>> [...]
>>>>>> Applied, thanks!
>>>>>>
>>>>> And dropped. You did not test it. Please read Samsung SoC maintainer
>>>>> profile:
>>>>> https://www.kernel.org/doc/html/latest/process/maintainers.html#arm-samsung-s3c-s5p-and-exynos-arm-architectures
>>>>>
>>>>> I also made announcements on the lists and on social.kernel.org. I don't
>>>>> know where to announce it more...
>>>>>
>>>> To clarify, I dropped only DTS and kept bindings. Let me know if
>>>> bindings are problematic here...
>>>>
>>>> I also repeated the announcement:
>>>> https://social.kernel.org/notice/AbqJkj9gOZJ3sG8eCu
>>>> Please share internally within Samsung, so there will be no surprises.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>>
>>> I already checked and there were no warnings or errors as shown below.
>>>
>>> Did I miss something??
>> It's not what is written in maintainer profile. Where do you see the
>> result of dtc W=1?
>>
> 
> Sorry, Krzysztof I miss W=1.
> 
> I haven`t been active in mainline for a long time, so I`m missing out on 
> a lot of things.

If you (plural you, Samsung) ever gave me an email address where I can
send notifications I would gladly forward them to you.

Over the time I sent few of them, like the one about deprecation of
platforms or changing some rules, feedback for common solution for
minidump (to remind: Samsung decided to skip it so we go with Qualcomm
idea and you will not be able to come with your own later) etc. I was
even contacting some addresses in Samsung LSI, but there was never a
response, except the one about minidump.

There was like never a chance to really get to Samsung, so sorry, now it
is Samsung's fault it does not follow announcements.

Best regards,
Krzysztof

