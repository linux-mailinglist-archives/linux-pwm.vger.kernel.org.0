Return-Path: <linux-pwm+bounces-5498-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7583A8A1B2
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823133BCC92
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7529B78E;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDkepYxa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4145229B76C;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728560; cv=none; b=LCQ/DkZ5WreZs+tRP5hIdOo3yA/S0U9WLccrz3AqbAxywq9iZ4mjZq1AykD2O3uiciwHqzilIF2ApkybuaXoAVgi2ozoAq0Un2RPu9iHGLLPbdXwJj+fYCuB6KzcYyd1fVkh0iZY0/WLSpDp+JNm9AzPON+P0iAm79DuirZJ3fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728560; c=relaxed/simple;
	bh=wTREZxYBrpJ9iX8vTdiRkhUcGSZDxA0IGE7Af2VCpxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VJq8MFepdo/YnWjZ99JlelrhwYbHZnNWInNOpFgz0l7kTWlw6I9NJqn9w1ZepdwVLT+m9IFRLW+0xlcprbxU1IXnlXXybmkT9BxbmqdVTUrz4A5j2GobTF5rKCClvkC4og/s9rtXirxV6rssVGO30dWsSwJgT+U+Ab+i9dEMcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDkepYxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FBB4C4CEF6;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728559;
	bh=wTREZxYBrpJ9iX8vTdiRkhUcGSZDxA0IGE7Af2VCpxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JDkepYxa/gPxgqI/XiQAoDJCPsBz0bbzeYHPIBMMzb6PbsnywPmOrrFlpzNDYsVcc
	 hYrqPIT60h5TkM/dV2HVdQ6m4TCCqRyA0FJ6JxatGtOFtE7FUvyhPOTRNuzYB9bLAR
	 Zlfil1HlW79XOToLnl8OFWdk9pz/tUOY+GXX3y+LnAJWcMlZsnto0UQtXvii5FJcZg
	 jNAJe/eTbI4bC1aA9FNY1Et0v5rJvNNUBgDLNoS3kg0E9lRn4S7CrUKxo5TEP50lMC
	 jgwk/+errEvHlohqLKZEvoCyl0s1RQyttf24UChIV0ad9rpPaNHVqvdN6+IZ6DgeEf
	 5kNlt5efB8bug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657C0C369B8;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:21 +0100
Subject: [PATCH v2 05/17] dt-bindings: mfd: adp5585: document adp5589 I/O
 expander
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-5-3a799c3ed812@analog.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
In-Reply-To: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728559; l=3566;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YoojjYm1UzSm+sJS5QEfKj93KLVCY30qFWFJCm6+f8k=;
 b=gk/mSBZfpRljrZwQ0LifFheXBkqUVdMVvY1fVhids2wWUJWdVfVNJ+JLACxIXwJQ4R6zBu/AE
 yIpFaL3dS3PCIs0PQT0aRQ6CltFZcmbmck6zKkSlA0cZ8WlFamnkOv4
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

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../devicetree/bindings/mfd/adi,adp5585.yaml       | 47 +++++++++++++++++-----
 .../devicetree/bindings/trivial-devices.yaml       |  2 -
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index e30e22f964f78519b2ec207e9415e4897db5c702..d690a411b3a4307f6dd5f4a432a357e89fefabb0 100644
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
+              - adi,adp5585-03
+              - adi,adp5585-04
+              - adi,adp5585-02
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



