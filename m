Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E00528E774
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Oct 2020 21:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgJNTjO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Oct 2020 15:39:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:16163 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgJNTjO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 14 Oct 2020 15:39:14 -0400
IronPort-SDR: LjBv2n56mODcpKexm/nF2aUoElOsi9h7sP+XSbAS6058oM4gkRzFLfsf4Lz0bRpcAuOjqPoiHj
 8Z5hVZkAvcVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="165390037"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="165390037"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 12:39:12 -0700
IronPort-SDR: QggV1lL5+ueOyQwDLCZWEpW7+fHx4cik/TX5ZRDsT2n5ecSLJ+tySIV8NI29ojSL6l90dm3Zwp
 7JDMI/xBValA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="351595986"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by fmsmga002.fm.intel.com with ESMTP; 14 Oct 2020 12:39:10 -0700
From:   vijayakannan.ayyathurai@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        vijayakannan.ayyathurai@intel.com
Subject: [PATCH v12 2/2] dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
Date:   Thu, 15 Oct 2020 03:36:10 +0800
Message-Id: <9cff78f955eb7b1f243380c79cdd48aa6d2ddc81.1602703463.git.vijayakannan.ayyathurai@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
In-Reply-To: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
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

