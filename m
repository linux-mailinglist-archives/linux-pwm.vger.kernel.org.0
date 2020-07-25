Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1138C22DA76
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jul 2020 01:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGYXTL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 Jul 2020 19:19:11 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:37695 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728158AbgGYXTI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Jul 2020 19:19:08 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 10FBE23E4C;
        Sun, 26 Jul 2020 01:19:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595719145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ai0La+0NTz47zNKNe8eCNR0aOanRg5MZY86cm9G5UM=;
        b=kqEGlrmPMMmvf5UYnEWCX7xD16NalVyHm8iD2CKx6Y+VwWk2EGFCxx+7e2BzfsxBTFTocT
        xKhT9AwybYVF9eTawp2dkCoEjLAYb9sPdI7mKhh5f5Hp5Tr+Nz3FtcRvrdnqlecrAVjUCY
        XGTnkTsDPcSANAkKEr4FbAPcv5Jttyc=
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v6 09/13] arm64: dts: freescale: sl28: enable sl28cpld
Date:   Sun, 26 Jul 2020 01:18:30 +0200
Message-Id: <20200725231834.25642-10-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200725231834.25642-1-michael@walle.cc>
References: <20200725231834.25642-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the board management controller node.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v5:
 - none

Changes since v4:
 - none

Changes since v3:
 - see cover letter

 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 360b3a168c10..8712fe82727b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -8,6 +8,7 @@
 
 /dts-v1/;
 #include "fsl-ls1028a.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Kontron SMARC-sAL28";
@@ -170,6 +171,107 @@
 		reg = <0x32>;
 	};
 
+	sl28cpld@4a {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "kontron,sl28cpld-r1";
+		reg = <0x4a>;
+
+		watchdog@4 {
+			compatible = "kontron,sl28cpld-wdt";
+			reg = <0x4>;
+			kontron,assert-wdt-timeout-pin;
+		};
+
+		hwmon@b {
+			compatible = "kontron,sl28cpld-fan";
+			reg = <0xb>;
+		};
+
+		sl28cpld_pwm0: pwm@c {
+			#pwm-cells = <2>;
+			compatible = "kontron,sl28cpld-pwm";
+			reg = <0xc>;
+		};
+
+		sl28cpld_pwm1: pwm@e {
+			#pwm-cells = <2>;
+			compatible = "kontron,sl28cpld-pwm";
+			reg = <0xe>;
+		};
+
+		sl28cpld_gpio0: gpio@10 {
+			compatible = "kontron,sl28cpld-gpio";
+			reg = <0x10>;
+			interrupts-extended = <&gpio2 6
+					       IRQ_TYPE_EDGE_FALLING>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"GPIO0_CAM0_PWR_N", "GPIO1_CAM1_PWR_N",
+				"GPIO2_CAM0_RST_N", "GPIO3_CAM1_RST_N",
+				"GPIO4_HDA_RST_N", "GPIO5_PWM_OUT",
+				"GPIO6_TACHIN", "GPIO7";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		sl28cpld_gpio1: gpio@15 {
+			compatible = "kontron,sl28cpld-gpio";
+			reg = <0x15>;
+			interrupts-extended = <&gpio2 6
+					       IRQ_TYPE_EDGE_FALLING>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"GPIO8", "GPIO9", "GPIO10", "GPIO11",
+				"", "", "", "";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		sl28cpld_gpio2: gpio@1a {
+			compatible = "kontron,sl28cpld-gpo";
+			reg = <0x1a>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"LCD0 voltage enable",
+				"LCD0 backlight enable",
+				"eMMC reset", "LVDS bridge reset",
+				"LVDS bridge power-down",
+				"SDIO power enable",
+				"", "";
+		};
+
+		sl28cpld_gpio3: gpio@1b {
+			compatible = "kontron,sl28cpld-gpi";
+			reg = <0x1b>;
+
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-line-names =
+				"Power button", "Force recovery", "Sleep",
+				"Battery low", "Lid state", "Charging",
+				"Charger present", "";
+		};
+
+		sl28cpld_intc: interrupt-controller@1c {
+			compatible = "kontron,sl28cpld-intc";
+			reg = <0x1c>;
+			interrupts-extended = <&gpio2 6
+					       IRQ_TYPE_EDGE_FALLING>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	eeprom@50 {
 		compatible = "atmel,24c32";
 		reg = <0x50>;
-- 
2.20.1

