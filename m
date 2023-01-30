Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E33681B9C
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jan 2023 21:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjA3UfK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Jan 2023 15:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjA3UfJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Jan 2023 15:35:09 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B0E166EC;
        Mon, 30 Jan 2023 12:35:04 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id dr8so13868692ejc.12;
        Mon, 30 Jan 2023 12:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Izia26EYeDM525t5D9ySWrr0/qUJNtoiKMM2Ve6HW1s=;
        b=S1STwkdg3cc0FiYh0eElBnjlY2I5wlJAcJ7cLhnykVBTRhO1ZflIyohVPX1/Re81GN
         k1zE/NMi1q5NmHqETza9d9ciC2SWJJglkJ6HxmZSLIHhX0QW5pr1YSxGuiAp275CRvF/
         hNnJkbO/nFBfp7cIhq1Gxsg1iZ8xDLmg2LMhw4growD3Dbi9TGfafKrV+RH9HDCCczIB
         eL2QB1jMKSeyjBMDgMbcd7M7juZOvd+aRfo8qAV342Zf1Av//8xnxeUY6eHa6Gdazcau
         Y+muOLRChlq3CWe4dxNCnHBO5nNHpKfOhtHGlsWp0+BXUvOazly/6O/8Kgy2RLH3+DlA
         /8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Izia26EYeDM525t5D9ySWrr0/qUJNtoiKMM2Ve6HW1s=;
        b=AdhjD9jhL35AcIcKrcwza0vnOAuBic6gSUe/CWIZe8FEZd1lQA4CJQrmvt0ZAJsbEL
         uM0uj2DaQlVgK91LRZCYKeMoa2LG93O7uNBAiR2cjdWQ8rEE5R+ZzsOIZFLrGBqwmdjd
         Ib+TLhOA1gFDb1nxs+oK0BH2VpsxUli3MLgzuJFo7eVv2fFu6Mt2qkPFcHhyh+61W2Zc
         RONY4IveFDMnSti4G38LGo1H8K4sgVvz7+/oypphLFgL4GTqJ4HJuQAJi52eLIKd/rWq
         faRNs2rPZphoTelZ6b9voAAZsCX628x1as2oW6aaLCPGzjv0kEe9L9tLPctfNBSxMjcx
         zMVQ==
X-Gm-Message-State: AO0yUKW/69Opq7ya0ipKvHmXULHoRrFOtTw67R2mPXf5T0o1JsZKJjYi
        s9BkdF+5uOK2oocISCq5xf8=
X-Google-Smtp-Source: AK7set/ZOwIiKJv5E0C3RIcESZk+4wxKOF7QbdrEh7hIpzXZ4AZm671atxgFxLQvTV4ttVjuqOTJFw==
X-Received: by 2002:a17:906:bcf5:b0:884:ab29:bd0b with SMTP id op21-20020a170906bcf500b00884ab29bd0bmr9190603ejb.69.1675110902831;
        Mon, 30 Jan 2023 12:35:02 -0800 (PST)
Received: from ?IPV6:2a01:c23:c074:7400:d941:3cb5:fa86:8ec8? (dynamic-2a01-0c23-c074-7400-d941-3cb5-fa86-8ec8.c23.pool.telefonica.de. [2a01:c23:c074:7400:d941:3cb5:fa86:8ec8])
        by smtp.googlemail.com with ESMTPSA id kl13-20020a170907994d00b00882f9130eafsm4270220ejc.26.2023.01.30.12.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 12:35:02 -0800 (PST)
Message-ID: <c92b9e51-bb69-0712-0b29-3db3c9a29f8b@gmail.com>
Date:   Mon, 30 Jan 2023 21:34:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3] dt-bindings: pwm: Convert Amlogic Meson PWM binding
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
Content-Language: en-US
In-Reply-To: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert Amlogic Meson PWM binding to yaml.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- fix clocks and clock-names
- consider that more than one compatible may be set
v3:
- remove minItem/maxItem properties for compatible
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 71 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-meson.txt     | 29 --------
 2 files changed, 71 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
new file mode 100644
index 000000000..750642e76
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/pwm-amlogic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic PWM
+
+maintainers:
+  - Heiner Kallweit <hkallweit1@gmail.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,meson8b-pwm
+              - amlogic,meson-gxbb-pwm
+              - amlogic,meson-gxbb-ao-pwm
+              - amlogic,meson-axg-ee-pwm
+              - amlogic,meson-axg-ao-pwm
+              - amlogic,meson-g12a-ee-pwm
+              - amlogic,meson-g12a-ao-pwm-ab
+              - amlogic,meson-g12a-ao-pwm-cd
+              - amlogic,meson-s4-pwm
+      - items:
+          - const: amlogic,meson-gx-pwm
+          - const: amlogic,meson-gxbb-pwm
+      - items:
+          - const: amlogic,meson-gx-ao-pwm
+          - const: amlogic,meson-gxbb-ao-pwm
+      - items:
+          - const: amlogic,meson8-pwm
+          - const: amlogic,meson8b-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    oneOf:
+      - items:
+          - enum: [clkin0, clkin1]
+      - items:
+          - const: clkin0
+          - const: clkin1
+
+  "#pwm-cells":
+    const: 3
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@8550 {
+      compatible = "amlogic,meson-gxbb-pwm";
+      reg = <0x08550 0x10>;
+      clocks = <&xtal>, <&xtal>;
+      clock-names = "clkin0", "clkin1";
+      #pwm-cells = <3>;
+    };
diff --git a/Documentation/devicetree/bindings/pwm/pwm-meson.txt b/Documentation/devicetree/bindings/pwm/pwm-meson.txt
deleted file mode 100644
index bd02b0a14..000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-meson.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Amlogic Meson PWM Controller
-============================
-
-Required properties:
-- compatible: Shall contain "amlogic,meson8b-pwm"
-                         or "amlogic,meson-gxbb-pwm"
-                         or "amlogic,meson-gxbb-ao-pwm"
-                         or "amlogic,meson-axg-ee-pwm"
-                         or "amlogic,meson-axg-ao-pwm"
-                         or "amlogic,meson-g12a-ee-pwm"
-                         or "amlogic,meson-g12a-ao-pwm-ab"
-                         or "amlogic,meson-g12a-ao-pwm-cd"
-- #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
-  the cells format.
-
-Optional properties:
-- clocks: Could contain one or two parents clocks phandle for each of the two
-  PWM channels.
-- clock-names: Could contain at least the "clkin0" and/or "clkin1" names.
-
-Example:
-
-	pwm_ab: pwm@8550 {
-		compatible = "amlogic,meson-gxbb-pwm";
-		reg = <0x0 0x08550 0x0 0x10>;
-		#pwm-cells = <3>;
-		clocks = <&xtal>, <&xtal>;
-		clock-names = "clkin0", "clkin1";
-	}
-- 
2.39.1

