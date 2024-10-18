Return-Path: <linux-pwm+bounces-3722-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1D9A3F61
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 15:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C27B23ED6
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107DF1D0DF7;
	Fri, 18 Oct 2024 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiXyNnAN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8901E49F;
	Fri, 18 Oct 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257582; cv=none; b=GOwKiKyuqBtVxKqLAlYVGGyAISmnpUBSldB2HfJ9lbc8w/lxYDxKMQz7ThTpQli+kJvEJZVTQbhfwEYCSB5H3LFokVfhj3ivU2iCzlgHr3ekqB2Y0LbLYSzj5JqdbS3/DBkgPXJ9zw0fZSEmJkd3WsXW7zxdeaDOHVEBlhv1pCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257582; c=relaxed/simple;
	bh=eB3BfaRHbAYsShmwieKgK+tyQ9QuJAeGouECbmRe0ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4lrfMg+rz43pQnHOUUH/gXOuBGz3SOv0X2z6PgPj78m8ycGHH5W7EF3o2sLAj1kJ9+8povNbjLK1y2CO8U7VXo857fVV6WFX3N08jKMVjk7RxYoUI9kzmYr8o7HJKmLi/t+w5CnWWuBDCQL2uGPDxSUMFp2GNH4kaGp1vrPgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiXyNnAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EB9C4CEC3;
	Fri, 18 Oct 2024 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729257581;
	bh=eB3BfaRHbAYsShmwieKgK+tyQ9QuJAeGouECbmRe0ng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZiXyNnANDDto5wGex3YPjx4ArU1KPSrhedpJYtpLZ1BaAAUvCVtu1WsyDfOffBGSJ
	 4td1aWS/HTNG+UYaT76FaCTsa4iqtfssCTpW+VI0E6f2+WBOBPavdKTyrbe6F0LZWv
	 9+hzNrkolUoLEugROSshLgGVEff8Q5Zc45GVnp0MjAzmDlvOBBHhuPjmHfeQVHiLyG
	 dRb/5gVqCYIh5XDT3mV8KId2V/uuitHUK1/Ff+aJwKD8sNeUEAFXtOVOOrytt1fjiX
	 QrEGDtfzhzYOSCWtiZJZvO3cO+T0ZbYHjjUKKl86vHkxZFQZx62HIBa4CM+YB3rgTd
	 ckAF0Y5pQwdrg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 18 Oct 2024 15:19:04 +0200
Subject: [PATCH v8 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
In-Reply-To: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
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

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml | 61 ++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..fb68c10b037b840a571a2ceee57f13cbae78da66
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
@@ -0,0 +1,61 @@
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
+  airoha,74hc595-mode:
+    description: Set the PWM to handle attached shift register chip 74HC595.
+
+      With this disabled, PWM assume a 74HC164 chip attached.
+
+      The main difference between the 2 chip is the presence of a latch pin
+      that needs to triggered to apply the configuration and PWM needs to
+      account for that.
+    type: boolean
+
+  airoha,sipo-clock-divisor:
+    description: Declare Shift Register chip clock divisor (clock source is
+      from SoC APB Clock)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 32
+    enum: [4, 8, 16, 32]
+
+  airoha,sipo-clock-delay:
+    description: Declare Serial GPIO Clock delay.
+      This can be needed to permit the attached shift register to correctly
+      setup and apply settings. Value must NOT be greater than
+      "airoha,sipo-clock-divisor" / 2
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 1
+    minimum: 1
+    maximum: 16
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


