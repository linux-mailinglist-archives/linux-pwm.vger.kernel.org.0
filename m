Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC90A7746A2
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjHHS67 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjHHS6l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7788CBF
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMz-0006sR-R6; Tue, 08 Aug 2023 19:19:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-00223k-Qx; Tue, 08 Aug 2023 19:19:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-00BTAw-4s; Tue, 08 Aug 2023 19:19:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 013/101] pwm: clps711x: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:03 +0200
Message-Id: <20230808171931.944154-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2239; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VGMaxgSZuYlsEB+RN2MaY7DpmxY/OhNqJv3hIczCQIM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0ni/JiXuCsB4JGI5KX+jPr8zVnS9IL4jFZeQC SQ811enM2GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4vwAKCRCPgPtYfRL+ ThO1B/0S3canp5gGC1kwymR8mULW0NbmJAde9c6HrYW3s0IJIxvy1Gc2St3lBpKCDT7w/ebJyRA XiMp1tbF7XsRSunjVnHzGCDm7GyhhmxuZHXDfI1HdjMhURq7CxNT9OgJKmtvH5uCGzI5HiyZ36V +4QJ7tF3lo2qLKWZD7YVj3yWalbFtHS6EVYYKs91EA1KO+irooqLi071aMkBIKL0qArr8Pcl25Q jn8AB/ruFvPf+VFtpQ7wQ0iwai2HcPOUWxTlJh8Yzas375gwMHHXocSFibDzpfbUH/OGaBapwQb EizB1v25bGVqpIflR4FUbAncadRfgYpj8z+qFGLO/bT7/Q9H
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
2.40.1

