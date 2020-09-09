Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115682631E6
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Sep 2020 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgIIQ3w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Sep 2020 12:29:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:4048 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730978AbgIIQ3b (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 9 Sep 2020 12:29:31 -0400
IronPort-SDR: gV4oEhuq0jHlRbOy0fOzLL63uBw9g1D/xr0j37OgW9XbXisbKDuzfegA7HZnYeKvyq4sS2QYti
 U5oHdPi5MXUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="243175917"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="243175917"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 09:29:28 -0700
IronPort-SDR: rUpC/Ggy4ojxN8XqqYd8DRB1SP5lkh08ZMVP5XrZkM3MTd8sLCJUsdV7FN7fL+03l9uX0ef+Ni
 l5565xH7oHDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="343945127"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by orsmga007.jf.intel.com with ESMTP; 09 Sep 2020 09:29:25 -0700
From:   vijayakannan.ayyathurai@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: [PATCH v7 2/2] dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
Date:   Thu, 10 Sep 2020 00:27:19 +0800
Message-Id: <20200909162719.7585-3-vijayakannan.ayyathurai@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
References: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.

Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../bindings/pwm/intel,keembay-pwm.yaml       | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml b/Documentation/devicetree/bindings/pwm/intel,keembay-pwm.yaml
new file mode 100644
index 000000000000..a37433487632
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
2.17.1

