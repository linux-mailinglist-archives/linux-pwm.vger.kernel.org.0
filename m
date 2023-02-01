Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0658E687C53
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Feb 2023 12:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjBBLcD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 2 Feb 2023 06:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjBBLbc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Feb 2023 06:31:32 -0500
X-Greylist: delayed 517 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 03:31:23 PST
Received: from algol.kleine-koenig.org (algol.kleine-koenig.org [IPv6:2a01:4f8:c010:8611::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A0A8C1E7
        for <linux-pwm@vger.kernel.org>; Thu,  2 Feb 2023 03:31:22 -0800 (PST)
Received: by algol.kleine-koenig.org (Postfix, from userid 1000)
        id 1CE76793DD2; Thu,  2 Feb 2023 12:22:43 +0100 (CET)
Envelope-to: u.kleine-koenig@pengutronix.de
Delivery-date: Wed, 01 Feb 2023 20:27:49 +0100
Received: from fudo.makrotopia.org ([2a07:2ec0:3002::71])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@makrotopia.org>)
        id 1pNIlm-0002Qu-88
        for u.kleine-koenig@pengutronix.de; Wed, 01 Feb 2023 20:27:49 +0100
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pNIle-000267-2N;
        Wed, 01 Feb 2023 20:27:38 +0100
Date:   Wed, 1 Feb 2023 19:25:57 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <70fe0b606d988958b87f89828b8728e2f68eaace.1675278958.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a07:2ec0:3002::71
X-SA-Exim-Mail-From: daniel@makrotopia.org
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH] dt-bindings: pwm: mediatek: add mediatek,mt7986 compatible
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.ext.pengutronix.de)
X-PTX-Original-Recipient: u.kleine-koenig@pengutronix.de
X-PTX-Original-Recipient: ukl@pengutronix.de
X-TUID: 15dsyLTD+p3P
Tags:   inbox pwm-ready
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit 241eab76657f ("pwm: mediatek: Add support for MT7986")
support for the 2 PWM channels implemented in MediaTek MT7986 SoCs has
been added. Also add the compatible string to dt-bindings now that
they have been converted to YAML.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
This patch has previously been submitted, but we decided to deferr it until
after the conversion to YAML which has now been done via commit
3e98855ca0cf ("dt-bindings: pwm: mediatek: Convert pwm-mediatek to DT schema")
See
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/Y39PjU1BqBB8tZ98@makrotopia.org/

Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
index dbc974bff9e9..8e176ba7a525 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
@@ -22,6 +22,7 @@ properties:
           - mediatek,mt7623-pwm
           - mediatek,mt7628-pwm
           - mediatek,mt7629-pwm
+          - mediatek,mt7986-pwm
           - mediatek,mt8183-pwm
           - mediatek,mt8365-pwm
           - mediatek,mt8516-pwm

base-commit: 66eee64b235411d512bed4d672c2d00683239daf
-- 
2.39.1


