Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776617746A9
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjHHS7C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjHHS6q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7801DD4D
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN7-0007JX-Fi; Tue, 08 Aug 2023 19:19:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN5-002269-NY; Tue, 08 Aug 2023 19:19:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN4-00BTCu-El; Tue, 08 Aug 2023 19:19:50 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 043/101] pwm: rcar: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:33 +0200
Message-Id: <20230808171931.944154-44-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PCPs3l8Rtqy4VFXyX1jGhoaaE/+fv/DDx8twmDHKGZs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njh9/z9YmO1bvqIintepo+VT5W4vXlroV5iu RNHbF3+nnmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ44QAKCRCPgPtYfRL+ TjgyB/9N2rcPFfs8oehYg7MpBDhHsf5W5Jg9VQJumBVqN9zuzTf0KTle1BROtfV1wZFRG9Z1lsj QVgQ5uYJBpr+/yq16ctScQ4rqpq4dZslxT9lQrb7KqFUaJU86C7xqGh4z+/p60Pv8mCYWAI0zv7 vEbFV2xD2s7TqUV8zoA9kBxADXfXxgXpdAM9CdBbWrnEc67i5c2s0Fpy1iZQQLY9GCT0V9IjoQ+ oDC7PFK/eUgbaK0ZfEdcRX6AQ31knCguUeSXLBbftbVfk/+ZQXAKgAOQezkkU5G9/wkgyQto+6p ATl3rpdxpg6FyyESnHkngs6WyIpxB7ReR2OVe6kJCsm+tqE6
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

This prepares the pwm-rcar driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rcar.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 13269f55fccf..5bb7b579705d 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -38,14 +38,13 @@
 #define  RCAR_PWMCNT_PH0_SHIFT	0
 
 struct rcar_pwm_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rcar_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static void rcar_pwm_write(struct rcar_pwm_chip *rp, u32 data,
@@ -202,12 +201,14 @@ static const struct pwm_ops rcar_pwm_ops = {
 
 static int rcar_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct rcar_pwm_chip *rcar_pwm;
 	int ret;
 
-	rcar_pwm = devm_kzalloc(&pdev->dev, sizeof(*rcar_pwm), GFP_KERNEL);
-	if (rcar_pwm == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*rcar_pwm));
+	if (chip == NULL)
 		return -ENOMEM;
+	rcar_pwm = to_rcar_pwm_chip(chip);
 
 	rcar_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rcar_pwm->base))
@@ -219,15 +220,13 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(rcar_pwm->clk);
 	}
 
-	platform_set_drvdata(pdev, rcar_pwm);
+	platform_set_drvdata(pdev, chip);
 
-	rcar_pwm->chip.dev = &pdev->dev;
-	rcar_pwm->chip.ops = &rcar_pwm_ops;
-	rcar_pwm->chip.npwm = 1;
+	chip->ops = &rcar_pwm_ops;
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = pwmchip_add(&rcar_pwm->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
 		pm_runtime_disable(&pdev->dev);
@@ -239,9 +238,9 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 
 static void rcar_pwm_remove(struct platform_device *pdev)
 {
-	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&rcar_pwm->chip);
+	pwmchip_remove(chip);
 
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.40.1

