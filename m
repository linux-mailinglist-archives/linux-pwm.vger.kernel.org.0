Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392895EF37D
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Sep 2022 12:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiI2KbF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Sep 2022 06:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiI2KbE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Sep 2022 06:31:04 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC195128899;
        Thu, 29 Sep 2022 03:31:02 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,354,1654527600"; 
   d="scan'208";a="136619473"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Sep 2022 19:31:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4F990400F7A2;
        Thu, 29 Sep 2022 19:30:58 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, Lee Jones <lee@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3 PWM
Date:   Thu, 29 Sep 2022 11:30:39 +0100
Message-Id: <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document RZ/G2L MTU3 PWM support. It supports following pwm modes.
	1) PWM mode 1
	2) PWM mode 2
	3) Reset-synchronized PWM mode
	4) Complementary PWM mode 1 (transfer at crest)
	5) Complementary PWM mode 2 (transfer at trough)
	6) Complementary PWM mode 3 (transfer at crest and trough)

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/mfd/renesas,rzg2l-mtu3.yaml      | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml b/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
index c4bcf28623d6..362fedf5bedb 100644
--- a/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
+++ b/Documentation/devicetree/bindings/mfd/renesas,rzg2l-mtu3.yaml
@@ -223,6 +223,50 @@ patternProperties:
       - compatible
       - reg
 
+  "^pwm@([0-4]|[6-7])+$":
+    type: object
+
+    properties:
+      compatible:
+        const: renesas,rz-mtu3-pwm
+
+      reg:
+        description: Identify pwm channels.
+        items:
+          enum: [ 0, 1, 2, 3, 4, 6, 7 ]
+
+      "#pwm-cells":
+        const: 2
+
+      renesas,pwm-mode1:
+        type: boolean
+        description: Enable PWM mode 1.
+
+      renesas,pwm-mode2:
+        type: boolean
+        description: Enable PWM mode 2.
+
+      renesas,reset-synchronized-pwm-mode:
+        type: boolean
+        description: Enable Reset-synchronized PWM mode.
+
+      renesas,complementary-pwm-mode1:
+        type: boolean
+        description: Complementary PWM mode 1 (transfer at crest).
+
+      renesas,complementary-pwm-mode2:
+        type: boolean
+        description: Complementary PWM mode 2 (transfer at trough).
+
+      renesas,complementary-pwm-mode3:
+        type: boolean
+        description: Complementary PWM mode 3 (transfer at crest and trough).
+
+    required:
+      - compatible
+      - reg
+      - "#pwm-cells"
+
 required:
   - compatible
   - reg
@@ -305,6 +349,12 @@ examples:
         compatible = "renesas,rzg2l-mtu3-counter";
         reg = <1>;
       };
+      pwm@3 {
+        compatible = "renesas,rz-mtu3-pwm";
+        reg = <3>;
+        #pwm-cells = <2>;
+        renesas,pwm-mode1;
+      };
     };
 
 ...
-- 
2.25.1

