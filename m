Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8375846B
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjGRSTL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGRSTH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBC7194
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHm-0001oi-8I; Tue, 18 Jul 2023 20:18:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-000Qmw-Id; Tue, 18 Jul 2023 20:18:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHk-005unn-Ft; Tue, 18 Jul 2023 20:18:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 07/18] pwm: hibvt: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:38 +0200
Message-Id: <20230718181849.3947851-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3009; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hItJI+G9fJrZE0JCUBQz6jkjtLX9JgLekJyOA4240oU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttbvS1kQFkg1OP45awLciWqtgfaZ8JwTbeuDh KU4Nl+YfaqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW7wAKCRCPgPtYfRL+ TpifB/47/nIwivF1qT2nlE+QXynB/QOEFzbiZs51NfWuzQWfH2waJWX/S+j6R9FiouWHq+KZ73E b3zfvxBGAfBCRTWWX1hUfq5BGJLdFqRmO2U6K6jOnlRB1rpB8jZse0ejnGr0QoJqw0wlIXtM0zA jRNe5oiuAcAIu88JVdL7jveotRl4CrEqZbXeS+emZ+30oj3dJedyFRTsoKWIrjIHUf9xRpDTy99 yQntEV45RCHgBldkxteyqFGV9Wm3w+9wWnavekZH1KNgfigUBGpwSUYrvPDJwJY9oL777Yidyoh SBmtY+o8J4xC6d/DHrHOvFHAQTFi73KTISPwO+MOTVLvLdC3
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

This prepares the pwm-hibvt driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-hibvt.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index b95df1a96127..70e2439302b6 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -33,7 +33,6 @@
 #define PWM_DUTY_MASK       GENMASK(31, 0)
 
 struct hibvt_pwm_chip {
-	struct pwm_chip	chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct reset_control *rstc;
@@ -65,7 +64,7 @@ static const struct hibvt_pwm_soc hi3559v100_soc_info = {
 
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct hibvt_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static void hibvt_pwm_set_bits(void __iomem *base, u32 offset,
@@ -192,12 +191,14 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 {
 	const struct hibvt_pwm_soc *soc =
 				of_device_get_match_data(&pdev->dev);
+	struct pwm_chip	*chip;
 	struct hibvt_pwm_chip *pwm_chip;
 	int ret, i;
 
-	pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*pwm_chip), GFP_KERNEL);
-	if (pwm_chip == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*pwm_chip));
+	if (chip == NULL)
 		return -ENOMEM;
+	pwm_chip = to_hibvt_pwm_chip(chip);
 
 	pwm_chip->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pwm_chip->clk)) {
@@ -206,9 +207,8 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pwm_chip->clk);
 	}
 
-	pwm_chip->chip.ops = &hibvt_pwm_ops;
-	pwm_chip->chip.dev = &pdev->dev;
-	pwm_chip->chip.npwm = soc->num_pwms;
+	chip->ops = &hibvt_pwm_ops;
+	chip->npwm = soc->num_pwms;
 	pwm_chip->soc = soc;
 
 	pwm_chip->base = devm_platform_ioremap_resource(pdev, 0);
@@ -229,29 +229,31 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	msleep(30);
 	reset_control_deassert(pwm_chip->rstc);
 
-	ret = pwmchip_add(&pwm_chip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		clk_disable_unprepare(pwm_chip->clk);
 		return ret;
 	}
 
-	for (i = 0; i < pwm_chip->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		hibvt_pwm_set_bits(pwm_chip->base, PWM_CTRL_ADDR(i),
 				PWM_KEEP_MASK, (0x1 << PWM_KEEP_SHIFT));
 	}
 
-	platform_set_drvdata(pdev, pwm_chip);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void hibvt_pwm_remove(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct hibvt_pwm_chip *pwm_chip;
 
-	pwm_chip = platform_get_drvdata(pdev);
+	chip = platform_get_drvdata(pdev);
+	pwm_chip = to_hibvt_pwm_chip(chip);
 
-	pwmchip_remove(&pwm_chip->chip);
+	pwmchip_remove(chip);
 
 	reset_control_assert(pwm_chip->rstc);
 	msleep(30);
-- 
2.39.2

