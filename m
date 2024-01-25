Return-Path: <linux-pwm+bounces-1042-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97C83C218
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5356C1F230A3
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925AF4501E;
	Thu, 25 Jan 2024 12:11:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B1E4501B
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184666; cv=none; b=IHxqNKzb8C7w3wb/JyzvsKcuh1r1eEGAJZrBq+vQ/fnHtEyn4JBOwR57jTxiM412EjzuAm97g+UdLJRyDgESPHoKi9wytDO0PrGaeEKKUVmgxjkjw5vwAwVpAwm+TneOlF+Qgt3BqeJKM5YC7YCQaLjKJYZX+dE6xI52M4d5ziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184666; c=relaxed/simple;
	bh=EyspCkf8TJIJCf2o87sHLyV8Xk//9qAC0hKUF5jihak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jH3yP9bJplQ28dTlk+apRpmDY0icIcMqotLW/v7YCz8Nyt9fZ2KsAJqYoqPnxllfqvJNwPZb8VeWJHDD2cv7qpU2pubt4gT3+QTXy6BlzJAsCZspI9nb8OfqL10TeRiXYxPJ5D6ggHXYT4Lia5gw+4d0J8aCviiNNa343gPcqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZS-0004gz-Gu; Thu, 25 Jan 2024 13:11:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZR-002HVo-FH; Thu, 25 Jan 2024 13:11:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZR-007n5X-1H;
	Thu, 25 Jan 2024 13:11:01 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 110/111] pwm: Make pwmchip_[sg]et_drvdata() a wrapper around dev_set_drvdata()
Date: Thu, 25 Jan 2024 13:10:12 +0100
Message-ID:  <f95a936ca6bc3c373657a11e242c7161b885b97e.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=EyspCkf8TJIJCf2o87sHLyV8Xk//9qAC0hKUF5jihak=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+7YLbIAflt5gQa/f3pY4XcxB68T7F5L/ZoC ksBVcIKN02JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPuwAKCRCPgPtYfRL+ ToF+B/0dx8YGIW4qCniHDPBOz78dBLQz89tpScojBu2UUkH8Xu5ix+PryZxuNVT11622f7hNTG/ pegEZlUiTCLVNglr0I6g09QcZRGrjZbaIRsD3ofTCb1p9o+6Z8AwQX3pbuBT527U/Ksn+QkTfm5 H31SXCA3mOPZdNOrhS8va7XDc6V8s0iubZSMgpwY1CLjLoDmVaI/mC4u83FP9Dbzh8TRnzMcVIn gO/2TRbkHDB9x4hmo67G0pLIQbLeFIUTOS+tPfs7+EfOQRjRQza2dMAz1U+Zrz+ce4lv/Ko82f9 yCp1AQceUTImjUBbhb5LlmjG2FcnmcixUClHpm0kaZe7f5Z0
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c0f3d1139051..7012adf80a2e 100644
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
 
@@ -301,20 +299,12 @@ static inline struct device *pwmchip_parent(struct pwm_chip *chip)
 
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


