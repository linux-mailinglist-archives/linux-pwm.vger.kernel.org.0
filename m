Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A377746A8
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjHHS7C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjHHS6p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4209D175DE1
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-0006x4-2T; Tue, 08 Aug 2023 19:19:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN0-00224F-BT; Tue, 08 Aug 2023 19:19:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMz-00BTBI-6f; Tue, 08 Aug 2023 19:19:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 018/101] pwm: ep93xx: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:08 +0200
Message-Id: <20230808171931.944154-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1948; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VfrtTR+Dtyhr5FLbkLufFmJM/RHPuoPF+Xuq/msUwmE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njEII5IhS61s2NQmo+1bsIAQkBel4reiBSB7 fjVD2y3cXiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4xAAKCRCPgPtYfRL+ Tg5CB/47lPMW7hX0EKTdv5/ZkjJAxB0hQsXQFm3ATFp8VfXi/1eKSXqRgmcwUza0OEUUCU9yCeg uCFzbd1Hb+UPy3CNgYlaItxld4GiijGq6NNSursEtr+YFAa4+NcdbZDjdqvueQJdQd45yapvpcU OLUW2w3KXl+sC6XnvfMkr8m9sy/UjqVl0n8jNquqUHXsqljSA1wDlfiODddXQBYAZQD+bZk3jox M4NORy/+0g14FBvj6W9KIhMfjzAqi+PuOJ1HUmRNHR//D6olzWlp4a68ItBi9rR4/LjGU+6sHY3 XfmtB9IJxwXML1eqaQf7poxR1Xa0fgtfAxNPxM4ppbral2+a
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-ep93xx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ep93xx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 51e072572a87..394013c545ac 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -36,12 +36,11 @@
 struct ep93xx_pwm {
 	void __iomem *base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ep93xx_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -163,12 +162,14 @@ static const struct pwm_ops ep93xx_pwm_ops = {
 
 static int ep93xx_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct ep93xx_pwm *ep93xx_pwm;
 	int ret;
 
-	ep93xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*ep93xx_pwm), GFP_KERNEL);
-	if (!ep93xx_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*ep93xx_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ep93xx_pwm = to_ep93xx_pwm(chip);
 
 	ep93xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ep93xx_pwm->base))
@@ -178,11 +179,9 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(ep93xx_pwm->clk))
 		return PTR_ERR(ep93xx_pwm->clk);
 
-	ep93xx_pwm->chip.dev = &pdev->dev;
-	ep93xx_pwm->chip.ops = &ep93xx_pwm_ops;
-	ep93xx_pwm->chip.npwm = 1;
+	chip->ops = &ep93xx_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &ep93xx_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return ret;
 
-- 
2.40.1

