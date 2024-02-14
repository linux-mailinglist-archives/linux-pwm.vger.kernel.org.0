Return-Path: <linux-pwm+bounces-1472-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B523385468E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66B921F24D33
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF614A8C;
	Wed, 14 Feb 2024 09:53:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F2914AAE
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904407; cv=none; b=f9iQzm5YDkYupySri7yBdVxLzG0fDcXwoZmFHOVenxyZfDPuwdGgBRetNSSMpnydyRhm9O7O7RcPvWZ7q7JxcoaqmFI8lF9ApL8xSaF8+kpljEtKeM6npbi/cMrNHBSCmBM2otMBv+DUmdnRxIVWU3cjYa5TzduaCta0pqx5HD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904407; c=relaxed/simple;
	bh=6X6XkNbV4OGEY7NUS+8o4/ZsgHyDDHbcmmIWBt/DEfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUtVBapjIbWl8xxtPTQNKYtSwmVGwx0xOZijFXL7cmUgsDeddKeK6Edo8Tu6NqWrWAwW4t5RzEpQ1xHuGclBqzMsfjO4e0Gm8Qs86j1L3accs1Y6WWVbz3Qxy3wfB0qsF3JuxV1h97R4t+oR8ZR479mRL9n+tsPrlpCDuBQlH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfC-0006M8-5t; Wed, 14 Feb 2024 10:34:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-000fJ1-Um; Wed, 14 Feb 2024 10:34:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-004YAt-2q;
	Wed, 14 Feb 2024 10:34:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 164/164] pwm: Make pwmchip_[sg]et_drvdata() a wrapper around dev_set_drvdata()
Date: Wed, 14 Feb 2024 10:33:31 +0100
Message-ID:  <4f313db0d231fba97783926e74ed361586c1f849.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=6X6XkNbV4OGEY7NUS+8o4/ZsgHyDDHbcmmIWBt/DEfc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIkHuMosEY8sSthqj50/gYv0xSDCXS9K6bIgb BzIRbz38EiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyJBwAKCRCPgPtYfRL+ TpKBB/9lcN8A0Q3HwQKGOpOe5+g4BQicQ4+e+TNgtp1FoCKMNt68BBq2DhBqckcAnX7ye7b7WGm Fry2pOPrJ+k0IqdgoF5H0Nd+4kE5T/3K8lIb56VtTYLngxSg6fNJnNeIxCkaJgZl/hsU0WFl/0w Ta1Fv2Kq177/JmpE2spopkjFWOVqJSvNChXK7JSuZFPDbqycpNe4HvKbplpkifhbnbKfAxpDwXh 8FPkne2FOMW47emO+l4MpfO3L/Dz7y+CMTVcBBaOU912tO6gHhvO/zURabkxXK5LHHyaC2Mj5CP 9BPbd1a13gX8jASqB521xJG85GYyIvsE/cdAOI8cv5W+N/69
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Now that a pwm_chip has a dedicated struct device, pwmchip_set_drvdata()
and pwmchip_get_drvdata() can be made thin wrappers around
dev_set_drvdata() and dev_get_drvdata() respectively and the previously
needed pointer can be dropped from struct pwm_chip.

Link: https://lore.kernel.org/r/f95a936ca6bc3c373657a11e242c7161b885b97e.1706182805.git.u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 8c801085462c..699052b38062 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -274,7 +274,6 @@ struct pwm_ops {
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @atomic: can the driver's ->apply() be called in atomic context
  * @uses_pwmchip_alloc: signals if pwmchip_allow was used to allocate this chip
- * @driver_data: Private pointer for driver specific info
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
@@ -290,7 +289,6 @@ struct pwm_chip {
 
 	/* only used internally by the PWM framework */
 	bool uses_pwmchip_alloc;
-	void *driver_data;
 	struct pwm_device pwms[] __counted_by(npwm);
 };
 
@@ -301,20 +299,12 @@ static inline struct device *pwmchip_parent(const struct pwm_chip *chip)
 
 static inline void *pwmchip_get_drvdata(struct pwm_chip *chip)
 {
-	/*
-	 * After pwm_chip got a dedicated struct device, this can be replaced by
-	 * dev_get_drvdata(&chip->dev);
-	 */
-	return chip->driver_data;
+	return dev_get_drvdata(&chip->dev);
 }
 
 static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
 {
-	/*
-	 * After pwm_chip got a dedicated struct device, this can be replaced by
-	 * dev_set_drvdata(&chip->dev, data);
-	 */
-	chip->driver_data = data;
+	dev_set_drvdata(&chip->dev, data);
 }
 
 #if IS_ENABLED(CONFIG_PWM)
-- 
2.43.0


