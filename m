Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F38774400
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjHHSOm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbjHHSON (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475541DD04
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-0007PU-DO; Tue, 08 Aug 2023 19:19:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN8-00227T-NL; Tue, 08 Aug 2023 19:19:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN8-00BTDz-1n; Tue, 08 Aug 2023 19:19:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 060/101] pwm: tiehrpwm: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:50 +0200
Message-Id: <20230808171931.944154-61-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5217; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XxND4k4SMJu9VNS5d2H1BQtRHZimIGxw5iI53F6tRHc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nj0LyfvgVN8829voTFPRIAD0o/xOOp0Wh+Tz BR1ps3DS0WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ49AAKCRCPgPtYfRL+ TtxRCACF1NMQXeuHXlAzQSsbKgcpooAWjIdu+25+mb7JUJh/3z5mBgW+PIzc+XjU06LN78Lq9pv 7dG6akVe0TQQFPRLXLfsZWJDWrkOXkFmctqZRtOgQrmFveZcUF1Tk4XRHkcJ6itFkd6bwzPlBty b4JFGnxftXtYL1NKUYZF1bwXi/oQ4YMv42PfHSTarTWMSH4RKXsY4uJL90DgKILdPupuplWHRQ1 /lREu9sui8kKSmaQfvBJdfyzQY59TgYHjvdJ1zmUfnbWZmRaezwcmhjjkhIppYFfOXLz2FeLLcK TC7InRYjQ7Og8QK//AttkQM1jJ1M8e91+aXAxcgsmihoevQS
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

This prepares the pwm-tiehrpwm driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiehrpwm.c | 52 ++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 27cf9d001ae1..5516cca7e3ac 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -105,7 +105,6 @@ struct ehrpwm_context {
 };
 
 struct ehrpwm_pwm_chip {
-	struct pwm_chip chip;
 	unsigned long clk_rate;
 	void __iomem *mmio_base;
 	unsigned long period_cycles[NUM_PWM_CHANNEL];
@@ -116,7 +115,7 @@ struct ehrpwm_pwm_chip {
 
 static inline struct ehrpwm_pwm_chip *to_ehrpwm_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ehrpwm_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u16 ehrpwm_read(void __iomem *base, unsigned int offset)
@@ -441,13 +440,15 @@ MODULE_DEVICE_TABLE(of, ehrpwm_of_match);
 static int ehrpwm_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pwm_chip *chip;
 	struct ehrpwm_pwm_chip *pc;
 	struct clk *clk;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_ehrpwm_pwm_chip(chip);
 
 	clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
@@ -466,9 +467,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &ehrpwm_pwm_ops;
-	pc->chip.npwm = NUM_PWM_CHANNEL;
+	chip->ops = &ehrpwm_pwm_ops;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
@@ -485,13 +484,13 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		goto err_clk_unprepare;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
@@ -504,9 +503,10 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 static void ehrpwm_pwm_remove(struct platform_device *pdev)
 {
-	struct ehrpwm_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	clk_unprepare(pc->tbclk);
 
@@ -514,9 +514,11 @@ static void ehrpwm_pwm_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
-static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
+static void ehrpwm_pwm_save_context(struct pwm_chip *chip)
 {
-	pm_runtime_get_sync(pc->chip.dev);
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	pm_runtime_get_sync(chip->dev);
 
 	pc->ctx.tbctl = ehrpwm_read(pc->mmio_base, TBCTL);
 	pc->ctx.tbprd = ehrpwm_read(pc->mmio_base, TBPRD);
@@ -527,11 +529,13 @@ static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
 	pc->ctx.aqsfrc = ehrpwm_read(pc->mmio_base, AQSFRC);
 	pc->ctx.aqcsfrc = ehrpwm_read(pc->mmio_base, AQCSFRC);
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(chip->dev);
 }
 
-static void ehrpwm_pwm_restore_context(struct ehrpwm_pwm_chip *pc)
+static void ehrpwm_pwm_restore_context(struct pwm_chip *chip)
 {
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
 	ehrpwm_write(pc->mmio_base, TBPRD, pc->ctx.tbprd);
 	ehrpwm_write(pc->mmio_base, CMPA, pc->ctx.cmpa);
 	ehrpwm_write(pc->mmio_base, CMPB, pc->ctx.cmpb);
@@ -544,13 +548,13 @@ static void ehrpwm_pwm_restore_context(struct ehrpwm_pwm_chip *pc)
 
 static int ehrpwm_pwm_suspend(struct device *dev)
 {
-	struct ehrpwm_pwm_chip *pc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	unsigned int i;
 
-	ehrpwm_pwm_save_context(pc);
+	ehrpwm_pwm_save_context(chip);
 
-	for (i = 0; i < pc->chip.npwm; i++) {
-		struct pwm_device *pwm = &pc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -564,11 +568,11 @@ static int ehrpwm_pwm_suspend(struct device *dev)
 
 static int ehrpwm_pwm_resume(struct device *dev)
 {
-	struct ehrpwm_pwm_chip *pc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	unsigned int i;
 
-	for (i = 0; i < pc->chip.npwm; i++) {
-		struct pwm_device *pwm = &pc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -577,7 +581,7 @@ static int ehrpwm_pwm_resume(struct device *dev)
 		pm_runtime_get_sync(dev);
 	}
 
-	ehrpwm_pwm_restore_context(pc);
+	ehrpwm_pwm_restore_context(chip);
 
 	return 0;
 }
-- 
2.40.1

