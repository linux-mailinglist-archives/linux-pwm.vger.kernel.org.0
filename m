Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6A03638AF
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Apr 2021 02:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbhDSABu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 18 Apr 2021 20:01:50 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:35578 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbhDSABk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 18 Apr 2021 20:01:40 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 13J00mFs005342; Mon, 19 Apr 2021 09:00:48 +0900
X-Iguazu-Qid: 2wHHDhxhkSqFDgunU4
X-Iguazu-QSIG: v=2; s=0; t=1618790447; q=2wHHDhxhkSqFDgunU4; m=bSI9vm50ZitVrBUKhnOZZ5HUX2GU6gHVq1ZVUX65HxA=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1113) id 13J00kCQ028669
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 09:00:46 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 4F1E31000B7;
        Mon, 19 Apr 2021 09:00:46 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 13J00jjF002370;
        Mon, 19 Apr 2021 09:00:45 +0900
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
Subject: [PATCH v6 1/2] dt-bindings: pwm: Add bindings for Toshiba Visconti PWM Controller
Date:   Mon, 19 Apr 2021 09:00:06 +0900
X-TSB-HOP: ON
Message-Id: <20210419000007.1944301-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210419000007.1944301-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210419000007.1944301-1-nobuhiro1.iwamatsu@toshiba.co.jp>
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

