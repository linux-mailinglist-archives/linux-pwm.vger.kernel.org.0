Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A3A196CAB
	for <lists+linux-pwm@lfdr.de>; Sun, 29 Mar 2020 12:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgC2KtQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Mar 2020 06:49:16 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35734 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgC2KtQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 29 Mar 2020 06:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:To:From:References:In-Reply-To
        :Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x4H/muhRkVbWTkqwR7Y2GiaMhYMGh6GNnyeZHrDRLfw=; b=FHFux9GQtyLyzll5CvT1Qwq4PJ
        4vDnaCDQ1sYTZYPOpGrAiD9v57Jf/YiusrDG8tu5kay4Gg00yZtx6JDbmkwPCXkTv96v13hCtF64p
        r8SfCwmzv+6SUeKTTzIZAeNfRxcmpRrSmsigqmRW1yHJssFIeQLGiruAikYVhyD1zieKsGFWBmMgI
        Dyg3SfbIOdmBZ1ygQnEsn3KgQybd6J42ATbtnYpBlhM5R/CIxtG+xzqZxwoLkKzHLAtya7i+zzhKN
        7RmLLl37illC7awXe+BR81AEDMx4e9i1rBwBfoxYyIeXguXXgaQdVyIM+ENREslR9xHr+V/fBg90T
        LP1YRugQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53426 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1jIVUZ-0004WB-Bd; Sun, 29 Mar 2020 11:48:35 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1jIVUU-0005hk-AO; Sun, 29 Mar 2020 11:48:30 +0100
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
Subject: [PATCH RFC 6/6] arm64: dts: clearfog-gt-8k: add cooling maps
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1jIVUU-0005hk-AO@rmk-PC.armlinux.org.uk>
Date:   Sun, 29 Mar 2020 11:48:30 +0100
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 .../marvell/armada-8040-clearfog-gt-8k.dts    | 122 +++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index a514ae51ccbf..1e7b47affe26 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -31,8 +31,11 @@
 		ethernet2 = &cp1_eth2;
 	};
 
-	pwm {
+	fan: pwm {
 		compatible = "pwm-fan";
+		/* 20% steps */
+		cooling-levels = <0 51 102 153 204 255>;
+		#cooling-cells = <2>;
 		pwms = <&cp0_gpio2 16 40000>;
 	};
 
@@ -107,6 +110,123 @@
 	};
 };
 
+&ap_thermal_ic {
+	polling-delay = <1000>; /* milliseconds */
+	trips {
+		ap_active: trip-active {
+			temperature = <40000>; /* millicelsius */
+			hysteresis = <4000>; /* millicelsius */
+			type = "active";
+		};
+	};
+	cooling-maps {
+		map0 {
+			trip = <&ap_active>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 4>;
+		};
+		map1 {
+			trip = <&ap_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+&cp0_thermal_ic {
+	polling-delay = <1000>; /* milliseconds */
+	trips {
+		cp0_active0: trip-active0 {
+			temperature = <40000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp0_active1: trip-active1 {
+			temperature = <45000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp0_active2: trip-active2 {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp0_active3: trip-active3 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+	};
+	cooling-maps {
+		map0 {
+			trip = <&cp0_active0>;
+			cooling-device = <&fan 0 1>;
+		};
+		map1 {
+			trip = <&cp0_active1>;
+			cooling-device = <&fan 1 2>;
+		};
+		map2 {
+			trip = <&cp0_active2>;
+			cooling-device = <&fan 2 3>;
+		};
+		map3 {
+			trip = <&cp0_active3>;
+			cooling-device = <&fan 3 4>;
+		};
+		map4 {
+			trip = <&cp0_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
+&cp1_thermal_ic {
+	polling-delay = <1000>; /* milliseconds */
+	trips {
+		cp1_active0: trip-active0 {
+			temperature = <40000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp1_active1: trip-active1 {
+			temperature = <45000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp1_active2: trip-active2 {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+		cp1_active3: trip-active3 {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <2500>; /* millicelsius */
+			type = "active";
+		};
+	};
+	cooling-maps {
+		map0 {
+			trip = <&cp1_active0>;
+			cooling-device = <&fan 0 1>;
+		};
+		map1 {
+			trip = <&cp1_active1>;
+			cooling-device = <&fan 1 2>;
+		};
+		map2 {
+			trip = <&cp1_active2>;
+			cooling-device = <&fan 2 3>;
+		};
+		map3 {
+			trip = <&cp1_active3>;
+			cooling-device = <&fan 3 4>;
+		};
+		map4 {
+			trip = <&cp1_crit>;
+			cooling-device = <&fan 4 5>;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 	pinctrl-0 = <&uart0_pins>;
-- 
2.20.1

