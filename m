Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083C578985C
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Aug 2023 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjHZRRa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 26 Aug 2023 13:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjHZRRP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 26 Aug 2023 13:17:15 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633E1BDB;
        Sat, 26 Aug 2023 10:17:13 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id C134B1000D0; Sat, 26 Aug 2023 18:17:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1693070231; bh=Lbm8wzOKC2M9GeSPbw06e8KPiOFgpvPECNpJXbRnIo4=;
        h=From:To:Cc:Subject:Date:From;
        b=j9u+3HNFtL/ansIVY+kJ3/2edhhGvGpGn6BYGnX27uq8OmsPe8Y19TZW7+NgLx6g5
         9cdoJ+efWCPyt4YPyi2KRjsqxHa+lxtqIYlIlY+hX9KqLyzbwx1891j7C3pTynEs6J
         H2ErMmFPJttjPT8iXlbCT4Mp/mKFedFttF86kgGsZSPXLqvAvTxY/rVG8aubFlDPqO
         xVwicVAj5iHnWZnl6PnQcXNPjXRvf/WIZEnY7qVKLI6hFeAEov860KW3ZoXSnOFZTm
         5+QuPlFkCALmT3AJOaaAcsKzZ655Djqrt4rs4JJ50f6ebSo2v6cJ1zqm1aCJZ8ku+x
         oVqbnUtBMdh4Q==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>
Subject: [PATCH v4 2/2] dt-bindings: media: remove nokia,n900-ir as pwm-ir-tx is compatible
Date:   Sat, 26 Aug 2023 18:17:11 +0100
Message-Id: <20230826171711.366710-1-sean@mess.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The generic pwm-ir-tx driver works for the Nokia n900, so nokia,n900-ir
can be removed.

Signed-off-by: Sean Young <sean@mess.org>
---
 .../bindings/leds/irled/pwm-ir-tx.yaml        |  5 ++++-
 .../devicetree/bindings/media/nokia,n900-ir   | 20 -------------------
 2 files changed, 4 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/nokia,n900-ir

diff --git a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
index f2a6fa140f38..7526e3149f72 100644
--- a/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
+++ b/Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
@@ -15,7 +15,10 @@ description:
 
 properties:
   compatible:
-    const: pwm-ir-tx
+    oneOf:
+      - const: pwm-ir-tx
+      - const: nokia,n900-ir
+        deprecated: true
 
   pwms:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/media/nokia,n900-ir b/Documentation/devicetree/bindings/media/nokia,n900-ir
deleted file mode 100644
index 13a18ce37dd1..000000000000
--- a/Documentation/devicetree/bindings/media/nokia,n900-ir
+++ /dev/null
@@ -1,20 +0,0 @@
-Device-Tree bindings for LIRC TX driver for Nokia N900(RX51)
-
-Required properties:
-	- compatible: should be "nokia,n900-ir".
-	- pwms: specifies PWM used for IR signal transmission.
-
-Example node:
-
-	pwm9: dmtimer-pwm@9 {
-		compatible = "ti,omap-dmtimer-pwm";
-		ti,timers = <&timer9>;
-		ti,clock-source = <0x00>; /* timer_sys_ck */
-		#pwm-cells = <3>;
-	};
-
-	ir: n900-ir {
-		compatible = "nokia,n900-ir";
-
-		pwms = <&pwm9 0 26316 0>; /* 38000 Hz */
-	};
-- 
2.42.0

