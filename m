Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB784679405
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jan 2023 10:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbjAXJV2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Jan 2023 04:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjAXJVK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Jan 2023 04:21:10 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB83640BEF;
        Tue, 24 Jan 2023 01:20:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y19so17582365edc.2;
        Tue, 24 Jan 2023 01:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkyt3V/sGweMqPRz5YiwT95Clx97EReN+Djf9uI4HAw=;
        b=CKS18NNmVewXIFwgT4uvAQ+zfKsoibcxbtwGO6YuqZocKNY43OyK9PYdP2W+JL/xxk
         wtNWFUW5u3OqrBJUrSVCREMTgw2FzydUKc4onoIgf4Q07dp6q/lAC1NzgdortFOGYY16
         aDsIbBOBTPUDRLOA5J0v6CHBXwiZHMz/QehV2KnPiEnysy7HSpw0G0Q3wlI4SBxWmNk6
         XVxqGcFOur1LtFCChRTTFBi2HJismqk640xhKSDxtukTradXSC1RUA4acA2C0fhDOpPk
         Peca/5Fnlfr2oOxOVPD6OfS9Oaa/rv/w3nbm1ItEMe0Fsm95bSvwz8pp4sqPR8R6eAxH
         iZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkyt3V/sGweMqPRz5YiwT95Clx97EReN+Djf9uI4HAw=;
        b=NXjyIrUQ536Y0iJwklv/6auJqFB+5JNHNqxVBeGJCC70Gn6K3YRZW28m+pO88CilD2
         aPLeVR3BCKNVIVzl1HAWI5fobRrOHjUUAgLT2+mCLGnXCmp2atKX3FdZuurYiUx1TiZj
         pzY2BL/3gAd34O5uA+nP/yURLmOUhfOOIkCtg/coliPZDEcY21Ctv2d/jwm10GVFkJJx
         bXDWBDcu9SvfkU6ph4lOPHhQp0KAtcDHjVVJbaxp2M43ZOg/zzmYxaP4v8s0eGOt+eZw
         cx3IMZPjEFcQlLjCd8fuYI4+noJ9fFEVuNXgYLY97P9+jCJjP1xoCGnANG0Ma1f+g9Jd
         k5nA==
X-Gm-Message-State: AFqh2kp53trRTQApVTn6W5yE24hawzNt2HUKq4snADG9nJWi+DRBx+Wk
        JsDW8teA+2Sz8rz0KUcnr9U=
X-Google-Smtp-Source: AMrXdXtRWxW1mAbiUmC4SLcOOmddV2ys9A8B0EHmTeVmBqDkSv7OFCZ0WGK0Gn+dVGSenvg/hDCV5Q==
X-Received: by 2002:a05:6402:3220:b0:49e:1d59:794f with SMTP id g32-20020a056402322000b0049e1d59794fmr35522994eda.22.1674552042732;
        Tue, 24 Jan 2023 01:20:42 -0800 (PST)
Received: from ?IPV6:2a01:c23:c139:7c00:ccbf:89a4:c6b8:c0f5? (dynamic-2a01-0c23-c139-7c00-ccbf-89a4-c6b8-c0f5.c23.pool.telefonica.de. [2a01:c23:c139:7c00:ccbf:89a4:c6b8:c0f5])
        by smtp.googlemail.com with ESMTPSA id b8-20020aa7c908000000b00482e0c55e2bsm396134edt.93.2023.01.24.01.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 01:20:42 -0800 (PST)
Message-ID: <2aaa347b-da29-67e8-56e9-959de708e426@gmail.com>
Date:   Tue, 24 Jan 2023 10:20:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 0/8] soc: amlogic: switch bindings to yaml and adjust some
 dtbs's
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <0e48405a-d4e7-92a8-339f-4be2f4ec1378@linaro.org>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <0e48405a-d4e7-92a8-339f-4be2f4ec1378@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 24.01.2023 08:16, Neil Armstrong wrote:
> Hi Heiner,
> 
> Le 23/01/2023 à 22:22, Heiner Kallweit a écrit :
>> At first adjust some existing dtbs's so that they pass dtbs_check
>> after switching bindings to yaml.
> 
> Thanks for this patchset, but please drop patches 1, 3 & 4, and take
> in account the existing compatible usage in your new bindings like
> I did in my conversion patchset.
> 
> While we did remove some bad compatibles we introduced a few years ago,
> now the GXBB, GXL & GXM are now stable a aew LTS releases now and
> a few other projects uses them as-is (U-Boot, BSDs, ...) so changing
> the compatibles isn't an option anymore... and we can't know which
> one they use and how the implementation behaves we must document
> the existing usage without breaking any potential users (including linux).
> 
I wasn't aware of this. Thanks for the hint.
So I'll rework the schemas to cover current usage of compatible strings.

> Thanks,
> Neil
> 
Heiner
> 
> 
>>
>> Then switch further Amlogic Meson bindings to yaml.
>> Tested with make targets dt_binding_check and dtbs_check.
>>
>> Heiner Kallweit (8):
>>    arm64: dts: meson-gx: Remove invalid pwm compatible
>>    arm64: dts: amlogic: Fix non-compliant SD/SDIO node names
>>    arm64: dts: meson-gx: Set only one compatible string for mmc
>>    arm64: dts: amlogic: Remove invalid compatible string
>>      amlogic,meson-gpio-intc
>>    dt-bindings: rtc: Add Amlogic Meson vrtc controller binding
>>    dt-bindings: pwm: Add Amlogic Meson PWM binding
>>    dt-bindings: interrupt-controller: Add Amlogic Meson GPIO interrupt
>>      controller binding
>>    dt-bindings: pinctrl: Add Amlogic Meson pinctrl binding
>>
>>   .../amlogic,meson-gpio-intc.txt               |  38 ------
>>   .../amlogic,meson-gpio-intc.yaml              |  72 +++++++++++
>>   .../pinctrl/amlogic,meson-pinctrl.yaml        | 121 ++++++++++++++++++
>>   .../bindings/pinctrl/meson,pinctrl.txt        |  94 --------------
>>   .../devicetree/bindings/pwm/pwm-amlogic.yaml  |  61 +++++++++
>>   .../devicetree/bindings/pwm/pwm-meson.txt     |  29 -----
>>   .../bindings/rtc/amlogic,meson-vrtc.yaml      |  50 ++++++++
>>   .../bindings/rtc/rtc-meson-vrtc.txt           |  22 ----
>>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   5 +-
>>   .../boot/dts/amlogic/meson-g12-common.dtsi    |   7 +-
>>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  15 +--
>>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |   3 +-
>>   arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |   3 +-
>>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   3 +-
>>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |   3 +-
>>   15 files changed, 320 insertions(+), 206 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
>>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
>>   create mode 100644 Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt
>>
> 
> 

