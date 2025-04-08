Return-Path: <linux-pwm+bounces-5380-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F662A8089A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 14:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272324C27F1
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Apr 2025 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FF026FD93;
	Tue,  8 Apr 2025 12:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="C6aeUss1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02E269AE4;
	Tue,  8 Apr 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115669; cv=pass; b=k1NLxYcCB+nr01pSQ8XPqcPRqd8wEIs4k0WtGWZKVAI7UDZ296ZiF2QY/v1fW6wci5p3lPEGnQ5CsK1TwYHbl6NDMfEljQevVXW5djLJMSwBx5T5I7j3U+5fjqwKVRIMePMjVwAzK0BargA6AQ8Se2fceMDm4IsTJe0D5x7f38I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115669; c=relaxed/simple;
	bh=if/kr7T1muk0IP3cVraxY2a6knWPUWP7GhMVOCw6VRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ql4lnzTgnejQ983CM3W+9XkcS2TSRMnLxkgmbZb8ThJ+kdUt0V6EwhrcU69f/9/SQOXGnVMp6VilPcYc5gQnv8X/9j9Ln0afxyuMnq5oJbj80IiyzAFoKAdcTGROOAYSDE+ASDSx4zZImthwSzXHuZjIjoRsBc5nCZ84uO0GwxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=C6aeUss1; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744115629; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RWCNx6stV+pP3bP/tkWGy9XDyRCmWiirtuNX7yrMmpnuEJIYmli40n7wNccdwba0EtB8ENylzgL4G3/9ozUjA4r93DZYsf2PDxPgA5Mw1TU5zOCdipYsVKoZDUXkkGlt9VygAy/aZn6DfsJlqXcEzv2ELE0t89y2r2MoKxGuhoY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744115629; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=17mDEEnDb/oaPKd4Ui5u9Q302d1mb74mkE4XB4hCKsI=; 
	b=PoqxXKkL7X6ETKiWDCeM7H8BfcetLACWz2LBwkJ1qBhzVjtOEUa2E+y0mc4fX9Y6tVuw/lunAix0UY750HeJnENhg62AX5B0ifd4bftiNmu9bRgbAB/UDe79PLwQ3DYysY3uRbcYzLsIaOd68RaaFXtmU5k8v558FCkWaTtT0Rs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744115629;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=17mDEEnDb/oaPKd4Ui5u9Q302d1mb74mkE4XB4hCKsI=;
	b=C6aeUss1kxlGtGNTEfRSAhKpejgkfmVBa5CDAql+Q33R0Col+ucd+ILPS/BbU+h9
	WKwHFb7da9XUuhJzo8M6OEwNboB3V/NqzThsSA45d0yFZ6O6mh0A2TWcF36Un7VGehA
	8Y6XvtNWn60pcdq413RxMJ/Rdt3ppJG0Holj/O0Y=
Received: by mx.zohomail.com with SMTPS id 1744115627338768.785220927375;
	Tue, 8 Apr 2025 05:33:47 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Tue, 08 Apr 2025 14:32:14 +0200
Subject: [PATCH 2/7] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-rk3576-pwm-v1-2-a49286c2ca8e@collabora.com>
References: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
In-Reply-To: <20250408-rk3576-pwm-v1-0-a49286c2ca8e@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-iio@vger.kernel.org, kernel@collabora.com, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The Rockchip RK3576 SoC has a newer PWM controller IP revision than
previous Rockchip SoCs. This IP, called "PWMv4" by Rockchip, introduces
several new features, and consequently differs in its bindings.

Instead of expanding the ever-growing rockchip-pwm binding that already
has an if-condition, add an entirely new binding to handle this.

The "osc" clock is an optional clock available on some instances of the
PWM controller. If present, it allows the controller to switch between
either the "pwm" clock or the "osc" clock for deriving its PWM signal
on a per-channel basis, through a hardware register write.

However, not all instances have this feature, and the hardware copes
just fine without this additional clock, so it's optional.

The PWM controller also comes with an interrupt now. This interrupt is
used to signal various conditions.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/pwm/rockchip,rk3576-pwm.yaml          | 94 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 101 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml b/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..143d4df5df8fa89d508faca5ddf67603fb7cb3f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/rockchip,rk3576-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip PWMv4 controller
+
+maintainers:
+  - Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+
+description: |
+  The Rockchip PWMv4 controller is a PWM controller found on several Rockchip
+  SoCs, such as the RK3576.
+
+  It supports both generating and capturing PWM signals.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: rockchip,rk3576-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    items:
+      - description: Used to derive the PWM signal.
+      - description: Used as the APB bus clock.
+      - description: Used as an added alternative to derive the PWM signal.
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: pwm
+      - const: pclk
+      - const: osc
+
+  interrupts:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3576-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pwm@2add0000 {
+            compatible = "rockchip,rk3576-pwm";
+            reg = <0x0 0x2add0000 0x0 0x1000>;
+            clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>, <&cru CLK_OSC_PWM1>;
+            clock-names = "pwm", "pclk", "osc";
+            interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+            #pwm-cells = <3>;
+        };
+    };
+  - |
+    #include <dt-bindings/clock/rockchip,rk3576-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pwm@2ade3000 {
+            compatible = "rockchip,rk3576-pwm";
+            reg = <0x0 0x2ade3000 0x0 0x1000>;
+            clocks = <&cru CLK_PWM2>, <&cru PCLK_PWM2>;
+            clock-names = "pwm", "pclk";
+            interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
+            #pwm-cells = <3>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 96b82704950184bd71623ff41fc4df31e4c7fe87..407179d2a90dd49800f2bb5770a1280c5afebb5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20885,6 +20885,13 @@ F:	Documentation/userspace-api/media/v4l/metafmt-rkisp1.rst
 F:	drivers/media/platform/rockchip/rkisp1
 F:	include/uapi/linux/rkisp1-config.h
 
+ROCKCHIP MFPWM
+M:	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
+L:	linux-rockchip@lists.infradead.org
+L:	linux-pwm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
+
 ROCKCHIP RK3568 RANDOM NUMBER GENERATOR SUPPORT
 M:	Daniel Golle <daniel@makrotopia.org>
 M:	Aurelien Jarno <aurelien@aurel32.net>

-- 
2.49.0


