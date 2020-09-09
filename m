Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A826293C
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Sep 2020 09:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIHwJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Sep 2020 03:52:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:16426 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgIIHwI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 9 Sep 2020 03:52:08 -0400
IronPort-SDR: UILeFe14gj6sOc1yuB8rbH1x4po87IIacuA0OWlF+YlROxYCoW0ORLH7/LgxBgqpoushXEMjzc
 M4XfsqC/dz8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="146005620"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="146005620"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 00:52:08 -0700
IronPort-SDR: 7sjshZpzj43z07R3nV7+O3dUTw5kSgZRS4O3BG4RVBKOE8N1AGM00NRTk3ZcFp9nHqFfq15lPz
 z2GKXErmOP1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="286141150"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2020 00:52:04 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v12 1/2] Add DT bindings YAML schema for PWM fan controller of LGM SoC
Date:   Wed,  9 Sep 2020 15:51:56 +0800
Message-Id: <a5b9fefb58a6fe16964219b0d443bf81c58f5445.1599637734.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1599637734.git.rahul.tanwar@linux.intel.com>
References: <cover.1599637734.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1599637734.git.rahul.tanwar@linux.intel.com>
References: <cover.1599637734.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Intel's LGM(Lightning Mountain) SoC contains a PWM fan controller
which is only used to control the fan attached to the system. This
PWM controller does not have any other consumer other than fan.
Add DT bindings documentation for this PWM fan controller.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

