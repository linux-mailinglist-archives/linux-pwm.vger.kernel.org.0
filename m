Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465C6252B5E
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Aug 2020 12:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgHZK1b (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Aug 2020 06:27:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:13396 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgHZK13 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Aug 2020 06:27:29 -0400
IronPort-SDR: vs0AHLDefYozqd6t3WJxRSS0MsMTIXgK8Wp8SYfiUn8QoxRCJOtlR0W8y2U/4i0XwoZlfTCq2v
 Q4myRPcB121A==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="217813981"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="217813981"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 03:27:29 -0700
IronPort-SDR: u/W915HsqS8dQB+oVmMwsukJLKLwOmbsdZU/SVAmJSBEIKZRXKIFYRagQZJD/JkCa7ahGCmKpJ
 MglXJsyLmnKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="299423395"
Received: from vgjayaku-ilbpg7.png.intel.com ([10.88.227.96])
  by orsmga006.jf.intel.com with ESMTP; 26 Aug 2020 03:27:27 -0700
From:   vineetha.g.jaya.kumaran@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: [PATCH v5 2/2] dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
Date:   Wed, 26 Aug 2020 18:25:59 +0800
Message-Id: <1598437559-25828-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1598437559-25828-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
References: <1598437559-25828-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>

Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
---
 .../devicetree/bindings/pwm/intel,keembay-pwm.yaml | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
new file mode 100644
index 00000000..a374334
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Intel Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/intel,keembay-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Keem Bay PWM Device Tree Bindings
+
+maintainers:
+  - Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    enum:
+      - intel,keembay-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+ - compatible
+ - reg
+ - clocks
+ - '#pwm-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #define KEEM_BAY_A53_GPIO
+
+    pwm@203200a0 {
+      compatible = "intel,keembay-pwm";
+      reg = <0x203200a0 0xe8>;
+      clocks = <&scmi_clk KEEM_BAY_A53_GPIO>;
+      #pwm-cells = <2>;
+    };
-- 
1.9.1

