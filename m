Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B036D774876
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjHHTd0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjHHTdJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:33:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822831DD68
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-0007Qx-DY; Tue, 08 Aug 2023 19:19:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN9-00227x-TP; Tue, 08 Aug 2023 19:19:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN9-00BTEP-AS; Tue, 08 Aug 2023 19:19:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 066/101] gpio: mvebu: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:56 +0200
Message-Id: <20230808171931.944154-67-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2210; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0P4Z7oK+1rjBDbpjk4rh3340iV+J+zCKBCWGQgz7SvI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nj7ub5JOy7JxIjSPWn69XcIRnIv3YJZob3W6 NXCoiUxoZSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4+wAKCRCPgPtYfRL+ ToPyCACzn1Ffh5omiy9dImR5yzSVYV4+XIxkIPOf8k7VVQom5RI//9IF02HT2YxIjvOtAMa3R7V vcTlA77WiqE9pS9d9YXhLqAZRgz9OyhRuZtBAgRWpLi8WmECAXstGCbq54B2pTURd6M8URNob/b HUy0tFw55sw/JCZmycc7XWvtYsciELyJGj1G4+uZp4vjqMbFVQATcOeb45sue6BWbIHAD4dWktT s+S6u6zU1jL919AhtBSf2xHkyaInwb/Diib16Wgw132xDZGkjMCm+W5jdAqISUetWcjMAHf+rK2 vUJ3vr6TR1KEpIszoqI9dLBXBqd6fFEwHJIbplLo/I3hejYj
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

This prepares the pwm sub-driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-mvebu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index b8387fea630e..6dec099dcc7d 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -98,7 +98,6 @@ struct mvebu_pwm {
 	u32			 offset;
 	unsigned long		 clk_rate;
 	struct gpio_desc	*gpiod;
-	struct pwm_chip		 chip;
 	spinlock_t		 lock;
 	struct mvebu_gpio_chip	*mvchip;
 
@@ -614,7 +613,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
  */
 static struct mvebu_pwm *to_mvebu_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mvebu_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -788,6 +787,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct mvebu_pwm *mvpwm;
+	struct pwm_chip *chip;
 	void __iomem *base;
 	u32 offset;
 	u32 set;
@@ -812,9 +812,11 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	if (IS_ERR(mvchip->clk))
 		return PTR_ERR(mvchip->clk);
 
-	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
-	if (!mvpwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, mvchip->chip.ngpio, sizeof(struct mvebu_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mvpwm = pwmchip_priv(chip);
+
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
 	mvpwm->offset = offset;
@@ -867,13 +869,11 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	mvpwm->chip.dev = dev;
-	mvpwm->chip.ops = &mvebu_pwm_ops;
-	mvpwm->chip.npwm = mvchip->chip.ngpio;
+	chip->ops = &mvebu_pwm_ops;
 
 	spin_lock_init(&mvpwm->lock);
 
-	return devm_pwmchip_add(dev, &mvpwm->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.40.1

