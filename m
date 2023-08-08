Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC6377485A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236327AbjHHTbx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjHHTbg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:31:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B6D1DD7B
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-0007Tm-AF; Tue, 08 Aug 2023 19:19:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-00228j-Vr; Tue, 08 Aug 2023 19:19:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-00BTEv-09; Tue, 08 Aug 2023 19:19:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 074/101] pwm: ep93xx: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:04 +0200
Message-Id: <20230808171931.944154-75-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1768; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OrV6AyToXA66fQ4T2Nne0dj4277PjMb9E7m28Iebttw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkEf1T00zXwNikaw2uC3Dxx4qoDlHg91UNiC TN7XIK7owWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5BAAKCRCPgPtYfRL+ TklbB/4rDGtisc3TfyWslr16apf6ybBjgiyO7gYR3EeX/nAujP/lSkDMpNmCgqfhKE7UfqO1k1Z UESNy1y090kSZvCRPb0kQuB2Co87RsTcsC6UBJHEg27RqRYkzh1vjm1jdeDFwa45Y7XAq/3MDX7 Zs3AGdC8d5bQkGrqnY6nncmOhkJH8wQVGVVa00y6Bo4nCwkm9CNFfo2Sm8dfNY13LF8TUv1c1LJ JogOwTsfiqSOn4ycCQWBRGYQyRJ2+AfypmZ6gQCrxJ7E0hA4brAduUlo91Tp4cG1K7DXsH0n63u lDO2/KGuOpJBuC+2q9Z1HQ1Rfu8heYwx5yYzVUI983vIq96x
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ep93xx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 394013c545ac..4d5147b403a4 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -34,6 +34,7 @@
 #define EP93XX_PWMx_INVERT	0x0c
 
 struct ep93xx_pwm {
+	struct platform_device *pdev;
 	void __iomem *base;
 	struct clk *clk;
 };
@@ -45,16 +46,16 @@ static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
 
 static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct platform_device *pdev = to_platform_device(chip->dev);
+	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
 
-	return ep93xx_pwm_acquire_gpio(pdev);
+	return ep93xx_pwm_acquire_gpio(ep93xx_pwm->pdev);
 }
 
 static void ep93xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct platform_device *pdev = to_platform_device(chip->dev);
+	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
 
-	ep93xx_pwm_release_gpio(pdev);
+	ep93xx_pwm_release_gpio(ep93xx_pwm->pdev);
 }
 
 static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -171,6 +172,8 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	ep93xx_pwm = to_ep93xx_pwm(chip);
 
+	ep93xx_pwm->pdev = pdev;
+
 	ep93xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ep93xx_pwm->base))
 		return PTR_ERR(ep93xx_pwm->base);
-- 
2.40.1

