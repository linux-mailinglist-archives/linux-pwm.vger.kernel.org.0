Return-Path: <linux-pwm+bounces-6221-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCDCACB982
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA55189AF01
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB219224B0C;
	Mon,  2 Jun 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="jluxEtLT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8A22257E;
	Mon,  2 Jun 2025 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881227; cv=pass; b=lqTYMG++XzLjFwHyKjNxA4Qd39L6p56mo9+g5J03e77973JAYvnNu5IwolrC+gyZWRPxO8FVrteVjofUfVCqq7py/sLf1ioRaeNt5RhmtNqIn6myBUS10NRu847DVVgP4LnC3IgaubAIs+9p7IqBM6gsfrQAUT8emfFHIML6EkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881227; c=relaxed/simple;
	bh=sHqT8y+JWpePcMn7FKTJjSmF3qP9aDTX0TsQDS5haeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JkA12oYWKNJgXCInQcu8ItR9i+lLq1Bp1k0rVZskt5KoFIsuSygtaYQuKcPgDn/EtxxHui/i+6AorpWK5ksfyswwzMojDI2nDWTdkDFW8L3RhufFskJ59Baup3Ijl3UszuFpVCYHJh+IqqBQ8XLxisvCP4G8C5OoZV9QGoppPK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=jluxEtLT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1748881192; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AkptTGEgE31egFhb+f/Uj95/Nt6wZrMBp+i7QgXWA8+AZEWtkMJB0W3uElJugAXzHVH6s2cW745b1NXRfwjaLfI52LojjEo2Qip3KFntk/ICfofL0XZsNu/NZ5FIXHdPpELXHle4p1ZHpei0XBh5lpOzF2XSKB4Oy0yWoCa/QI8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1748881192; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=thPWNUjDhq74INOVmaKiFAm4Ay3tl0e1gLSGBjUtuCA=; 
	b=j2lKIaKtyEDUhTafuB1qmTqLvB279lG6bw88aUxQU93DdGeE5T9Bvvcu1J7GBRnbMdDhZYQaub+0Wu0zW0dTQnqczfXW1hBk5/SsM3/kxPPiJ3bfSzvQEbCD+nLXatZgeCOUaFHQd+VPApOmTSMval+IkNH5H/GRddXADfS/wKE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1748881192;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=thPWNUjDhq74INOVmaKiFAm4Ay3tl0e1gLSGBjUtuCA=;
	b=jluxEtLTEOZgDWrHx8tE7+HvcyzXF4jXsWSxPMHRRlZxiu56w9l4tXvhzqxN5jFV
	iZrVh1Xwn0SJe6BwaCDWZUyeUJUC8iIj4Uw308rsu03Le1Q4ZHc0g7j2pd/E9DXMgIT
	E3alHbGpkOUfmVYz8U/+Hvg9rsJ2nEPT4u5O8Gmw=
Received: by mx.zohomail.com with SMTPS id 1748881189490850.5349919679828;
	Mon, 2 Jun 2025 09:19:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 02 Jun 2025 18:19:13 +0200
Subject: [PATCH v2 2/7] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-rk3576-pwm-v2-2-a6434b0ce60c@collabora.com>
References: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
In-Reply-To: <20250602-rk3576-pwm-v2-0-a6434b0ce60c@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 William Breathitt Gray <wbg@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Lee Jones <lee@kernel.org>, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
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

There are two additional clocks, "osc" and "rc". These are available for
every PWM instance, and the PWM hardware can switch between the "pwm",
"osc" and "rc" clock at runtime.

The PWM controller also comes with an interrupt now. This interrupt is
used to signal various conditions.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/pwm/rockchip,rk3576-pwm.yaml          | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 84 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml b/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..48d5055c8b069fff431c62e67bda11f2e086c9a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
@@ -0,0 +1,77 @@
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
+    items:
+      - description: Used to derive the PWM signal.
+      - description: Used as the APB bus clock.
+      - description: Used as an alternative to derive the PWM signal.
+      - description: Used as another alternative to derive the PWM signal.
+
+  clock-names:
+    items:
+      - const: pwm
+      - const: pclk
+      - const: osc
+      - const: rc
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
+            clocks = <&cru CLK_PWM1>, <&cru PCLK_PWM1>, <&cru CLK_OSC_PWM1>,
+                     <&cru CLK_RC_PWM1>;
+            clock-names = "pwm", "pclk", "osc", "rc";
+            interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+            #pwm-cells = <3>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2f13e1602ae68d808b2e8a4711d3c6d40bf5f752..ed5cf56b3ebf9e3153cb9171908a1d36c246197d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21418,6 +21418,13 @@ F:	Documentation/userspace-api/media/v4l/metafmt-rkisp1.rst
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


