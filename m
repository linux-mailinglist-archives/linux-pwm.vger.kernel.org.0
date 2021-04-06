Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C574355885
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 17:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbhDFPvN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 11:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243875AbhDFPvM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 11:51:12 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3598FC06174A;
        Tue,  6 Apr 2021 08:51:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l4so22705069ejc.10;
        Tue, 06 Apr 2021 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MwBs5r1ZJNOmTqYBpKTtnKYCyLFiaA9WgWxe+ttx57g=;
        b=YpfgJoVR99TLjEIAiCUf0MhS+8vlpnI8XDlBtP8pBpMnVl0rJoCsv2VrTntaygKrVi
         oYU39msAOlzwehwCWXX45pzV/nUMhAHb2Z3rvEKHNeKHuk0seJ71SA6Clu1YwnRXi2Zm
         bM/UuIHPx6eqJAd/1ZoZWPpNppiSjkugnTo9hFRKLfxY6fTMeEUfQCJ/L6ZwD8GKBLb5
         LG1rjqVfgw0TiQ6gsZAMsDJjExhL0IID0Jn4yj5BNw59xhBz5ZfWLX9zhwUj3zovMFvP
         RIp18iRTt7qlyUtO8P7bvOVLcv2k0pvF34zV/OlxRYQwvhmTmB9ZSw6GvhZf3q9C/7We
         Ui2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MwBs5r1ZJNOmTqYBpKTtnKYCyLFiaA9WgWxe+ttx57g=;
        b=W+0NCTepL43FM9//rNLHAh+n9doLYkBmUPVklZMgfkW57a75tj4WKOG/XgGpr7iI5W
         IhYI41vjtpU/mhfRZus3hJdIul1S2rsILsOP6tSZoas5g1n5/KyHWsxv+erymTMAB8uF
         PqC/WbbMA3cS8Ojo973dnNVLMExXGUf4KzGWODUkF5JLT287SFCdupiK8tIHpNlzKGQd
         kiF8dBkaNG3xsF6OJT2YnBT/sVOQjBGytZDvprATnCOWQjA7XRDuIgoTv1RxWLUwzX6P
         VvanpUwz5dZ/eEfvqrbTb60wrgwc+KVDZukoxa1cZXQYfboOEgo/5IWBt8JaIPB7UnO+
         xIPQ==
X-Gm-Message-State: AOAM5319RYaBZjzNIEKeepmgcOU+Ue+rlvFBpG+MC1sT7DbQQEGVNQKg
        4Loe/pSilqou8VNLxiFWkeU=
X-Google-Smtp-Source: ABdhPJwB8DLj57BRL/dataeb6kvhb3ZsPmD6W8ROBoUSxQljHmy0I8hpKKuNGdvCPz5jzF8sJ9z0LQ==
X-Received: by 2002:a17:906:1ba9:: with SMTP id r9mr2482740ejg.395.1617724261927;
        Tue, 06 Apr 2021 08:51:01 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h8sm13894327ede.25.2021.04.06.08.51.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:51:01 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: pwm: convert pwm-rockchip.txt to YAML
Date:   Tue,  6 Apr 2021 17:50:52 +0200
Message-Id: <20210406155053.29101-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Current dts files with 'pwm' nodes are manually verified.
In order to automate this process pwm-rockchip.txt
has to be converted to yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-rockchip.txt       | 27 ---------
 .../devicetree/bindings/pwm/pwm-rockchip.yaml      | 66 ++++++++++++++++++++++
 2 files changed, 66 insertions(+), 27 deletions(-)
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
index 000000000..cfd637d3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -0,0 +1,66 @@
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
+    description:
+      For older hardware (rk2928, rk3066, rk3188, rk3228, rk3288, rk3399)
+        There is one clock that is used both to derive the functional clock
+        for the device and as the bus clock.
+      For newer hardware (rk3328 and future SoCs) that is also specified
+      with clock names.
+        "pwm" is used to derive the functional clock for the device.
+        "pclk" is used as the APB bus clock.
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: pwm
+      - const: pclk
+
+  "#pwm-cells":
+    enum: [2, 3]
+    description:
+      Must be 2 (rk2928) or 3 (rk3288).
+      See pwm.yaml for a description of the cell format.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#pwm-cells"
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

