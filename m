Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B052EAB10
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Jan 2021 13:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbhAEMn3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Jan 2021 07:43:29 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:34636 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbhAEMn3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 5 Jan 2021 07:43:29 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id B25E1440820;
        Tue,  5 Jan 2021 14:42:43 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v5 3/4] arm64: dts: armada: add pwm offsets for ap/cp gpios
Date:   Tue,  5 Jan 2021 14:42:30 +0200
Message-Id: <e783b1233a8d0bc2ef25f5b5b9a7385adc52c8e2.1609849176.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1609849176.git.baruch@tkos.co.il>
References: <cover.1609849176.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The 'marvell,pwm-offset' property of both GPIO blocks (per CP component)
point to the same counter registers offset. The driver will decide how
to use counters A/B.

This is different from the convention of pwm on earlier Armada series
(370/38x). On those systems the assignment of A/B counters to GPIO
blocks is coded in both DT and the driver. The actual behaviour of the
current driver on Armada 8K/7K is the same as earlier systems.

Add also clock properties for base pwm frequency reference.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm64/boot/dts/marvell/armada-ap80x.dtsi |  3 +++
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
index 12e477f1aeb9..6614472100c2 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
@@ -281,6 +281,9 @@ ap_gpio: gpio@1040 {
 					gpio-controller;
 					#gpio-cells = <2>;
 					gpio-ranges = <&ap_pinctrl 0 0 20>;
+					marvell,pwm-offset = <0x10c0>;
+					#pwm-cells = <2>;
+					clocks = <&ap_clk 3>;
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 994a2fce449a..d774a39334d9 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -234,12 +234,17 @@ CP11X_LABEL(gpio1): gpio@100 {
 				gpio-controller;
 				#gpio-cells = <2>;
 				gpio-ranges = <&CP11X_LABEL(pinctrl) 0 0 32>;
+				marvell,pwm-offset = <0x1f0>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				interrupts = <86 IRQ_TYPE_LEVEL_HIGH>,
 					<85 IRQ_TYPE_LEVEL_HIGH>,
 					<84 IRQ_TYPE_LEVEL_HIGH>,
 					<83 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <2>;
+				clock-names = "core", "axi";
+				clocks = <&CP11X_LABEL(clk) 1 21>,
+					 <&CP11X_LABEL(clk) 1 17>;
 				status = "disabled";
 			};
 
@@ -250,12 +255,17 @@ CP11X_LABEL(gpio2): gpio@140 {
 				gpio-controller;
 				#gpio-cells = <2>;
 				gpio-ranges = <&CP11X_LABEL(pinctrl) 0 32 31>;
+				marvell,pwm-offset = <0x1f0>;
+				#pwm-cells = <2>;
 				interrupt-controller;
 				interrupts = <82 IRQ_TYPE_LEVEL_HIGH>,
 					<81 IRQ_TYPE_LEVEL_HIGH>,
 					<80 IRQ_TYPE_LEVEL_HIGH>,
 					<79 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <2>;
+				clock-names = "core", "axi";
+				clocks = <&CP11X_LABEL(clk) 1 21>,
+					 <&CP11X_LABEL(clk) 1 17>;
 				status = "disabled";
 			};
 		};
-- 
2.29.2

