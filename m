Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7B35A915
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 01:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbhDIXJ2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 19:09:28 -0400
Received: from mo-csw1515.securemx.jp ([210.130.202.154]:54816 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbhDIXJ1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 19:09:27 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 139N8mwQ025391; Sat, 10 Apr 2021 08:08:48 +0900
X-Iguazu-Qid: 34trpShQHyR5GWaOzw
X-Iguazu-QSIG: v=2; s=0; t=1618009727; q=34trpShQHyR5GWaOzw; m=jJIK4W1wmjRMATCnSLh12MTAyo7+1SfpPUVz3gNmul4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 139N8lVv003776
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 10 Apr 2021 08:08:47 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 34AC41000D3;
        Sat, 10 Apr 2021 08:08:47 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 139N8kdt024949;
        Sat, 10 Apr 2021 08:08:46 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
Date:   Sat, 10 Apr 2021 08:08:36 +0900
X-TSB-HOP: ON
Message-Id: <20210409230837.1919744-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210409230837.1919744-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add bindings for the Toshiba Visconti PWM Controller.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pwm/toshiba,pwm-visconti.yaml    | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml

diff --git a/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
new file mode 100644
index 000000000000..d350f5edfb67
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/toshiba,pwm-visconti.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba Visconti PWM Controller
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+properties:
+  compatible:
+    items:
+      - const: toshiba,visconti-pwm
+
+  reg:
+    maxItems: 1
+
+  '#pwm-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - '#pwm-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pwm: pwm@241c0000 {
+            compatible = "toshiba,visconti-pwm";
+            reg = <0 0x241c0000 0 0x1000>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pwm_mux>;
+            #pwm-cells = <2>;
+        };
+    };
-- 
2.30.0.rc2

