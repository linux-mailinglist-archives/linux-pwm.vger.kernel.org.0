Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C92C4C1C78
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Feb 2022 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiBWTqp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Feb 2022 14:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiBWTqp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Feb 2022 14:46:45 -0500
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE0B4B400;
        Wed, 23 Feb 2022 11:46:16 -0800 (PST)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1645645573;
        bh=pjAbnCs8cCcjtdBzAC9l+vd148bcJSfRgwQvGacOiYo=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=TRdZkz9/Dvj7EcoVQoyX0DRrVBTsve1NOg3BkdbgKWOeeo9+AI3Qnd0Uuy7vlw5xI
         2frocOi4sbawlmWCTDQ1RE/WJGEXHoAu+gAEcmZfs/rvrBjwsqYHEHYE5qJ71zbn6B
         FrRRf5gsCGZQUsOB2l70/xjRihq49JhZKe/XhaHTj03pUwP0R8Lc3hwxq5bvmHY1S9
         YOc2O3LAHDPUDxt+26aSGWqnfk4kuCbS7JTIlB0zR2sywbVGDxU/B8FmBceJaMKFUL
         yZ0Av3NQwbiVj5xYQYGqvzv58L0ekKUGp4bzL3B/yLS7aK2E63rCEGRU6/JH5K6CS6
         TzK3yho0GRjKg==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: [PATCH v8 1/3] dt-bindings: leds: Optional multi-led unit address
Date:   Wed, 23 Feb 2022 20:45:39 +0100
Message-Id: <20220223194541.826572-2-sven@svenschwermer.de>
In-Reply-To: <20220223194541.826572-1-sven@svenschwermer.de>
References: <20220223194541.826572-1-sven@svenschwermer.de>
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
    Changes in v8:
    * (no changes)
    
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

