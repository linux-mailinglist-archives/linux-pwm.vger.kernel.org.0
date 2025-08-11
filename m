Return-Path: <linux-pwm+bounces-7013-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA546B218B3
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8217B1171
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA5B2E62AE;
	Mon, 11 Aug 2025 22:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUTvo1++"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC72E6124;
	Mon, 11 Aug 2025 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952500; cv=none; b=l7y8tbx0phM/3N0CeovGod5v0r8ueRSkuVnYHoGZiz0uvs42fVUGkeQujbiNnpXYjd2JmUTbrvQHfhAQIiWkGDqp9y9K7oH0zkEvsCP3jK0xFZt4gUtFMNbyTetwt5evYxzyoJJVkSsE7ky6IVySdICnevR5/taj1/idKgmQqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952500; c=relaxed/simple;
	bh=UPNJQhUA6Bu+vQ0Xv1n3WkPsshuFsugmgPi29JpHb20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gs5Kkq80IB9fxa+nd+cp7ndtCGd7RXnydMOHgJ1LRwVxi7lKp/vkXpXEzuKITrEfa8zjhlQpgdcAB/gIa8a6DL95Xdtu95F8HfO2inaYcXhy+Hq0LyPb5cYY+B4CgKvkI5PH8joyuMi4U45UrYOmrS6sciz8eYb6PrWul01X3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUTvo1++; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a11a138faso370335e9.2;
        Mon, 11 Aug 2025 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952496; x=1755557296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CodmMT7JjiLTDpj7w45XSeNEEzkEBcMMbF3t4awvoLg=;
        b=LUTvo1++OvAofeWWstl0Zrdtq6NMPHP6e2gQvBZxr7d6EKb2Ov5KpycOAs39dkN5Z6
         Qk2AuBuxwFC40BvJWsiOEA6iEtK8INyBcjEX5CzkU8Ie6KmgE9Aht0TBOGKBufw2z7Ty
         iw011tOdV21eiF/03Iag4Zc/W+wzbaMGuukjvjaVqvBviy4kK5wPf8+0rBbgUZ3bUW4Y
         CYp1MU3R2f2++1kR318cfpMXsawa8hkYeVtGnBV4F5xHju7tQaHBm1Qao8WLNY+SuUvB
         ZIsh7EluA6ygBxvjmQ7dHGVepi7j6xbNJtP8vhO1TAb00euD3c/fhcyqDbKe9SwTLMFe
         6q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952496; x=1755557296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CodmMT7JjiLTDpj7w45XSeNEEzkEBcMMbF3t4awvoLg=;
        b=M4LdpukZYCjKQkRMkRt6r+ec9O9Hfl8gar9FhTSs4EUDnv70UANu/XrCk52RC2AVxZ
         nW2VCHpbcZzeq/zptSZWwjhfm3zvNXCwYRBjP+jqQlW9YX4+Jti4K++2n+5fNyIZramE
         9QXs0oLyW9IdOWr4p00WQSjxi5KKsjNLeACCSw+LRnOsTP024m9/zRGoZiNcvgY4N2oP
         OqJYdhBTawFqLt5F+ELXxQG6MlRfXt5i9JfJ1PDgzexDNexx9rVLkPDPHr9+BBwq50jj
         j98mmR7NIzkhGZIUee2FVpC3I0mo8DbTxvOER0XTo/mfcH61MzUwUsJ9SpLjkHyKxhma
         HMjg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Z4KMdfdBKZeElhVbXcTbf/7jef/9PWqd0VBDbe+/cOQ0yD6WPtQFGHT6gu3Oll4tRUX0nt+bIDyQlGc=@vger.kernel.org, AJvYcCVIS3EItwU7GOXHbAxTqC/zpWAocwZ1RqN/iKgZSvY6rBb66tGvohm/BZS2JcSRkNwQjH2/KAKPz1J6@vger.kernel.org, AJvYcCVw1vk2ZaP1DTM+DlZ+pGgvNsjqyqmCyp79PCxfsQFuEqxiOsFd3yu5u1kKGdJRMYv5SnEi1tRhDW02@vger.kernel.org, AJvYcCXGa5YT2tU6En0Vx+clirjeolfBscSoMbLzAvolaI9hqmzN1GLEZEekh57WyBx1bEvd9TEykSn5D8hy@vger.kernel.org, AJvYcCXlnHA/HOEakxEHkzPB390pP2d2TwKtSVsFkYTHQYVsYfxZyql3EnxnAO6rnZYqk8i50EDKdshyqlRtvHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDda6jne8GJ6glCSErpZaTaT93MkW2Q0fvHxSzxImfBd1qGqco
	c1z1/A32a3P2RfgIFDMDcDaq530pzRPWpaFKYCCEhstRqrn774UPwuVZPQYtYLQ=
X-Gm-Gg: ASbGncuzur5MUHrkE/GHQ0yG9Vwy3yua2WvLki7DrTWrPKs9BSU1/fP/7WpZhdv1KyG
	lmylFjBDuvClrBFUJzlgMvZHUolJIgce/s11zxx4RdcSCPLAAh/17Docgwu5uXy00l8K2JqagLp
	muPkrd7X6bVU6x7rxYh6hbjNwj4Zpx8/mqELl7RCqsqi2z/Qah+KWyjNNMzVrV/lhHKkLx6W4iA
	i2OZo2INSmtoWzcdjwJjZF66gs0eWxiwbyKajCvvu59WhjjxtNDCkTbCNuR79izoAO3Nhdi2SBY
	uY7nD+xYdb/K/EUhXop9VVj593GAe6l1gdDhMr9Io0yIJm5acYgnNoY3JuqM/cfv2+N+YVt5WbE
	XcpLNgvLD61vcXSiH6Kbr/4fNaUZgbkF49P4w8hS5ntZA53M=
X-Google-Smtp-Source: AGHT+IFaTclGM/3szTeKR4emD2Ude+cbSZ0zqbGoDkB1YynY4ngEcsThAfRUrEB27QVCMQeZjA6Q8w==
X-Received: by 2002:a05:600c:4fd1:b0:453:5c30:a1fd with SMTP id 5b1f17b1804b1-45a10ba7d10mr12015855e9.8.1754952496137;
        Mon, 11 Aug 2025 15:48:16 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:9b35:8c56:5611:71e6:ca77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm343678175e9.2.2025.08.11.15.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:48:15 -0700 (PDT)
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
Subject: [PATCH 8/8] usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema
Date: Tue, 12 Aug 2025 00:47:39 +0200
Message-Id: <20250811224739.53869-9-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the TWL4030/6030 USB module
to the modern YAML DT schema format. This adds formal validation
and improves documentation using a conditional schema.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../bindings/usb/ti,twlxxxx-usb.yaml          | 121 ++++++++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   |  43 -------
 2 files changed, 121 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
new file mode 100644
index 000000000..029865ad2
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/ti,twlxxxx-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TWL4030/6030 USB PHY and Comparator
+
+maintainers:
+  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
+
+description: |
+  Bindings for the USB PHY and comparator module found within the
+  TWL4030 and TWL6030 family of companion chips.
+
+  TWL6030: USB COMPARATOR
+  TWL4030: USB COMPARATOR & PHY
+
+  If a sibling node is compatible with "ti,twl4030-bci", the driver for
+  that node will query this device for USB power status.
+
+properties:
+  compatible:
+    enum:
+      - ti,twl4030-usb
+      - ti,twl6030-usb
+
+  interrupts:
+    description: |
+      Interrupts for ID and VBUS events.
+      For "ti,twl6030-usb", two interrupts must be specified:
+        - The first is the OTG interrupt for ID events (host mode).
+        - The second is the USB interrupt for VBUS events (device mode).
+      For "ti,twl4030-usb", one or two interrupts can be specified:
+        - The first is the OTG interrupt for both ID and VBUS events.
+        - The second is optional.
+    minItems: 1
+    maxItems: 2
+
+  usb-supply:
+    description:
+      Phandle to the VUSB regulator. For TWL6030, this should be the 'vusb'
+      regulator. For TWL6032 subclass, it should be the 'ldousb' regulator.
+
+  usb1v5-supply:
+    description: Phandle to the VUSB1V5 regulator (for TWL4030).
+
+  usb1v8-supply:
+    description: Phandle to the VUSB1V8 regulator (for TWL4030).
+
+  usb3v1-supply:
+    description: Phandle to the USB3V1 regulator (for TWL4030).
+
+  usb_mode:
+    description: |
+      The mode used by the PHY (TWL4030 ONLY) to connect to the controller:
+        1: ULPI mode
+        2: CEA2011_3PIN mode
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: ti,twl6030-usb
+then:
+  required:
+    - usb-supply
+  properties:
+    interrupts:
+      minItems: 2
+else:
+  required:
+    - usb1v5-supply
+    - usb1v8-supply
+    - usb3v1-supply
+    - usb_mode
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        twl@48 {
+            reg = <0x48>;
+
+            usb_phy: usb-phy {
+                compatible = "ti,twl4030-usb";
+                interrupts = <10 4>;  // Single interrupt: OTG (ID and VBUS events)
+                interrupt-parent = <&gic>;
+                usb1v5-supply = <&reg_vusb1v5>;
+                usb1v8-supply = <&reg_vusb1v8>;
+                usb3v1-supply  = <&reg_vusb3v1>;
+                usb_mode = <1>;
+            };
+        };
+    };
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        twl@48 {
+            reg = <0x48>;
+
+            usb_comp: usb-phy {
+                compatible = "ti,twl6030-usb";
+                interrupts = <4 4>, <10 4>;  // Two interrupts: OTG (ID events), USB (VBUS events)
+                interrupt-parent = <&gic>;
+                usb-supply = <&reg_vusb>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt b/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
deleted file mode 100644
index 17327a296..000000000
--- a/Documentation/devicetree/bindings/usb/twlxxxx-usb.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-USB COMPARATOR OF TWL CHIPS
-
-TWL6030 USB COMPARATOR
- - compatible : Should be "ti,twl6030-usb"
- - interrupts : Two interrupt numbers to the cpu should be specified. First
-   interrupt number is the otg interrupt number that raises ID interrupts when
-   the controller has to act as host and the second interrupt number is the
-   usb interrupt number that raises VBUS interrupts when the controller has to
-   act as device
- - usb-supply : phandle to the regulator device tree node. It should be vusb
-   if it is twl6030 or ldousb if it is twl6032 subclass.
-
-twl6030-usb {
-	compatible = "ti,twl6030-usb";
-	interrupts = < 4 10 >;
-};
-
-Board specific device node entry
-&twl6030-usb {
-	usb-supply = <&vusb>;
-};
-
-TWL4030 USB PHY AND COMPARATOR
- - compatible : Should be "ti,twl4030-usb"
- - interrupts : The interrupt numbers to the cpu should be specified. First
-   interrupt number is the otg interrupt number that raises ID interrupts
-   and VBUS interrupts. The second interrupt number is optional.
- - <supply-name>-supply : phandle to the regulator device tree node.
-   <supply-name> should be vusb1v5, vusb1v8 and vusb3v1
- - usb_mode : The mode used by the phy to connect to the controller. "1"
-   specifies "ULPI" mode and "2" specifies "CEA2011_3PIN" mode.
-
-If a sibling node is compatible "ti,twl4030-bci", then it will find
-this device and query it for USB power status.
-
-twl4030-usb {
-	compatible = "ti,twl4030-usb";
-	interrupts = < 10 4 >;
-	usb1v5-supply = <&vusb1v5>;
-	usb1v8-supply = <&vusb1v8>;
-	usb3v1-supply = <&vusb3v1>;
-	usb_mode = <1>;
-};
-- 
2.39.5


