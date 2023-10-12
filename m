Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C071D7C72D4
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378723AbjJLQbZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379625AbjJLQbI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85051CA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaV-0005Gd-7C; Thu, 12 Oct 2023 18:31:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaS-001C8P-UZ; Thu, 12 Oct 2023 18:31:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaS-00F5PU-Le; Thu, 12 Oct 2023 18:31:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 050/109] pwm: clps711x: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:18 +0200
Message-ID: <20231012162827.1002444-161-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2239; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uttibuUPMCE6ihNNpyBu3/EYsQLKMrwihagoZRONhP4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7nptSq9X/VovEsSoHud9NnIAxIHGrKYju6v KIgotuh6oWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge5wAKCRCPgPtYfRL+ Tp0vCACadLS9MSEhBml/p3ME/Gv0XHWVMV/mWt5oPylJO1iYguGDucXBIaSIQC7lAUtsBX5XqPK UBld7pXsN3uN+xII77IBT28O6TswO9oOnFc5Bg3SXpMKw+ldVjveoozDC6n7OeWgdiViXXiNg8D DiXQoLm9MlkYfFmLY6cNtEl+h6UJc7jN0uIxqAQyx9O96Zn0BLlLByn2Fxvo5tS8W63BvHgrEuh fF63arnD6S7yhs/JJKyZk51YMuHWYz0NVj3NYktAJI31xQGH1tfnmZ2fGDcv22suTWXzkrlxl+f b9uX6tZe7kZg9lEKn+1Vcru3qC8TPUtV39K4DgDHVb3elqpc
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

This prepares the pwm-clps711x driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clps711x.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 42179b3f7ec3..f8a05a11a5d0 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -12,7 +12,6 @@
 #include <linux/pwm.h>
 
 struct clps711x_chip {
-	struct pwm_chip chip;
 	void __iomem *pmpcon;
 	struct clk *clk;
 	spinlock_t lock;
@@ -20,7 +19,7 @@ struct clps711x_chip {
 
 static inline struct clps711x_chip *to_clps711x_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct clps711x_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -85,11 +84,13 @@ static struct pwm_device *clps711x_pwm_xlate(struct pwm_chip *chip,
 
 static int clps711x_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct clps711x_chip *priv;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_clps711x_chip(chip);
 
 	priv->pmpcon = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->pmpcon))
@@ -99,15 +100,13 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	priv->chip.ops = &clps711x_pwm_ops;
-	priv->chip.dev = &pdev->dev;
-	priv->chip.npwm = 2;
-	priv->chip.of_xlate = clps711x_pwm_xlate;
-	priv->chip.of_pwm_n_cells = 1;
+	chip->ops = &clps711x_pwm_ops;
+	chip->of_xlate = clps711x_pwm_xlate;
+	chip->of_pwm_n_cells = 1;
 
 	spin_lock_init(&priv->lock);
 
-	return devm_pwmchip_add(&pdev->dev, &priv->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static const struct of_device_id __maybe_unused clps711x_pwm_dt_ids[] = {
-- 
2.42.0

