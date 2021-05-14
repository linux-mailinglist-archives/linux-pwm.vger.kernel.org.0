Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E289C380221
	for <lists+linux-pwm@lfdr.de>; Fri, 14 May 2021 04:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhENCtz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 May 2021 22:49:55 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:14311 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhENCtz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 May 2021 22:49:55 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 14E2aIgP043663;
        Fri, 14 May 2021 10:36:18 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 14 May
 2021 10:48:33 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <p.zabel@pengutronix.de>,
        <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v5 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
Date:   Fri, 14 May 2021 10:48:44 +0800
Message-ID: <20210514024845.10531-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
References: <20210514024845.10531-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 14E2aIgP043663
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds device binding for aspeed pwm-tach device which is a
multi-function device include pwm and tach function and pwm/tach device
bindings which should be the child-node of pwm-tach device.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 66 +++++++++++++++
 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 84 +++++++++++++++++++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 62 ++++++++++++++
 3 files changed, 212 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
new file mode 100644
index 000000000000..0b23281e9f5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 ASPEED, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2600 Tach controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  The ASPEED Tach controller can support upto 16 fan input.
+  This module is part of the ast2600-pwm-tach multi-function device. For more
+  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-tach
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  pinctrl-0: true
+
+  pinctrl-names:
+    const: default
+
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties:
+  type: object
+  properties:
+    reg:
+      description:
+        The tach channel used for this fan.
+      maxItems: 1
+    aspeed,min-rpm:
+      description:
+        define the minimal revolutions per minute of the measure fan
+        used to calculate the sample period of tach
+      default: 1000
+    aspeed,pulse-pr:
+      description:
+        Value specifying the number of pulses per revolution of the
+        monitored FAN.
+      default: 2
+    aspeed,tach-div:
+      description:
+        define the tachometer clock divider as an integer. Formula of
+        tach clock = clock source / (2^tach-div)^2
+      minimum: 0
+      maximum: 15
+      # The value that should be used if the property is not present
+      default: 5
+  required:
+    - reg
diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
new file mode 100644
index 000000000000..d742ccfcc003
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 ASPEED, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwm-tach.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM Tach controller Device Tree Bindings
+
+description: |
+  The PWM Tach controller is represented as a multi-function device which
+  includes:
+    PWM
+    Tach
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - aspeed,ast2600-pwm-tach
+      - const: syscon
+      - const: simple-mfd
+  reg:
+    maxItems: 1
+  clocks:
+    maxItems: 1
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+patternProperties:
+  "^pwm(@[0-9a-f]+)?$":
+    $ref: ../pwm/aspeed,ast2600-pwm.yaml
+
+  "^tach(@[0-9a-f]+)?$":
+    $ref: ../hwmon/aspeed,ast2600-tach.yaml
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ast2600-clock.h>
+    pwm_tach: pwm_tach@1e610000 {
+      compatible = "aspeed,ast2600-pwm-tach", "syscon", "simple-mfd";
+      reg = <0x1e610000 0x100>;
+      clocks = <&syscon ASPEED_CLK_AHB>;
+      resets = <&syscon ASPEED_RESET_PWM>;
+
+      pwm: pwm {
+        compatible = "aspeed,ast2600-pwm";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #pwm-cells = <3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pwm0_default>;
+        pwm-ch@0 {
+          reg = <0>;
+          aspeed,wdt-reload-enable;
+          aspeed,wdt-reload-duty-point = <32>;
+        };
+      };
+
+      tach: tach {
+        compatible = "aspeed,ast2600-tach";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_tach0_default>;
+        fan@0 {
+          reg = <0>;
+          aspeed,min-rpm = <1000>;
+          aspeed,pulse-pr = <2>;
+          aspeed,tach-div = <5>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
new file mode 100644
index 000000000000..f1354c8d35b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 ASPEED, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/aspeed,ast2600-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASPEED AST2600 PWM controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  The ASPEED PWM controller can support upto 16 PWM outputs.
+  This module is part of the ast2600-pwm-tach multi-function device. For more
+  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-pwm
+
+  "#pwm-cells":
+    const: 3
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  pinctrl-0: true
+
+  pinctrl-names:
+    const: default
+
+
+required:
+  - compatible
+  - "#pwm-cells"
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties:
+  description: Set extend properties for each pwm channel.
+  type: object
+  properties:
+    reg:
+      description:
+        The pwm channel index.
+      maxItems: 1
+    aspeed,wdt-reload-enable:
+      type: boolean
+      description:
+        Enable the function of wdt reset reload duty point.
+    aspeed,wdt-reload-duty-point:
+      description:
+        Define the duty point after wdt reset, 0 = 100%
+      minimum: 0
+      maximum: 255
+  required:
+    - reg
-- 
2.25.1

