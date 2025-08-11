Return-Path: <linux-pwm+bounces-7006-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF210B218A4
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD183B7A5A
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CC12D876B;
	Mon, 11 Aug 2025 22:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqx0mqsq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C641F948;
	Mon, 11 Aug 2025 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952476; cv=none; b=dLTg07Ojh7FYZ/rWr0R6txmXWGmnS2WQIPnfTVRdtAHw25h6IMtZfUdY16pe4hTtrJ04e5lEHUdYEml60MZ15rmMv/cmLuFNVdecTjgZ8Cwc+EKLjhvnqc68Pfbar6zPJNpwr6Sf3pZ46cl6Jr+I/QBx/UZGIoBT/LjF4GYVjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952476; c=relaxed/simple;
	bh=3fMs0gu71XBaEqJNnizVOUz+v+B6NVErPlhRL3FCrsE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYT7g482r7qvEJyQuSM3A5wErVZdI9AE7msfUQZJsdJyLipUXlZTOoq4g1clX7ZB+a1GkmTiqxmvh/X3/OCYeS0lQNXRur59ozny+sRKVD8oCS2R7rq6OLp3I7eD3bEeJl7/jBHkVNNyTBhmCflXe0WwABVhYvzOboxqQ8oNA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqx0mqsq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459d7726ee6so24850135e9.2;
        Mon, 11 Aug 2025 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952472; x=1755557272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzCqX2ZYKYTo3ekNGO+LJq6k9fCVha5OiU2+WPRizEY=;
        b=hqx0mqsqqO+KJCvuAaTb4c/dk9YNaErvP2ZlHuTvhYZ+GuZGUfQAa0/a2WFYkw9wPP
         cpyigmf4z3cx0YeeeklzAx8byPewZmRWialIAxMHXYnRr3lOJO1OS3F6jGs07N32ucif
         w+oQn8dKSJaW1WuL4yja62Yn1rUFFsySW/gGtDo1l8JBEjxzqUEqA01mP5d9Ty63owlD
         Z36y0Pbd+aJn9Uo4juwWcBAZhC9AwkJ/zp3wTI3lbOs0uwbHlNCRMEp++Hxd4STkaqJ5
         BZRFLBps4aHCn+O5gfEY4Rw5tRrd+9Q2OH862D3NiadvyfAxEbMrmn3zNcguP01YuO7F
         jOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952472; x=1755557272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzCqX2ZYKYTo3ekNGO+LJq6k9fCVha5OiU2+WPRizEY=;
        b=UVuchHs0RaQwf5Y0H2r6jqN2n9AjEyROr7sj+fz19bWR/rOVsLHttIFZfwlpO+HvFw
         oVZO0PkL7Naunh9m6EmDv5KHbCEV+agYU6kogHi5TXuO/C4G86mXGxmCMQH1ewjaFgw/
         VfcoO1jvfewW1PRUnJwj3PC5tMcSq0iWnRY59x10PHX76tRuazOz52dfkw49cXo/3MRm
         ZhKmCi1jfYNAJfUM/td5ly+KwbZipUfHkf35sGFGr8VBtzpmABG+Yxw3k28zfpuZb0K6
         9EldpUFyfCQ2QbbJBeengvpgDNPE+/rtJmNZFs74YAcfGY/My24xiUmuikhotUEsYedQ
         HjeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6THN0mLU4glk/HshcbfPJRBfFQ0Hfuuywk5c+BnQX71DUbFZhKYqI/enxwDJDw3qPUKdYOxk73RsnCeM=@vger.kernel.org, AJvYcCVtDdqNpUWy/WBdVtpd+zpLktgL4Ciuu1uwtfCTmSwSoEkgLDH/PvC6kPmpcz7jAegzYAc4gAAsWV3r@vger.kernel.org, AJvYcCWSvbVSvdGmkgLArvRgIVMI65NP1TSznQYpKbzYfVFa3HoZD9qFdzsymVKUHwyIyv3f1ah2yIL0ZgUj@vger.kernel.org, AJvYcCWjgCFEFaNP+hpyPao/6joD+ByBzRfhbxl2rbizNW8W9eFnnbkxeHE4fDd9aN86mN70Er9y2bKIZbOYCn0=@vger.kernel.org, AJvYcCWxlAFg6Nju3nSVXlj6qId/s8pYOoXn9huRHGRsIO3mDHvoKPmwNVHbB4G3TytuULQj2QiLQwwRmDXq@vger.kernel.org
X-Gm-Message-State: AOJu0YzYm86cFScY3RUWvMUpUbbiR8nzzntImm8zACg/DS21BAxzI9m5
	Gye5L5pYZUxebliiGurSlejbMT9UK7dEo32o7BuT1DFVPzAacd/jttD0ac4uNx0=
X-Gm-Gg: ASbGncsWcOa2K5Cs02uVHSpKmCgV+5kbu/saFEyvBu6Kz06M7sG+2h0yS42I/zQWAhZ
	V9P7MxzE1VHpnMgXdDOvmdJI6anC+Zqqng/qmaIqCQ5iaxW6wO3NEjbPjQQyDqVFF71T2FYlXxb
	Bv/ZqUnpc6fBaoTL5C2I3401ceKfOBBdjOPhyl+xRQJY37QUX+0Q4/2H8BcDU7EfURVaFlCFQtj
	AFgmg0fftM5vF0J5Mjl9vROyzCgci3ovOZzXzxjoM46mdOypit+5jrZdmxuKdOEiV8AIUKJkUeX
	bjv71GxIZYUjUFCjMJyVDPGfLPSgqHHCbRJHJPL00zziRUd75lKN58kmeoaRIutBnevDLmUkU6J
	facxdMltZEmY7ysimGem/yJNLUsr6BIT0dbYmC4+L87gEutgzp5+gRUgILQ==
X-Google-Smtp-Source: AGHT+IFWzxJ+g5eEcsxMCd0lwXo+vaBOu8AhH+amFT8iqogah3uVpug/+TvyZBOzuUBBVpCx/oayLQ==
X-Received: by 2002:a05:600c:3b8d:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45a1161825dmr4761515e9.10.1754952472284;
        Mon, 11 Aug 2025 15:47:52 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:9b35:8c56:5611:71e6:ca77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm343678175e9.2.2025.08.11.15.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:47:51 -0700 (PDT)
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
Subject: [PATCH 1/8] mfd: dt-bindings: ti,twl4030-audio: convert to DT schema
Date: Tue, 12 Aug 2025 00:47:32 +0200
Message-Id: <20250811224739.53869-2-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the TWL4030 audio module
to the modern YAML DT schema format. This adds formal validation
and improves documentation.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../bindings/mfd/ti,twl4030-audio.yaml        | 91 +++++++++++++++++++
 .../devicetree/bindings/mfd/twl4030-audio.txt | 46 ----------
 2 files changed, 91 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl4030-audio.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-audio.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl4030-audio.yaml b/Documentation/devicetree/bindings/mfd/ti,twl4030-audio.yaml
new file mode 100644
index 000000000..16ddcf007
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,twl4030-audio.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,twl4030-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030-family Audio Module
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description: |
+  The audio module within the TWL4030-family of companion chips consists
+  of an audio codec and a vibra driver. This binding describes the parent
+  node for these functions.
+
+properties:
+  compatible:
+    const: ti,twl4030-audio
+
+  codec:
+    type: object
+    description: Node containing properties for the audio codec functionality.
+    properties:
+      ti,digimic_delay:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Delay in milliseconds after enabling digital microphones to reduce
+          artifacts.
+
+      ti,ramp_delay_value:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Headset ramp delay configuration to reduce pop noise.
+
+      ti,hs_extmute:
+        type: boolean
+        description:
+          Enable the use of an external mute for headset pop reduction.
+
+      ti,hs_extmute_gpio:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description:
+          The GPIO specifier for the external mute control.
+        maxItems: 1
+
+      ti,offset_cncl_path:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Offset cancellation path selection. Refer to the Technical
+          Reference Manual for valid values.
+
+    # The 'codec' node itself is optional, but if it exists, it can be empty.
+    # We don't require any of its sub-properties.
+
+  ti,enable-vibra:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Set to 1 to enable the vibra functionality, if missing
+      or it is 0, the vibra functionality is disabled.
+
+additionalProperties: false
+
+required:
+  - compatible
+
+examples:
+  - |
+    i2c {
+
+      clock-frequency = <2600000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      twl: twl@48 {
+        reg = <0x48>;
+        interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+        interrupt-parent = <&intc>;
+
+        twl_audio: audio {
+          compatible = "ti,twl4030-audio";
+
+          ti,enable-vibra = <1>;
+
+          codec {
+            ti,ramp_delay_value = <3>;
+          };
+
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/twl4030-audio.txt b/Documentation/devicetree/bindings/mfd/twl4030-audio.txt
deleted file mode 100644
index 414d2ae0a..000000000
--- a/Documentation/devicetree/bindings/mfd/twl4030-audio.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Texas Instruments TWL family (twl4030) audio module
-
-The audio module inside the TWL family consist of an audio codec and a vibra
-driver.
-
-Required properties:
-- compatible : must be "ti,twl4030-audio"
-
-Optional properties, nodes:
-
-Audio functionality:
-- codec { }: Need to be present if the audio functionality is used. Within this
-	     section the following options can be used:
-- ti,digimic_delay: Delay need after enabling the digimic to reduce artifacts
-		    from the start of the recorded sample (in ms)
--ti,ramp_delay_value: HS ramp delay configuration to reduce pop noise
--ti,hs_extmute: Use external mute for HS pop reduction
--ti,hs_extmute_gpio: Use external GPIO to control the external mute
--ti,offset_cncl_path: Offset cancellation path selection, refer to TRM for the
-		      valid values.
-
-Vibra functionality
-- ti,enable-vibra: Need to be set to <1> if the vibra functionality is used. if
-		   missing or it is 0, the vibra functionality is disabled.
-
-Example:
-&i2c1 {
-	clock-frequency = <2600000>;
-
-	twl: twl@48 {
-		reg = <0x48>;
-		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
-		interrupt-parent = <&intc>;
-
-		twl_audio: audio {
-			compatible = "ti,twl4030-audio";
-
-			ti,enable-vibra = <1>;
-
-			codec {
-				ti,ramp_delay_value = <3>;
-			};
-
-		};
-	};
-};
-- 
2.39.5


