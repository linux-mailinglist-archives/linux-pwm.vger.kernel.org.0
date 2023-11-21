Return-Path: <linux-pwm+bounces-15-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642C77F2F56
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F594281FC2
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3B2524CD;
	Tue, 21 Nov 2023 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4E10C9
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAJ-00050j-MA; Tue, 21 Nov 2023 14:51:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAJ-00Aax9-8H; Tue, 21 Nov 2023 14:51:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-004xbT-VK; Tue, 21 Nov 2023 14:51:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 012/108] pwm: img: Make use of parent device pointer in driver data
Date: Tue, 21 Nov 2023 14:49:14 +0100
Message-ID: <20231121134901.208535-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0tlSCUu9kEZFvLsbsWj2csLUhLXwnv9amJBeZ26qPuI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVaVtsdIcOCI3AeMWsGXfJHLbv5bMutwDYnm Hr2xHf85j2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1WgAKCRCPgPtYfRL+ TjRSCACo7wFlsn5Uso0OZdmQJcY6LcYayctkI1XBk8pL5MvArpfrQw5bzE5czB5lx+B/enk/W3Q WwY7CZ3cj5WwDbNk4EqfK8gE8L5FfL/iueoTmUhm+7TBz4yGKiP2iXsiUfGQZdXYFJXKtJeibqr k0b3oYLklgDvzr7Kx/+8IN38VolHZHS4B6mrjZmAKaeNwrvjEoYCa8w93Y8YtSe+g4I3mdJ9kwR IMkS8bJwqJujqxjrXks3iZiHJwDABc+oT6OUTq7ljUbtBsueopMlH139KxSv2xDcPxbm+aL31th 5wCcrjYF0Yhau3QZGOKNU6uMzYuK1jm4MuHubzJTetZ+v+Yi
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
index 0d218c0b690e..d5d50645530f 100644
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
2.42.0


