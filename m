Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C546791B7
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jan 2023 08:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjAXHOR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Jan 2023 02:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAXHOQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Jan 2023 02:14:16 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03A91A6;
        Mon, 23 Jan 2023 23:14:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v10so17226994edi.8;
        Mon, 23 Jan 2023 23:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R/gscYi2CxqFQn/wHKaRq7cLM4225WOiA33RvJa6O3g=;
        b=GEGmlW6RXixgZLaBN1PDq4KYA+MYsAky/BGFsvi6dIHiQ4i5FNAkO2ibqCc6WxVzKG
         Lo5ePI6vLLAUN5L8R/+I4wZeq4gmnwyEC/AsznF0Uq59YCxnBQQCX+U6tv3aW3//EmvE
         1C0LN059V2PLbOWZsTlU+wwXvVjIgiKHyEfTyvOot7ZpmoCwrmoaPz4xQ1t3Nkag4FGZ
         tT/sfY8r8h5mjB6PeKhrqHGs0FkQAdtg3Bbls3RXRCC/sZx5N2LsHJ1AjBjpJuSzcBSK
         r87c7lfv/rW5+DWHT9HDVqSn1QXMZ79SwrMTtVrkH1vrj6Vd78kkdV9/u/nUtxv9GBVI
         uQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/gscYi2CxqFQn/wHKaRq7cLM4225WOiA33RvJa6O3g=;
        b=zwEtthYUMttgm6k7+GD8efQo+ETsCCUDkvCFylofaRoTVmfXTUGbA6vDDrkG9UQp+h
         qv1BMbr5Mn7FzLIzNlRvfwGL6RC012ldzXDJbhDhsVp3o8h5Qh0r5VXyVwXDH3qZDhrE
         vFkBVCyzsFyXy+bLd+OhUwNhnU2wykEvwY/k7eJdzPRYoFlTwDN96ntJM1k3NWL0vVZY
         mfmONf+RjGrMr3A5rFUpWCt0tFo97z3PqEdSBvgyq0z92R9W3vuXCAuzOPVE7MOVoNAm
         0DwGkzN+jS8eZYyEHriufTD6LjTtn/QjKKVJUFWfjApxnzPfKnhRDXx+F8nVtTfionf2
         H1SA==
X-Gm-Message-State: AFqh2kpfhaG2sjHI6w1d94NwL6xNAZn+UnqLbFY0JocWAF5nbSF82mUA
        mxoR3ry9v/bbyk5JaIXK4DI=
X-Google-Smtp-Source: AMrXdXvFkJvbBmITEt6DIqeWCdJcnHQKODdiqadQqUg4hRR5JJfLcF9kimnHbW9lIjH+l3gpJDcwAA==
X-Received: by 2002:a05:6402:24a0:b0:499:70a8:f918 with SMTP id q32-20020a05640224a000b0049970a8f918mr33964222eda.16.1674544453198;
        Mon, 23 Jan 2023 23:14:13 -0800 (PST)
Received: from ?IPV6:2a01:c23:c139:7c00:8402:5a53:ddd5:ab2c? (dynamic-2a01-0c23-c139-7c00-8402-5a53-ddd5-ab2c.c23.pool.telefonica.de. [2a01:c23:c139:7c00:8402:5a53:ddd5:ab2c])
        by smtp.googlemail.com with ESMTPSA id s10-20020a056402520a00b0049ea0854ba9sm406823edd.52.2023.01.23.23.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 23:14:12 -0800 (PST)
Message-ID: <04f4edd0-56ea-6c4b-1e0a-638c937ae945@gmail.com>
Date:   Tue, 24 Jan 2023 08:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 8/8] dt-bindings: pinctrl: Add Amlogic Meson pinctrl
 binding
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <69188960-9d88-4163-8a87-1820fb673eb9@gmail.com>
 <167452325471.3119159.12105704680288885350.robh@kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <167452325471.3119159.12105704680288885350.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 24.01.2023 02:22, Rob Herring wrote:
> 
> On Mon, 23 Jan 2023 22:30:44 +0100, Heiner Kallweit wrote:
>> Add Amlogic Meson pinctrl binding.
>> Tested with make targets dt_binding_check and dtbs_check.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  .../pinctrl/amlogic,meson-pinctrl.yaml        | 121 ++++++++++++++++++
>>  .../bindings/pinctrl/meson,pinctrl.txt        |  94 --------------
>>  2 files changed, 121 insertions(+), 94 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
>>
> 

Thanks, I didn't catch these warnings because Meson8 support isn't
enabled on my system. Will look into it.

> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/69188960-9d88-4163-8a87-1820fb673eb9@gmail.com
> 
> 
> pinctrl@84: #address-cells:0:0: 2 was expected
> 	arch/arm/boot/dts/meson8b-ec100.dtb
> 	arch/arm/boot/dts/meson8b-mxq.dtb
> 	arch/arm/boot/dts/meson8b-odroidc1.dtb
> 	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
> 	arch/arm/boot/dts/meson8-minix-neo-x8.dtb
> 
> pinctrl@84: compatible: ['amlogic,meson8m2-aobus-pinctrl', 'amlogic,meson8-aobus-pinctrl'] is too long
> 	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
> 
> pinctrl@84: reg: 'anyOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/meson8b-ec100.dtb
> 	arch/arm/boot/dts/meson8b-mxq.dtb
> 	arch/arm/boot/dts/meson8b-odroidc1.dtb
> 	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
> 	arch/arm/boot/dts/meson8-minix-neo-x8.dtb
> 
> pinctrl@84: #size-cells:0:0: 2 was expected
> 	arch/arm/boot/dts/meson8b-ec100.dtb
> 	arch/arm/boot/dts/meson8b-mxq.dtb
> 	arch/arm/boot/dts/meson8b-odroidc1.dtb
> 	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
> 	arch/arm/boot/dts/meson8-minix-neo-x8.dtb
> 
> pinctrl@9880: #address-cells:0:0: 2 was expected
> 	arch/arm/boot/dts/meson8b-ec100.dtb
> 	arch/arm/boot/dts/meson8b-mxq.dtb
> 	arch/arm/boot/dts/meson8b-odroidc1.dtb
> 	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
> 	arch/arm/boot/dts/meson8-minix-neo-x8.dtb
> 
> pinctrl@9880: compatible: ['amlogic,meson8m2-cbus-pinctrl', 'amlogic,meson8-cbus-pinctrl'] is too long
> 	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
> 
> pinctrl@9880: reg: 'anyOf' conditional failed, one must be fixed:
> 	arch/arm/boot/dts/meson8b-ec100.dtb
> 	arch/arm/boot/dts/meson8b-mxq.dtb
> 	arch/arm/boot/dts/meson8b-odroidc1.dtb
> 	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
> 	arch/arm/boot/dts/meson8-minix-neo-x8.dtb
> 
> pinctrl@9880: #size-cells:0:0: 2 was expected
> 	arch/arm/boot/dts/meson8b-ec100.dtb
> 	arch/arm/boot/dts/meson8b-mxq.dtb
> 	arch/arm/boot/dts/meson8b-odroidc1.dtb
> 	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
> 	arch/arm/boot/dts/meson8-minix-neo-x8.dtb
> 

