Return-Path: <linux-pwm+bounces-1454-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39E854616
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F02C1C20756
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9311759F;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B72F1B965
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903291; cv=none; b=E8+4QrMEjFEkd3F+j/NOD34r1oBOu9rZEL+zCHatPXB//VSfT4gX6/xVYEvHLLNy4XQhm59oC/QaKnI8OO0LIe/PxoBEu+PEQy4y5PJTRh2F7+/PxkOlpSj9MfF23zWGiJmRZQ0loHcbtDDBW0wJqH+M8eISBYV/YOiJLpOgVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903291; c=relaxed/simple;
	bh=FmfAEOza9/d2hNbh0tuCn4rmbZNKD9slzf5V5SZ7yKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLUOICSnHqg38PwP7jybkqg8CbsCVcpIvGdHqzEATxzueY/k3b0yNTKS/ABSOkW2k0tSMOXQ0oPAdibKQTec13Dyc5CrQya6j06SRIBDLJ/OfxIUjjti5WK8QoGfUY1OQfnCfu9IC5no/9i+mjsrcKutoALjopC8lHxmBGb/9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfB-0006Id-O9; Wed, 14 Feb 2024 10:34:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-000fIi-7n; Wed, 14 Feb 2024 10:34:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-004YAZ-0V;
	Wed, 14 Feb 2024 10:34:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 159/164] staging: greybus: pwm: Rework how the number of PWM lines is determined
Date: Wed, 14 Feb 2024 10:33:26 +0100
Message-ID:  <3efd84ac03e7dc288f20b0de20b142b6404cb1fa.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2418; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=FmfAEOza9/d2hNbh0tuCn4rmbZNKD9slzf5V5SZ7yKA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIkBYfxnpsZDGPR6CM6yYdFj2e0aARUj9TzsI U2MyZHUuwSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyJAQAKCRCPgPtYfRL+ TpHECAC0Dh8Wq/Sy8uBw18G5fGsgw8ytujJBANc7y7TyUUoEmiGH1Jm4NxKDW/BmVwm7CJc9u86 1kh0MZ/Cu9rTQ21uAuK8NF0lg/8s4IDoAkPWyfV9E4mkJ5hWytnH6c7xhtAIM52ZL8nBiyn1IPv gkAQEvnB0PioQhTkTy4N1E6tHoVIpbts3670tq89g0qG8HqPqRJ83L4Hru5UbFJ5p+vOwlyXwVJ hYfUZk8/2xGdDZJYAct76h1CRqh7pF90DxmCVjWN9uj3frn816P0McfT69XKIbAmPVMQYynQW6F Hb3OeKuPq0okk9kDsbTuEhPQKu5EnMli+6uEnf4k53FUJXjw
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

With a later patch it becomes necessary to already now the number of PWM
lines when pwmc is allocated. So make the function not use pwmc but a
plain connection and return the number of lines instead of storing it in
pwmc. This allows to get rid of the pwm_max member.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/pwm.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index c7a2e874a62b..35e98e7c00c1 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -16,8 +16,6 @@
 
 struct gb_pwm_chip {
 	struct gb_connection	*connection;
-	u8			pwm_max;	/* max pwm number */
-
 	struct pwm_chip		chip;
 };
 
@@ -26,17 +24,21 @@ static inline struct gb_pwm_chip *pwm_chip_to_gb_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct gb_pwm_chip, chip);
 }
 
-static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
+static int gb_pwm_get_npwm(struct gb_connection *connection)
 {
 	struct gb_pwm_count_response response;
 	int ret;
 
-	ret = gb_operation_sync(pwmc->connection, GB_PWM_TYPE_PWM_COUNT,
+	ret = gb_operation_sync(connection, GB_PWM_TYPE_PWM_COUNT,
 				NULL, 0, &response, sizeof(response));
 	if (ret)
 		return ret;
-	pwmc->pwm_max = response.count;
-	return 0;
+
+	/*
+	 * The request returns the highest allowed PWM id parameter. So add one
+	 * to get the number of PWMs.
+	 */
+	return response.count + 1;
 }
 
 static int gb_pwm_activate_operation(struct pwm_chip *chip, u8 which)
@@ -245,7 +247,7 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 	struct gb_connection *connection;
 	struct gb_pwm_chip *pwmc;
 	struct pwm_chip *chip;
-	int ret;
+	int ret, npwm;
 
 	pwmc = kzalloc(sizeof(*pwmc), GFP_KERNEL);
 	if (!pwmc)
@@ -267,15 +269,16 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 		goto exit_connection_destroy;
 
 	/* Query number of pwms present */
-	ret = gb_pwm_count_operation(pwmc);
-	if (ret)
+	ret = gb_pwm_get_npwm(connection);
+	if (ret < 0)
 		goto exit_connection_disable;
+	npwm = ret;
 
 	chip = &pwmc->chip;
 
 	chip->dev = &gbphy_dev->dev;
 	chip->ops = &gb_pwm_ops;
-	chip->npwm = pwmc->pwm_max + 1;
+	chip->npwm = npwm;
 
 	ret = pwmchip_add(chip);
 	if (ret) {
-- 
2.43.0


