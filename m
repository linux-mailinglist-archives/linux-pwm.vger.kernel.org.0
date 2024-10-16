Return-Path: <linux-pwm+bounces-3675-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B63D39A06A2
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 12:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1DA1F23DC7
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 10:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D860F206968;
	Wed, 16 Oct 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SytKO7G6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94160206960;
	Wed, 16 Oct 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729073303; cv=none; b=QLZq0e6VCIPwyRD0UsHqcthOh8dHzAFCHUpWrFjBqFR5VXuAjHhttN2SP53CcaAG/NE8uzVsjhzvnx4dSuwhrlF4cRnBs4Q9aFJpMa11r2jxG4ClC0dYt67el0cL0BMOVtUhwlv37Pkeek81Qrw06cpfGMuLlubsfpaqC6Bx9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729073303; c=relaxed/simple;
	bh=XeXtI3ee+OeOqTEY9KnIkN4qLg1Q8wUxrPM5In0H/Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swEbt8wrZTrE/mB2/TDleaNNvrn4oa4rXKDxm9Uy6RVfirxKpAb56hMFeNluNKTDsa7DhASGTW2H6fOKv8u8ZZV/D2DHKMQzIe0WJxPuGo8k2KwiGmexE9TeIMMsCgSJNXuYpHXRXHyv8J6IwekcxQP7cRsOGrm2rOsLOvHnXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SytKO7G6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D966C4CEC5;
	Wed, 16 Oct 2024 10:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729073303;
	bh=XeXtI3ee+OeOqTEY9KnIkN4qLg1Q8wUxrPM5In0H/Zs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SytKO7G6algKu+vMXNzAV/wXIJR0sehWFumPhVOJyQJOsARzclbisrI1jv/iwbEqz
	 4MbyOLON5fKo38GUQPMEvt1QmAqOa1rfbn6pnaLVhlL05AfkDZ3IFfULPxp7kK0VNh
	 DtM0uKbNns0MUXoj5yzqX/t2qd2QPK3zhHWTW2U8a6SHDE2usZdmqULoRobNoTPwuH
	 rTRV4FwWknVufZPtKVFhxyU++nRYtUI2/5DkZ17XBN1rfRCZ8wg7TOh+hTooliwnMp
	 10vED1elTsU3CXt0OpU+wBHdJLwApDaD4TLwn6cpu0ZedeQcjDsTgSGjJwtw1CCNHw
	 ab81Sl3ZvNAoQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 16 Oct 2024 12:07:31 +0200
Subject: [PATCH v7 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-en7581-pinctrl-v7-3-4ff611f263a7@kernel.org>
References: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
In-Reply-To: <20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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


