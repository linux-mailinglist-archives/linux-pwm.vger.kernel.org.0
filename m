Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DDF4F77C7
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Apr 2022 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241967AbiDGHl3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 7 Apr 2022 03:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241987AbiDGHlZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 7 Apr 2022 03:41:25 -0400
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3896B63384;
        Thu,  7 Apr 2022 00:39:16 -0700 (PDT)
From:   sven@svenschwermer.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1649316787;
        bh=pjAbnCs8cCcjtdBzAC9l+vd148bcJSfRgwQvGacOiYo=;
        h=From:To:Cc:Subject:In-Reply-To:References;
        b=cVhZja7pc4Ynpk20QCFXwL/8+1eOnP9W/STrPiSISAPoeL5O1CbMuAF1Odhv+EsyY
         EEIbywrnMOnPkxk1NGbZzkPPLgr0wIFBbN6QZHEcuVh2BZwWj3LEWAPqAJOyW3xh4l
         yaGBX/QpWdqmTUjVbLYpL329pCFHoNWVXTs2bQ4huD8ZnAXsAhwPFWJaS1XmXWJChB
         z2cUS+9kwS3PJ+0k5eLXWwWOlYeeflvSbJL9cIRQ+zsBpsDZp4slmbjtc59ykOo3vL
         ndTwIna7IwX7LRVm7Ee+e22n8rVmuXv1P3oP4DX8dzzW120fBUvgdbZleq5P22tCM1
         zdtyhXNUtSVng==
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, robh+dt@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        post@lespocky.de, andy.shevchenko@gmail.com, robh@kernel.org
Subject: [PATCH v8 1/3 RESEND] dt-bindings: leds: Optional multi-led unit address
Date:   Thu,  7 Apr 2022 09:32:23 +0200
Message-Id: <20220407073225.71605-2-sven@svenschwermer.de>
In-Reply-To: <20220407073225.71605-1-sven@svenschwermer.de>
References: <20220407073225.71605-1-sven@svenschwermer.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

