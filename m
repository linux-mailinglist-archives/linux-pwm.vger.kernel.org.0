Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6229534D
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Oct 2020 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505125AbgJUULv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Oct 2020 16:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438832AbgJUULu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Oct 2020 16:11:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED884C0613CF
        for <linux-pwm@vger.kernel.org>; Wed, 21 Oct 2020 13:11:49 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id i12so3032291ota.5
        for <linux-pwm@vger.kernel.org>; Wed, 21 Oct 2020 13:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qB8P/6WO1D6RZP2Pmqy7a+v/iyOu8tobujQ8YoHYu9I=;
        b=AnGy9r3RaoiobqjMi1OhPVgQAkMoaUMobsDw3HMdNpbDxPb8FNA4oJzYnCIeq/+Mhy
         ycqSFIMTNOrkzeSBI/hljp9SxfKD7XP/GTtZJ6S7EE7XU7t5gRrr/YBJXdP3cGmY210s
         Fp2JT+PeoDJX8YWBCV9wDAeTrtZDRJAAoIMmRVR2ep4lcBcRSQbcm87zfy+h0Ne/0Kiv
         TUn7O67/Me13fRrKkigibHhCpJgzr2r1cMWaE/3ijIl/Cg7SH+MX9NQpcXG0FhO+vuQD
         gd2zBWGH5qii83CBsGnxkf/t5exldlS09wgDEkU5YiHri6G8YLFRNo2d3//6WmiZxM1o
         8iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qB8P/6WO1D6RZP2Pmqy7a+v/iyOu8tobujQ8YoHYu9I=;
        b=qZI/2p5adw/7WifWjCMCwNSJagfGQ5bpjlBIdkj9KFqb53PycaGgCD08s8lGC7FMzM
         hVvlR8weiZGifT1tUkSDYFbOnqYzq/iYhiigVjP+06qriAd26UgsDpxTj9rm1621Y21q
         ySWmmKYlHs0RCpCe7JvyNP8s8F0tfDRhbzrdpuUkRTCJ2D2MRrP23A8AlxyGcmw6HWZ0
         ne444moamlVJCJ5jjuv75Q6+YwQMLXBPlkMM0idCiXzLRTXcRt9IENt38rbUC3Tv9nHl
         q3YAN0fYxSzjO7tZ0lw2C1UYvtqtAkBCJdkD73ZuqTjnmPSrQq+X/DywI/cD4ihWDdql
         c6uA==
X-Gm-Message-State: AOAM532mbLelCWIbxt2gEMtFavpInSLnpHbBGNI70C1UO+EbRfzmuXLp
        0NpZ/8PLpdvq+W6m/cO5W6O2pw==
X-Google-Smtp-Source: ABdhPJyDgqkT/pt/hrWNYpqUXUrfNe7GQUKRCVxdMSeS1moog0IYT2oQ9rDKMKSIAWkGLUbyusJ6SA==
X-Received: by 2002:a9d:73c6:: with SMTP id m6mr3795879otk.105.1603311109298;
        Wed, 21 Oct 2020 13:11:49 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t5sm838166otl.22.2020.10.21.13.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:11:48 -0700 (PDT)
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
Subject: [PATCH v6 1/4] dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
Date:   Wed, 21 Oct 2020 13:12:21 -0700
Message-Id: <20201021201224.3430546-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
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

Changes since v5:
- None

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

