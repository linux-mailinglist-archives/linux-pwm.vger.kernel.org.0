Return-Path: <linux-pwm+bounces-1397-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AB18545E7
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71D0CB22C2F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC94182DD;
	Wed, 14 Feb 2024 09:34:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9018AF9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903281; cv=none; b=dvKMuBjmKwq7aIMPWPjKGvm8Ncp2H20m9jJEWzhUSP6UqjwwZMlFMpTM3HnBK4/KQEm2qhlkvYBks916LqYeXdvvVuyjfFaeZGgufZtShAE64FdvCxAs9vhjH/Zf6dUhdgDP4FXhEbYeXs+mrWKb1auZcptRREt2qxgoQwpsyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903281; c=relaxed/simple;
	bh=3owHd3zGdYBwLRD7h/gysAUZCgxfrcC9mg5+isubX0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ml7HmK0T4pk2j4jZa7bZfGzohpeyHOYZAQEkcTuNJ9XfA+2U7ry1210q26fYHzda1SLpqfs1mLSbjhZ/40fPhUWGB6c4ZuCmce2kBvXETcdM4frn1yj2yuIx11GR4FzmsAS7109TkcNUUUhfGQmuIXkULoNuWQ7iHKr0SHMDU3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-0005Gb-1I; Wed, 14 Feb 2024 10:34:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-000fDp-MH; Wed, 14 Feb 2024 10:34:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-004Y5H-1y;
	Wed, 14 Feb 2024 10:34:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 082/164] pwm: pca9685: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:32:09 +0100
Message-ID:  <14b6ec2bdaa7050b9f49a69f35edef731fd84c25.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4002; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3owHd3zGdYBwLRD7h/gysAUZCgxfrcC9mg5+isubX0I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiptqejIC9PywUEwjXbmxDtHo9sX/cO6UP3A eHoD9x9ElGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIqQAKCRCPgPtYfRL+ TobiB/4ms8FRtPwHy9oYsRQMp73NMmEBehChkkioMpfOSYroj7mN3O3bg48n7TCVaTZY+jA+ohO zaXQdbf3LHk3xIKCTfFAtY8bEPSNwN3brM7JtHDu5pJ3hUEEuFpJDq5z3Ngx1tcoxiE0OeSNVqy 607Q5ktQevs32CuTThjVTprDjmUC9aQ3CC0Ue9OsyUrGJ8PvrCwyiPKqTL+GywH7nKTZvxb09f4 HD0mpJwfU31VVogKtbd49ogRnvoGQq9WRWMh0G0C9pCXdD6PW8t2onwwiMQ2Z2A2dEt5qaUxGKI F+Wp7rq/PSlmS3VW4AZGJtDfFiddFMpIXNaO6sWEZkOU29Da
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the accessor
function provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pca9685.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index d7542517fa49..e976a5ca1e7b 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -110,7 +110,7 @@ static bool pca9685_prescaler_can_change(struct pca9685 *pca, int channel)
 static int pca9685_read_reg(struct pwm_chip *chip, unsigned int reg, unsigned int *val)
 {
 	struct pca9685 *pca = to_pca(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	int err;
 
 	err = regmap_read(pca->regmap, reg, val);
@@ -123,7 +123,7 @@ static int pca9685_read_reg(struct pwm_chip *chip, unsigned int reg, unsigned in
 static int pca9685_write_reg(struct pwm_chip *chip, unsigned int reg, unsigned int val)
 {
 	struct pca9685 *pca = to_pca(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	int err;
 
 	err = regmap_write(pca->regmap, reg, val);
@@ -254,7 +254,7 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 
 	if (pca9685_pwm_test_and_set_inuse(pca, offset))
 		return -EBUSY;
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 	return 0;
 }
 
@@ -279,7 +279,7 @@ static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 	struct pca9685 *pca = to_pca(chip);
 
 	pca9685_pwm_set_duty(chip, offset, 0);
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pwmchip_parent(chip));
 	pca9685_pwm_clear_inuse(pca, offset);
 }
 
@@ -313,7 +313,7 @@ static int pca9685_pwm_gpio_direction_output(struct gpio_chip *gpio,
 static int pca9685_pwm_gpio_probe(struct pwm_chip *chip)
 {
 	struct pca9685 *pca = to_pca(chip);
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 
 	pca->gpio.label = dev_name(dev);
 	pca->gpio.parent = dev;
@@ -350,7 +350,7 @@ static inline int pca9685_pwm_gpio_probe(struct pwm_chip *chip)
 
 static void pca9685_set_sleep_mode(struct pwm_chip *chip, bool enable)
 {
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	struct pca9685 *pca = to_pca(chip);
 	int err = regmap_update_bits(pca->regmap, PCA9685_MODE1,
 				     MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
@@ -379,7 +379,7 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	prescale = DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->period,
 					 PCA9685_COUNTER_RANGE * 1000) - 1;
 	if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX) {
-		dev_err(chip->dev, "pwm not changed: period out of bounds!\n");
+		dev_err(pwmchip_parent(chip), "pwm not changed: period out of bounds!\n");
 		return -EINVAL;
 	}
 
@@ -391,7 +391,7 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	pca9685_read_reg(chip, PCA9685_PRESCALE, &val);
 	if (prescale != val) {
 		if (!pca9685_prescaler_can_change(pca, pwm->hwpwm)) {
-			dev_err(chip->dev,
+			dev_err(pwmchip_parent(chip),
 				"pwm not changed: periods of enabled pwms must match!\n");
 			return -EBUSY;
 		}
@@ -487,7 +487,7 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		mutex_unlock(&pca->lock);
 	}
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -501,7 +501,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clear_bit(pwm->hwpwm, pca->pwms_enabled);
 	mutex_unlock(&pca->lock);
 
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pwmchip_parent(chip));
 	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
 }
 
-- 
2.43.0


