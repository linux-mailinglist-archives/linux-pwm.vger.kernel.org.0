Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8490D196CA8
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2020 12:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgC2KtJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Mar 2020 06:49:09 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35690 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgC2KtI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 06:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:To:From:References:In-Reply-To
        :Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vXYY5z/ib46qhy4U0CkhLW8/nfu/Rd7Z0xRYxAP+zvg=; b=EPP3zCmvtwDEKZ34xgnrULqxyR
        5Q/QgHDRH4o0axsJX7Rnlgv1EWspoyyXL/IBDi7/IoSbv0xVFplWfk18V3s4lSHjW7MJyDN1oP7eY
        AinoNgFi066dRPKpQTiQp0HpqwbFUtxfAdqVD8WJ6rIiPcJYNjXA1vEaRjKsFYXfWZk77iTtemWZG
        vELSsVzzjWi6qZFahx4v5IZ/ufwzOJ2rREjldloy2l5nvnWtk2djg5D8tWTu54604m6jqYpyT3kwa
        CnjAoXH1W2nogBdH91OI5eDsL0mC1ebUg1rPhkURQL9rsTqwcAZYkniok7p666rd2Eunyd9k2HE0s
        1dhXJrow==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:45286 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1jIVUN-0004Vu-4x; Sun, 29 Mar 2020 11:48:23 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1jIVUK-0005hJ-33; Sun, 29 Mar 2020 11:48:20 +0100
In-Reply-To: <20200329104549.GX25745@shell.armlinux.org.uk>
References: <20200329104549.GX25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Uwe Kleine-Konig" <u.kleine-koenig@pengutronix.de>
Subject: [PATCH RFC 4/6] arm64: dts: armada-cp11x: add pwm support to GPIO
 blocks
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1jIVUK-0005hJ-33@rmk-PC.armlinux.org.uk>
Date:   Sun, 29 Mar 2020 11:48:20 +0100
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add PWM support to the GPIO blocks.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 024073edfc1c..dfd251acc194 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -311,6 +311,7 @@
 				ngpios = <32>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				gpio-ranges = <&CP11X_LABEL(pinctrl) 0 0 32>;
 				interrupt-controller;
 				interrupts = <86 IRQ_TYPE_LEVEL_HIGH>,
@@ -319,6 +320,8 @@
 					<83 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <2>;
 				status = "disabled";
+				clock-names = "core";
+				clocks = <&CP11X_LABEL(clk) 1 21>;
 			};
 
 			CP11X_LABEL(gpio2): gpio@140 {
@@ -327,6 +330,7 @@
 				ngpios = <31>;
 				gpio-controller;
 				#gpio-cells = <2>;
+				#pwm-cells = <2>;
 				gpio-ranges = <&CP11X_LABEL(pinctrl) 0 32 31>;
 				interrupt-controller;
 				interrupts = <82 IRQ_TYPE_LEVEL_HIGH>,
@@ -335,6 +339,8 @@
 					<79 IRQ_TYPE_LEVEL_HIGH>;
 				#interrupt-cells = <2>;
 				status = "disabled";
+				clock-names = "core";
+				clocks = <&CP11X_LABEL(clk) 1 21>;
 			};
 		};
 
-- 
2.20.1

