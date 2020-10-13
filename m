Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B321F28D381
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgJMSRO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 14:17:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:6974 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgJMSRN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Oct 2020 14:17:13 -0400
IronPort-SDR: oIU4HQTHJ3fGMF2suq6JsU/QFKpLS/ptsxz5Uz/JYVbqjloY3+pWOowQDbm6ncFL8NiqRb+/yP
 fAjlB/zYthMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="165169277"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="165169277"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 11:17:13 -0700
IronPort-SDR: 8vXrQWfJ33m9qYci7GSkRkX6JYLgpsy4RWId5VwfnM/U8YDGLk2B1HGEZIHtDN+uUBfQ7g4+H9
 6hk/UojP3R8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="521131497"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by fmsmga005.fm.intel.com with ESMTP; 13 Oct 2020 11:17:10 -0700
From:   vijayakannan.ayyathurai@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        vijayakannan.ayyathurai@intel.com
Subject: [PATCH v11 2/2] dt-bindings: pwm: keembay: Add bindings for Intel Keem Bay PWM
Date:   Wed, 14 Oct 2020 02:14:13 +0800
Message-Id: <3b857e98962b755251dd7285abaa24a2f389688f.1602612067.git.vijayakannan.ayyathurai@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602612067.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1602612067.git.vijayakannan.ayyathurai@intel.com>
In-Reply-To: <cover.1602612067.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1602612067.git.vijayakannan.ayyathurai@intel.com>
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

