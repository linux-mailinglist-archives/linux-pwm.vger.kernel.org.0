Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0467319FC3
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Feb 2021 14:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhBLNWA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Feb 2021 08:22:00 -0500
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:36692 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhBLNVu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Feb 2021 08:21:50 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 11CDJS4j014513; Fri, 12 Feb 2021 22:19:28 +0900
X-Iguazu-Qid: 2wGqn5DuWpbZZCpp4q
X-Iguazu-QSIG: v=2; s=0; t=1613135968; q=2wGqn5DuWpbZZCpp4q; m=Z20x/stw9IjYjNipnTj02kjN3WwyptGZtjzUyhmYWYQ=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1110) id 11CDJR6o026389;
        Fri, 12 Feb 2021 22:19:27 +0900
Received: from enc01.toshiba.co.jp ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 11CDJRA3018973;
        Fri, 12 Feb 2021 22:19:27 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 11CDJQRC001989;
        Fri, 12 Feb 2021 22:19:26 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2 1/2] dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
Date:   Fri, 12 Feb 2021 22:19:09 +0900
X-TSB-HOP: ON
Message-Id: <20210212131910.557581-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add bindings for the Toshiba Visconti PWM Controller.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../bindings/pwm/toshiba,pwm-visconti.yaml    | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml

diff --git a/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
new file mode 100644
index 000000000000..f11558cdc32f
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
+      - const: toshiba,pwm-visconti
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
+            compatible = "toshiba,pwm-visconti";
+            reg = <0 0x241c0000 0 0x1000>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pwm_mux>;
+            #pwm-cells = <2>;
+        };
+    };
-- 
2.30.0.rc2

