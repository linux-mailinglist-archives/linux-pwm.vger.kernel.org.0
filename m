Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10812758472
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjGRSTP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjGRSTM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0874FE6F
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHp-0001sD-KO; Tue, 18 Jul 2023 20:19:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHm-000QnR-Pu; Tue, 18 Jul 2023 20:18:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-005uo7-EU; Tue, 18 Jul 2023 20:18:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 12/18] pwm: lpc18xx-sct: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:43 +0200
Message-Id: <20230718181849.3947851-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3014; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8qFV+ZpzWctEvjucXqQ5Vx3aybR8BN+EvElD9qNTRKo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttb1W2uHkVUcYUKsK69X6PRHYfvRhXCBtXghe ackeXTahMyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW9QAKCRCPgPtYfRL+ TvSzCACr+hnUAF/Cl9nwXZ26xi8IdQtap83m7MvcGAVIohcZY1YogCgCVAhWYFyPg+nZMTJgyPw BLaFZsAanTz4aLoEPw43w3RJuISNfvW7oRm/WZaB1L5cAz01ldnwgOVwHYeIbpSNnCD3tUlr87s fzyUwTUG3nz3uzmYtDa6caNMI7xlA593DU585jUhuf69JrIWbVldNlDFae98X9JsprpT6f0xEKm CNOdlTjoUnU9IghAGRzODZy1+IcubAHaUzqqHcjg8VLpAF1oAngULtZE/qLUBnrE/c+p5xt704N X+Gz67FfZgHPOuK3PBuqZ7nqSex7CRfAchxa9fbPpdm3IUbm
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

This prepares the pwm-lpc18xx-sct driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 0bf0893a5d52..13d4eb9d533f 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -92,7 +92,6 @@ struct lpc18xx_pwm_data {
 
 struct lpc18xx_pwm_chip {
 	struct device *dev;
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *pwm_clk;
 	unsigned long clk_rate;
@@ -109,7 +108,7 @@ struct lpc18xx_pwm_chip {
 static inline struct lpc18xx_pwm_chip *
 to_lpc18xx_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lpc18xx_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline void lpc18xx_pwm_writel(struct lpc18xx_pwm_chip *lpc18xx_pwm,
@@ -351,14 +350,15 @@ MODULE_DEVICE_TABLE(of, lpc18xx_pwm_of_match);
 
 static int lpc18xx_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct lpc18xx_pwm_chip *lpc18xx_pwm;
 	int ret;
 	u64 val;
 
-	lpc18xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*lpc18xx_pwm),
-				   GFP_KERNEL);
-	if (!lpc18xx_pwm)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*lpc18xx_pwm));
+	if (!chip)
 		return -ENOMEM;
+	lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 
 	lpc18xx_pwm->dev = &pdev->dev;
 
@@ -391,9 +391,8 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm->min_period_ns = DIV_ROUND_UP(NSEC_PER_SEC,
 						  lpc18xx_pwm->clk_rate);
 
-	lpc18xx_pwm->chip.dev = &pdev->dev;
-	lpc18xx_pwm->chip.ops = &lpc18xx_pwm_ops;
-	lpc18xx_pwm->chip.npwm = LPC18XX_NUM_PWMS;
+	chip->ops = &lpc18xx_pwm_ops;
+	chip->npwm = LPC18XX_NUM_PWMS;
 
 	/* SCT counter must be in unify (32 bit) mode */
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CONFIG,
@@ -425,21 +424,22 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	val |= LPC18XX_PWM_PRE(0);
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
 
-	ret = pwmchip_add(&lpc18xx_pwm->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add failed\n");
 
-	platform_set_drvdata(pdev, lpc18xx_pwm);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void lpc18xx_pwm_remove(struct platform_device *pdev)
 {
-	struct lpc18xx_pwm_chip *lpc18xx_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 	u32 val;
 
-	pwmchip_remove(&lpc18xx_pwm->chip);
+	pwmchip_remove(chip);
 
 	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL,
-- 
2.39.2

