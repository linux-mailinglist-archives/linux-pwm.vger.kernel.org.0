Return-Path: <linux-pwm+bounces-8645-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMoRL4tI5mnSuAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8645-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 17:38:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B7742E701
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 17:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05260317F78B
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 14:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3103B530B;
	Mon, 20 Apr 2026 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Ji49vSkd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E663B4EBC;
	Mon, 20 Apr 2026 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692203; cv=pass; b=O1B1VGJklkyQMl8W0GPdy7vcy38+qDMGHKKQe5jSRV9KVY0XPaimifxc1C0xuAavxqOR3eFz0HlVWt5uCZ1fl4q1t66O73Tghk/Rdew3iebethSUnR2FnueTu6rOxmLyCgvd9tLBWWqp1dsBwtBPh0v8cdPp0EinWJn7dy95PQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692203; c=relaxed/simple;
	bh=QcKVmbaRkNCqiR47r/Fq9+7IbyifeWd+ELd7ZUsnp9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFSUuB3061sRdDTfDOHNGc5+dC96+1Q/D4bcTFnM/XXpFgYAJ5OzSaRxAm2slooEAEVrK0xVLYA1rRTYz/lHO2t5L+7NBJYEY0A3ikH1c8yDWg2ipdz73Vu7TwCJL2S3HyBV66360mvt4/rlyij3qxE+74LMLvDNfdFDsviVSR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Ji49vSkd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1776692166; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kbWrdoVJzGhTG6U4AOCvWdKVLMOS8MtH4pD9eCVSkzJDFEpSsD/ZTPZTkJiYR206v7BM3BOc96uR+w14z0rIfyW/fZGo3re6vXgiWl277lBrHGlG+zNsNnd4gWKyFlvXwRw6w2CMte8nZAMqmwHDEn+Zp2zw+QJFHGaMzo5PKyE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776692166; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9x9hZMXBpn0P7sSuaA5owfOkbpFsWAWGV2pJQS60n9Q=; 
	b=Vtoj0hCytPWlUHpOLIw6MRjkxyAb844eoMER6XHwLcvA30on3pE4xPPDn7IMJbyMD4nRBGbdrjl61uKxU4iqNC+JVCDid+s4Pvs9kGaYUqWF63PGYP6BZvYZVDH0ezzfudvUGvtUfkhXu8MdmX2ZOzESpTSy6v7VM4+BotLTBAA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776692166;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=9x9hZMXBpn0P7sSuaA5owfOkbpFsWAWGV2pJQS60n9Q=;
	b=Ji49vSkdVTSHfzJ6C7yxMIMN60E9ymIKS5kbwKbcKfdT+ZKqMF3wX6Ue+pnLRJ7u
	pqKoObUC8gjBh+FXqOgznACl8Td4aSdPDqt9KW9pKyIJUyWohLDn8qOmRGYD/cPcUjH
	RWBpHepzOIOIyB0p19AGwn2aFPz4Xq9mTBMSeGXI=
Received: by mx.zohomail.com with SMTPS id 1776692164179410.7232026286083;
	Mon, 20 Apr 2026 06:36:04 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 20 Apr 2026 15:35:19 +0200
Subject: [PATCH v4 1/5] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-rk3576-pwm-v4-1-421738c7bf28@collabora.com>
References: <20260420-rk3576-pwm-v4-0-421738c7bf28@collabora.com>
In-Reply-To: <20260420-rk3576-pwm-v4-0-421738c7bf28@collabora.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>, 
 Damon Ding <damon.ding@rock-chips.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, 
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8645-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org,microchip.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:dkim,collabora.com:mid,microchip.com:email,makrotopia.org:email,2add0000:email,infradead.org:email,aurel32.net:email,devicetree.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33B7742E701
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index 891fb83ba7a9..86f20cb563c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23172,6 +23172,13 @@ F:	Documentation/userspace-api/media/v4l/metafmt-rkisp1.rst
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
2.53.0


