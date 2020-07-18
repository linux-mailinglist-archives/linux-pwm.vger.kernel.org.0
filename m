Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAB6224C09
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jul 2020 16:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGROty (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 Jul 2020 10:49:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:3940 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGROty (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 18 Jul 2020 10:49:54 -0400
IronPort-SDR: vBbq3as+qeeIfHIAyhDUDZgT86XWJcpAd3qKSuBpZJIHg85QUg+ooAra/C1fnZ56jw4VKnasQu
 2FmRPHwCVDkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="129826079"
X-IronPort-AV: E=Sophos;i="5.75,367,1589266800"; 
   d="scan'208";a="129826079"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 07:49:54 -0700
IronPort-SDR: Lc+DHL93rLE70zHYVn7CQb9cLBNP23C9270cw6P3sYFvJUrMOEJQIA0gFNclWWV1rDrrRAZG6M
 KiCgx5HwJ5BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,367,1589266800"; 
   d="scan'208";a="300836352"
Received: from vgjayaku-ilbpg7.png.intel.com ([10.88.227.96])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2020 07:49:52 -0700
From:   vineetha.g.jaya.kumaran@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com
Subject: [PATCH v2 2/2] dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
Date:   Sat, 18 Jul 2020 22:47:08 +0800
Message-Id: <1595083628-20734-3-git-send-email-vineetha.g.jaya.kumaran@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
References: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>

Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.

Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
---
 .../devicetree/bindings/pwm/intel,keembay-pwm.yaml | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
new file mode 100644
index 00000000..e9388a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
@@ -0,0 +1,45 @@
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

