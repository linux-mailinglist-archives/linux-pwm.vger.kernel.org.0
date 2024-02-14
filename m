Return-Path: <linux-pwm+bounces-1363-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 085468545B6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 625F8B226C6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B71802B;
	Wed, 14 Feb 2024 09:34:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69AF18E2F
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903273; cv=none; b=B3Kp2eUjNLPtBYjcSZZwpx7UBgk4r4yO/HZ4aJHJhQt+kVin0noBR7I8DYYYCl6hDa87qNMXkus76w2dTW3g3RJSb+z26bJKmeNuOOYRW1iViifbb6mHd/Z1onR8dydzjeuMHRoWFvHuX7SXxrPmdy8OMmn7li0X0rFVNtUfXHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903273; c=relaxed/simple;
	bh=HVe8lwm2b4VVJbbU3hGU3vOoqo4JgQ5Uci4583jBqb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nz4vFF7xouXIlhBGWnQHYxk7rBI/VT4FKJR8LoJpVbMwVo91k+i2GHysIJJ6YSD87Wht2iv0XmUK2vl0Kw8kivAhP6uchkiTdpjVHJSIwyqzLdldKlwlpKBG85tGoOg9sKRqbEcDpM1p63XEhrez6uMjLqKWrAMrDybrUKf0HVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-0004sP-Ny; Wed, 14 Feb 2024 10:34:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-000fCJ-H5; Wed, 14 Feb 2024 10:34:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-004Y3R-1S;
	Wed, 14 Feb 2024 10:34:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>,
	linux-pwm@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 056/164] pwm: jz4740: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:43 +0100
Message-ID:  <86b8a362f1e50c5b95c43e056d03ee5ca66d1641.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=HVe8lwm2b4VVJbbU3hGU3vOoqo4JgQ5Uci4583jBqb4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiKXuhUVTYJApGgnSyjl27q5l3MXUklgez3n JUthKVAmzmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIigAKCRCPgPtYfRL+ TnBrB/9QTx+Q/goGBBR4X/g0rrski19ghMWnxVSaKdsY0t9FHiwX50ge1syvTMHm6W2cHbYXn7x 4UAHmHa0uW+1V6/Pxv/YvmG9MKDdeKS1EWZF0xXKRcjlKbQVNCl5mIDRGUVaCMASZNbdNPaDbcY Tg+lYUzAVMAfU6Wk4JtNmGYVHY0GPq4XhgxtuWj6QIQXnC8AgDNC2Ptjr9YVIY81oipQoMlJ8/G SSw0Msq2p2c+qF5THVy7DqkfnS81c6n2+LVtIJTph5TziBoc72DH9UnBijJN64v1hE6tQ3Lygyt uJ5ynY+TCxiL89s/yIQfMw4Wa8XYCH7X1YJ0bvx6JzqpuwI2
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
 drivers/pwm/pwm-jz4740.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index de9e66065e48..4d39f61b86ff 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -40,7 +40,7 @@ static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned int channel)
 	/* Enable all TCU channels for PWM use by default except channels 0/1 */
 	u32 pwm_channels_mask = GENMASK(chip->npwm - 1, 2);
 
-	device_property_read_u32(chip->dev->parent,
+	device_property_read_u32(pwmchip_parent(chip)->parent,
 				 "ingenic,pwm-channels-mask",
 				 &pwm_channels_mask);
 
@@ -59,9 +59,10 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	snprintf(name, sizeof(name), "timer%u", pwm->hwpwm);
 
-	clk = clk_get(chip->dev, name);
+	clk = clk_get(pwmchip_parent(chip), name);
 	if (IS_ERR(clk)) {
-		dev_err(chip->dev, "error %pe: Failed to get clock\n", clk);
+		dev_err(pwmchip_parent(chip),
+			"error %pe: Failed to get clock\n", clk);
 		return PTR_ERR(clk);
 	}
 
@@ -149,7 +150,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	rate = clk_round_rate(clk, tmp);
 	if (rate < 0) {
-		dev_err(chip->dev, "Unable to round rate: %ld\n", rate);
+		dev_err(pwmchip_parent(chip), "Unable to round rate: %ld\n", rate);
 		return rate;
 	}
 
@@ -170,7 +171,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	err = clk_set_rate(clk, rate);
 	if (err) {
-		dev_err(chip->dev, "Unable to set rate: %d\n", err);
+		dev_err(pwmchip_parent(chip), "Unable to set rate: %d\n", err);
 		return err;
 	}
 
-- 
2.43.0


