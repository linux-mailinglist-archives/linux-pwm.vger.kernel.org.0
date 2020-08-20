Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B724C816
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 00:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgHTW4D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Aug 2020 18:56:03 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39149 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgHTW4C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Aug 2020 18:56:02 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 40AA060002;
        Thu, 20 Aug 2020 22:55:59 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Antoine Aubert <a.aubert@overkiz.com>
Subject: [PATCH 4/4] ARM: dts: at91: kizbox: switch to new pwm-atmel-tcb binding
Date:   Fri, 21 Aug 2020 00:55:46 +0200
Message-Id: <20200820225546.2246517-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
References: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Switch to the new pwm-atmel-tcb binding that avoid wasting TCB channels.

Cc: Antoine Aubert <a.aubert@overkiz.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-kizbox.dts | 45 ++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
index 7d938ccf71b0..3e255bf8707c 100644
--- a/arch/arm/boot/dts/at91-kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -53,43 +53,32 @@ pwm_leds {
 
 		network_green {
 			label = "pwm:green:network";
-			pwms = <&tcb_pwm 2 10000000 PWM_POLARITY_INVERTED>;
+			pwms = <&tcb1_pwm1 0 10000000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 
 		network_red {
 			label = "pwm:red:network";
-			pwms = <&tcb_pwm 4 10000000 PWM_POLARITY_INVERTED>;
+			pwms = <&tcb1_pwm2 0 10000000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 
 		user_green {
 			label = "pwm:green:user";
-			pwms = <&tcb_pwm 0 10000000 PWM_POLARITY_INVERTED>;
+			pwms = <&tcb1_pwm0 0 10000000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 
 		user_red {
 			label = "pwm:red:user";
-			pwms = <&tcb_pwm 1 10000000 PWM_POLARITY_INVERTED>;
+			pwms = <&tcb1_pwm0 1 10000000 PWM_POLARITY_INVERTED>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
 		};
 	};
-
-	tcb_pwm: pwm {
-		compatible = "atmel,tcb-pwm";
-		#pwm-cells = <3>;
-		tc-block = <1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_tcb1_tioa0
-			     &pinctrl_tcb1_tioa1
-			     &pinctrl_tcb1_tioa2
-			     &pinctrl_tcb1_tiob0>;
-	};
 };
 
 &tcb0 {
@@ -104,6 +93,32 @@ timer@2 {
 	};
 };
 
+&tcb1 {
+	tcb1_pwm0: pwm@0 {
+		compatible = "atmel,tcb-pwm";
+		reg = <0>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tcb1_tioa0 &pinctrl_tcb1_tiob0>;
+	};
+
+	tcb1_pwm1: pwm@1 {
+		compatible = "atmel,tcb-pwm";
+		reg = <1>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tcb1_tioa1>;
+	};
+
+	tcb1_pwm2: pwm@2 {
+		compatible = "atmel,tcb-pwm";
+		reg = <2>;
+		#pwm-cells = <3>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tcb1_tioa2>;
+	};
+};
+
 &ebi {
 	status = "okay";
 };
-- 
2.26.2

