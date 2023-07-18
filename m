Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2834758467
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjGRSTJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGRSTG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA35135
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:18:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-0001oF-E5; Tue, 18 Jul 2023 20:18:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHk-000Qmd-Io; Tue, 18 Jul 2023 20:18:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHj-005unc-Ta; Tue, 18 Jul 2023 20:18:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 04/18] pwm: berlin: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:35 +0200
Message-Id: <20230718181849.3947851-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TpVO3AgFPO0B3PUzZcDnV2Yl/rrVQbvHG6wqakZnHFc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpRt1157bVY+VD8nSXqFrZXFqvRzanvXvTFWfCt1fFKlr ueyX6KtnYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBMJM6A/X/ipP8+02Y4dfWx lhWdu9aztDy3Y3u556HvPXxzlR0MIk5v+Jg+O/fUvQd+kWVN17305szWLGs/rliedCKsqWDj5IW lARm5u72tbdWWJL57mP57ovQC54/CbbyysWUNC/YelJRdqaTfYJny2lZ+ncPW+M6XG4N69GIr94 TMt8mufsYr3t7UKLDfSr878F/a3ns9IR94Aq/9vHaXy+LYP5PJKleeBB4wjPjGP9kz1cF+j3rU/ JNO+dybniknRjws+GlZwulfOevvrhj/dV9VRbk4hDeEycWyLvrcpTXb78AlX8W5bjfrUuvN+Bl7 ex+H/HtZxXPySla96SlOxwWv3vn13fzT8t9BnHnrHOE6AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-berlin driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-berlin.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 8d685d097c21..5b605f554ac5 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -48,7 +48,6 @@ struct berlin_pwm_channel {
 };
 
 struct berlin_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct berlin_pwm_channel channel[BERLIN_PWM_NUMPWMS];
@@ -56,7 +55,7 @@ struct berlin_pwm_chip {
 
 static inline struct berlin_pwm_chip *to_berlin_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct berlin_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u32 berlin_pwm_readl(struct berlin_pwm_chip *bpc,
@@ -198,12 +197,14 @@ MODULE_DEVICE_TABLE(of, berlin_pwm_match);
 
 static int berlin_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct berlin_pwm_chip *bpc;
 	int ret;
 
-	bpc = devm_kzalloc(&pdev->dev, sizeof(*bpc), GFP_KERNEL);
-	if (!bpc)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*bpc));
+	if (!chip)
 		return -ENOMEM;
+	bpc = to_berlin_pwm_chip(chip);
 
 	bpc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bpc->base))
@@ -213,15 +214,14 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(bpc->clk))
 		return PTR_ERR(bpc->clk);
 
-	bpc->chip.dev = &pdev->dev;
-	bpc->chip.ops = &berlin_pwm_ops;
-	bpc->chip.npwm = BERLIN_PWM_NUMPWMS;
+	chip->ops = &berlin_pwm_ops;
+	chip->npwm = BERLIN_PWM_NUMPWMS;
 
-	ret = devm_pwmchip_add(&pdev->dev, &bpc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-	platform_set_drvdata(pdev, bpc);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
@@ -229,10 +229,11 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int berlin_pwm_suspend(struct device *dev)
 {
-	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	unsigned int i;
 
-	for (i = 0; i < bpc->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
 		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
@@ -248,7 +249,8 @@ static int berlin_pwm_suspend(struct device *dev)
 
 static int berlin_pwm_resume(struct device *dev)
 {
-	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	unsigned int i;
 	int ret;
 
@@ -256,7 +258,7 @@ static int berlin_pwm_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < bpc->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
 		berlin_pwm_writel(bpc, i, channel->ctrl, BERLIN_PWM_CONTROL);
-- 
2.39.2

