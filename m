Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037E426E952
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Sep 2020 01:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgIQXQQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Sep 2020 19:16:16 -0400
Received: from mo-csw-fb1514.securemx.jp ([210.130.202.170]:45122 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgIQXQQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Sep 2020 19:16:16 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id 08HMWExS023499; Fri, 18 Sep 2020 07:32:14 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 08HMVqfK029069; Fri, 18 Sep 2020 07:31:52 +0900
X-Iguazu-Qid: 34trRpZzTmG2XpMcy6
X-Iguazu-QSIG: v=2; s=0; t=1600381911; q=34trRpZzTmG2XpMcy6; m=VBTIbfjMOovm/MfxIujNATw7A5El/AJAFSdlK+q5IiE=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1513) id 08HMVoIH012505;
        Fri, 18 Sep 2020 07:31:51 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 08HMVoag020156;
        Fri, 18 Sep 2020 07:31:50 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 08HMVoIX003096;
        Fri, 18 Sep 2020 07:31:50 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 1/2] dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
Date:   Fri, 18 Sep 2020 07:31:39 +0900
X-TSB-HOP: ON
Message-Id: <20200917223140.227542-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200917223140.227542-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200917223140.227542-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add bindings for the Toshiba Visconti PWM Controller.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../bindings/pwm/toshiba,pwm-visconti.yaml    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml

diff --git a/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
new file mode 100644
index 000000000000..9145e9478b41
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/toshiba,pwm-visconti.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0
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
+      - enum:
+          - toshiba,pwm-tmpv7708
+      - const: toshiba,pwm-visconti
+
+  reg:
+    # base address and length of the registers block for the PWM.
+    maxItems: 1
+
+  '#pwm-cells':
+    # should be 2. See pwm.yaml in this directory for a description of
+    # the cells format.
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
+            compatible = "toshiba,pwm-tmpv7708", "toshiba,pwm-visconti";
+            reg = <0 0x241c0000 0 0x1000>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pwm_mux>;
+            #pwm-cells = <2>;
+        };
+    };
-- 
2.27.0

