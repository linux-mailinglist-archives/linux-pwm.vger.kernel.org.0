Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89311678998
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jan 2023 22:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjAWVbL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Jan 2023 16:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjAWVbJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Jan 2023 16:31:09 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5905C16AD6;
        Mon, 23 Jan 2023 13:31:08 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id az20so34160111ejc.1;
        Mon, 23 Jan 2023 13:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMrJ0puhHaYAGR7cm+2T4ZLMvI2HK00WmCCvIJxL5IA=;
        b=gFPn1gofsTEjfe5fmlsW5Inpoe4DwFbR95+i+S45tZmbAqXCaIjowyMwdc7gtxurxj
         mVQQJqa44VSh6iilow0gQCQ/FYMyt3u+buBnsHB0gX8D3fgT6qLfTmJMId+HaODJgjre
         2JDfNd2yiadPaJ2Kdydvt9vua3v20MXod6AOVxzRWhay3knzW8AwJdK+HZ3eoDhsaAxy
         3afI7s87SbJXTffE+tzx8ZsGdWAI3wvaXNuDGWE3UwsuQEMLp+cWUM2Ug5co5BHaT3tX
         ZfZahSAmxm0Ur/oZAwFfHCb9Q5QTeXjy/47cnd0UoUUd/NYJ4zbgx8i1ktNh9WRmAx46
         x0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMrJ0puhHaYAGR7cm+2T4ZLMvI2HK00WmCCvIJxL5IA=;
        b=K02rU5GvH7dTQiyBjFeDCAW0Q1DxYK9HwU7R+2Dqb2xaCh2v1/0IsA3M8I9gPNz850
         K/aVwK+dBn2iF0Xpl0nXxgFIWRkobEKF8SzG5n/S6XfEqQJgw4P1HIGIKlezYWIfsQwV
         SAR2o7n4QeI8ryII3sQCGl+mn0JuQb1/CWNvjLODHSlUn41fuxhfKYVuYdWLO+P/HKGr
         WPaUMVxu7zmRyZefKkhkGS6HIUL92V3g9EFky/BE2wkhbwvET+SC5LXb7RjnsZUXlhXC
         P5+XOZxIDmAkkB0bTT9gQcRmRu00plQ+vCeZ4RLpOi3c95AJ2aAgQ5pgZQU23OTAdZjo
         KcjA==
X-Gm-Message-State: AFqh2kpq7T+VcUGumUqNQ+HWFcqSFdv6jAHsh3XRArLCr0VSbL7C9ezh
        TvIafBN9zLETCSOpvHGrv30=
X-Google-Smtp-Source: AMrXdXsuUDGL/8bnnpTryWjO06y2FoaJUV1fwx1U6RARROXcXxnInatXg6PO9RTMoNTQoqMwU57JHg==
X-Received: by 2002:a17:907:80c7:b0:84c:eca0:5f67 with SMTP id io7-20020a17090780c700b0084ceca05f67mr28344950ejc.54.1674509466752;
        Mon, 23 Jan 2023 13:31:06 -0800 (PST)
Received: from ?IPV6:2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7? (dynamic-2a01-0c23-bc5b-9400-dc4c-6fb7-47b2-beb7.c23.pool.telefonica.de. [2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7])
        by smtp.googlemail.com with ESMTPSA id kz16-20020a17090777d000b00877961fbaffsm5888982ejc.15.2023.01.23.13.31.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 13:31:06 -0800 (PST)
Message-ID: <25708b33-6f58-bde0-2fa7-089e6d89b552@gmail.com>
Date:   Mon, 23 Jan 2023 22:25:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH 3/8] arm64: dts: meson-gx: Set only one compatible string for
 mmc
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
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
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
In-Reply-To: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
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

In preparation of schema-based validation use one compatible string only.
Both are aliases anyway.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 75d35dcfe..c0a311da4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -601,21 +601,21 @@ apb: apb@d0000000 {
 			ranges = <0x0 0x0 0x0 0xd0000000 0x0 0x200000>;
 
 			sd_emmc_a: mmc@70000 {
-				compatible = "amlogic,meson-gx-mmc", "amlogic,meson-gxbb-mmc";
+				compatible = "amlogic,meson-gx-mmc";
 				reg = <0x0 0x70000 0x0 0x800>;
 				interrupts = <GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			sd_emmc_b: mmc@72000 {
-				compatible = "amlogic,meson-gx-mmc", "amlogic,meson-gxbb-mmc";
+				compatible = "amlogic,meson-gx-mmc";
 				reg = <0x0 0x72000 0x0 0x800>;
 				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
 			sd_emmc_c: mmc@74000 {
-				compatible = "amlogic,meson-gx-mmc", "amlogic,meson-gxbb-mmc";
+				compatible = "amlogic,meson-gx-mmc";
 				reg = <0x0 0x74000 0x0 0x800>;
 				interrupts = <GIC_SPI 218 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
-- 
2.39.1


