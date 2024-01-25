Return-Path: <linux-pwm+bounces-1043-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B5F83C228
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20167B24000
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D083D98E;
	Thu, 25 Jan 2024 12:11:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA90C45020
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184666; cv=none; b=vCPsuOU2y+cnee219LsbhGxJMnKYvVqoDbs6tFLcBQxy+hu7c+Xp3eMgjorTMtcqRKGOgFX+u+M6c5TO8xXuPyutzy2uNi6O8V5n7uGk28pCn5ICT85LFaena6g5j4TQ7XqBY0xH81oZjX5h9A96O/Q2eB8xK3UkKaPHs4KujKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184666; c=relaxed/simple;
	bh=UeKCwn2GW6SYXoYMGVhQOEFQrUIA+9rYY7iFhSXWjuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phGuGOfbMHUAXvlVNue8zL23DOGuw3tAbZ2l/pJsj7GBJX6lyhkAZsPfmnjV/djlSc69d1O8DrTxdbjXOcGHmL0xNC0cGljmHKBsfyWXJqI6WTgxbInqLDLil1Cfugm7PAlUlx5LiQ7b4sHi8j5Z8WI3awRp8FxQ+/e8E+lSl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-0004WW-SI; Thu, 25 Jan 2024 13:10:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-002HUB-JE; Thu, 25 Jan 2024 13:10:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-007n3o-1f;
	Thu, 25 Jan 2024 13:10:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pwm@vger.kernel.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v5 085/111] pwm: samsung: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:47 +0100
Message-ID:  <259526dbf79927759cf0dbd5cea1c9a72e93b492.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6205; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=UeKCwn2GW6SYXoYMGVhQOEFQrUIA+9rYY7iFhSXWjuE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+e5VzO5pcCwTrYHpG8dMQVP716ZZNx2LcP6 Vm+iFOq4DWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPngAKCRCPgPtYfRL+ TiyuB/9YYuayjJurs4fj41Lwo4crThgLymmHi5MjbtZ8gke5dMiTpAnoxz61mTG7TtUBKPU4LFu 8de2uwDyTY4Sp/OasOnsFIbi+cn2j+P6L32VPmtGqRijIAhIEVOki4MRwJTmVDjYvT8H3VQqUYV WuvrHl34z+EJnMjX6yZpkd/1s3x4YfJTnc5rrambSqfhylo3gLQwP9SIm1ko2ppF7AIifbc0KQp 4CQz8+gMottKvblH9g+R0hxi2ch3qPk5zl0rSEbeJhMVNZigLbi140rk0f9cFyNRFgRkGzyU0g9 a+WFyx2APP+h1WwQ379Vg6V3R31irxagB6PyGrs1OQET4yAB
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-samsung driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 46 ++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index a97cae49406e..dec44ba1f90b 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -69,7 +69,6 @@ struct samsung_pwm_channel {
 
 /**
  * struct samsung_pwm_chip - private data of PWM chip
- * @chip:		generic PWM chip
  * @variant:		local copy of hardware variant data
  * @inverter_mask:	inverter status for all channels - one bit per channel
  * @disabled_mask:	disabled status for all channels - one bit per channel
@@ -80,7 +79,6 @@ struct samsung_pwm_channel {
  * @channel:		per channel driver data
  */
 struct samsung_pwm_chip {
-	struct pwm_chip chip;
 	struct samsung_pwm_variant variant;
 	u8 inverter_mask;
 	u8 disabled_mask;
@@ -110,7 +108,7 @@ static DEFINE_SPINLOCK(samsung_pwm_lock);
 static inline
 struct samsung_pwm_chip *to_samsung_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct samsung_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline unsigned int to_tcon_channel(unsigned int channel)
@@ -181,9 +179,10 @@ static unsigned long pwm_samsung_get_tin_rate(struct samsung_pwm_chip *our_chip,
 	return rate / (reg + 1);
 }
 
-static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *our_chip,
+static unsigned long pwm_samsung_calc_tin(struct pwm_chip *chip,
 					  unsigned int chan, unsigned long freq)
 {
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 	struct samsung_pwm_variant *variant = &our_chip->variant;
 	unsigned long rate;
 	struct clk *clk;
@@ -197,12 +196,12 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *our_chip,
 				return rate;
 		}
 
-		dev_warn(pwmchip_parent(&our_chip->chip),
+		dev_warn(pwmchip_parent(chip),
 			"tclk of PWM %d is inoperational, using tdiv\n", chan);
 	}
 
 	rate = pwm_samsung_get_tin_rate(our_chip, chan);
-	dev_dbg(pwmchip_parent(&our_chip->chip), "tin parent at %lu\n", rate);
+	dev_dbg(pwmchip_parent(chip), "tin parent at %lu\n", rate);
 
 	/*
 	 * Compare minimum PWM frequency that can be achieved with possible
@@ -329,7 +328,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		dev_dbg(pwmchip_parent(chip), "duty_ns=%d, period_ns=%d (%u)\n",
 						duty_ns, period_ns, period);
 
-		tin_rate = pwm_samsung_calc_tin(our_chip, pwm->hwpwm, period);
+		tin_rate = pwm_samsung_calc_tin(chip, pwm->hwpwm, period);
 
 		dev_dbg(pwmchip_parent(chip), "tin_rate=%lu\n", tin_rate);
 
@@ -506,9 +505,10 @@ static const struct of_device_id samsung_pwm_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 
-static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
+static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 {
-	struct device_node *np = pwmchip_parent(&our_chip->chip)->of_node;
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
+	struct device_node *np = pwmchip_parent(chip)->of_node;
 	const struct of_device_id *match;
 	struct property *prop;
 	const __be32 *cur;
@@ -522,7 +522,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
-			dev_err(pwmchip_parent(&our_chip->chip),
+			dev_err(pwmchip_parent(chip),
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
 								__func__);
 			continue;
@@ -533,7 +533,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 	return 0;
 }
 #else
-static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
+static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 {
 	return -ENODEV;
 }
@@ -542,21 +542,22 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 static int pwm_samsung_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct samsung_pwm_chip *our_chip;
 	unsigned int chan;
 	int ret;
 
-	our_chip = devm_kzalloc(&pdev->dev, sizeof(*our_chip), GFP_KERNEL);
-	if (our_chip == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, SAMSUNG_PWM_NUM, sizeof(*chip));
+	if (chip == NULL)
 		return -ENOMEM;
+	our_chip = to_samsung_pwm_chip(chip);
+
+	chip->ops = &pwm_samsung_ops;
 
-	our_chip->chip.dev = &pdev->dev;
-	our_chip->chip.ops = &pwm_samsung_ops;
-	our_chip->chip.npwm = SAMSUNG_PWM_NUM;
 	our_chip->inverter_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
-		ret = pwm_samsung_parse_dt(our_chip);
+		ret = pwm_samsung_parse_dt(chip);
 		if (ret)
 			return ret;
 	} else {
@@ -595,7 +596,7 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, our_chip);
 
-	ret = pwmchip_add(&our_chip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(dev, "failed to register PWM chip\n");
 		clk_disable_unprepare(our_chip->base_clk);
@@ -612,17 +613,18 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 static void pwm_samsung_remove(struct platform_device *pdev)
 {
-	struct samsung_pwm_chip *our_chip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 
-	pwmchip_remove(&our_chip->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(our_chip->base_clk);
 }
 
 static int pwm_samsung_resume(struct device *dev)
 {
-	struct samsung_pwm_chip *our_chip = dev_get_drvdata(dev);
-	struct pwm_chip *chip = &our_chip->chip;
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 	unsigned int i;
 
 	for (i = 0; i < SAMSUNG_PWM_NUM; i++) {
-- 
2.43.0


