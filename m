Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A3B1DE129
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 09:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgEVHmL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 03:42:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:12119 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgEVHmJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 22 May 2020 03:42:09 -0400
IronPort-SDR: s+rHtuqsfpsAvxj9b84zoMQhZLraD+d4/+gCment8mxFy6xuhkMVf2ca7imkUI/paepm3KSV09
 bcDfUlNZYWrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 00:42:09 -0700
IronPort-SDR: 7fwHEQRbpziYxtUvaI6lAKmDy6CpE/ASFupWP+b9BiyJyW5zXP7MV1U4s7c6KhT3vYNJ6LnrT7
 970LgVyIjxsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,420,1583222400"; 
   d="scan'208";a="283323614"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2020 00:42:06 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v1 1/2] Add YAML schema for a new PWM driver
Date:   Fri, 22 May 2020 15:41:58 +0800
Message-Id: <53333e2a30f123065a68a3a24042ead982393164.1590132733.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add DT bindings YAML schema for PWM controller driver of
Lightning Mountain(LGM) SoC.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/pwm/pwm-intel-lgm.yaml     | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml b/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
new file mode 100644
index 000000000000..adb33265aa5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-intel-lgm.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-intel-lgm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LGM SoC PWM controller
+
+maintainers:
+  - Rahul Tanwar <rahul.tanwar@intel.com>
+
+properties:
+  compatible:
+    const: intel,lgm-pwm
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+  - clocks
+  - resets
+
+examples:
+  - |
+    pwm: pwm@e0d00000 {
+        compatible = "intel,lgm-pwm";
+        reg = <0xe0d00000 0x30>;
+        #pwm-cells = <2>;
+        clocks = <&cgu0 126>;
+        resets = <&rcu0 0x30 21>;
+    };
-- 
2.11.0

