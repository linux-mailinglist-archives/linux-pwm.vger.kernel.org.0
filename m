Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915434B07A4
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Feb 2022 08:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbiBJH7M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Feb 2022 02:59:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiBJH7M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Feb 2022 02:59:12 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B271088;
        Wed,  9 Feb 2022 23:59:13 -0800 (PST)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644479952;
        bh=kgZk2Wfxw/Z1ovu039oPl4PjhgNjv01ns8rfN3+47X4=;
        h=From:To:Cc:Subject;
        b=Q1pSvKIrd3ZcKAmNEMCgWFPLvNjZQ+mKT3HvhxNIiSlrfF24y4/2fRcmus7N0lm9e
         ZbDqJAKt+re4QBVCgg9rAMpaHh6JkHKd8qyRVqHZBqkUGFAz6FZqQILU3A7hwJShdb
         Utyl8dIvzifY4eI/eqiOZ7Yeh+zeAAWw9vRIBYaciCc82NCnmduZEw41ZvHciZ2aBZ
         sjOTkJ0aLe1rZ7RA49X65LBDZG78bVO70FmA+x8CMtHTNjBqWZ4R4lfqnfn1utk1Vb
         GV25B/P5bf5iiZUuoX+elDDVNiKSS6csNra72BFx8HNzpEeH5xqqxgGE23QC2y52Qd
         6ENgg98E6onGA==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: [PATCH v7 1/3] dt-bindings: leds: Optional multi-led unit address
Date:   Thu, 10 Feb 2022 08:59:06 +0100
Message-Id: <20220210075908.120496-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>

The unit address does not make sense in all cases the multi-led node is
used, e.g. for the upcoming PWM multi-color LED driver.

Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v7:
    * (no changes)
    
    Added in v6

 .../devicetree/bindings/leds/leds-class-multicolor.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
index 37445c68cdef..f41d021ed677 100644
--- a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
@@ -20,7 +20,7 @@ description: |
   within this documentation directory.
 
 patternProperties:
-  "^multi-led@([0-9a-f])$":
+  "^multi-led(@[0-9a-f])?$":
     type: object
     description: Represents the LEDs that are to be grouped.
     properties:
-- 
2.35.1

