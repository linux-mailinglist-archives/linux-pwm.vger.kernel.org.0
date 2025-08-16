Return-Path: <linux-pwm+bounces-7076-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5FB289FD
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 04:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04664B6440D
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 02:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E6A1EA7E9;
	Sat, 16 Aug 2025 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzAbd55k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA921DE4C9;
	Sat, 16 Aug 2025 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310707; cv=none; b=DoR9fp066p4tBe+DxKdu3U270O8VGegng1oNnBIqHu3GhipNC52e78zY0epvMbKqEQveeH2Evzdo/zsEOJbo4z/W3kTkw5BlPNKg8kvLraPQASmitueYlIcz/gvf6yQ2KFyidne2UWmsB9+CYhP5E7uqGGGEremMYY77Em9/+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310707; c=relaxed/simple;
	bh=jkO8p+3zOrzC2yaGP5yQflX4JgF012QEpQkuYa/TkzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=soUWdYcN6bvdOtjHyleQdqw141o0BCrkNTugTPLl7IcehBoQkN6LvX2uBCw1KrLRQpAHlp8vZCAQxyIQcgsz1rTgSGyxVERLigWxLVixGFX5RrvetLTQaCBmRiUDALSQ921bScb9Yktewquu+WvLNMjiIDxZpPqoC7BsDlVx42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzAbd55k; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso17984535e9.3;
        Fri, 15 Aug 2025 19:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755310703; x=1755915503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjtdgClxqAryqHymCU6m/Gc+SPOzF3E/t04HFbVAGPs=;
        b=PzAbd55kOJhQmSIsWMHRvVYq+Zsk2RAvGL8+GgVEOK8uEiFnAns4ceVnE3W2jumMH8
         LlKxqmBJkjgZb0mgRoXwHaHFUQ1HIr/hP+72FAl7HIYU4LXIheIRla3MLB8Om8IacCA+
         zZI5kpqChI+UTV3hoem/0l/k6kC4HwRpIy3W2jTVK/AtohvUbH8Gr0wVGVnN7uuUkCJJ
         cO26a/QXHlOcXyJpP/LNnpwSLbb08jaInsEt6xx9WhqKHk/xXS19zcuFYpPLuEm1VGm4
         wokXm99qHD3BSEfDLr8a9Kpbuek+aWeEf0c9OiYmbQy0fP1e/TjARPC+Xix1/qK1Q9xk
         xolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310703; x=1755915503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjtdgClxqAryqHymCU6m/Gc+SPOzF3E/t04HFbVAGPs=;
        b=X3aVEck6jNsrXh4/wO7B7ug0DZq7oxsUzMJKAmDlnUy+1Bc9amuc2HpE6kz8xIK7gK
         E4eK7M5eic/sYP83z045QqUO+VNp7MFIp5vFFCf8P+QchDCMx72r3w4TPnymYT5lMrS1
         brkBRfX7p6Tf/U0j1afW9dQ05zhaz0JsKb3gVBVfEh4l3Gt3Pcvq42hnik7SoamZbWE8
         Upihj9SMA8Pi9mKonyljsTjM4L1xIMyALWbSDXEPP97wXjpPRtNT+oiMg4EzuzDUuMaj
         T8Zlrvi8qmhgzSOxS2VvcC+u4mp8/XzFN8vZc6d/Yk30AvfbIhvTkOjUto0KtotlebwD
         3dzw==
X-Forwarded-Encrypted: i=1; AJvYcCUL3xmvUrwiTZ6sC5RC9+hBYbC/webW/taew6ciT8qSVcULKwwVnX2NHYwT8eCsYmeIbKJ7/Hn6bXrHYg==@vger.kernel.org, AJvYcCUWXdryezWKWuomn/Pt2MyXWIiOoc6uTSQIF6XPjTNB44w3K17agmNMpYhBQY+FfQc94sLC91p2tF6g@vger.kernel.org, AJvYcCW/Sbp74B4crCsKgPwwwfphcoY49Y3yo07rYyH9cvdRZQ8Tor0JtJJzCNGD4+hP/rQNrBzUN/P41umWUg==@vger.kernel.org, AJvYcCXNF+rh3HD7ktLmFk41uPKwB2L70IiYBXv/CFcwtLERHCL8qqI3zmPBC57Rn+w9TPsOYtHMPlHT4Hf2@vger.kernel.org, AJvYcCXQDG7jFFVr3ssjZiH08PFZPgdzsE1ipc/VMPPOYp+vAe83cl6t791JmrSSGHE6x5FzAwY9Jfq7EnoX@vger.kernel.org, AJvYcCXjsWxQm9jgPawZaG0hhAXiQVhyN/kJBmlI9br0qH5IrLGi6kdsJFYxz4Iu2HBHmBo/fbfRRZOy28YGBbU=@vger.kernel.org, AJvYcCXyQNyZhxbAf/Nw0r5R58jeLjhaUHxjvLM4vWLkHE8uL0Kc5GKzgVU2kpJAPoniMIE3IbfVJiekN2hLPTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRFyjehEhx69WpgUjlT72dHnqwIkDNPgZCGOzKZjUxDfhxJob
	MxoGs6z1jxjNOJ1ie76ZVPJs40+U4ub7g3vDlB9ubJ+TTuEfzqmFuw2HR3piGGs=
X-Gm-Gg: ASbGnctpHH9mMsaV8k5x0mSKnzjQm+/WNvvliBTnrqeTG4H1/4Zd3eXgRFcwSUj6b0N
	GJxNNX2Jo6OsGPL5CU9+LNvKlbNtlf9wH9se6hM5HQkPROZTxFYfeyb5PcWRUvcTpGmyFZ8Qt39
	4U4tXoJF8OxtTlxVfcyyDIYvrXJfVjmflIxwCm+o5n+SgzKGfwI9lhGXiPLHCRtfeI/Hdvnw5DG
	juIvp9t79/7Z41zMvfDS2Ev9bXSxaqCxHDbWFzqyueUxHSY1yBvhWwFsucs6WVHrtADbfNF6Znd
	94+HkPAkd/dhu+6tvX7PW+KcLGUQHbry0jA8IRYrP6WYTBp+m0dyEmuCtOC47GbYcAAwnYU33bO
	tBmG1UCdoJV7xOfhzTNF7UuPtYXUMj6mKyemr0wqVup9jdLQ=
X-Google-Smtp-Source: AGHT+IEDpwyX1ziaBMwO3Ayd4p94N1AgBI3i3qn7uRV2GGOlAxLv2zqLhXSoifjqb3glF8hmwrsfLg==
X-Received: by 2002:a05:600c:19d1:b0:459:d709:e5d4 with SMTP id 5b1f17b1804b1-45a26e1f0cemr6380985e9.0.1755310703376;
        Fri, 15 Aug 2025 19:18:23 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:212f:1af8:ee74:5774:2fc2:70a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1fe2c019sm58712535e9.17.2025.08.15.19.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:18:22 -0700 (PDT)
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
Subject: [PATCH v3 4/6] ASoC: dt-bindings: omap-twl4030: convert to DT schema
Date: Sat, 16 Aug 2025 04:15:21 +0200
Message-Id: <20250816021523.167049-5-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the OMAP TWL4030 sound card
to the modern YAML DT schema format. This adds formal validation
and improves documentation.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v3:
 - No change to binding content, only updating commit message format.

Changes in v2:
 - Fixed comment formatting (added spaces for better alignment).
 - Updated commit subject to align with subsystem style.
 - Retained Acked-by from v1 as changes are cosmetic.
---
 .../bindings/sound/omap-twl4030.txt           |  62 -----------
 .../bindings/sound/ti,omap-twl4030.yaml       | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 62 deletions(-)
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
index 000000000..7c9371860
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml
@@ -0,0 +1,102 @@
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
+  Bindings for audio setups on TI OMAP SoCs using TWL4030-family audio
+  codec connected via a McBSP port.
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
+        - Mic Bias 1   # Used for Main Mic or Digimic0
+        - Mic Bias 2   # Used for Sub Mic or Digimic1
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


