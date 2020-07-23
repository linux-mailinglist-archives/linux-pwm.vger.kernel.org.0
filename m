Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78922A9EC
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 09:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGWHoa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 03:44:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:20836 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgGWHoa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 23 Jul 2020 03:44:30 -0400
IronPort-SDR: Ymea8dzdLTrE5mhxogfs4W0v7193/coyhSoOjdDBO8sood0kAAAODzag1xQOsL6svz5m9ypfc/
 LFBThBdwpQBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="147972728"
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="147972728"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 00:44:29 -0700
IronPort-SDR: 1926ICqp1GvFwOqFAx1zwC0zvd52mPobZKvYY8hvfuIHIT7Hjwl/NoYupDFaiUpzTLWIdGWuhb
 SdmGz91brnZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,385,1589266800"; 
   d="scan'208";a="272230470"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jul 2020 00:44:26 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v5 1/2] Add DT bindings YAML schema for PWM fan controller of LGM SoC
Date:   Thu, 23 Jul 2020 15:44:17 +0800
Message-Id: <4e975206fcbddedc746e8d39b620336d5fab8b14.1595489518.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
References: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
References: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
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
 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
new file mode 100644
index 000000000000..0211a0dc79ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
@@ -0,0 +1,40 @@
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

