Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39F9678994
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jan 2023 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjAWVbH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Jan 2023 16:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAWVbH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Jan 2023 16:31:07 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1194A126FF;
        Mon, 23 Jan 2023 13:31:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v30so16226779edb.9;
        Mon, 23 Jan 2023 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Az6/+eS6ijz6i/CMKCOR2HNf4utXJX9P0GxQzD5Ytps=;
        b=BR34zr7979WtSxuJfQQmHhscCCpGpa4wPeRndQwBkQf1VMoF+o36ZcPm8SB67r8Iau
         OlRhq8rzcHbAgK4GsQ0khz1LmHmM5fdLW/03hzQjHmSGXTTGxvadi2faCaI6RTs4NOJN
         UTsrTFgx4/+2MIXmcbagLLCCtIES4Q2P57BgUi6XW1GUyJMm+xQmjW1tvauwtms1RlhF
         zDdPmb1JGtdbtZ9B1kNQFJ7dfS2wwwpGIpbkSpoT/1UlS3NjLfx3/V8tI3AFRXFLFtDI
         bXvNTw4kGgPOH3sR6UiEIv1ldSZ6bUq0AO2K0Qw27LLovvjOX6AWtZFIAEZTnnC4zoTl
         Hcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Az6/+eS6ijz6i/CMKCOR2HNf4utXJX9P0GxQzD5Ytps=;
        b=b0MgGxXPI7d/rAHnspi1HX53iB6xk/stxdtijT83Sri2vDeFV9NazBBsHqT4C4iGFI
         psCajbtK9+eKhKnEJO0wQWAYJ1dmmFlc66JQ1+Gg5r47IXnPDwG8VUbXReSLp+Ze17NC
         0YOExQF6XbBQsR7F058uUyVWZsarF/jkeE+zdWO2QdnRQXA/ne7ztBO2ImK2XQD8Xw36
         3K+3zBfqEbQfaR3f/31ip94XmostK2YnhZ3TzK38hMqkoSY/DKBepnTYa5l0GxP0lVHw
         CiR1t+lGWoHST/rt25dbEyZjZfH/7gscWd9+bJIu4YltXCL8Qz9w4tx0qid4g4EbD1w1
         N/KQ==
X-Gm-Message-State: AFqh2kpdKTs4svQAMWZuRC6tCM+2NI1eArg8+uvBDcMtawPv4+e486/J
        YdJn/1fAJENBT5mJCc1Nxs8=
X-Google-Smtp-Source: AMrXdXvBhhFAnlGDpShjqyTOqXfCsXipvqGMLgY5DjYtYmmrUoMO9uh7PEYOVRplnKyaHNRjwS9RZQ==
X-Received: by 2002:a05:6402:388c:b0:49a:6a2:6f2f with SMTP id fd12-20020a056402388c00b0049a06a26f2fmr31501205edb.4.1674509464518;
        Mon, 23 Jan 2023 13:31:04 -0800 (PST)
Received: from ?IPV6:2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7? (dynamic-2a01-0c23-bc5b-9400-dc4c-6fb7-47b2-beb7.c23.pool.telefonica.de. [2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7])
        by smtp.googlemail.com with ESMTPSA id u16-20020aa7d550000000b004873927780bsm228573edr.20.2023.01.23.13.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 13:31:04 -0800 (PST)
Message-ID: <55c53e8d-6b30-51bf-edf6-b5b67887bd0a@gmail.com>
Date:   Mon, 23 Jan 2023 22:24:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
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
Subject: [PATCH 2/8] arm64: dts: amlogic: Fix non-compliant SD/SDIO node names
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

mmc-controller.yaml defines "^mmc(@.*)?$" as node name pattern.
In preparation of adding schema-based validation fix the node name
in two affected files.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi        | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 1648e67af..ed895fb32 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1883,7 +1883,7 @@ apb: bus@ffe00000 {
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x200000>;
 
-			sd_emmc_b: sd@5000 {
+			sd_emmc_b: mmc@5000 {
 				compatible = "amlogic,meson-axg-mmc";
 				reg = <0x0 0x5000 0x0 0x800>;
 				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 1a931d5c2..80d82f739 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2321,7 +2321,7 @@ uart_A: serial@24000 {
 			};
 		};
 
-		sd_emmc_a: sd@ffe03000 {
+		sd_emmc_a: mmc@ffe03000 {
 			compatible = "amlogic,meson-axg-mmc";
 			reg = <0x0 0xffe03000 0x0 0x800>;
 			interrupts = <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
@@ -2333,7 +2333,7 @@ sd_emmc_a: sd@ffe03000 {
 			resets = <&reset RESET_SD_EMMC_A>;
 		};
 
-		sd_emmc_b: sd@ffe05000 {
+		sd_emmc_b: mmc@ffe05000 {
 			compatible = "amlogic,meson-axg-mmc";
 			reg = <0x0 0xffe05000 0x0 0x800>;
 			interrupts = <GIC_SPI 190 IRQ_TYPE_EDGE_RISING>;
-- 
2.39.1


