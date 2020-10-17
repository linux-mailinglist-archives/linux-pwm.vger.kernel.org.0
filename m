Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA830290F38
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Oct 2020 07:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411651AbgJQFaD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Oct 2020 01:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411647AbgJQF3p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Oct 2020 01:29:45 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A753DC05BD3A
        for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2020 22:20:18 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id r7so1165349ool.0
        for <linux-pwm@vger.kernel.org>; Fri, 16 Oct 2020 22:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9e/IBYO317qxh+k1PgUNvYuepVlTAW7gAlmjMH8Is2Y=;
        b=bLxO1DyD7WvKNbZ1qoNgdML8S06NyThXquGQr4XnUlUt9D4aVwZhUg0gExq4WLd4XB
         moDieBVHzm0EFujGt5u7mdbuXsOR4fm7sHvpnkiLPCWTIgY66YAincSyXbmuMcDGuqKi
         R6DHtHmCUuFVXmREnQqhl5wAsiiQLVFw+v7z/TfIqolMUQcFepstkBmPlZGHP4+exHvk
         pijkfCU+QyiOtC3wm0MA5tdZbusHUv2L7bFUufXqVnIfHd/96x2u7h0owK6oSnG7uQJP
         +C1pASGGslJtcalIIRC4vYTb67Os481jQ8802H+N6KqIz8EMTOEmNEaWrbYpfk/L/izs
         YkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9e/IBYO317qxh+k1PgUNvYuepVlTAW7gAlmjMH8Is2Y=;
        b=JwWxYfLLE/1HPdOV7UUejTss/Jow9BB8kM61PNEJMrRb3t4dRImhgzGvc9bhyFgAEZ
         GcdQZ39ww2uNx5i2NCHX4jHLWIHcH8MrpQSvL1zhd+4pFP3NfR3/a03BkJY68KMwnG8x
         13+DKQAxfAY/WQBwdtu7hRFLxA3+XmpU4w+ZEW3j0I3O64WFxiP65U1FBB0pMkORXzZh
         NX6ZgzcPW15hHDZIle/O06J8OVuiJpVUT4+9kYS0NpksRolYZY1ecR1eGYv2Rlp1yvGG
         /uEdtyy7CihBxU7wjFf/JXULySamPQTMFCTtop+I81SWVjYjBg4+ZGNfIheg7cjB5boy
         gOCQ==
X-Gm-Message-State: AOAM5339xJ6akYU9hRRfihIxEEolm5HNP5Q8eGU+MnvRlhG86WStpAGm
        W4MIPpyGJh2F6zokztJKbybp7g==
X-Google-Smtp-Source: ABdhPJwQqm5S0AzDUW5rkgNpkeYRRBP0fX2RJNYHWemLAyHX8mF1SGm5s8tmjHHwkVuryF+KzABJ4Q==
X-Received: by 2002:a4a:9fd1:: with SMTP id b17mr5228553oom.86.1602912017986;
        Fri, 16 Oct 2020 22:20:17 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f2sm1572769ots.64.2020.10.16.22.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 22:20:17 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v5 1/4] dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
Date:   Fri, 16 Oct 2020 22:20:54 -0700
Message-Id: <20201017052057.2698588-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201017052057.2698588-1-bjorn.andersson@linaro.org>
References: <20201017052057.2698588-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds the binding document describing the three hardware blocks
related to the Light Pulse Generator found in a wide range of Qualcomm
PMICs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Dropped quotes around power-source
- Moved "multi-led" to properties
- Corrected tab-indented line in example

 .../bindings/leds/leds-qcom-lpg.yaml          | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
new file mode 100644
index 000000000000..5ccf0f3d8f1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-qcom-lpg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Light Pulse Generator
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: >
+  The Qualcomm Light Pulse Generator consists of three different hardware blocks;
+  a ramp generator with lookup table, the light pulse generator and a three
+  channel current sink. These blocks are found in a wide range of Qualcomm PMICs.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8916-pwm
+      - qcom,pm8941-lpg
+      - qcom,pm8994-lpg
+      - qcom,pmi8994-lpg
+      - qcom,pmi8998-lpg
+
+  "#pwm-cells":
+    const: 2
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  qcom,power-source:
+    $ref: /schemas/types.yaml#definitions/uint32
+    description: >
+      power-source used to drive the output, as defined in the datasheet.
+      Should be specified if the TRILED block is present
+    enum:
+      - 0
+      - 1
+      - 3
+
+  multi-led:
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      "^led@[0-9a-f]$":
+        type: object
+        $ref: common.yaml#
+
+        properties:
+          "qcom,dtest":
+            $ref: /schemas/types.yaml#definitions/uint32-array
+            description: >
+              configures the output into an internal test line of the pmic. Specified
+              by a list of u32 pairs, one pair per channel, where each pair denotes the
+              test line to drive and the second configures how the value should be
+              outputed, as defined in the datasheet
+            minItems: 2
+            maxItems: 2
+
+        required:
+          - reg
+
+patternProperties:
+  "^led@[0-9a-f]$":
+    type: object
+    $ref: common.yaml#
+    properties:
+      "qcom,dtest":
+        $ref: /schemas/types.yaml#definitions/uint32-array
+        description: >
+          configures the output into an internal test line of the pmic. Specified
+          by a list of u32 pairs, one pair per channel, where each pair denotes the
+          test line to drive and the second configures how the value should be
+          outputed, as defined in the datasheet
+        minItems: 2
+        maxItems: 2
+
+    required:
+      - reg
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    lpg {
+      compatible = "qcom,pmi8994-lpg";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      qcom,power-source = <1>;
+
+      led@1 {
+        reg = <1>;
+        label = "green:user1";
+      };
+
+      led@2 {
+        reg = <2>;
+        label = "green:user0";
+        default-state = "on";
+      };
+
+      led@3 {
+        reg = <3>;
+        label = "green:user2";
+      };
+
+      led@4 {
+        reg = <4>;
+        label = "green:user3";
+
+        qcom,dtest = <4 1>;
+      };
+    };
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    lpg {
+      compatible = "qcom,pmi8994-lpg";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      qcom,power-source = <1>;
+
+      multi-led {
+        color = <LED_COLOR_ID_MULTI>;
+        label = "rgb:notification";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led@1 {
+          reg = <1>;
+          color = <LED_COLOR_ID_RED>;
+        };
+
+        led@2 {
+          reg = <2>;
+          color = <LED_COLOR_ID_GREEN>;
+        };
+
+        led@3 {
+          reg = <3>;
+          color = <LED_COLOR_ID_BLUE>;
+        };
+      };
+    };
+  - |
+    lpg {
+      compatible = "qcom,pm8916-pwm";
+      #pwm-cells = <2>;
+    };
+...
-- 
2.28.0

