Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A640E17E2E0
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 15:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgCIO5K (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Mar 2020 10:57:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34460 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCIO5E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Mar 2020 10:57:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so11607560wrl.1
        for <linux-pwm@vger.kernel.org>; Mon, 09 Mar 2020 07:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo93l2/8r8L8gS5JJpSQUbdZuZ69zVWX1PF9SCY5L+g=;
        b=eRFWJsYkgb85TrToXLRsuRjLWizdB84ye/h9VpIexcxM96AoHfmt82hSJM+Ugrnh2F
         OvHILrAj2GQbjg2iJDuciHOjDy4vXkC79uEOjUKvB76DnlXFp6IZR1lcBjRLHlWGtxS3
         KkuthRrpl7VM1Ze4R7OSHDpwDHUSerWBJwCgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xo93l2/8r8L8gS5JJpSQUbdZuZ69zVWX1PF9SCY5L+g=;
        b=rsyOvqmHrV1tRjZVj49avxqn/BssluBfdwEfHbBRsXarDs/DbuIpGbpQ+3++XncY8F
         76GzeLgZdq1fnH/fpRIKRNfxsPHot52bjospp2YJQsYLnF6zDZnwbvb5iO1EHa+ST5T/
         FB03ubewc3o7Kjz0pzHQ1VIoGcAgTynoO7WSzDDLYnq/gAjzSQmIA5ioJG4QiGvTRkou
         9Tuy2NRCM5uicDSMO0ozHIJlHG3if4fU/Rw5nJBQzMrLlxOYAw4qtiYgK6dac0nRghQN
         dXJsI8IjfyTgt7kc4butdZ5URZ6n8Torc/81pjM3vCEqZ5224SNHFSD7fWzGOA5L7ncW
         hw4g==
X-Gm-Message-State: ANhLgQ30Q63TzHAUvM0GSBTdpC0ixoLmyCdHB3LDh3J2XRP6AX08X8dI
        yxpKf3XPVYrNo71mNNTPpTHSIyrzDzwH1zm/
X-Google-Smtp-Source: ADFU+vsv8W8c3M5KPpD2WNoum2WmQNNXJWoqlokkaN+9MtjGiEVX4M2fTneGnZW4Qsv70pIM0/W/UQ==
X-Received: by 2002:a5d:420c:: with SMTP id n12mr2082129wrq.173.1583765820427;
        Mon, 09 Mar 2020 07:57:00 -0700 (PDT)
Received: from ub1910.Hitronhub.home ([213.48.11.149])
        by smtp.gmail.com with ESMTPSA id u8sm5078424wmn.9.2020.03.09.07.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 07:56:59 -0700 (PDT)
From:   Paul Barker <pbarker@konsulko.com>
To:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Paul Barker <pbarker@konsulko.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH] dts: imx6: Allow flags argument in pwms reference
Date:   Mon,  9 Mar 2020 14:55:58 +0000
Message-Id: <20200309145558.16098-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pwm-imx27 driver supports a third argument in a pwms reference to
provide flags. However #pwm-cells needs to be set to <3> in the pwm node
so that these flags can be passed through to the driver. Once #pwm-cells
is <3>, all pwms references need to use the 3-cell form.

Signed-off-by: Paul Barker <pbarker@konsulko.com>

Cc: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Rob Herring robh+dt@kernel.org
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts      |  2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts      |  2 +-
 arch/arm/boot/dts/imx6dl-mamoj.dts               |  2 +-
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi       |  1 -
 arch/arm/boot/dts/imx6q-ba16.dtsi                |  2 +-
 arch/arm/boot/dts/imx6q-display5.dtsi            |  1 -
 arch/arm/boot/dts/imx6q-kp.dtsi                  |  4 ++--
 arch/arm/boot/dts/imx6q-logicpd.dts              |  2 +-
 arch/arm/boot/dts/imx6q-mccmon6.dts              |  1 -
 arch/arm/boot/dts/imx6q-novena.dts               |  2 +-
 arch/arm/boot/dts/imx6q-pistachio.dts            |  2 +-
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts   |  2 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi           |  2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi     |  2 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi           |  2 +-
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi           |  2 +-
 arch/arm/boot/dts/imx6qdl-emcon.dtsi             |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi             |  2 +-
 arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi    |  2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi         |  4 ++--
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi     |  6 +++---
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi    |  4 ++--
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi        |  4 ++--
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi       |  2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi         |  2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi         |  6 +++---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi           |  2 +-
 arch/arm/boot/dts/imx6qdl-savageboard.dtsi       |  2 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi               |  2 --
 arch/arm/boot/dts/imx6qdl.dtsi                   |  8 ++++----
 arch/arm/boot/dts/imx6sl-evk.dts                 |  2 +-
 arch/arm/boot/dts/imx6sl.dtsi                    |  8 ++++----
 arch/arm/boot/dts/imx6sll-evk.dts                |  2 +-
 arch/arm/boot/dts/imx6sll.dtsi                   |  8 ++++----
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts         |  2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                |  2 +-
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts |  6 +++---
 arch/arm/boot/dts/imx6sx.dtsi                    | 16 ++++++++--------
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi          |  2 +-
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts      |  2 +-
 arch/arm/boot/dts/imx6ul-geam.dts                |  2 +-
 arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi |  2 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi              |  2 +-
 arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts  |  2 +-
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi    |  2 +-
 arch/arm/boot/dts/imx6ul-pico.dtsi               |  2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi              |  1 -
 arch/arm/boot/dts/imx6ul.dtsi                    | 16 ++++++++--------
 arch/arm/boot/dts/imx6ull-colibri.dtsi           |  4 ----
 56 files changed, 85 insertions(+), 95 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
index 37f80ab8ccd0..f87ac95b70bc 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
@@ -14,7 +14,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
index 8d8c8c27e482..efb3f64e961b 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
@@ -49,7 +49,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 3000>;
+		pwms = <&pwm3 0 3000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6dl-mamoj.dts b/arch/arm/boot/dts/imx6dl-mamoj.dts
index 385ce7b0029e..72ee236d2f5e 100644
--- a/arch/arm/boot/dts/imx6dl-mamoj.dts
+++ b/arch/arm/boot/dts/imx6dl-mamoj.dts
@@ -21,7 +21,7 @@
 
 	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 25000>; /* 25000ns -> 40kHz */
+		pwms = <&pwm3 0 25000 0>; /* 25000ns -> 40kHz */
 		brightness-levels = <0 4 8 16 32 64 128 160 192 224 255>;
 		default-brightness-level = <7>;
 	};
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 80ed5f16a76e..17bd48f50c7b 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -540,7 +540,6 @@
 };
 
 &pwm1 {
-	#pwm-cells = <3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
 	status = "disabled";
diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index 37c63402157b..497887bc68dd 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -55,7 +55,7 @@
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_display>;
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <  0   1   2   3   4   5   6   7   8   9
 				      10  11  12  13  14  15  16  17  18  19
 				      20  21  22  23  24  25  26  27  28  29
diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/imx6q-display5.dtsi
index 83524bb99eb3..fef5d7254536 100644
--- a/arch/arm/boot/dts/imx6q-display5.dtsi
+++ b/arch/arm/boot/dts/imx6q-display5.dtsi
@@ -399,7 +399,6 @@
 };
 
 &pwm2 {
-	#pwm-cells = <3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
index 24c8169baf44..26cd45e9ff54 100644
--- a/arch/arm/boot/dts/imx6q-kp.dtsi
+++ b/arch/arm/boot/dts/imx6q-kp.dtsi
@@ -15,7 +15,7 @@
 / {
 	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 255>;
 		num-interpolated-steps = <255>;
 		default-brightness-level = <250>;
@@ -23,7 +23,7 @@
 
 	beeper {
 		compatible = "pwm-beeper";
-		pwms = <&pwm2 0 500000>;
+		pwms = <&pwm2 0 500000 0>;
 	};
 
 	lcd_display: display {
diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/imx6q-logicpd.dts
index 7a3d1d3e54a9..8f94364ba484 100644
--- a/arch/arm/boot/dts/imx6q-logicpd.dts
+++ b/arch/arm/boot/dts/imx6q-logicpd.dts
@@ -13,7 +13,7 @@
 
 	backlight: backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 20000>;
+		pwms = <&pwm3 0 20000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		power-supply = <&reg_lcd>;
diff --git a/arch/arm/boot/dts/imx6q-mccmon6.dts b/arch/arm/boot/dts/imx6q-mccmon6.dts
index a4d295455e67..55692c73943d 100644
--- a/arch/arm/boot/dts/imx6q-mccmon6.dts
+++ b/arch/arm/boot/dts/imx6q-mccmon6.dts
@@ -237,7 +237,6 @@
 };
 
 &pwm2 {
-	#pwm-cells = <3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 61347a545d6c..c6f0b271d8e4 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -67,7 +67,7 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 10000000>;
+		pwms = <&pwm1 0 10000000 0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_backlight_novena>;
 		power-supply = <&reg_lvds_lcd>;
diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts b/arch/arm/boot/dts/imx6q-pistachio.dts
index a31b17eaf51c..faa3ad912049 100644
--- a/arch/arm/boot/dts/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/imx6q-pistachio.dts
@@ -124,7 +124,7 @@
 
 	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 50000>;
+		pwms = <&pwm1 0 50000 0>;
 		brightness-levels = <
 			0  /*1  2  3  4  5  6*/  7  8  9
 			10 11 12 13 14 15 16 17 18 19
diff --git a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
index c54362fcc508..dad9a2542841 100644
--- a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
+++ b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
@@ -18,7 +18,7 @@
 
 	backlight_lvds: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 50000>;
+		pwms = <&pwm2 0 50000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 248>;
 		default-brightness-level = <7>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 1b5bc6b5e806..7bb985e680ad 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -57,7 +57,7 @@
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		enable-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
index b8e74ab3c993..09722220e5b7 100644
--- a/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apf6dev.dtsi
@@ -13,7 +13,7 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 191000>;
+		pwms = <&pwm3 0 191000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <0>;
 		power-supply = <&reg_5v>;
diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
index 376750882ed3..b9a8da7428d4 100644
--- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
@@ -46,7 +46,7 @@
 / {
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		enable-gpios = <&gpio6 31 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index d03dff23863d..f6cc7599189e 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -51,7 +51,7 @@
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		pwms = <&pwm3 0 5000000>;
+		pwms = <&pwm3 0 5000000 0>;
 		enable-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* Colibri BL_ON */
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index e3be453d8a4a..09cbbc244f12 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -64,7 +64,7 @@
 			active-low;
 			label = "imx6:red:front";
 			max-brightness = <248>;
-			pwms = <&pwm1 0 50000>;
+			pwms = <&pwm1 0 50000 0>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
index 70d26616d771..863061690a1b 100644
--- a/arch/arm/boot/dts/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
@@ -66,7 +66,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_lvds_bl>;
 		enable-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>;
-		pwms = <&pwm1 0 50000>;
+		pwms = <&pwm1 0 50000 0>;
 		brightness-levels = <
 			0 4 8 16 32 64 80 96 112
 			128 144 160 176 250
@@ -78,7 +78,7 @@
 	pwm_fan: pwm-fan {
 		compatible = "pwm-fan";
 		#cooling-cells = <2>;
-		pwms = <&pwm4 0 50000>;
+		pwms = <&pwm4 0 50000 0>;
 		cooling-levels = <0 64 127 191 255>;
 		status = "disabled";
 	};
@@ -145,7 +145,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_rgb_bl>;
 		enable-gpios = <&gpio6 8 GPIO_ACTIVE_HIGH>;
-		pwms = <&pwm3 0 5000000>;
+		pwms = <&pwm3 0 5000000 0>;
 		brightness-levels = <
 			250 176 160 144 128 112
 			96 80 64 48 32 16 8 1
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 1a9a9d98f284..7b9f39156096 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -23,7 +23,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 54b2beadd7a2..e1f44b925e41 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -23,7 +23,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 1b6c1331c220..6dc2d5de60cf 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -24,7 +24,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
index e8e36dfd0a6b..ad28d957b471 100644
--- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
@@ -65,7 +65,7 @@
 
 	backlight-display {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <
 			0  1  2  3  4  5  6  7  8  9
 			10 11 12 13 14 15 16 17 18 19
diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index aee9221f0f29..62cebd978103 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -54,7 +54,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <
 			0  1  2  3  4  5  6  7  8  9
 			10 11 12 13 14 15 16 17 18 19
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 6d21cc6a9d4b..c637e2acb1d7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -63,7 +63,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 756f3a9f1b4f..7357dc217193 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -20,7 +20,7 @@
 
 	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 100000>;
+		pwms = <&pwm3 0 100000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
index 81c7ebb4b3fb..7ba108ccb6b4 100644
--- a/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
@@ -137,7 +137,7 @@
 
 	lcd_backlight: lcd-backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		pwm-names = "LCD_BKLT_PWM";
 
 		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index 2418cf8f2317..4ebf8cae0de2 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -118,7 +118,7 @@
 
 	backlight-lcd {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
@@ -127,7 +127,7 @@
 
 	backlight_lvds0: backlight-lvds0 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index c3415aa348a2..26baf21ec199 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -196,7 +196,7 @@
 
 	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
@@ -205,7 +205,7 @@
 
 	backlight_lvds0: backlight-lvds0 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
@@ -214,7 +214,7 @@
 
 	backlight_lvds1: backlight-lvds1 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm2 0 5000000>;
+		pwms = <&pwm2 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index ed53f07c6b7b..cd10427e812b 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -17,7 +17,7 @@
 
 	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
@@ -26,7 +26,7 @@
 
 	backlight_lvds0: backlight-lvds0 {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 8b0e432099b5..cba2dbd8383d 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -146,7 +146,7 @@
 
 	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
@@ -155,7 +155,7 @@
 
 	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
index 9ebd438dce7d..87072a5f59ca 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
@@ -15,7 +15,7 @@
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_backlight>;
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index cf628465cd0a..79999f1b0adc 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -153,7 +153,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 5000000>;
+		pwms = <&pwm3 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 8468216dae9b..5cee6f7dc080 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -143,7 +143,7 @@
 		#clock-cells = <0>;
 		clock-frequency = <22000000>;
 		clock-output-names = "mipi_pwm3";
-		pwms = <&pwm3 0 45>; /* 1 / 45 ns = 22 MHz */
+		pwms = <&pwm3 0 45 0>; /* 1 / 45 ns = 22 MHz */
 		status = "okay";
 	};
 
@@ -206,7 +206,7 @@
 
 	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
@@ -215,7 +215,7 @@
 
 	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_3p3v>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index fe59dde41b64..0e51f57b6c8c 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -112,7 +112,7 @@
 
 	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6qdl-savageboard.dtsi b/arch/arm/boot/dts/imx6qdl-savageboard.dtsi
index a616e3c400d3..6823a639ed2f 100644
--- a/arch/arm/boot/dts/imx6qdl-savageboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-savageboard.dtsi
@@ -83,7 +83,7 @@
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <4>;
 		power-supply = <&reg_3p3v>;
-		pwms = <&pwm1 0 10000>;
+		pwms = <&pwm1 0 10000 0>;
 	};
 
 	reg_3p3v: regulator-3p3v {
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index c68cb90fd801..362e65ccaa78 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -738,14 +738,12 @@
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-	#pwm-cells = <3>;
 	status = "disabled";
 };
 
 &pwm2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm2>;
-	#pwm-cells = <3>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index e6b4b8525f98..6e0ef24737bb 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -509,7 +509,7 @@
 			};
 
 			pwm1: pwm@2080000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02080000 0x4000>;
 				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
@@ -520,7 +520,7 @@
 			};
 
 			pwm2: pwm@2084000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02084000 0x4000>;
 				interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -531,7 +531,7 @@
 			};
 
 			pwm3: pwm@2088000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x02088000 0x4000>;
 				interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -542,7 +542,7 @@
 			};
 
 			pwm4: pwm@208c000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
 				reg = <0x0208c000 0x4000>;
 				interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index bc86cfaaa9c2..6fef97ce636b 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -23,7 +23,7 @@
 
 	backlight_display: backlight_display {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 59c54e6ad09a..c615290faf48 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -341,7 +341,7 @@
 			};
 
 			pwm1: pwm@2080000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg = <0x02080000 0x4000>;
 				interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
@@ -351,7 +351,7 @@
 			};
 
 			pwm2: pwm@2084000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg = <0x02084000 0x4000>;
 				interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
@@ -361,7 +361,7 @@
 			};
 
 			pwm3: pwm@2088000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg = <0x02088000 0x4000>;
 				interrupts = <0 85 IRQ_TYPE_LEVEL_HIGH>;
@@ -371,7 +371,7 @@
 			};
 
 			pwm4: pwm@208c000 {
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				compatible = "fsl,imx6sl-pwm", "fsl,imx27-pwm";
 				reg = <0x0208c000 0x4000>;
 				interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 5ace9e6acf85..26b065d9275c 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -26,7 +26,7 @@
 
 	backlight_display: backlight-display {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index a1bc5bb31756..95a7dd8c2622 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -329,7 +329,7 @@
 				clocks = <&clks IMX6SLL_CLK_PWM1>,
 					 <&clks IMX6SLL_CLK_PWM1>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm2: pwm@2084000 {
@@ -339,7 +339,7 @@
 				clocks = <&clks IMX6SLL_CLK_PWM2>,
 					 <&clks IMX6SLL_CLK_PWM2>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm3: pwm@2088000 {
@@ -349,7 +349,7 @@
 				clocks = <&clks IMX6SLL_CLK_PWM3>,
 					 <&clks IMX6SLL_CLK_PWM3>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm4: pwm@208c000 {
@@ -359,7 +359,7 @@
 				clocks = <&clks IMX6SLL_CLK_PWM4>,
 					 <&clks IMX6SLL_CLK_PWM4>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			gpt1: timer@2098000 {
diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
index 832b5c5d7441..6c7acc435806 100644
--- a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
@@ -18,7 +18,7 @@
 
 	backlight-lvds {
 		compatible = "pwm-backlight";
-		pwms = <&pwm4 0 5000000>;
+		pwms = <&pwm4 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		power-supply = <&reg_3p3v>;
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index f6972deb5e39..0be08c2229f8 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -23,7 +23,7 @@
 
 	backlight_display: backlight-display {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 5000000>;
+		pwms = <&pwm3 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
diff --git a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
index 28563f21024e..b5c0d35f2554 100644
--- a/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
+++ b/arch/arm/boot/dts/imx6sx-softing-vining-2000.dts
@@ -46,19 +46,19 @@
 		red {
 			label = "red";
 			max-brightness = <255>;
-			pwms = <&pwm6 0 50000>;
+			pwms = <&pwm6 0 50000 0>;
 		};
 
 		green {
 			label = "green";
 			max-brightness = <255>;
-			pwms = <&pwm2 0 50000>;
+			pwms = <&pwm2 0 50000 0>;
 		};
 
 		blue {
 			label = "blue";
 			max-brightness = <255>;
-			pwms = <&pwm1 0 50000>;
+			pwms = <&pwm1 0 50000 0>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 59bad60a47dc..af77b86281fc 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -411,7 +411,7 @@
 				clocks = <&clks IMX6SX_CLK_PWM1>,
 					 <&clks IMX6SX_CLK_PWM1>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm2: pwm@2084000 {
@@ -421,7 +421,7 @@
 				clocks = <&clks IMX6SX_CLK_PWM2>,
 					 <&clks IMX6SX_CLK_PWM2>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm3: pwm@2088000 {
@@ -431,7 +431,7 @@
 				clocks = <&clks IMX6SX_CLK_PWM3>,
 					 <&clks IMX6SX_CLK_PWM3>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm4: pwm@208c000 {
@@ -441,7 +441,7 @@
 				clocks = <&clks IMX6SX_CLK_PWM4>,
 					 <&clks IMX6SX_CLK_PWM4>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			flexcan1: can@2090000 {
@@ -1329,7 +1329,7 @@
 				clocks = <&clks IMX6SX_CLK_PWM5>,
 					 <&clks IMX6SX_CLK_PWM5>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm6: pwm@22a8000 {
@@ -1339,7 +1339,7 @@
 				clocks = <&clks IMX6SX_CLK_PWM6>,
 					 <&clks IMX6SX_CLK_PWM6>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm7: pwm@22ac000 {
@@ -1349,7 +1349,7 @@
 				clocks = <&clks IMX6SX_CLK_PWM7>,
 					 <&clks IMX6SX_CLK_PWM7>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 
 			pwm8: pwm@22b0000 {
@@ -1359,7 +1359,7 @@
 				clocks = <&clks IMX6SX_CLK_PWM8>,
 					 <&clks IMX6SX_CLK_PWM8>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 			};
 		};
 
diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index 265bf4108cb6..adc87ccb7380 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -14,7 +14,7 @@
 
 	backlight_display: backlight-display {
 		compatible = "pwm-backlight";
-		pwms = <&pwm1 0 5000000>;
+		pwms = <&pwm1 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
index 3749fdda3611..7691f26c0f18 100644
--- a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
+++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
@@ -18,7 +18,7 @@
 
 	lcd_backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm5 0 50000>;
+		pwms = <&pwm5 0 50000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-geam.dts b/arch/arm/boot/dts/imx6ul-geam.dts
index 9f63706383a7..c3060f28111e 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/imx6ul-geam.dts
@@ -21,7 +21,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm8 0 100000>;
+		pwms = <&pwm8 0 100000 0>;
 		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
 				     10 11 12 13 14 15 16 17 18 19
 				     20 21 22 23 24 25 26 27 28 29
diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi b/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
index 18966350bfd8..614f165f66cf 100644
--- a/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
+++ b/arch/arm/boot/dts/imx6ul-imx6ull-opos6uldev.dtsi
@@ -9,7 +9,7 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 191000>;
+		pwms = <&pwm3 0 191000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <7>;
 		power-supply = <&reg_5v>;
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index cc9adce638f5..ee86c36205f9 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -20,7 +20,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm8 0 100000>;
+		pwms = <&pwm8 0 100000 0>;
 		brightness-levels = < 0  1  2  3  4  5  6  7  8  9
 				     10 11 12 13 14 15 16 17 18 19
 				     20 21 22 23 24 25 26 27 28 29
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts b/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
index 5bad29683cc3..b3638367494d 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
@@ -14,7 +14,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm7 0 5000000>;
+		pwms = <&pwm7 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
index f05e91841202..7aaf08bae1b7 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
@@ -35,7 +35,7 @@
 
 	pwm-beeper {
 		compatible = "pwm-beeper";
-		pwms = <&pwm8 0 5000>;
+		pwms = <&pwm8 0 5000 0>;
 	};
 
 	reg_3v3: regulator-3v3 {
diff --git a/arch/arm/boot/dts/imx6ul-pico.dtsi b/arch/arm/boot/dts/imx6ul-pico.dtsi
index de9f83189ba8..699d64f3c6e9 100644
--- a/arch/arm/boot/dts/imx6ul-pico.dtsi
+++ b/arch/arm/boot/dts/imx6ul-pico.dtsi
@@ -22,7 +22,7 @@
 
 	backlight {
 		compatible = "pwm-backlight";
-		pwms = <&pwm3 0 5000000>;
+		pwms = <&pwm3 0 5000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 		status = "okay";
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index bb6dbfd5546b..938a32ced88d 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -549,7 +549,6 @@
 &pwm5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm5>;
-	#pwm-cells = <3>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index d9fdca12819b..858552d21434 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -371,7 +371,7 @@
 				clocks = <&clks IMX6UL_CLK_PWM1>,
 					 <&clks IMX6UL_CLK_PWM1>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -382,7 +382,7 @@
 				clocks = <&clks IMX6UL_CLK_PWM2>,
 					 <&clks IMX6UL_CLK_PWM2>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -393,7 +393,7 @@
 				clocks = <&clks IMX6UL_CLK_PWM3>,
 					 <&clks IMX6UL_CLK_PWM3>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -404,7 +404,7 @@
 				clocks = <&clks IMX6UL_CLK_PWM4>,
 					 <&clks IMX6UL_CLK_PWM4>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -733,7 +733,7 @@
 				clocks = <&clks IMX6UL_CLK_PWM5>,
 					 <&clks IMX6UL_CLK_PWM5>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -744,7 +744,7 @@
 				clocks = <&clks IMX6UL_CLK_PWM6>,
 					 <&clks IMX6UL_CLK_PWM6>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -755,7 +755,7 @@
 				clocks = <&clks IMX6UL_CLK_PWM7>,
 					 <&clks IMX6UL_CLK_PWM7>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 
@@ -766,7 +766,7 @@
 				clocks = <&clks IMX6UL_CLK_PWM8>,
 					 <&clks IMX6UL_CLK_PWM8>;
 				clock-names = "ipg", "per";
-				#pwm-cells = <2>;
+				#pwm-cells = <3>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 9145c536d71a..6cf95939121d 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -145,25 +145,21 @@
 &pwm4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm4>;
-	#pwm-cells = <3>;
 };
 
 &pwm5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm5>;
-	#pwm-cells = <3>;
 };
 
 &pwm6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm6>;
-	#pwm-cells = <3>;
 };
 
 &pwm7 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm7>;
-	#pwm-cells = <3>;
 };
 
 &sdma {
-- 
2.20.1

