Return-Path: <linux-pwm+bounces-7012-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE63EB218B4
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8973A18839C3
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4636D2E6121;
	Mon, 11 Aug 2025 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLCoRPoR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A42E6102;
	Mon, 11 Aug 2025 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952498; cv=none; b=R56jHmSTPaUtPexVq+zyIe9ZDng7oTUqPNadmdWY7Tseh3uLf3lmnw0wpT+kSw/6/4Mi2E4xQ7yD/VQmd7bnFw5PsX0WVW99Roi3lwNQd6UUwR/lhmNtqpiBiHDazuMJR7MgMhxCfrts9kyDIWV9OrBNVHNiQ+2055FewHuby0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952498; c=relaxed/simple;
	bh=Maf69irc9Jfh0p1QrcCM4Y5PKCuqx2oMXie44/wihiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fHJ5yynREcjouZZsp21hA22yPM3X1w50VYWF7m2iSmsBjXRF/D5vEq0uwxF/42bWKjaBjf7A4ciRU7FQejtxnx9WINSB15ZAGDxsTRXXxpK3NhjW2/jkwoSOzFqUpdNETi69iplBkjaZgp24VSYBCZSExFVyMYCAd2e2noNn9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLCoRPoR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459e1338565so45531885e9.2;
        Mon, 11 Aug 2025 15:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952494; x=1755557294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9S0gh3D1sziXY6ibN484oqc+CnJbOON18K1NzgX5Pdw=;
        b=YLCoRPoR93+Hiu7aWkWDB1VUmJXjfxF7wPG/zguYaXitdwzvsloitvrDcMNcJuls0/
         wXDhW4eIi4kb3ov1A+bn+dXa9DFS1DLZEn4P1LY3eG3GCntBu8pAFQopZ7J7hohdBKh1
         aNhsOBAJJOjABsjlWzTNU4kXTYQTjNpDPVM8QAvef5oULlfcmITpCV4xhN/iz2O0Dyi5
         nGxKD6W4woJLj56SJYEq+DeE7xGXdyi8Nab/2cY0l+ZbO4UF74RKntRdibHbxBPtff4T
         Nos9ISSSH9AOe/u75AVnp7BTDb5/qQbHtd+4uC1LFeQWgf5f1dDi83AV2vrM0MnZhRSZ
         p1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952494; x=1755557294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9S0gh3D1sziXY6ibN484oqc+CnJbOON18K1NzgX5Pdw=;
        b=NzNXjHOJKV8ZfZKmWaAZWNGdEYGnKQSsElw2NnCuQcFZzCYfZAHPx1P2394v8hbVMh
         u6j1/jTaGXzmdg9qYRoaMTMkbU8f77kVGOUi1Sv+I25B6N+jC14VSdFVWdbRsi18C3Xu
         Pek/3KTRNEvlyKhY48ojW2S2B7uizkpPUG6u7EdfhUD+Gm8SJo07IdMUCQtQngmKE2BG
         IHmSDqi3/aUIOqyUNIq9/ybDInwLwVOlNVLJ9fYsiArvMPWYmSi1ZFi5/kI0dIXzbRjT
         KI/gs1ZvMqessDj3/6xOCbLR9DT5P/Si7PA7XnXc6alORf/AJpyzVINMVEmNVmtBgKYy
         oNpA==
X-Forwarded-Encrypted: i=1; AJvYcCUFOM4MHwGi+Xra+vW2DgtptTRIk00U8biXRUJX6aKiHoRLxsZ6kRIrI3TRpSvR2wP95l+789jeBGcD@vger.kernel.org, AJvYcCUmNFuXa4EsCg2I+OTaltGJ3wGl8QsO5IcwsTMFYTBpT24Dg6xQ+VKDyfx3liSxgmuEGLVpmV+rsGbQihw=@vger.kernel.org, AJvYcCVl8DbCHnd0NiNeaBHs3R6ujrA96ZpmPIDM5Z8uiXylddR8m1xCMMZHovNPnp9WWWgL8gz09YyyWeNzFVs=@vger.kernel.org, AJvYcCW1+PilE0qz3XHhRafFPImVxHEICeo7PC3qOg24RxJBUo8VTvknYvkizqdxtSGbRY5GyVxt+kIMfllS@vger.kernel.org, AJvYcCXnCsnQFSvMgC+IQjJYVq0oB2IHxUJH3YxTE0GA2hGTKNP4mFpIYLVrD+QwWdrx8I1+/XgKoSIBzC1K@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcwd8f3pOtlC0PI4pqiMMr0da7+LHKEJNQ1QpyOa5J4rYEyf2H
	/kIo21CvoGqQ9IdjmBBSjF8VPBk5iQQ96E83TeALAarfSR5FSNtXZynZ5jh6e/4=
X-Gm-Gg: ASbGncuAAsg28Zuua+hQdZMgqfwndTF++o/1LJKtSRDE6k+jOGhFJWMxE2D9HWbOPtC
	+uC1YbqnHYYJHZCkQh15eoNpHkUAOAgUPYDwSFz7mC1PFVUn9Bm6NLM2BLepyOErGYQsdXqbln7
	xO+YNOkcNhCtSIg980XnZw27m6iCn7AkJKFLKzhJQmXgX1XkuxSh8cCgzFFsUGvl3ZvqnsN6LE1
	VNVSpNQkTG2cDiRbjmhF7yd0KFPq6jvrdZ33Z/hHVetNjderLcnjZ8xSNm0S6CozQofCSRrslaz
	/uwTe5LMgvSXAqnZBcPcRgVD8NPkIvSP1oYjjd7esTsa1spkS0aOLg1HpyHXSM+hdStEUs1824T
	RtfXo3BtGpn3nT18ZR85CERs7RDBQ715DiGfPVE4Udn26bnI=
X-Google-Smtp-Source: AGHT+IEq8Qtq1Ahr1t13doc3VxUksvFe2eVGY19U58nWLkRbHqGdkBpR0wPKGFAVpLx4YsezlHTVdQ==
X-Received: by 2002:a05:600c:a03:b0:458:bc2c:b2ed with SMTP id 5b1f17b1804b1-459f4e9e7dfmr127460095e9.7.1754952493912;
        Mon, 11 Aug 2025 15:48:13 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:9b35:8c56:5611:71e6:ca77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm343678175e9.2.2025.08.11.15.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:48:13 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: peter.ujfalusi@gmail.com,
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
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH 7/8] sound: dt-bindings: ti,omap-twl4030: convert to DT schema
Date: Tue, 12 Aug 2025 00:47:38 +0200
Message-Id: <20250811224739.53869-8-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the legacy TXT binding for the OMAP TWL4030 sound card
to the modern YAML DT schema format. This adds formal validation
and improves documentation.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../bindings/sound/omap-twl4030.txt           |  62 -----------
 .../bindings/sound/ti,omap-twl4030.yaml       | 101 ++++++++++++++++++
 2 files changed, 101 insertions(+), 62 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-twl4030.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml

diff --git a/Documentation/devicetree/bindings/sound/omap-twl4030.txt b/Documentation/devicetree/bindings/sound/omap-twl4030.txt
deleted file mode 100644
index f6a715e4e..000000000
--- a/Documentation/devicetree/bindings/sound/omap-twl4030.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-* Texas Instruments SoC with twl4030 based audio setups
-
-Required properties:
-- compatible: "ti,omap-twl4030"
-- ti,model: Name of the sound card (for example "omap3beagle")
-- ti,mcbsp: phandle for the McBSP node
-
-Optional properties:
-- ti,codec: phandle for the twl4030 audio node
-- ti,mcbsp-voice: phandle for the McBSP node connected to the voice port of twl
-- ti, jack-det-gpio: Jack detect GPIO
-- ti,audio-routing: List of connections between audio components.
-  Each entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source.
-  If the routing is not provided all possible connection will be available
-
-Available audio endpoints for the audio-routing table:
-
-Board connectors:
- * Headset Stereophone
- * Earpiece Spk
- * Handsfree Spk
- * Ext Spk
- * Main Mic
- * Sub Mic
- * Headset Mic
- * Carkit Mic
- * Digital0 Mic
- * Digital1 Mic
- * Line In
-
-twl4030 pins:
- * HSOL
- * HSOR
- * EARPIECE
- * HFL
- * HFR
- * PREDRIVEL
- * PREDRIVER
- * CARKITL
- * CARKITR
- * MAINMIC
- * SUBMIC
- * HSMIC
- * DIGIMIC0
- * DIGIMIC1
- * CARKITMIC
- * AUXL
- * AUXR
-
- * Headset Mic Bias
- * Mic Bias 1 /* Used for Main Mic or Digimic0 */
- * Mic Bias 2 /* Used for Sub Mic or Digimic1 */
-
-Example:
-
-sound {
-	compatible = "ti,omap-twl4030";
-	ti,model = "omap3beagle";
-
-	ti,mcbsp = <&mcbsp2>;
-};
diff --git a/Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml b/Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml
new file mode 100644
index 000000000..3124320d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,omap-twl4030.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments SoC with twl4030 based audio setups
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
+  Bindings for audio setups on TI OMAP SoCs using TWL4030-family audio codec connected via a McBSP port.
+
+properties:
+  compatible:
+    const: ti,omap-twl4030
+
+  ti,model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Name of the sound card (for example "omap3beagle").
+
+  ti,mcbsp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle for the McBSP node.
+
+  ti,codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle for the twl4030 audio node.
+
+  ti,mcbsp-voice:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to the McBSP node connected to the voice port.
+
+  ti,jack-det-gpio:
+    description: GPIO specifier for jack detection.
+    maxItems: 1
+
+  ti,audio-routing:
+    description: |
+      A list of audio routing connections. Each entry is a pair of strings,
+      with the first being the connection's sink and the second being the
+      source. If not provided, all possible connections are available.
+
+      Available TWL4030 Pins:  "HFL", "HFR",
+        "PREDRIVEL", "PREDRIVER", "CARKITL", "CARKITR", "MAINMIC", "SUBMIC",
+        "HSMIC", "DIGIMIC0", "DIGIMIC1", "CARKITMIC", "AUXL", "AUXR",
+        "Headset Mic Bias", "Mic Bias 1", "Mic Bias 2"
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    items:
+      enum:
+        # Board Connectors
+        - Headset Stereophone
+        - Earpiece Spk
+        - Handsfree Spk
+        - Ext Spk
+        - Main Mic
+        - Sub Mic
+        - Headset Mic
+        - Carkit Mic
+        - Digital0 Mic
+        - Digital1 Mic
+        - Line In
+
+        # CODEC Pins
+        - HSOL
+        - HSOR
+        - EARPIECE
+        - HFL
+        - HFR
+        - PREDRIVEL
+        - PREDRIVER
+        - CARKITL
+        - CARKITR
+        - MAINMIC
+        - SUBMIC
+        - HSMIC
+        - DIGIMIC0
+        - DIGIMIC1
+        - CARKITMIC
+        - AUXL
+        - AUXR
+
+        # Headset Mic Bias
+        - Mic Bias 1 # Used for Main Mic or Digimic0
+        - Mic Bias 2 # Used for Sub Mic or Digimic1
+
+required:
+  - compatible
+  - ti,model
+  - ti,mcbsp
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "ti,omap-twl4030";
+        ti,model = "omap3beagle";
+        ti,mcbsp = <&mcbsp2>;
+    };
-- 
2.39.5


