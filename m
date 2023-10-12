Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B357C72E3
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379622AbjJLQbd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379599AbjJLQbL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4ACDD
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaZ-0005Xn-2s; Thu, 12 Oct 2023 18:31:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaW-001C9M-Bu; Thu, 12 Oct 2023 18:31:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaW-00F5QW-2k; Thu, 12 Oct 2023 18:31:04 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 066/109] pwm: lpc18xx-sct: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:34 +0200
Message-ID: <20231012162827.1002444-177-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3038; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hL3NRnrGhmDnL+/aA/MCOSU3YGi6QtKn4V05wNIpUcQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB76u1zMME8d1k3/hmHe5MBvSmujfM4Em0mPP 36NHJ5m546JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge+gAKCRCPgPtYfRL+ TrsSB/sGPaWfNoTtiZRQYKGtvcD9TYtjZRaNOMrrZXZZQJM+amWcWSGXDYfzUPLS/Z21uP9o93Y T9j4+bq0aK4Hjd13iRDopr6FbAzEOCRmj+xfUQBHVgbtFkQbpoYquL54EMr9O8C0ZYFbpKj7nW/ /abzjZAtVq1GLz2+2Ip5/q2qcfo8uSdzUxw/yVj6YawGLJfanfYOyLiW7zMdPTQqKKx894lJKno unsV7YrETR+ARfztbv5nIlPxh6qWdndTCy2HJF6NAHVFd67H3+uhqBA5H/UxG+Lo6fq/CNIuRfZ Xu9gAj2AnJn1c+a7V6H67sK76olyzXBE4K+BLizyWVmF7805
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

This prepares the pwm-lpc18xx-sct driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 1fda3f11b3a6..606fa9cbebab 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -93,7 +93,6 @@ struct lpc18xx_pwm_data {
 
 struct lpc18xx_pwm_chip {
 	struct device *parent;
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *pwm_clk;
 	unsigned long clk_rate;
@@ -110,7 +109,7 @@ struct lpc18xx_pwm_chip {
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
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, LPC18XX_NUM_PWMS, sizeof(*lpc18xx_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 
 	lpc18xx_pwm->parent = &pdev->dev;
 
@@ -391,9 +391,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm->min_period_ns = DIV_ROUND_UP(NSEC_PER_SEC,
 						  lpc18xx_pwm->clk_rate);
 
-	lpc18xx_pwm->chip.dev = &pdev->dev;
-	lpc18xx_pwm->chip.ops = &lpc18xx_pwm_ops;
-	lpc18xx_pwm->chip.npwm = LPC18XX_NUM_PWMS;
+	chip->ops = &lpc18xx_pwm_ops;
 
 	/* SCT counter must be in unify (32 bit) mode */
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CONFIG,
@@ -425,21 +423,22 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
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
2.42.0

