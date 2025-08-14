Return-Path: <linux-pwm+bounces-7050-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8875B266F7
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD921CC2160
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0FB302CC6;
	Thu, 14 Aug 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj0AGD4l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEBD302773;
	Thu, 14 Aug 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177725; cv=none; b=m6RsQGn52jqdbVd3BCWwP4Owj3zmq86EOlxRld9RaFqtX8fz2wy7Nqg/MVKLN8GSzOzM01TF/5UU3VlblnsLB3YzhZiMcwKEwVIckxpdRn+Y7oiX4ClmkKMWlFOslL50bM8Zh5hAh5nPNCe5uIucWXY54ahFJVWQdTRO/ldqMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177725; c=relaxed/simple;
	bh=jqnXnZp7RhpL1YMBGZScNoAkw+LmKGjT5H9FKCka2hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ITqT8mwt/Jonk/HRFBtbHcGhbIpisiEy+RU+NnpkqbFCx8CztBJz3qyhLxhlDsz+cg6WK0zgKghYMbe9EFsWLfqvRLlT9dLE88RW1LdJ2QFTA/M3Eyqo87pxNCytdcikmJShJmTgIygj2wu0Gd9JyvTfiTUBDj+uowEwNkoQ5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj0AGD4l; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso5124035e9.3;
        Thu, 14 Aug 2025 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177721; x=1755782521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMz0z0NTwoZNKGW97tiHCixZ/UdB6VOtCFJYznUWSlI=;
        b=Wj0AGD4lyKn45YgYVpTvrUK6/MrusNG8GvH+5BALBqtQEDFCWzfg1CX4f6fhH32q98
         qeGAIWmtBrsynn1nT9NmGO0nRyJA9EOJVwEjmpxCLTZ27PIaCzzfS3NT3lCXuAPtNcwz
         5Uohl5hojHTgrZO+XtGAqt6LlU5PdwI1EcF9asp40IiCbS8y/4mi/FYgfyDL75nuaCjM
         y23hJypIaWdYWP1nxMpYD1WrLFcCjJCF2YD2/E9rQ8cUC6gmn05JyBJxr+wrjyKZT7qM
         3Aa4cqSv5MBrFbXuhqVAm9c3fXjhQRHwdyrBvHx/tkfImiguegw/zMUsf6oG+NUPf8rh
         hSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177721; x=1755782521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMz0z0NTwoZNKGW97tiHCixZ/UdB6VOtCFJYznUWSlI=;
        b=Aib/3GClHXYHQK2fRALxvOmJ+0I9OE1hM8r41pcYQzHMrM+GfLaUPd4dMi/MR4ex1m
         Wr8EUFyZR+RUQaxyudxauaMGIBpISc5XXjq36xTsc5SAh9u6aYOsOXTRGOfiAkEqNdLh
         mmH+h325irF7l0/95G0mo0HfwZ6CLipfOODgUE7EpKCP4eTEKasnMLrbfUMsKqB0lSDE
         4EBC0/0PWTxsVZG89IAoyCIkiw+tyw/43yB15UxucnzE9xnDq294JOFPWx+kIQGwxw6+
         yHQWgzjJuBaDG6cdDXEaduG0K/LvMtrlBpD+v3UhutDw4FA4pFWxtVmXmodsQvTQBSb8
         FkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFupDUrXs5WsImSsDBmIIkXc6kuM7H6xHPjZzVQsSCrGKGLlMKrwqClFwLdNi8GGCGSYSnF7MVBgEFqUg=@vger.kernel.org, AJvYcCWT0dMcb0oPgQ4RKKyBGqYHkhNRzb/pElj2BUOBisGUwasBxt9GiyXhLpDYnewmoWatJuZt6i9ZScLJ@vger.kernel.org, AJvYcCXU4lwt1rvfn+1H8dvNLLUEd0wpDxXfrDjD2A4NTqh5ntsRyuuC9yezEb8MYIvdQ9dXvm6N4b6yJS2p@vger.kernel.org, AJvYcCXl3WGGjLszSBhXPMq8XwiVWkQZ7AYNOIz03jrfY0onB1Jl2Ww9vQgEd0dlA1G8/yDqhMTgpBUbavOVDyo=@vger.kernel.org, AJvYcCXlA4cV3yR4c87Y7z3DmFlQ8X4awuRmV/jllEpnYbrbqJxUAJ5rPMIcoXMUvIYIcU8qE2h+hNjDnttg@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjOsi8y993u+7e/AishprKgE0CKT6Uizh6aFh8ankmTwxppl3
	ZryqMmJ7ylG/kHe8Oy224i5RDU9LN0HdkYu+Xe7xFV3kPxFcBsog6gf9dmHT
X-Gm-Gg: ASbGncsVhYh0qjI6L8oOdR3wgMKhfO8WUg7JECAlf4q+cmI3l35lUfdLGo8pCZyk+Wa
	nCLfKsAqkWSyr9tk9deWZj7/QJqknQ26YkWh1bRh0bjCCqk8fbeYI0hPEQbhzNjs4pioxgL5rK7
	T7d/rQjE4Ov6MWSbsHbTmb9lkfFHB/Imt+ZF9zFiyeNtYLsbMQnhACKd/QuDL35q6yVO2kPqZjx
	+aasxc4CzVBaa86b1r7gJ1PwWHDUdPnNlnXWSmMb8JJmDvEWet2daCDqkvR+YwUduKWHmoqWTtP
	+1QyeX6XZdjpt85jW10ruh8P6uQTW2A5GywS785MFFym/L0qcgO959cgwyd9vbTomwMhrw6r6ed
	jgDGKqY7hyd5LvbNQwrK+0758Hm1ehp+TEkmz8KWtLlvOVzPY6b6mmJkY/3c7D4sF0hceJ8F2Th
	srRpSDHOhEDP5p/TxQdllvink995c4QkZP
X-Google-Smtp-Source: AGHT+IEhoPp/GvoE0/G8qvem1zpvto20Ky61lY0ZUidud4Xnsxob/d04gPyLQTwmNSdaWYCSyuFzQg==
X-Received: by 2002:a05:600c:8b62:b0:456:1560:7c5f with SMTP id 5b1f17b1804b1-45a1ce34c75mr19212705e9.14.1755177721062;
        Thu, 14 Aug 2025 06:22:01 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-658-1-96-160.w81-250.abo.wanadoo.fr. [81.250.250.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm50998831f8f.18.2025.08.14.06.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:22:00 -0700 (PDT)
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
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v2 7/9] Documentation: omap-twl4030: convert to DT schema
Date: Thu, 14 Aug 2025 15:21:27 +0200
Message-Id: <20250814132129.138943-8-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
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

Changes in v2:
- Fixed comment formatting (added spaces for better alignment).
- Updated commit subject to align with subsystem style.
- Retained Acked-by from v1 as changes are cosmetic.

Acked-by: Mark Brown <broonie@kernel.org>

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
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


