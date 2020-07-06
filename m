Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D26215DD2
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2020 19:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgGFR6a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Jul 2020 13:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgGFR5e (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jul 2020 13:57:34 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0877C061794;
        Mon,  6 Jul 2020 10:57:33 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F0C0E22FB3;
        Mon,  6 Jul 2020 19:57:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1594058250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNbDjJViK3QDI95n5hN2Q7pRVOSwGWhUgn/WJptcTqU=;
        b=aNC8rjAO91JA37PFPkvi2R8N0fMnaA6VfG27CfXaS+lNfSvqe1TWY8l9520SOdJtE4fjY3
        xshG4kzKi0Ij8MpAnJfVnh7Xa3yfo6fsFMpTbpY0g5RJFm1fexMmg1/KHFQZTPMIIwvyFl
        aXtS2PvzvmnNZx1XwXhDGKCcAlm4yhM=
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v5 03/13] dt-bindings: mfd: Add bindings for sl28cpld
Date:   Mon,  6 Jul 2020 19:53:43 +0200
Message-Id: <20200706175353.16404-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706175353.16404-1-michael@walle.cc>
References: <20200706175353.16404-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a device tree bindings for the board management controller found on
the Kontron SMARC-sAL28 board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v4:
 - fix the regex of the unit-address

Changes since v3:
 - see cover letter

 .../bindings/gpio/kontron,sl28cpld-gpio.yaml  |  54 +++++++
 .../hwmon/kontron,sl28cpld-hwmon.yaml         |  27 ++++
 .../kontron,sl28cpld-intc.yaml                |  54 +++++++
 .../bindings/mfd/kontron,sl28cpld.yaml        | 153 ++++++++++++++++++
 .../bindings/pwm/kontron,sl28cpld-pwm.yaml    |  35 ++++
 .../watchdog/kontron,sl28cpld-wdt.yaml        |  35 ++++
 6 files changed, 358 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml

diff --git a/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
new file mode 100644
index 000000000000..9a63a158a796
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/kontron,sl28cpld-gpio.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/kontron,sl28cpld-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO driver for the sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description: |
+  This module is part of the sl28cpld multi-function device. For more
+  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
+
+  There are three flavors of the GPIO controller, one full featured
+  input/output with interrupt support (kontron,sl28cpld-gpio), one
+  output-only (kontron,sl28-gpo) and one input-only (kontron,sl28-gpi).
+
+  Each controller supports 8 GPIO lines.
+
+properties:
+  compatible:
+    enum:
+      - kontron,sl28cpld-gpio
+      - kontron,sl28cpld-gpi
+      - kontron,sl28cpld-gpo
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupt-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  gpio-line-names:
+      minItems: 1
+      maxItems: 8
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
new file mode 100644
index 000000000000..1cebd61c6c32
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/kontron,sl28cpld-hwmon.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/kontron,sl28cpld-hwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hardware monitoring driver for the sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description: |
+  This module is part of the sl28cpld multi-function device. For more
+  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
+
+properties:
+  compatible:
+    enum:
+      - kontron,sl28cpld-fan
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
new file mode 100644
index 000000000000..4c39e9ff9aea
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/kontron,sl28cpld-intc.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/kontron,sl28cpld-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Interrupt controller driver for the sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description: |
+  This module is part of the sl28cpld multi-function device. For more
+  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
+
+  The following interrupts are available. All types and levels are fixed
+  and handled by the board management controller.
+
+  ==== ============= ==================================
+   IRQ line/device   description
+  ==== ============= ==================================
+    0  RTC_INT#      Interrupt line from on-board RTC
+    1  SMB_ALERT#    Event on SMB_ALERT# line (P1)
+    2  ESPI_ALERT0#  Event on ESPI_ALERT0# line (S43)
+    3  ESPI_ALERT1#  Event on ESPI_ALERT1# line (S44)
+    4  PWR_BTN#      Event on PWR_BTN# line (P128)
+    5  SLEEP#        Event on SLEEP# line (S149)
+    6  watchdog      Interrupt of the internal watchdog
+    7  n/a           not used
+  ==== ============= ==================================
+
+properties:
+  compatible:
+    enum:
+      - kontron,sl28cpld-intc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupt-controller: true
+
+required:
+  - compatible
+  - interrupts
+  - "#interrupt-cells"
+  - interrupt-controller
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
new file mode 100644
index 000000000000..e3a62db678e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/kontron,sl28cpld.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kontron's sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description: |
+  The board management controller may contain different IP blocks like
+  watchdog, fan monitoring, PWM controller, interrupt controller and a
+  GPIO controller.
+
+properties:
+  compatible:
+    const: kontron,sl28cpld-r1
+
+  reg:
+    description:
+      I2C device address.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+patternProperties:
+  "^gpio(@[0-9a-f]+)?$":
+    $ref: ../gpio/kontron,sl28cpld-gpio.yaml
+
+  "^hwmon(@[0-9a-f]+)?$":
+    $ref: ../hwmon/kontron,sl28cpld-hwmon.yaml
+
+  "^interrupt-controller(@[0-9a-f]+)?$":
+    $ref: ../interrupt-controller/kontron,sl28cpld-intc.yaml
+
+  "^pwm(@[0-9a-f]+)?$":
+    $ref: ../pwm/kontron,sl28cpld-pwm.yaml
+
+  "^watchdog(@[0-9a-f]+)?$":
+    $ref: ../watchdog/kontron,sl28cpld-wdt.yaml
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sl28cpld@4a {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "kontron,sl28cpld-r1";
+            reg = <0x4a>;
+
+            watchdog@4 {
+                compatible = "kontron,sl28cpld-wdt";
+                reg = <0x4>;
+                kontron,assert-wdt-timeout-pin;
+            };
+
+            hwmon@b {
+                compatible = "kontron,sl28cpld-fan";
+                reg = <0xb>;
+            };
+
+            pwm@c {
+                #pwm-cells = <2>;
+                compatible = "kontron,sl28cpld-pwm";
+                reg = <0xc>;
+            };
+
+            pwm@e {
+                #pwm-cells = <2>;
+                compatible = "kontron,sl28cpld-pwm";
+                reg = <0xe>;
+            };
+
+            gpio@10 {
+                compatible = "kontron,sl28cpld-gpio";
+                reg = <0x10>;
+                interrupts-extended = <&gpio2 6
+                               IRQ_TYPE_EDGE_FALLING>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+                gpio-line-names = "a", "b", "c";
+
+                interrupt-controller;
+                #interrupt-cells = <2>;
+            };
+
+            gpio@15 {
+                compatible = "kontron,sl28cpld-gpio";
+                reg = <0x15>;
+                interrupts-extended = <&gpio2 6
+                               IRQ_TYPE_EDGE_FALLING>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+
+                interrupt-controller;
+                #interrupt-cells = <2>;
+            };
+
+            gpio@1a {
+                compatible = "kontron,sl28cpld-gpo";
+                reg = <0x1a>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            gpio@1b {
+                compatible = "kontron,sl28cpld-gpi";
+                reg = <0x1b>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+            };
+
+            interrupt-controller@1c {
+                compatible = "kontron,sl28cpld-intc";
+                reg = <0x1c>;
+                interrupts-extended = <&gpio2 6
+                               IRQ_TYPE_EDGE_FALLING>;
+
+                interrupt-controller;
+                #interrupt-cells = <2>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml b/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
new file mode 100644
index 000000000000..02fe88c30233
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/kontron,sl28cpld-pwm.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/kontron,sl28cpld-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM driver for the sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description: |
+  This module is part of the sl28cpld multi-function device. For more
+  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
+
+  The controller supports one PWM channel and supports only four distinct
+  frequencies (250Hz, 500Hz, 1kHz, 2kHz).
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: kontron,sl28cpld-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
new file mode 100644
index 000000000000..dd6559f2973a
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/kontron,sl28cpld-wdt.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/kontron,sl28cpld-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Watchdog driver for the sl28cpld board management controller
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description: |
+  This module is part of the sl28cpld multi-function device. For more
+  details see Documentation/devicetree/bindings/mfd/kontron,sl28cpld.yaml.
+
+allOf:
+  - $ref: watchdog.yaml#
+
+properties:
+  compatible:
+    const: kontron,sl28cpld-wdt
+
+  reg:
+    maxItems: 1
+
+  kontron,assert-wdt-timeout-pin:
+    description: The SMARC standard defines a WDT_TIME_OUT# pin. If this
+      property is set, this output will be pulsed when the watchdog bites
+      and the system resets.
+    type: boolean
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.20.1

