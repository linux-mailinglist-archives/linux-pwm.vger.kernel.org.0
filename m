Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6302D7BA2
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 17:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391735AbgLKQvN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 11:51:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:34846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390282AbgLKQtf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 11 Dec 2020 11:49:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4C10B283;
        Fri, 11 Dec 2020 16:48:20 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
Subject: [PATCH v6 10/11] DO NOT MERGE: ARM: dts: Add RPi's official PoE hat support
Date:   Fri, 11 Dec 2020 17:47:59 +0100
Message-Id: <20201211164801.7838-11-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211164801.7838-1-nsaenzjulienne@suse.de>
References: <20201211164801.7838-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is an example on how to enable the fan on top of RPi's official PoE
hat.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 403bacf986eb..9ae44620c5b8 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -5,6 +5,7 @@
 #include "bcm283x-rpi-usb-peripheral.dtsi"
 
 #include <dt-bindings/reset/raspberrypi,firmware-reset.h>
+#include <dt-bindings/pwm/raspberrypi,firmware-poe-pwm.h>
 
 / {
 	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
@@ -68,6 +69,54 @@ sd_vcc_reg: sd_vcc_reg {
 		enable-active-high;
 		gpio = <&expgpio 6 GPIO_ACTIVE_HIGH>;
 	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <0 50 150 255>;
+		#cooling-cells = <2>;
+		pwms = <&fwpwm RASPBERRYPI_FIRMWARE_PWM_POE 80000>;
+	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			trips {
+				threshold: trip-point@0 {
+					temperature = <45000>;
+					hysteresis = <5000>;
+					type = "active";
+				};
+
+				target: trip-point@1 {
+					temperature = <50000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+
+				cpu_hot: cpu_hot@0 {
+					temperature = <55000>;
+					hysteresis = <2000>;
+					type = "active";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&threshold>;
+					cooling-device = <&fan 0 1>;
+				};
+
+				map1 {
+					trip = <&target>;
+					cooling-device = <&fan 1 2>;
+				};
+
+				map2 {
+					trip = <&cpu_hot>;
+					cooling-device = <&fan 2 3>;
+				};
+			};
+		};
+	};
 };
 
 &ddc0 {
@@ -103,6 +152,11 @@ reset: reset {
 		compatible = "raspberrypi,firmware-reset";
 		#reset-cells = <1>;
 	};
+
+	fwpwm: pwm {
+		compatible = "raspberrypi,firmware-poe-pwm";
+		#pwm-cells = <2>;
+	};
 };
 
 &gpio {
-- 
2.29.2

