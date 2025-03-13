Return-Path: <linux-pwm+bounces-5159-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C013A5F794
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DE317E601
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A83267B8D;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S79RwY+W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60326869F;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875558; cv=none; b=Y0yhjJlz8Rts6gGwEV3HgYoevDrcjSxewk2wr1leVfBuDEVZ6l2EAAWgqoXtSpWka/OAQGGO5Pi7mva4tUMPwkd9d7sw5mARIK/4Oxk999gu0gIJ4z+IHFAULYjU5k51c8q/ZYuhP7h5UGO9LFnb1xdxXRylbIOXB/bA8ZAo41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875558; c=relaxed/simple;
	bh=Fn7k3XRmgGeTcU5L6r0+n5XDkdk/fxr+UU17KnsKoac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RyRxycFaQpMMOTRMZBKftIwiou4dySXRxi+A25Yh1q5HRyO32A7kUQvGC37xfdn2qwfyT1EqXdiSuALZg8mKJI9/YnDhI62NRqbcF35i3y1plXrGZHmJHEVltcB6cyYlDw+aei288vWI9We5cO/zQLyxD5FFAwF6qIoGb4IxCYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S79RwY+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 094E6C2BC87;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875558;
	bh=Fn7k3XRmgGeTcU5L6r0+n5XDkdk/fxr+UU17KnsKoac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S79RwY+WNYEbT+JJ6UKWq8MWOlLkMwMFBAt45C6gNCQErd5IKUydv0LYqgCmoQCvb
	 VucJR+4K3Ae5Fe24L1TBMjeFc3Dp8X/b5GorJW032IpLmUXLErLJZBQ93ScRHzfXVo
	 rMe188j6Z2QF+RwWmFBZbGqV2dFLiDHAc4hykjzoy1PbeMOkDFz68NJlN45+2HCpdp
	 KivD1Oa1x6qoGnFunoI/liKGXNkOuQ0DkWMYSrnwoHHicbMpI9SbpfCVskYsuLJr3g
	 mh9XUieFelrsO25wgd05jI8dqV/3DRWWEdY2AvGmTolS9AlPXGqyWgXD+zDSY7kEcZ
	 66hH50+zygkPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2391C282EC;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:26 +0000
Subject: [PATCH 09/18] dt-bindings: mfd: adp5585: add properties for input
 events
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-9-20e80d4bd4ea@analog.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=7712;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ypEFkxleuONgmcwAw/524X6k+fiuPuF+VdlS5uAV6c0=;
 b=jUMp/8OX8QJ/McPQHFEUltq4QahrfNA2SqAeHM3JrMSUQJEp1hciJ+gy0/BfYN1GAE3NxTQPY
 gbSdx0ZDpN3BYJ4RC+RP/jK+CmegX3alrDUPvu8BYtEa2WHe0DuHE/N
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

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../devicetree/bindings/mfd/adi,adp5585.yaml       | 188 ++++++++++++++++++++-
 1 file changed, 187 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index 87256a37b5f4b6a019f581b164c276d8805d2e52..e976c9240df79afae1d0949e6ac91d477bfaceef 100644
--- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -49,6 +49,85 @@ properties:
   "#pwm-cells":
     const: 3
 
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 2
+
+  adi,keypad-pins:
+    description: Specifies the pins used for the keypad matrix.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  adi,key-poll-ms:
+    description: Configure time between consecutive scan cycles.
+    enum: [10, 20, 30, 40]
+    default: 10
+
+  adi,unlock-keys:
+    description:
+      Specifies a maximum of 2 keys that can be used to unlock the keypad.
+      If this property is set, the keyboard will be locked and only unlocked
+      after these keys are pressed. The value 127 serves as a wildcard which
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
+  adi,reset1-keys:
+    description:
+      Defines the trigger events (key presses) that can generate reset
+      conditions one the reset1 block.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 3
+
+  adi,reset2-keys:
+    description:
+      Defines the trigger events (key presses) that can generate reset
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
+  adi,rst-passtrough-enable:
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
@@ -56,11 +135,28 @@ patternProperties:
     required:
       - gpio-hog
 
+dependencies:
+  linux,keymap:
+    - adi,keypad-pins
+    - interrupts
+  interrupt-controller:
+    - interrupts
+  adi,unlock-trigger-sec:
+    - adi,unlock-keys
+  adi,reset1-active-high:
+    - adi,reset1-keys
+  adi,rst-passtrough-enable:
+    - adi,reset1-keys
+  adi,reset2-active-high:
+    - adi,reset2-keys
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
@@ -68,7 +164,29 @@ allOf:
             const: adi,adp5585-01
     then:
       properties:
+        adi,unlock-keys: false
+        adi,unlock-trigger-sec: false
         gpio-reserved-ranges: false
+        adi,keypad-pins:
+          minItems: 2
+          maxItems: 11
+          items:
+            minimum: 0
+            maximum: 10
+        adi,reset1-keys:
+          items:
+            anyOf:
+              - minimum: 1
+                maximum: 30
+              - minimum: 37
+                maximum: 47
+        adi,reset2-keys:
+          items:
+            anyOf:
+              - minimum: 1
+                maximum: 30
+              - minimum: 37
+                maximum: 47
     else:
       if:
         properties:
@@ -81,6 +199,25 @@ allOf:
                 - adi,adp5585-04
       then:
         properties:
+          adi,unlock-keys: false
+          adi,unlock-trigger-sec: false
+          adi,keypad-pins:
+            minItems: 2
+            maxItems: 10
+            items:
+              enum: [0, 1, 2, 3, 4, 6, 7, 8, 9, 10]
+          adi,reset1-keys:
+            items:
+              anyOf:
+                - minimum: 1
+                  maximum: 25
+                - enum: [37, 38, 39, 40, 41, 43, 44, 45, 46, 47]
+          adi,reset2-keys:
+            items:
+              anyOf:
+                - minimum: 1
+                  maximum: 25
+                - enum: [37, 38, 39, 40, 41, 43, 44, 45, 46, 47]
           gpio-reserved-ranges:
             maxItems: 1
             items:
@@ -90,11 +227,33 @@ allOf:
       else:
         properties:
           gpio-reserved-ranges: false
+          adi,keypad-pins:
+            minItems: 2
+            maxItems: 19
+            items:
+              minimum: 0
+              maximum: 18
+          adi,reset1-keys:
+            items:
+              anyOf:
+                - minimum: 1
+                  maximum: 88
+                - minimum: 97
+                  maximum: 115
+          adi,reset2-keys:
+            items:
+              anyOf:
+                - minimum: 1
+                  maximum: 88
+                - minimum: 97
+                  maximum: 115
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -110,6 +269,33 @@ examples:
             gpio-reserved-ranges = <5 1>;
 
             #pwm-cells = <3>;
+
+            interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+
+            adi,reset1-keys = <1 43>;
+            adi,reset2-keys = <2 3>;
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
2.48.1



