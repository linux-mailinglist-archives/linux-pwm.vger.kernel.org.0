Return-Path: <linux-pwm+bounces-1461-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E21854620
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A744D1F2E0D9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD5D12E7D;
	Wed, 14 Feb 2024 09:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6ED1B967
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=IcExc88jQfNDP+aosSXsqggqY/xo2E0VFAlKD7vaPj1L0Fq5NAt+0VhY+mkttfHvIlRajv0oubN7V+so5BR4+DOWJJK/GmokTbsgLIZAytyaoUXjADS942sGArLidoGOrLFw6OmRb97HQqjdzVrQQ2PUeEs/8ktV0Q0/rphis/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=1mYNF32HY1YpSr9chVfF9Db7sNhhVqUKJXsocCMVUh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klMzCof4x5yOdug5ebnfwQ/M0LltS8WFyrqaCFBU5mzFMC0BJiTdgfo0v6dCACm6h6/1/4rzNWTg4IQ6ZxmiWxJ8O6R8cw0gXZdhtKu6kG0TlB8MEpwJRXmS7h0hiKiKT5YbRCfMjYlgEHiQ26yNb3oIdcsXDmWHri3bdU2TsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfA-0006G6-DF; Wed, 14 Feb 2024 10:34:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-000fIU-PU; Wed, 14 Feb 2024 10:34:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-004YAN-2H;
	Wed, 14 Feb 2024 10:34:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 156/164] staging: greybus: pwm: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:33:23 +0100
Message-ID:  <7e7517527b825a18ca10cb0faa837577d4f0ec8a.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2807; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1mYNF32HY1YpSr9chVfF9Db7sNhhVqUKJXsocCMVUh0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIj+81T3xJC2kABDMyQeAwDb/u4T2cO/k38mg ENZN8zKOneJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI/gAKCRCPgPtYfRL+ TgXBB/9UJva3OZPzzVm1Bqy+w6RCgO2FiSLAxQusHoH5jOsNx5a0QC5WrRFMeR6VqhWtDWqGSgt HnyLum371BXlMWahbq+uxldxlkw4/RFTtiVPxkapVaB/FPeDvd41pJqLAg2B/2Ty5FeA0uJzQAk FUbdrRzVLZ2FELh7JWSrQyJnRRaaRe7eCPsE7FWQX5q3mvSyDZXkuvEYQb/+sbs+8LKvzm+mgSz FDQaBewPOZDTQnSZ+tW4FzyYSbP8MRHDRjKEvtqd9yhQO2lqqwMf3dQTch2XdZJMrelY/SQr7BU 9Gte1FZnK4/KXOI951y6Os9o0OspYFw5V4UG6rG+a988s3aH
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
 drivers/staging/greybus/pwm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 97b49d436c54..0cd1dab2d888 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -51,7 +51,7 @@ static int gb_pwm_activate_operation(struct pwm_chip *chip, u8 which)
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(chip->dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -76,7 +76,7 @@ static int gb_pwm_deactivate_operation(struct pwm_chip *chip, u8 which)
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(chip->dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -104,7 +104,7 @@ static int gb_pwm_config_operation(struct pwm_chip *chip,
 	request.duty = cpu_to_le32(duty);
 	request.period = cpu_to_le32(period);
 
-	gbphy_dev = to_gbphy_dev(chip->dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -131,7 +131,7 @@ static int gb_pwm_set_polarity_operation(struct pwm_chip *chip,
 	request.which = which;
 	request.polarity = polarity;
 
-	gbphy_dev = to_gbphy_dev(chip->dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -156,7 +156,7 @@ static int gb_pwm_enable_operation(struct pwm_chip *chip, u8 which)
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(chip->dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -184,7 +184,7 @@ static int gb_pwm_disable_operation(struct pwm_chip *chip, u8 which)
 	ret = gb_operation_sync(pwmc->connection, GB_PWM_TYPE_DISABLE,
 				&request, sizeof(request), NULL, 0);
 
-	gbphy_dev = to_gbphy_dev(chip->dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	gbphy_runtime_put_autosuspend(gbphy_dev);
 
 	return ret;
@@ -198,7 +198,7 @@ static int gb_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	if (pwm_is_enabled(pwm))
-		dev_warn(chip->dev, "freeing PWM device without disabling\n");
+		dev_warn(pwmchip_parent(chip), "freeing PWM device without disabling\n");
 
 	gb_pwm_deactivate_operation(chip, pwm->hwpwm);
 }
-- 
2.43.0


