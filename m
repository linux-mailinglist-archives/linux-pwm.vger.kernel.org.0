Return-Path: <linux-pwm+bounces-2993-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E6D94DABD
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Aug 2024 06:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002CB1C20E3B
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Aug 2024 04:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D313213E;
	Sat, 10 Aug 2024 04:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/uIFJMs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216FB322A;
	Sat, 10 Aug 2024 04:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723265368; cv=none; b=mLneY1l3+zQerVzmzHOTMFmJyRRHabinTUT5H2CvV5jcJM2Emp7M2ILnh/km6jNvln9D49RfhE4OW5FhzJMxK/dyW6tliYW+zg9kgasvM7ZXiuIhygER0RhhyTdGpEQ/srfFtEytnh5LxQMFCd7+0sHx2F/sSS1v8aB1WRf4yZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723265368; c=relaxed/simple;
	bh=Mk2rcGEztxQiBiRE+FSeEijjIvEK+CxsM3Jy7NOV8wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnWjzSG34hZMCy+FJIgiDYwJwhfSNcGk2VnAKuOsvhFAXUiyoiqnGYrfPgLuOpTfW86DN+ktiew4XMd93Pb4wAOFMgYC6nE04n/ah/Gh82Ib4li647dQJLfJGCMswBX55AyfgzK61idqgnCooaLStYiGB7bTuD7a8gJfxaD7fac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/uIFJMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA3BC32781;
	Sat, 10 Aug 2024 04:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723265367;
	bh=Mk2rcGEztxQiBiRE+FSeEijjIvEK+CxsM3Jy7NOV8wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D/uIFJMsY4l4fRE90e+K3E27n8L1A2K/W8jjacLb8FoDfFzp6MdrEkBY2tSbwiV4c
	 O1H+uC4qlvJ3WdZs/UGYoF/oGwN++iTodlLxDTv3x3YnBkazoxl2ZM2DzF1z58jUN0
	 luYL/GpHaI9vDhddLHuy1Pfv9FyPeejCyYLbb5d2mpctEonh5/e1foOluF6FjeB7U7
	 KRL4wrqUX21/NmXs422b0JQ32BRpD2675V6472JX2jnSFbMqgeEYLACbKi68zlwbBJ
	 uLX5dLx5SWgTtyRAwicJHZYXV0ICPCH20d8TPGxyKczyrmiBUG/s3miGDxb+OL/sgt
	 LqKGhLVpTaVWA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: ukleinek@kernel.org,
	lorenzo.bianconi83@gmail.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com
Subject: [PATCH 1/2] dt-bindings: pwm: Document Airoha EN7581 PWM
Date: Sat, 10 Aug 2024 06:48:42 +0200
Message-ID: <6a95b1d7fb90045a51a0cf51b9fafff26790904b.1723264979.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723264979.git.lorenzo@kernel.org>
References: <cover.1723264979.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Marangi <ansuelsmth@gmail.com>

Document required property for the Airoha EN7581 PWM. The device
requires 3 different address for the sgpio, flash and cycle config.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/pwm/airoha,en7581-pwm.yaml       | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
new file mode 100644
index 000000000000..52470668f90e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/airoha,en7581-pwm.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/airoha,en7581-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 PWM
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: airoha,en7581-pwm
+
+  reg:
+    items:
+      - description: sgpio config address
+      - description: flash config address
+      - description: cycle config address
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@1fbf0224 {
+        compatible = "airoha,en7581-pwm";
+        reg = <0x1fbf0224 0x10>,
+              <0x1fbf0238 0x28>,
+              <0x1fbf0298 0x8>;
+        #pwm-cells = <3>;
+    };
-- 
2.46.0


