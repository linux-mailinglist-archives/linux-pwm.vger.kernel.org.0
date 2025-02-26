Return-Path: <linux-pwm+bounces-4999-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246C5A4635F
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 15:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D26F189DDC9
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 14:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC092222BE;
	Wed, 26 Feb 2025 14:45:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07F421D3E2;
	Wed, 26 Feb 2025 14:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581147; cv=none; b=QRBLOifti9BUz26U9ahZ2bFzwpCOqmpooFRTT2vNetWNfcO5dRZeu3clFCJECbe7Sr8OF9tqNpewU+W/Coqaw9DBo5X77TSLKyWaYjz+BI28EfwAFu5deIQTqV2pw7ApZepVMOLdScg5OU7yCl+eYUXYsK9VjPHEbol7WOo7I7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581147; c=relaxed/simple;
	bh=qMdMU4uybebz3RTIig63SmuyCLlIpICkMcg1hb9c0MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2DhSv5xloQMRGVoLRDHyMiP9+dqoOqwvQpA/QijQ5Y366sRmGPgxD49C5ZqVjtgy5AV7CJ+Eks3zbfcml+mIsf3suHchLpnhuQkfj/6y/KWAVD5fbQ+dMLyVpCpsJG+kNEyvSY92CMr/VbHCUaWdUZ7ZXaraqif7vNiO41rNm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Gb6Xki/AQmCN7inGeWtmrQ==
X-CSE-MsgGUID: Q9sjkRLDQkmY0W8tqq5T1g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 26 Feb 2025 23:45:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.96])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8466B4043711;
	Wed, 26 Feb 2025 23:45:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v24 1/4] dt-bindings: pwm: Add RZ/G2L GPT binding
Date: Wed, 26 Feb 2025 14:45:20 +0000
Message-ID: <20250226144531.176819-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226144531.176819-1-biju.das.jz@bp.renesas.com>
References: <20250226144531.176819-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the General PWM Timer (GPT).

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v23->v24:
 * No change.
v22->v23:
 * Updated #pwm-cells value from 2->3 as it is the recommended value for
   new drivers.
 * Retained Rb tag as it is trivial change.
v21->v22:
 * No change.
v20->v21:
 * No change.
v19->v20:
 * No change.
v18->v19:
 * No change.
v17->v18:
 * No change.
v16->v17:
 * No change.
v15->v16:
 * No change.
v14->v15:
 * No change.
v13->v14:
 * No change.
v12->v13:
 * No change.
v11->v12:
 * No change.
v10->v11:
 * No change.
v9->v10:
 * Updated the example gpt4: pwm@10048400-> gpt: pwm@10048000
 * Keep Rb tag from Rob as the above change is trivial one.
v8->v9:
 * Added Rb tag from Rob.
v7->v8:
 * Removed Rb tags from Rob and Geert as it modelled as single GPT
   device handling multiple channels.
 * Updated description
 * Updated interrupts and interrupt-names properties
 * Updated example
v6->v7:
 * No change.
v5->v6:
 * No change.
v4->v5:
 * No change.
v3->v4:
 * No change.
v2->v3:
 * Added Rb tag from Rob.
v1->v2:
 * Added '|' after 'description:' to preserve formatting.
 * Removed description for pwm_cells as it is common property.
 * Changed the reg size in example from 0xa4->0x100
 * Added Rb tag from Geert.
RFC->v1:
 * Added Description
 * Removed comments from reg and clock
---
 .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 378 ++++++++++++++++++
 1 file changed, 378 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
new file mode 100644
index 000000000000..13b807765a30
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
@@ -0,0 +1,378 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/renesas,rzg2l-gpt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L General PWM Timer (GPT)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
+  (GPT32E). It supports the following functions
+  * 32 bits x 8 channels.
+  * Up-counting or down-counting (saw waves) or up/down-counting
+    (triangle waves) for each counter.
+  * Clock sources independently selectable for each channel.
+  * Two I/O pins per channel.
+  * Two output compare/input capture registers per channel.
+  * For the two output compare/input capture registers of each channel,
+    four registers are provided as buffer registers and are capable of
+    operating as comparison registers when buffering is not in use.
+  * In output compare operation, buffer switching can be at crests or
+    troughs, enabling the generation of laterally asymmetric PWM waveforms.
+  * Registers for setting up frame cycles in each channel (with capability
+    for generating interrupts at overflow or underflow)
+  * Generation of dead times in PWM operation.
+  * Synchronous starting, stopping and clearing counters for arbitrary
+    channels.
+  * Starting, stopping, clearing and up/down counters in response to input
+    level comparison.
+  * Starting, clearing, stopping and up/down counters in response to a
+    maximum of four external triggers.
+  * Output pin disable function by dead time error and detected
+    short-circuits between output pins.
+  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
+  * Enables the noise filter for input capture and external trigger
+    operation.
+
+  The below pwm channels are supported.
+    pwm0  - GPT32E0.GTIOC0A channel
+    pwm1  - GPT32E0.GTIOC0B channel
+    pwm2  - GPT32E1.GTIOC1A channel
+    pwm3  - GPT32E1.GTIOC1B channel
+    pwm4  - GPT32E2.GTIOC2A channel
+    pwm5  - GPT32E2.GTIOC2B channel
+    pwm6  - GPT32E3.GTIOC3A channel
+    pwm7  - GPT32E3.GTIOC3B channel
+    pwm8  - GPT32E4.GTIOC4A channel
+    pwm9  - GPT32E4.GTIOC4B channel
+    pwm10 - GPT32E5.GTIOC5A channel
+    pwm11 - GPT32E5.GTIOC5B channel
+    pwm12 - GPT32E6.GTIOC6A channel
+    pwm13 - GPT32E6.GTIOC6B channel
+    pwm14 - GPT32E7.GTIOC7A channel
+    pwm15 - GPT32E7.GTIOC7B channel
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-gpt  # RZ/G2{L,LC}
+          - renesas,r9a07g054-gpt  # RZ/V2L
+      - const: renesas,rzg2l-gpt
+
+  reg:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 3
+
+  interrupts:
+    items:
+      - description: GPT32E0.GTCCRA input capture/compare match
+      - description: GPT32E0.GTCCRB input capture/compare
+      - description: GPT32E0.GTCCRC compare match
+      - description: GPT32E0.GTCCRD compare match
+      - description: GPT32E0.GTCCRE compare match
+      - description: GPT32E0.GTCCRF compare match
+      - description: GPT32E0.GTADTRA compare match
+      - description: GPT32E0.GTADTRB compare match
+      - description: GPT32E0.GTCNT overflow/GTPR compare match
+      - description: GPT32E0.GTCNT underflow
+      - description: GPT32E1.GTCCRA input capture/compare match
+      - description: GPT32E1.GTCCRB input capture/compare
+      - description: GPT32E1.GTCCRC compare match
+      - description: GPT32E1.GTCCRD compare match
+      - description: GPT32E1.GTCCRE compare match
+      - description: GPT32E1.GTCCRF compare match
+      - description: GPT32E1.GTADTRA compare match
+      - description: GPT32E1.GTADTRB compare match
+      - description: GPT32E1.GTCNT overflow/GTPR compare match
+      - description: GPT32E1.GTCNT underflow
+      - description: GPT32E2.GTCCRA input capture/compare match
+      - description: GPT32E2.GTCCRB input capture/compare
+      - description: GPT32E2.GTCCRC compare match
+      - description: GPT32E2.GTCCRD compare match
+      - description: GPT32E2.GTCCRE compare match
+      - description: GPT32E2.GTCCRF compare match
+      - description: GPT32E2.GTADTRA compare match
+      - description: GPT32E2.GTADTRB compare match
+      - description: GPT32E2.GTCNT overflow/GTPR compare match
+      - description: GPT32E2.GTCNT underflow
+      - description: GPT32E3.GTCCRA input capture/compare match
+      - description: GPT32E3.GTCCRB input capture/compare
+      - description: GPT32E3.GTCCRC compare match
+      - description: GPT32E3.GTCCRD compare match
+      - description: GPT32E3.GTCCRE compare match
+      - description: GPT32E3.GTCCRF compare match
+      - description: GPT32E3.GTADTRA compare match
+      - description: GPT32E3.GTADTRB compare match
+      - description: GPT32E3.GTCNT overflow/GTPR compare match
+      - description: GPT32E3.GTCNT underflow
+      - description: GPT32E4.GTCCRA input capture/compare match
+      - description: GPT32E4.GTCCRB input capture/compare
+      - description: GPT32E4.GTCCRC compare match
+      - description: GPT32E4.GTCCRD compare match
+      - description: GPT32E4.GTCCRE compare match
+      - description: GPT32E4.GTCCRF compare match
+      - description: GPT32E4.GTADTRA compare match
+      - description: GPT32E4.GTADTRB compare match
+      - description: GPT32E4.GTCNT overflow/GTPR compare match
+      - description: GPT32E4.GTCNT underflow
+      - description: GPT32E5.GTCCRA input capture/compare match
+      - description: GPT32E5.GTCCRB input capture/compare
+      - description: GPT32E5.GTCCRC compare match
+      - description: GPT32E5.GTCCRD compare match
+      - description: GPT32E5.GTCCRE compare match
+      - description: GPT32E5.GTCCRF compare match
+      - description: GPT32E5.GTADTRA compare match
+      - description: GPT32E5.GTADTRB compare match
+      - description: GPT32E5.GTCNT overflow/GTPR compare match
+      - description: GPT32E5.GTCNT underflow
+      - description: GPT32E6.GTCCRA input capture/compare match
+      - description: GPT32E6.GTCCRB input capture/compare
+      - description: GPT32E6.GTCCRC compare match
+      - description: GPT32E6.GTCCRD compare match
+      - description: GPT32E6.GTCCRE compare match
+      - description: GPT32E6.GTCCRF compare match
+      - description: GPT32E6.GTADTRA compare match
+      - description: GPT32E6.GTADTRB compare match
+      - description: GPT32E6.GTCNT overflow/GTPR compare match
+      - description: GPT32E6.GTCNT underflow
+      - description: GPT32E7.GTCCRA input capture/compare match
+      - description: GPT32E7.GTCCRB input capture/compare
+      - description: GPT32E7.GTCCRC compare match
+      - description: GPT32E7.GTCCRD compare match
+      - description: GPT32E7.GTCCRE compare match
+      - description: GPT32E7.GTCCRF compare match
+      - description: GPT32E7.GTADTRA compare match
+      - description: GPT32E7.GTADTRB compare match
+      - description: GPT32E7.GTCNT overflow/GTPR compare match
+      - description: GPT32E7.GTCNT underflow
+
+  interrupt-names:
+    items:
+      - const: ccmpa0
+      - const: ccmpb0
+      - const: cmpc0
+      - const: cmpd0
+      - const: cmpe0
+      - const: cmpf0
+      - const: adtrga0
+      - const: adtrgb0
+      - const: ovf0
+      - const: unf0
+      - const: ccmpa1
+      - const: ccmpb1
+      - const: cmpc1
+      - const: cmpd1
+      - const: cmpe1
+      - const: cmpf1
+      - const: adtrga1
+      - const: adtrgb1
+      - const: ovf1
+      - const: unf1
+      - const: ccmpa2
+      - const: ccmpb2
+      - const: cmpc2
+      - const: cmpd2
+      - const: cmpe2
+      - const: cmpf2
+      - const: adtrga2
+      - const: adtrgb2
+      - const: ovf2
+      - const: unf2
+      - const: ccmpa3
+      - const: ccmpb3
+      - const: cmpc3
+      - const: cmpd3
+      - const: cmpe3
+      - const: cmpf3
+      - const: adtrga3
+      - const: adtrgb3
+      - const: ovf3
+      - const: unf3
+      - const: ccmpa4
+      - const: ccmpb4
+      - const: cmpc4
+      - const: cmpd4
+      - const: cmpe4
+      - const: cmpf4
+      - const: adtrga4
+      - const: adtrgb4
+      - const: ovf4
+      - const: unf4
+      - const: ccmpa5
+      - const: ccmpb5
+      - const: cmpc5
+      - const: cmpd5
+      - const: cmpe5
+      - const: cmpf5
+      - const: adtrga5
+      - const: adtrgb5
+      - const: ovf5
+      - const: unf5
+      - const: ccmpa6
+      - const: ccmpb6
+      - const: cmpc6
+      - const: cmpd6
+      - const: cmpe6
+      - const: cmpf6
+      - const: adtrga6
+      - const: adtrgb6
+      - const: ovf6
+      - const: unf6
+      - const: ccmpa7
+      - const: ccmpb7
+      - const: cmpc7
+      - const: cmpd7
+      - const: cmpe7
+      - const: cmpf7
+      - const: adtrga7
+      - const: adtrgb7
+      - const: ovf7
+      - const: unf7
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - power-domains
+  - resets
+
+allOf:
+  - $ref: pwm.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpt: pwm@10048000 {
+        compatible = "renesas,r9a07g044-gpt", "renesas,rzg2l-gpt";
+        reg = <0x10048000 0x800>;
+        interrupts = <GIC_SPI 218 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 219 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 220 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 221 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 222 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 223 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 224 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 225 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 226 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 227 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 231 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 232 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 233 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 234 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 235 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 236 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 237 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 238 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 239 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 240 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 244 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 245 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 246 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 247 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 248 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 249 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 250 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 251 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 252 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 253 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 257 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 258 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 259 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 260 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 261 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 263 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 266 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 272 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 273 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 274 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 275 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 276 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 278 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 279 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 283 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 284 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 285 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 286 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 287 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 288 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 289 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 290 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 291 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 292 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 296 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 297 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 298 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 299 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 301 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 302 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 303 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 304 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 305 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 309 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 310 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 311 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 312 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 313 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 314 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 315 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 316 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 317 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "ccmpa0", "ccmpb0", "cmpc0", "cmpd0",
+                          "cmpe0", "cmpf0", "adtrga0", "adtrgb0",
+                          "ovf0", "unf0",
+                          "ccmpa1", "ccmpb1", "cmpc1", "cmpd1",
+                          "cmpe1", "cmpf1", "adtrga1", "adtrgb1",
+                          "ovf1", "unf1",
+                          "ccmpa2", "ccmpb2", "cmpc2", "cmpd2",
+                          "cmpe2", "cmpf2", "adtrga2", "adtrgb2",
+                          "ovf2", "unf2",
+                          "ccmpa3", "ccmpb3", "cmpc3", "cmpd3",
+                          "cmpe3", "cmpf3", "adtrga3", "adtrgb3",
+                          "ovf3", "unf3",
+                          "ccmpa4", "ccmpb4", "cmpc4", "cmpd4",
+                          "cmpe4", "cmpf4", "adtrga4", "adtrgb4",
+                          "ovf4", "unf4",
+                          "ccmpa5", "ccmpb5", "cmpc5", "cmpd5",
+                          "cmpe5", "cmpf5", "adtrga5", "adtrgb5",
+                          "ovf5", "unf5",
+                          "ccmpa6", "ccmpb6", "cmpc6", "cmpd6",
+                          "cmpe6", "cmpf6", "adtrga6", "adtrgb6",
+                          "ovf6", "unf6",
+                          "ccmpa7", "ccmpb7", "cmpc7", "cmpd7",
+                          "cmpe7", "cmpf7", "adtrga7", "adtrgb7",
+                          "ovf7", "unf7";
+        clocks = <&cpg CPG_MOD R9A07G044_GPT_PCLK>;
+        power-domains = <&cpg>;
+        resets = <&cpg R9A07G044_GPT_RST_C>;
+        #pwm-cells = <3>;
+    };
-- 
2.43.0


