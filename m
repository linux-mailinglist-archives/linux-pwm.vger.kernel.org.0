Return-Path: <linux-pwm+bounces-7757-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D648ECA6CDE
	for <lists+linux-pwm@lfdr.de>; Fri, 05 Dec 2025 10:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4FB03039C7F
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Dec 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39683164C1;
	Fri,  5 Dec 2025 09:05:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.205.26])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838B2302CC3;
	Fri,  5 Dec 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.205.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925509; cv=none; b=XEpp7sTAfw8Eu+n8KeSXRUW16nn+mJc0Q3tBI8HxFOFcwe8+Nbtx/gk3mCvmfvS18i+WSYRxiHGKxHgmBzcgo70ECJTt4LY1ej5LJbHfh1WiqlAYnrAAq1H+HOdT4Dzi618w4RXdM9ZNcX+8LKuUZhtCv/8ShCApPegD6FnSs74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925509; c=relaxed/simple;
	bh=aYA1fVu5HnF8pTxQfWHxypGKDFNWYQtNrYuYZ0a5kwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IH8QrpEyq/XLuV54jVRGBJAwuOOQrv7YhGWw2DGyWOU5B0/aOuNZL8BqKOXsFnTuraK9DU6MUvRQ1k51a+V1NcHSpu8tXy3td69PHTCaOnc15mdktLU9x9doyEP6QqrzJ7L0LfKGHdcYGyCDHmcziId0PihHrVh1XU0RS2yrEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.229.205.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005152DT.eswin.cn (unknown [10.12.96.41])
	by app1 (Coremail) with SMTP id TAJkCgCXkWk0oDJpctmBAA--.42178S2;
	Fri, 05 Dec 2025 17:04:53 +0800 (CST)
From: dongxuyang@eswincomputing.com
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	xuxiang@eswincomputing.com,
	wangguosheng@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Xuyang Dong <dongxuyang@eswincomputing.com>
Subject: [PATCH 1/2] dt-bindings: pwm: eswin: Add EIC7700 pwm controller
Date: Fri,  5 Dec 2025 17:04:50 +0800
Message-Id: <20251205090450.1446-1-dongxuyang@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20251205090411.1388-1-dongxuyang@eswincomputing.com>
References: <20251205090411.1388-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgCXkWk0oDJpctmBAA--.42178S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4fAF4rXry7WF45Gw17Wrg_yoW8KF47pF
	4xCFWUtrnagF17WanYqF1I9F13Xa97GF18Krs2g3Z0q3s0g3Z0qw43Kry5JF97Ar1xXFy5
	GF9agw12ya18A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUXJ5wUUUUU=
X-CM-SenderInfo: pgrqw5xx1d0w46hv4xpqfrz1xxwl0woofrz/

From: Xuyang Dong <dongxuyang@eswincomputing.com>

Introduce device-tree binding documentation for ESWIN EIC7700 pwm
controller.

Signed-off-by: Xiang Xu <xuxiang@eswincomputing.com>
Signed-off-by: Guosheng Wang <wangguosheng@eswincomputing.com>
Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
---
 .../bindings/pwm/eswin,eic7700-pwm.yaml       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/eswin,eic7700-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/eswin,eic7700-pwm.yaml b/Documentation/devicetree/bindings/pwm/eswin,eic7700-pwm.yaml
new file mode 100644
index 000000000000..8b7dc7d4dffe
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/eswin,eic7700-pwm.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/eswin,eic7700-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ESWIN EIC7700 PWM controller
+
+maintainers:
+  - Xiang Xu <xuxiang@eswincomputing.com>
+  - Guosheng Wang <wangguosheng@eswincomputing.com>
+  - Xuyang Dong <dongxuyang@eswincomputing.com>
+
+description: |
+  The EIC7700 PWM used the DesignWare APB timers module. The PWM driver
+  supports a duty cycle range from 0% to 100%, with explicit support for
+  both 0% and 100% duty cycles.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: eswin,eic7700-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 3
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+
+  snps,pwm-full-range-enable:
+    type: boolean
+    description: |
+      Enable support for 0% and 100% duty cycle.
+      When present, the PWM controller can output 0% and 100% duty cycles.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - snps,pwm-full-range-enable
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@50818000 {
+        compatible = "eswin,eic7700-pwm";
+        reg = <0x50818000 0x4000>;
+        clocks = <&clock 242>;
+        resets = <&reset 136>;
+        #pwm-cells = <3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&fan_pwm>;
+        snps,pwm-full-range-enable;
+    };
-- 
2.34.1


