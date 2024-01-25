Return-Path: <linux-pwm+bounces-1045-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0707083C21B
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B741F24055
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007663A27E;
	Thu, 25 Jan 2024 12:11:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3483C097
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184666; cv=none; b=lLYICoKewToBikFNZ9Kee6K9YUAcztVS4xhSlSCh7hOmDJ774XA11Hw1KhfkbnFgJxXHloEJbYcYZCeW47hsgxzBjiwMJAXI2Lr6JZvTySdAmyRQL/kM4iD9kLkH9KgJR0OsYh+4GfLMR2mO0ufBZH5LVSAdVhS3rZumCfZnuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184666; c=relaxed/simple;
	bh=ndnj3SAeIJE9BN8JuRaL8lyalmHKP0Y19+AO9kO8vuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYXmLAa0mZRRK2EI0V4H5NqnHs5cuF+xaTXhaKb99tD4wm6Pn5Wk/3kCJS+E4uCJN0ke8YWwojcyoJ5//V7/gEUlMBfxKn1VFdtAl8ZhaK9qbV4N3eGJA/WrrTnEO3M6v2AQw5XglFC8dPvNT4WzYN57vRfrLQw17RLMeczZZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZS-0004fa-7L; Thu, 25 Jan 2024 13:11:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZQ-002HVd-Qq; Thu, 25 Jan 2024 13:11:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZQ-007n5P-2Q;
	Thu, 25 Jan 2024 13:11:00 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Kees Cook <keescook@chromium.org>,
	linux-pwm@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	kernel@pengutronix.de,
	linux-hardening@vger.kernel.org
Subject: [PATCH v5 108/111] pwm: Ensure a struct pwm has the same lifetime as its pwm_chip
Date: Thu, 25 Jan 2024 13:10:10 +0100
Message-ID:  <db65cd276a6fc81722d57a9a215304c2cd9e085c.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3366; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ndnj3SAeIJE9BN8JuRaL8lyalmHKP0Y19+AO9kO8vuk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+4CFrJnmP7FJh3PMl9GSwLT6SKwhsKe6eIK fzj6m6pkVyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPuAAKCRCPgPtYfRL+ ThF1B/9LY6VXpJAu7mHYlwsFpW4mCNyHCCiyWMw9A+Q/hnJ5/fuf80IkpSeYV9axIoBFi8Sv9/C QeQeAvvKp8urMDVcsol/VO+Tnvpvv4LCmHnzSQgdi+OWf9YZ0HdosPX30xgxl2NzS79xUB1ZRF2 +WtUkq4SU6ZG4mA1/W/xLN1Ma9jte0LADuEfHTlFNHr4ANdFPHnyYWWWd47vLKzJgc5K0puLH3E Ai610iFjI3VwiB1Aleqn9V/VGmoK3l2pzh9P3/YWfQlx5roa8f9WHFuZhsOxveMv2Oqtz9Etol5 /Wo0T6dPunm4513zTHaC8k/+rzGVY/mV5gNZGdPTJtBzEbYv
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

It's required to not free the memory underlying a requested PWM
while a consumer still has a reference to it. While currently a pwm_chip
doesn't life long enough in all cases, linking the struct pwm to the
pwm_chip results in the right lifetime as soon as the pwmchip is living
long enough. This happens with the following commits.

Note this is a breaking change for all pwm drivers that don't use
pwmchip_alloc().

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org> # for struct_size() and __counted_by()
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 27 ++++++++++-----------------
 include/linux/pwm.h |  2 +-
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 80acae5fed11..e5024dff56b3 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -456,15 +456,16 @@ EXPORT_SYMBOL_GPL(of_pwm_single_xlate);
 
 static void *pwmchip_priv(struct pwm_chip *chip)
 {
-	return (void *)chip + sizeof(*chip);
+	return (void *)chip + struct_size(chip, pwms, chip->npwm);
 }
 
 struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
 {
 	struct pwm_chip *chip;
 	size_t alloc_size;
+	unsigned int i;
 
-	alloc_size = size_add(sizeof(*chip), sizeof_priv);
+	alloc_size = size_add(struct_size(chip, pwms, npwm), sizeof_priv);
 
 	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
 	if (!chip)
@@ -476,6 +477,13 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 
 	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
 
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		pwm->chip = chip;
+		pwm->hwpwm = i;
+	}
+
 	return chip;
 }
 EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
@@ -523,7 +531,6 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
  */
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
-	unsigned int i;
 	int ret;
 
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
@@ -543,28 +550,16 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
-	if (!chip->pwms)
-		return -ENOMEM;
-
 	mutex_lock(&pwm_lock);
 
 	ret = idr_alloc(&pwm_chips, chip, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		mutex_unlock(&pwm_lock);
-		kfree(chip->pwms);
 		return ret;
 	}
 
 	chip->id = ret;
 
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
-
-		pwm->chip = chip;
-		pwm->hwpwm = i;
-	}
-
 	mutex_unlock(&pwm_lock);
 
 	if (IS_ENABLED(CONFIG_OF))
@@ -594,8 +589,6 @@ void pwmchip_remove(struct pwm_chip *chip)
 	idr_remove(&pwm_chips, chip->id);
 
 	mutex_unlock(&pwm_lock);
-
-	kfree(chip->pwms);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 1620a1eef165..d505400f8573 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -290,7 +290,7 @@ struct pwm_chip {
 	/* only used internally by the PWM framework */
 	bool uses_pwmchip_alloc;
 	void *driver_data;
-	struct pwm_device *pwms;
+	struct pwm_device pwms[] __counted_by(npwm);
 };
 
 static inline struct device *pwmchip_parent(struct pwm_chip *chip)
-- 
2.43.0


