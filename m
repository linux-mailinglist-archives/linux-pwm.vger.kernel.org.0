Return-Path: <linux-pwm+bounces-62-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0492F7F2F91
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3532D1C21653
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B77353805;
	Tue, 21 Nov 2023 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4F10C1
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAX-0005uV-H3; Tue, 21 Nov 2023 14:52:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAU-00Ab0Q-8Y; Tue, 21 Nov 2023 14:51:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAT-004xfD-Vr; Tue, 21 Nov 2023 14:51:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 065/108] pwm: lpc18xx-sct: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:07 +0100
Message-ID: <20231121134901.208535-66-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3038; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hL3NRnrGhmDnL+/aA/MCOSU3YGi6QtKn4V05wNIpUcQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWUu1zMME8d1k3/hmHe5MBvSmujfM4Em0mPP 36NHJ5m546JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1lAAKCRCPgPtYfRL+ Tr8ZB/sEPj/Tmc2zTibTucpI8HbHUltu7eho1CiD7c9LgJefPSqjUYesMwGqtdNDSaDjppVO3md Pb1Y7YXKZtp57san2dbaZym/g5gMjxs9bnItH0bd9TfUqtfRlC/Wm8lM6i+TknaELNxlMqcLxpg tV8PRuMjreI5FXZ2+N8IO2u/r3U8HzrcoZ24fNGWWyoLJ520uDzMmO22dv+Nf3bk/j++SVgDG/W Ii9QU/WJtUR1nkGE6iR4as0LniuOv3xKwHQo4AELbiO4sy4ui8E316ClFfY6kRxnI2fDfYq8lft DZ+hBbfxR9ZA3726qqIqPDk3P9ocSvSPVPu8QgFs9bnTgWHQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

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


