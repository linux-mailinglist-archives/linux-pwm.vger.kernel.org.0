Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF733288CAC
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Oct 2020 17:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbgJIPaw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Oct 2020 11:30:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:34442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388473AbgJIPau (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 9 Oct 2020 11:30:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6A0DAF2B;
        Fri,  9 Oct 2020 15:30:48 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     f.fainelli@gmail.com, linux@roeck-us.net, jdelvare@suse.com,
        wahrenst@gmx.net,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] DO NOT MERGE: ARM: dts: Add RPi's official PoE hat support
Date:   Fri,  9 Oct 2020 17:30:29 +0200
Message-Id: <20201009153031.986-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009153031.986-1-nsaenzjulienne@suse.de>
References: <20201009153031.986-1-nsaenzjulienne@suse.de>
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
index 09a1182c2936..98ecb9d82ecd 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -5,6 +5,7 @@
 #include "bcm283x-rpi-usb-peripheral.dtsi"
 
 #include <dt-bindings/reset/raspberrypi,firmware-reset.h>
+#include <dt-bindings/pwm/raspberrypi,firmware-pwm.h>
 
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
+		pwms = <&fwpwm RASPBERRYPI_FIRMWARE_PWM_POE>;
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
+		compatible = "raspberrypi,firmware-pwm";
+		#pwm-cells = <1>;
+	};
 };
 
 &gpio {
-- 
2.28.0

