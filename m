Return-Path: <linux-pwm+bounces-7047-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B8EB26724
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046842A4736
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D7301489;
	Thu, 14 Aug 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmqH3Ut1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4A301023;
	Thu, 14 Aug 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177719; cv=none; b=HoATa8bpw5wRNHiF9aFJ4LhfBmXnlYsVPVHXwyEhHK5DgFxULuNFf0m+2EoSJ2fasgnurwLzExkWcUyrUXQxSeMhKfB2n68KCk7Gwb8pTFU+GFojVqP8JUsqV76a5QZ75J5BmZbDckKdaHA7aXt0Zr+jkTeIe5LPiasGuj37qB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177719; c=relaxed/simple;
	bh=+NSDll+hNxWRQ00a+/KSaxMfFkFtPTeDZ0v7kppqz7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g4VVjnTU0WHzFPFooaWQwzjM/5vEnzrvdRf4/RxE4oOlbaDWRHuoG4eaHbe7BnTzsvZnWgNDj7FOj0wCz0Rv3QauzenAvzYWBaaPUSb5/tyi2gwmv5q9FUK5AtGeQCD3lMfYFgoft3eb4L1ZxB+6JkqkDTCWEvSGZdwNyIDFqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmqH3Ut1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b9edf0e4efso523965f8f.2;
        Thu, 14 Aug 2025 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177715; x=1755782515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFntgdu7BGuuqufTBZF2uZX15xbuiq4/LkniuWTnia8=;
        b=FmqH3Ut1ItcOzL/cuMu4JppFPHIL/7QjCT8zc3XB1Npa4Y5tt3vQWjEQeliT/rp1kf
         CtAmMWRlZFFcI4Y/7H2MRIHpPGuYJTWjGLAoUodoZNK7DBjuQQZjXgbhcl1JRVPJwWGh
         noAxhnLvgmdI63WeeyEhXg4X9PCGq+FrzAyhs9qxjZy8lKK+pt51P4WibGMUEO4RWWGA
         3T03EYbxyfz/puFwvltY+sNho4sFuZeUr+bfLRt2AaovHtI1S495NvzOYLVRPBP6oTIq
         +uwqru8mZ5Wp59hppzkEzrU/hgqb68pXhrO0nALVmzGX678VjOhUO/wJXIKbUMf8oVvl
         euJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177715; x=1755782515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFntgdu7BGuuqufTBZF2uZX15xbuiq4/LkniuWTnia8=;
        b=UUR0smZfSJZvc1RrktjFERD1hUD56r7G2hGvv3peXdUusD5Gp6Df6I1UULgv0e4o29
         3fr2aB0LRF1SjtzSkBXd1QdcltJzJRIEgymtg+5Uxf5RurVn7EwynS2pPBj/vSLNiWrU
         4RmhUegNzbI96VKGycZlHCQDaZgtuxsoHLwzkbJZfBL2JU+zxSpydQw7bzv2OB+BPE2A
         5E8isd0EQHPgtOF0onW0ZjpN4gTshs1jczduOkoQ8eQQvwTvrfJd9bAJzbV2kZMnKRjM
         LGOq2KhYzpQIpAI/lVakcpVf0l6ebLV2q4nmUu9yBD39kptMUWAtmNr7P8A+rTGdXgbf
         dkMw==
X-Forwarded-Encrypted: i=1; AJvYcCVCywFQ1XrFbpHzr4DDzGWqXzz1Q4GVnoXFZSi64rB65g12II3RvTafGVulpSOOKddEAV0Uk8fYZEcX@vger.kernel.org, AJvYcCVVmHkEwb6VcpYXvfgCsWLkFwPTuN2s7P8/RMLfcHzTm+DssYXw96ezxiWbvtW+kvwaH/m06t4uKcVlPaw=@vger.kernel.org, AJvYcCVpwFqXi2dTatiLJAlodvMYE9VIPEPfVqUAbxHyZ+IQseVnhXvlRSTUKJpB/gqVVgbfQnv0r0RqATk0eJ0=@vger.kernel.org, AJvYcCXZzS7urNub1XhP99nelHK/IpmtoePJ2UKlm/cCnoU1zXWxGNkSpJZrH3zl0TfQU+ira3ThL8Qn1mqo@vger.kernel.org, AJvYcCXdIxAHyQtIrg8DG+kNTsaJaOJBoTljvlK7GLCVy6nA3QQXXNGLfUVARnt7IfeaZUIwll994Mc5rYV0@vger.kernel.org
X-Gm-Message-State: AOJu0YyklYANSGr5VWWWkiHZVMu9RkfzdBU53qsdRlAuCPU7xekc6wJm
	kAe1AZEnuPQSusm6+JYwQ4kFDz5h02TKNW9MHXr49rFn4918pzTD5NbxVAJK
X-Gm-Gg: ASbGnctvIG9PZ86+fsmNIHX7jTf9UzoGdDgks5yDHoHJP0+bhpah0zmNrxvUxGGcOBT
	/dOOX8OM6Jg5pchYCvwXUUQU4j7mM5ehS43hSJdN0dti4/sp6Nx526NbeftHdzi9a5opS5xfEgv
	iWWRDHg9KH4d5nYBGQA0As+O6ZVzVttQsBFm81Jm3cjUDE5PKsexX26pNk1SJ4DjJTMOuxfwHyJ
	SaSJucZ00iAGVyA8kbUoR/pGB9rUd+BcJL0i0uQMj1gxf1QT1X7fYC48UO9E8lGOiyqL37HIRPk
	DKe0gGog8XTWyyqN0pJokZ3hFn4Xv/pEtEGnu5gi5LpPkYRmS1qTDPq5MyDCJupFEVsptRSt9oy
	MpMOBwK1h0+SpmXxB6iHjVddAhldexpnDWDvbCUnaNzwgm4FURQk6HAdllv6/XLNQ/yYJ4Dwg3E
	87aH60+EB1nv7FpJgMBr7R5A==
X-Google-Smtp-Source: AGHT+IFO4PzPgSSV86iTyYC0NTzQfHea5OJvZ+Lhd7w31g2opoaACae5hmzYH0OXpgY32pQ+AvesXg==
X-Received: by 2002:a05:6000:144f:b0:3b7:9ae1:eb9 with SMTP id ffacd0b85a97d-3ba50cc8e1emr2060413f8f.23.1755177715345;
        Thu, 14 Aug 2025 06:21:55 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-658-1-96-160.w81-250.abo.wanadoo.fr. [81.250.250.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm50998831f8f.18.2025.08.14.06.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:21:54 -0700 (PDT)
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
Subject: [PATCH v2 4/9] mfd: dt-bindings: ti,twl4030-power: convert to DT schema
Date: Thu, 14 Aug 2025 15:21:24 +0200
Message-Id: <20250814132129.138943-5-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the TWL4030 power module
to the modern YAML DT schema format. This adds formal validation
and improves documentation.

Changes in v2:
Simplified the description field by removing redundant '|' as it
does not affect formatting in this context.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../bindings/mfd/ti,twl4030-power.yaml        | 69 +++++++++++++++++++
 .../devicetree/bindings/mfd/twl4030-power.txt | 48 -------------
 2 files changed, 69 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml b/Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml
new file mode 100644
index 000000000..713e2facf
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,twl4030-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030-family Power Management Module
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description:
+  The power management module inside the TWL family provides several facilities
+  to control the power resources, including power scripts. For now, the
+  binding only supports the complete shutdown of the system after poweroff.
+
+properties:
+  compatible:
+    description: |
+      The compatible string determines the specific power configuration.
+        "ti,twl4030-power": Standard power control.
+        "ti,twl4030-power-reset": Recommended for OMAP3530 and similar SoCs
+          that require a special configuration for warm reset to work correctly.
+        "ti,twl4030-power-idle": Loads the TI-recommended configuration for
+          idle modes into the PMIC.
+        "ti,twl4030-power-idle-osc-off": Uses the recommended idle configuration
+          but also shuts down the external oscillator. This may not work on all
+          boards depending on the oscillator wiring.
+
+    enum:
+      - ti,twl4030-power
+      - ti,twl4030-power-reset
+      - ti,twl4030-power-idle
+      - ti,twl4030-power-idle-osc-off
+
+  ti,system-power-controller:
+    type: boolean
+    description:
+      Indicates that the TWL4030 is the power supply master of the system,
+      allowing it to initiate system power-off.
+
+  ti,use_poweroff:
+    type: boolean
+    description: Deprecated name for ti,system-power-controller.
+    deprecated: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      clock-frequency = <2600000>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      twl: twl@48 {
+        reg = <0x48>;
+        interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+        interrupt-parent = <&intc>;
+
+        twl_power: power {
+          compatible = "ti,twl4030-power";
+          ti,use_poweroff;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
deleted file mode 100644
index 3d1996331..000000000
--- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Texas Instruments TWL family (twl4030) reset and power management module
-
-The power management module inside the TWL family provides several facilities
-to control the power resources, including power scripts. For now, the
-binding only supports the complete shutdown of the system after poweroff.
-
-Required properties:
-- compatible : must be one of the following
-	"ti,twl4030-power"
-	"ti,twl4030-power-reset"
-	"ti,twl4030-power-idle"
-	"ti,twl4030-power-idle-osc-off"
-
-The use of ti,twl4030-power-reset is recommended at least on
-3530 that needs a special configuration for warm reset to work.
-
-When using ti,twl4030-power-idle, the TI recommended configuration
-for idle modes is loaded to the tlw4030 PMIC.
-
-When using ti,twl4030-power-idle-osc-off, the TI recommended
-configuration is used with the external oscillator being shut
-down during off-idle. Note that this does not work on all boards
-depending on how the external oscillator is wired.
-
-Optional properties:
-
-- ti,system-power-controller: This indicates that TWL4030 is the
-  power supply master of the system. With this flag, the chip will
-  initiate an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
-  system poweroffs.
-
-- ti,use_poweroff: Deprecated name for ti,system-power-controller
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
-		twl_power: power {
-			compatible = "ti,twl4030-power";
-			ti,use_poweroff;
-		};
-	};
-};
-- 
2.39.5


