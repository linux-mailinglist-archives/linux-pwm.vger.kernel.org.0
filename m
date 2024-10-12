Return-Path: <linux-pwm+bounces-3619-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F899B76C
	for <lists+linux-pwm@lfdr.de>; Sun, 13 Oct 2024 00:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411E01F21E64
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 22:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97E19B3ED;
	Sat, 12 Oct 2024 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anNf1kvF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B2199FA9;
	Sat, 12 Oct 2024 22:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770900; cv=none; b=ipTEDZyltrpKlZVV57V0rBC6cejQEv70Qk0FP5Q0knGjlLFG13BM7odhba3fciSQgLdhqIU3xtyGFcJIq6oO8MRXsYPyByNMsHq28LcfVf8o8N252NJS94uf6Ojm6EoYcFCk6t1X+6RXzkYcx8lvxAESbLZnXTjFIy5jFwZikWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770900; c=relaxed/simple;
	bh=smbpZHj9Fc2SUqJDB42k0u1ZQM85V3W6kg2ptqohN8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s6q7SovjTsEfUXYl4gA7rAmfwBIoLrQGP00nqk+41zhIHQwLsTQLnrLLKBpB79kqnuMmRM2xBmxaHrbgwKVnefwoMla2l7L+v4zC48X3TTzYPRccNvX+K5eWXv2WccvyPgZboplYUmdKGz6Ue18xmiXKD5e2J1XWqJezGg0KAkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anNf1kvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846FEC4CEC6;
	Sat, 12 Oct 2024 22:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728770899;
	bh=smbpZHj9Fc2SUqJDB42k0u1ZQM85V3W6kg2ptqohN8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=anNf1kvFupZEGY7x476OnekTaXHAdi+tJcpYIz6rWpdYdh7IWh0IPYZ13/xVno0BW
	 exF+u1mrPPW17xQFR1mr72LhI0RM/99u7TzbopZ5RyCVFSpUgrs9C9wC27QfcGozuy
	 toqHORGDFeq2f4MxL5dDY1GMBq1IIMHAeboKWPS/dWlJBcTKibmQ1fLZwWt99yQUHl
	 H9Svb2rp9e9uDTZ4decF87pnfdUDcXj5XO8e9YvHiTboyRnSOVQk0/FcYMgadlYnaQ
	 brNr1kZe+Rta2kXFEImYENXV7vgwxPfuEyysswzNE5aLOFwYKnVAJPLgIyHwgbXri9
	 vqtJpMptBap3w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 13 Oct 2024 00:07:09 +0200
Subject: [PATCH v6 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-en7581-pinctrl-v6-3-2048e2d099c2@kernel.org>
References: <20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org>
In-Reply-To: <20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org>
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

Introduce device-tree binding documentation for Airoha EN7581 pwm
controller.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f36387572a9781636aeacdbcc8947017c7ca75a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/airoha,en7581-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 PWM Controller
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: airoha,en7581-pwm
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm {
+      compatible = "airoha,en7581-pwm";
+
+      #pwm-cells = <3>;
+    };

-- 
2.47.0


