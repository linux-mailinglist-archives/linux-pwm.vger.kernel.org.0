Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6629A35D19C
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 22:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237095AbhDLUCZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 16:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhDLUCZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Apr 2021 16:02:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907D3C061574;
        Mon, 12 Apr 2021 13:02:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s15so16559213edd.4;
        Mon, 12 Apr 2021 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Q72c5txIW6Vzq4nbjDcQAJgkWiRNUCrhHe9INPM0VEE=;
        b=tJQVV9XhgxzxoQ8aoestUB4a5ty8ZCg8+hVbq/t0xyx4KixPfGrjrBbefe2rqU760m
         OdnuJI3JT/kJyKUzwxd9z0bdW1Wa60EHiJxgPV/UU/fQmumNdZTch1E+K5a0zAovY1Ub
         DBpjEGBziq50g+VktPieA1x9CGF4ufX3DB1xddtJVw70m1i6IJFH4ay/p5qOq8Nb7Z8w
         XIZHl1mjWUQCmJvHFHyy/AjY7OGU3DF0461XmhGFC2kyXGypsEffQF9GemeISG3ZTqRC
         pFvTBIjMn0nDY1DfEf1azZsXpzDZq/LfkeCbEiHWjHymXne+9uIJrBjGPLTnup5BClZl
         RmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q72c5txIW6Vzq4nbjDcQAJgkWiRNUCrhHe9INPM0VEE=;
        b=hkts1X+76BeHJSzRIvOtsUFrF95mW4KOjqus+yPXxUz/F70iz48/S2CP6EIm/dTlIe
         Sygv8R6bR7xpEFjHjVmitzENPGq2oJ9XE1HVEld2eIK2VH73vZasm+txd5w4T3zD8fuY
         TNNpr+KGeMyGd70USMbdi+fJdLyE2O1kTP9RxQniqp5Z0wgHXF2PruKwX2teyj5H9PTf
         odPOyEfKmFQPhWRMnrMUnHRPI4O36kWNJnarUmro8gVTRqvianCXfzXYsIvoOQTSe8ST
         t7qignhJ3QPQIjyOFWYo4LH4KrG8ji5npzpBP2gxy2kUakzIcsWujfJRMhRNwRSzCiy7
         faKw==
X-Gm-Message-State: AOAM533NpPMGIAJGIeZtom9YCNC/pWjlyKyfqS+LGyD6F8qAVHDPyi1S
        4u2wxoQMeZ+f5dJMch3XtLk=
X-Google-Smtp-Source: ABdhPJyAntVAlRtzzphLGXMMBOsByDYF48e8RN8y5cNhnaHRnIui0sb3HqLsZmBef1XmYwmiFGRWAw==
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr31166337edb.306.1618257725240;
        Mon, 12 Apr 2021 13:02:05 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x9sm7514531edv.22.2021.04.12.13.02.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Apr 2021 13:02:04 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
Date:   Mon, 12 Apr 2021 22:01:52 +0200
Message-Id: <20210412200155.5316-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Current dts files with 'pwm' nodes are manually verified.
In order to automate this process pwm-rockchip.txt
has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
For some SoC nodes this patch serie generates notifications
for undocumented "interrupts" properties shared between
PWM channels till there is consensus of what to do with it or
someone makes a solution for the whole PWM block.

Changed V3:
  fix mistake with compatibles introduced in V2
Changed V2:
  changed schema for clocks and clock-names
---
 .../devicetree/bindings/pwm/pwm-rockchip.txt       | 27 -------
 .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 88 ++++++++++++++++++++++
 2 files changed, 88 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt b/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
deleted file mode 100644
index f70956dea..000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Rockchip PWM controller
-
-Required properties:
- - compatible: should be "rockchip,<name>-pwm"
-   "rockchip,rk2928-pwm": found on RK29XX,RK3066 and RK3188 SoCs
-   "rockchip,rk3288-pwm": found on RK3288 SOC
-   "rockchip,rv1108-pwm", "rockchip,rk3288-pwm": found on RV1108 SoC
-   "rockchip,vop-pwm": found integrated in VOP on RK3288 SoC
- - reg: physical base address and length of the controller's registers
- - clocks: See ../clock/clock-bindings.txt
-   - For older hardware (rk2928, rk3066, rk3188, rk3228, rk3288, rk3399):
-     - There is one clock that's used both to derive the functional clock
-       for the device and as the bus clock.
-   - For newer hardware (rk3328 and future socs): specified by name
-     - "pwm": This is used to derive the functional clock.
-     - "pclk": This is the APB bus clock.
- - #pwm-cells: must be 2 (rk2928) or 3 (rk3288). See pwm.yaml in this directory
-   for a description of the cell format.
-
-Example:
-
-	pwm0: pwm@20030000 {
-		compatible = "rockchip,rk2928-pwm";
-		reg = <0x20030000 0x10>;
-		clocks = <&cru PCLK_PWM01>;
-		#pwm-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
new file mode 100644
index 000000000..19b42d31d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-rockchip.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip PWM controller
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+properties:
+  compatible:
+    oneOf:
+      - const: rockchip,rk2928-pwm
+      - const: rockchip,rk3288-pwm
+      - const: rockchip,vop-pwm
+      - items:
+          - enum:
+              - rockchip,rv1108-pwm
+          - const: rockchip,rk3288-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    maxItems: 2
+
+  "#pwm-cells":
+    enum: [2, 3]
+    description:
+      Must be 2 (rk2928) or 3 (rk3288 and later).
+      See pwm.yaml for a description of the cell format.
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - rockchip,rv1108-pwm
+
+then:
+  properties:
+    clocks:
+      items:
+        - description: Used to derive the functional clock for the device.
+        - description: Used as the APB bus clock.
+
+    clock-names:
+      items:
+        - const: pwm
+        - const: pclk
+
+  required:
+    - clocks
+    - clock-names
+
+else:
+  properties:
+    clocks:
+      maxItems: 1
+      description:
+        Used both to derive the functional clock
+        for the device and as the bus clock.
+
+  required:
+    - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3188-cru-common.h>
+    pwm0: pwm@20030000 {
+      compatible = "rockchip,rk2928-pwm";
+      reg = <0x20030000 0x10>;
+      clocks = <&cru PCLK_PWM01>;
+      #pwm-cells = <2>;
+    };
-- 
2.11.0

