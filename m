Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F4162E732
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 22:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiKQVnN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 16:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbiKQVmw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 16:42:52 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B04B68C50;
        Thu, 17 Nov 2022 13:42:51 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gv23so8492999ejb.3;
        Thu, 17 Nov 2022 13:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WU2FtKz2cQUGKZlIODWTKfxDXDSrXrZii2EAiH6b2SY=;
        b=XCEAWPRv/khshr0AUdo0MZLOaCnjU8u2XmEzlMWPTscjgepeUipdmhuuYY7ePSmXFV
         hFzASZFgPgiR9eA3nxh89cUH0rs+KrbaNYHWshXdM4RWzyY7Pw98Uk8YR96cNBYIkBJH
         U2qLaPv7tn4v8phnhqyqfVvYDqDdSZBkm52q/ZG7xto7PglVZw27m+9W+ZNjZvR36G2n
         X1fw0B+qhQSRabWbR28i2IuTFz99QdboxOeqlvPepNIhs1sxlj/1JmKAo0BtmX6d/QqN
         XmO5Q0dZJXM4AoTejbuEc37VflPA6P77NQ4bqVbMHJ7Yp5CfmWfQ6jWUMCAqNl6Hlfyn
         plVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WU2FtKz2cQUGKZlIODWTKfxDXDSrXrZii2EAiH6b2SY=;
        b=4khzee5DLY6W3m26V8Nj749ksDwpag/drZvtUyDfCDrJ7+B0Ii4jXPK1kr7+ORtfk8
         G0ax7kvdLPtZWii2SLqrvsxoey9Idc7GTe+dF/1HiPH8Db/fUqoXhzHuAbkoBAlKy8ZX
         I/RxahdL5IRMTZPOmumjX2uokSExBEme7cEkzqP85V+IqzYRZS1T2DsmFPTnq05nuPWS
         QyR1gBkEwoWbGua3iXjxy81RJOab/cHca+7kck3oGw0o2LnvrxuEiNBKEbW+QaDCOo3J
         OQrSw6Xtfa+ISU3RlnrW6LL6+j47oOt2g/2v12c+WJ0107+igvuHvwzB+1hkfZ2WpvZa
         6XnQ==
X-Gm-Message-State: ANoB5pno/LlLO0WPgFjA9Dflj/bJU0mb02X/76KcOA23j8wI4Gh5VCkY
        mFMIUxA7FUdy+n8MG0iR8pI=
X-Google-Smtp-Source: AA0mqf6ejPg8pXDTuDhUQHYoqW6llWNB4o/HdjxTJBbH5Gn/02dhI2debUVLj9v0eB9tUJzTgigLQg==
X-Received: by 2002:a17:906:19d2:b0:78e:11ea:8528 with SMTP id h18-20020a17090619d200b0078e11ea8528mr3832415ejd.190.1668721369551;
        Thu, 17 Nov 2022 13:42:49 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qp25-20020a170907207900b007081282cbd8sm854074ejb.76.2022.11.17.13.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:42:49 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2] dt-bindings: pwm: tegra: Convert to json-schema
Date:   Thu, 17 Nov 2022 22:42:48 +0100
Message-Id: <20221117214248.2365983-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Tegra PWFM bindings from the free-form text format to
json-schema.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- drop Tegra210 example so that validation doesn't fail due to missing
  pinmux json-schema conversion
- combine Tegra20 and Tegra186 compatible strings
- drop useless description of the single clock
- remove clock-names property
- remove unnecessary quotes

 .../bindings/pwm/nvidia,tegra20-pwm.txt       | 78 ---------------
 .../bindings/pwm/nvidia,tegra20-pwm.yaml      | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
deleted file mode 100644
index 47f1abf20118..000000000000
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-Tegra SoC PWFM controller
-
-Required properties:
-- compatible: Must be:
-  - "nvidia,tegra20-pwm": for Tegra20
-  - "nvidia,tegra30-pwm", "nvidia,tegra20-pwm": for Tegra30
-  - "nvidia,tegra114-pwm", "nvidia,tegra20-pwm": for Tegra114
-  - "nvidia,tegra124-pwm", "nvidia,tegra20-pwm": for Tegra124
-  - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
-  - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
-  - "nvidia,tegra186-pwm": for Tegra186
-  - "nvidia,tegra194-pwm": for Tegra194
-  - "nvidia,tegra234-pwm", "nvidia,tegra194-pwm": for Tegra234
-- reg: physical base address and length of the controller's registers
-- #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
-  the cells format.
-- clocks: Must contain one entry, for the module clock.
-  See ../clocks/clock-bindings.txt for details.
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - pwm
-
-Optional properties:
-============================
-In some of the interface like PWM based regulator device, it is required
-to configure the pins differently in different states, especially in suspend
-state of the system. The configuration of pin is provided via the pinctrl
-DT node as detailed in the pinctrl DT binding document
-	Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
-The PWM node will have following optional properties.
-pinctrl-names:	Pin state names. Must be "default" and "sleep".
-pinctrl-0:	phandle for the default/active state of pin configurations.
-pinctrl-1:	phandle for the sleep state of pin configurations.
-
-Example:
-
-	pwm: pwm@7000a000 {
-		compatible = "nvidia,tegra20-pwm";
-		reg = <0x7000a000 0x100>;
-		#pwm-cells = <2>;
-		clocks = <&tegra_car 17>;
-		resets = <&tegra_car 17>;
-		reset-names = "pwm";
-	};
-
-
-Example with the pin configuration for suspend and resume:
-=========================================================
-Suppose pin PE7 (On Tegra210) interfaced with the regulator device and
-it requires PWM output to be tristated when system enters suspend.
-Following will be DT binding to achieve this:
-
-#include <dt-bindings/pinctrl/pinctrl-tegra.h>
-
-	pinmux@700008d4 {
-		pwm_active_state: pwm_active_state {
-                        pe7 {
-                                nvidia,pins = "pe7";
-                                nvidia,tristate = <TEGRA_PIN_DISABLE>;
-			};
-		};
-
-		pwm_sleep_state: pwm_sleep_state {
-                        pe7 {
-                                nvidia,pins = "pe7";
-                                nvidia,tristate = <TEGRA_PIN_ENABLE>;
-			};
-		};
-	};
-
-	pwm@7000a000 {
-		/* Mandatory PWM properties */
-		pinctrl-names = "default", "sleep";
-		pinctrl-0 = <&pwm_active_state>;
-		pinctrl-1 = <&pwm_sleep_state>;
-	};
diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
new file mode 100644
index 000000000000..739d3155dd32
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/nvidia,tegra20-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra PWFM controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nvidia,tegra20-pwm
+          - nvidia,tegra186-pwm
+
+      - items:
+          - enum:
+              - nvidia,tegra30-pwm
+              - nvidia,tegra114-pwm
+              - nvidia,tegra124-pwm
+              - nvidia,tegra132-pwm
+              - nvidia,tegra210-pwm
+          - enum:
+              - nvidia,tegra20-pwm
+
+      - items:
+          - const: nvidia,tegra194-pwm
+          - const: nvidia,tegra186-pwm
+
+      - items:
+          - const: nvidia,tegra234-pwm
+          - const: nvidia,tegra194-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: module reset
+
+  reset-names:
+    items:
+      - const: pwm
+
+  "#pwm-cells":
+    const: 2
+
+  pinctrl-names:
+    items:
+      - const: default
+      - const: sleep
+
+  pinctrl-0:
+    description: configuration for the default/active state
+
+  pinctrl-1:
+    description: configuration for the sleep state
+
+  operating-points-v2:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  power-domains:
+    items:
+      - description: phandle to the core power domain
+
+allOf:
+  - $ref: pwm.yaml
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra20-car.h>
+
+    pwm: pwm@7000a000 {
+        compatible = "nvidia,tegra20-pwm";
+        reg = <0x7000a000 0x100>;
+        #pwm-cells = <2>;
+        clocks = <&tegra_car TEGRA20_CLK_PWM>;
+        resets = <&tegra_car 17>;
+        reset-names = "pwm";
+    };
-- 
2.38.1

