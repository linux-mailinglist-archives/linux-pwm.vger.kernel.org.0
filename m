Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2CF27F922
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Oct 2020 07:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgJAFkV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Oct 2020 01:40:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:19677 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAFkU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 1 Oct 2020 01:40:20 -0400
IronPort-SDR: b0D8siVmXNaD3QLk17uSI5Vj15KRchiYcZ59BiI6wJ5jnV2Gi5bqxk3s8yuyTuMIYrnERdHrFl
 eozemEfAsF3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="224244708"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="224244708"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 22:40:20 -0700
IronPort-SDR: ZeQ/HmMGugdir6cS+MJc4G09CmF7OSw/ec7Bucckqe22Oy7TRXkBZ7TUr5WCe5lJYzmKPBAcSD
 1MhuR02Wz8hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="514552266"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by fmsmga006.fm.intel.com with ESMTP; 30 Sep 2020 22:40:18 -0700
From:   vijayakannan.ayyathurai@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        vijayakannan.ayyathurai@intel.com
Subject: [PATCH v9 2/2] dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
Date:   Thu,  1 Oct 2020 13:37:51 +0800
Message-Id: <20201001053751.10405-3-vijayakannan.ayyathurai@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001053751.10405-1-vijayakannan.ayyathurai@intel.com>
References: <20201001053751.10405-1-vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.

Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
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

