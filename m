Return-Path: <linux-pwm+bounces-1027-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DCB83C229
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCAC5B23C71
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6633D99E;
	Thu, 25 Jan 2024 12:11:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3136B10
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184663; cv=none; b=GUr4fMfRJ/nHsTWrkkUdmgj3X5dGpqI6k9mQ9sLXBCkPOZMAUVbofReuahXWluayBPLgYEC86QLuId0BDtbt2XHkGqGuieofSSKMMfAmSxqj+U0mbaUe3bW4zq7H/W1Lb0Jbzna9YQH4tRk9JIRtv+J35Mb2e0TvBTObMkWh8+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184663; c=relaxed/simple;
	bh=KJEuGC/52+vOnMm9CNKDLGMayPv+GmDgxwikRzww63k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHG9vIV8C+29bAb6sT+VyvgtqrAcrvqSzJRRPnmlZTWG+w/G5TD2q6zRWy8CM2KWJFFDtn5A8eO/hWQgb3i4Fv32ZS7rx1q2EnM6gAMwzTuhqAgMivPcv+h5ZWlJiNyvYM9NM81xeo3FVU9CT3sg0KT5s22T4xk5jRa0gyH5MPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-0004X2-Fs; Thu, 25 Jan 2024 13:10:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-002HUF-Pb; Thu, 25 Jan 2024 13:10:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-007n3s-2J;
	Thu, 25 Jan 2024 13:10:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-pwm@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 086/111] pwm: sifive: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:48 +0100
Message-ID:  <1758e7c75c4a573c01e430c4b13619b5ee11ca11.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3195; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=KJEuGC/52+vOnMm9CNKDLGMayPv+GmDgxwikRzww63k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+fXRBe1dlXQzxd4bAHXKAnQxtLUVnGVrumk 3H6DoKuetCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPnwAKCRCPgPtYfRL+ Tro8CACrgRebmLSi4QmerWXLYIeCpCfjEBL/pkMgGZM5Q0yNcJn8W81vn0uUa4tMK0BD6Czsbjk HgnPcx8kkl0sIJhZC1CdVWQkdjaOIeU1zvSd/BdBJcMraVsqupJQh4Xl5Fsd1MNKlyNVhv0XVmQ NsLKWVuJv8ey5LNOkdsPsO5IxKiZKCJU60i1wb13+0vxBH3XAUxWxmG6RNlf+hQjwh01yE2Wi1E joE31JHn2W53hzluHlc13jJClBQ9uSfhu0ql18L+vwZR+3ef0TGDgsUTPfY+mr/OVKWNpQcC5+v pq+fWS+ubX73ivgYKYIF+WO2DiQKDkETtvsD5JF416U8ORON
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sifive driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index c1b412905d9e..cf3fcffe7b3a 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -41,7 +41,7 @@
 #define PWM_SIFIVE_DEFAULT_PERIOD	10000000
 
 struct pwm_sifive_ddata {
-	struct pwm_chip	chip;
+	struct pwm_chip *chip;
 	struct mutex lock; /* lock to protect user_count and approx_period */
 	struct notifier_block notifier;
 	struct clk *clk;
@@ -54,7 +54,7 @@ struct pwm_sifive_ddata {
 static inline
 struct pwm_sifive_ddata *pwm_sifive_chip_to_ddata(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_sifive_ddata, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int pwm_sifive_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -102,7 +102,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
 	ddata->real_period = div64_ul(num, rate);
-	dev_dbg(pwmchip_parent(&ddata->chip),
+	dev_dbg(pwmchip_parent(ddata->chip),
 		"New real_period = %u ns\n", ddata->real_period);
 }
 
@@ -230,15 +230,14 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	u32 val;
 	unsigned int enabled_pwms = 0, enabled_clks = 1;
 
-	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-	if (!ddata)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ddata = pwm_sifive_chip_to_ddata(chip);
+	ddata->chip = chip;
 
 	mutex_init(&ddata->lock);
-	chip = &ddata->chip;
-	chip->dev = dev;
 	chip->ops = &pwm_sifive_ops;
-	chip->npwm = 4;
 
 	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ddata->regs))
@@ -296,7 +295,7 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 		goto unregister_clk;
 	}
 
-	platform_set_drvdata(pdev, ddata);
+	platform_set_drvdata(pdev, chip);
 	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
 
 	return 0;
@@ -314,15 +313,16 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 
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


