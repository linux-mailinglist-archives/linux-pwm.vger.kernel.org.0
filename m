Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB407338CED
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 13:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhCLMZp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 07:25:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231458AbhCLMZ2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Mar 2021 07:25:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51244B0C6;
        Fri, 12 Mar 2021 12:25:26 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v8 10/11] DO NOT MERGE: ARM: dts: Add RPi's official PoE hat support
Date:   Fri, 12 Mar 2021 13:24:53 +0100
Message-Id: <20210312122454.24480-11-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312122454.24480-1-nsaenzjulienne@suse.de>
References: <20210312122454.24480-1-nsaenzjulienne@suse.de>
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
index 3b4ab947492a..6897c7831d09 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -5,6 +5,7 @@
 #include "bcm283x-rpi-usb-peripheral.dtsi"
 
 #include <dt-bindings/reset/raspberrypi,firmware-reset.h>
+#include <dt-bindings/pwm/raspberrypi,firmware-poe-pwm.h>
 
 / {
 	compatible = "raspberrypi,4-model-b", "brcm,bcm2711";
@@ -69,6 +70,54 @@ sd_vcc_reg: sd_vcc_reg {
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
@@ -104,6 +153,11 @@ reset: reset {
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
2.30.1

