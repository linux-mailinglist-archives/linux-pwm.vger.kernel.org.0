Return-Path: <linux-pwm+bounces-7077-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BA5B289F4
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 04:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5126022E5
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 02:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C98202C43;
	Sat, 16 Aug 2025 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP57p5Wo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B279EA;
	Sat, 16 Aug 2025 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310710; cv=none; b=FXWPcWEj962B8OzT0fHQooPMcOBPjkrFq1tVI07yn+VnNepvY11dROZ0TUtSqj9qMgtzc/1M942D99GMaxwKSvKFvq5LlbUXVRZ01O6e2LpHgrRoLVwaamd1dhYRghhZq+arWb6ozBponeZGu5spaaZvBhrd5xVW9DxUmeCbboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310710; c=relaxed/simple;
	bh=iG8hiwI6gZFIs3EG+bpt/RDjTe4KOFgc/1QMQJQO4eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FA30m+nDwT+QrvIeSXD8NBCZznizt4KNaxT8x6h8HMPON00OgacySLKShfV6y+6M7M02VuDjB3HyhDmtCHEOCVT+Xw+TXAKUIMUELuE0NEoJo3T890o5q6F1JM2vEnUVXzaYfI6BtUTEOfv4zVsBe90pXzBOMtmxo0wKtypjbJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WP57p5Wo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0cd668so12126855e9.3;
        Fri, 15 Aug 2025 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755310706; x=1755915506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze4O4MOWswAI5XJ71bJqUM7LZAiKSco1sWC6EZAZ50I=;
        b=WP57p5Wocvgjk63BINKEkg07+nGFdS0PC8SI/z+zuuj/gmIh9u4CS8j9E23L5vr9Dj
         c+77bL8QotoLkQcK/7vWxaZtecbEJCmv4/IEVOMniI8UgZGlDN30d0WV6lHxLjTQiOgh
         bJwbinIZadKTjSavqt0MzvbRKqVNHtURb9siWYFvF/lL3KU11GUoT4n9KvKokxynpTwV
         1cOzo0xPXHzmIxkK7EErUKQ8GxOKtlTKBII5ZfXfHZauTP1rX2Qd0Nyea/EkQXD1ZrzU
         GgAzNh5o5HOsdhjvT5bq9Wcz8cyBOP234kmokGaN4hN6a6/cRpv1BN73qsY5OivqTdho
         Ar2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310706; x=1755915506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze4O4MOWswAI5XJ71bJqUM7LZAiKSco1sWC6EZAZ50I=;
        b=IAJ/sMH+r7UxZ/keckVVtwbDrLnwXOm7NlMPfEMg32kSGRJ+jgHb03QGOLoPZkNGJ5
         1zOFco4OnOz3GiOCoY57rQJ5KbV3Ww/D5baSuSlLW90PVFhwHeAqp+TJ1qicRUGpT3Ec
         fEBG6WdyAvAEjBkceNKjxO+OsH39dP1r6gS156cC9FqLijrsfntXYB1KFGKpT9W+JasC
         bFIeE9iDaKeIQ7CVs292OXgqIQA0uC6taMlHcGPwm47O8jPWUhXfqOKrA2F2HZWru+nK
         X9k7OECvbCS9bRZUY7QqYW45q2izeBm3PTazFTvP8ovC9Upy085iXEWDbUZ31FdM8Trh
         QjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFSNnTOwN3Xm9tFYUVTBpzqVSqNDt0hoYUzUEyal/GImnkSS8hgJoD9E52MbW6N42nBPI/T75Ugx0i5A==@vger.kernel.org, AJvYcCUK7ukhqV56byFB9xNQNDNTDy5v4kAxjgjUD+DS5KS3NdV68GxhHC4wb04jlknR4HdLZXppuMUW4wJ7@vger.kernel.org, AJvYcCUuputP+YJLSnhzmH3hJcilW3h+8XTS9Cl+HCdCFfapH8laE59MscEDDip8o+NFv3z8uFPQ2ZP5J1j6nA==@vger.kernel.org, AJvYcCV76CdAqpgGBPU0S0ZEvRTAvIMClug0Z81IlXbY0pm5UEcxjxsRVRftAuRlddDus95m9jkA6kxheW1qe6A=@vger.kernel.org, AJvYcCWAr7KYcWVw2VeHC/szsFCFnMyLOxIBCYRoDkqrkGwJrbKhQp+qFenQpVNRSEME8qkfXymcuxWTcIV/@vger.kernel.org, AJvYcCX0qve5FF2JsUEytXXtu0xvXpcjCMvY9Ee2HDumKGFEvjHKXYvMO0VKd+L7XcLXU1vBzE2hWyOlGwcqtz8=@vger.kernel.org, AJvYcCXGiCP2YOg7tmuUzjTVm7IfvJMH2TO1KuKsWBQNV1j+zEuUN7t43e0th6xUpKP7I5SQwuYlCGriGHeW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2pv9eujNSSp8cUSRXdUHHiqW+4/aWO5XBqHEb/Nm2DY0vmD3p
	oMhnYEHiLxNKDQuQu3lb44BjfpdQbgIMp7hglQrUGiGPH9GMYgbQAxd1+q5xzRA=
X-Gm-Gg: ASbGncsg6QGA63me4GOIvg43PqfaDE3Ei7kC7xn8dv2LIIO6GkAL9QPygaic+KLcWth
	d/E9uxWDzCzYM6RJDYgX1RfmccD/OXeM+TNg+VQFBd2QB4+cDV7HfdwBTY9hKVuzVwKyBlqQQIJ
	Y1hjp9Z4B26bQaEM83CdMmI7GN4a5I+X6v0oogAcneXOcE01js+AfhflbeMmDRHehYTXO9uDJ1S
	dlivXaYKDMCzqGEWSP0eAjEDJK7MwNRBlZ9P/M60Edc1SzM/VV2lxgJrjQjT9TmeG30V8xzSGJq
	vo9Hm69d1LPrEFE9yPz7mYBbWXHUAVxnx788oQ19x8k4ITfp9U4WuETzko2LqoRlTO8lmnVctwZ
	WhKEeFCA63ceR9DUsAsIqaNc4VnPqlo4jh8TVbkpwk+Zm/tw=
X-Google-Smtp-Source: AGHT+IEi7+0siAUZLCApuhc6Rc+WC3G3k/Y4w2iMTGWKechJTFfbsY8rLB+Mi5U5QDjSPo0/vPNBow==
X-Received: by 2002:a05:600c:198d:b0:459:e094:92cb with SMTP id 5b1f17b1804b1-45a218095eemr33920905e9.12.1755310706082;
        Fri, 15 Aug 2025 19:18:26 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:212f:1af8:ee74:5774:2fc2:70a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1fe2c019sm58712535e9.17.2025.08.15.19.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:18:24 -0700 (PDT)
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
Subject: [PATCH v3 5/6] usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema
Date: Sat, 16 Aug 2025 04:15:22 +0200
Message-Id: <20250816021523.167049-6-jihed.chaibi.dev@gmail.com>
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

Convert the legacy TXT binding for the TWL4030/6030 USB module
to the modern YAML DT schema format. This adds formal validation
and improves documentation using a conditional schema.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v3:
 - No changes.

Changes in v2:
 - Added '#phy-cells' property to support PHY framework integration.
---
 .../bindings/usb/ti,twlxxxx-usb.yaml          | 125 ++++++++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   |  43 ------
 2 files changed, 125 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml b/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
new file mode 100644
index 000000000..48ff5b732
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
@@ -0,0 +1,125 @@
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
+  '#phy-cells':
+    const: 0
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
+            usb_phy: twl4030-usb {
+                compatible = "ti,twl4030-usb";
+                interrupts = <10 4>;  // 1 interrupt: OTG (ID & VBUS events)
+                interrupt-parent = <&gic>;
+                usb1v5-supply = <&reg_vusb1v5>;
+                usb1v8-supply = <&reg_vusb1v8>;
+                usb3v1-supply  = <&reg_vusb3v1>;
+                usb_mode = <1>;
+                #phy-cells = <0>;
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
+            usb_comp: twl6030-usb {
+                compatible = "ti,twl6030-usb";
+                interrupts = <4 4>, <10 4>;  // 2 interrupts: OTG & USB
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


