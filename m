Return-Path: <linux-pwm+bounces-4933-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEAAA37E79
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 10:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4063A9250
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Feb 2025 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECFB215779;
	Mon, 17 Feb 2025 09:30:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3F2153D8;
	Mon, 17 Feb 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784650; cv=none; b=W+fgzeqXj/N9HleT3eES4GSkobGbbJ2THbW+SH5Z+etAZcCthNdcTG/Kt+11ZXo9GI23hUHSTIS2Dkpwtwy7ldDJsKZVSBmrR4Hj6Z/VFRHCNgE4IbeL8TUsJF52ezujGx458/avTNyNksIy72P7wfL9gGHAXFT7zwB/Cs6oIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784650; c=relaxed/simple;
	bh=aD3vY1slnPKPfhpqd2dAsUosRPb/99diiY0WwJCvQBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf4zI4H9JHb9TU7Z3ckCy39byLd12kCWKhCqdJAVgznuRzrLNv/efqg+D4RsQxB1peYbH0TQHLIG+tHYq7/VoIPCXdk+R/vcRpMZqBkEcckIJaXQygeVgWXsnwzJA3noZ39gJC15LlLSwJrREiKSC5+5D+Z+OcHlJY8uJNUlxqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.156])
	by gateway (Coremail) with SMTP id _____8CxLGu_AbNn_pZ4AA--.11606S3;
	Mon, 17 Feb 2025 17:30:39 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.156])
	by front1 (Coremail) with SMTP id qMiowMBxLse7AbNnvO4XAA--.26537S3;
	Mon, 17 Feb 2025 17:30:38 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Juxin Gao <gaojuxin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 1/2] dt-bindings: pwm: Add Loongson PWM controller
Date: Mon, 17 Feb 2025 17:30:24 +0800
Message-ID: <d6be5236ab4ff5b5fde78004c38d8bced42f2ba2.1739784071.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1739784071.git.zhoubinbin@loongson.cn>
References: <cover.1739784071.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxLse7AbNnvO4XAA--.26537S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxArW8Aw1fAw4fWr1kWryDArc_yoW5ArWfpF
	sxC3s2kr10qF17u398Wa48Cr1fZ3s5A3W7KFW7Aw1DKF9xJ3WYqw13KF15Z3y3ur1UXFWU
	ZF9akr4UKa4UCrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jzc_-UUUUU=

Add Loongson PWM controller binding with DT schema format using
json-schema.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
---
 .../bindings/pwm/loongson,ls7a-pwm.yaml       | 66 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml b/Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
new file mode 100644
index 000000000000..46814773e0cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/loongson,ls7a-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson PWM Controller
+
+maintainers:
+  - Binbin Zhou <zhoubinbin@loongson.cn>
+
+description:
+  The Loongson PWM has one pulse width output signal and one pulse input
+  signal to be measured.
+  It can be found on Loongson-2K series cpus and Loongson LS7A bridge chips.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: loongson,ls7a-pwm
+      - items:
+          - enum:
+              - loongson,ls2k0500-pwm
+              - loongson,ls2k1000-pwm
+              - loongson,ls2k2000-pwm
+          - const: loongson,ls7a-pwm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#pwm-cells':
+    description:
+      The first cell must have a value of 0, which specifies the PWM output signal;
+      The second cell is the period in nanoseconds;
+      The third cell flag supported by this binding is PWM_POLARITY_INVERTED.
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/loongson,ls2k-clk.h>
+    pwm@1fe22000 {
+        compatible = "loongson,ls2k1000-pwm", "loongson,ls7a-pwm";
+        reg = <0x1fe22000 0x10>;
+        interrupt-parent = <&liointc0>;
+        interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk LOONGSON2_APB_CLK>;
+        #pwm-cells = <3>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 896a307fa065..9fcde52aec4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13616,6 +13616,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
 F:	drivers/i2c/busses/i2c-ls2x.c
 
+LOONGSON PWM DRIVER
+M:	Binbin Zhou <zhoubinbin@loongson.cn>
+L:	linux-pwm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
+
 LOONGSON-2 SOC SERIES CLOCK DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
-- 
2.47.1


