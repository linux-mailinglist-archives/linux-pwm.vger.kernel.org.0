Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F066735B485
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Apr 2021 15:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhDKNKh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 09:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbhDKNKd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 09:10:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED03C061574;
        Sun, 11 Apr 2021 06:10:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e7so11775476edu.10;
        Sun, 11 Apr 2021 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HSvdpIMLsn0RnpUE4sX7jib7kDhn37eZZS9bsKWgBwM=;
        b=FLLf+FINblf0xE6K84r49vHqlJhZXHkUC4gkjPIDXI8MGMaQBpF4cihrV6onpXTaBp
         vdkLL7dKxgW4JtI7yGkgR9edSUOif91Z7hayO9VyxeOIEYg0oDi5fHxj06ezRw1YS0GE
         /UEP0zK8DSvyaezvf7/sRSDjSFXp6C7Rqh1LEFCGDDkHE8wBeCd0bqfk2+VXr3e4YqyC
         CyW9iNuhrVHLL9W3AsMNlMdRbXpDERQxsFLgZzYSmwzosIxKuS3uU2zJHA7tETIwwZpf
         471zec6rzuUmtCXU3WJ+/ldE4Cli6MezB/xGtRtWjOMU8LWVLzB/feura8Nk20Y4vHXd
         gZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HSvdpIMLsn0RnpUE4sX7jib7kDhn37eZZS9bsKWgBwM=;
        b=IUuBp+lMXY0giqk/VdVvLzyXwQeNjmILtkQhLTMqOHbwYvtG3rll6ULXU4VCQItpth
         YhOm5131bGI7uLEfchWrHC1QGpncl6UdJGRdXhx44balZF/IKB4AXwDnN8I5+ad0ZE4t
         QsI+zKZy1CGsBVezeYa+AVrdr8XG8rok+4Dhmqu2U7hYVixQ+KWlxIFkJKiMSCg4bl7Q
         ECZoX08Ha0hMqg8+baHGSsMWI/VYaDB300Tk0lYHOm7IQkuIpRWsoPT0WEUvnyOxFqZi
         bh/OtJL0wfoAooM/9HBANqbld5sAgSqKjcHffTjZbl2blGQlpgicTkAQ9WSWzOUlpTaf
         6W7A==
X-Gm-Message-State: AOAM530vXlYF38TovmepkE99sfCpbtyhwDLWthktW6yCKxSzoBnXthhA
        5KgLn5h/aUvuG8m9uH151AY0O6dMf/hPaQ==
X-Google-Smtp-Source: ABdhPJx19OZpyYTMvsTHKcHcJM+xDYsx1U55kZsBqfMosXJyUMgV0g33n4IP6IFs7QV3sls4PaDo/Q==
X-Received: by 2002:a05:6402:5153:: with SMTP id n19mr11353148edd.173.1618146614237;
        Sun, 11 Apr 2021 06:10:14 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w2sm3983520eju.71.2021.04.11.06.10.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Apr 2021 06:10:13 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
Date:   Sun, 11 Apr 2021 15:10:02 +0200
Message-Id: <20210411131007.21757-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Current dts files with 'pwm' nodes are manually verified.
In order to automate this process pwm-rockchip.txt
has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V2:
  changed schema for clocks and clock-names
---
 .../devicetree/bindings/pwm/pwm-rockchip.txt       | 27 -------
 .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 91 ++++++++++++++++++++++
 2 files changed, 91 insertions(+), 27 deletions(-)
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
index 000000000..142ce85ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -0,0 +1,91 @@
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
+          - const: rockchip,rk3036-pwm
+          - const: rockchip,rk2928-pwm
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

