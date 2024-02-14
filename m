Return-Path: <linux-pwm+bounces-1476-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5B85469C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3AC1F2347F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2C114A8C;
	Wed, 14 Feb 2024 09:54:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB55C16415
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904444; cv=none; b=NTQK/7OcrYkSm/UVR2eGWk/XwcC1Ef2Vvjx9nNOyvFPdY25I8QEMlaxejCgULXhzvbDuKgR2TkuIoClvsWEtn3GxKqHAihVJfirhkD1DvPyeByISd9Fhil+1ZiEbNXxY3hH4FB8wtGykROkCPOTF8QC3MihFwEq6UNslO5AJbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904444; c=relaxed/simple;
	bh=HgfWuoAldHCxu7T8Elci1C9ZiywoT2q/5Ke/8eGWH3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHYRwX7n8Wu+F/E/tYq/82tGM4FRpXBKqOnnIYPSmsEkq+AWEt4nfskXlNIhVHJN9PAq73Z18I9E5V6bytdhubGBcZOAWqnZLtDTbj66BBarPJIAqRxxtP0yQ97yjHXwtV539lZRDdf+4C2VhK7DP0oqEd5M3eqf0WlVXU7jN6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfA-0006ES-3T; Wed, 14 Feb 2024 10:34:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-000fIN-F3; Wed, 14 Feb 2024 10:34:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-004YAF-1E;
	Wed, 14 Feb 2024 10:34:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>,
	Rob Herring <robh@kernel.org>,
	linux-pwm@vger.kernel.org
Cc: linux-leds@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 154/164] leds: qcom-lpg: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:21 +0100
Message-ID:  <0be073477092eeccaac6c021cf07e38fc30c74fc.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=HgfWuoAldHCxu7T8Elci1C9ZiywoT2q/5Ke/8eGWH3o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIj7tEEiXGTqu4Oii8IT2k+iGFSc63G5RY7iq uO0mbepe4GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI+wAKCRCPgPtYfRL+ TjI4B/9LcTkfeWMCd8yWBUAeKDDOz/rRGS+IY2bbi8MAP6c4QtVxvHi7vHVih0IIJ9/Cl+sgYGI 2kzUCTueGAm0f6BN4is4cJOq8QLcKjai0ZxXPhmddaTVkhQdaqyldO7RSuah8bEG5sVU1R38FeW qHz2rUGXdS6+1gOfTaGcbQO/d0x26Pco2cQ1URDr9KWEejBg9QUI/W9lWwydZfW6RZFzTdWGARf QWaMANNAe3H8Rkfla//BqDWVc714eyNjYZqLrxrxXuRFqkOAt07MwT5rau+oYlm5PQ/8j3jj+RM ruzIZjNnFfjFFF7Ph5wTYZm8I8Sn2Jzqksvr0+WGFi1uzJrW
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


