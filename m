Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC304B7FBF
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Feb 2022 05:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbiBPEyZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Feb 2022 23:54:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238171AbiBPEyY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Feb 2022 23:54:24 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CD2AF1F9
        for <linux-pwm@vger.kernel.org>; Tue, 15 Feb 2022 20:54:12 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so1230219oov.3
        for <linux-pwm@vger.kernel.org>; Tue, 15 Feb 2022 20:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upTWQKCUf0o4m7HcdhyN/xP1oH98RdS82XJSQB3BSzY=;
        b=H+RVkZKEn8WASj9WOOGHAUmsGIvNJ73gOZJrRpUa3e5YwesYm5ckPle6+1Bvk6iLJQ
         gnrJeEjgG+RmblWLkwHDJAOKE9F+y8dW91qw3mnv+WuWJIrAB4ww41xrXTBdZdpd838f
         noUEJ5N85Br2yjVrwtN/+tz1UA5fwagoyb5ITpqRIoQS4fnFq/wS6lngJBZjeHeqxuQW
         RQYp40xf4z7BCK0PSqw0FFBW61973YNpJIIXKOeGxue813rDmvfWqD1mS13SWGccmCV0
         wXZ5+cNzcRizPob9kQD+2oqPXhdCLb0PBsMR4yp9XInzHS2upjB4EIJ3kCa8/7j/WDmj
         TWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upTWQKCUf0o4m7HcdhyN/xP1oH98RdS82XJSQB3BSzY=;
        b=NPz6bedmagZ+s7suJxJ17SS7WlgBJzT09g+35bm+IaN1ynrL5k0F9UUcGW7VjFZKOZ
         CzfQgko1Iqc6F7oaz+iy0+2NjdntJUAJR5JOVudVZ40IHjnxuZ5ffxzYZrwQtLUEB00+
         pye/57UDyyZwUYxFjxtO0sQJRXBhE0LkuOxSmEwjr+wX/eK5oH+OmsqtYTBfqX9BGk6H
         H3belUrbDy6+hPThG8yDWHw6NQlHpOCz+mfiqXzmIjJ+2D0qx/zQbQOObsWLVZ/Z9CYx
         B30630hrhkvPgyTrYOwQvFNL8HsVIq0hLLVumNUTNNrKc6o6bpv/YDHHVhx0I/HjVHKJ
         qOgg==
X-Gm-Message-State: AOAM5315DP4VOoVwEO8nBsKethzeT/qx6EYHnWInqZLhcBzE8FZPS4vI
        AQVs01dufARsO8MSCRxA8CX8vw==
X-Google-Smtp-Source: ABdhPJy+cyFtLbvYcQ1r3DrOGH2hnAXBXXMd6n2lDGkyrH3J21nTllnGkipJ4rTDxiDEDXWAbeeCIg==
X-Received: by 2002:a4a:c719:0:b0:2eb:c34a:2ba7 with SMTP id n25-20020a4ac719000000b002ebc34a2ba7mr352663ooq.98.1644987252075;
        Tue, 15 Feb 2022 20:54:12 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id n11sm6916614oal.1.2022.02.15.20.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 20:54:11 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 1/2] dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
Date:   Tue, 15 Feb 2022 20:56:19 -0800
Message-Id: <20220216045620.1716537-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This adds the binding document describing the three hardware blocks
related to the Light Pulse Generator found in a wide range of Qualcomm
PMICs.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes since v11:
- None

 .../bindings/leds/leds-qcom-lpg.yaml          | 173 ++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
new file mode 100644
index 000000000000..336bd8e10efd
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -0,0 +1,173 @@
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
+      - qcom,pm8150b-lpg
+      - qcom,pm8150l-lpg
+      - qcom,pm8916-pwm
+      - qcom,pm8941-lpg
+      - qcom,pm8994-lpg
+      - qcom,pmc8180c-lpg
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
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      power-source used to drive the output, as defined in the datasheet.
+      Should be specified if the TRILED block is present
+    enum: [0, 1, 3]
+
+  qcom,dtest:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: >
+      A list of integer pairs, where each pair represent the dtest line the
+      particular channel should be connected to and the flags denoting how the
+      value should be outputed, as defined in the datasheet. The number of
+      pairs should be the same as the number of channels.
+    items:
+      items:
+        - description: dtest line to attach
+        - description: flags for the attachment
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
+    patternProperties:
+      "^led@[0-9a-f]$":
+        type: object
+        $ref: common.yaml#
+
+patternProperties:
+  "^led@[0-9a-f]$":
+    type: object
+    $ref: common.yaml#
+
+    properties:
+      reg: true
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
+    led-controller {
+      compatible = "qcom,pmi8994-lpg";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      qcom,power-source = <1>;
+
+      qcom,dtest = <0 0>,
+                   <0 0>,
+                   <0 0>,
+                   <4 1>;
+
+      led@1 {
+        reg = <1>;
+        color = <LED_COLOR_ID_GREEN>;
+        function = LED_FUNCTION_INDICATOR;
+        function-enumerator = <1>;
+      };
+
+      led@2 {
+        reg = <2>;
+        color = <LED_COLOR_ID_GREEN>;
+        function = LED_FUNCTION_INDICATOR;
+        function-enumerator = <0>;
+        default-state = "on";
+      };
+
+      led@3 {
+        reg = <3>;
+        color = <LED_COLOR_ID_GREEN>;
+        function = LED_FUNCTION_INDICATOR;
+        function-enumerator = <2>;
+      };
+
+      led@4 {
+        reg = <4>;
+        color = <LED_COLOR_ID_GREEN>;
+        function = LED_FUNCTION_INDICATOR;
+        function-enumerator = <3>;
+      };
+    };
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    led-controller {
+      compatible = "qcom,pmi8994-lpg";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      qcom,power-source = <1>;
+
+      multi-led {
+        color = <LED_COLOR_ID_RGB>;
+        function = LED_FUNCTION_STATUS;
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
+    pwm-controller {
+      compatible = "qcom,pm8916-pwm";
+      #pwm-cells = <2>;
+    };
+...
-- 
2.33.1

