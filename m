Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC4F678991
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jan 2023 22:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjAWVbF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Jan 2023 16:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAWVbF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Jan 2023 16:31:05 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21297126FF;
        Mon, 23 Jan 2023 13:31:04 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g11so10742553eda.12;
        Mon, 23 Jan 2023 13:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGy0L8FYKqoa2JKT2+lRKom4fwae0WN7DTnvx0E4Uzc=;
        b=g3yJTOA2nZO0Dnf/q+WUQ17ab7h55P+/OqcdQBpFGQp6h3UtMIeFE9zmNJLc3X9fj6
         C590kHQzH+fsVFJW1mzraHaBRoZJCUAZBsrQliiapxjd7tgxsgSnDf5HWyCJFssUI5nX
         pbu3jwxkuA5AFPM5TcOj7frMlzIiJzWuyqCXuxAT8YrYSc39/yiwYut3kURTI0yeaf/g
         faXzt2kIsdCyDiqHcDLixXZHcwQI9AXfa0x4cdMe9RR5qWnbuZuII5E17z/OzMP1jCde
         baofBmX/duEWiPMyw8LfDVnM8qzLepwnPkNtLQgYsm8oA/4Vk1CFJryPS2QsxeiCOhAz
         rO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGy0L8FYKqoa2JKT2+lRKom4fwae0WN7DTnvx0E4Uzc=;
        b=cxAV3dWByiVjV2tIUN09TmERC6+6bI90GCuJ7qVq6so4viDXKYZ6AAJNJvX2Qp4/E8
         Kf+K44XI7iMp7bxGxXRz+nkYLh3LccQBnKIf2cyC72AOZhFdVvbKJ/6Tan6pNOkPZ7zQ
         J6nLEUy2FF9IzCWcszj05bXWnF+pN6mIhR1+6KZ3CIujxBID/A2293x/M10n/Lj1qYNF
         5AEEO1R19vC0e7qv8jmy9bVtkL4uZ5HlxJKS25bznHCHB3/UkqZVMcQnCCguxWsMOx6z
         AuJnQn6NKs3cqqa5MmaEQkyAqXIO5JcUylYPePL33iAS92Q+WjuWcZ1RiyZxzDmblm3w
         69og==
X-Gm-Message-State: AFqh2kq3ndzK8M03LaUIWHm/dJo1uLNd59h0l6fIGHACvpYFNNMad+TY
        6+kzX8yeW0ATyLC1b2/1M4g=
X-Google-Smtp-Source: AMrXdXtDrtFMC+Krfg/TfV027iJVS6WEimm/PnKTdIxeQra5m4weBTCn+UTAXPU83PrQ9lDliTU/zg==
X-Received: by 2002:a05:6402:401d:b0:49b:5a1c:9cb5 with SMTP id d29-20020a056402401d00b0049b5a1c9cb5mr29220354eda.16.1674509462545;
        Mon, 23 Jan 2023 13:31:02 -0800 (PST)
Received: from ?IPV6:2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7? (dynamic-2a01-0c23-bc5b-9400-dc4c-6fb7-47b2-beb7.c23.pool.telefonica.de. [2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7])
        by smtp.googlemail.com with ESMTPSA id u10-20020aa7db8a000000b00487b73912c2sm230560edt.12.2023.01.23.13.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 13:31:02 -0800 (PST)
Message-ID: <0fab069e-dc03-783e-e4f9-d49f96669328@gmail.com>
Date:   Mon, 23 Jan 2023 22:23:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH 1/8] arm64: dts: meson-gx: Remove invalid pwm compatible
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

amlogic,meson-gx-pwm isn't a valid compatible string, so remove it.
See drivers/pwm/pwm-meson.c.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index a79a35e84..75d35dcfe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -328,14 +328,14 @@ i2c_A: i2c@8500 {
 			};
 
 			pwm_ab: pwm@8550 {
-				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
+				compatible = "amlogic,meson-gxbb-pwm";
 				reg = <0x0 0x08550 0x0 0x10>;
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
 			pwm_cd: pwm@8650 {
-				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
+				compatible = "amlogic,meson-gxbb-pwm";
 				reg = <0x0 0x08650 0x0 0x10>;
 				#pwm-cells = <3>;
 				status = "disabled";
@@ -350,7 +350,7 @@ saradc: adc@8680 {
 			};
 
 			pwm_ef: pwm@86c0 {
-				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
+				compatible = "amlogic,meson-gxbb-pwm";
 				reg = <0x0 0x086c0 0x0 0x10>;
 				#pwm-cells = <3>;
 				status = "disabled";
@@ -497,7 +497,7 @@ i2c_AO: i2c@500 {
 			};
 
 			pwm_AO_ab: pwm@550 {
-				compatible = "amlogic,meson-gx-ao-pwm", "amlogic,meson-gxbb-ao-pwm";
+				compatible = "amlogic,meson-gxbb-ao-pwm";
 				reg = <0x0 0x00550 0x0 0x10>;
 				#pwm-cells = <3>;
 				status = "disabled";
-- 
2.39.1


