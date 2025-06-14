Return-Path: <linux-pwm+bounces-6359-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D86FEAD9DA9
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 16:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D201D189E1A1
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 14:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB892E62D3;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9F5zuLk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925D2E3385;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911831; cv=none; b=eU1nm4LfF/PmMU0g5bJS7/XSW3ZgKz/RpnipINJWhGpSD9WjqsJhP8i/2ygq6OiLRzikfEbUCjKeyw4FB9eD6Ua8cf2xxhCoZvmcHgB7ExJHAfjpvoIR05QgwIMJuQ7QSNIhYvK6Mel436XjIkqu2yBXZhKyC0F+FjzULFU/hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911831; c=relaxed/simple;
	bh=UMjAhA0/of625MCFMiAwHjc6aT/ETfabVgzkhbFPGLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMX1IQLUdu+Cg+6RlkCsFCky5OYJnGeA4lhlIiSgQZKWtqm1iHSfcE0Sn17Jdz7Dp0FCa5Uk8XC/E14j5K5b5xwN/f1pnuzWPzdPNz/0LsK6hJB9ILkOouH+dALeBtkwJSqMqkPlccuYKUJ2uJTSPQF+WPLBRijMWUGTcFKYwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9F5zuLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBDC7C4CEF9;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749911830;
	bh=UMjAhA0/of625MCFMiAwHjc6aT/ETfabVgzkhbFPGLI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D9F5zuLkXw/dKCrg+YL2cACFr6om86akNcBBKfzrsEUKp28jlym1pUJ5MnK2SkX9m
	 7YF+BrJTD1t7dEcSin7W/2gQrKsH1dGEsuCK9ROQRQ0puWm0TyeiwOK/D+l4/2g3+v
	 qOVMWaYNgXpuaSvR6v94mwTyMVKI/GoDD3FvJC0CaraBVSZveGV2a79ftYVIzIC0Oo
	 3EM+oMLfJFdGQa63FxnRbArOrG+uaCJ3DiOOBO5I+Ofd56VFrOpJ2oF+PNUB9yfWEK
	 bgf7Aw67cNQd6AjNum6pjSIvoKnxdJbi2+PbB2HxGeyjYgzAblywjVW2Vbr323gOq6
	 v4bfA8uzO/Nig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31DDC71150;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 14 Jun 2025 15:36:02 +0100
Subject: [PATCH v5 11/20] dt-bindings: mfd: adp5585: add properties for
 input events
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250614-dev-adp5589-fw-v5-11-7e9d84906268@analog.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
In-Reply-To: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749911835; l=7657;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=CnRbMPpeu0VTUQwRPy3CZDgnIinA5ERlDv8wycI5H2I=;
 b=sudghfV+Bg6pXoNLvZuWIXUAqRuFfPJvzr+mGuR7F2YrV1VYiNHo83llgmQlh/oBdFTMcu3N2
 7ZxLUH8ByamAM2xG5e9JL+GlCt///aUpvxMVEdWuMizkROkowRPruKF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Add properties related to input events. These devices can act as
keyboards and can support events either via a keymap Matrix or through
GPIs. Note that the device needs to be an interrupt controller for GPIs
based events.

We specifically need a property specifying the pins used by the keymap
matrix since these devices have no requirement for rows and columns to be
contiguous without holes which is enforced by the standard input
properties.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../devicetree/bindings/mfd/adi,adp5585.yaml       | 188 ++++++++++++++++++++-
 1 file changed, 186 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index 9471af28419d820424745315ffb2129f7dd37581..b3bf2ed586104303fd078bd06683e4f0d3383575 100644
--- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -49,6 +49,84 @@ properties:
   "#pwm-cells":
     const: 3
 
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  poll-interval:
+    enum: [10, 20, 30, 40]
+    default: 10
+
+  adi,keypad-pins:
+    description: Specifies the pins used for the keypad matrix.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  adi,unlock-events:
+    description:
+      Specifies a maximum of 2 events that can be used to unlock the keypad.
+      If this property is set, the keyboard will be locked and only unlocked
+      after these keys/gpis are pressed. The value 127 serves as a wildcard which
+      means any key can be used for unlocking.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 2
+    items:
+      anyOf:
+        - minimum: 1
+          maximum: 88
+        - minimum: 97
+          maximum: 115
+        - const: 127
+
+  adi,unlock-trigger-sec:
+    description:
+      Defines the time in which the second unlock event must occur after the
+      first unlock event has occurred.
+    maximum: 7
+    default: 0
+
+  adi,reset1-events:
+    description:
+      Defines the trigger events (key/gpi presses) that can generate reset
+      conditions one the reset1 block.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 3
+
+  adi,reset2-events:
+    description:
+      Defines the trigger events (key/gpi presses) that can generate reset
+      conditions one the reset2 block.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 2
+
+  adi,reset1-active-high:
+    description: Sets the reset1 signal as active high.
+    type: boolean
+
+  adi,reset2-active-high:
+    description: Sets the reset2 signal as active high.
+    type: boolean
+
+  adi,rst-passthrough-enable:
+    description: Allows the RST pin to override (OR with) the reset1 signal.
+    type: boolean
+
+  adi,reset-trigger-ms:
+    description:
+      Defines the length of time that the reset events must be active before a
+      reset signal is generated. All events must be active at the same time for
+      the same duration.
+    enum: [0, 1000, 1500, 2000, 2500, 3000, 3500, 4000]
+    default: 0
+
+  adi,reset-pulse-width-us:
+    description: Defines the pulse width of the reset signals.
+    enum: [500, 1000, 2000, 10000]
+    default: 500
+
 patternProperties:
   "-hog(-[0-9]+)?$":
     type: object
@@ -56,11 +134,28 @@ patternProperties:
     required:
       - gpio-hog
 
+dependencies:
+  linux,keymap:
+    - adi,keypad-pins
+    - interrupts
+  interrupt-controller:
+    - interrupts
+  adi,unlock-trigger-sec:
+    - adi,unlock-events
+  adi,reset1-active-high:
+    - adi,reset1-events
+  adi,rst-passtrough-enable:
+    - adi,reset1-events
+  adi,reset2-active-high:
+    - adi,reset2-events
+
 required:
   - compatible
   - reg
 
 allOf:
+  - $ref: /schemas/input/matrix-keymap.yaml#
+  - $ref: /schemas/input/input.yaml#
   - if:
       properties:
         compatible:
@@ -68,8 +163,29 @@ allOf:
             const: adi,adp5585-01
     then:
       properties:
+        adi,unlock-events: false
+        adi,unlock-trigger-sec: false
         gpio-reserved-ranges: false
-
+        adi,keypad-pins:
+          minItems: 2
+          maxItems: 11
+          items:
+            minimum: 0
+            maximum: 10
+        adi,reset1-events:
+          items:
+            anyOf:
+              - minimum: 1
+                maximum: 30
+              - minimum: 37
+                maximum: 47
+        adi,reset2-events:
+          items:
+            anyOf:
+              - minimum: 1
+                maximum: 30
+              - minimum: 37
+                maximum: 47
   - if:
       properties:
         compatible:
@@ -81,6 +197,25 @@ allOf:
               - adi,adp5585-04
     then:
       properties:
+        adi,unlock-events: false
+        adi,unlock-trigger-sec: false
+        adi,keypad-pins:
+          minItems: 2
+          maxItems: 10
+          items:
+            enum: [0, 1, 2, 3, 4, 6, 7, 8, 9, 10]
+        adi,reset1-events:
+          items:
+            anyOf:
+              - minimum: 1
+                maximum: 25
+              - enum: [37, 38, 39, 40, 41, 43, 44, 45, 46, 47]
+        adi,reset2-events:
+          items:
+            anyOf:
+              - minimum: 1
+                maximum: 25
+              - enum: [37, 38, 39, 40, 41, 43, 44, 45, 46, 47]
         gpio-reserved-ranges:
           maxItems: 1
           items:
@@ -99,11 +234,33 @@ allOf:
     then:
       properties:
         gpio-reserved-ranges: false
+        adi,keypad-pins:
+          minItems: 2
+          maxItems: 19
+          items:
+            minimum: 0
+            maximum: 18
+        adi,reset1-events:
+          items:
+            anyOf:
+              - minimum: 1
+                maximum: 88
+              - minimum: 97
+                maximum: 115
+        adi,reset2-events:
+          items:
+            anyOf:
+              - minimum: 1
+                maximum: 88
+              - minimum: 97
+                maximum: 115
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -119,6 +276,33 @@ examples:
             gpio-reserved-ranges = <5 1>;
 
             #pwm-cells = <3>;
+
+            interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+
+            adi,reset1-events = <1 43>;
+            adi,reset2-events = <2 3>;
+            adi,reset-trigger-ms = <2000>;
+
+            /*
+             * col0, col1, col2
+             * row0, row1, row2
+             */
+            adi,keypad-pins = <0 1 2 6 7 8>;
+
+            linux,keymap = <
+                MATRIX_KEY(0x00, 0x00, KEY_1)
+                MATRIX_KEY(0x00, 0x01, KEY_2)
+                MATRIX_KEY(0x00, 0x02, KEY_3)
+
+                MATRIX_KEY(0x01, 0x00, KEY_A)
+                MATRIX_KEY(0x01, 0x01, KEY_B)
+                MATRIX_KEY(0x01, 0x02, KEY_C)
+
+                MATRIX_KEY(0x02, 0x00, BTN_1)
+                MATRIX_KEY(0x02, 0x01, BTN_2)
+                MATRIX_KEY(0x02, 0x02, BTN_3)
+            >;
         };
     };
 

-- 
2.49.0



