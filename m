Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4045374F2C
	for <lists+linux-pwm@lfdr.de>; Thu,  6 May 2021 08:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhEFGKo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 May 2021 02:10:44 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:27440 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhEFGKo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 May 2021 02:10:44 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1465vjqF003653;
        Thu, 6 May 2021 13:57:45 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 May
 2021 14:09:32 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <p.zabel@pengutronix.de>,
        <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v3 1/2] dt-bindings: Add bindings for aspeed pwm-tach and pwm.
Date:   Thu, 6 May 2021 14:10:49 +0800
Message-ID: <20210506061050.8001-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506061050.8001-1-billy_tsai@aspeedtech.com>
References: <20210506061050.8001-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1465vjqF003653
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds device bindings for aspeed pwm-tach device which is a
multi-function device include pwn and tach function and pwm device which
should be the sub-node of pwm-tach device.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 55 +++++++++++++++++++
 .../bindings/pwm/aspeed,ast2600-pwm.yaml      | 41 ++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
new file mode 100644
index 000000000000..9626bbd50acd
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
@@ -0,0 +1,55 @@
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
+additionalProperties:
+  type: object
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
+        #pwm-cells = <3>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
new file mode 100644
index 000000000000..78db1c9c9b10
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/aspeed,ast2600-pwm.yaml
@@ -0,0 +1,41 @@
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
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-pwm
+
+  "#pwm-cells":
+    const: 3
+
+additionalProperties: false
+
+examples:
+  - |
+    // The PWM should be a subnode of a "aspeed,ast2600-pwm-tach" compatible
+    // node.
+    #include <dt-bindings/clock/ast2600-clock.h>
+    pwm_tach: pwm_tach@1e610000 {
+      compatible = "aspeed,ast2600-pwm-tach", "syscon", "simple-mfd";
+      reg = <0x1e610000 0x100>;
+      clocks = <&syscon ASPEED_CLK_AHB>;
+      resets = <&syscon ASPEED_RESET_PWM>;
+
+      pwm: pwm {
+        compatible = "aspeed,ast2600-pwm";
+        #pwm-cells = <3>;
+      };
+    };
-- 
2.25.1

