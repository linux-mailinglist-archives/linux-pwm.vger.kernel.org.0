Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA079774698
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjHHS6z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjHHS6j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815F08CBB
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-0006oQ-OA; Tue, 08 Aug 2023 19:19:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-00223N-2j; Tue, 08 Aug 2023 19:19:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMx-00BTAi-Af; Tue, 08 Aug 2023 19:19:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 009/101] pwm: bcm-kona: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:17:59 +0200
Message-Id: <20230808171931.944154-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4lOgYJf9pELkAq0II4KGpCMH7rGjczQ12sdM6GbU9M8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0ni6V0mz34GNKezmoX0DUsCqRjiogfDHDRhJh kk+xucB55OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4ugAKCRCPgPtYfRL+ TqHSCACnqETl7NrXG4QNZ8zs5xkYxi5l4mQrowZMSN93EDXdRS/F57SNuISZCUYmmtwHt0rAcoE mynZS+iPTtEW9tR/DQa6EKQ3w/sbUz3hOCWHikpDvLLBoW6Fue0DIfVqnpcIA5Jbkh6flM4YFDD Rt6yL3qdbIExPzAVM23eqSko+hq6wmunRIcFpsfcZ4L6CEmL/9FCjHvgOPvfgSsEmKyTVd8MTCO DrAKyrFM+Fm/7Brj6WUShfMnRwRZoqQBZBsYo9Q7NgkGPpOtU1PvQmc75U3ojT7RAEs1XBnZuQz MXSqn26dx8W2psL0JJHqueG32In248WXwq0ioYn6pbz08K+V
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

This prepares the pwm-bcm-kona driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-kona.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index c0d9956b6443..a0d961173b86 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -56,14 +56,13 @@
 #define DUTY_CYCLE_HIGH_MAX			0x00ffffff
 
 struct kona_pwmc {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *chip)
 {
-	return container_of(chip, struct kona_pwmc, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -264,18 +263,18 @@ static const struct pwm_ops kona_pwm_ops = {
 
 static int kona_pwmc_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct kona_pwmc *kp;
 	unsigned int chan;
 	unsigned int value = 0;
 	int ret = 0;
 
-	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
-	if (kp == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, 6, sizeof(*kp));
+	if (chip == NULL)
 		return -ENOMEM;
+	kp = to_kona_pwmc(chip);
 
-	kp->chip.dev = &pdev->dev;
-	kp->chip.ops = &kona_pwm_ops;
-	kp->chip.npwm = 6;
+	chip->ops = &kona_pwm_ops;
 
 	kp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kp->base))
@@ -295,14 +294,14 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	}
 
 	/* Set push/pull for all channels */
-	for (chan = 0; chan < kp->chip.npwm; chan++)
+	for (chan = 0; chan < chip->npwm; chan++)
 		value |= (1 << PWM_CONTROL_TYPE_SHIFT(chan));
 
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
 	clk_disable_unprepare(kp->clk);
 
-	ret = devm_pwmchip_add(&pdev->dev, &kp->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 
-- 
2.40.1

