Return-Path: <linux-pwm+bounces-963-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497D483C1C2
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED0C1F22BCE
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E7845022;
	Thu, 25 Jan 2024 12:10:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0F43B19D
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184648; cv=none; b=EeC3BzP7bFbchS8KjW5mIWhlYR/PrjyQKQ1zbFViMoTG4vdISbxBUB73Hzlth4pzFMW0ULhAhbqBhUxNtFF3xZU9Qwyp97gDf81ScI2M389z+kK4ewkU9Ksj+8JoSnTKLW1A15Qp+uYrrrjOD/6tB7r20MZLQb3RxjCydh2soEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184648; c=relaxed/simple;
	bh=jEbW/hpLW1JxlNK+aVYESLEanAndkE4+sbFtTg+ousM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQ2TLpD2qcJsBXmzKml6UM6A43yyf0Lo/bE4oyxu2yxERYZo8sKu8HrGQC5gJn5g3u8o0Efelxnt9kAWKIYXcu/sjRoGGr/66dRdLqbSjsIXRfuljreTCm6I08xyFl6mQFV+6x3O8IEjnzjLI/JnfdkFMOdey0k2JTyg8yKiTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-0003fU-OW; Thu, 25 Jan 2024 13:10:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-002HPQ-8B; Thu, 25 Jan 2024 13:10:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-007myv-0a;
	Thu, 25 Jan 2024 13:10:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 012/111] pwm: fsl-ftm: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:34 +0100
Message-ID:  <90daadd272794b064bab5ffcc1628365965a4d16.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=jEbW/hpLW1JxlNK+aVYESLEanAndkE4+sbFtTg+ousM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9HJW9KvrSwgOhtxxdCPTJSVsW2+ya9DUl4P VNcwL7oPoqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPRwAKCRCPgPtYfRL+ TjLJCACSf0lypQuTQPOxDWREJWTfhOt0xQvwPu6TDxNQ7N9n9NzTEE8dKFKsHy2HCZi218UAcgl zsHDBz261yOsTUrJpAmKp+sRyu7FcTw+KR3Jg64HlCSrWlpDQiKNqYEIx8HqjMrhIsdV1HxLXPE T+qj281bv1bt25JbKTweipGli0J5JlWjTIzFu2L+koYIsd3dkq7Dociy3RUD+qkc7+845SqLR1G 4nyLhMNMjXHsm0kKOoo7rd1nalXiLsMmEP3styc32OJ7I5T+S0TOty4A+5hmSRb3kzUSjRO+csY Ecw6OKMTIbhq562oCeqDIO3zi+CWAUi86EvAFzkis/R7qUPD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index d1b6d1aa4773..47f1f5ac39cf 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -221,10 +221,11 @@ static bool fsl_pwm_is_other_pwm_enabled(struct fsl_pwm_chip *fpc,
 		return false;
 }
 
-static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
+static int fsl_pwm_apply_config(struct pwm_chip *chip,
 				struct pwm_device *pwm,
 				const struct pwm_state *newstate)
 {
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	unsigned int duty;
 	u32 reg_polarity;
 
@@ -232,7 +233,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	bool do_write_period = false;
 
 	if (!fsl_pwm_calculate_period(fpc, newstate->period, &periodcfg)) {
-		dev_err(fpc->chip.dev, "failed to calculate new period\n");
+		dev_err(pwmchip_parent(chip), "failed to calculate new period\n");
 		return -EINVAL;
 	}
 
@@ -246,7 +247,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	 */
 	else if (!fsl_pwm_periodcfg_are_equal(&fpc->period, &periodcfg)) {
 		if (fsl_pwm_is_other_pwm_enabled(fpc, pwm)) {
-			dev_err(fpc->chip.dev,
+			dev_err(pwmchip_parent(chip),
 				"Cannot change period for PWM %u, disable other PWMs first\n",
 				pwm->hwpwm);
 			return -EBUSY;
@@ -322,7 +323,7 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		goto end_mutex;
 	}
 
-	ret = fsl_pwm_apply_config(fpc, pwm, newstate);
+	ret = fsl_pwm_apply_config(chip, pwm, newstate);
 	if (ret)
 		goto end_mutex;
 
-- 
2.43.0


