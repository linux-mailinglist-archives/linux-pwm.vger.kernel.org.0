Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF7123A22C
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Aug 2020 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgHCJmm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Aug 2020 05:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgHCJmk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Aug 2020 05:42:40 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365CDC061757;
        Mon,  3 Aug 2020 02:42:38 -0700 (PDT)
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3134723E40;
        Mon,  3 Aug 2020 11:42:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1596447754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1QllJx1w4eW/sp75PkVZvdUNY2zx1Kc2TbgXVA5i+aU=;
        b=c5kanZmqMxfAYaM9pzbQD3ZvuCKz1YdZRp+od76VjBF3JzAoTcZhWXnJuhReXfJL2A9SDC
        NhUlu7RTDoWJL941YGTm7l0E6V4feSmFuSWxCIlx9Fa1k0NxGA++DK33JtaetiVzvgvskL
        r6UP1wntEzfskLaYd6Dg3XowauHvVvQ=
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH v7 02/13] dt-bindings: mfd: Add bindings for sl28cpld
Date:   Mon,  3 Aug 2020 11:35:48 +0200
Message-Id: <20200803093559.12289-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803093559.12289-1-michael@walle.cc>
References: <20200803093559.12289-1-michael@walle.cc>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes since v6:
 - renamed "sl28cpld-r1" to "sl28cpld"
 - made paths relative
 - moved "reg" and "compatible" to the top of a node

Changes since v5:
 - none

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
index 000000000000..e2d2c10e536a
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
+  details see ../mfd/kontron,sl28cpld.yaml.
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
index 000000000000..010333cb25c0
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
+  details see ../mfd/kontron,sl28cpld.yaml.
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
index 000000000000..e8dfa6507f64
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
+  details see ../mfd/kontron,sl28cpld.yaml.
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
index 000000000000..eb3b43547cb6
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
+    const: kontron,sl28cpld
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
+            compatible = "kontron,sl28cpld";
+            reg = <0x4a>;
+            #address-cells = <1>;
+            #size-cells = <0>;
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
+                compatible = "kontron,sl28cpld-pwm";
+                reg = <0xc>;
+                #pwm-cells = <2>;
+            };
+
+            pwm@e {
+                compatible = "kontron,sl28cpld-pwm";
+                reg = <0xe>;
+                #pwm-cells = <2>;
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
index 000000000000..981cfec53f37
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
+  details see ../mfd/kontron,sl28cpld.yaml.
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
index 000000000000..179272f74de5
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
+  details see ../mfd/kontron,sl28cpld.yaml.
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

