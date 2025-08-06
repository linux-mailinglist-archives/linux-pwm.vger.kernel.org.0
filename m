Return-Path: <linux-pwm+bounces-6967-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A077B1C17C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 09:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BBE1822FE
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Aug 2025 07:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E22236E0;
	Wed,  6 Aug 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TgPrb9VS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB3221286
	for <linux-pwm@vger.kernel.org>; Wed,  6 Aug 2025 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754466184; cv=none; b=k6j7wVbpPaH9nkYkO1Dw+1rOFYF7DSuBvDIX0qtSK0j51Dka76w9t5e9pwP+E7UHaIV/4N7WYaJx2mmtcXKsNNVxN5+FneTUc1SsF09WE/dCTq42vD51SfEhVK/WstCRZnOmIKBqNoflXuvV0j/dDk/ZqTq68rb88HnWSjKkyF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754466184; c=relaxed/simple;
	bh=kkEmUrwx+kdtEg6kHO1I+y5/Dpcy71Vjd/uZm+Eancc=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=JS9+BXGq72+UlHKhu6SsChhPef9sGujApHohDR1CAqPA37k1WboVnTT/X3w6FzIKi+tXF99xvHBATJm6ro0AShgL83tYSmdxTqbqeGfaptf+nzWsUr2WASLQUAH9tiQwBh580UPCSEO482yavj4YY+fuj1WQEbjj5ZgaucjEvOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TgPrb9VS; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250806074259euoutp0112039d18137a6c7ab890ca3d3ec8af7f~ZHbHbpyvn2621826218euoutp01D
	for <linux-pwm@vger.kernel.org>; Wed,  6 Aug 2025 07:42:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250806074259euoutp0112039d18137a6c7ab890ca3d3ec8af7f~ZHbHbpyvn2621826218euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754466179;
	bh=q2udXAqNPgrdyMOy7GXl2F6vbyrcToTWFKHsnI3BpjI=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=TgPrb9VScAT0YNpQCAXcDowGKe7oZE2n5RBTagJ1796cJjR99/U1aoIpvV9eRi4yI
	 d1j3zthrHPPeDXj/K/mdJH53YoCOjEQNY3pecnjKY9n158klVHT7IqfWrghahcL70k
	 WzVKtluYB9S7k/p+WJdOnsri8gvwlWWBG9eqr4lk=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250806074258eucas1p1e0d3410d9ab52d6d35cae08268a76389~ZHbG3UIQC0086600866eucas1p1X;
	Wed,  6 Aug 2025 07:42:58 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250806074257eusmtip27f6e726d2075ae083960782fdf047806~ZHbFpMAZX1964419644eusmtip2F;
	Wed,  6 Aug 2025 07:42:57 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 06 Aug 2025 09:42:50 +0200
Subject: [PATCH v13 5/7] dt-bindings: pwm: thead: Add T-HEAD TH1520 PWM
 controller
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-rust-next-pwm-working-fan-for-sending-v13-5-690b669295b6@samsung.com>
In-Reply-To: <20250806-rust-next-pwm-working-fan-for-sending-v13-0-690b669295b6@samsung.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,  Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,  Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,  Andreas
	Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,  Trevor
	Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,  Michal
	Wilczynski <m.wilczynski@samsung.com>, Guo Ren <guoren@kernel.org>,  Fu Wei
	<wefu@redhat.com>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>,  Benno Lossin <lossin@kernel.org>,  Michael
	Turquette <mturquette@baylibre.com>,  Drew Fustini <fustini@kernel.org>,
	Benno Lossin <lossin@kernel.org>,  Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org,  Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250806074258eucas1p1e0d3410d9ab52d6d35cae08268a76389
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250806074258eucas1p1e0d3410d9ab52d6d35cae08268a76389
X-EPHeader: CA
X-CMS-RootMailID: 20250806074258eucas1p1e0d3410d9ab52d6d35cae08268a76389
References: <20250806-rust-next-pwm-working-fan-for-sending-v13-0-690b669295b6@samsung.com>
	<CGME20250806074258eucas1p1e0d3410d9ab52d6d35cae08268a76389@eucas1p1.samsung.com>

Add the Device Tree binding documentation for the T-HEAD
TH1520 SoC PWM controller.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Drew Fustini <fustini@kernel.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../devicetree/bindings/pwm/thead,th1520-pwm.yaml  | 48 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml b/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..855aec59ac53c430adc849271235686e87b10e6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/thead,th1520-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 PWM controller
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: thead,th1520-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: SoC PWM clock
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      pwm@ffec01c000 {
+          compatible = "thead,th1520-pwm";
+          reg = <0xff 0xec01c000 0x0 0x4000>;
+          clocks = <&clk CLK_PWM>;
+          #pwm-cells = <3>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e6fe51161ea9b2646d252315dacfe9f17420192d..17d44567fe479c5db697c8f7604b423a95a341d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21708,6 +21708,7 @@ F:	Documentation/devicetree/bindings/firmware/thead,th1520-aon.yaml
 F:	Documentation/devicetree/bindings/mailbox/thead,th1520-mbox.yaml
 F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
+F:	Documentation/devicetree/bindings/pwm/thead,th1520-pwm.yaml
 F:	Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c

-- 
2.34.1


