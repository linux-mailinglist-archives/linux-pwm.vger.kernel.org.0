Return-Path: <linux-pwm+bounces-1785-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1223387DCFD
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 11:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C304728104F
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0480B18EB0;
	Sun, 17 Mar 2024 10:40:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BED1798A
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710672058; cv=none; b=SbLqTJs9cYlA0c4MzbNZCNioS8t26FLuiDe5TIcdnL1lrKVviVNeMPqpDpV0pz9P/6z9nGQ0Ubssniw/iHmxcP5iBAMjbPVLYGH2RrrQtI1y2nbEEJ7tSoeZD96TqkJSZvTXmIfS+HbRPRHMhaeAiUCWyptEP5DwbSa9Le34jRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710672058; c=relaxed/simple;
	bh=AG4jwZ/6gQYisCrxpsL8cWXEFovxSI4ZrMHP/oYXx0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1Y6NLykz9cGioQaTsZGZ+0dn57a4rBCA0uu7gEMpkblbZLaXrdP9dXMaQZ0trMZZ3H2DKsuyqVVP/8iWH11sKOpgaT7xIND/hAYD3It5mcRCXiq/L6iQeIip0eQDHTldivaQhgH36tgPWvd1J6EUhRmwlYmNItxyxlmDWIHZhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-0002C0-W5; Sun, 17 Mar 2024 11:40:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-006rg2-JJ; Sun, 17 Mar 2024 11:40:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwe-007aDJ-1g;
	Sun, 17 Mar 2024 11:40:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH 6/8] pwm: Make pwmchip_[sg]et_drvdata() a wrapper around dev_set_drvdata()
Date: Sun, 17 Mar 2024 11:40:37 +0100
Message-ID:  <a5e05bd2d83421a26fdef6a87d69253c0f98becf.1710670958.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=AG4jwZ/6gQYisCrxpsL8cWXEFovxSI4ZrMHP/oYXx0A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl9sinoTzcjgUWbtVuaHO3lUS+n+GX4AducX4ih ArnnSBt0wqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfbIpwAKCRCPgPtYfRL+ TrJ7B/9b9+z8CxI0WS+EXdc8cJFZ2IJ7LjVij/hkFU/X8UEjLE4qPSsCiJE6be0XVuUWUaN1MZO 4QsymlmZaucMoeu/hav6R1+FtuKv1RN3O8q8oTsc5GWbCW8LSgZOu0Mr5Ip88ADSWoHqC7Edolu DOtQWDoPyF5C+t0v3GXFkjB9ie7aNZBglBL6tfrt6Mt0Kwc4IL3/XrNuSMSPATspIrAm3PK6wR/ 4FgWYCLH1zd+5WDKO0j1NYFCpAppA/V5TY+X1RKN+Iyf576ADo4jCD7l0vG8n1oUJhFTbgfOrnR hf7iYW5b+OgQ9DZPlXX6i/FLlYpc16osZPs1NNsH0deKIsKq
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
index 495e23761f34..60b92c2c75ef 100644
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


