Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671324BCE4A
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Feb 2022 12:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiBTLv2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 20 Feb 2022 06:51:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBTLv1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 20 Feb 2022 06:51:27 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413754BFC5;
        Sun, 20 Feb 2022 03:51:06 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id B254341B13;
        Sun, 20 Feb 2022 16:50:54 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1645357855; bh=1YlbsxH0JoY8SWFQLXv0f2oen4FfT2iOGdwImk2P+/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zFJVAxQBsaGmtFTDgKuFvoRNb9sDdKLnFM6KovRPcQ/emsRymMpRDvEHdf+hVi62n
         wz72T/lSW9dQh3tWNPLxzk3s7fBOeycZl8U4teFai65tSxD01q6Y0fTLd4+Rj+zWet
         2mmtFvVPTWaEZ7q3FVM2gpUmMqb+WpeM0SFOwOI/mu5QAeEij05LAdE634yLwoiiUB
         kMvOe8t7LHjJZaJzirqS40g4I+wQkXFYd6XVobM107MSItmreGQEhMfo3bDpW1AJ0+
         lRrF9xMQGR9GALrUN7dZ59WOWLI170cIa7iC8QNdQcCKyYsRd/s9ji8/NigF+eN82V
         EXnvJkd02A1Yw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     thierry.reding@gmail.com, lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v6 1/2] dt-bindings: pwm: Document clk based PWM controller
Date:   Sun, 20 Feb 2022 16:50:29 +0500
Message-Id: <20220220115030.23772-2-nikita@trvn.ru>
In-Reply-To: <20220220115030.23772-1-nikita@trvn.ru>
References: <20220220115030.23772-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add YAML devicetree binding for clk based PWM controller

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
--
Changes in v2:
 - fix the file name.
Changes in v4:
 - Use generic node name in the dt bindings example.
Changes in v5:
 - make compatible required
---
 .../devicetree/bindings/pwm/clk-pwm.yaml      | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
new file mode 100644
index 000000000000..ec1768291503
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/clk-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock based PWM controller
+
+maintainers:
+  - Nikita Travkin <nikita@trvn.ru>
+
+description: |
+  Some systems have clocks that can be exposed to external devices.
+  (e.g. by muxing them to GPIO pins)
+  It's often possible to control duty-cycle of such clocks which makes them
+  suitable for generating PWM signal.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: clk-pwm
+
+  clocks:
+    description: Clock used to generate the signal.
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - clocks
+
+examples:
+  - |
+    pwm {
+      compatible = "clk-pwm";
+      #pwm-cells = <2>;
+      clocks = <&gcc 0>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&pwm_clk_flash_default>;
+    };
-- 
2.34.1

