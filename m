Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC107C72C7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347329AbjJLQbT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379613AbjJLQbC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:02 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056EECC
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-000516-3G; Thu, 12 Oct 2023 18:30:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaQ-001C7l-J6; Thu, 12 Oct 2023 18:30:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaQ-00F5Oh-A6; Thu, 12 Oct 2023 18:30:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 039/109] pwm: ab8500: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:07 +0200
Message-ID: <20231012162827.1002444-150-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iuOiOOR77ki3z9y7/Se6t+44wfrdR9+cG1nAMH6IJEc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7arHyCygjRpSdPjgYowjkodl8XG2o63BTWv O29IMn1h1WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge2gAKCRCPgPtYfRL+ Tm3ECACTWxTgdcKvaxO6RERo2XT0Kvqk7WiFRc18LbdlO2tnKuS1wmmAkl9idWet+AP0/KlnjbA Hxe+v378DoHvTVKkuGX8CczAeaMi8mTqx/R4rz9BkJJSnjPGKf2aJW72kCOmn/PsAoJyjnG017O RBQl/wj6oD/bRmxI+b5EY6uudgi7t0AaJAQt9yVKrZ+MonfGf0XEidsDSmF3Wgnv2kRKh6gmpVI XOqT1Dd6pHLZwtj1TvhcOEGXtdOgTFZESXw+UH+gbwlhu9yvH53yas0a1OqodbZfz0JozHa7ZpB gyX1/srAF9JBfx98wgmFGiCC5c0GBDiXueul+ELUjFZ7r5sf
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-ab8500 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 719e4ccf1800..f642103931c7 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -24,13 +24,12 @@
 #define AB8500_PWM_CLKRATE 9600000
 
 struct ab8500_pwm_chip {
-	struct pwm_chip chip;
 	unsigned int hwid;
 };
 
 static struct ab8500_pwm_chip *ab8500_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ab8500_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -185,6 +184,7 @@ static const struct pwm_ops ab8500_pwm_ops = {
 
 static int ab8500_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct ab8500_pwm_chip *ab8500;
 	int err;
 
@@ -195,16 +195,16 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	 * Nothing to be done in probe, this is required to get the
 	 * device which is required for ab8500 read and write
 	 */
-	ab8500 = devm_kzalloc(&pdev->dev, sizeof(*ab8500), GFP_KERNEL);
-	if (ab8500 == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*ab8500));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	ab8500->chip.dev = &pdev->dev;
-	ab8500->chip.ops = &ab8500_pwm_ops;
-	ab8500->chip.npwm = 1;
+	ab8500 = pwmchip_priv(chip);
+
+	chip->ops = &ab8500_pwm_ops;
 	ab8500->hwid = pdev->id - 1;
 
-	err = devm_pwmchip_add(&pdev->dev, &ab8500->chip);
+	err = devm_pwmchip_add(&pdev->dev, chip);
 	if (err < 0)
 		return dev_err_probe(&pdev->dev, err, "Failed to add pwm chip\n");
 
-- 
2.42.0

