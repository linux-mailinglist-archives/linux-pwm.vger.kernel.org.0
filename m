Return-Path: <linux-pwm+bounces-6355-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497B4AD9D9C
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 16:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942F83B5F47
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 14:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBD82E336C;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOIS0Q4C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9D32E173E;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911831; cv=none; b=OdWS+qLdDINAdmIYYCRfyNsDFDCTFFOBtA5/+2UonECl5rnAycmVGXA7yys3qEtczUFzVKbpbBK2f3TGTQfedcbtJmUSZeZ+iE8ciLXk+u2pTOv+S2onOFFIB6HaGG2iLb0VTF+XuUylBV7xbJJ7/Zk8F7dr+tkSWJr45Psj2+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911831; c=relaxed/simple;
	bh=OJ6TowkARp/Doi6+qnVBRc8J1B7tkneZYbYsIN03Ohw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHBAkJEhx4TnWOIF4BJRxdpUjwKrPmcW7tdKZwk+XaEdXnHNaIy/hqpQVIjLEnjJteT4a9zNow8IzE4GnuExTXpszH4dX02QO3GpoQtz3yEwtZRQ1Z/mFef0lEeEWmPQ9d3sFu9nq4JqxEji3JXqIDKi/JvJ8Mu5WTO9NIEnT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOIS0Q4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85F57C4AF10;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749911830;
	bh=OJ6TowkARp/Doi6+qnVBRc8J1B7tkneZYbYsIN03Ohw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OOIS0Q4CWX1RTXYRhOA8FpS3z2RMuE87Yyk9ViOUen6I6q6NJNA9AtMCIe/nNSOPu
	 aDJHNFPqRrpMRK/OepMEbHln1ZpOT48VHQmZ+pbUQvke+2Tsy8fiufQGEKIyYPLqJQ
	 SXUGaIoLfGjHNEUZHznB+oZLgBMeZNoJA48cqZty91TcDYUc++fFYA668MOD0J+iDM
	 4H1X1G9Im2M+YeCJH8vrbxUnXovfVpSbmdvH3indMAIB3sZ5GOQEX21mVtdqqs9ARg
	 JvSQgy6uw4pDDRw8G+P61Al8j4Yr0ViOm6I48rVIO08aOXXvDHCngKPWtc328diBhJ
	 OhtdMqoP+jXTQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2C9C71159;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 14 Jun 2025 15:35:56 +0100
Subject: [PATCH v5 05/20] dt-bindings: mfd: adp5585: document adp5589 I/O
 expander
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250614-dev-adp5589-fw-v5-5-7e9d84906268@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749911835; l=3683;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=beLTP9GDditX9ha6QitAuUXi6px8/CxhIbNd+KVg+k4=;
 b=yBAsWNaPzXJZWIGr7c/x8rqLZ5i/sL6MJE7GMWMMjU4Pr3tiJDcTHisY0jC6eRmnyFigpx6Ay
 W8WSaBLrDckAlIoNZjLk7L+x7lGb2eG9cN4t5StZFD9OK+V/mp/K/SD
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



