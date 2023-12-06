Return-Path: <linux-pwm+bounces-325-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C18F806E61
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7A5281BC6
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09CF35883;
	Wed,  6 Dec 2023 11:48:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E51AD51
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:27 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-0006KK-Sx; Wed, 06 Dec 2023 12:48:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-00DwtA-E9; Wed, 06 Dec 2023 12:48:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-00FQyJ-5I; Wed, 06 Dec 2023 12:48:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 029/115] pwm: rz-mtu3: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:43 +0100
Message-ID:  <bba8d7647063016eff19712ad67c133a5c0c120e.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=RXUL+Bul1j2UW9auOAT9GLPfTlq3Ul9LsGuF3oz8Iec=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6Ck8tUS4prH/3cZeXbJsBMex4Q1tJiYocNA TtbrQeil3GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeggAKCRCPgPtYfRL+ TpqzB/0YNFw9Fw78u4fQWByvFWxRqFwLuH44jvs+g6P0pQ0kpm8NeRp8hyYJRPYrodVoeSIUoOh rw05pPxeX/39telqckp3ZI2LAB5T0f6psT3f64VVuF1tfrantoGex++F6kS/qMXq8TFdDIFMQgO F8dH1qr2BAzkQjQ4L+NJ1p3udKw7ILqu0HJGLDd+9211237vILgp4+kzl6/do6L1IusjCm9gpoM UnSeiy6Y2cKlRnDEQOS4OngJ+q8K2en1Jw+N3sCsw0TBj3zPrtkwqMyQjYKFbyYuv7JWiefAGL7 vZxJTTbVKE0Q898jf3GX8d1uqJZLISDjS6kvlcO66pAioWi4
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
 drivers/pwm/pwm-rz-mtu3.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index bdda315b3bd3..45d075560a21 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -274,7 +274,7 @@ static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 	int rc;
 
-	rc = pm_runtime_resume_and_get(chip->dev);
+	rc = pm_runtime_resume_and_get(pwmchip_parent(chip));
 	if (rc)
 		return rc;
 
@@ -307,7 +307,7 @@ static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	state->polarity = PWM_POLARITY_NORMAL;
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -362,7 +362,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!pwm->state.enabled) {
 		int rc;
 
-		rc = pm_runtime_resume_and_get(chip->dev);
+		rc = pm_runtime_resume_and_get(pwmchip_parent(chip));
 		if (rc)
 			return rc;
 	}
@@ -399,7 +399,7 @@ static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* If the PWM is not enabled, turn the clock off again to save power. */
 	if (!pwm->state.enabled)
-		pm_runtime_put(chip->dev);
+		pm_runtime_put(pwmchip_parent(chip));
 
 	return 0;
 }
-- 
2.42.0


