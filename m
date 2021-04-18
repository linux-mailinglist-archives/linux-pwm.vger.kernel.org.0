Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070AF3634C0
	for <lists+linux-pwm@lfdr.de>; Sun, 18 Apr 2021 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236698AbhDRLKE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Apr 2021 07:10:04 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:46732 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbhDRLKE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Apr 2021 07:10:04 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 13IB9CkH003069; Sun, 18 Apr 2021 20:09:12 +0900
X-Iguazu-Qid: 2wHHJLHH07xBzaK9RI
X-Iguazu-QSIG: v=2; s=0; t=1618744152; q=2wHHJLHH07xBzaK9RI; m=iJXnjyHRFYdtaCI0PJvigV0jdAvBbIc14eo/qe7KI6w=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1110) id 13IB9BIS036070
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 18 Apr 2021 20:09:11 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 13FE71000B4;
        Sun, 18 Apr 2021 20:09:11 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 13IB9AXF016774;
        Sun, 18 Apr 2021 20:09:10 +0900
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
Subject: [PATCH v5 1/2] dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
Date:   Sun, 18 Apr 2021 20:09:03 +0900
X-TSB-HOP: ON
Message-Id: <20210418110904.1942806-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210418110904.1942806-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210418110904.1942806-1-nobuhiro1.iwamatsu@toshiba.co.jp>
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

