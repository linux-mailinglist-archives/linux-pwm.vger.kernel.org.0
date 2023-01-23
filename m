Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB56789A4
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jan 2023 22:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjAWVbR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Jan 2023 16:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjAWVbQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Jan 2023 16:31:16 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960AB3346D;
        Mon, 23 Jan 2023 13:31:14 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id tz11so34189100ejc.0;
        Mon, 23 Jan 2023 13:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhqMDyZNYknusskJ2HTcXP2zsADreDJb6E1r4c2waBQ=;
        b=B3AyW/ZcL8h9935ra2pnJwqvkNz7xTPDtz5Ay9p02Vwb1/GCicJsVGkOy5Ou3zeEMl
         nLkhR/RiBwLRA5iKQT7gQruqOvUGuWDUoAE+mfzhx7dOLTdyUTyIVSO4XV2RVuZPvpQ4
         zCmS/aZBpXEEkj1zneruPN7hxI1ANQLwhlgW0seOfrKPp7Hqt1nFw85Oyo1AafhKArp8
         jdGyWIQn8rk1XnXxRA2kgqpPI2IGl6xP4HUTLg/wsrvKngjXUGA5mKSsgPFhs5lnEjxj
         cF3K5Yn8wy82FqhYiyj6xdJb6vEyOhj01ycWCLKCYv+D1S5XtLObx0byqMzqvW1jtxso
         CSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhqMDyZNYknusskJ2HTcXP2zsADreDJb6E1r4c2waBQ=;
        b=FpQWtMW3FMHAwKn/pZDt0t816BSrZ7641qU/DW1ez3UZMmMTFBAb2lWpzJ8NVJG0e6
         mPuPXGTcdzYjErSarejvG0z7zH+a+GkHMw7eGdq4bqzBmLnaRqMoFCOrKC6DiYM8owiI
         f+//XktGN/EdjPID1BByPsEMVXPUTGGhVyval53A2rkZfLVSe6QVyV8mIW0/B0Yjjygh
         U+Dvn5Hka7iyaCY5QYeX9WJXrwZMtGyY6GWGWnUYwjKH3UpHDMFHCGT6Db4ovj7il5yL
         tDbOduA2M9z1gxtVIarH9vUvhap/Ti+uPsfFRu/UaQQl7RFu25QUcSmg4j/bKEFQwpe9
         bdpw==
X-Gm-Message-State: AFqh2kr5tufGK+WqQ8Q9mcJo64QUGc6ay4nk5DP+eZR4DNqoPXo/2JPV
        6y5si0cDaY0YTS12Kq0+Wyo=
X-Google-Smtp-Source: AMrXdXvda3nPIrZkuBa5tT2QpbKAstlDALB1jRpWbVI0RHEJa1k9ZCaH2s8gDZatpgPisj3m8a/leA==
X-Received: by 2002:a17:906:8617:b0:86b:1130:5e55 with SMTP id o23-20020a170906861700b0086b11305e55mr27754876ejx.22.1674509472873;
        Mon, 23 Jan 2023 13:31:12 -0800 (PST)
Received: from ?IPV6:2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7? (dynamic-2a01-0c23-bc5b-9400-dc4c-6fb7-47b2-beb7.c23.pool.telefonica.de. [2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7])
        by smtp.googlemail.com with ESMTPSA id kw16-20020a170907771000b0084d43e23436sm20635273ejc.38.2023.01.23.13.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 13:31:12 -0800 (PST)
Message-ID: <0d492f0e-abb3-33f6-3ee9-09e1440a9015@gmail.com>
Date:   Mon, 23 Jan 2023 22:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH 6/8] dt-bindings: pwm: Add Amlogic Meson PWM binding
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cb62dfc0-cb3d-beba-6d0b-8db18583dda0@gmail.com>
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

Add Amlogic Meson PWM binding.
Tested with make targets dt_binding_check and dtbs_check.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-amlogic.yaml  | 61 +++++++++++++++++++
 .../devicetree/bindings/pwm/pwm-meson.txt     | 29 ---------
 2 files changed, 61 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-meson.txt

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
new file mode 100644
index 000000000..443ff4e5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -0,0 +1,61 @@
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
+    enum:
+      - amlogic,meson8b-pwm
+      - amlogic,meson-gxbb-pwm
+      - amlogic,meson-gxbb-ao-pwm
+      - amlogic,meson-axg-ee-pwm
+      - amlogic,meson-axg-ao-pwm
+      - amlogic,meson-g12a-ee-pwm
+      - amlogic,meson-g12a-ao-pwm-ab
+      - amlogic,meson-g12a-ao-pwm-cd
+      - amlogic,meson-s4-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
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
+    apb@fe000000 {
+      reg = <0x0 0xfe000000 0x0 0x480000>;
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pwm@8550 {
+        compatible = "amlogic,meson-gxbb-pwm";
+        reg = <0x0 0x08550 0x0 0x10>;
+        clocks = <&xtal>, <&xtal>;
+        clock-names = "clkin0", "clkin1";
+        #pwm-cells = <3>;
+      };
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


