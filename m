Return-Path: <linux-pwm+bounces-1844-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B67B894D0C
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 09:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6141F227AE
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E2D3D3A5;
	Tue,  2 Apr 2024 07:59:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8213D0BE;
	Tue,  2 Apr 2024 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044740; cv=none; b=VU3F26/9xJLjZeJqyA5A64OFfb4zyVNqb3vcuknYnKgXvoHuXncIrORxgvkQizy9r7yzi1CCxP8/r0mziOlY6quRVctI2YEjmB5yD/SqkEHuy9cX8jG06ChqaDdnzYBTZB6witnqLjKh0uonPLZhUxffQ5snYZdewnA5NAbr/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044740; c=relaxed/simple;
	bh=9x5of8tfO4aBfMHpTgpnC4Ok9cNXq3xTyzqKGATe+z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGxrNHVPf6yFrBvop0TszBQ7qtbk98CF72aPbdLi7VLpXNm8lecLyytNS7Asm5A4wswHlI82agmmecPXVVgFKsm+EdXsdcONMFrhojUVG7FxA5WElJ0DHH3f1YMQZVV4OuCaJKWr7HwWlEMPW/BfQ8fqM4idSSN3eQK6s2cI4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8BxC+m_ugtmXD8iAA--.58963S3;
	Tue, 02 Apr 2024 15:58:55 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxSRK7ugtmzqNxAA--.12573S3;
	Tue, 02 Apr 2024 15:58:53 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v1 1/5] dt-bindings: pwm: Add Loongson PWM controller
Date: Tue,  2 Apr 2024 15:58:38 +0800
Message-ID: <edad2bb5b0045c633734c1499fb163c3c6776121.1711953223.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711953223.git.zhoubinbin@loongson.cn>
References: <cover.1711953223.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxSRK7ugtmzqNxAA--.12573S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZw4kZr47Ar15Cw1rAF4xuFX_yoW5Gw1fpF
	nxCasrKr10qF17uws5WFy8Cr1fZ3s5CFnFkF4ay3WDKF98G3WYqw1akF1DZw43Cr1UXFWU
	ZFZ3ur4jka48CrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

Add Loongson PWM controller binding with DT schema format using
json-schema.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../devicetree/bindings/pwm/pwm-loongson.yaml | 64 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-loongson.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-loongson.yaml b/Documentation/devicetree/bindings/pwm/pwm-loongson.yaml
new file mode 100644
index 000000000000..d25904468353
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-loongson.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-loongson.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Loongson PWM Controller
+
+maintainers:
+  - Binbin Zhou <zhoubinbin@loongson.cn>
+
+description:
+  It is the generic PWM framework driver for Loongson family.
+  Each PWM has one pulse width output signal and one pulse input
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
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - '#pwm-cells'
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
index 96496dbcae6d..9c4f3186e7f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12753,6 +12753,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
 F:	drivers/i2c/busses/i2c-ls2x.c
 
+LOONGSON PWM DRIVER
+M:	Binbin Zhou <zhoubinbin@loongson.cn>
+L:	linux-pwm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pwm/pwm-loongson.yaml
+
 LOONGSON-2 SOC SERIES CLOCK DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-clk@vger.kernel.org
-- 
2.43.0


