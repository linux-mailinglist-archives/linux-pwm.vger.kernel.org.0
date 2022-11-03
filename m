Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465A3617C14
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Nov 2022 13:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKCMBm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Nov 2022 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiKCMBl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Nov 2022 08:01:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00826DF11;
        Thu,  3 Nov 2022 05:01:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f7so2621523edc.6;
        Thu, 03 Nov 2022 05:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IQVmkJIfw+G4+zEwXF78WRi81YVym7RqqN9ditiGR8=;
        b=TaNdyEtKa8K1l5TrTQk2XV0W1b3PzqvsN2Lk8J0y6odluB6ib+TZQvGS61ahyrCdPe
         TgvYEf/idRaUC5aGbV4+Q8Sy7HksLdzJdwix+oPCRjjFk5W0Ygsv806WZAfnxLNKMNtC
         Oj6DNwxhsfRRj1AJdktzoIgCy+2WlNaq7t2QHFtBWsHmlED9oy3BJVpZRHosrEyP4Xec
         aWgjwBvWnA9KIvvCAK0JMAOFcAXkJz1gVL8O5HbIHVXA2CFIIUHaRbNra+E7zZRP75Mm
         og00eEcGwLEJCJ31wB2VaRqrKzhhclgdNRyx4Um8JfG0SJIYRO7nE5kEWN9GuTNCG25R
         ScGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IQVmkJIfw+G4+zEwXF78WRi81YVym7RqqN9ditiGR8=;
        b=Tm9ihkPVQ7eEqAyYhwtZpoxA6zGEKhc5LR5GVEGrhxZieT+GTAEkeOYunLX/bPKKpr
         968y3w7ktdBV7prbRpq5CMw22KWtyd/z90cnk+wUbxVF4T4OJz3d0DJNFEwh5CHJsT4M
         HC0WDQyZptvi4fWrb+o0ccWQWRRw6c6jKG+jgcX8Rr7r5b+DSBLi3tDoDHD37YZ3M8Si
         quzuYbCV5OqtMpwmJEjE5HUd77hXKLZSNtrUntMugCZjwYSWmYIiE+kJWAHJW5lprCMv
         YlATeVfAX8bGIJwrD/v+1btabyCzk+JgzkvGhu3TMi74LhK9RKT0JHj41aBRC+HSHR8k
         hn6w==
X-Gm-Message-State: ACrzQf1LVv/ELOego7AKRqWtMRyPsOEMR6aLWEvcuxaG5VKGhLg3re6r
        5DayzHyAAbEcKw/gMSYJeMM=
X-Google-Smtp-Source: AMsMyM4wATwlk4RPzcgKvOZwf5w68fr1EQLtWQEbJimqtPpuKgIfUB7wEIzz5GV/vTRA5xxHcfZkdQ==
X-Received: by 2002:aa7:d385:0:b0:461:8cd3:b38b with SMTP id x5-20020aa7d385000000b004618cd3b38bmr29914191edq.172.1667476898409;
        Thu, 03 Nov 2022 05:01:38 -0700 (PDT)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b0077016f4c6d4sm423983ejb.55.2022.11.03.05.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:01:37 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] dt-bindings: pwm: tegra: Convert to json-schema
Date:   Thu,  3 Nov 2022 13:01:37 +0100
Message-Id: <20221103120137.1467905-1-thierry.reding@gmail.com>
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
 .../bindings/pwm/nvidia,tegra20-pwm.txt       |  77 ----------
 .../bindings/pwm/nvidia,tegra20-pwm.yaml      | 144 ++++++++++++++++++
 2 files changed, 144 insertions(+), 77 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
deleted file mode 100644
index 74c41e34c3b6..000000000000
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ /dev/null
@@ -1,77 +0,0 @@
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
index 000000000000..9c73e78ff434
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
@@ -0,0 +1,144 @@
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
+      - items:
+          - const: nvidia,tegra20-pwm
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
+          - const: nvidia,tegra186-pwm
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
+    items:
+      - description: module clock
+
+  clock-names:
+    items:
+      - const: pwm
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
+    $ref: "/schemas/types.yaml#/definitions/phandle"
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
+
+  # Example with the pin configuration for suspend and resume:
+  # ==========================================================
+  # Suppose pin PE7 (On Tegra210) interfaced with the regulator device and it requires PWM output
+  # to be tristated when system enters suspend.
+  - |
+    #include <dt-bindings/clock/tegra210-car.h>
+    #include <dt-bindings/pinctrl/pinctrl-tegra.h>
+
+    pinmux@700008d4 {
+        compatible = "nvidia,tegra210-pinmux";
+        reg = <0x700008d4 0x29c>, /* Pad control registers */
+              <0x70003000 0x294>; /* Mux registers */
+
+        pwm_active_state: pwm_active_state {
+            pe7 {
+                nvidia,pins = "pe7";
+                nvidia,tristate = <TEGRA_PIN_DISABLE>;
+            };
+        };
+
+        pwm_sleep_state: pwm_sleep_state {
+            pe7 {
+                nvidia,pins = "pe7";
+                nvidia,tristate = <TEGRA_PIN_ENABLE>;
+            };
+        };
+    };
+
+    pwm@7000a000 {
+        compatible = "nvidia,tegra210-pwm", "nvidia,tegra20-pwm";
+        reg = <0x7000a000 0x100>;
+        clocks = <&tegra_car TEGRA210_CLK_PWM>;
+        clock-names = "pwm";
+        resets = <&tegra_car 17>;
+        reset-names = "pwm";
+        #pwm-cells = <2>;
+        pinctrl-names = "default", "sleep";
+        pinctrl-0 = <&pwm_active_state>;
+        pinctrl-1 = <&pwm_sleep_state>;
+    };
-- 
2.38.1

