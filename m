Return-Path: <linux-pwm+bounces-7778-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC76CAD901
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 16:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAA3C302C4E6
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A62D7DFF;
	Mon,  8 Dec 2025 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWVHLfHX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2833B2D3A70
	for <linux-pwm@vger.kernel.org>; Mon,  8 Dec 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765207302; cv=none; b=aaMgU8C5+coIYXlQD45o6GMZ5BApgc3h3Phm3GfHbeQOyENDLc/yqYvHVBkMKJXAV9m+kvSEOUvHhkCmyVlEuIQ66QjcMGkrRyyyIPzqGxPtft/lgisKOQDiSyCaWTZul+tgJ24xU311hW+CUWe9mAIQeHcxPtj+dlSiFg2X2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765207302; c=relaxed/simple;
	bh=mq+s44ijAclqnuV+cmi1xA85/WeUM8NVW4c1VrVMF+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRkbqKf0CtPnzSOEs96pWo8KaiTpkduAG8LWZhOkzSIj7GeNvS+Yx5TImCnvqoSpH/74qAS+IWLzhIjMvRUiydQeN+EjK7D3kEUmgVbcumeJ2J8G3TBsQveX1+vHlEQJNEdi/OBAKh608IUSMZx9yEHU5U+yaQWrRC3TwJ8/WFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWVHLfHX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so6471299a12.2
        for <linux-pwm@vger.kernel.org>; Mon, 08 Dec 2025 07:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765207297; x=1765812097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yus3yZX5nvgWHXiBbDABLJvxtFbnQWmiIgDx2Gk7iQ=;
        b=AWVHLfHXQG380SnY5y6uYnh6B03NokSpJ5tNIFuNMD2neaQlHAxTYrSEw4CO81lyfY
         l8J9N6mhlJ6winklQiTsi5m/Capps9GM9rK/uSM6TdUrU41f07ZeiGHFzvFYrs6Zhqfq
         LUKl1sBGSLmAGAAikY1eADt5qnT/5AddUzwb1RKM1R8Al/Knb3svBrd47D4ORqOto9Ki
         P8jN3dmhIM6j/hrTxqkFQw3T8ih339726DjlmCYQnDXClrGPQPG88aPRySgxPV4ArPxM
         dIHRjR5TzQXzcL1LJekye01mwrjTguYKyv6EwHa6zUE66XVthzpf8vuWgnaHm+EOcG7H
         kANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765207297; x=1765812097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9yus3yZX5nvgWHXiBbDABLJvxtFbnQWmiIgDx2Gk7iQ=;
        b=v2pxeT6fefoAVYQO/zxeBJ1dvh+uViEBvZntPM5C2h4FU/D1VncFlJzoFTnZZVzkUQ
         JXzpLS22JIyOcpQvt89/9stN+gI8EqssjXRTQoHsD1my22O6hLOIr/TyQPljCYbWLHJf
         WprQjGeipeOwMDklNYX3R//3zbdmLFDWBVkZMnZ8DZghKfSfKDNxr1CQGhq67G9o63wC
         cbYfohHZ4xyRssu+BK+zcgG156OabLheH29zL27sW1E5/tRjW7IB0eEmIy8ME4E5/AS7
         NfES+gl0qk33ws5najrnpuUpkm7vCtA7E2xQF3Usv5Yqk3YeZMEo+ruPVkV4V7j6bPVP
         L+hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyu6Gj5AU4uPlSD57gSARF96lDW6gpL0ULq29bMxjSHGgqixm4CP3zEcwNnb30cpQAPV1VfZGLOHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFNZ4fmoYpLXpea8ETzzQ93kW4FW1Z5UtDkQgiaYuZUV4BDGF
	JESbiHhBdpcl4xwdh10KQgy05WA3IaNEcGP06SWENiqJmVPaPbthnc3w
X-Gm-Gg: ASbGnctx/+gTooaLZG7jQOUgUpbKf/VCWOvBDK06pSdjOkgq8KxsYn665H1Jl9sdUNp
	W0E8SBePcc9FjFXDCkcS5jwaY8Luaau4U7IbDX/vsbDFlpIb3+lXkCNkxYsF2rtAeD7JgLlD0H+
	KRDUSZwe9WFf7WxT/sDAc9jC257TllxVk3jyWaDgVF5tmtnQAV3jtC7MPumnMmY5kee35xfSLYk
	ijXUqsKkdadtOATw9kvPTqTipvxuhXMeP5YxxnpS/Rk5rFiZay+4V8sARazj8USrMrpZdKgoxOW
	X15oRIw5Es8b1/3Y/c6v19bBE5TVu7lFFxOJugRkALzU+cup2faObxH180EO7YLtAfAxlWgNcb2
	sZhyLVLnwp0LcYz3xAW+eGz1CGJzlkaTSvpGeR9lHJq50HEqyJTYkatQYDlf01+xfHiRae8guy2
	YldI3dmc7Atb3fVeo7fhSOjkuS7l1cOiXyuDV55W6nTvBtkYDxLj0exnfPfCkKx0aSfxVT4q7Uu
	UaDE0S4s3/5wrZ9
X-Google-Smtp-Source: AGHT+IE580n6GG3J6x73ZX/F/KYiF6Gq/B7h1HeINKFAocn1SdUDBOHl9UBDM0Tn7BuPHnSvGR70jQ==
X-Received: by 2002:a05:6402:2696:b0:640:c9ff:c06a with SMTP id 4fb4d7f45d1cf-6491a0e7174mr7527394a12.15.1765207297024;
        Mon, 08 Dec 2025 07:21:37 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b412deddsm11547484a12.31.2025.12.08.07.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:21:36 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 1/9] dt-bindings: pwm: Document RZ/G3E GPT support
Date: Mon,  8 Dec 2025 15:21:18 +0000
Message-ID: <20251208152133.269316-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
References: <20251208152133.269316-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Document support for the GPT found on the Renesas RZ/G3E (R9A09G047)
SoC.

The GPT is a 32-bit timer with 16 hardware channels (GPT0: 8 channel
and GPT1: 8channels). The hardware supports simultaneous control of
all channels. PWM waveforms can be generated by controlling the
up-counter, downcounter, or up- and down-counter.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No change.
v2->v3:
 * Added Rb tag from Rob.
v1->v2:
 * Created separate document for RZ/G3E GPT.
 * Updated commit header and description.
---
 .../bindings/pwm/renesas,rzg3e-gpt.yaml       | 323 ++++++++++++++++++
 1 file changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml

diff --git a/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml b/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
new file mode 100644
index 000000000000..cb4ffab5f47f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,rzg3e-gpt.yaml
@@ -0,0 +1,323 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/renesas,rzg3e-gpt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3E General PWM Timer (GPT)
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+
+description: |
+  RZ/G3E General PWM Timer (GPT) composed of 16 channels with 32-bit
+  timer. It supports the following functions
+  * 32 bits x 16 channels.
+  * Up-counting or down-counting (saw waves) or up/down-counting
+    (triangle waves) for each counter.
+  * Clock sources independently selectable for each channel.
+  * Four I/O pins per channel.
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
+  * Count start, count stop, count clear, up-count, down-count, or input
+    capture operation in response to a maximum of 8 ELC events.
+  * Count start, count stop, count clear, up-count, down-count, or input
+    capture operation in response to the status of two input pins.
+  * Starting, clearing, stopping and up/down counters in response to a
+    maximum of four external triggers.
+  * Output pin disable function by detected short-circuits between output
+    pins.
+  * A/D converter start triggers can be generated.
+  * Compare match A to F event and overflow/underflow event can be output
+    to the ELC.
+  * Enables the noise filter for input capture.
+  * Logical operation between the channel output.
+
+properties:
+  compatible:
+    items:
+      - const: renesas,r9a09g047-gpt  # RZ/G3E
+
+  reg:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 3
+
+  interrupts:
+    items:
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.0
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.0
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.0
+      - description: A and B both high interrupt for channel GPT{0,1}.0
+      - description: A and B both low interrupt for channel GPT{0,1}.0
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.1
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.1
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.1
+      - description: A and B both high interrupt for channel GPT{0,1}.1
+      - description: A and B both low interrupt for channel GPT{0,1}.1
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.2
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.2
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.2
+      - description: A and B both high interrupt for channel GPT{0,1}.2
+      - description: A and B both low interrupt for channel GPT{0,1}.2
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.3
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.3
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.3
+      - description: A and B both high interrupt for channel GPT{0,1}.3
+      - description: A and B both low interrupt for channel GPT{0,1}.3
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.4
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.4
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.4
+      - description: A and B both high interrupt for channel GPT{0,1}.4
+      - description: A and B both low interrupt for channel GPT{0,1}.4
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.5
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.5
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.5
+      - description: A and B both high interrupt for channel GPT{0,1}.5
+      - description: A and B both low interrupt for channel GPT{0,1}.5
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.6
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.6
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.6
+      - description: A and B both high interrupt for channel GPT{0,1}.6
+      - description: A and B both low interrupt for channel GPT{0,1}.6
+      - description: Input capture/compare match of the GTCCRA for channel GPT{0,1}.7
+      - description: Input capture/compare match of the GTCCRB for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRC for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRD for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRE for channel GPT{0,1}.7
+      - description: Compare match with the GTCCRF for channel GPT{0,1}.7
+      - description: A and B both high interrupt for channel GPT{0,1}.7
+      - description: A and B both low interrupt for channel GPT{0,1}.7
+
+  interrupt-names:
+    items:
+      - const: gtcia0
+      - const: gtcib0
+      - const: gtcic0
+      - const: gtcid0
+      - const: gtcie0
+      - const: gtcif0
+      - const: gtcih0
+      - const: gtcil0
+      - const: gtcia1
+      - const: gtcib1
+      - const: gtcic1
+      - const: gtcid1
+      - const: gtcie1
+      - const: gtcif1
+      - const: gtcih1
+      - const: gtcil1
+      - const: gtcia2
+      - const: gtcib2
+      - const: gtcic2
+      - const: gtcid2
+      - const: gtcie2
+      - const: gtcif2
+      - const: gtcih2
+      - const: gtcil2
+      - const: gtcia3
+      - const: gtcib3
+      - const: gtcic3
+      - const: gtcid3
+      - const: gtcie3
+      - const: gtcif3
+      - const: gtcih3
+      - const: gtcil3
+      - const: gtcia4
+      - const: gtcib4
+      - const: gtcic4
+      - const: gtcid4
+      - const: gtcie4
+      - const: gtcif4
+      - const: gtcih4
+      - const: gtcil4
+      - const: gtcia5
+      - const: gtcib5
+      - const: gtcic5
+      - const: gtcid5
+      - const: gtcie5
+      - const: gtcif5
+      - const: gtcih5
+      - const: gtcil5
+      - const: gtcia6
+      - const: gtcib6
+      - const: gtcic6
+      - const: gtcid6
+      - const: gtcie6
+      - const: gtcif6
+      - const: gtcih6
+      - const: gtcil6
+      - const: gtcia7
+      - const: gtcib7
+      - const: gtcic7
+      - const: gtcid7
+      - const: gtcie7
+      - const: gtcif7
+      - const: gtcih7
+      - const: gtcil7
+
+  clocks:
+    items:
+      - description: Core clock (PCLKD)
+      - description: Bus clock (PCLKA)
+
+  clock-names:
+    items:
+      - const: core
+      - const: bus
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Reset for bus clock (PCLKA/PCLKD)
+      - description: Reset for core clock (PCLKD)
+
+  reset-names:
+    items:
+      - const: rst_p
+      - const: rst_s
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: pwm.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g047-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pwm@13010000 {
+        compatible = "renesas,r9a09g047-gpt";
+        reg = <0x13010000 0x10000>;
+        interrupts = <GIC_SPI 538 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 546 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 562 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 570 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 586 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 594 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 539 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 547 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 555 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 563 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 571 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 579 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 587 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 595 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 540 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 548 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 556 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 564 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 572 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 580 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 588 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 596 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 541 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 549 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 557 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 565 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 573 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 581 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 589 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 597 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 542 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 550 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 558 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 566 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 574 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 582 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 590 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 598 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 543 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 551 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 559 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 567 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 575 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 583 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 591 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 599 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 544 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 552 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 560 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 568 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 584 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 592 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 600 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 545 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 553 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 561 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 569 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 577 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 585 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 593 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 601 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "gtcia0", "gtcib0", "gtcic0", "gtcid0",
+                          "gtcie0", "gtcif0", "gtcih0", "gtcil0",
+                          "gtcia1", "gtcib1", "gtcic1", "gtcid1",
+                          "gtcie1", "gtcif1", "gtcih1", "gtcil1",
+                          "gtcia2", "gtcib2", "gtcic2", "gtcid2",
+                          "gtcie2", "gtcif2", "gtcih2", "gtcil2",
+                          "gtcia3", "gtcib3", "gtcic3", "gtcid3",
+                          "gtcie3", "gtcif3", "gtcih3", "gtcil3",
+                          "gtcia4", "gtcib4", "gtcic4", "gtcid4",
+                          "gtcie4", "gtcif4", "gtcih4", "gtcil4",
+                          "gtcia5", "gtcib5", "gtcic5", "gtcid5",
+                          "gtcie5", "gtcif5", "gtcih5", "gtcil5",
+                          "gtcia6", "gtcib6", "gtcic6", "gtcid6",
+                          "gtcie6", "gtcif6", "gtcih6", "gtcil6",
+                          "gtcia7", "gtcib7", "gtcic7", "gtcid7",
+                          "gtcie7", "gtcif7", "gtcih7", "gtcil7";
+        clocks = <&cpg CPG_MOD 0x31>, <&cpg CPG_MOD 0x31>;
+        clock-names = "core", "bus";
+        power-domains = <&cpg>;
+        resets = <&cpg 0x59>, <&cpg 0x5a>;
+        reset-names = "rst_p", "rst_s";
+        #pwm-cells = <3>;
+    };
-- 
2.43.0


