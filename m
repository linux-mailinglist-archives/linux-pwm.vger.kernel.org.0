Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71536791C9
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Jan 2023 08:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjAXHSC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Jan 2023 02:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjAXHSB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Jan 2023 02:18:01 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7476976B9
        for <linux-pwm@vger.kernel.org>; Mon, 23 Jan 2023 23:17:56 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id n7so12922622wrx.5
        for <linux-pwm@vger.kernel.org>; Mon, 23 Jan 2023 23:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VK1e6exqqlScuIzxu3kNmwlgTnCtE6Xr3k93M7x3/qM=;
        b=u5z15n4Cyt2W8vpNpjDEUeibtG9KHLxTHPITggkl6YipYA5BXWZ7/ft4hggv0FDPB9
         PK+Nzz9u4k22ogUnKlyaMoStBoHq36k9tnELpawylWBgOzKjH24AqP5EoUJg8nP/j5JC
         7qfbyrBwPAJBOQeDyW1+9gtnBsodssyGQLbXIwnAAcRwe+9Htsl7d2PdGMMQ+KQ33jR1
         6IGA5AGS/Bs1jAmEjr+ugu/XSrwDHcF7cJtzaxEbP77pq7CVPbnTDa17+Pd26pIB3iJD
         LxNctTqt2rhXFwlCLbPNRC2Uspa54BJ5j0kq3toy/k9GBvlsjGUtn09KGQwCbrBdu9tI
         N49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VK1e6exqqlScuIzxu3kNmwlgTnCtE6Xr3k93M7x3/qM=;
        b=wBPlWDV19KPzEu9oxgEp3RiNz9BlM69QVJa+/pF0kX4b6iv9E6aKm+TmonTEAF3ISZ
         0Sue4YTz78dHQqzLifRq2O2Od0lwVTmbkHwJmGVjeA/LHuAqQDRX1sbYH4Ncgs/xkac+
         cWR8RqmIqhAyl/FcpN9mcgfInKWlT1+NQhsRyXpojrjNjUzOKeXse/e+cNVgP91luazD
         lRWg3OrJ2w6cVov9sLW9JyoMusULSejz/qBExJNqz4jcbHdyoGd2T0clV4Rx8PHnnJfN
         OlYtdX/ZLsRrCCFTVBt10Hcjuuoi1ZblpsI5te8WYGEHTz8oaSRKkc+Bi8w7Zg0zlPBP
         6Pbg==
X-Gm-Message-State: AFqh2konJp20IOZ+/xOHZqSu84NcxESqmF1F9K1YB+efeYgs0hj9/xwc
        ly6T/8Iaq/ZssyskDZwlvzkmxA==
X-Google-Smtp-Source: AMrXdXvwcy3PSUb4q848sDoaIWHWtvBUmNR0so2nrtzYx6JjuVz/rsCcjLc37lx8FLvr6XECSoyb9g==
X-Received: by 2002:adf:dc0a:0:b0:2be:57a6:8161 with SMTP id t10-20020adfdc0a000000b002be57a68161mr12340309wri.46.1674544674861;
        Mon, 23 Jan 2023 23:17:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:7542:4469:3507:5738? ([2a01:e0a:982:cbb0:7542:4469:3507:5738])
        by smtp.gmail.com with ESMTPSA id p7-20020adff207000000b002bdff778d87sm1147623wro.34.2023.01.23.23.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 23:17:54 -0800 (PST)
Message-ID: <02e97893-ccae-50d1-db38-fb6fa31faaa5@linaro.org>
Date:   Tue, 24 Jan 2023 08:17:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/8] arm64: dts: amlogic: Fix non-compliant SD/SDIO node
 names
Content-Language: fr
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
 <55c53e8d-6b30-51bf-edf6-b5b67887bd0a@gmail.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <55c53e8d-6b30-51bf-edf6-b5b67887bd0a@gmail.com>
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

Le 23/01/2023 à 22:24, Heiner Kallweit a écrit :
> mmc-controller.yaml defines "^mmc(@.*)?$" as node name pattern.
> In preparation of adding schema-based validation fix the node name
> in two affected files.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 2 +-
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 1648e67af..ed895fb32 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1883,7 +1883,7 @@ apb: bus@ffe00000 {
>   			#size-cells = <2>;
>   			ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x200000>;
>   
> -			sd_emmc_b: sd@5000 {
> +			sd_emmc_b: mmc@5000 {
>   				compatible = "amlogic,meson-axg-mmc";
>   				reg = <0x0 0x5000 0x0 0x800>;
>   				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 1a931d5c2..80d82f739 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -2321,7 +2321,7 @@ uart_A: serial@24000 {
>   			};
>   		};
>   
> -		sd_emmc_a: sd@ffe03000 {
> +		sd_emmc_a: mmc@ffe03000 {
>   			compatible = "amlogic,meson-axg-mmc";
>   			reg = <0x0 0xffe03000 0x0 0x800>;
>   			interrupts = <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
> @@ -2333,7 +2333,7 @@ sd_emmc_a: sd@ffe03000 {
>   			resets = <&reset RESET_SD_EMMC_A>;
>   		};
>   
> -		sd_emmc_b: sd@ffe05000 {
> +		sd_emmc_b: mmc@ffe05000 {
>   			compatible = "amlogic,meson-axg-mmc";
>   			reg = <0x0 0xffe05000 0x0 0x800>;
>   			interrupts = <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
