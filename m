Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C71220EFF4
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 09:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgF3Hzo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jun 2020 03:55:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:11631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgF3Hzo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 30 Jun 2020 03:55:44 -0400
IronPort-SDR: QXV0+9Xu+ntc85sYZo3AfxI7e9zFAoDgko0hGqZ9r/VpooC4rxzPTsJOSXilIYQn64u/sUMp9f
 d03gnJzSRR6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="164181318"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="164181318"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 00:55:44 -0700
IronPort-SDR: etVdrMc7UBySrIWzt8zCoMe9MGGNKCdTsbWV+/KIV2yKD/AFn5FPaURfqhzcnQzV7N5gw0PFFS
 MPSZVTKc9tOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="295133629"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga002.jf.intel.com with ESMTP; 30 Jun 2020 00:55:40 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v4 1/2] Add DT bindings YAML schema for PWM fan controller of LGM SoC
Date:   Tue, 30 Jun 2020 15:55:31 +0800
Message-Id: <cfef33c19b97a9cfbb8ecc0c6a122f3c9a5b46dd.1593503228.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
References: <cover.1593503228.git.rahul.tanwar@linux.intel.com>
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
 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
new file mode 100644
index 000000000000..120bf3d85a24
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/intel,lgm-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LGM SoC PWM fan controller
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
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  intel,fan-wire:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: Specifies fan mode. Default when unspecified is 2.
+
+  intel,max-rpm:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description:
+      Specifies maximum RPM of fan attached to the system.
+      Default when unspecified is 4000.
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
+        clocks = <&cgu0 126>;
+        resets = <&rcu0 0x30 21>;
+    };
-- 
2.11.0

