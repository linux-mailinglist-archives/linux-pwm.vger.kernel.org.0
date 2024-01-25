Return-Path: <linux-pwm+bounces-956-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453B83C1D9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBABEB20F74
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEF73D99E;
	Thu, 25 Jan 2024 12:10:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC943C097
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184647; cv=none; b=pVQbGpVu+CPydR9yMFi4u4B7N2c9vQquiZ24AyKxG+0mVU2dkoZIH5KrsC8lBRFfJG6xREJETJkogyzHGl0rGxWSMWLi/CRpEVl3v+euq0KvsObgyf6ywKWoJXYAzbGWtZ3EyYSqKuaxq0AMzmTWDO0uCOagcg1ZngxEiRghyds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184647; c=relaxed/simple;
	bh=uFBlakhvwzSVbt80uodFKs9a9OzBGt3pAN9wCTEkBqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XStKDUR5goiBbrgB2es3M2O1Ni4B/sMdtjLSIUQcr/ZGVvBFo9/ye/6di6PO9BH38w7V1/9RKPVF8F8nu4mSoGjZ7fLOn0ysphXMtCB+3XP5mvWOy+7hPv/whiQO0bDD5Z8yVkUEsmFk2JsakhxtPERNNUfZpd3YWiEZ9rdu7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-0003g1-Tb; Thu, 25 Jan 2024 13:10:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-002HPU-EO; Thu, 25 Jan 2024 13:10:42 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-007myz-1D;
	Thu, 25 Jan 2024 13:10:42 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 013/111] pwm: img: Make use of parent device pointer in driver data
Date: Thu, 25 Jan 2024 13:08:35 +0100
Message-ID:  <d47e77ac3e7c905f021ad27c3bbbb8054c1045c7.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=uFBlakhvwzSVbt80uodFKs9a9OzBGt3pAN9wCTEkBqs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9I9hRx5ek0VWjZDIU1wsV9g8d+uv75HUvHE JujoaqT2+yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPSAAKCRCPgPtYfRL+ TpGSCACOGZ2GkUD+ap/q6ENDTy/Hw2X/oWTB/pFD8AR2E1uBoni3W/5sxfoEYevi0R7YZikIJAh z7AFm4+ZmidfrZ6SEUWGtAbiEfBmF/APvV0QN4u2+P6GGGsOIXEcIDaibdk5b7ojej8A/FGigLW l+w3jTFnXHYj7A2V6N9Xmo4inFEue0Ab+Mk6OWXMz0RhfE4hwA1WU3EiPGgqEZTOXM4+p74umAo 0KEUCQAD9njjIWwZhWkQv/8TrMc6zIP/mEz2HSVRz3nCorJIiMTo7NUq936gROsxy2mEQN15BdS ssMfvNd9PPEiWcWOwvv9T8dzmcAz50b7DPO1Hrj4U535uEQu
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, make use of the
already existing pointer to the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 5965ac35b32e..2d7477fc391a 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -99,7 +99,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (period_ns < imgchip->min_period_ns ||
 	    period_ns > imgchip->max_period_ns) {
-		dev_err(chip->dev, "configured period not in range\n");
+		dev_err(imgchip->dev, "configured period not in range\n");
 		return -ERANGE;
 	}
 
@@ -120,14 +120,14 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		div = PWM_CTRL_CFG_SUB_DIV0_DIV1;
 		timebase = DIV_ROUND_UP(mul, 512);
 	} else {
-		dev_err(chip->dev,
+		dev_err(imgchip->dev,
 			"failed to configure timebase steps/divider value\n");
 		return -EINVAL;
 	}
 
 	duty = DIV_ROUND_UP(timebase * duty_ns, period_ns);
 
-	ret = pm_runtime_resume_and_get(chip->dev);
+	ret = pm_runtime_resume_and_get(imgchip->dev);
 	if (ret < 0)
 		return ret;
 
@@ -141,8 +141,8 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	      (timebase << PWM_CH_CFG_TMBASE_SHIFT);
 	img_pwm_writel(imgchip, PWM_CH_CFG(pwm->hwpwm), val);
 
-	pm_runtime_mark_last_busy(chip->dev);
-	pm_runtime_put_autosuspend(chip->dev);
+	pm_runtime_mark_last_busy(imgchip->dev);
+	pm_runtime_put_autosuspend(imgchip->dev);
 
 	return 0;
 }
@@ -153,7 +153,7 @@ static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(chip->dev);
+	ret = pm_runtime_resume_and_get(imgchip->dev);
 	if (ret < 0)
 		return ret;
 
@@ -177,8 +177,8 @@ static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val &= ~BIT(pwm->hwpwm);
 	img_pwm_writel(imgchip, PWM_CTRL_CFG, val);
 
-	pm_runtime_mark_last_busy(chip->dev);
-	pm_runtime_put_autosuspend(chip->dev);
+	pm_runtime_mark_last_busy(imgchip->dev);
+	pm_runtime_put_autosuspend(imgchip->dev);
 }
 
 static int img_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.43.0


