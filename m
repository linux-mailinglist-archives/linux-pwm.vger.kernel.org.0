Return-Path: <linux-pwm+bounces-1409-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 041798545E6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA48A1F2E064
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8407A18EB4;
	Wed, 14 Feb 2024 09:34:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42AA18AE0
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903283; cv=none; b=jmJOO/LJ/1WApTicYNpyZW5Kl77y13OXVGdStPsFOaVckqt02NaqhK8j8aWQskKD0WMVYylPp3Ty3VtiHfYo/T+Z+nYSu91NYD/UgVLjoBBxRasVvbF++exrAWZ+OzsGdBz6LQGbZbmNFwtwauZ/zSPpo9LR+wXTXaalACFMH20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903283; c=relaxed/simple;
	bh=TS2SuJjkwNJtPUY3FsLwiCtm+q1TFZUqoQ0gsqhcsk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6vQwL36sDab78KG0SdYDnvh/n7ckckPXSjlE8QQROhB7LCAaKEfnjAoetkJmuPw2zde1wRkrGYjBu7VZtcndYvwjNhv8mAFwA7oVldAhu/OUWEsVq14f+Q+s0Mm9LCtuaUj0PpJrSJBlckRPQiOBN3LX5e7BkVo+I6tA2IEZ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-0005ZL-4w; Wed, 14 Feb 2024 10:34:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-000fF7-NF; Wed, 14 Feb 2024 10:34:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-004Y6n-24;
	Wed, 14 Feb 2024 10:34:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-pwm@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 103/164] pwm: sifive: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:32:30 +0100
Message-ID:  <b7b7985f4dc746f6a36c5048d428c4ed0a2d42dc.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2663; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=TS2SuJjkwNJtPUY3FsLwiCtm+q1TFZUqoQ0gsqhcsk4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjBwJd/Jn3oPTdIFr2TkHHzIyM9JaeylwF63 BUOLSlf5A+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIwQAKCRCPgPtYfRL+ Ts0jB/sGYEEaeYWtPA2Dg9FaCXYJzf8tYUyJ72AJZ7KMt8vahWTJgiVMa5ptB3HmBx3VPW3Nutt rwC7cSQKZ7GF5rklLLW9HULeedGp5OYA/oKZYObVJl3pTXzh/vBqPo5SaQpjhv3WE6fmqhStViu 8X27P8tPQuWik1QhXA53L0zTx8HcPx2T4k+FTpNdJ1CYeRJjDkn7qvPyVY+x3/F2PI+uha/RsUk xZt2tuPbvlv8MxIY+9UG9ARypRty9UUdHbyOy+8o+Ik1OpagZhT63mxF8MtpInke9i+m292jDxL CYCbRUu6MFySs+LwmNpybXT9PLlrFCwm1s0PnGQaUi8mB6Fm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct pwm_sifive_ddata. Use the pwm_chip as driver
data instead of the pwm_sifive_ddata to get access to the pwm_chip in
pwm_sifive_remove() without using ddata->chip. In the clock rate
notifier it's not possible to get the pwm_chip without adding a pointer
to this to struct pwm_sifive_ddata. Instead of that add a parent device
pointer which is all that is needed there.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index cf00f902fc30..ed40a687f909 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -42,6 +42,7 @@
 
 struct pwm_sifive_ddata {
 	struct pwm_chip	chip;
+	struct device *parent;
 	struct mutex lock; /* lock to protect user_count and approx_period */
 	struct notifier_block notifier;
 	struct clk *clk;
@@ -102,7 +103,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
 	ddata->real_period = div64_ul(num, rate);
-	dev_dbg(ddata->chip.dev,
+	dev_dbg(ddata->parent,
 		"New real_period = %u ns\n", ddata->real_period);
 }
 
@@ -236,7 +237,7 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 
 	mutex_init(&ddata->lock);
 	chip = &ddata->chip;
-	chip->dev = dev;
+	chip->dev = ddata->parent = dev;
 	chip->ops = &pwm_sifive_ops;
 	chip->npwm = 4;
 
@@ -296,7 +297,7 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 		goto unregister_clk;
 	}
 
-	platform_set_drvdata(pdev, ddata);
+	platform_set_drvdata(pdev, chip);
 	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
 
 	return 0;
@@ -314,15 +315,16 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 
 static void pwm_sifive_remove(struct platform_device *dev)
 {
-	struct pwm_sifive_ddata *ddata = platform_get_drvdata(dev);
+	struct pwm_chip *chip = platform_get_drvdata(dev);
+	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
 	struct pwm_device *pwm;
 	int ch;
 
-	pwmchip_remove(&ddata->chip);
+	pwmchip_remove(chip);
 	clk_notifier_unregister(ddata->clk, &ddata->notifier);
 
-	for (ch = 0; ch < ddata->chip.npwm; ch++) {
-		pwm = &ddata->chip.pwms[ch];
+	for (ch = 0; ch < chip->npwm; ch++) {
+		pwm = &chip->pwms[ch];
 		if (pwm->state.enabled)
 			clk_disable(ddata->clk);
 	}
-- 
2.43.0


