Return-Path: <linux-pwm+bounces-3761-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A41D09AB9F7
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 01:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE87B22E4A
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B941CEAC6;
	Tue, 22 Oct 2024 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbEPKR5K"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3983130AF6;
	Tue, 22 Oct 2024 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639279; cv=none; b=agKaLVFGuA9OjOqioA5HGyYiuN8yIOd3+tev7Mk0QH2cTWCeaUePHAm4lwIV71aKRKKcZdoIK/ia2MGqfPiy7BQzqPcocMy+gPx1z2YxlbINmYSgRcjxUzOJKkfBJtyyZ6bJQ09Vu9/jxYgQtbrH/idrOHU7p357hmIxv+VA8bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639279; c=relaxed/simple;
	bh=FAO97CuKD7aUVJNmNCdPPUIYExvHYvJ4uLWSpPgZ0gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sj4wQmS9JxmnK8xZfBzsGgFlslVz0MM7H+72eYDwYTVMdlBQ955iqkVj6R4HoAeybcjmGfOwyGAcWCKnUBGB4C0Gp3eW5INrFFKkhcBkBWCHqWTtceXsB9y+DzqJNAhUXqz4+ngicy7wLSdLzlDfXChV3q4ightTsmTgvzu7Gzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbEPKR5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FD5C4CEC3;
	Tue, 22 Oct 2024 23:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729639279;
	bh=FAO97CuKD7aUVJNmNCdPPUIYExvHYvJ4uLWSpPgZ0gc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FbEPKR5KkWYqafMhGfTzgClimknwLceQn+89rnz86iHFw5KsrQ+3pMcGvblscklhz
	 UzAJAgmG8FTmmmG+x1uMk9Vr+CD6PHXDwlZb9ivLHvC2mX7wA1bDMpJaGFmHK8PS/J
	 wDv7dgAHPUmaMmRYNz74o9MmGbiAcbuouFCGNf4dRJPz68hS4AsUSbWx8ttK+TnMxZ
	 C/Oxyw4cQfpuSr8s64jqma+ZVj1zLZ0IAIUbQXfN43Y2Vx4X2HoFfUcvEfZlOIEfDV
	 hzQ/7qzdcv2DgVvzOPmoEfxowF7RCxXCw1MIzLz3JuQVN5327t5jiCYEolXCwXS/nC
	 YWrcLWeEyWO0A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 23 Oct 2024 01:20:01 +0200
Subject: [PATCH v9 1/6] dt-bindings: arm: airoha: Add the chip-scu node for
 EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-en7581-pinctrl-v9-1-afb0cbcab0ec@kernel.org>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
In-Reply-To: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
 linux-pwm@vger.kernel.org
X-Mailer: b4 0.14.2

This patch adds the chip-scu document bindings for EN7581 SoC.
The airoha chip-scu block provides a configuration interface for clock,
io-muxing and other functionalities used by multiple controllers (e.g.
clock, pinctrl, ecc.) on EN7581 SoC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/arm/airoha,en7581-chip-scu.yaml       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..67c449d804c22b6b8268c9840995fe2584349b58
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/airoha,en7581-chip-scu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha Chip SCU Controller for EN7581 SoC
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description:
+  The airoha chip-scu block provides a configuration interface for clock,
+  io-muxing and other functionalities used by multiple controllers (e.g. clock,
+  pinctrl, ecc) on EN7581 SoC.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - airoha,en7581-chip-scu
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      syscon@1fa20000 {
+        compatible = "airoha,en7581-chip-scu", "syscon";
+        reg = <0x0 0x1fa20000 0x0 0x388>;
+      };
+    };

-- 
2.47.0


