Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7F4686F63
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Feb 2023 20:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjBAT5x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Feb 2023 14:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjBAT5x (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Feb 2023 14:57:53 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE82F1E5CF;
        Wed,  1 Feb 2023 11:57:51 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f7so11646388edw.5;
        Wed, 01 Feb 2023 11:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nbuyl7LvCUFmULBk+luDWMTsBcFBqdWcL+IpHpfcGe8=;
        b=YR2Tw7n7yEIg54prt0s3LcXFpSYSBWD38YayxwxASTIO/s4OiwgLtubxtMwcMpH8+S
         xMCpEUhiezRxTh1x0Std5TnmWm0nyqVE8zFpB5SpjfTnkvSIlTmqbHl9qn6js/hZZf3m
         p7ou6b7YW/fZKwVJBJCNLlxLFvcdBhxxtjifzN1Y6CqfKqqm7vo4vHRCcGIjgpHVhWfq
         WI/m0+NSuKdgrfq54Ue739oXqIPyzzfhS0XMZB7bwMuuVt2Esb/Xf8GtQ8ke+c4DfEMl
         dIFiV2w+0G+aIYVMpV753+GJvS6mUlGP1gMkeNz4InzHIztR6Rj/wLcyhEjupIU0u+1R
         Cllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nbuyl7LvCUFmULBk+luDWMTsBcFBqdWcL+IpHpfcGe8=;
        b=tSxnjKA1+fnjQ58TQKa1ZZ/mchFiWGn2WZdY5hm4JwhzB2oLnLuw4iFiguyduqlKPT
         l7MrLU953GXMWk4Ns4OLxdo4CGU8UdA+W1iWkAQUMrBm+XTCx1wEx50sW6WgUjxv/Dee
         jcqFCSsc1Cz26U84VzS7lLKOeHGGKSvK0kxcfGdXh+X0FrVYVFCcLA0z9ttBtsyHgux+
         EkSfXQMqq3MKQSrtPmfdmpDtd8xq+zs3M5tuHB9Xc5UqZNCkAvl1jLs1eWELUlrCVooz
         J/RT9O/CQ4gsphYpDYE285CGEk5N5EC0Uwo19WoWbOfIVwYgyvP0/L0HFxMbpxHFWfTq
         n2Rg==
X-Gm-Message-State: AO0yUKWPHZ+ZYqfzWsgn4P83pS46sMMoqPUkyykcMdC3yRhFXnlQmlmi
        t4cngzUaL+do0eTDz4cXB9k=
X-Google-Smtp-Source: AK7set+GI7HhysY3JX/WRp5iUFfCA+K5YmLjYE53kw7Js72+bUO9lFyXk/XUEc0wQuQNk34amxoXbQ==
X-Received: by 2002:a05:6402:292a:b0:4a2:471a:4d26 with SMTP id ee42-20020a056402292a00b004a2471a4d26mr3028603edb.10.1675281470074;
        Wed, 01 Feb 2023 11:57:50 -0800 (PST)
Received: from ?IPV6:2a01:c23:b912:d400:3963:7bc4:12b:ddb3? (dynamic-2a01-0c23-b912-d400-3963-7bc4-012b-ddb3.c23.pool.telefonica.de. [2a01:c23:b912:d400:3963:7bc4:12b:ddb3])
        by smtp.googlemail.com with ESMTPSA id m5-20020aa7c485000000b0049e19136c22sm10170677edq.95.2023.02.01.11.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 11:57:49 -0800 (PST)
Message-ID: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
Date:   Wed, 1 Feb 2023 20:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/4] soc: amlogic: switch bindings to yaml and adjust some
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

Switch two Amlogic Meson bindings to yaml. As prerequisite adjust the
order of some compatibles first.

New versions of the bindings have been submitted as individual
patches in between. Put it into a series again.

Heiner Kallweit (4):
  arm: dts: meson: adjust order of some compatibles
  arm64: dts: meson: adjust order of some compatibles
  dt-bindings: pwm: Convert Amlogic Meson PWM binding
  dt-bindings: interrupt-controller: Convert Amlogic Meson GPIO
    interrupt controller binding

 .../amlogic,meson-gpio-intc.txt               | 38 ----------
 .../amlogic,meson-gpio-intc.yaml              | 72 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 70 ++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-meson.txt     | 29 --------
 arch/arm/boot/dts/meson8b.dtsi                |  4 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |  4 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  4 +-
 7 files changed, 148 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt

-- 
2.39.1

