Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0326A24D193
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgHUJc1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Aug 2020 05:32:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:44789 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgHUJcX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 21 Aug 2020 05:32:23 -0400
IronPort-SDR: BLxb/Si5ueioOkUi4Yb6TSNh8yBjE95UQD5fKbDuIVYpbXEi+B8PUFyK+qUsQdzQehnQQ5iapj
 Sp0ztsZKe2Rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="240319058"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="240319058"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 02:32:23 -0700
IronPort-SDR: d21yNFJihXByneaQTrRhL7r73L1I0zGmE4d5341wcCVfKQWu196frNV+S0IiQyuU4tBFNp6BUb
 TFOZtg4+7Ogg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="280230221"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2020 02:32:20 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v9 1/2] Add DT bindings YAML schema for PWM fan controller of LGM SoC
Date:   Fri, 21 Aug 2020 17:32:10 +0800
Message-Id: <cb86a768550b592b5fc4713bd07689bf84ba044b.1598001442.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1598001442.git.rahul.tanwar@linux.intel.com>
References: <cover.1598001442.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1598001442.git.rahul.tanwar@linux.intel.com>
References: <cover.1598001442.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
which is only used to control the fan attached to the system. This
PWM controller does not have any other consumer other than fan.
Add DT bindings documentation for this PWM fan controller.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
new file mode 100644
index 000000000000..11a606536169
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/intel,lgm-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LGM SoC PWM fan controller
+
+maintainers:
+  - Rahul Tanwar <rtanwar@maxlinear.com>
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
+  - clocks
+  - resets
+
+additionalProperties: false
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

