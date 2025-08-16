Return-Path: <linux-pwm+bounces-7074-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6175B289E5
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 04:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A0EB63613
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 02:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D0B1D63DF;
	Sat, 16 Aug 2025 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/JR2mJg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209CB1A76BB;
	Sat, 16 Aug 2025 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310704; cv=none; b=BCdlxtAzY1zfXzTZ33OJK2/jiZML/c1fvPLpoRN30ghGbAyc3zS/rkoxOQ2MrSgH9xRRgMgZLqHep4ljuOr0azT7Fo3KRmDJhV8N+GySPRRyZLDZ1VP7WSxLyFJHaJzVxQenyx13ppyHlWqZul6HzfdtUuJ+vMftgh9n21OXgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310704; c=relaxed/simple;
	bh=jbZCunKxRmzW54eRdGFMx1EPI04q2ckQbFHtdWw4rVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gartge+ReCqe/A1LB8rnQP97qIourNkS3ZWOv2cXn2PprNuhDrXKhWV85FZ41uzwe+Ly2K1NMyLQ55aO6BdXMcx2iqAksX7n/KlwwD/BNsd+YNQMiu3IStN0gSuPBbfdtMZIz6sp2J5WTEbkXqatJ4h7eFcdtoSK/X89b2wKd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/JR2mJg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so1357653f8f.3;
        Fri, 15 Aug 2025 19:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755310700; x=1755915500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZN9bP9H+qPp8fpqZRzlhEjRrMc4Qa6tjW94WuAua4I=;
        b=i/JR2mJgQAXhOqttvwsxQrqkbIORWlTYov+byemXw+DQnPcfadWv+020C8BND8xVqW
         QEopCYAHoL3ifvHRgNndGc+jlaFky0bYw9al4+4J6xCDEmDvQ5K1w3Le2XXNZEKQh+vd
         g+jo9s17boyPpOZKhorRPRdZqOJYIz6r9qGJ5tmvfjzC9GtoFWGUqlQqqQwXLChU6p7N
         weiFoO002xXIta4JU/HhIUPeCXducIuaSJPHH0fDeK09SthW4mW2pmtJmwtmMe6a9RJL
         ttDsU0dXSpKIQGwYT5LcnbS279M4zP6zvKD1PCJg5ezvgjyE0yi7ubLV2I81PwLHBlqt
         AesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310700; x=1755915500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZN9bP9H+qPp8fpqZRzlhEjRrMc4Qa6tjW94WuAua4I=;
        b=qT8Eqp3gIUAhRDd/QWi5ynFIFYcjGdvI3uev1Pm5pl8gzrOQiTwLaPRaqNOah1ZMkE
         +D8gF2DEAhI0CU3fOeLwduBlVuyCqqVlBhuAvh7ltTsQsPTOD4evix/ReHTIN925Ok14
         4upICifHMmZ5UG2BDnNpsUBpNE2b1XImD/dWQxuOhyPEIFtMWAKz3vcoHVLQoZ7E6XBb
         fjgBQV8D6X4zIclE+BwJ5WknZP00gVxEJvEctuZCJvzcknOCO59EHphv3eEEOJbtVmOv
         mYP70jLmVauTf2USU1hH6zn3zcKRVwJDbbDcn8hIFleGu7BapRivtwnFGgbQ/0dgeX44
         igHg==
X-Forwarded-Encrypted: i=1; AJvYcCUjyuCSRWlqWpVY+aVlhCZ+RRtn1JZPuwTu8g+og8Pl4Xqq0N6YHh+in6CEX4hvH+8G2uZR8dKPXucx@vger.kernel.org, AJvYcCV1gvVy7/hoCN3c0zjtJQ4a5xkNNUJCKug+D+yq7DzLhXuOFxhnoLkxayOOsJtD670KLF3rrJQGXgZDpw==@vger.kernel.org, AJvYcCVoVvnaHX/K+Th29Id+xXHExtjBLz5Rn23c98c14p5BPkrjk3MKmTOC3FfY0Kl/8DrD3O2O/Y2YCuK+Ij8=@vger.kernel.org, AJvYcCVscW10qr07NKHGoMpk3A5NWaKbItOnbPJQY8mHaJwAOPHIWFBBrA/cDO7+BP0PuqVLlI9cxQM58hkQrL8=@vger.kernel.org, AJvYcCWK+NGqwfEO63eL/2rh5Mxt54RmpluFQCHeGgrOafLZQ6/ER2nPp4VaIuhdt0vKjXBinZ2eBead6DsJ@vger.kernel.org, AJvYcCWRIixgm4MKG9VpFWa6nSMgfWQa/YNiT4M6SWGzsoT3jQE2giTGYs01cr10j/APnHN/1bE4i3FhGzRkWQ==@vger.kernel.org, AJvYcCWw/+f2GlSPuG2SYRu3oBZ24UBJaUWBysKLREIbCnzcgnlgjW8If6ozWtH/pwnr1DIXsYB6lkkTT6D5@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWnhFcEaYqhqNwGnJv3HTLxwI6Xjv4OMgZNfY38N5n6p5+Cxe
	Y+dUVbhm0wnsOzXyFLhVqUuNjdlvcWneAB5LOzPv4Q7xLnT7wRKcIi/fk75DJ+I=
X-Gm-Gg: ASbGncu+fFl+GScBhkv6NNtzBa4JjDL+WDZEJrEmlJtGtEphMNP2cxqjZOrguDs5R1R
	Q9LVkc9p10QiPe9ubwS7ws5knCh8sg61KGooiEJ1wsXqYzFSytqTQPTTJrrWzMD7EfqSKrwQLVx
	43woznWDxGlbz8743A9NQpgm7doRItj/a/sO5xT06PzxJUN2SMcND1O4gG9fQ9kvk0O4SEvlmkb
	ERPpk98mgJn0eL3y8NVugDidxGr46f5NbqfeoAwWDqPfwie3fsvdVb3G299P+tMMmUogyjWEKTV
	Tdtt+2ee8ja+4BzYZunaNksCI2N0oC9VMAMIpC5fh4G9Ow3L71di+H06eA74iuvz20DGx/Eo2nC
	lLGNvgnV3kdGtwTKdQw9qA3rZlrj33ACDknlWRf1FAOv2EOw=
X-Google-Smtp-Source: AGHT+IGxzqOGpcA9bTZa5RCXTgePA7Ph/aSndBF/AC3QQ3qQ11Ft14TPMYaSW2ATNY28F3G1XC+30A==
X-Received: by 2002:a05:600c:c8f:b0:458:c045:ee99 with SMTP id 5b1f17b1804b1-45a26794ce2mr5618795e9.28.1755310699964;
        Fri, 15 Aug 2025 19:18:19 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:212f:1af8:ee74:5774:2fc2:70a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1fe2c019sm58712535e9.17.2025.08.15.19.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:18:19 -0700 (PDT)
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
Subject: [PATCH v3 2/6] mfd: dt-bindings: ti,twl4030-audio: convert to DT schema
Date: Sat, 16 Aug 2025 04:15:19 +0200
Message-Id: <20250816021523.167049-3-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
References: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the TWL4030 audio module bindings from txt to YAML format and
move them to the sound subsystem bindings directory. This patch also
refines the schema by adding an enum constraint for ti,enable-vibra and
updates the example to remove irrelevant I2C clock-frequency property.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v3:
 - No changes.

Changes in v2:
 - Moved binding from mfd to sound directory.
 - Added enum: [0, 1] to ti,enable-vibra for stricter validation.
 - Removed clock-frequency from the example as it’s not relevant to the binding.
 - Simplified example by removing unnecessary I2C node properties.
---
 .../devicetree/bindings/mfd/twl4030-audio.txt | 46 ----------
 .../bindings/sound/ti,twl4030-audio.yaml      | 90 +++++++++++++++++++
 2 files changed, 90 insertions(+), 46 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,twl4030-audio.yaml

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
diff --git a/Documentation/devicetree/bindings/sound/ti,twl4030-audio.yaml b/Documentation/devicetree/bindings/sound/ti,twl4030-audio.yaml
new file mode 100644
index 000000000..c9c3f7513
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,twl4030-audio.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,twl4030-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030-family Audio Module
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
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
+
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
+  # The 'codec' node itself is optional, but if it exists, it can be empty.
+  # We don't require any of its sub-properties.
+
+  ti,enable-vibra:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      Enable or disable the vibra functionality.
+
+additionalProperties: false
+
+required:
+  - compatible
+
+examples:
+  - |
+    i2c {
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
-- 
2.39.5


