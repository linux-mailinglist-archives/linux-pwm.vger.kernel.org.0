Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC98A678D4D
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jan 2023 02:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjAXBX4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Jan 2023 20:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbjAXBXz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Jan 2023 20:23:55 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C62BF12;
        Mon, 23 Jan 2023 17:23:24 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id k44-20020a9d19af000000b00683e176ab01so8379332otk.13;
        Mon, 23 Jan 2023 17:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V1sgADgA70SKeXhD/RheeeugqRShv1VPpwgsy/A47Bo=;
        b=sxA6eM/C6VkUe5xqf0iYUox08lyBHB93W7UmeDHndrW7TV47ryfXcIKoFw4MGQ0CaE
         jE4quliMp77WNNh9qufWEsfA7Itw05/KlVFusvwx8y907UQDFR3bMa8uRCyxZK7JidIx
         ELQsVhtZceZQtptaJfpZixVYaCAZPEOfX1ydt/s/nJazvsIxMt8qsHdGW1CnVHkdGHMO
         PzOIectaoZpW6y4eAfJBuJAW3gTU99Yk8/lWN71HngMbx0YPTjcd0wofTy80oTJfgapI
         MgpXOvHNd60DPkkC1A/YXKD2um+wcrHPltADQBT/AdivVYbutazIDDvuzCOsnen5D+vc
         qCuA==
X-Gm-Message-State: AFqh2kpYX0CMyfdAjvyyVq0WJEewsakUh+tPYzpdLU0He9SY84OXAp/Y
        oiGrbdSDWPgqWmy++a4WIw==
X-Google-Smtp-Source: AMrXdXvmGDew3Bm1N7N4NrHTPEZ/EnDXGdyJAibQDZF1jWycasGn07D0bPUpJAQzs9TdUOf3LSF0CQ==
X-Received: by 2002:a05:6830:1048:b0:66e:a83e:9e6b with SMTP id b8-20020a056830104800b0066ea83e9e6bmr13809933otp.25.1674523367356;
        Mon, 23 Jan 2023 17:22:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e14-20020a056830200e00b0066eab2ec808sm369992otp.1.2023.01.23.17.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 17:22:46 -0800 (PST)
Received: (nullmailer pid 3121725 invoked by uid 1000);
        Tue, 24 Jan 2023 01:22:42 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
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
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
In-Reply-To: <69188960-9d88-4163-8a87-1820fb673eb9@gmail.com>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
 <69188960-9d88-4163-8a87-1820fb673eb9@gmail.com>
Message-Id: <167452325471.3119159.12105704680288885350.robh@kernel.org>
Subject: Re: [PATCH 8/8] dt-bindings: pinctrl: Add Amlogic Meson pinctrl binding
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


On Mon, 23 Jan 2023 22:30:44 +0100, Heiner Kallweit wrote:
> Add Amlogic Meson pinctrl binding.
> Tested with make targets dt_binding_check and dtbs_check.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  .../pinctrl/amlogic,meson-pinctrl.yaml        | 121 ++++++++++++++++++
>  .../bindings/pinctrl/meson,pinctrl.txt        |  94 --------------
>  2 files changed, 121 insertions(+), 94 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/69188960-9d88-4163-8a87-1820fb673eb9@gmail.com


pinctrl@84: #address-cells:0:0: 2 was expected
	arch/arm/boot/dts/meson8b-ec100.dtb
	arch/arm/boot/dts/meson8b-mxq.dtb
	arch/arm/boot/dts/meson8b-odroidc1.dtb
	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
	arch/arm/boot/dts/meson8-minix-neo-x8.dtb

pinctrl@84: compatible: ['amlogic,meson8m2-aobus-pinctrl', 'amlogic,meson8-aobus-pinctrl'] is too long
	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb

pinctrl@84: reg: 'anyOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/meson8b-ec100.dtb
	arch/arm/boot/dts/meson8b-mxq.dtb
	arch/arm/boot/dts/meson8b-odroidc1.dtb
	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
	arch/arm/boot/dts/meson8-minix-neo-x8.dtb

pinctrl@84: #size-cells:0:0: 2 was expected
	arch/arm/boot/dts/meson8b-ec100.dtb
	arch/arm/boot/dts/meson8b-mxq.dtb
	arch/arm/boot/dts/meson8b-odroidc1.dtb
	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
	arch/arm/boot/dts/meson8-minix-neo-x8.dtb

pinctrl@9880: #address-cells:0:0: 2 was expected
	arch/arm/boot/dts/meson8b-ec100.dtb
	arch/arm/boot/dts/meson8b-mxq.dtb
	arch/arm/boot/dts/meson8b-odroidc1.dtb
	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
	arch/arm/boot/dts/meson8-minix-neo-x8.dtb

pinctrl@9880: compatible: ['amlogic,meson8m2-cbus-pinctrl', 'amlogic,meson8-cbus-pinctrl'] is too long
	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb

pinctrl@9880: reg: 'anyOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/meson8b-ec100.dtb
	arch/arm/boot/dts/meson8b-mxq.dtb
	arch/arm/boot/dts/meson8b-odroidc1.dtb
	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
	arch/arm/boot/dts/meson8-minix-neo-x8.dtb

pinctrl@9880: #size-cells:0:0: 2 was expected
	arch/arm/boot/dts/meson8b-ec100.dtb
	arch/arm/boot/dts/meson8b-mxq.dtb
	arch/arm/boot/dts/meson8b-odroidc1.dtb
	arch/arm/boot/dts/meson8m2-mxiii-plus.dtb
	arch/arm/boot/dts/meson8-minix-neo-x8.dtb

