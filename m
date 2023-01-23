Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522F96789A1
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jan 2023 22:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjAWVbO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Jan 2023 16:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjAWVbN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Jan 2023 16:31:13 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A303346D;
        Mon, 23 Jan 2023 13:31:12 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mg12so34098710ejc.5;
        Mon, 23 Jan 2023 13:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppdW84a0SQYG4k4BGWbGIbCGp/ezutsaizpkowzYII4=;
        b=SxosNVpoA4n4v1mM4hjrl7EWQjEVdhjVSKwY4wB6A7zbLhV4olFTRC2ag5fEwbTUb2
         1weTDmGfKALKHf1iyrFUR5/zapDu9JtJrau6mxyOCE6f3E7rsAJ09rT6oo8BTIJt5u8z
         RtU3OfKNz5kwlmElIkUq1EQECuu1ya74bJsC9wfWmCqXSjs/ENlnsItsdMXfxdJJwBHl
         wZRQDxAA9Q8rSeyD6laFEuKDcu+g/Ujrj39bbs3aePGVy4N8lDvqe0Kaa+7Bq498hNzN
         R6bgoL10S2I3ubBtsNYcOYjnUMiIir5Alhdx7oBV/YzXzr5xNfeulY7O3uN4GuBzqz4O
         P80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppdW84a0SQYG4k4BGWbGIbCGp/ezutsaizpkowzYII4=;
        b=WyI06wiSXgLcjR1xFDlOmfs8ZbPDLU4Kn0HXnk9OJ3MKyrhHp893iV/ruM5mDNT75Q
         l71wGpwjrUEH4kMdH4UMQlb3P0PGm4c3CQcB0F9P1d1sf0NQG7+Zsrftj6cSov+TnHe7
         VuV1vsRq2GPBvCO1EHdArKUbrE9b3QN8MmqBgAJ39gL/2nSYiZDx2io/8HS8uc5AxLhg
         t30SMkKYdHL3CXqR0POfGWzvNRr4oGL6j1PotZiMCJZexDnYrzGCWC9sZWLNPNmS2RVC
         oKMsErHyWz1xxqK/q2j8obpOvfyEvm5KWIFpktSSGEbWxxw8UXRCfftiyRQw7TIaCr+S
         IGhg==
X-Gm-Message-State: AFqh2krCyGd1B1idc+Zm46xwFLfXs3PCoNcoTht2jQhrkvhMkPQb3f7t
        Ft+dlsObmT93XAKl9C3d0/g=
X-Google-Smtp-Source: AMrXdXsMnmrNmfbXjdlkXwkZoLz0pQ+2wP521XDFsAYfrWEjIMh5t4BBWLO/BsF5i1V9UbMiwSnExQ==
X-Received: by 2002:a17:907:2395:b0:871:629:227c with SMTP id vf21-20020a170907239500b008710629227cmr22744678ejb.66.1674509470778;
        Mon, 23 Jan 2023 13:31:10 -0800 (PST)
Received: from ?IPV6:2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7? (dynamic-2a01-0c23-bc5b-9400-dc4c-6fb7-47b2-beb7.c23.pool.telefonica.de. [2a01:c23:bc5b:9400:dc4c:6fb7:47b2:beb7])
        by smtp.googlemail.com with ESMTPSA id 8-20020a170906328800b00871cb1b8f63sm11109155ejw.26.2023.01.23.13.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 13:31:10 -0800 (PST)
Message-ID: <440a7cad-d48f-8975-4dfd-265b235bf629@gmail.com>
Date:   Mon, 23 Jan 2023 22:28:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH 5/8] dt-bindings: rtc: Add Amlogic Meson vrtc controller
 binding
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

Add Amlogic Meson vrtc controller binding.
Tested with make targets dt_binding_check and dtbs_check.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../bindings/rtc/amlogic,meson-vrtc.yaml      | 50 +++++++++++++++++++
 .../bindings/rtc/rtc-meson-vrtc.txt           | 22 --------
 2 files changed, 50 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
new file mode 100644
index 000000000..26a70b3ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/amlogic,meson-vrtc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/amlogic,meson-vrtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Virtual RTC (VRTC)
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description: |
+  This is a Linux interface to an RTC managed by firmware, hence it's
+  virtual from a Linux perspective.  The interface is 1 register where
+  an alarm time (in seconds) is to be written.
+  The alarm register is a simple scratch register shared between the
+  application processors (AP) and the secure co-processor (SCP.)  When
+  the AP suspends, the SCP will use the value of this register to
+  program an always-on timer before going sleep. When the timer expires,
+  the SCP will wake up and will then wake the AP.
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-vrtc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus@ff800000 {
+      reg = <0x0 0xff800000 0x0 0x100000>;
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      rtc@a8 {
+        compatible = "amlogic,meson-vrtc";
+        reg = <0x0 0x000a8 0x0 0x4>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt b/Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt
deleted file mode 100644
index c014f54a9..000000000
--- a/Documentation/devicetree/bindings/rtc/rtc-meson-vrtc.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-* Amlogic Virtual RTC (VRTC)
-
-This is a Linux interface to an RTC managed by firmware, hence it's
-virtual from a Linux perspective.  The interface is 1 register where
-an alarm time (in seconds) is to be written.
-
-Required properties:
-- compatible: should be "amlogic,meson-vrtc"
-- reg: physical address for the alarm register
-
-The alarm register is a simple scratch register shared between the
-application processors (AP) and the secure co-processor (SCP.)  When
-the AP suspends, the SCP will use the value of this register to
-program an always-on timer before going sleep. When the timer expires,
-the SCP will wake up and will then wake the AP.
-
-Example:
-
-	vrtc: rtc@0a8 {
-		compatible = "amlogic,meson-vrtc";
-		reg = <0x0 0x000a8 0x0 0x4>;
-	};
-- 
2.39.1


