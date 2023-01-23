Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F4678970
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jan 2023 22:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbjAWVW2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Jan 2023 16:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjAWVW2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Jan 2023 16:22:28 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE563526C;
        Mon, 23 Jan 2023 13:22:26 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y19so16230732edc.2;
        Mon, 23 Jan 2023 13:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/m9fxwpEbZpN8X/D6lwA+MFLaC8U37ezUMxtxmuH1s=;
        b=nHYnC2veAbsrTjlHDQZR0BhSSYSQHFBMBLaA06XtKf/JcBy5o8Qo7rR09XYFpWbUEQ
         zUOF/c0nEFw/jpxdxY0TfQt3XGGuupq5k+GM3BFNMVNokLyG6Kk1IjtfDSXvHP48ZG13
         jdOgZSqvN3oJXcHwsBtb9UDARHudBrRRed8l6Isn9nuA4nQuuylTDdPnfDcXiZqSEILN
         gWO7GzisBtbyiAwsbduiUw3652oAUhn8vy/MxZKL9AZXx0cbkrVRsYgm9na9wU7vZ5Fs
         WThJGOxnqxCx06877AWz0wv5I7DlCBeQVyGjt7IoWTH2E3KUbvDlkObUuIZjI+xI/qTV
         YVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O/m9fxwpEbZpN8X/D6lwA+MFLaC8U37ezUMxtxmuH1s=;
        b=hGifrAa0OWc5cLMtG4cxl1MC5lqEOWp8v4/khIuELyK4FonZ43BF2GXdiqNB4gtRSG
         +FXnhTwaNCYiyUBo950QENaOhQAWGkTWgB1s+gr36YtZDH7luGRd40pUtxleeMV2Wmjl
         OhLQaB5iDylddhPRkxVTN2tDWwGXAmp/STdpDkv2dctb+aDkJ1Bh6fIlluFRMXBhD9Kl
         uBAgd4yP0yW2k1GjqM5dCrNChtGUHWuxtJP9TYlakAUo/M04i/3xxTAAnE+vEQAQkyj/
         SI5M5nVQMnJ/qitwsk85wctLhnjaiV+YCraVU6GCpzwwaga/sj6T3CVdlWZKHC9wJpa8
         AQcg==
X-Gm-Message-State: AFqh2koOwsoXdHVXDaqP3ajgMXIalNtkWuUorPC8T7stvi31+wR+ezSD
        EBysxTeF67wBXEPvAmxvMyk=
X-Google-Smtp-Source: AMrXdXsecJ0Lmw0T6hteu5NgTW5sF1ad5h25d+1oE8fDr0Fwmliz4MOIjn5MfXF/7fkBbotfYHdm0g==
X-Received: by 2002:a05:6402:5296:b0:49c:3cf4:d9ed with SMTP id en22-20020a056402529600b0049c3cf4d9edmr30260243edb.23.1674508945276;
        Mon, 23 Jan 2023 13:22:25 -0800 (PST)
Received: from ?IPV6:2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7? (dynamic-2a01-0c23-bc5b-9400-dc4c-6fb7-47b2-beb7.c23.pool.telefonica.de. [2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7])
        by smtp.googlemail.com with ESMTPSA id cm28-20020a0564020c9c00b0049e9fe9abcasm213409edb.44.2023.01.23.13.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 13:22:24 -0800 (PST)
Message-ID: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
Date:   Mon, 23 Jan 2023 22:22:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/8] soc: amlogic: switch bindings to yaml and adjust some
 dtbs's
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

At first adjust some existing dtbs's so that they pass dtbs_check
after switching bindings to yaml.

Then switch further Amlogic Meson bindings to yaml.
Tested with make targets dt_binding_check and dtbs_check.

Heiner Kallweit (8):
  arm64: dts: meson-gx: Remove invalid pwm compatible
  arm64: dts: amlogic: Fix non-compliant SD/SDIO node names
  arm64: dts: meson-gx: Set only one compatible string for mmc
  arm64: dts: amlogic: Remove invalid compatible string
    amlogic,meson-gpio-intc
  dt-bindings: rtc: Add Amlogic Meson vrtc controller binding
  dt-bindings: pwm: Add Amlogic Meson PWM binding
  dt-bindings: interrupt-controller: Add Amlogic Meson GPIO interrupt
    controller binding
  dt-bindings: pinctrl: Add Amlogic Meson pinctrl binding

 .../amlogic,meson-gpio-intc.txt               |  38 ------
 .../amlogic,meson-gpio-intc.yaml              |  72 +++++++++++
 .../pinctrl/amlogic,meson-pinctrl.yaml        | 121 ++++++++++++++++++
 .../bindings/pinctrl/meson,pinctrl.txt        |  94 --------------
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  |  61 +++++++++
 .../devicetree/bindings/pwm/pwm-meson.txt     |  29 -----
 .../bindings/rtc/amlogic,meson-vrtc.yaml      |  50 ++++++++
 .../bindings/rtc/rtc-meson-vrtc.txt           |  22 ----
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   5 +-
 .../boot/dts/amlogic/meson-g12-common.dtsi    |   7 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  15 +--
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |   3 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |   3 +-
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   3 +-
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |   3 +-
 15 files changed, 320 insertions(+), 206 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt

-- 
2.39.1

