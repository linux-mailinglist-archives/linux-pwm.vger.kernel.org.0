Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0023C5FBAD5
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 20:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJKS5p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 14:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJKS5c (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 14:57:32 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D5B895D1
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 11:57:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f27so1487880qkh.12
        for <linux-pwm@vger.kernel.org>; Tue, 11 Oct 2022 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7MRNW6m6g8CYG+UQ5OATy25MtYysQqA6sH5xmW6Gss=;
        b=qA9kaTexUkWg+qp1UcnfMNvLehR4FV9cS5z82Hj0lXBIFCZAhXO80XCI2VQa3o03pk
         Hc6Vl/F2KCyVLgLQhr6+lxnGy//pLe6YiTJ1itudB/yJGct2TaiapQmRnMIpM5G5io/u
         1M9xPZY9qd6IkxLFbM7+GX2U5IhWdHkNdyr3Rp8DVEWg02S2vq66nhQXZ4Qi0FoN5Kga
         ozAVzu4qrS/3BjU2NlX1aas/GlaX05rJjJRDbI9RzWqn3p4JmgQ2pluyEisktyF/AqQ1
         nXtB7O+mITpxtgOaMU+YbbkYggCDj4OJ5Y75PvMMdD/LVcJ98wvmXNU+390TaQka/dPh
         ORLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7MRNW6m6g8CYG+UQ5OATy25MtYysQqA6sH5xmW6Gss=;
        b=crmCw83d83j3W40RsT8CQtytoeHeQARpY/oEnkjior4wsKTnT5XALRWMndMwIy5i7i
         U/0CSaNgPL7/FEwV9McPIQotU+Jg6oaRTIz4NCjvQRIITzzMp5zxyl3Kl5X1ocDJ7a6K
         eGvyWxs4Z+/gPErus0qjWSWQgVJo2uuJ+gbWjQqEqqPgz1C+E2NqxdNbGv3Fw5uOdGVW
         7cyBtp4sSnfJPyaMtpBFne43fZEYeRiSwMq5I2ENqESJognVuuUuPybn7dN7CQZf/JMS
         tR8Ht7VogMxOSN35zMUgPZUi9YLi8cLEzkpKNlLpYPQdHjmXDf2jmtKZoqDkLGLw/tHI
         bmnA==
X-Gm-Message-State: ACrzQf12HYeG/Cz06eDZXJbyAgi2mx7Vo1295KWrj2GERWRszYKGQvBE
        Icm0FZ8g+96qa+rED1UxIBNK3w==
X-Google-Smtp-Source: AMsMyM7gg7zRTMEQzLbIJsSJqlfTkKEGfwR/4SKbS8dVaDQ3ub/GEkm+hdHd0tPRkG0b/Z/8ks093Q==
X-Received: by 2002:a05:620a:2043:b0:6ee:8874:f5bc with SMTP id d3-20020a05620a204300b006ee8874f5bcmr2201786qka.134.1665514625359;
        Tue, 11 Oct 2022 11:57:05 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id i14-20020a05620a248e00b006bba46e5eeasm14509356qkn.37.2022.10.11.11.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 11:57:04 -0700 (PDT)
Message-ID: <ad2e4445-052b-d65a-bdba-5759c169aafd@linaro.org>
Date:   Tue, 11 Oct 2022 14:54:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
 <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
 <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/10/2022 10:55, Biju Das wrote:
> 
>>>  .../bindings/mfd/renesas,rz-mtu3.yaml         | 305
>> ++++++++++++++++++
>>>  1 file changed, 305 insertions(+)
>>>  create mode 100644
>>> Documentation/devicetree/bindings/mfd/renesas,rz-mtu3.yaml
>>
>> This should not be in MFD. Just because some device has few features,
>> does not mean it should go to MFD... Choose either timer or pwm.
> 
> MFD is for multifunction device. This IP supports multiple functions
> like timer, pwm, clock source/events. That is the reason I have added 
> here. MFD is core which provides register access for client devices.
> 
> For me moving it to pwm or counter is not a big problem.
> Why do you think it cannot be MFD?


Because it makes MFD a dump for everything where author did not want to
think about real device aspects, but instead represented driver design
(MFD driver).

MFDs are pretty often combining unrelated features, e.g. PMICs which
have wakeup and system power control, regulator, 32 kHz clocks, RTC and
some USB connector.

Just because you will have clocksource driver, PWM driver and timer
driver does not make it a MFD.

Best regards,
Krzysztof

