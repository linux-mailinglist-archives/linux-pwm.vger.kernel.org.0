Return-Path: <linux-pwm+bounces-5158-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FF7A5F77E
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DC63BD530
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD642686BE;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb956yzY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17416268685;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875558; cv=none; b=nUHMVO09h4h6ZogxXvYLhJ2xIMwokZHo2PrL5zbxX7Al6FbJneeIGCGWyF4y2TafMJFTU3l/TDln/Sh6vIwTJ0zYRfFhzkgLbD6YIgKvibs3QQLXnBSSoAeOck+Ux9FwGP6qt7BES374GPJn/BamP+KeebR0iT/v1EdCk0mjlxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875558; c=relaxed/simple;
	bh=ZuPpUZrWrIanIwjB5TcqWxXnwChpucCUCkIsIN8Afz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dS7mWMoHOXrQPGTq3Ih24e3nLGoHWIdSymunq1Wgd2O+0OARMBf7q2EmCK667pQtwUSbq2ev74/OOIhbVEwNQ2stu8oDyFeMIxe8l31wSU7QzRmRZsntNvgGBcdCh6bOkc7hUcXFl5SVYKZVB4EdyuuuO9PONTqflc1LMGgJQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb956yzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92AC1C4CEFB;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875557;
	bh=ZuPpUZrWrIanIwjB5TcqWxXnwChpucCUCkIsIN8Afz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Tb956yzYhKE96yA+MRPFe0aFg5tGxYgZnyKay7GU/dVlsDUpIwPrnzHb6tcUyh8kT
	 2RVIlKbHTtSe7KVD8uAy06a38yhmw/5zIEURNcklWU1Po9Po4rYq8Gk9k2hw7gb6aR
	 0DcwokjgkV0mj7mWVRQrUzDEuzlb2r30u2g2KzW0DX38NIZvOw7w/Hv+8/cjsErnvz
	 8eDBfKtcvtYquvNgQ+jljbUySNLcC/D4qW8EBhBOTB2QV6mHHkdBSbAEELJPW74QF0
	 Fs3OVIv+VfEOdlOzJhvXW0Oqxdrcxr6Pk/Nh5q+Ldd0QWf1d/uW2zlEWWmaXVn4cOB
	 we81Z0X5/Cjog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AB2C35FF3;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:22 +0000
Subject: [PATCH 05/18] dt-bindings: mfd: adp5585: document adp5589 I/O
 expander
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-5-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=3546;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=rrvfmHEXd0tTkBviDQann7NZgieOZ479PPjxFhfnUAI=;
 b=0uqWM3h49M4V7Pzhax4lfh3//ckEIRqpyBwLyN1l8NQd6sY4WeVMEaInpstcHCyJ0LfiMnPiL
 Zx5S8OSzv/KCsS3i9uCFOkB7Gp8qdsJQgRbNO8SM+yxjgoLiOIWdEPO
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
 .../devicetree/bindings/mfd/adi,adp5585.yaml       | 48 +++++++++++++++-------
 .../devicetree/bindings/trivial-devices.yaml       |  2 -
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index e30e22f964f78519b2ec207e9415e4897db5c702..87256a37b5f4b6a019f581b164c276d8805d2e52 100644
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
@@ -63,13 +70,26 @@ allOf:
       properties:
         gpio-reserved-ranges: false
     else:
-      properties:
-        gpio-reserved-ranges:
-          maxItems: 1
-          items:
+      if:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - adi,adp5585-00
+                - adi,adp5585-02
+                - adi,adp5585-03
+                - adi,adp5585-04
+      then:
+        properties:
+          gpio-reserved-ranges:
+            maxItems: 1
             items:
-              - const: 5
-              - const: 1
+              items:
+                - const: 5
+                - const: 1
+      else:
+        properties:
+          gpio-reserved-ranges: false
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index fadbd3c041c8c39faedfe62874d4eba25a0bf30e..bdf0afb9301181b3f95fb7125302304834bdee94 100644
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
2.48.1



