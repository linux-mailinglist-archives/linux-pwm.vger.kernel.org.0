Return-Path: <linux-pwm+bounces-1031-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 790E583C225
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78452B22E25
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E19446A0;
	Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153B4502A
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184664; cv=none; b=FnwR9+40tc0DJ4xyL8UH1bk3hiQlXtIXWG+KleNF61s2EBCTLJpsWybsBZmvZCe4rOelxk9dq5VZuGH5iC+58Ga2HioLJunBjLkRy/Xw4YCqqt8O564eeROST5nyd5gkYh0NhCC7mHl/WHJuoSh/ezmnh5xbqa0YQFR2oF3GLmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184664; c=relaxed/simple;
	bh=TYiQCSljGWoEGgak5kXyP6CBHH4tPiwJ97FsdVYfhqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3kAciMxENcjhI8EHvCmzrMppyGnEPCmU1ZVqcWXJIDAHTntaFOKGvufjgMdQfND9ApWgh/4QDxGs6NZCcI1ETvn8B7JBHXzxGERLRUF0aaN8ng47RYDDNxeIUlYh6AsnUMWUtAB0bjKQygBqB/c0nCRCj5EkDjIYPJqyw2Sde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-0004YQ-WC; Thu, 25 Jan 2024 13:10:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-002HUX-Ka; Thu, 25 Jan 2024 13:10:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-007n4H-1n;
	Thu, 25 Jan 2024 13:10:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 091/111] pwm: stm32-lp: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:53 +0100
Message-ID:  <4eb36d234035eeff80cbf2b1156bf16df09f52fe.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=TYiQCSljGWoEGgak5kXyP6CBHH4tPiwJ97FsdVYfhqA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+lDRHuHfukkFSiK82TipFM60fLRJr2uJ3ny 7HKMm1kX6WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPpQAKCRCPgPtYfRL+ Tjq8CACo4QSpAmaDkazaEljQNRarkFbeLc9mq2/bcFSVIBFVvvXdYD6rLFERJAjkN2r6xl5yi8t YUtzbQsSlfFAsgsPlWD3tA+PelXtGOvnmekGXXoeMuiUDpAnjUg1G1ABZM+trbIFg29ocBXjglL n3R+GkuauOrQbEafWhkz6rsVE/V1kuw2tK9VhA79F93RhCoe+w/WdMpq25hPqgnW4cWjDT75Cre Jtr7pUhfhHVp9fTF2j7T4EA8aj2pEUr6IYll6aDgpeHWhHylV76ZHTGwN2cPPrRIrV2CJl6ZVox 3LBT9DprPc+lKMMH/dItrUvBpRoZ1gxEBWEFXb5K5dqDSyKA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-stm32-lp driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 3754faeca838..579fea9a0da4 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -18,14 +18,13 @@
 #include <linux/pwm.h>
 
 struct stm32_pwm_lp {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct regmap *regmap;
 };
 
 static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
 {
-	return container_of(chip, struct stm32_pwm_lp, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /* STM32 Low-Power Timer is preceded by a configurable power-of-2 prescaler */
@@ -196,20 +195,20 @@ static const struct pwm_ops stm32_pwm_lp_ops = {
 static int stm32_pwm_lp_probe(struct platform_device *pdev)
 {
 	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct stm32_pwm_lp *priv;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_stm32_pwm_lp(chip);
 
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
-	priv->chip.dev = &pdev->dev;
-	priv->chip.ops = &stm32_pwm_lp_ops;
-	priv->chip.npwm = 1;
+	chip->ops = &stm32_pwm_lp_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return ret;
 
@@ -220,13 +219,13 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 
 static int stm32_pwm_lp_suspend(struct device *dev)
 {
-	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	struct pwm_state state;
 
-	pwm_get_state(&priv->chip.pwms[0], &state);
+	pwm_get_state(&chip->pwms[0], &state);
 	if (state.enabled) {
 		dev_err(dev, "The consumer didn't stop us (%s)\n",
-			priv->chip.pwms[0].label);
+			chip->pwms[0].label);
 		return -EBUSY;
 	}
 
-- 
2.43.0


