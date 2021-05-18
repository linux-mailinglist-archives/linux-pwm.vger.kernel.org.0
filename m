Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A56E387F0A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 May 2021 19:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351308AbhERRzp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 May 2021 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351277AbhERRzo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 May 2021 13:55:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29189C061760
        for <linux-pwm@vger.kernel.org>; Tue, 18 May 2021 10:54:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x8so11178311wrq.9
        for <linux-pwm@vger.kernel.org>; Tue, 18 May 2021 10:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWPyuzoJy/mScoWjTd2g156JIqxC7nCj/J8y8W+5TIQ=;
        b=gFITqRQ42/kzXwvlJxXPZLz9mArPh+pgdzCUd/Jxd1yrL6hggF14NdJNillhgJdwyX
         Sce0Br+HzNLf+LOydSu6aplcnaRFCsjewZ+DGhQFzn95i9HvdGi7Vj0BFatbdG9lD2Oy
         mvNPsKvV+132xtqDcIQ2zn1o0rRLooZVm6bkQJ+onnbx88YTgoTors2oG8C38Zwb49Xj
         ynvUDuaGkuN57coAxPIG3Gjp3LW+ruLhQTAVMx1wHLTTJq5YGgg/bCyW2W/Zo7ywGYPh
         F57HYLCKxLUOIKXusNpVCm7AxFQBEFqVWk3gcMS6EfxZl5WffEcfM8tVle8Pmyb/8oYd
         NuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWPyuzoJy/mScoWjTd2g156JIqxC7nCj/J8y8W+5TIQ=;
        b=aXY5zLpCCFxxKNTFSNwDWnLEklbrX3EFJHvZPM1LjrXOzXX5/S5Lmc17yBv411vV7M
         TvIJJ0T67Xd/ZMYEDxACF4DAAY4xxahA2X04flSbZFMZH09uq30ZEPGC/D1S5pKp6RI1
         YM4sexMllJhxO8OAdngylPyFdLV95a9bOV6tj7VQ9ctEZ6dUmhIqXB2ti+4DaY2Fbu7V
         nYm0X0O0IstQUKUa+SARs42Gj9vVnyhRW6DfGKkeaupg4MznMvDB1kWDTwXxs2vFGq1W
         GzAJyyskAllOhgNW7T1pFgWqmR+Z8GygKjQWFkAaMs0CKYudX4IMmMGBNcMBWGVFuDQ7
         7hTw==
X-Gm-Message-State: AOAM5318vj2lRk4Dg4NkHAGiG6mV7eHZFyE7F3k3AfU/tIjaUQZBIXfX
        3dYwXUvBINvbkQ9NSpo1ry3fSg==
X-Google-Smtp-Source: ABdhPJzoBUSu3qBReU3Wn0C/GcMbanCzAN+0PiM0fvT4m9u2qWF6Q6o+Gx0yv3qirYtHdkj9jj/OzQ==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr8552995wrp.173.1621360464840;
        Tue, 18 May 2021 10:54:24 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id a17sm14458963wrt.53.2021.05.18.10.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 10:54:24 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: pwm: pwm-mtk-disp: convert to YAML schema
Date:   Tue, 18 May 2021 19:54:19 +0200
Message-Id: <20210518175422.2678665-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert the dt-binding documentation for pwm-mtk-disp to YAML.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt  | 44 ----------
 .../devicetree/bindings/pwm/pwm-mtk-disp.yaml | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
deleted file mode 100644
index 902b271891ae..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-MediaTek display PWM controller
-
-Required properties:
- - compatible: should be "mediatek,<name>-disp-pwm":
-   - "mediatek,mt2701-disp-pwm": found on mt2701 SoC.
-   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
-   - "mediatek,mt8167-disp-pwm", "mediatek,mt8173-disp-pwm": found on mt8167 SoC.
-   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
- - reg: physical base address and length of the controller's registers.
- - #pwm-cells: must be 2. See pwm.yaml in this directory for a description of
-   the cell format.
- - clocks: phandle and clock specifier of the PWM reference clock.
- - clock-names: must contain the following:
-   - "main": clock used to generate PWM signals.
-   - "mm": sync signals from the modules of mmsys.
- - pinctrl-names: Must contain a "default" entry.
- - pinctrl-0: One property must exist for each entry in pinctrl-names.
-   See pinctrl/pinctrl-bindings.txt for details of the property values.
-
-Example:
-	pwm0: pwm@1401e000 {
-		compatible = "mediatek,mt8173-disp-pwm",
-			     "mediatek,mt6595-disp-pwm";
-		reg = <0 0x1401e000 0 0x1000>;
-		#pwm-cells = <2>;
-		clocks = <&mmsys CLK_MM_DISP_PWM026M>,
-			 <&mmsys CLK_MM_DISP_PWM0MM>;
-		clock-names = "main", "mm";
-		pinctrl-names = "default";
-		pinctrl-0 = <&disp_pwm0_pins>;
-	};
-
-	backlight_lcd: backlight_lcd {
-		compatible = "pwm-backlight";
-		pwms = <&pwm0 0 1000000>;
-		brightness-levels = <
-			  0  16  32  48  64  80  96 112
-			128 144 160 176 192 208 224 240
-			255
-		>;
-		default-brightness-level = <9>;
-		power-supply = <&mt6397_vio18_reg>;
-		enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
-	};
diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
new file mode 100644
index 000000000000..0f016c81cd53
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/pwm/pwm-mtk-disp.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MediaTek display PWM controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Lee Jones <lee.jones@linaro.org>
+  - Matthias Brugger <matthias.bgg@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2701-disp-pwm
+          - mediatek,mt6595-disp-pwm
+          - mediatek,mt8173-disp-pwm
+      - items:
+          - const: mediatek,mt8167-disp-pwm
+          - const: mediatek,mt8173-disp-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: clock used to generate PWM signals
+      - description: sync signal from the mmsys module
+
+  clock-names:
+    items:
+      - const: main
+      - const: mm
+
+  "#pwm-cells":
+    const: 2
+
+  power-domains:
+    description:
+      List of phandles and PM domain specifiers, as defined by bindings of the
+      PM domain provider (see also ../power_domain.txt).
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/gpio/gpio.h>
+    pwm0: pwm@1401e000 {
+      compatible = "mediatek,mt8173-disp-pwm";
+      reg = <0x1401e000 0x1000>;
+      #pwm-cells = <2>;
+      clocks = <&mmsys CLK_MM_DISP_PWM026M>,
+               <&mmsys CLK_MM_DISP_PWM0MM>;
+      clock-names = "main", "mm";
+      pinctrl-names = "default";
+      pinctrl-0 = <&disp_pwm0_pins>;
+    };
+
+    backlight_lcd: backlight_lcd {
+      compatible = "pwm-backlight";
+      pwms = <&pwm0 0 1000000>;
+      brightness-levels = <
+        0  16  32  48  64  80  96 112
+        128 144 160 176 192 208 224 240
+        255
+      >;
+      default-brightness-level = <9>;
+      power-supply = <&mt6397_vio18_reg>;
+      enable-gpios = <&pio 95 GPIO_ACTIVE_HIGH>;
+    };
-- 
2.31.1

