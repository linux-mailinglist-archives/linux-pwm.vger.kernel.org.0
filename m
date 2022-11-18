Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA662EF51
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Nov 2022 09:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbiKRI3C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 18 Nov 2022 03:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiKRI2d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 18 Nov 2022 03:28:33 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C070F1088
        for <linux-pwm@vger.kernel.org>; Fri, 18 Nov 2022 00:28:24 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t10so5960111ljj.0
        for <linux-pwm@vger.kernel.org>; Fri, 18 Nov 2022 00:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrA5CDs46lQZm6VaAVmPmV1Nyk9XIySNq9lvhXdo7k8=;
        b=yIT6wd8Tn/4EigMdSev3RTx1dShvONUZ1o2LJic5y3UzW8LgMuG7uFp80Y8Mw7p+2i
         u+Hx+MWiciMmXSYnrFx98cxa4sbmSAURAUt99p8E3r2tMmF0ygoLGxcFQPJrif3jPMLj
         y0DxRVohO6j383Jju+uqZkJFVPAKCT7G1d+SNz0aRrDl59ec+iH3SvLunNJnRAN3fFHp
         uj/yuz8SV/cGRRKi6lGP5BHU+Y9YeVlbn5zwGo+B4clkg1nQfYqsfFdJXz60NiVE7C5x
         xoWYk/DHjlYtipany3Ms311spap+ZgR86DO9tnSirVslPkUYj7drcMZpd/Ds56w7qUSX
         eO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrA5CDs46lQZm6VaAVmPmV1Nyk9XIySNq9lvhXdo7k8=;
        b=4nVTzkH5jRR7r4lmY5OW5tjc8mgn1EPaBLuM9WLPMWP5QG8GpEXNIKbYA8mvtCRLqY
         F4t90VIir/iXDlNp25ll31+XcDZ5XpKvVoU3z8kRtYz+qH7H6h9T5n3N6Cyd/JZkrpWr
         WjHV2NXH0kXFrk8zM6UmfUguoFd5XXGjAB3QOBKB5clUB8AXilWa8OI7RvqhPUnoj47D
         Ot0QUjrUX+ACCgfbktr45aC4semRPw550DIGBuVOMD5fEyADNGkZwl3eQJZF/GeF0aYY
         KE0RObOijH04+T27MBJvYkrva01JDM5KZ+IsUvWx0KBLroTtuRBvRkvgS5TC2c6RDTZT
         UXWA==
X-Gm-Message-State: ANoB5pn9zzz4Qm2RHdP1xBd9eu7SQL2u7PyNh3PYX4WLysRFKTRHfvt7
        wSmS6VryCu6HknQjJh/lE+u/qA==
X-Google-Smtp-Source: AA0mqf4FSTsj7jWLGFDuUM1KolU0pAAAlYx7n+VRF6tfHUnjgf3Tz4kJo9qfndGCbN01BGn3foVCSQ==
X-Received: by 2002:a2e:9052:0:b0:26e:eeb:f9cf with SMTP id n18-20020a2e9052000000b0026e0eebf9cfmr2211769ljg.480.1668760070041;
        Fri, 18 Nov 2022 00:27:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g27-20020a2eb0db000000b0026bf0d71b1esm573326ljl.93.2022.11.18.00.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 00:27:49 -0800 (PST)
Message-ID: <06ac1c86-22f7-97ff-bf59-6fb0994dfcc5@linaro.org>
Date:   Fri, 18 Nov 2022 09:27:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 1/9] dt-bindings: drop redundant part of title of
 shared bindings
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, linux-can@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-watchdog@vger.kernel.org
References: <20221117123850.368213-1-krzysztof.kozlowski@linaro.org>
 <20221117123850.368213-2-krzysztof.kozlowski@linaro.org>
 <Y3Z0w6JH1f5zgwvW@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3Z0w6JH1f5zgwvW@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 17/11/2022 18:52, Conor Dooley wrote:
> On Thu, Nov 17, 2022 at 01:38:42PM +0100, Krzysztof Kozlowski wrote:
>> The Devicetree bindings document does not have to say in the title that
>> it is a "binding", but instead just describe the hardware.  For shared
>> (re-usable) schemas, name them all as "common properties".
> 
> 
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
>> index 1ab416c83c8d..d2de3d128b73 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
>> @@ -4,7 +4,7 @@
>>  $id: http://devicetree.org/schemas/clock/qcom,gcc.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: Qualcomm Global Clock & Reset Controller Common Bindings
>> +title: Qualcomm Global Clock & Reset Controller common parts
>>  
>>  maintainers:
>>    - Stephen Boyd <sboyd@kernel.org>
> 
> 
>> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> index cf9c2f7bddc2..20ac432dc683 100644
>> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
>> @@ -4,7 +4,7 @@
>>  $id: http://devicetree.org/schemas/opp/opp-v2-base.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>> -title: Generic OPP (Operating Performance Points) Common Binding
>> +title: Generic OPP (Operating Performance Points) common parts
>>  
>>  maintainers:
>>    - Viresh Kumar <viresh.kumar@linaro.org>
> 
> Hey Krzysztof,
> 
> Hopefully I've not overlooked something obvious, but it wasnt noted in
> the commit message - how come these two are "parts" rather than
> "properties"? The opp one at least don't seem to have much more than
> properties and patterProperties in it.

They should be properties, will fix in v2.


Best regards,
Krzysztof

