Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF24F6791C2
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jan 2023 08:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjAXHQv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Jan 2023 02:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjAXHQv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Jan 2023 02:16:51 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456843AA6
        for <linux-pwm@vger.kernel.org>; Mon, 23 Jan 2023 23:16:49 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso10185948wmq.5
        for <linux-pwm@vger.kernel.org>; Mon, 23 Jan 2023 23:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hTtPbBF2Q6UH5MokSMoyqymn+L8qY1BRaG006W5dhY=;
        b=bxnQM4jVcaTKwE6lhG1gXYGuWV6R/ofAFC3f5/MqIWvUYFN8yL3DJPhXSJk84moB7F
         f3m4SgvqoPUYr5UhkTAItqsU3KnInjUUMgzPHUhelJbU5/UttaNqT9myJkj9dZrCGXWk
         JBziIlZrkLCLfRyPQxXIOXVISN0i98wElnjeidrqfG3dKazkBnCR/qvhR6bHZ7IcUQSa
         FBu6J/xmxVSqyMUD1a5E4W8dX0QVyjOeZN8UoyZGO4k6i3CfMC5q+x41Y3A6a5aEbrct
         zsJyklxKx+LsdEwMI42EP33CsrgrZcXe3yCbjZCIyWFAllNt3//909dHrOpzmkdko+LX
         rYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hTtPbBF2Q6UH5MokSMoyqymn+L8qY1BRaG006W5dhY=;
        b=RSd4dxSywp2JsG6nWFo4Gvj3lSlpzlPkckOP3IQsGO6TahM6kEWZZtW3K9hRsGlT6A
         E3aOJ9w9VAJrcgUMrSNNE/RUqpEMfLx8P+RApf85aFrc4ENuytPaBQha0liFWZAHNO57
         FV66OmS0yoX8UI4MJi8NeqNooLSgSXmw45hSKmH1I9QE+0BcnAINPMJj7VQz78cFdHw2
         QOWIXVcdFIt8mAQnPHrReXrgIPyAFEMplahntyvrBDK/cAr84ufdNqJV25UH9bdzqXiY
         wnWmJZz7OU636E5yvozdqjFHFNG2mJrt0dNhhx9EwPiIVOkhrKyuM3loQu6XooPgUXtb
         3fcQ==
X-Gm-Message-State: AFqh2koisYT/S9vAzdzifWXut28Pm8kkave6tDIQI9GEzp/G2jUw6Ez+
        FtbUoGJ0KPULO2ijtdLTXiilgg==
X-Google-Smtp-Source: AMrXdXsWH2VxzTlgVDRHedju/McxB7qKu5r3nMyPPOEdRkw/0Gr4d5VTUMtfg6PAsD4lFt6cYxt7eA==
X-Received: by 2002:a05:600c:3545:b0:3c6:e60f:3f4a with SMTP id i5-20020a05600c354500b003c6e60f3f4amr26899413wmq.1.1674544607642;
        Mon, 23 Jan 2023 23:16:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7542:4469:3507:5738? ([2a01:e0a:982:cbb0:7542:4469:3507:5738])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003db30be4a54sm13316639wms.38.2023.01.23.23.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 23:16:47 -0800 (PST)
Message-ID: <0e48405a-d4e7-92a8-339f-4be2f4ec1378@linaro.org>
Date:   Tue, 24 Jan 2023 08:16:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 0/8] soc: amlogic: switch bindings to yaml and adjust some
 dtbs's
To:     Heiner Kallweit <hkallweit1@gmail.com>,
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
Content-Language: fr
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Heiner,

Le 23/01/2023 à 22:22, Heiner Kallweit a écrit :
> At first adjust some existing dtbs's so that they pass dtbs_check
> after switching bindings to yaml.

Thanks for this patchset, but please drop patches 1, 3 & 4, and take
in account the existing compatible usage in your new bindings like
I did in my conversion patchset.

While we did remove some bad compatibles we introduced a few years ago,
now the GXBB, GXL & GXM are now stable a aew LTS releases now and
a few other projects uses them as-is (U-Boot, BSDs, ...) so changing
the compatibles isn't an option anymore... and we can't know which
one they use and how the implementation behaves we must document
the existing usage without breaking any potential users (including linux).

Thanks,
Neil



> 
> Then switch further Amlogic Meson bindings to yaml.
> Tested with make targets dt_binding_check and dtbs_check.
> 
> Heiner Kallweit (8):
>    arm64: dts: meson-gx: Remove invalid pwm compatible
>    arm64: dts: amlogic: Fix non-compliant SD/SDIO node names
>    arm64: dts: meson-gx: Set only one compatible string for mmc
>    arm64: dts: amlogic: Remove invalid compatible string
>      amlogic,meson-gpio-intc
>    dt-bindings: rtc: Add Amlogic Meson vrtc controller binding
>    dt-bindings: pwm: Add Amlogic Meson PWM binding
>    dt-bindings: interrupt-controller: Add Amlogic Meson GPIO interrupt
>      controller binding
>    dt-bindings: pinctrl: Add Amlogic Meson pinctrl binding
> 
>   .../amlogic,meson-gpio-intc.txt               |  38 ------
>   .../amlogic,meson-gpio-intc.yaml              |  72 +++++++++++
>   .../pinctrl/amlogic,meson-pinctrl.yaml        | 121 ++++++++++++++++++
>   .../bindings/pinctrl/meson,pinctrl.txt        |  94 --------------
>   .../devicetree/bindings/pwm/pwm-amlogic.yaml  |  61 +++++++++
>   .../devicetree/bindings/pwm/pwm-meson.txt     |  29 -----
>   .../bindings/rtc/amlogic,meson-vrtc.yaml      |  50 ++++++++
>   .../bindings/rtc/rtc-meson-vrtc.txt           |  22 ----
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   5 +-
>   .../boot/dts/amlogic/meson-g12-common.dtsi    |   7 +-
>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  15 +--
>   arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |   3 +-
>   arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |   3 +-
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   3 +-
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |   3 +-
>   15 files changed, 320 insertions(+), 206 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl.yaml
>   delete mode 100644 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
>   create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>   delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
>   create mode 100644 Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
>   delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt
> 


