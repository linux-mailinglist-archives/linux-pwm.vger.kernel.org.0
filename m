Return-Path: <linux-pwm+bounces-7075-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E73B289E7
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 04:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2D11B68469
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 02:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AC71E0E1F;
	Sat, 16 Aug 2025 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4CVDg1H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DF81CAA65;
	Sat, 16 Aug 2025 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310705; cv=none; b=rqWoETP5shXyMuNbQQKpzBBiOlEDy1MHHZwTSx45sGZSVcyuT8V624Tgll2BEvlBOIhlCf01n2OeZstQJqmcs8FQ4LRQ05STXCQjBz8r9b4ZJiwByLQDEaqfol1v9DqYfFInWGWcjdCBPvFxuvoNCp1TGhor94OdZzeUgekLKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310705; c=relaxed/simple;
	bh=tzbURwJlE4sv3qsrae+WruTMwS+zOGlsmhWYYQO/3dE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s1d5TRBLq/TNCbw9oTmwyX9RyhkQkjoqcED5KLUmM49STluqfvzPCOfm0OOb5V0UtA8/JNgYqCHWCfV4uT2gISF1MKBkDWfLmKN258Oe5WTFXnPo/6SLofDtBZpEJ426AQ31skGSseO3zXg9y/tBUxvJJMcam+XfZdqmhuYka8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4CVDg1H; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso16452775e9.1;
        Fri, 15 Aug 2025 19:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755310702; x=1755915502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGIyJ0TCKzvsKaDMmUW3Wdsvfi8CtjWi28UHZHisKpg=;
        b=H4CVDg1H8elpcQMuHfn2ZHdfjQ+yE3m/zRB8tfIWtJuKTrOBI+6DqGDMzYeMIvnOZ9
         5LLp25XrLxHDlHqCNPjrHWDeSpMycz1GqPLOC5jkp1zARr6yA6bM8ARE8S3MqHjxnNvN
         YbtXOg9XndWsh4mlpzC7ERb3ZdJtPys7APAyP75PmzFyyLOG0pI6Se64mEmTdktYsZl8
         O2PPdbfJtHXziqhNaXcEAENoiqfxw9oIVc3DmcK9IWBQP3rIN9vQTQ73JLxgZOqsj1Zg
         BK3w73oDDSNrhjJQjOMqES7bfGvT8tOqpBnxNudqNgfJM9fKOaD0FwTW+7Xwkwqwo9vN
         bHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310702; x=1755915502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGIyJ0TCKzvsKaDMmUW3Wdsvfi8CtjWi28UHZHisKpg=;
        b=lFCrHWOZ0ZiT+pZQ/Uso1SToCo20iQd3lNae0oTzgN6QnQ6LbgeXzZlXVPNVkMTxNb
         Bpyvb3MSlhEBJTlkbCteVrgIPwjNrBVMjNBU9tVsHrjbuGN6bFq24Xd9M9Ran/ArKHYp
         bld8d6tvr3Zqa2yRLRXtbFYnIdbTiDg2+Dx67Gk9MgNcD0xGIZeUNvMMjeEwqeh5HYd3
         wpUDN4GVEcYFRPr70ENlFIavR7eDAK+0QCFOhB+mBRqcjJEsXlZL5I6+EuDbbkkzVt2w
         c7tRGr85HMu6lLRmRP5QIRkOzrTTOos1cKbmphnvDeR/IpOl26irDx5Qmq++8PRuhEBl
         9cpA==
X-Forwarded-Encrypted: i=1; AJvYcCUOLcbP5gl1Aj1H4y6wD1WTRxr8FaTV2nxLFiFia8+MG3vWSgtGA6WaHWf7ZG9UX9rxhBLwOFsMh5mdPA==@vger.kernel.org, AJvYcCUW32tx/EfXneAntT10ddSS797LUku4LgWaJxgaJD8NO6DLUmTcUQQHS4dBK6HEh7AcaVV+Y0k4fMa9@vger.kernel.org, AJvYcCUslA+7/tCHO2aIHZNxyqtcg2p2fcrySzBZn8gaj8r20d1ZH6Zz4RkkJMjxHSaewWV3RvxBwUrIlRzi@vger.kernel.org, AJvYcCVeq5QJgAg3YtvgaN65thVDn4CsC6PIVRzKZ7xiEEcXPAPveU+3HgIU3l/FBS9Kjhedafq+an0feP89U1M=@vger.kernel.org, AJvYcCWLXrIIjs2M/GaHXDwujdB6xpqlPS4u5h3+/UdekJFn9UVYDGw8HtvnkThPQgEGGyYiuMf+XajVGY7ljg==@vger.kernel.org, AJvYcCWuAPWlwQdo+bQdLWcqZ+Qw/Y4jDM8iUKARhzAF/ajjMNepvq4SH/IEsJvSU+N7nI78clH3eAZ3t63T5tk=@vger.kernel.org, AJvYcCXiZh+s7dGHFgxupIbPtJNVFuhzqHa0ic7EH/T4un7zbIIALEnkZZL8o0ATGgcIiBc2U91fKJlSBPQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXKBZZAghTcuStyvftoohqKoeFa1NZwA8OJwF3ezxmmDD3p/a
	0uyZSgqfNY2M3hpp59IRaAfFmKqcEENFPdghfipR2WAK9YY9MGTdVw3k/gw7Ars=
X-Gm-Gg: ASbGnctgxnZhsha8bPLGs3IHUzFplivjPX4MWNPYe9f87nsX10PyraQUyd6ETlZj+lF
	tH2cj/zngPIoC7KFkNwBFKgGrFm7ilQVBeanzmnc1AiHunxFHt5Kt7iDFBZ4H3rmOyfvCS+g7Ig
	u2JzH20OqNZpeIzjqrXm4p0YBbFnEh+9s817SvBtkNC6Ny4vBqmxL/SOQb5O/LaZ3iYtI6TpurU
	9RtFQv83hdEBUy+/V9OaBsyRO2uvIDATtI1c6PZYFEyC6Jxu3vmKNw0qMRtexGM77DZzM7NbdyR
	CrwX108jwMNLe6iJyaRLuK1Fb9C4X6xXSPz1OMteHAP7OOMVHfzk0OKRhY5dlGQMeFHOuO6KjRM
	lN7PHOor+RfBCOprdaS2Z4DS2TxH0kBt5em7vxqhcGgBaUHw=
X-Google-Smtp-Source: AGHT+IEne0jj9qlJaGNIVJ3iI9oeGSARVy+s4LjvS+VakdEpY2SsAdktmDdjFPHvfEFebR7AOFYRAA==
X-Received: by 2002:a05:600c:4f4c:b0:458:a992:6f1e with SMTP id 5b1f17b1804b1-45a27151275mr4507915e9.5.1755310701636;
        Fri, 15 Aug 2025 19:18:21 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:212f:1af8:ee74:5774:2fc2:70a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1fe2c019sm58712535e9.17.2025.08.15.19.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:18:21 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andreas@kemnade.info,
	peter.ujfalusi@gmail.com,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	tiwai@suse.com,
	conor+dt@kernel.org,
	lee@kernel.org,
	ukleinek@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	aaro.koskinen@iki.fi,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v3 3/6] input: dt-bindings: ti,twl4030-keypad: convert to DT schema
Date: Sat, 16 Aug 2025 04:15:20 +0200
Message-Id: <20250816021523.167049-4-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
References: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy TXT binding for the TWL4030 keypad module
to the modern YAML DT schema format. This adds formal validation
and improves documentation by inheriting from the matrix-keymap schema.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
Changes in v3:
 - Made 'linux,keymap' a required property as suggested by the reviewer.

Changes in v2:
 - Simplified the description field by removing redundant '|'
 as it does not affect formatting in this context.
---
 .../bindings/input/ti,twl4030-keypad.yaml     | 59 +++++++++++++++++++
 .../bindings/input/twl4030-keypad.txt         | 27 ---------
 2 files changed, 59 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/twl4030-keypad.txt

diff --git a/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml b/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
new file mode 100644
index 000000000..c69aa7f5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ti,twl4030-keypad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030-family Keypad Controller
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
+  TWL4030's Keypad controller is used to interface a SoC with a matrix-type
+  keypad device. The keypad controller supports multiple row and column lines.
+  A key can be placed at each intersection of a unique row and a unique column.
+  The keypad controller can sense a key-press and key-release and report the
+  event using a interrupt to the cpu.
+
+allOf:
+  - $ref: matrix-keymap.yaml#
+
+properties:
+  compatible:
+    const: ti,twl4030-keypad
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+  - keypad,num-rows
+  - keypad,num-columns
+  - linux,keymap
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+
+    keypad {
+        compatible = "ti,twl4030-keypad";
+        interrupts = <1>;
+        keypad,num-rows = <8>;
+        keypad,num-columns = <8>;
+        linux,keymap = <
+            /* row 0 */
+            MATRIX_KEY(0, 0, KEY_1)
+            MATRIX_KEY(0, 1, KEY_2)
+            MATRIX_KEY(0, 2, KEY_3)
+
+            /* ...and so on for a full 8x8 matrix... */
+
+            /* row 7 */
+            MATRIX_KEY(7, 6, KEY_Y)
+            MATRIX_KEY(7, 7, KEY_Z)
+        >;
+    };
diff --git a/Documentation/devicetree/bindings/input/twl4030-keypad.txt b/Documentation/devicetree/bindings/input/twl4030-keypad.txt
deleted file mode 100644
index e4be2f76a..000000000
--- a/Documentation/devicetree/bindings/input/twl4030-keypad.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* TWL4030's Keypad Controller device tree bindings
-
-TWL4030's Keypad controller is used to interface a SoC with a matrix-type
-keypad device. The keypad controller supports multiple row and column lines.
-A key can be placed at each intersection of a unique row and a unique column.
-The keypad controller can sense a key-press and key-release and report the
-event using a interrupt to the cpu.
-
-This binding is based on the matrix-keymap binding with the following
-changes:
-
- * keypad,num-rows and keypad,num-columns are required.
-
-Required SoC Specific Properties:
-- compatible: should be one of the following
-   - "ti,twl4030-keypad": For controllers compatible with twl4030 keypad
-      controller.
-- interrupt: should be one of the following
-   - <1>: For controllers compatible with twl4030 keypad controller.
-
-Example:
-	twl_keypad: keypad {
-		compatible = "ti,twl4030-keypad";
-		interrupts = <1>;
-		keypad,num-rows = <8>;
-		keypad,num-columns = <8>;
-	};
-- 
2.39.5


