Return-Path: <linux-pwm+bounces-7009-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BB1B21896
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1ED61904470
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FB82E5419;
	Mon, 11 Aug 2025 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHDi/jMg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53722E425E;
	Mon, 11 Aug 2025 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952490; cv=none; b=gQsNdugWjLx6NtOcBt97LYp3l5mNLFc/UfXUIH8a+faKyScF5nK4NQx9vLq++pYfXMnZKYXJQnvcCUVIpbBUe2Z2jSqyUfrtTOcogPxpCvWnGNbRVb0d7EJGm0EBjl81EHm/ajH+ES1LcSYiLgeIZgW9C2JcpJ563Arkg+XiuJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952490; c=relaxed/simple;
	bh=5BR5cfe8t6koUL9Rqha0JKrh7QSZt0+zQ0ZeSTqPbyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9ji/gQRJxOcnPO9Id9VVMwFDVj7O31S4YbVZN4ca/lz6gKxZaIi9CUPxfJP7n3gR3vAr/S0k4DBaubasz9UxNWirSsqe/PWO1cPtyV6eI6GuK91NeVWJnr7kb5UbdaMrcdRx0Kj03U8tUnodgMoFz5OEAuP7wM9aCIyQMM09kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHDi/jMg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso31282895e9.3;
        Mon, 11 Aug 2025 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952487; x=1755557287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gsim7Mbp8csf32SO778GzsmLe7VF3Ywcdd8xmkgQYBk=;
        b=bHDi/jMg2pNFpYhxGxnueWn5Q9cZWdm9KIMA9JYfp3V3g330XmLMxzvsGwEBr/zDpg
         rbdPWNl9AF64vMSL+mZsI6zue8n0VPqXCIagx9iCjgbejns0lYRN/zVbBbUPZu+iLNDy
         ljsBnqbO1aVa7eptSiEAMKKNtlVNfQzTfYIneCUuy3uC4Atl/jw2N7Xo2YrlEU2Hz6GJ
         DmMlDuxNDXvw/u4P48suqhmvME6WknwHKBowE0R9jVahDrmEkfBSNaGcKHdwTuNSCv5D
         6iatv0ryqxr80WqDyAfgjtqmqnShmbCwFW7cFjOrNrzBAbs460o8gtzCGKVCmnHF1rKI
         NIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952487; x=1755557287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gsim7Mbp8csf32SO778GzsmLe7VF3Ywcdd8xmkgQYBk=;
        b=JMWSr43ABd/n0LcRU4Ykmwsje7QzB/K4iwPYQAfW1jRi3ve8THxs7aYdyc2H1ALiAg
         Yba7Zw7/XIqNyzss9EQ/oznAh0MQmnWgLMOvHB9OkuB4Uo8ZSNeFMVqlFCZ06+1I3pok
         UlWuRAXzdMwovduFm4fZrQWSIMYHVtqMPibU1GJd04nJkc0MEKUy4Lo+cS1BBEPrbwbc
         N6B1WQVGGN6RwBTM1k14UojGRljd+fNrJADTKSXUNpnyomw6X2KfobQ9IncXb/5w+pzR
         nBi1VhM3n4g8gaqbFFA2BP1W0GkfE1CJAMZDIAeF8S6XbFZyLyIVleI76mAJz+gIhQsq
         4VQg==
X-Forwarded-Encrypted: i=1; AJvYcCU6/8E9rsZ2Qcgwj21JmpEt3DsPsnAVn8udLIHExJdbYuEF0IPuY/QPYS2HphBNNm0VeTP8zAANPATLqSM=@vger.kernel.org, AJvYcCUZrmi8WwTxoIY97HiYsAwu8p3VCBwM4E8YdwJML+Zou5qMTeQRExR9ehOSUhI9WBxZdWvLsMm3rfMU@vger.kernel.org, AJvYcCUnSwJ7STrs8bVL+4+vlqTNjOFiJo0y3fXDvtpU2RwXcV1m3lFSuvDmo5pZ6bb3tqfnHXLOvq92eoSGeZo=@vger.kernel.org, AJvYcCXJA4kS1UU4wJuVE4NKwa0IRpVxkW1z4uJVxAQ9jV6BXcldI2jJshXVYpbyDxyU3sd/2GdaIDv6pYnb@vger.kernel.org, AJvYcCXO9WXmlaxJbv77pIJn7QHTBNP3wDhuNqoYhByRnUiScx6wL6LpP3zDMl/9Q6VYx+xcPeX5f5N4oQPA@vger.kernel.org
X-Gm-Message-State: AOJu0YzvT4R4XoCqw7fCET9Gah2+sWnFNU1qIqlWGWdZjxFhkC/bGn6v
	g/lyMGNyYRiIvsKw1PcokdOTCJHPa+6KGOL75ciBT+hyG9i+rbTqotUb4osqHTU=
X-Gm-Gg: ASbGncszXGcUzGXv3oGB12WgLyR047Y/oLtU1Jq7Tu0o6iMSq7vYH+VbKt3yphm62sk
	4vprQdzHkIJq6sNebLGfzdF8c5W3uDaE9h0UCjWRqrkalnenfvCGjA1+kf09bcAfgHqrWxhehFG
	rxAWMhh04rDS6PQsoDS1Vv/x3DimUMzyOCG1jCYo8tlMSquazh1QFtW1MDrMUpf3xseygRG5ba4
	LkMRA0ptdlvamOlA9dPa8nCwWYedVKTHnNK1ko3X6EPOVF5/VCqg8yutRFvAdfer/m4d74wN0cS
	4cdzunPojZ47rYMiiqjdV7ttvKtAuMBSBsK/deNS2I9VLGVyb5qc9noSrlvyX8hAXuAPu+TkgHr
	vltifDecfPtLlIhcNmmVn9Q9ce2JGKNeo+UGwU7T6dYkpOQQ=
X-Google-Smtp-Source: AGHT+IHtnAeMNoqTMmNPwYJahRNDxJzYsvSJkXHKGiu4Co27s+6YE/y6/imOhrVFG8UJ5Nfh4f645w==
X-Received: by 2002:a05:600c:3503:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45a10c01785mr10573605e9.22.1754952486429;
        Mon, 11 Aug 2025 15:48:06 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:9b35:8c56:5611:71e6:ca77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm343678175e9.2.2025.08.11.15.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:48:06 -0700 (PDT)
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
Subject: [PATCH 4/8] mfd: dt-bindings: ti,twl4030-power: convert to DT schema
Date: Tue, 12 Aug 2025 00:47:35 +0200
Message-Id: <20250811224739.53869-5-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the TWL4030 power module
to the modern YAML DT schema format. This adds formal validation
and improves documentation.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../bindings/mfd/ti,twl4030-power.yaml        | 69 +++++++++++++++++++
 .../devicetree/bindings/mfd/twl4030-power.txt | 48 -------------
 2 files changed, 69 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml b/Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml
new file mode 100644
index 000000000..c95b3f705
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
+description: |
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


