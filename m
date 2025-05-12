Return-Path: <linux-pwm+bounces-5901-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51E0AB373F
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496FA16F2F7
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6060B2949F0;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDP7/bsJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C401293759;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=dm6XJrIvxoNgPX6yVRg8rdmlZMHTVPcTj9g/yKqvibMJ7uugKJ9Y+BHrV94u0Q6zGfeWeJGBOJqrNCNQxBbN3HKghZWLh1KYg7RMTlwH8+RfVEsiNZVHQm4ai6sAKLGLuuvB/uoday9OJoIqiG5FhrjbsDMV+ZqjYtaK/8Gi6s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=OJ6TowkARp/Doi6+qnVBRc8J1B7tkneZYbYsIN03Ohw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ep+fdX0Rdea4DxGoQwSIaEV1F0fikCgitjvHVHcqtmRFWssM1UEbKtWc0FGpwBP8DY9mas1GWiodVq0TM+TlzPLLTp6cl/VDXrFqSN7FXr5L6uVCoyjo3HOJronnBjxYsp7W53P0g3jsHN93kOeQ6TTpI/3BePOieP0valxh5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDP7/bsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B714FC4CEFD;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053538;
	bh=OJ6TowkARp/Doi6+qnVBRc8J1B7tkneZYbYsIN03Ohw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WDP7/bsJRx628HIItXNO2cEKTLBe8w36IATCjoeDIQyJmUXcqtBqrdpufqbUnCJq1
	 2m80Zf3Ot3BO+ZX58kp998U7NX6kxW78rHCytBtoruXiaSQo4f437/xNexx4VHUKL5
	 eKPq3k5646cxYL2Bw5ZibYQ2Yfd8EAMzuN8nPQsyuVpp6q46hl7F18VDQn5oCZ/IsY
	 TunZU2UkvML3u4KqkLM6/3U7C0+8PlAI7ZmdxqnfL4rg97oIJGodB83iQb1o1CH92l
	 b9JPfokZj06tjIZLlkNjzQjvXZVEhnMsriZFEKGgX5HSK9joyagYADFTBhq5SpU7vv
	 gPWod5ggYhlkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC17EC3ABC3;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:38:58 +0100
Subject: [PATCH v3 06/22] dt-bindings: mfd: adp5585: document adp5589 I/O
 expander
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-6-092b14b79a88@analog.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
In-Reply-To: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
To: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=3683;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=beLTP9GDditX9ha6QitAuUXi6px8/CxhIbNd+KVg+k4=;
 b=FV/4rBk1ORdEyoZ49j5yIV45t/WkLt5M6N4uhjZm7Wg13M3RR6QvKtVfn36K11tsnymOSkrHo
 EuTk+4nFROsD+Dqhh8UfdEhpXemHfwp1sVCCdud1pduCKNSz9V07Rxl
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The ADP5589 is a 19 I/O port expander with built-in keypad matrix decoder,
programmable logic, reset generator, and PWM generator.

We can't really have adp5589 devices fallback to adp5585 (which have
less pins) because there are some significant differences in the register
map.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../devicetree/bindings/mfd/adi,adp5585.yaml       | 47 +++++++++++++++++-----
 .../devicetree/bindings/trivial-devices.yaml       |  2 -
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index e30e22f964f78519b2ec207e9415e4897db5c702..9471af28419d820424745315ffb2129f7dd37581 100644
--- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -15,14 +15,21 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - adi,adp5585-00  # Default
-          - adi,adp5585-01  # 11 GPIOs
-          - adi,adp5585-02  # No pull-up resistors by default on special pins
-          - adi,adp5585-03  # Alternate I2C address
-          - adi,adp5585-04  # Pull-down resistors on all pins by default
-      - const: adi,adp5585
+    oneOf:
+      - items:
+          - enum:
+              - adi,adp5585-00  # Default
+              - adi,adp5585-01  # 11 GPIOs
+              - adi,adp5585-02  # No pull-up resistors by default on special pins
+              - adi,adp5585-03  # Alternate I2C address
+              - adi,adp5585-04  # Pull-down resistors on all pins by default
+          - const: adi,adp5585
+      - items:
+          - enum:
+              - adi,adp5589-00  # Default
+              - adi,adp5589-01  # R4 defaulted to RESET1 output
+              - adi,adp5589-02  # Pull-down resistors by default on special pins
+          - const: adi,adp5589
 
   reg:
     maxItems: 1
@@ -62,7 +69,17 @@ allOf:
     then:
       properties:
         gpio-reserved-ranges: false
-    else:
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adp5585-00
+              - adi,adp5585-02
+              - adi,adp5585-03
+              - adi,adp5585-04
+    then:
       properties:
         gpio-reserved-ranges:
           maxItems: 1
@@ -71,6 +88,18 @@ allOf:
               - const: 5
               - const: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adp5589-00
+              - adi,adp5589-01
+              - adi,adp5589-02
+    then:
+      properties:
+        gpio-reserved-ranges: false
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8da408107e55483affedb7e697eb79e8c8902ed9..208fe4242672d9da66799c2742a9381938737232 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -39,8 +39,6 @@ properties:
           - ad,adm9240
             # AD5110 - Nonvolatile Digital Potentiometer
           - adi,ad5110
-            # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
-          - adi,adp5589
             # Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher
           - adi,lt7182s
             # AMS iAQ-Core VOC Sensor

-- 
2.49.0



