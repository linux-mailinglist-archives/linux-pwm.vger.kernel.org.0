Return-Path: <linux-pwm+bounces-307-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A128806E50
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2511C1F21506
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D415134563;
	Wed,  6 Dec 2023 11:48:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DF312B
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:24 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00060Q-FE; Wed, 06 Dec 2023 12:48:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00Dwrn-17; Wed, 06 Dec 2023 12:48:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO5-00FQwx-OI; Wed, 06 Dec 2023 12:48:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 008/115] pwm: ab8500: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:22 +0100
Message-ID:  <d67cf766390d12c86a5e03893c9e7d6dba819551.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3155; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=r5Kmv/tDk34cc+a8oE6K7rQUuOVXGh3943H4Og8rEXo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5b6Yukx8LtCQgM47xU4bn+82VSiXutRKDIA PKM/xSYyvyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeWwAKCRCPgPtYfRL+ TjntCACCFilzLovfztbvQrvHBrkfyweiY0BE6ziN9BTW4TT5RGSYFWXteb8//1SOE7O1ZdDrcPS LYrAL97OMSZavJJyReRsX6p18hnO5Wm9HMQttOvX6AQK3jhZhQ93iI/FfTXeWwlfjh3ndiEtU+J qZ4XdKrmwZsK0L4ZWrnvNT92U8r/eG4dwNUG/Tu4E3II/mbH13ry3/ydhpY7tJmDFo5MbN2q5Sg 2Xf3wp8xjdGsudma+2QjZOjx0adWQgQNTSpWKFZAH1ndi2+BBBJKzJSk3g2x4VN33FYi7cOAILf 38uPao8NrHAlkL4V8+QDwQYz44x1ieACcx/mMpN4a+T3zwTn
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
 drivers/pwm/pwm-ab8500.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 670d33daea84..719e4ccf1800 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -92,12 +92,12 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * when disabled.
 	 */
 	if (!state->enabled || duty_steps == 0) {
-		ret = abx500_mask_and_set_register_interruptible(chip->dev,
+		ret = abx500_mask_and_set_register_interruptible(pwmchip_parent(chip),
 					AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 					1 << ab8500->hwid, 0);
 
 		if (ret < 0)
-			dev_err(chip->dev, "%s: Failed to disable PWM, Error %d\n",
+			dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM, Error %d\n",
 								pwm->label, ret);
 		return ret;
 	}
@@ -115,22 +115,22 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	reg = AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2);
 
-	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_set_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 			reg, lower_val);
 	if (ret < 0)
 		return ret;
 
-	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_set_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 			(reg + 1), higher_val);
 	if (ret < 0)
 		return ret;
 
 	/* enable */
-	ret = abx500_mask_and_set_register_interruptible(chip->dev,
+	ret = abx500_mask_and_set_register_interruptible(pwmchip_parent(chip),
 				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 				1 << ab8500->hwid, 1 << ab8500->hwid);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM, Error %d\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM, Error %d\n",
 							pwm->label, ret);
 
 	return ret;
@@ -144,7 +144,7 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ab8500_pwm_chip *ab8500 = ab8500_pwm_from_chip(chip);
 	unsigned int div, duty_steps;
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL7_REG,
 						&ctrl7);
 	if (ret)
@@ -157,13 +157,13 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2),
 						&lower_val);
 	if (ret)
 		return ret;
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL2_REG + (ab8500->hwid * 2),
 						&higher_val);
 	if (ret)
-- 
2.42.0


