Return-Path: <linux-pwm+bounces-4404-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EEE9F7F5C
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 17:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B43118889F9
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203FC227B8D;
	Thu, 19 Dec 2024 16:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XGbyQAfn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E17225A2C;
	Thu, 19 Dec 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625319; cv=none; b=frfWQlUue/BQlBRp+HuubraCSn6/XTPSudwb9NyMD+yBBNGs+kYUr6bwH+c4sGbo9XLIK2u354eAK5+befjOEYQ1659+vsBYSk7z/crj2NqmojMN/DaYW1naQrNy143j8MVi+0VqiLCr5/8XfycpfEr2THt4THdRUF+KPvGVSno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625319; c=relaxed/simple;
	bh=KWh36d+ljikVIIPs4N2J6PrSLdnhSOVvwQo9gjfU3sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXRs89yLnp5/hBvoArjStuVHAmH6rxCAIIG0AwUOm/NFkweCsrmGy/5tmRAMWos3RdAgCIst7nmtyyVmxbQYPwo9680IyqlozH2b3VLHDpnwKLD7lHZao79asGPawfG7QOyrfWkjfeE1gZg5wHDelf54hJD9BtLuT0LvJn+Gers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XGbyQAfn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 737936000D;
	Thu, 19 Dec 2024 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734625309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAwdN6gi/D4quCoE23KgD7Buo4fvppT/guEfYAfj/VU=;
	b=XGbyQAfnl1Jvk32RYw/qh9EJfcsgDdw62ckrUaLXEPHhsU6djqxONqQ7rKZinvxdItFpwf
	+l4KGLX1WYkcL2rhIqLj23G45Prp8GPZK8Mg6xUAjAwyFq8d0D6bfJa4ZkCMVWQrHo/DDS
	g74OyXM5lyNAjuejIqftzccETH0ikSoe6iIPzCLqOabYXLvaOiaQy5ePZtRlxHLUbAjBin
	uWPzRB21A5VvInR6oYYj1fsiCxToPKVVyyfPjG4yFPjfzIiwsPVGsOE4XU/Ay6B0wlFnPL
	fZHQOxWDjjzR0j2FeXszy8pO0dMDlHA2tVSYOrrx3DmqdT+SHvUrGGGSd6K6oQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 19 Dec 2024 17:21:18 +0100
Subject: [PATCH 1/8] dt-bindings: Add MAX7360 MFD device
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-mdb-max7360-support-v1-1-8e8317584121@bootlin.com>
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
In-Reply-To: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734625307; l=1890;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=KWh36d+ljikVIIPs4N2J6PrSLdnhSOVvwQo9gjfU3sc=;
 b=Kstdw8fe9mjoFyo+Ucpn/uZbYYjQz58viHgIWfyK/52Sn0+K4+lMfonwYPIQrkYYlt2PNHUji
 Kr7eTl+ziutAQrYqcL/YXTOLXVO3mDJ43KHQ0A/DWxbsOhoFrOzIftC
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Add device tree bindings for Maxim Integrated MAX7360 MFD device with
support for keypad, rotary, gpios and pwm functionalities.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 Documentation/devicetree/bindings/mfd/max7360.yaml | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max7360.yaml b/Documentation/devicetree/bindings/mfd/max7360.yaml
new file mode 100644
index 000000000000..49dd437fd313
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/max7360.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/max7360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX7360 Keypad, Rotary encoder, PWM and GPIO controller
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+
+description: |
+  Maxim MAX7360 MFD device, with following functions:
+    - keypad controller
+    - rotary controller
+    - GPIO and GPO controller
+    - PWM controller
+
+  https://www.analog.com/en/products/max7360.html
+
+properties:
+  compatible:
+    enum:
+      - maxim,max7360
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: The interrupt line the device is connected to.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      max7360@38 {
+        compatible = "maxim,max7360";
+        reg = <0x38>;
+
+        interrupt-parent = <&gpio1>;
+        interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+      };
+    };

-- 
2.39.5


