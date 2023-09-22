Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7777AB255
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Sep 2023 14:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjIVMmu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Sep 2023 08:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjIVMmt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Sep 2023 08:42:49 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0A18F;
        Fri, 22 Sep 2023 05:42:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690f2719ab2so500635b3a.0;
        Fri, 22 Sep 2023 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695386562; x=1695991362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzUmaJw00NtdO2a1fcJmH57EcGwwL4xYW2vDq8BiXSs=;
        b=OQXB/WYBBZqdjTLkvkmEUkPKCzwQjpUSuQ41BQuHAi/0dHo5H07AOvuMmwf2fwtr8W
         3GAEqK7emZJHpXdLsnmItGb6E1KB2dnj0SwcRPbN8O0N65ebkZyzsW3MYTaewI55NK/n
         YfZlBhwW83E/2CeSCWivQVd8WMqamFN5FYFKbBZQfUek3s5byKN5aMvt0Fbnm7Knuvpp
         JBvPTF5LTu6jJTmlxKTXUgBCsEXiGMIZn3cpzHpGvbq8TtT49TBEFrNntO5oVes2617U
         2R+lE80+FZuJ7JmBHCMaXqX9k9txHxyptH3Pm9Vv/nChSe4Zr7ZHoSHdZzP8gvMT6eRs
         4VkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695386562; x=1695991362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzUmaJw00NtdO2a1fcJmH57EcGwwL4xYW2vDq8BiXSs=;
        b=mAZAKDYhEXcoTXXDIz9yF0uFEzgUAaWbsuQWoqIDUVR0Ra7Xx+0KFZEj6nMtWUgclV
         bjergPXzFVHNQttV4r4Fn6FwQEJ3EvI6bDN+RYQvGcCV6oLDGE3pmaUkwXQViKUIOXDa
         2a3QLPXIKEhE823KCw/Vbva1uNu/t/KbzagQ8BXqypVJZ3zMixKwzexd2zAmXdYt0U3l
         x96Tq0pd4njtpZFKQJM99lOh3JXBvj47X3GxTICywmXokqAnSdzrtcUs9rjvwgYN7NGZ
         BbpH5bpnuiaOevJM2nK/JpZhtcSfqjq/fMivSP0ItXpArYjxRqCYGyoWHoiGp0k+3IQr
         +Kgg==
X-Gm-Message-State: AOJu0YzTkAr29FiiYkYDyS/yf3lFLPeZ1ykhKOC/0jw67XnXQcBCti/M
        rvXdu1SqzTaRNX6hfN+q39cZfks4rY8=
X-Google-Smtp-Source: AGHT+IEdnpNK8ETni0ksqyKm5iYjIu0JAeuxJbEVPQu18hMs0j1Do9t03OsCkKYF+OG3s1QWm5RbTQ==
X-Received: by 2002:a05:6a20:394c:b0:13e:1d49:7249 with SMTP id r12-20020a056a20394c00b0013e1d497249mr7474116pzg.2.1695386562316;
        Fri, 22 Sep 2023 05:42:42 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:2546:6c99:4de0:9123])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001bba669a7eesm3368170plb.52.2023.09.22.05.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:42:41 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     shawnguo@kernel.org
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 3/3] ARM: dts: mxs: Switch to #pwm-cells = <3>
Date:   Fri, 22 Sep 2023 09:42:29 -0300
Message-Id: <20230922124229.359543-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922124229.359543-1-festevam@gmail.com>
References: <20230922124229.359543-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

mxs-pwm.yaml documents that #pwm-cells should be 3.

This is correct as the last cell may indicate the PWM polarity.

Convert all mxs devicetree files to using #pwm-cells = <3> for
consistency.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Newly introduced. Change mxs DT's to use #pwm-cells = <3>. (Uwe)

 arch/arm/boot/dts/nxp/mxs/imx23-evk.dts              | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts            | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx23-xfi3.dts             | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx23.dtsi                 | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28-apf28dev.dts         | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts         | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28-cfa10055.dts         | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28-cfa10057.dts         | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28-cfa10058.dts         | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx28lc.dtsi | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28-evk.dts              | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28-m28cu3.dts           | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts           | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28-tx28.dts             | 2 +-
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi                 | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx23-evk.dts b/arch/arm/boot/dts/nxp/mxs/imx23-evk.dts
index 3b609d987d88..7365fe4581a3 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23-evk.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx23-evk.dts
@@ -137,7 +137,7 @@ usb0: usb@80080000 {
 
 	backlight_display: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 2 5000000>;
+		pwms = <&pwm 2 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts b/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
index 46057d9bf555..636cf09a2b37 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
@@ -166,7 +166,7 @@ reg_vdd_tuner: regulator-vdd-tuner0 {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 2 5000000>;
+		pwms = <&pwm 2 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx23-xfi3.dts b/arch/arm/boot/dts/nxp/mxs/imx23-xfi3.dts
index b1d8210f3ecc..28341d8315c2 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23-xfi3.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx23-xfi3.dts
@@ -153,7 +153,7 @@ reg_vddio_sd0: regulator-vddio-sd0 {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 2 5000000>;
+		pwms = <&pwm 2 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx23.dtsi b/arch/arm/boot/dts/nxp/mxs/imx23.dtsi
index 5eca942a52fd..2bb68fc954b9 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx23.dtsi
@@ -561,7 +561,7 @@ pwm: pwm@80064000 {
 				compatible = "fsl,imx23-pwm";
 				reg = <0x80064000 0x2000>;
 				clocks = <&clks 30>;
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				fsl,pwm-number = <5>;
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-apf28dev.dts b/arch/arm/boot/dts/nxp/mxs/imx28-apf28dev.dts
index fd6fee63ad2f..6c87266eb135 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-apf28dev.dts
@@ -39,7 +39,7 @@ user {
 	backlight {
 		compatible = "pwm-backlight";
 
-		pwms = <&pwm 3 191000>;
+		pwms = <&pwm 3 191000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts
index 953e3162d2d2..f0ce897b9d5c 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10049.dts
@@ -173,7 +173,7 @@ rotary {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000>;
+		pwms = <&pwm 3 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-cfa10055.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10055.dts
index 70e225a99fbe..cb68edd6101b 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-cfa10055.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10055.dts
@@ -39,7 +39,7 @@ hx8357: hx8357@0 {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000>;
+		pwms = <&pwm 3 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-cfa10057.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10057.dts
index 0be7356941ee..5875c3d7ba97 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10057.dts
@@ -26,7 +26,7 @@ reg_usb1_vbus: regulator-0 {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 4 5000000>;
+		pwms = <&pwm 4 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-cfa10058.dts b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10058.dts
index aae0f1801461..b414e67ef379 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-cfa10058.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-cfa10058.dts
@@ -26,7 +26,7 @@ reg_usb1_vbus: regulator-0 {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000>;
+		pwms = <&pwm 3 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx28lc.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx28lc.dtsi
index 6633cde305e5..652fc9e57a55 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx28lc.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-eukrea-mbmx28lc.dtsi
@@ -14,7 +14,7 @@ / {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 4 1000000>;
+		pwms = <&pwm 4 1000000 0>;
 		brightness-levels = <0 25 50 75 100 125 150 175 200 225 255>;
 		default-brightness-level = <10>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-evk.dts b/arch/arm/boot/dts/nxp/mxs/imx28-evk.dts
index 783abb82b2a8..9ebb7371e235 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-evk.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-evk.dts
@@ -117,7 +117,7 @@ user {
 
 	backlight_display: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 2 5000000>;
+		pwms = <&pwm 2 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-m28cu3.dts b/arch/arm/boot/dts/nxp/mxs/imx28-m28cu3.dts
index 8241c2d159fa..34b4d3246db1 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-m28cu3.dts
@@ -17,7 +17,7 @@ memory@40000000 {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 3 5000000>;
+		pwms = <&pwm 3 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts b/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
index 6bf26f386a5e..13070ca08cff 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-m28evk.dts
@@ -13,7 +13,7 @@ / {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 4 5000000>;
+		pwms = <&pwm 4 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-tx28.dts b/arch/arm/boot/dts/nxp/mxs/imx28-tx28.dts
index 23ad7cd0a1de..0391ffd15866 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28-tx28.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx28-tx28.dts
@@ -131,7 +131,7 @@ user_led: user {
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm 0 500000>;
+		pwms = <&pwm 0 500000 0>;
 		/*
 		 * a silly way to create a 1:1 relationship between the
 		 * PWM value and the actual duty cycle
diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index 763adeb995ee..01ddd1ab5354 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -1185,7 +1185,7 @@ pwm: pwm@80064000 {
 				compatible = "fsl,imx28-pwm", "fsl,imx23-pwm";
 				reg = <0x80064000 0x2000>;
 				clocks = <&clks 44>;
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				fsl,pwm-number = <8>;
 				status = "disabled";
 			};
-- 
2.34.1

