Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2770E614C58
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Nov 2022 15:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiKAORK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Nov 2022 10:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKAORJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Nov 2022 10:17:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97BCE1A817;
        Tue,  1 Nov 2022 07:17:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A01AD23A;
        Tue,  1 Nov 2022 07:17:14 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1B9F3F703;
        Tue,  1 Nov 2022 07:17:06 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <uwu@icenowy.me>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: [PATCH 1/9] dt-bindings: pwm: allwinner,sun4i-a10: Add F1C100s compatible
Date:   Tue,  1 Nov 2022 14:16:50 +0000
Message-Id: <20221101141658.3631342-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101141658.3631342-1-andre.przywara@arm.com>
References: <20221101141658.3631342-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM controller in the Allwinner F1C100s series of SoCs is the same
as in the A20 SoCs, so allow using that as the fallback name.

Join the V3s compatible string in an enum on the way.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml      | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
index 4cc3cc7c50bec..66e400f2a3a4f 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
@@ -25,7 +25,9 @@ properties:
           - const: allwinner,sun8i-a83t-pwm
           - const: allwinner,sun8i-h3-pwm
       - items:
-          - const: allwinner,sun8i-v3s-pwm
+          - enum:
+              - allwinner,suniv-f1c100s-pwm
+              - allwinner,sun8i-v3s-pwm
           - const: allwinner,sun7i-a20-pwm
       - items:
           - const: allwinner,sun50i-a64-pwm
-- 
2.25.1

