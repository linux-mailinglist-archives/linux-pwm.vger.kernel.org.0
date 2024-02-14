Return-Path: <linux-pwm+bounces-1395-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACD78545D5
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0993A1F2DF9F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660A8182A0;
	Wed, 14 Feb 2024 09:34:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA23134A0
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903281; cv=none; b=b04l7xsqV+5tYYknlWhVtu4SMd0tzaxHg+99E2nkTECaGBXCZ9Cf056dP9eKCUUiDivLVDwSrhfWjRxVcODLglIW4lRhNiQ2jGqknNCLGKYIjVUU4QXfruTQ+ZyGY7C2YdpTJSfU9yv2NLseNx+vLtbBjcKyHN/AzEi8a0v24KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903281; c=relaxed/simple;
	bh=cQXa2ZxyI6L4pSJu/p9Pzs8FtX8fWzpfSAwzoyRgqHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F29irm+9XlW4AX/X5/fLorxRiigJGyTRdQ++sqLNiXvK1ngu3ONdFfSzFmi+Misu0WiOgAlqTRan4HKVSHVQJTTrpXDiRmARJpF+yozE+1cYZLcERBcCCcAPbzPg1tYvU9ls3rCQYoib7L5UuiKE831rL8hwRJ8krkNML+EkGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-0005HL-6N; Wed, 14 Feb 2024 10:34:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-000fDs-QU; Wed, 14 Feb 2024 10:34:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-004Y5L-2O;
	Wed, 14 Feb 2024 10:34:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 083/164] pwm: pca9685: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:10 +0100
Message-ID:  <4cb65adc92414a901dd3c0b8412de075196a3c54.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2123; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=cQXa2ZxyI6L4pSJu/p9Pzs8FtX8fWzpfSAwzoyRgqHE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiqBgcXOUYGHlGjCBlRtd3Q2q4UmcExhioV+ hhVaY8y01iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIqgAKCRCPgPtYfRL+ Tpz7CACLA6SPEXIgX3ZawJPOsXmg6sFL3Ce9UwoXiOxbORsBMZND/XnafHnaZ2nVmaq79JZOAdf LQseRJZcIrMWNgZBhzWjIc56L/FF5g2FeJgn+ZUybslLpbNrQVoLdWxzsEVrHxigDRGiAAexPGJ J6hMF3Jk0d3ZNCQ6449QwCju9b3/V92E5mC7oko+jpfP22BIpjMra1BGgwBA0jnHEE/AoU59i82 oqR7UCMKuxTbrZICfKuO5esINRoofMUcDPjMyKoG/0udlilR6c0hnDHIiRXoY5njVsaaeKY4A3y ROqvKWCSmB3HWmLkwNY4F2ci0V0MaNq4QdDIfLOEWzpV+RfM
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-pca9685 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pca9685.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index e976a5ca1e7b..c5da2a6ed846 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -76,7 +76,6 @@
 #define REG_OFF_L(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L : LED_N_OFF_L((C)))
 
 struct pca9685 {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	struct mutex lock;
 	DECLARE_BITMAP(pwms_enabled, PCA9685_MAXCHAN + 1);
@@ -88,7 +87,7 @@ struct pca9685 {
 
 static inline struct pca9685 *to_pca(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pca9685, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /* This function is supposed to be called with the lock mutex held */
@@ -526,9 +525,11 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	unsigned int reg;
 	int ret;
 
-	pca = devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
-	if (!pca)
-		return -ENOMEM;
+	/* Add an extra channel for ALL_LED */
+	chip = devm_pwmchip_alloc(&client->dev, PCA9685_MAXCHAN + 1, sizeof(*pca));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pca = to_pca(chip);
 
 	pca->regmap = devm_regmap_init_i2c(client, &pca9685_regmap_i2c_config);
 	if (IS_ERR(pca->regmap)) {
@@ -537,7 +538,6 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 			ret);
 		return ret;
 	}
-	chip = &pca->chip;
 
 	i2c_set_clientdata(client, chip);
 
@@ -573,10 +573,6 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	pca9685_write_reg(chip, PCA9685_ALL_LED_ON_H, LED_FULL);
 
 	chip->ops = &pca9685_pwm_ops;
-	/* Add an extra channel for ALL_LED */
-	chip->npwm = PCA9685_MAXCHAN + 1;
-
-	chip->dev = &client->dev;
 
 	ret = pwmchip_add(chip);
 	if (ret < 0)
-- 
2.43.0


