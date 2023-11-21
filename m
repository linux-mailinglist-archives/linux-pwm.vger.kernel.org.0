Return-Path: <linux-pwm+bounces-16-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B57F2F57
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70081C216F5
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C365381E;
	Tue, 21 Nov 2023 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF3810DC
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-0005JI-6q; Tue, 21 Nov 2023 14:51:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-00Aaxr-O9; Tue, 21 Nov 2023 14:51:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-004xcF-F9; Tue, 21 Nov 2023 14:51:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 024/108] pwm: rz-mtu3: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:26 +0100
Message-ID: <20231121134901.208535-25-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RXUL+Bul1j2UW9auOAT9GLPfTlq3Ul9LsGuF3oz8Iec=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVnDFiRAfaUzSpbn1O5zVXCcbk9UK/awexG7 hzl25yYy3eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1ZwAKCRCPgPtYfRL+ TlS4B/oDPV+/b5mobTEJ0vGGym8Fi9+GuBK2/0KVv1m2BNuvRmXMU2cmhyQENM3pd/Dq//RRmK9 HzeRMOzdCOXsZ6nnH+Cx1ths7xH5PS5y4V69CnjMDX63mXPnr1Qp4c5sONo825rpIg+bpod4JCV HASWQ3hrrkTL/ygSLSLGJ/QsmDWXuzfzALKQKBWqhHcCDIYtZYjQauLBLzdVXp3aTRu8+UPzdVw P8+2q2i4kLvPp84+bNn1k6JtDP8zJCBJlBcZz+NrfoXg0duf8WpGxDU5J19mZGWNQI1kAXCsZVt k8xmxJPwUKDCAvXRgUNOJ5uT5Mik4mUYXTKD3P79CwvmE4cp
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


