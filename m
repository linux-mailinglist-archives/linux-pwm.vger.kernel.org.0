Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7968E5A9FAB
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Sep 2022 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiIATPE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Sep 2022 15:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiIATPA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Sep 2022 15:15:00 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE922642;
        Thu,  1 Sep 2022 12:14:59 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11e9a7135easo31495210fac.6;
        Thu, 01 Sep 2022 12:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VtMkuQSRm5s1MtIjNa1EI8yp4U/CIxvqBb2k57VJBOU=;
        b=fWu6xD8tfkhFtB1j9Y8rmyGRFUhARegqat6A9dZTujn2fk5EVwOSYU7yN0zUncF6vD
         Xh7hTD0L4jvnApT1IlA5tzqv7KxEC0k169+MvyYUveQ31cnk8OCjAXYKvWk+KOirV0XM
         yU3DG391HDf9q7gqcnfQ+/8YcUKGeOQW7CYhRwLYQJWmE1hhhBhTyxjuRL/3niJNQ33j
         9gIVxAxcFfhx7S4dyLje3Nu9r1o1kypXQkiFbRCYiAY6Yq3jdcF1OjNjVNAiz09pFGcn
         tUfcvnehOfMI2PtkIbXNaXAqo2Wwsp/aThDeXIvTuKpoNDcVu/vSnEHScprMaE35MvY3
         7q5A==
X-Gm-Message-State: ACgBeo2U4XD8JQ9neK0CyF54sx8PgKqIfS/M58skadyYcZxdzV082gLg
        7vLz6k/EHLu89dE2DuciBw==
X-Google-Smtp-Source: AA6agR68L2pMI+zsGWYQfVqT4QIh1hXgYYBwcPPZuBXZjrexaF099gi6TRxkvCJOAByhjpke28ugXw==
X-Received: by 2002:a05:6871:7a4:b0:11e:b321:c396 with SMTP id o36-20020a05687107a400b0011eb321c396mr327886oap.241.1662059697438;
        Thu, 01 Sep 2022 12:14:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x13-20020a9d588d000000b00636fd78dd57sm32059otg.41.2022.09.01.12.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:14:57 -0700 (PDT)
Received: (nullmailer pid 2226884 invoked by uid 1000);
        Thu, 01 Sep 2022 19:14:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com, linux-pwm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <20220901135523.52151-1-sebastian.reichel@collabora.com>
References: <20220901135523.52151-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/1] dt-bindings: pwm: rockchip: Add description for rk3588
Date:   Thu, 01 Sep 2022 14:14:55 -0500
Message-Id: <1662059695.095333.2226883.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 01 Sep 2022 15:55:23 +0200, Sebastian Reichel wrote:
> Add "rockchip,rk3588-pwm" compatible string for PWM nodes found
> on a rk3588 platform.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> No driver changes required.
> ---
>  Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


pwm@10280000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rv1108-elgin-r1.dtb
	arch/arm/boot/dts/rv1108-evb.dtb

pwm@10280010: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rv1108-elgin-r1.dtb
	arch/arm/boot/dts/rv1108-evb.dtb

pwm@10280020: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rv1108-elgin-r1.dtb
	arch/arm/boot/dts/rv1108-evb.dtb

pwm@10280030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rv1108-elgin-r1.dtb
	arch/arm/boot/dts/rv1108-evb.dtb

pwm@20040000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rv1108-elgin-r1.dtb
	arch/arm/boot/dts/rv1108-evb.dtb

pwm@20040010: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rv1108-elgin-r1.dtb
	arch/arm/boot/dts/rv1108-evb.dtb

pwm@20040020: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rv1108-elgin-r1.dtb
	arch/arm/boot/dts/rv1108-evb.dtb

pwm@20040030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/rv1108-elgin-r1.dtb
	arch/arm/boot/dts/rv1108-evb.dtb

pwm@ff1b0030: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dtb
	arch/arm64/boot/dts/rockchip/rk3328-a1.dtb
	arch/arm64/boot/dts/rockchip/rk3328-evb.dtb
	arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dtb
	arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dtb
	arch/arm64/boot/dts/rockchip/rk3328-rock64.dtb
	arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dtb
	arch/arm64/boot/dts/rockchip/rk3328-roc-pc.dtb

