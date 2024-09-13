Return-Path: <linux-pwm+bounces-3238-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD59783A3
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA342B24C70
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Sep 2024 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE1780611;
	Fri, 13 Sep 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6RFea03"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA217A15A;
	Fri, 13 Sep 2024 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240107; cv=none; b=WroV9e1L9t9x1ijreDSFpsVlB6t3t9cCsqXrIJMAxuNX65Pp8iPGi33Lojum7lc+Izs2lIyQP8ftXyuv7VwMUTtSVHJmu0hh+VvDMJbY3BJxNbxWBwdoqUTpUEfaHEjGIZEMg9QVLiEfdoBprT6UHF8AS2RRcBcRcLO41NXpUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240107; c=relaxed/simple;
	bh=5BxvSoJGkTvuZWFT0LW8xSppfKPLK5W8Ozr1yp+nxb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eUA19e2h5wF+PUobkKugKZCQkzLSUH4Szo05LYFKf7JqSeP0Ige3yIKEpT3OujO1L6PKipguxbrHgA1tDL1lwC9kYz+HCOTyBGssBzo7FoCMUay+UsI5U9+BXP27TeZ/6J2Cv4Vyl1EdNmO4YpKYOuwDpjjOOlfhAnWv+zn65iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6RFea03; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c25554ec1eso2652020a12.1;
        Fri, 13 Sep 2024 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726240103; x=1726844903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qs9D7WYZmFir3ENOGTcz3S245/jkLwimxjEHB73n2I=;
        b=U6RFea038wtTPIpUxm9qNE+vPXzXjou+6YOsXAMMGBpUwyYql3ljtiUItlrgaqWLrg
         UK0gdzmk3GXPr70O8kDiEpPzFbynhhhdwXh0BDLexceQUgS5fy5z/Lg/HVdUk//821+8
         0qpEy5m0cGVfLFDOmlULObPz/nvQBlgvjifbJWI66h1rsg92onqEuxLHC9fxp5FpYSmF
         0FF/sCVvT3HksrBfTyHPelTOUeFKmG74V+Vj+mOX+oOwPnP6/0ACmT7zWOoxMQYBo95z
         GTu/xLQ5hBPD36lzhadbRnK7IJC9EvMkMl6VmxgwQZgu2tEYkghQWdm+5wckNC78CW9l
         5qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726240103; x=1726844903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qs9D7WYZmFir3ENOGTcz3S245/jkLwimxjEHB73n2I=;
        b=QGaqCb3vB3vaKnNxlYZJ7PpwnU7sKB6fu5DiMkgYkbzVOxMo7lZKuOUYXJ35cLwBd4
         Q8Vmhjz862C5P+1twbZpR6VhErx4GGqXW6Ljk8KmwSJfbqiJm/BO5m2mYSQUGUmCkV1q
         BuYZKAGeRscIjaWadmCM3Pnpu3RHWARxOSQuDoImj61Qh+zwN5UNna0URJjJVVBFhktn
         TP75rvzKfM7AGL94dUFZJRAXfQRQsrLa9RjwNgcK3FiQWIVRwMIlM8ggn1+3mZ3rtzyl
         p6v6/aj65lZpETD5oF4wxf7PTpe4SrlttpmX4lQv/uDKoFe8ML34b+mvphsfUdIkx1qT
         52+A==
X-Forwarded-Encrypted: i=1; AJvYcCUCpluUl5Esj2uqQx2/l33xl677rcykp0osHRwMNswEcQS7UQvY0zA8bO/s17MK3VXXJhLt0/LyFLt0@vger.kernel.org, AJvYcCUDbFqLyh/BnUxnP7/0B1qfESPfiVIRG+64X4XNX7crRsjk5uHG/VjfrUv96Zj2D637qMSUjcoDtKAtDjmk@vger.kernel.org, AJvYcCUo65Oc82arC0Q1e7oYQESJu8wvQIOffp0+n8JSlPWp7uJkPyMqTduw+VTFm5qCnS5VBvYDOc3oApVw@vger.kernel.org, AJvYcCVuV6eqCm1FxpRkKkB9iKddRRy/daTMpbvIZlHu9qEPVbdGXs84jhqq6c4mGicafy3dn/+hptYEfmmgI2jrFQDlYZc=@vger.kernel.org, AJvYcCWUzxPlv2GjCNE0uWT0/rJ1lsrwzMFxjPGUduVbcMfNK8n/ttjqfBWTEZfqwkqcp4S0QvTAxqglwF1uNw==@vger.kernel.org, AJvYcCWeJw+3WDMtg5RllBZj3hI+2BSGRDLgUMBvxPDTwLgZZKFr0yHonMc+8/ioBq1fFbfjxO0ZA2Al8okzKIQ=@vger.kernel.org, AJvYcCWqtDxmtMnRRtoT8bI+xFiUOFviQnw9ecMuLLf0+h0cqRWaTjY+wC0JnaY6WC/jwUA72j8r/dbKh93DZwvRMA==@vger.kernel.org, AJvYcCXPExuge/pv3yct4RUhEfWoY59Cxc5dUzZJVt3m0yOHBVsVPdVbGhH5efcKivb6m4JAmqChyBADLT2k@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3n2kuTnFoXMYj4l17ikt8oBQ5Hzioq/IehAiPRTxn9kw5ZMOC
	c+kiyTgVf9GceG7e6vacr2gB9cTNNa+rm++hfN3qhFSUIr63E9O4TIFxTg==
X-Google-Smtp-Source: AGHT+IGahGtGigZva5WPUaLkeCtIA6xLZrMdXSHJDxtijqoIvYyvOjyZWfSktvVNDMinjY/pES1pWw==
X-Received: by 2002:a05:6402:2108:b0:5c4:2396:d990 with SMTP id 4fb4d7f45d1cf-5c42396da70mr1184642a12.17.1726240103019;
        Fri, 13 Sep 2024 08:08:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.127.153.210])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd523b4sm7774318a12.51.2024.09.13.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 08:08:22 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Fri, 13 Sep 2024 18:07:48 +0300
Subject: [PATCH v4 05/27] dt-bindings: mfd: add maxim,max77705
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-starqltechn_integration_upstream-v4-5-2d2efd5c5877@gmail.com>
References: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
In-Reply-To: <20240913-starqltechn_integration_upstream-v4-0-2d2efd5c5877@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
 Simona Vetter <simona@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726240085; l=5568;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=5BxvSoJGkTvuZWFT0LW8xSppfKPLK5W8Ozr1yp+nxb0=;
 b=hFCvbe7/NZeyGGOlUrY6moZjqhp7M+tq8u1pB+8hJ/1RUhTji/N5Cbrm4vhl7h0G8elBiXQzQ
 QfaTXcE8qh7CEAMHTuEUJaLdsG2uiUE6446V2gdDN4K4dbzfSIKDgrv
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

Add maxim,max77705 core binding part.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

---
Changes in v4:
- change dts example intendation from tabs
 to spaces
- remove interrupt-names property
- remove obvious reg description
- split long(>80) lines
---
 .../devicetree/bindings/mfd/maxim,max77705.yaml    | 169 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 170 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
new file mode 100644
index 000000000000..40a67d15e312
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77705.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77705 Companion Power Management IC and USB Type-C interface IC
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77705 multi functional
+  device.
+
+  The Maxim MAX77705 is a Companion Power Management and Type-C
+  interface IC which includes charger, fuelgauge, LED, haptic motor driver and
+  Type-C management IC.
+
+properties:
+  compatible:
+    const: maxim,max77705
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  charger:
+    $ref: /schemas/power/supply/power-supply.yaml
+    additionalProperties: true
+    properties:
+      compatible:
+        const: maxim,max77705-charger
+
+    required:
+      - compatible
+      - monitored-battery
+
+  fuel_gauge:
+    $ref: /schemas/power/supply/power-supply.yaml
+    type: object
+    additionalProperties: true
+    description: MAX77705 fuel gauge with ModelGauge m5 EZ algorithm support.
+    properties:
+      compatible:
+        const: maxim,max77705-fuel-gauge
+
+      shunt-resistor-micro-ohms:
+        description: |
+          The value of current sense resistor in microohms.
+
+    required:
+      - compatible
+      - shunt-resistor-micro-ohms
+      - monitored-battery
+      - power-supplies
+
+  haptic:
+    type: object
+    additionalProperties: false
+    properties:
+      compatible:
+        const: maxim,max77705-haptic
+
+      haptic-supply: true
+
+      pwms:
+        maxItems: 1
+
+    required:
+      - compatible
+      - haptic-supply
+      - pwms
+
+  leds:
+    type: object
+    additionalProperties: false
+    description:
+      Up to 4 LEDs supported. One LED is represented by one child node.
+    properties:
+      compatible:
+        const: maxim,max77705-led
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-3]$":
+        type: object
+        $ref: /schemas/leds/common.yaml#
+        properties:
+          reg:
+            description:
+              LED index.
+        unevaluatedProperties: false
+        required:
+          - reg
+
+    required:
+      - compatible
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max77705";
+            reg = <0x66>;
+            interrupt-parent = <&pm8998_gpios>;
+            interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+            pinctrl-0 = <&chg_int_default>;
+            pinctrl-names = "default";
+
+            leds {
+                compatible = "maxim,max77705-led";
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@1 {
+                    reg = <1>;
+                    label = "red:usr1";
+                };
+
+                led@2 {
+                    reg = <2>;
+                    label = "green:usr2";
+                };
+
+                led@3 {
+                    reg = <3>;
+                    label = "blue:usr3";
+                };
+            };
+
+            max77705_charger: charger {
+                compatible = "maxim,max77705-charger";
+                monitored-battery = <&battery>;
+            };
+
+            fuel_gauge {
+                compatible = "maxim,max77705-fuel-gauge";
+                monitored-battery = <&battery>;
+                power-supplies = <&max77705_charger>;
+                rsense = <5>;
+            };
+
+
+            haptic {
+                compatible = "maxim,max77705-haptic";
+                haptic-supply = <&vib_regulator>;
+                pwms = <&vib_pwm 0 50000>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b65cfa1d322d..59d027591e34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14064,6 +14064,7 @@ B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77705*.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	drivers/*/*max77843.c

-- 
2.39.2


