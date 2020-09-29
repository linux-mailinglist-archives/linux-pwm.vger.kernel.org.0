Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF74A27BB55
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Sep 2020 05:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgI2DOr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 23:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgI2DOq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 28 Sep 2020 23:14:46 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533A2C0613D0
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 20:14:46 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x14so3834092oic.9
        for <linux-pwm@vger.kernel.org>; Mon, 28 Sep 2020 20:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nh5o0Iu/sIZeZX/X4jVg+PbYLpIA5MkJTyhcsl8L8x0=;
        b=tYivMjEz8hGygZhhtfc92v4wXyoS8P1JXMKzYdamYaQviTmrt5YMUfTw7CWFm6NpQP
         gfRaXHdjk7i3nuIQAMyLSJGE3nT+WT5WmnT9OfZ5ksxQpuup5VUDGF9OPTXgKvRYP8LP
         d7bt5fwultsxxDsJC4EaJute/K+X/gxhM4LdSqqeH5mArwEg2pINbYyll9wHTtgh3N7X
         Ebsyfl4DGwMVI0UwNTs1O3QYApl5W+QL60l17mzAdF1/qrdoU8vzWfsJdl7j8oAaSad9
         0QKj6BqkBS1ydgLCKPq2BAYSeh8xRyrNeF6yQopKwQVRh4L0Cy0cJ6NweDVRB4j/2dcK
         fG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nh5o0Iu/sIZeZX/X4jVg+PbYLpIA5MkJTyhcsl8L8x0=;
        b=kP6l6ET49rGf1zTFblnI3aRljZRfAtJkGppMLu81nuvRwjM2LsW3Lg7crxT1IORcKD
         +zB0LqtF0kr4ob9QPQjHPbqevr7O0llcOeOWDjvK8rcc9qhzFrRbPc31/UtKu8XesWaJ
         p3ZftgYnAtzNE5WuyvNTFkWq4vTTqQm9Hti6Gcjwcn1pWTv3RMJeQ/bwDsmjtSwhRZqM
         OKv43Lh81xIfRfhCEB6IrMVdE6ankj3OFEdfTichHd1XaNPeR2pOp/Q8/ROJ9PE4z10g
         ncM5YaMuZ71m2YAoObPuf28LgR+K7Bhe506cBpQMPM5MOI0F+ULoK4zsst89EJKqAPwc
         Jgvw==
X-Gm-Message-State: AOAM531/nTFb7puI4mcp/uuWaF1iYXB/B4exRR2/y6DfvNhKEn+J6pGN
        EzQ5wJdrjBkJ6qmxwhuTtXOsAg==
X-Google-Smtp-Source: ABdhPJzCaUUPPFvHGDDy9+Dw1EP6JS0uTQ3Q7Gvdopr3c2fhZ6dTgtIqKmX9/d5U6B0esvbKYT9cAQ==
X-Received: by 2002:aca:f203:: with SMTP id q3mr1189882oih.148.1601349285686;
        Mon, 28 Sep 2020 20:14:45 -0700 (PDT)
Received: from localhost.localdomain (99-135-181-32.lightspeed.austtx.sbcglobal.net. [99.135.181.32])
        by smtp.gmail.com with ESMTPSA id 36sm729548otb.30.2020.09.28.20.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 20:14:45 -0700 (PDT)
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
Subject: [PATCH v4 1/4] dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
Date:   Mon, 28 Sep 2020 20:15:41 -0700
Message-Id: <20200929031544.1000204-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929031544.1000204-1-bjorn.andersson@linaro.org>
References: <20200929031544.1000204-1-bjorn.andersson@linaro.org>
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

Changes since v3:
- Rewritten as YAML
- Adopt multicolor model

 .../bindings/leds/leds-qcom-lpg.yaml          | 170 ++++++++++++++++++
 1 file changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
new file mode 100644
index 000000000000..5c6e98fc3b9a
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
+  "qcom,power-source":
+    $ref: /schemas/types.yaml#definitions/uint32
+    description: >
+      power-source used to drive the output, as defined in the datasheet.
+      Should be specified if the TRILED block is present
+    enum:
+      - 0
+      - 1
+      - 3
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
+  "^multi-led$":
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
+	label = "rgb:notification";
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

