Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3F27EF334
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Nov 2023 13:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjKQM7v (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Nov 2023 07:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346030AbjKQM7m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Nov 2023 07:59:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F43BD56
        for <linux-pwm@vger.kernel.org>; Fri, 17 Nov 2023 04:59:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40a48775c58so15921235e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Nov 2023 04:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700225977; x=1700830777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92KaagYK4Q6I8Q+kS3VXik470FxeSDcwqV61XGzdHMc=;
        b=EMN833p6XGQ2rHO/hoLRBK11ewx5wTSnmEhsnPyJE4O1VF53CkrGazwYx/mevyzZ1d
         WVuUXvkQgFuyIUffEV3Wowo7/ULcAFo22PJKTqpuIv0Tmz3jE3JczzvgecxfuWtll6Bg
         5tsP+zJPY9wBgi5qw1J7ez2n8o/Eys0KvQbBMA6FXEd3GflgFYurYbmF5CRStn+3F4Gl
         ew5HzBsC1B/MkYMVfOs6f3xUWW/SDWmTlG67az9W0f/4p0tZZJwoVgxqJyoOx5Dazfar
         WmPqooSAS6rcJkugU0sjQW4qe7rKW2ou6HaXlF33cXXsObiszaR0vUtOU7j+/Kxe1puR
         z1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700225977; x=1700830777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92KaagYK4Q6I8Q+kS3VXik470FxeSDcwqV61XGzdHMc=;
        b=KXbOquIYb/Z4oEJSgE5wrkKIdUCTp35B1A/Kpzc8wO6Ob0Kbb/MdpwYWyeZMNSxctF
         oWRPL5R3M3Z7d1eTDoMOEeD3411Q/8D+bXSnW4WZY05/dP0tOfNf+Qb0BabNC/IdqgLo
         RF4IC0Bb3rUkldsJT4Enrd1kwn1tjpImqGbaR4vKvMVB4RCs//bTLQbzTz2RIoYOZcz0
         OvF4/WppNMPHLo03lhxBSzlgNL72lDF5l1PAEIICUolRWN32mVIsVq/hXYMiHblihAUu
         NdebqXN5eNk51+x7WAeaqZS0BrrwhlDUWS543ZgK734RdFH49wZje7lSYOkF4B16MlNG
         dagA==
X-Gm-Message-State: AOJu0YyJeK14TEcgJMCYYo+PS+QRfTwcMlO/8rQOoDkOTbswPMs0Xrja
        Y1J/JqZKRj4ZxZ/NBBmcsMJdXw==
X-Google-Smtp-Source: AGHT+IHJarfDKVM02/KEz4vsEFlQsu9jRbie2N/lyjCIFyQbFZsbgK7Bpgp8NaxTDgyBN/qVE/f4NQ==
X-Received: by 2002:a05:600c:3c9b:b0:401:2ee0:7558 with SMTP id bg27-20020a05600c3c9b00b004012ee07558mr4340885wmb.32.1700225976737;
        Fri, 17 Nov 2023 04:59:36 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:8196:e423:38cb:9a09])
        by smtp.googlemail.com with ESMTPSA id k21-20020a05600c1c9500b0040a487758dcsm2671343wms.6.2023.11.17.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 04:59:36 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        JunYi Zhao <junyi.zhao@amlogic.com>
Subject: [PATCH v2 5/6] arm: dts: amlogic: migrate pwms to new meson8 v2 binding
Date:   Fri, 17 Nov 2023 13:59:15 +0100
Message-ID: <20231117125919.1696980-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117125919.1696980-1-jbrunet@baylibre.com>
References: <20231117125919.1696980-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update Amlogic based SoC PWMs to meson8-pwm-v2 compatible

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/boot/dts/amlogic/meson.dtsi           |  4 ++--
 arch/arm/boot/dts/amlogic/meson8.dtsi          | 16 +++++++++++++---
 arch/arm/boot/dts/amlogic/meson8b-ec100.dts    |  2 --
 arch/arm/boot/dts/amlogic/meson8b-mxq.dts      |  2 --
 arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts |  2 --
 arch/arm/boot/dts/amlogic/meson8b.dtsi         | 16 +++++++++++++---
 6 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/amlogic/meson.dtsi b/arch/arm/boot/dts/amlogic/meson.dtsi
index 8e3860d5d916..80cc004ad5fe 100644
--- a/arch/arm/boot/dts/amlogic/meson.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson.dtsi
@@ -83,14 +83,14 @@ i2c_A: i2c@8500 {
 			};
 
 			pwm_ab: pwm@8550 {
-				compatible = "amlogic,meson-pwm";
+				compatible = "amlogic,meson8-pwm-v2";
 				reg = <0x8550 0x10>;
 				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
 			pwm_cd: pwm@8650 {
-				compatible = "amlogic,meson-pwm";
+				compatible = "amlogic,meson8-pwm-v2";
 				reg = <0x8650 0x10>;
 				#pwm-cells = <3>;
 				status = "disabled";
diff --git a/arch/arm/boot/dts/amlogic/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
index 59932fbfd5d5..153b8fe9c506 100644
--- a/arch/arm/boot/dts/amlogic/meson8.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8.dtsi
@@ -450,10 +450,14 @@ analog_top: analog-top@81a8 {
 	};
 
 	pwm_ef: pwm@86c0 {
-		compatible = "amlogic,meson8-pwm", "amlogic,meson8b-pwm";
+		compatible = "amlogic,meson8-pwm-v2";
 		reg = <0x86c0 0x10>;
 		#pwm-cells = <3>;
 		status = "disabled";
+		clocks = <&xtal>,
+			 <0>,
+			 <&clkc CLKID_FCLK_DIV4>,
+			 <&clkc CLKID_FCLK_DIV3>;
 	};
 
 	clock-measure@8758 {
@@ -702,11 +706,17 @@ timer@600 {
 };
 
 &pwm_ab {
-	compatible = "amlogic,meson8-pwm", "amlogic,meson8b-pwm";
+	clocks = <&xtal>,
+		 <0>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_FCLK_DIV3>;
 };
 
 &pwm_cd {
-	compatible = "amlogic,meson8-pwm", "amlogic,meson8b-pwm";
+	clocks = <&xtal>,
+		 <0>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_FCLK_DIV3>;
 };
 
 &rtc {
diff --git a/arch/arm/boot/dts/amlogic/meson8b-ec100.dts b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
index 3da47349eaaf..cdd7d04db256 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
@@ -441,8 +441,6 @@ &pwm_cd {
 	status = "okay";
 	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&xtal>, <&xtal>;
-	clock-names = "clkin0", "clkin1";
 };
 
 &rtc {
diff --git a/arch/arm/boot/dts/amlogic/meson8b-mxq.dts b/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
index 7adedd3258c3..68f4f70f4f03 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
@@ -162,8 +162,6 @@ &pwm_cd {
 	status = "okay";
 	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&xtal>, <&xtal>;
-	clock-names = "clkin0", "clkin1";
 };
 
 &uart_AO {
diff --git a/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
index 941682844faf..ff955b960688 100644
--- a/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
@@ -347,8 +347,6 @@ &pwm_cd {
 	status = "okay";
 	pinctrl-0 = <&pwm_c1_pins>, <&pwm_d_pins>;
 	pinctrl-names = "default";
-	clocks = <&xtal>, <&xtal>;
-	clock-names = "clkin0", "clkin1";
 };
 
 &rtc {
diff --git a/arch/arm/boot/dts/amlogic/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
index 5198f5177c2c..6c91eda92e8b 100644
--- a/arch/arm/boot/dts/amlogic/meson8b.dtsi
+++ b/arch/arm/boot/dts/amlogic/meson8b.dtsi
@@ -404,10 +404,14 @@ analog_top: analog-top@81a8 {
 	};
 
 	pwm_ef: pwm@86c0 {
-		compatible = "amlogic,meson8b-pwm";
+		compatible = "amlogic,meson8-pwm-v2";
 		reg = <0x86c0 0x10>;
 		#pwm-cells = <3>;
 		status = "disabled";
+		clocks = <&xtal>,
+			 <0>,
+			 <&clkc CLKID_FCLK_DIV4>,
+			 <&clkc CLKID_FCLK_DIV3>;
 	};
 
 	clock-measure@8758 {
@@ -677,11 +681,17 @@ timer@600 {
 };
 
 &pwm_ab {
-	compatible = "amlogic,meson8b-pwm";
+	clocks = <&xtal>,
+		 <0>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_FCLK_DIV3>;
 };
 
 &pwm_cd {
-	compatible = "amlogic,meson8b-pwm";
+	clocks = <&xtal>,
+		 <0>,
+		 <&clkc CLKID_FCLK_DIV4>,
+		 <&clkc CLKID_FCLK_DIV3>;
 };
 
 &rtc {
-- 
2.42.0

