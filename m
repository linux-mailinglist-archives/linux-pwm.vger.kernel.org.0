Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17305247E0E
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Aug 2020 07:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHRFtU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Aug 2020 01:49:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:47304 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgHRFtT (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 18 Aug 2020 01:49:19 -0400
IronPort-SDR: kxvHZXnIuRuVGWsgC0mpJ98lE/Vd9h54i5zGrzbjmFxVgCfPsN5l8d3h2wcmpamiz4YbBu/qTx
 bqgbu/rKxMZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="155928944"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="155928944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 22:49:18 -0700
IronPort-SDR: 2r4oizdbtCbzxCiA8qrrdV2WRmK0KB9faF4XiZK1hQ5AbXTBcdZC95K/68qxIPDwr3fnzkIq4Z
 RfdlKr9/NBEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="279310662"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2020 22:49:15 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v7 1/2] Add DT bindings YAML schema for PWM fan controller of LGM SoC
Date:   Tue, 18 Aug 2020 13:49:00 +0800
Message-Id: <071226b34783c8ab2ce44f8cc50ec00c04fbdd2b.1597729246.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1597729246.git.rahul.tanwar@linux.intel.com>
References: <cover.1597729246.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1597729246.git.rahul.tanwar@linux.intel.com>
References: <cover.1597729246.git.rahul.tanwar@linux.intel.com>
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
 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
new file mode 100644
index 000000000000..289b82213e23
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
@@ -0,0 +1,54 @@
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
+  pwm-fanmode:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description: Specifies PWM fan mode. Default when unspecified is 2.
+
+  pwm-maxrpm:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description:
+      Specifies maximum RPM of PWM fan attached to the system.
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
+        #pwm-cells = <2>;
+        clocks = <&cgu0 126>;
+        resets = <&rcu0 0x30 21>;
+    };
-- 
2.11.0

