Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB1367BFF4
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jan 2023 23:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjAYW3D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Jan 2023 17:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbjAYW3C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Jan 2023 17:29:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375E5EFBC;
        Wed, 25 Jan 2023 14:28:49 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u21so295105edv.3;
        Wed, 25 Jan 2023 14:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h9d5CcIPIwAVuZTZA7qCdKWxys5gtGTLaZZHJl5UAVQ=;
        b=URSHRW2b0I/0QCF62mgR6tevAW3gjPGTB3qqF7779q/46dUO9pTVfqutc3DFRRXITP
         hb88OLD0M5DjibVZX2gRlkJZkOhQ7fyljLQXGH2mjeHbNyWGdEeUVtWsmSLMzcFED46H
         BF5Ba+Z3YYrjXhaU0CmSAnyMDTtKLpv47TU6Orrs8CR/Y80BAj8zAD2jxrB9dtYv4gQ7
         S2IYu2BYTMSqTGFzOnYnALtYGD43HJHhu8MLwRUWRpv5c+X0WvNCG2FhObTuuy7BduNK
         e1Fej1XcjWL6VLEThuFvTJE7MVl8IG8gicOS/drKyi5p8TNHdeH8DajvbJfCZTEZsCK1
         FeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h9d5CcIPIwAVuZTZA7qCdKWxys5gtGTLaZZHJl5UAVQ=;
        b=vBoIBBdxDjRgPtDJTUGcy1KFFdxzW/tdlYOPHDKSSxe6tc2bL29Oou9XHkY6z2iAvv
         Hjup3rvNs65jPGBDVgyz4RRDX1YdkVLXM8EgVa0/c32uYkZSscxkieCKJL9VzBmIijMz
         e1nYRiR1ovQaRHSqrpuLnZV7KDsrjdPIMLBIryUr3MCM6lbb4mAZZBxN/3CpL1/cyHA7
         rAdUYG1ayiHNjIygSbPxPeX5Y9gixB2+qvv7XuGcj5H4D1hK14ToAvYbqiypaTAmqAqO
         NVMyn9hhhzxWzb3PYeyhp2Yem0YnY7t04Fnax4gB4oW9ycmpeqJYBkdieTZgBKRdBwP4
         5TsQ==
X-Gm-Message-State: AO0yUKVQw0elJu3/y2voZGTdXWcrCeD/yUqsr1Lfx5FvxlPhjDWxzCAK
        1nxxsCBZvwpedD/9G3F4G3g=
X-Google-Smtp-Source: AK7set9LLaD+M/2UIwGL68ILsokHpRI+wlZCL/233GwnOyAXCVldAoPaQqkYUSQGPixzU2TUGsmfog==
X-Received: by 2002:a50:9eef:0:b0:4a0:8fc4:6be8 with SMTP id a102-20020a509eef000000b004a08fc46be8mr6583792edf.26.1674685728057;
        Wed, 25 Jan 2023 14:28:48 -0800 (PST)
Received: from ?IPV6:2a01:c22:720f:5a00:b1aa:59d6:6587:3051? (dynamic-2a01-0c22-720f-5a00-b1aa-59d6-6587-3051.c22.pool.telefonica.de. [2a01:c22:720f:5a00:b1aa:59d6:6587:3051])
        by smtp.googlemail.com with ESMTPSA id s25-20020aa7cb19000000b0047e6fdbf81csm2891373edt.82.2023.01.25.14.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 14:28:47 -0800 (PST)
Message-ID: <d37fb6a3-f94e-224a-8829-80cf47412fce@gmail.com>
Date:   Wed, 25 Jan 2023 23:28:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] dt-bindings: pwm: Convert Amlogic Meson PWM binding
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
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 73 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-meson.txt     | 29 --------
 2 files changed, 73 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
new file mode 100644
index 000000000..871b24bc2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -0,0 +1,73 @@
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
+    minItems: 1
+    maxItems: 2
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


