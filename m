Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D197E5446
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Nov 2023 11:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344421AbjKHKrB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Nov 2023 05:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344649AbjKHKqR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Nov 2023 05:46:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2332D4F
        for <linux-pwm@vger.kernel.org>; Wed,  8 Nov 2023 02:44:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so3614355e9.1
        for <linux-pwm@vger.kernel.org>; Wed, 08 Nov 2023 02:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699440287; x=1700045087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Maq2+L1Y42eLIp6jLOTQKPo6JnaiX6HnytDKQ9hLP3M=;
        b=g9XQA9rzym40Y/5WeB9duG4RMsqs9UF/7dkpw3q5vzWlYDbrqOKsj9eBBgqYyAFYZi
         gyR1mPsCVJC1UhOmdpSEBIwUTqGldBj2wlsn25TiVkBvkGsyJbWBI4alYtlRe3N03U8R
         xD8L9Sl5lRB5gr1m/LNfDOzTvZzoy0ijBYGn9a+al1dxR1xfOGbd+DQVtyBFX4hUd89Q
         rhOavNd5h0MuYO3vKFNxWyhiF5ubb5a+XMOwcBmzUHmGxlg0cZwOX4gUIw0kHDcGAw4/
         N03ZZE9IOmnxtEi6Z4pdVfq3MjBRBO1xwVCmrfUxU/h4lGFfjEYaTS1HxNeIHIUmcOzN
         Zkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440287; x=1700045087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Maq2+L1Y42eLIp6jLOTQKPo6JnaiX6HnytDKQ9hLP3M=;
        b=Re2gMoubdgMH9fZ0jvpbS3QqGo4NxNXltKAQJN+cgTbxPxqUtOlJszPAZ/fX5/miMq
         4GtHG/HOnPp3gVe7GmfULkRS2Gf+wr08sXVS21TpnkgDs7B2cOxwppyYm0XaI5XeQfgu
         lygU34VGwGhkdiDrVk6Pz0BVU+VkYu7/LrXMRFuUoa2FMi7+INdRvuPRV6NfsYHbb88C
         VuzEurETjLrArUtMod+dxApHnRNvRXE3o4cqIBlwwtIOZtNs5rK7iMIawp2/K2o6e0+A
         zHdUkmcITBdtaj4689nIWVWFp9AGAXyd7gS+rv4u6T3uXdB1amkGxx2y+Hua7cCBodRA
         YiLw==
X-Gm-Message-State: AOJu0YxtfGc7+AOcKhgsuktchHiXqsdVyoHAmsMwp0YWUPoFaOjTv8Z6
        RnQujFqLphIpNsVjOdkd5J8JtQ==
X-Google-Smtp-Source: AGHT+IHfnKTLAUfozAkfKQV4GR2Fej9TWilPKyjgZI/joMTpp1hOhiecaU9SQRw9m85EcpIoxEyIjw==
X-Received: by 2002:a05:600c:4512:b0:406:44fc:65c9 with SMTP id t18-20020a05600c451200b0040644fc65c9mr1775482wmo.8.1699440287419;
        Wed, 08 Nov 2023 02:44:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b004094c5d92bdsm19377377wmb.31.2023.11.08.02.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:44:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 14/17] arm64: dts: exynos7: add specific compatibles to several blocks
Date:   Wed,  8 Nov 2023 11:43:40 +0100
Message-Id: <20231108104343.24192-15-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Exynos7 reuses several devices from older designs, thus historically
we kept the old (block's) compatible only.  This works fine and there is
no bug here, however guidelines expressed in
Documentation/devicetree/bindings/writing-bindings.rst state that:
1. Compatibles should be specific.
2. We should add new compatibles in case of bugs or features.

Add compatibles specific to Exynos7 in front of all old-SoC-like
compatibles.  This will also help reviews of new code using existing
DTS as template.  No functional impact on Linux drivers behavior.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos7.dtsi | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 6ed80ddf3369..9cb6bd61262e 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -128,7 +128,8 @@ soc: soc@0 {
 		ranges = <0 0 0 0x18000000>;
 
 		chipid@10000000 {
-			compatible = "samsung,exynos4210-chipid";
+			compatible = "samsung,exynos7-chipid",
+				     "samsung,exynos4210-chipid";
 			reg = <0x10000000 0x100>;
 		};
 
@@ -279,7 +280,7 @@ clock_fsys1: clock-controller@156e0000 {
 		};
 
 		serial_0: serial@13630000 {
-			compatible = "samsung,exynos4210-uart";
+			compatible = "samsung,exynos7-uart", "samsung,exynos4210-uart";
 			reg = <0x13630000 0x100>;
 			interrupts = <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peric0 PCLK_UART0>,
@@ -289,7 +290,7 @@ serial_0: serial@13630000 {
 		};
 
 		serial_1: serial@14c20000 {
-			compatible = "samsung,exynos4210-uart";
+			compatible = "samsung,exynos7-uart", "samsung,exynos4210-uart";
 			reg = <0x14c20000 0x100>;
 			interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peric1 PCLK_UART1>,
@@ -299,7 +300,7 @@ serial_1: serial@14c20000 {
 		};
 
 		serial_2: serial@14c30000 {
-			compatible = "samsung,exynos4210-uart";
+			compatible = "samsung,exynos7-uart", "samsung,exynos4210-uart";
 			reg = <0x14c30000 0x100>;
 			interrupts = <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peric1 PCLK_UART2>,
@@ -309,7 +310,7 @@ serial_2: serial@14c30000 {
 		};
 
 		serial_3: serial@14c40000 {
-			compatible = "samsung,exynos4210-uart";
+			compatible = "samsung,exynos7-uart", "samsung,exynos4210-uart";
 			reg = <0x14c40000 0x100>;
 			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock_peric1 PCLK_UART3>,
@@ -539,7 +540,7 @@ pmu_system_controller: system-controller@105c0000 {
 		};
 
 		rtc: rtc@10590000 {
-			compatible = "samsung,s3c6410-rtc";
+			compatible = "samsung,exynos7-rtc", "samsung,s3c6410-rtc";
 			reg = <0x10590000 0x100>;
 			interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
@@ -559,7 +560,8 @@ watchdog: watchdog@101d0000 {
 		};
 
 		gpu: gpu@14ac0000 {
-			compatible = "samsung,exynos5433-mali", "arm,mali-t760";
+			compatible = "samsung,exynos7-mali",
+				     "samsung,exynos5433-mali", "arm,mali-t760";
 			reg = <0x14ac0000 0x5000>;
 			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>,
@@ -619,7 +621,7 @@ adc: adc@13620000 {
 		};
 
 		pwm: pwm@136c0000 {
-			compatible = "samsung,exynos4210-pwm";
+			compatible = "samsung,exynos7-pwm", "samsung,exynos4210-pwm";
 			reg = <0x136c0000 0x100>;
 			interrupts = <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.34.1

