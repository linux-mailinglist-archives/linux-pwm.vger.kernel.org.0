Return-Path: <linux-pwm+bounces-7496-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00505C0F931
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 18:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A9A64EE2F1
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Oct 2025 17:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402F3161B8;
	Mon, 27 Oct 2025 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="j6itSMIs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88F2314D1F;
	Mon, 27 Oct 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585269; cv=pass; b=P5B+eCuQQ/N/2q8gbNAaKEfoOaz6ToGTDNzggATi0o2T3D2QCwwz0xRCxaYJi7RdM+zMw9SBZEPeQq7/+kAZBf6midfFVPXsyFM8XbloVvdbWs0lNM8MWODn5NRP4qQ1ehPohz1LD94fGJnG7TmD6v9fVvdbvpoo4mv7FliWz/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585269; c=relaxed/simple;
	bh=A/4Yz4hhujrm8CR0ftfBmFXk6/qM4KRv16czO0V08GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4TlesNASOi5FGMAjzQryqbo3LOduc+nw/xTRT3VcycMDEQbfss+TOkTkagbBq7KIchgoNyLFFU5DqDn0ckgdd4Ha5RS7LBChK/VH0ilEburNRQnuYGsbXCe8xvU0JkE07s8zI4rZO+ZX/p89IpYwFsjUqGuM/K4wpsPTrkvhU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=j6itSMIs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761585245; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CPtXThCicam2Ac3DHsVuX+IK7fWAdHUfnD7cxH79w26WEUn9RSzkUdCDonUQuhQ9o0wMH2qTcHQ4+49YlC7is0E8lPZZVvrcQsKgfS81wsOlHx92U3GIHLPSoudoEe6goXw6Xpc53toaVrW9GcIfF+NK5H3IncGzUUVo8R3CMKQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761585245; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WxeBMINNWAM7WRg6131Emc+P7krNwdR5I4H1Br/gtac=; 
	b=dqgL2ftJLhq/pkLze3FfCbjbG69nJpRLzkP0b2fVE/F5wnk5v5dDJuB23O2nFx7ciBGEQVcPXQYfmxaF2BaFWHdrcJyBcpL1Cx88IwYfNbfEhBbOndRld0irbHsoQKwCBO1VxgZfyPZLspqqCmiAv8K1o2UT8olT5Mg6sT4mt88=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761585245;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=WxeBMINNWAM7WRg6131Emc+P7krNwdR5I4H1Br/gtac=;
	b=j6itSMIs4tSHT4qOrbkx1ThSOa5n7nWxEkBxy7kwoEs6tpKzcMo25S2sxXIjjx3f
	sGboq6AcyuB8q/2gcWVo/54ckBrfkRf3+/536m43oRr6lhbkBtZE6F3S0BxcF6N2pHV
	C2nurr6275WF3QbQ8j+8A0xcl0T0MOpo3AzTxmOE=
Received: by mx.zohomail.com with SMTPS id 1761585243033285.30838624105627;
	Mon, 27 Oct 2025 10:14:03 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 27 Oct 2025 18:11:56 +0100
Subject: [PATCH v3 1/5] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-rk3576-pwm-v3-1-654a5cb1e3f8@collabora.com>
References: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
In-Reply-To: <20251027-rk3576-pwm-v3-0-654a5cb1e3f8@collabora.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>
Cc: kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3

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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 .../bindings/pwm/rockchip,rk3576-pwm.yaml          | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 84 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml b/Documentation/devicetree/bindings/pwm/rockchip,rk3576-pwm.yaml
new file mode 100644
index 000000000000..48d5055c8b06
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
index 252b06d4240c..baecabab35a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22366,6 +22366,13 @@ F:	Documentation/userspace-api/media/v4l/metafmt-rkisp1.rst
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
2.51.1


