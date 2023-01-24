Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11391679187
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jan 2023 08:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjAXHET (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Jan 2023 02:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXHES (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Jan 2023 02:04:18 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354A330295;
        Mon, 23 Jan 2023 23:04:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v5so17239810edc.3;
        Mon, 23 Jan 2023 23:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gq0yjq1Pj3VqNap7K/pSurVYv79d/n7gtKKetfE4Jhc=;
        b=ReCyceVDlhZDGn2CsQqVGZ7zwziUAnol7HG/lyslhx6ED5vvGVkcvfHhutFNITVpY1
         FRAav/kHFJnhxgL+qV1BLpInOeaNbyHFhhRh+BlvGOZzetaJSig+6cpv8xnHXfK9K1D2
         6gTR+JX6CB1eFCs5k/BQqytEYIIcMPjVOOx8ND549yle752zjPwuJnUoTd7gqKgV8/sT
         XgF6IJJRrdmdjwKZem8Q84KjM9K9gBj4+Iw2nHzjzkEM1jE+CubhHG+mtRxrtmF/zBI2
         FCfyVD9TO+NGPqA9H0ltNPiVIrmbYYUKFdT2lgLu/XnJCbzzysgKs+iN1O7hepBs/6Sh
         713A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq0yjq1Pj3VqNap7K/pSurVYv79d/n7gtKKetfE4Jhc=;
        b=nYBxDyIKt52tzhbqTX7Pre8S5PW2t13GFh72LcEAXvOJD8tBdOLhrlYmn5UNC3UQdx
         uTByF0cJrKtJ/2Eah9RmIKJhgdctalnTnpGlCaEp2jXjESQ/avNxYXrivR0Oz3DoMjxv
         Lt3ngwUrw/KmRivBjJ/4eXFKFoBwCyTSqu4KM+dtwryPGQvTyc6NHtG6MwAFkttkhGRh
         ZIgbXrxWjI0Y9vGROAsA/VlnabZdFoG3oZKReMfawvE8ZWj+zYazyFhgAsjPAboZOcam
         +2KCYmRtcxoDkI42yM28Zla0bJ5aNPKGFTvdC0IN/V5AOqUDsx7EkzjFU3VskmznTtkz
         R9ig==
X-Gm-Message-State: AO0yUKWYoBayuLeJ9hcsbkqQKGI4eB5pGxFFEoY330bXs53mgP/w53eP
        Fwr1rwr7PVlZEZMh2++KN8c=
X-Google-Smtp-Source: AK7set8o6z3F1SEXP94ZDsneiKRfLncSo7VXCnTwehVCa6jaJYXnO3SajMTfjIuAKndx/00T+ryp2g==
X-Received: by 2002:a05:6402:528a:b0:49f:88ef:8d76 with SMTP id en10-20020a056402528a00b0049f88ef8d76mr2356129edb.29.1674543855438;
        Mon, 23 Jan 2023 23:04:15 -0800 (PST)
Received: from ?IPV6:2a01:c23:c139:7c00:8402:5a53:ddd5:ab2c? (dynamic-2a01-0c23-c139-7c00-8402-5a53-ddd5-ab2c.c23.pool.telefonica.de. [2a01:c23:c139:7c00:8402:5a53:ddd5:ab2c])
        by smtp.googlemail.com with ESMTPSA id i2-20020a170906444200b0084cb4d37b8csm480151ejp.141.2023.01.23.23.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 23:04:14 -0800 (PST)
Message-ID: <d8f0a5a9-5a16-1f63-8444-86434ff52e34@gmail.com>
Date:   Tue, 24 Jan 2023 08:03:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 7/8] dt-bindings: interrupt-controller: Add Amlogic Meson
 GPIO interrupt controller binding
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <06289641-18b1-320d-6162-7ae176452f31@gmail.com>
 <167452325371.3118653.16373677195744392136.robh@kernel.org>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <167452325371.3118653.16373677195744392136.robh@kernel.org>
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
> On Mon, 23 Jan 2023 22:30:08 +0100, Heiner Kallweit wrote:
>> Add Amlogic Meson GPIO interrupt controller binding.
>> Tested with make targets dt_binding_check and dtbs_check.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  .../amlogic,meson-gpio-intc.txt               | 38 ----------
>>  .../amlogic,meson-gpio-intc.yaml              | 72 +++++++++++++++++++
>>  2 files changed, 72 insertions(+), 38 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 

Patch 4 of the series fixes these warnings.
Did you apply the full series?


> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/06289641-18b1-320d-6162-7ae176452f31@gmail.com
> 
> 
> interrupt-controller@4080: compatible: ['amlogic,meson-s4-gpio-intc', 'amlogic,meson-gpio-intc'] is too long
> 	arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb
> 
> interrupt-controller@9880: compatible:0: 'amlogic,meson-gpio-intc' is not one of ['amlogic,meson8-gpio-intc', 'amlogic,meson8b-gpio-intc', 'amlogic,meson-gxbb-gpio-intc', 'amlogic,meson-gxl-gpio-intc', 'amlogic,meson-axg-gpio-intc', 'amlogic,meson-g12a-gpio-intc', 'amlogic,meson-sm1-gpio-intc', 'amlogic,meson-a1-gpio-intc', 'amlogic,meson-s4-gpio-intc', 'amlogic,meson-sc2-gpio-intc']
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-gt1-ultimate.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-mecool-kiii-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-minix-neo-u9h.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-q200.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-q201.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dtb
> 	arch/arm/boot/dts/meson8b-ec100.dtb
> 	arch/arm/boot/dts/meson8b-mxq.dtb
> 	arch/arm/boot/dts/meson8b-odroidc1.dtb
> 
> interrupt-controller@9880: compatible: ['amlogic,meson8-gpio-intc', 'amlogic,meson-gpio-intc'] is too long
> 	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
> 	arch/arm/boot/dts/meson8-minix-neo-x8.dtb
> 
> interrupt-controller@9880: compatible: ['amlogic,meson-gpio-intc', 'amlogic,meson8b-gpio-intc'] is too long
> 	arch/arm/boot/dts/meson8b-ec100.dtb
> 	arch/arm/boot/dts/meson8b-mxq.dtb
> 	arch/arm/boot/dts/meson8b-odroidc1.dtb
> 
> interrupt-controller@9880: compatible: ['amlogic,meson-gpio-intc', 'amlogic,meson-gxbb-gpio-intc'] is too long
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dtb
> 
> interrupt-controller@9880: compatible: ['amlogic,meson-gpio-intc', 'amlogic,meson-gxl-gpio-intc'] is too long
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-gt1-ultimate.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-mecool-kiii-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-minix-neo-u9h.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-q200.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-q201.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dtb
> 	arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dtb
> 
> interrupt-controller@f080: compatible: ['amlogic,meson-axg-gpio-intc', 'amlogic,meson-gpio-intc'] is too long
> 	arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dtb
> 	arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dtb
> 	arch/arm64/boot/dts/amlogic/meson-axg-s400.dtb
> 
> interrupt-controller@f080: compatible: ['amlogic,meson-g12a-gpio-intc', 'amlogic,meson-gpio-intc'] is too long
> 	arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12a-u200.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dtb
> 	arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dtb
> 
> interrupt-controller@f080: compatible: ['amlogic,meson-sm1-gpio-intc', 'amlogic,meson-gpio-intc'] is too long
> 	arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dtb
> 	arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dtb
> 	arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dtb
> 	arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dtb
> 	arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dtb
> 	arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dtb
> 	arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dtb
> 	arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dtb
> 	arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dtb
> 	arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dtb
> 

