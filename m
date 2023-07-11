Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9180974E6A0
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Jul 2023 07:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGKF7D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Jul 2023 01:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGKF7C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Jul 2023 01:59:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0356C1A7
        for <linux-pwm@vger.kernel.org>; Mon, 10 Jul 2023 22:58:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e99584adaso293150a12.0
        for <linux-pwm@vger.kernel.org>; Mon, 10 Jul 2023 22:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689055137; x=1691647137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zj3IQ/+F48JuMncJJrePBBu6AGCGhuyGEx5VtKIoCXU=;
        b=McekgwoCljPM2KEtKpnvtIRNOeILG/FO93/d4byH4ZeL1iebUIDZqSRrxOmWzXC3/t
         KjFY8hSEL9RgFj3P3Uo5Bj21XHiExkgMjcTLlOJMpxBSDXRoxpMSYq2HSByo8zBYiOkr
         JxNGQV0m58YUFgXgK7GK9wZEQboZOcKg+yYo9hokH4EBf8F1jMFOqe3rSeQaunudKY5h
         UXQV2YxC1ZnmRJCzni/slhDX0CIhO8vyuUO+Nav0WJAKHfufiSAaOw3bKNtn2eJCpAca
         +N+7P7J+35vfV9lf3VH9cv81CoHC51hqnnEQX4DnVcJGCg7HTMIu/zWOjOTH6nlurGz0
         ft6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689055137; x=1691647137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zj3IQ/+F48JuMncJJrePBBu6AGCGhuyGEx5VtKIoCXU=;
        b=LQhlhC6jeWz62ktXj81CW6JW3vtN8EiJCkkwVPxQHLVYcd8VDktvVR7EiGw2lEyUMV
         fhuT3LaqZRHlAJ4hFAfR1lDExFdvmhkfXI/hIuCHI7YzElvMpslJ4/mN5qzGqsMp923Q
         GAqnhuUjmzsAmmHGrIVTrvss6tW2nGdD/7/mQlSulu0tHlao65UULw9Spox9YCgnKK+i
         ykX02ecFlG693JaxqFJEBISxn6OZLSMxoDtQFa+KsCwGV8XhsfgCT5cU5zxzJktvtsUt
         WuO2LW0tfGWc+utQwqCT48ipIx4U2hpNAcYEEXB1tCwJVu5FY1SDObfW7587kP3b/eK3
         Mayg==
X-Gm-Message-State: ABy/qLaxgY081komLUJItQs3FlpJDe6mgzd8XddE7dgJEQCES7pNBOLO
        fhnH+wBFufrlJs7Yycfb8V1441JFTRUR5cEpACw=
X-Google-Smtp-Source: APBJJlEWvdPL7dZZTCHCeeBpGza2Z5DICi24muBnEuZv4fopMf/NWNWeX5K9l6Q1G7KCTu5VKgRYeg==
X-Received: by 2002:a05:6402:2022:b0:51d:9e0c:1396 with SMTP id ay2-20020a056402202200b0051d9e0c1396mr14420488edb.35.1689055137425;
        Mon, 10 Jul 2023 22:58:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id bo28-20020a0564020b3c00b0051df5bd1cd8sm692565edb.65.2023.07.10.22.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 22:58:57 -0700 (PDT)
Message-ID: <431faa87-d152-5f7a-40fd-8b6fe26f0bb9@linaro.org>
Date:   Tue, 11 Jul 2023 07:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Anjelique Melendez <quic_amelende@quicinc.com>,
        Rob Herring <robh@kernel.org>
Cc:     pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        u.kleine-koenig@pengutronix.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <20230621185949.2068-2-quic_amelende@quicinc.com>
 <20230626135857.GA3118929-robh@kernel.org>
 <2e871e21-a81d-0d7d-993b-9a9d7bd9d962@quicinc.com>
 <e7298704-5a03-0961-90a3-dab4af60c326@linaro.org>
 <32e9a512-fd74-b2f6-6b8a-fefb9ad5912d@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <32e9a512-fd74-b2f6-6b8a-fefb9ad5912d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/07/2023 05:52, Anjelique Melendez wrote:
> 
> 
> On 7/1/2023 4:03 AM, Krzysztof Kozlowski wrote:
>> On 29/06/2023 03:19, Anjelique Melendez wrote:
>>
>>>>> +examples:
>>>>> +  - |
>>>>> +    pmic {
>>>>> +      #address-cells = <1>;
>>>>> +      #size-cells = <0>;
>>>>> +
>>>>> +      qcom,pbs@7400 {
>>>>> +        compatible = "qcom,pbs";
>>>>> +        reg = <0x7400>;
>>>>> +      };
>>>>
>>>> Why do you need a child node for this? Is there more than 1 instance in 
>>>> a PMIC? Every sub-function of a PMIC doesn't have to have a DT node.
>>>>
>>>
>>> We currently have another downstream driver (which is planned to get upstreamed)
>>> which also needs a handle to a pbs device in order to properly trigger events. 
>>
>> I don't see how does it answer Rob's concerns. Neither mine about
>> incomplete binding. You don't need pbs node here for that.
>>
>> Anyway, whatever you have downstream also does not justify any changes.
>> Either upstream these so we can see it or drop this binding.
>>
>> Best regards,
>> Krzysztof
>>
> 
> On PMI632, peripherals are partitioned over 2 different SIDs
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/pmi632.dtsi?h=v6.5-rc1#n42
> and https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/pmi632.dtsi?h=v6.5-rc1#n149).
> Unfortunately, the pbs peripheral and the lpg peripherals are on different
> PMI632 devices and therefore have different regmaps.
>  
> If we get rid of the pbs node we need to get a handle to the proper regmap.
> I see two possible options, we could either introduce a new client property
> which points to a peripheral on the same device as pbs.
> 
> i.e.
> 	led-controller {
> 		compatible = "qcom,pmi632-lpg";
>       		#address-cells = <1>;
>       		#size-cells = <0>;
>       		#pwm-cells = <2>;
>      		nvmem-names = "lpg_chan_sdam";
>       		nvmem = <&pmi632_sdam7>;
>       		qcom,pbs-phandle = <&pmi632_gpios>;
>       		..... 
> 	};
> Then when client is probing could do something like the following to get the regmap
> 
> 	dn = of_parse_phandle(node, "qcom,pbs-phandle", 0);
> 	pdev = of_find_device_by_node(dn);
> 	pbs_regmap = dev_get_regmap(&pdev->dev->parent, NULL);
> 
> 
> 
> Or we could use the nvmem phandle and just have something like this in client's probe
> 
> 	dn = of_parse_phandle(node, "nvmem", 0);
> 	pdev = of_find_device_by_node(dn);
> 	pbs_regmap = dev_get_regmap(&pdev->dev->parent, NULL);
> 
> 
> 
> Let me know what your thoughts are on this.

Rob asked you - "Is there more than 1 instance in a PMIC?" - and you did
not answer positively, just mentioned something about drivers in
downstream, which do not matter. So is the answer for that question:
yes, you have two instances of the same PMIC differing by presence of
PBS and other features"?

Best regards,
Krzysztof

