Return-Path: <linux-pwm+bounces-7044-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B2AB266FB
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684D33A5BC7
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A0C3002DB;
	Thu, 14 Aug 2025 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEyVvvqI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B96191F92;
	Thu, 14 Aug 2025 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177713; cv=none; b=H+KrceytWQ50qyeTJDG2F7QytW/cTy6msRC7SMO3m3hkRhM4BivkBgonRp6pN8RJkhBzkj7xH/j+k+1m2RgYD/Hi1kSDU5tJf7WrTzDpLhf3P9ftpGsmpwJQXrb0gMUbTncip1ixjn6HqgRDCf4hMltvVN+4v3eaKizxudrpTh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177713; c=relaxed/simple;
	bh=U8FU7FRkRV+/JafGQmV5sFWMXTKJjY8I/thsrRc+ED4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVjOqsTykyheC2ajXD7iZviPpgkBa8TYA4hMRHDYwHbF5nRebaT7MAvG0K9Evtq4EuI+VwGKldkKMe03EkVlfSBdG6nOqonbPJdAv2oYQzz0RCxpclsHgLL/jwfOUcGyTOPXukDatoVd0OiPB9cX0TqwMfJ//U1IxzuhwXSLx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEyVvvqI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9e414252dso466370f8f.3;
        Thu, 14 Aug 2025 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177709; x=1755782509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JU2Gp9h4czw7MJEaHWu/eIohrSz/v3NRu6dZAti6l6A=;
        b=IEyVvvqIUnTBLgPLc2EP9DlLuvSMnQW/6zaNYoDpxFwljUk4AvdhXgC9He2CzPJ3Rn
         l7cujxGhmBv4dGqbQkadcbz8gVNc1aFEzeZunhjkF+yXR1mYZKsO+PElXbs7KyD4p07R
         +6QfXIVl/4xipVIu7RklMCsSM8tbrTixZ5aVPcAFxP3n9EZhm8wliJdLb3zh/+3yg0e9
         csH6nehRmL4gJacXkzeaLdjRWiB834f0rszM6qOEfsWwPl1ZL8kqXTd0MqfWinx/EJnm
         +O3JRD6vkobA/9uuGjvwdMSN04OTYR5Bx1YLB6b/Ng+u0s+H1irVhLS5oidAOYAaShbC
         IYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177709; x=1755782509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JU2Gp9h4czw7MJEaHWu/eIohrSz/v3NRu6dZAti6l6A=;
        b=rUnKBdYDx0/TO3HV+D4mkMfn3qJrr4wn4N0MgGaN0qUEh0s4y1wLiCEIuyZRQvbCDo
         xj0oMgg86HOsagvgMaSaKZQeiakRRijJjtFYyQA5OR/Vov876t9slqh1z04kBLoEAYjy
         Vm9CLjoJNoRwIsV2yhindFSQMpqqCSEDGL21xpfAYh6sDgTT+hYZhB8aT5zT4zkM96fI
         QdT8eoxmhRnZMQuerXxY7kMsq9LLW0WfXkmaa+EL1o88Iiu5An0sPR7V7W9KpfPg9uXF
         0Ltu11YqmEM3nFzvgTAnUPxeP26WLdEzBnNxppUYaxTk4D153soiDHqMu8/esHiLXWRv
         H0gA==
X-Forwarded-Encrypted: i=1; AJvYcCVf0SfcxCkaRFZeHHgbdrzh1oBk7drggAQPFyuE0ZUO4jpsPzMF//QvMmj6NoTp8Ci9NhX+6T+ei1dH@vger.kernel.org, AJvYcCVnvJzbEc3FQAtnzy/gkcvUXVZePZ3Go1qOP777V6wNT9oCNJJfhCEcpmyjlD5uS8YjoBSpopT+EsYCSuw=@vger.kernel.org, AJvYcCVtB2L/FntcR697B4yLUKVSQndCB2SNFqwKloboPWyHEOyb2SHMDQ7As5rAFU2JndBHq/pfjtkYDOi4@vger.kernel.org, AJvYcCWCQTiTKhIUDrcqs/9K0KDxSnEEkxyAYesiDtylhNpd1JN1ylwhL8sVyyWBxr72KynepKA9m1xD8nzk@vger.kernel.org, AJvYcCXojChpmnWW7Hboj5GXjxJ0wqkqm168xinN2b4IJQ7YyfgCfrFvGpshezmHbMQE9TmD5ee294mgady52/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlv21bxf/XSmeLmPV9TDg/qvR9WC+MCScAgVH6PU5dN1oWXVB
	Df/GAbXYb2S+J1Kjd4/DQZGpbcdC0TrBYCua7LuEJ1vj5Suz1WkolL//hkwU
X-Gm-Gg: ASbGncs2UFI543Y5UEvpAAiR1MIDO2GY368Vm1C6j+VheF24Z3kT30OYMt/UMhWI/IG
	LuNf/an/NFMysM97sr9Bet1Keel5OB82U1y+lZC1j1B2bG3IA6Mwaml/2hlvWJWbDMjOv31oeSL
	yAyI/nV97f5gUcZ+gN3t13TB9zCy31p4459D30lD7eREe+iZGcCTkkj65Xt3WlFWrK0/CZE6ZMQ
	pzoQnsvSFzDVz1r2PVwLDw6jeTigB6TTFr8HXu9u//eWDiTZl4ExaN2HowZZngIwBGsYX0ooAcy
	XhXwC9HjYjH/N1b2FNRv49c3YmcQp3Jo466nwC2mGsNh3OpMAox4Y/bqSgoOc3TMJkG8vRDozno
	bpPjTQQ/+78lmlr54ewUOZ3JsYhXHulBANgtNnfRgStsrMTxtGXtybjvB4SbCGYYcJbmHsj+yN8
	CPsDdidLgbPWUEMnGCnFH+5g==
X-Google-Smtp-Source: AGHT+IFXYxx0HIDKMOOsz0Kg0OfVqALvEwyRBRSw3nB53odh49i2jBiSY+y6VktUaDR4o37S0HDDvQ==
X-Received: by 2002:a05:6000:24c2:b0:3b7:974d:537b with SMTP id ffacd0b85a97d-3b9fc3597c2mr2793105f8f.35.1755177709228;
        Thu, 14 Aug 2025 06:21:49 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-658-1-96-160.w81-250.abo.wanadoo.fr. [81.250.250.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm50998831f8f.18.2025.08.14.06.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:21:48 -0700 (PDT)
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
Subject: [PATCH v2 1/9] mfd: dt-bindings: ti,twl4030-audio: convert to DT schema
Date: Thu, 14 Aug 2025 15:21:21 +0200
Message-Id: <20250814132129.138943-2-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
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

Changes in v2:
- Moved binding from mfd to sound directory.
- Added enum: [0, 1] to ti,enable-vibra for stricter validation.
- Removed clock-frequency from the example as it’s not relevant to the binding.
- Simplified example by removing unnecessary I2C node properties.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
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


