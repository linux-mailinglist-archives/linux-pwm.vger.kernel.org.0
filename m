Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB637678D4A
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jan 2023 02:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjAXBXz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Jan 2023 20:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjAXBXy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Jan 2023 20:23:54 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E60305E2;
        Mon, 23 Jan 2023 17:23:22 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id j10-20020a4aa64a000000b004f9b746ee29so2433261oom.0;
        Mon, 23 Jan 2023 17:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2cQMAwwRREiwr/oZxVGOyaxb8i+wrIpEeXOLH8JzHGE=;
        b=zzNhWldsZMzxwDgcjg98oROoYjVrD/BUJrBZ4PSIFBS7/JMtEZ1Eu6zva2d+0LLr/n
         zlcjcOaltmmw1WN7vnj8+1UYpqYffhpAvl/uxe3s5/71OpdaIgwh1aoU5FEnrtZ+5ymb
         7p0dgQ24Gpr33NELtJ5St48Yj/94GahipdgvqE+fPVuXC600e8hG4fj5ygrzr5aj4Rjn
         EyfQ7aT/lEXUPnBp5HC2HiAH/lxYml4x7jBIenHrkCLJHTxHpSNJuo2u5ABTSXt5F6mI
         3thKUSagvC4auyCt0IhoWBJ3NsGrh6p8U6btFrcJMA62BApHe25qjJlGjBKTdoSMg58g
         YM3w==
X-Gm-Message-State: AFqh2koOrMsONkKErIY4sr70GvrGnPbE57Ir+PtkYsjKne3B0iakKodv
        8JxTHzKTGnJwWMTRHUHfRA==
X-Google-Smtp-Source: AMrXdXujZwMm6fXYSgOameyhHf0Aq2138aPsqvYqCTkEXLOXKLmaxvKaplYwPXK4MO3oQ+4UfNXC9g==
X-Received: by 2002:a4a:8c68:0:b0:4a3:aa96:23c7 with SMTP id v37-20020a4a8c68000000b004a3aa9623c7mr11797638ooj.6.1674523365895;
        Mon, 23 Jan 2023 17:22:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a4a984e000000b004fca8a11c61sm277950ooi.3.2023.01.23.17.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:22:45 -0800 (PST)
Received: (nullmailer pid 3121723 invoked by uid 1000);
        Tue, 24 Jan 2023 01:22:42 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
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
        =?utf-8?q?=2C?= "devicetree@vger.kernel.org" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
In-Reply-To: <06289641-18b1-320d-6162-7ae176452f31@gmail.com>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <06289641-18b1-320d-6162-7ae176452f31@gmail.com>
Message-Id: <167452325371.3118653.16373677195744392136.robh@kernel.org>
Subject: Re: [PATCH 7/8] dt-bindings: interrupt-controller: Add Amlogic Meson
 GPIO interrupt controller binding
Date:   Mon, 23 Jan 2023 19:22:42 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Mon, 23 Jan 2023 22:30:08 +0100, Heiner Kallweit wrote:
> Add Amlogic Meson GPIO interrupt controller binding.
> Tested with make targets dt_binding_check and dtbs_check.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  .../amlogic,meson-gpio-intc.txt               | 38 ----------
>  .../amlogic,meson-gpio-intc.yaml              | 72 +++++++++++++++++++
>  2 files changed, 72 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/06289641-18b1-320d-6162-7ae176452f31@gmail.com


interrupt-controller@4080: compatible: ['amlogic,meson-s4-gpio-intc', 'amlogic,meson-gpio-intc'] is too long
	arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dtb

interrupt-controller@9880: compatible:0: 'amlogic,meson-gpio-intc' is not one of ['amlogic,meson8-gpio-intc', 'amlogic,meson8b-gpio-intc', 'amlogic,meson-gxbb-gpio-intc', 'amlogic,meson-gxl-gpio-intc', 'amlogic,meson-axg-gpio-intc', 'amlogic,meson-g12a-gpio-intc', 'amlogic,meson-sm1-gpio-intc', 'amlogic,meson-a1-gpio-intc', 'amlogic,meson-s4-gpio-intc', 'amlogic,meson-sc2-gpio-intc']
	arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-gt1-ultimate.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-mecool-kiii-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-minix-neo-u9h.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-q200.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-q201.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dtb
	arch/arm/boot/dts/meson8b-ec100.dtb
	arch/arm/boot/dts/meson8b-mxq.dtb
	arch/arm/boot/dts/meson8b-odroidc1.dtb

interrupt-controller@9880: compatible: ['amlogic,meson8-gpio-intc', 'amlogic,meson-gpio-intc'] is too long
	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
	arch/arm/boot/dts/meson8-minix-neo-x8.dtb

interrupt-controller@9880: compatible: ['amlogic,meson-gpio-intc', 'amlogic,meson8b-gpio-intc'] is too long
	arch/arm/boot/dts/meson8b-ec100.dtb
	arch/arm/boot/dts/meson8b-mxq.dtb
	arch/arm/boot/dts/meson8b-odroidc1.dtb

interrupt-controller@9880: compatible: ['amlogic,meson-gpio-intc', 'amlogic,meson-gxbb-gpio-intc'] is too long
	arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dtb
	arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dtb

interrupt-controller@9880: compatible: ['amlogic,meson-gpio-intc', 'amlogic,meson-gxl-gpio-intc'] is too long
	arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-mecool-kii-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-sml5442tw.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-p281.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dtb
	arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-gt1-ultimate.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-mecool-kiii-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-minix-neo-u9h.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-q200.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-q201.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dtb
	arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dtb

interrupt-controller@f080: compatible: ['amlogic,meson-axg-gpio-intc', 'amlogic,meson-gpio-intc'] is too long
	arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j100.dtb
	arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-2.dtb
	arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j110-rev-3.dtb
	arch/arm64/boot/dts/amlogic/meson-axg-s400.dtb

interrupt-controller@f080: compatible: ['amlogic,meson-g12a-gpio-intc', 'amlogic,meson-gpio-intc'] is too long
	arch/arm64/boot/dts/amlogic/meson-g12a-radxa-zero.dtb
	arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dtb
	arch/arm64/boot/dts/amlogic/meson-g12a-u200.dtb
	arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dtb
	arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dtb
	arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dtb
	arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dtb
	arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dtb
	arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dtb
	arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtb
	arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dtb
	arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dtb
	arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dtb

interrupt-controller@f080: compatible: ['amlogic,meson-sm1-gpio-intc', 'amlogic,meson-gpio-intc'] is too long
	arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air.dtb
	arch/arm64/boot/dts/amlogic/meson-sm1-a95xf3-air-gbit.dtb
	arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dtb
	arch/arm64/boot/dts/amlogic/meson-sm1-h96-max.dtb
	arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dtb
	arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dtb
	arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dtb
	arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dtb
	arch/arm64/boot/dts/amlogic/meson-sm1-x96-air.dtb
	arch/arm64/boot/dts/amlogic/meson-sm1-x96-air-gbit.dtb

