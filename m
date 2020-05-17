Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060141D6853
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgEQN4K (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 09:56:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:63618 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgEQN4K (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 17 May 2020 09:56:10 -0400
IronPort-SDR: 3LRQWAHT6Q7zxGmD87wgS5scuN1/wuYq/DVttWXE9V0+duGa6f1us64Z14CXVZioCjE1A1Zb4Q
 5B5z3L3VJAFw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 06:56:10 -0700
IronPort-SDR: +15jN2GeaJoZYfAL8vEPLG3p089NSTilueHLLHONXLtCLXx7LJL5f58V8Y1YodL3gtR308rgg9
 RJiDFxDtEeDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,403,1583222400"; 
   d="scan'208";a="263694173"
Received: from vgjayaku-ilbpg7.png.intel.com ([10.88.227.96])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2020 06:56:08 -0700
From:   vineetha.g.jaya.kumaran@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@intel.com, vineetha.g.jaya.kumaran@intel.com
Subject: [PATCH 3/3] dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
Date:   Sun, 17 May 2020 21:52:40 +0800
Message-Id: <1589723560-5734-4-git-send-email-vineetha.g.jaya.kumaran@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
References: <1589723560-5734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>

Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.

Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
---
 .../devicetree/bindings/pwm/pwm-keembay.yaml       | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-keembay.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
new file mode 100644
index 0000000..00968d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-keembay.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 Intel Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-keembay.yaml#
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
+    description:
+        phandle to the reference clock.
+
+required:
+ - compatible
+ - reg
+ - clocks
+
+examples:
+  - |
+    pwm@203200a0 {
+      compatible = "intel,keembay-pwm";
+      reg = <0x0 0x203200a0 0x0 0xe8>;
+      clocks = <&scmi_clk KEEM_BAY_A53_GPIO>;
+    };
-- 
1.9.1

