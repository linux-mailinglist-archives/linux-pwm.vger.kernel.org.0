Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087F135C3D2
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 12:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbhDLKY1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 06:24:27 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:55474 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbhDLKYT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 06:24:19 -0400
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 13C9ifcK096490
        for <linux-pwm@vger.kernel.org>; Mon, 12 Apr 2021 17:44:41 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 13C9iS0n096463;
        Mon, 12 Apr 2021 17:44:28 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 17:54:50 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <p.zabel@pengutronix.de>,
        <billy_tasi@aspeedtech.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 1/4] dt-bindings: Add bindings for aspeed pwm-tach.
Date:   Mon, 12 Apr 2021 17:54:54 +0800
Message-ID: <20210412095457.15095-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 13C9iS0n096463
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch adds device bindings for aspeed pwm-tach device which is a
multi-function device include pwn and tach function.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/mfd/aspeed,ast2600-pwm-tach.yaml | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml

diff --git a/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
new file mode 100644
index 000000000000..73512ff71d23
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aspeed,ast2600-pwm-tach.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 ASPEED, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/aspeed,ast2600-pwn-tach.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PWM Tach controller Device Tree Bindings
+
+description: |
+  The PWM Tach controller is represented as a multi-function device which includes:
+    PWM
+    Tach
+
+maintainers:
+  - Billy Tsai <billy_tasi@aspeedtech.com>
+
+properties:
+  compatible:
+    - items:
+        - enum:
+            - aspeed,ast2600-pwn-tach
+        - const: syscon
+        - const: simple-mfd
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm_tach: pwm_tach@1e610000 {
+      compatible = "aspeed,ast2600-pwm-tach", "simple-mfd", "syscon";
+      #address-cells = <1>;
+      #size-cells = <1>;
+      reg = <0x1e610000 0x100>;
+
+      pwm: pwm@0 {
+        compatible = "aspeed,ast2600-pwm";
+        #pwm-cells = <3>;
+        reg = <0x0 0x100>;
+      };
+
+      tach: tach@0 {
+        compatible = "aspeed,ast2600-tach";
+        reg = <0x0 0x100>;
+      };
+    };
-- 
2.25.1

