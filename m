Return-Path: <linux-pwm+bounces-1050-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE19783C224
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B27290F38
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180FF32C91;
	Thu, 25 Jan 2024 12:11:13 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30C133CC9
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184673; cv=none; b=TjRKlGAgogAAkGu7C5Y++BsyMM63krJZb09lkgxZUiWJzcYUkJ0j46a8Hcu1/1uncyYP3kswtiUynCtqBwwVZUfbBnnGsXUcjpFiKt9LWjjWPjX1hiVM3IyujjWP87Td1cGdI+ot4zp9MzGSZBSHr0qd5GJq8ph056JErMs1NqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184673; c=relaxed/simple;
	bh=HgfWuoAldHCxu7T8Elci1C9ZiywoT2q/5Ke/8eGWH3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDV5nMqH6hfplrm1ycH3S3u7qHbIqPkQw7P/7Rvz1aIGGZna8jQ9Afu72Pd7bThsdwk5egLWsRfelgJtOojDAoQ5+oUQQrZ9/wRXJPpmwK3+aIOnhFXGzlE93BscujV3uOoPqDL4y2hXKIsCgyO28TIsyem5GgSJMlj9IfJ2Wx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZR-0004eW-DN; Thu, 25 Jan 2024 13:11:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZQ-002HVS-83; Thu, 25 Jan 2024 13:11:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZQ-007n5D-0V;
	Thu, 25 Jan 2024 13:11:00 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Lu Hongfei <luhongfei@vivo.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Luca Weiss <luca@z3ntu.xyz>,
	linux-pwm@vger.kernel.org
Cc: linux-leds@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v5 105/111] leds: qcom-lpg: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:10:07 +0100
Message-ID:  <514037c1fa6e234b3f5c4b51b6c2db4d0408c203.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=HgfWuoAldHCxu7T8Elci1C9ZiywoT2q/5Ke/8eGWH3o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+1ftR6CgdfVQ9a7qWfbVexQEaPs155dEZK8 l0sBBOYPbiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPtQAKCRCPgPtYfRL+ TlSxCAChFoAstA8UlbdzaHJ7ZD2qqxAbhwdffzuQmlsYVEYDuXTLled9udEzuaMrXBPnx1AIS1H XMlWpTG6WRNXKDc7q16NcvmhNJsSD13SXLK9z65PjXrdI0iQ5Vu8vkiCmzGCnTbWJzgiaf1/N8m yJrcVx/LQUXuvW+tPpYZ0LolnePQo5sSyDdJkVK+7WhZZkcshKgUY8LDSeV5oZghj0LimSxT/Fx 3uA/7d5oOktOc6cDhO2uSg257WPy6DzAXYezU6VjEn69kzB1Ah0e6HXsDVA9yKPWm3gXq5Ne+Bp nrlz7EftvqMzNgskidp7DxpKu3JE2LbW/PbN5FK/dyz+buyz
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm sub-driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 156b73d1f4a2..0a7acf59a420 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -77,7 +77,7 @@ struct lpg {
 
 	struct mutex lock;
 
-	struct pwm_chip pwm;
+	struct pwm_chip *pwm;
 
 	const struct lpg_data *data;
 
@@ -978,7 +978,7 @@ static int lpg_pattern_mc_clear(struct led_classdev *cdev)
 
 static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lpg, pwm);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -1093,13 +1093,17 @@ static const struct pwm_ops lpg_pwm_ops = {
 
 static int lpg_add_pwm(struct lpg *lpg)
 {
+	struct pwm_chip *chip;
 	int ret;
 
-	lpg->pwm.dev = lpg->dev;
-	lpg->pwm.npwm = lpg->num_channels;
-	lpg->pwm.ops = &lpg_pwm_ops;
+	lpg->pwm = chip = devm_pwmchip_alloc(lpg->dev, lpg->num_channels, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	ret = devm_pwmchip_add(lpg->dev, &lpg->pwm);
+	chip->ops = &lpg_pwm_ops;
+	pwmchip_set_drvdata(chip, lpg);
+
+	ret = devm_pwmchip_add(lpg->dev, chip);
 	if (ret)
 		dev_err_probe(lpg->dev, ret, "failed to add PWM chip\n");
 
-- 
2.43.0


