Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3931C20D1E2
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 20:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgF2Soh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 14:44:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:40916 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbgF2SoC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Jun 2020 14:44:02 -0400
IronPort-SDR: a+SOZ1NxVd3QEdWfn5A05yR/TJuFoBHoE9aq3qKb8KsLSD0o9HyPlbe9rqsP48BQO7HN2ErI5I
 ww7XNEoKknqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="134249545"
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="134249545"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 02:04:00 -0700
IronPort-SDR: STrvPj96RlAD7lPaaBOdSDyKih7aU1PdIQXeqvI1m6nWdHjjGCQy8LCHSPGJCI3J/c8s9USQH+
 Sn2Hajo4qAZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="294829170"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga002.jf.intel.com with ESMTP; 29 Jun 2020 02:03:56 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 1/2] Add DT bindings YAML schema for PWM fan controller of LGM SoC
Date:   Mon, 29 Jun 2020 17:03:46 +0800
Message-Id: <cd0692812e7f1bce365a7594b076ae0ed19d2b37.1593420979.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
References: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
References: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
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
 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
new file mode 100644
index 000000000000..bc3fbc46ec5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/intel,lgm-pwm.yaml
@@ -0,0 +1,51 @@
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
+        #pwm-cells = <2>;
+        clocks = <&cgu0 126>;
+        resets = <&rcu0 0x30 21>;
+    };
-- 
2.11.0

