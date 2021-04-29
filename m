Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6E36F1A7
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Apr 2021 23:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbhD2VQF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Apr 2021 17:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbhD2VQD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Apr 2021 17:16:03 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A2C06134B
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 14:15:16 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id e25so37948426oii.2
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 14:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fe89kRGBfUr3nhPy9Di5M1WD0v7Pf3Rw9gqCGNTJqLs=;
        b=Xl5WS50eO7JhaA30CSUPZ/gtio09TI1cD0J1XdZrPp11SlXRNxkzGK3p7FAyBA6oKT
         r5eT9LyOZOKut5BvjAOP53cpdbe4sFrgJVMzdIu72op02LdjpNT0SH8XezzOO02+ErEL
         HNuLtbUmqgJN/l854LJ8zl6NtrqriPlA8Ito4sXl0hY9aSrNn6u0QYRhXMeKsLF2R6zH
         oeBo+aHunYuBTQoaf3OzrNpoLyVPXrRhxWXQV6Zs9ZODDvuGWJnU4Pax787VX1Xjyxk4
         YBgCNVy4OVDi0XGYOisDB8xl5GX1m33E6HSaIm56OOKSPPVgcezQQ2FS78TshrOmY27y
         NqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fe89kRGBfUr3nhPy9Di5M1WD0v7Pf3Rw9gqCGNTJqLs=;
        b=gNEIWrWQcgqrWOmT3VNLKXd1RPr+zDOZD7Yg1Y5oEMg/BdLW6HByaMtOJNCVv6gEa0
         wqXLq0tF4atKh4Np81fq2Djk33Vr42bDBJ/ad1poz23EERtHr4M6YdlJ/glkddUo3M2h
         8JoL5XetxXe2BTseG7W4B3xrrVq/0koHbgRhRHqxmPuy79EOwhBxtZpnaGYbrNuuOrid
         NMQYbiHrAYtCcQPgTtcbRlBW2iyJ8ZfgkinY7snLKw6nyGWIofQzD3KCnMkMsYnwhUpp
         uRSgqvQOcN9aD+GaOQzaxfvR691qvSbhiu5dOtegvBMctQIDBqPAmWQy89nO+cv7bbDm
         vQJg==
X-Gm-Message-State: AOAM532ScHo3iFaWxVW6lmQDQsrJZ+7tidQqL5fFvyZFXENF8EZJPVl6
        8fDj1moY9k9DYWL01bOo0Bf1xQ==
X-Google-Smtp-Source: ABdhPJzmbILKUfma1enx9Jt1H6fWGUWfyMGDXtrOFGfokLTZly4fmdLih+gMENgUekqtVCwplEBDkg==
X-Received: by 2002:aca:c206:: with SMTP id s6mr1395445oif.177.1619730915354;
        Thu, 29 Apr 2021 14:15:15 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y67sm242707otb.1.2021.04.29.14.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 14:15:14 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: [PATCH v7 1/6] dt-bindings: leds: Add Qualcomm Light Pulse Generator binding
Date:   Thu, 29 Apr 2021 14:15:12 -0700
Message-Id: <20210429211517.312792-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210429211517.312792-1-bjorn.andersson@linaro.org>
References: <20210429211517.312792-1-bjorn.andersson@linaro.org>
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

Changes since v6:
- Backed qcom,dtest out of the child nodes again, as it's useful to be able to
  route pwm signals through dtest lines as well (and pwm channels aren't
  described as children).
- Added pm8150[bl] compatibles
- Dropped quotes around qcom,dtest
- Fixed indentation errors in subnode definition

 .../bindings/leds/leds-qcom-lpg.yaml          | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
new file mode 100644
index 000000000000..2998598e8785
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
@@ -0,0 +1,158 @@
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
+
+  qcom,dtest:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: >
+      A list of integer pairs, where each pair represent the dtest line the
+      particular channel should be connected to and the flags denoting how the
+      value should be outputed, as defined in the datasheet. The number of
+      pairs should be the same as the number of channels.
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
+    lpg {
+      compatible = "qcom,pmi8994-lpg";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      qcom,power-source = <1>;
+
+      qcom,dtest = <0 0
+                    0 0
+                    0 0
+                    4 1>;
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
2.29.2

