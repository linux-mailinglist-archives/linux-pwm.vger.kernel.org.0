Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB876789AC
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jan 2023 22:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjAWVbV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Jan 2023 16:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjAWVbU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Jan 2023 16:31:20 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712E138E81;
        Mon, 23 Jan 2023 13:31:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v13so16212208eda.11;
        Mon, 23 Jan 2023 13:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbvaBDv4AuFMFSfD4pfq9eHigQMw7BiJJeXrVGHM3fA=;
        b=Na7qXEjST9dcdqqejZpAYdLxnQLIHGc17SiU8cL7seoOz0nKiDbrdZkLXh81s9XRzD
         KNfKmP7A7fI6RO1m5+x8M1t1/66sE6j8tM+Hzb3zi6ycyh1iEBCP/DJRc7BwJotpKUSP
         8vcrStExdi07iryNM0TnsMPtMx0QMMdB1K7ZfseFXElNFv6OYvePJPFw67fCmKncJjin
         N3+FUVE2ZNGB0/XkpmzWoNtOx8NfU3FCmftWVYGJoRCpD8M4F0MFpoO1NaeQN24HIxg3
         iatD3fYivY2KGe6ZyySyNTot3gz7Jooy5vjp+a4hPkk0HrJzVd8LSim8vEMZSEjwsth6
         3sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FbvaBDv4AuFMFSfD4pfq9eHigQMw7BiJJeXrVGHM3fA=;
        b=RWnEgiIo10Xy8LaipKhFvaiJVbxU4p5srSFzmP6r7jUt28EsKe5qWEFRKC1N0g7TyM
         8xzUorQiK0wjEo8SYmeekpZN+rri6y4NzLDEyhL1Er1gB/wt5OvmpjKwBZepsrr8Ne7B
         +HgPhE1zbQaMCtYAK9eFlIZ4H7Hbf8E7U7Kjf9T7FkvFwsAl+hlUdoyGhmhM1gF8UQ+c
         Zwf0IAOR/Nr1/K2Tk9rTdRgQxoBY6KZdsOXYo7C0fgataOfg/7+j95nO2gNut8TRNSRO
         jlfdQnCibhPUiqoKJ3ruFTpqzT/rtRlbkHKLcP0sxfBCtocJIKHLV0Y685Z9V5H3Rrd6
         rZsg==
X-Gm-Message-State: AFqh2kpd7Tny+qd/5vpa+Btz+7fOe4EjlgZe9SY6GISmVHiP8y8nWGPy
        xY/baZnqbuOJ94qPV7CoIf4=
X-Google-Smtp-Source: AMrXdXspByrb10lD6d3wx+cd+//RpC0wKKyjFT3EOSbGbzGbzu9iO5AvlWjH1aSUay3kBumeIcxLaQ==
X-Received: by 2002:a05:6402:4441:b0:49c:91d8:e989 with SMTP id o1-20020a056402444100b0049c91d8e989mr24706485edb.42.1674509476877;
        Mon, 23 Jan 2023 13:31:16 -0800 (PST)
Received: from ?IPV6:2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7? (dynamic-2a01-0c23-bc5b-9400-dc4c-6fb7-47b2-beb7.c23.pool.telefonica.de. [2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7])
        by smtp.googlemail.com with ESMTPSA id en11-20020a056402528b00b0049fc459ef1fsm192641edb.90.2023.01.23.13.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 13:31:16 -0800 (PST)
Message-ID: <69188960-9d88-4163-8a87-1820fb673eb9@gmail.com>
Date:   Mon, 23 Jan 2023 22:30:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH 8/8] dt-bindings: pinctrl: Add Amlogic Meson pinctrl binding
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

Add Amlogic Meson pinctrl binding.
Tested with make targets dt_binding_check and dtbs_check.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../pinctrl/amlogic,meson-pinctrl.yaml        | 121 ++++++++++++++++++
 .../bindings/pinctrl/meson,pinctrl.txt        |  94 --------------
 2 files changed, 121 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl.yaml
new file mode 100644
index 000000000..afdf4dade
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/amlogic,meson-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson pinmux controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson8-cbus-pinctrl
+      - amlogic,meson8b-cbus-pinctrl
+      - amlogic,meson8m2-cbus-pinctrl
+      - amlogic,meson8-aobus-pinctrl
+      - amlogic,meson8b-aobus-pinctrl
+      - amlogic,meson8m2-aobus-pinctrl
+      - amlogic,meson-gxbb-periphs-pinctrl
+      - amlogic,meson-gxbb-aobus-pinctrl
+      - amlogic,meson-gxl-periphs-pinctrl
+      - amlogic,meson-gxl-aobus-pinctrl
+      - amlogic,meson-axg-periphs-pinctrl
+      - amlogic,meson-axg-aobus-pinctrl
+      - amlogic,meson-g12a-periphs-pinctrl
+      - amlogic,meson-g12a-aobus-pinctrl
+      - amlogic,meson-a1-periphs-pinctrl
+      - amlogic,meson-s4-periphs-pinctrl
+
+  ranges: true
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+required:
+  - compatible
+  - ranges
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties:
+  anyOf:
+    - type: object
+      allOf:
+        - $ref: pincfg-node.yaml#
+        - $ref: pinmux-node.yaml#
+
+patternProperties:
+  "^bank@[0-9]$":
+    type: object
+    properties:
+      reg:
+        minItems: 5
+        maxItems: 5
+
+      reg-names:
+        items:
+          - const: gpio
+          - const: pull
+          - const: pull-enable
+          - const: mux
+          - const: ds
+
+      gpio-controller: true
+
+      "#gpio-cells":
+        const: 2
+
+      gpio-ranges:
+        $ref: /schemas/types.yaml#/definitions/phandle
+
+    required:
+      - reg
+      - reg-names
+      - gpio-controller
+      - "#gpio-cells"
+      - gpio-ranges
+
+examples:
+  - |
+    bus@34400 {
+      reg = <0x0 0x34400 0x0 0x400>;
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pinctrl@40 {
+        compatible = "amlogic,meson-g12a-periphs-pinctrl";
+        #address-cells = <2>;
+        #size-cells = <2>;
+        /* avoid "unit has no reg or ranges property" warning */
+        ranges = <0x0 0x0 0x0 0x34400 0x0 0x100>;
+
+        bank@40 {
+          reg = <0x0 0x40  0x0 0x4c>,
+                <0x0 0xe8  0x0 0x18>,
+                <0x0 0x120 0x0 0x18>,
+                <0x0 0x2c0 0x0 0x40>,
+                <0x0 0x340 0x0 0x1c>;
+          reg-names = "gpio", "pull", "pull-enable", "mux", "ds";
+          gpio-controller;
+          #gpio-cells = <2>;
+          gpio-ranges = <&periphs_pinctrl 0 0 86>;
+        };
+
+        cec_ao_a_h_pins: cec_ao_a_h {
+          mux {
+            groups = "cec_ao_a_h";
+            function = "cec_ao_a_h";
+            bias-disable;
+          };
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
deleted file mode 100644
index 8146193bd..000000000
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ /dev/null
@@ -1,94 +0,0 @@
-== Amlogic Meson pinmux controller ==
-
-Required properties for the root node:
- - compatible: one of "amlogic,meson8-cbus-pinctrl"
-		      "amlogic,meson8b-cbus-pinctrl"
-		      "amlogic,meson8m2-cbus-pinctrl"
-		      "amlogic,meson8-aobus-pinctrl"
-		      "amlogic,meson8b-aobus-pinctrl"
-		      "amlogic,meson8m2-aobus-pinctrl"
-		      "amlogic,meson-gxbb-periphs-pinctrl"
-		      "amlogic,meson-gxbb-aobus-pinctrl"
-		      "amlogic,meson-gxl-periphs-pinctrl"
-		      "amlogic,meson-gxl-aobus-pinctrl"
-		      "amlogic,meson-axg-periphs-pinctrl"
-		      "amlogic,meson-axg-aobus-pinctrl"
-		      "amlogic,meson-g12a-periphs-pinctrl"
-		      "amlogic,meson-g12a-aobus-pinctrl"
-		      "amlogic,meson-a1-periphs-pinctrl"
-		      "amlogic,meson-s4-periphs-pinctrl"
- - reg: address and size of registers controlling irq functionality
-
-=== GPIO sub-nodes ===
-
-The GPIO bank for the controller is represented as a sub-node and it acts as a
-GPIO controller.
-
-Required properties for sub-nodes are:
- - reg: should contain a list of address and size, one tuple for each entry
-   in reg-names.
- - reg-names: an array of strings describing the "reg" entries.
-   Must contain "mux" and "gpio".
-   May contain "pull", "pull-enable" and "ds" when appropriate.
- - gpio-controller: identifies the node as a gpio controller
- - #gpio-cells: must be 2
-
-=== Other sub-nodes ===
-
-Child nodes without the "gpio-controller" represent some desired
-configuration for a pin or a group. Those nodes can be pinmux nodes or
-configuration nodes.
-
-Required properties for pinmux nodes are:
- - groups: a list of pinmux groups. The list of all available groups
-   depends on the SoC and can be found in driver sources.
- - function: the name of a function to activate for the specified set
-   of groups. The list of all available functions depends on the SoC
-   and can be found in driver sources.
-
-Required properties for configuration nodes:
- - pins: a list of pin names
-
-Configuration nodes support the following generic properties, as
-described in file pinctrl-bindings.txt:
- - "bias-disable"
- - "bias-pull-up"
- - "bias-pull-down"
- - "output-enable"
- - "output-disable"
- - "output-low"
- - "output-high"
-
-Optional properties :
- - drive-strength-microamp: Drive strength for the specified pins in uA.
-			    This property is only valid for G12A and newer.
-
-=== Example ===
-
-	pinctrl: pinctrl@c1109880 {
-		compatible = "amlogic,meson8-cbus-pinctrl";
-		reg = <0xc1109880 0x10>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		gpio: banks@c11080b0 {
-			reg = <0xc11080b0 0x28>,
-			      <0xc11080e8 0x18>,
-			      <0xc1108120 0x18>,
-			      <0xc1108030 0x30>;
-			reg-names = "mux", "pull", "pull-enable", "gpio";
-			gpio-controller;
-			#gpio-cells = <2>;
-               };
-
-		nand {
-			mux {
-				groups = "nand_io", "nand_io_ce0", "nand_io_ce1",
-					 "nand_io_rb0", "nand_ale", "nand_cle",
-					 "nand_wen_clk", "nand_ren_clk", "nand_dqs",
-					 "nand_ce2", "nand_ce3";
-				function = "nand";
-			};
-		};
-	};
-- 
2.39.1


