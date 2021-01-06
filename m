Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85872EBA9C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Jan 2021 08:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAFHif (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Jan 2021 02:38:35 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:36299 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbhAFHif (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 6 Jan 2021 02:38:35 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id DB64D4409D4;
        Wed,  6 Jan 2021 09:37:51 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Baruch Siach <baruch@tkos.co.il>, Rob Herring <robh@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v6 4/4] dt-bindings: ap806: document gpio marvell,pwm-offset property
Date:   Wed,  6 Jan 2021 09:37:40 +0200
Message-Id: <2c6ca62ad42e08dcf308f91a8da8124749d44308.1609917364.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1609917364.git.baruch@tkos.co.il>
References: <cover.1609917364.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Update the example as well. Add the '#pwm-cells' and 'clocks' properties
for a complete working example.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../bindings/arm/marvell/ap80x-system-controller.txt      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
index e31511255d8e..052a967c1f28 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap80x-system-controller.txt
@@ -80,6 +80,11 @@ Required properties:
 
 - offset: offset address inside the syscon block
 
+Optional properties:
+
+- marvell,pwm-offset: offset address of PWM duration control registers inside
+  the syscon block
+
 Example:
 ap_syscon: system-controller@6f4000 {
 	compatible = "syscon", "simple-mfd";
@@ -101,6 +106,9 @@ ap_syscon: system-controller@6f4000 {
 		gpio-controller;
 		#gpio-cells = <2>;
 		gpio-ranges = <&ap_pinctrl 0 0 19>;
+		marvell,pwm-offset = <0x10c0>;
+		#pwm-cells = <2>;
+		clocks = <&ap_clk 3>;
 	};
 };
 
-- 
2.29.2

