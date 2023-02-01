Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDAB686F78
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Feb 2023 21:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjBAUCQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Feb 2023 15:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBAUCP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Feb 2023 15:02:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42267ED0;
        Wed,  1 Feb 2023 12:02:14 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cw4so13752477edb.13;
        Wed, 01 Feb 2023 12:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjWgvQwvZyIsMDgCbiBje/5KENMDXEezSPyh+umiPdU=;
        b=GdhO4DdpoLpR0ZKP3Xw/WTvp+aHvsGxS/NmFUeHukhP2Fp1RWkq5bi1B7squTskbP4
         /hfZgnpCOIkGQk0vYT4Eo3Lb89tP2apjreJ4zjuMPFhOUaI6MaO0oN5MHaBzOPtKhbwX
         JvSgvb8JXAZ6/qNknuiPCiBSixfaOBf6o5t7gQYm6L8dOIi4F3NodmxauNckZM20INO6
         enc8ZsZ7qVfZ+EKuYfD2EN/DP7ap44fI1oA12c5xU+zAxqmfVLiAaV2p/GoRq20BYzAi
         AXlGI1GeftUACT4IRRQQz5COWDrtS2H1PYze4lQgXFYkZgPkqWpll4JZrrSyKN7LFGuj
         auvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjWgvQwvZyIsMDgCbiBje/5KENMDXEezSPyh+umiPdU=;
        b=k24NJE8QD7tQk7jLYg7zijEFGk92bnH4Xj0H4TAUavcq20UYzEuFLJO1S+UreROhru
         mhd0zfdOtFT6w7KUEKhFa3aV5yxMrpkbe+IvwaogAzogqMUJqhR7e6ANNdyt8D8F2VQ4
         W+jV51zidIhP4+zAaIbkhMtVW48eGfN5s5+ijaPRAHHcoXGCZrZsYGqN6sh6mfEw31nB
         0Qe3oX0Q3BrUDe1cnEmjf5yeKHsAcwe8iJ6Lt3VqwLZ5RnI57fbmO9Jzca2g/rjZCZRq
         hyRe66LyvDnDarPnRj8Ks3ay/RIxnwnQDlK5FbfrJb5b9bTzxsXVupurxC/BlzvZ2Wd8
         SC1w==
X-Gm-Message-State: AO0yUKWaz4geZ0EsgmPdUBjIOCUKz4uqOugmurIaX58FVVgXKNf0/8tC
        rLlQgl4YuEGlmzFGaqj4LHY=
X-Google-Smtp-Source: AK7set9KWjKT6/RHInEXGxZqqoVIS6d7vQeC3zQ7pPQeXiXdw8jqSi7/LCKDS6ITaDZNLHvURIkJYA==
X-Received: by 2002:aa7:d0c6:0:b0:49b:4711:f4b4 with SMTP id u6-20020aa7d0c6000000b0049b4711f4b4mr3791920edo.0.1675281733150;
        Wed, 01 Feb 2023 12:02:13 -0800 (PST)
Received: from ?IPV6:2a01:c23:b912:d400:3963:7bc4:12b:ddb3? (dynamic-2a01-0c23-b912-d400-3963-7bc4-012b-ddb3.c23.pool.telefonica.de. [2a01:c23:b912:d400:3963:7bc4:12b:ddb3])
        by smtp.googlemail.com with ESMTPSA id lc7-20020a170906f90700b00887a23bab85sm5797602ejb.220.2023.02.01.12.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 12:02:12 -0800 (PST)
Message-ID: <5b83767e-c53d-316f-df10-45a39dbd9c88@gmail.com>
Date:   Wed, 1 Feb 2023 21:00:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: [PATCH 3/4] dt-bindings: pwm: Convert Amlogic Meson PWM binding
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org
References: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
In-Reply-To: <8df4ceec-663c-dc68-d775-5caeb02c0cca@gmail.com>
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

Reviewed-by: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 70 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-meson.txt     | 29 --------
 2 files changed, 70 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
new file mode 100644
index 000000000..527864a4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -0,0 +1,70 @@
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
+      - enum:
+          - amlogic,meson8b-pwm
+          - amlogic,meson-gxbb-pwm
+          - amlogic,meson-gxbb-ao-pwm
+          - amlogic,meson-axg-ee-pwm
+          - amlogic,meson-axg-ao-pwm
+          - amlogic,meson-g12a-ee-pwm
+          - amlogic,meson-g12a-ao-pwm-ab
+          - amlogic,meson-g12a-ao-pwm-cd
+          - amlogic,meson-s4-pwm
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


