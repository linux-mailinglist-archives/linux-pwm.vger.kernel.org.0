Return-Path: <linux-pwm+bounces-309-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3607806E5B
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DCDDB20D90
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4834570;
	Wed,  6 Dec 2023 11:48:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138471BD
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:25 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00063d-EL; Wed, 06 Dec 2023 12:48:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00DwsB-VQ; Wed, 06 Dec 2023 12:48:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00FQxL-Mb; Wed, 06 Dec 2023 12:48:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 014/115] pwm: dwc: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:28 +0100
Message-ID:  <b658a070b99c1da744239c7053ba78295795f5c5.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=XgmTTfzI3pPaBpiBliNfjawjKnjYqW4ajGt6ALaiu6A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5ittWBNCUIZ2IJi7X1ccQNW/N1AEz071Pti mqUJ4k76k6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeYgAKCRCPgPtYfRL+ TuU8B/4tEhNMIyROyGOEAN5ES3tz5NXziIwDLOay5Z5t9xrj0NV8AGI3oCCdiORdRnowy43TxwP lb8hxjWXFNFmQq0v7PQzLl4sZ3OciK2dTRwJ2U0ORqylKhPR6YurppgS7KTYCU3J/MuvJGfR9xc 975k4a2sAZ+P3Vt4TsslXzY+IlnarRohpvIK0os+e2+dWeLWxtzvt4mZEX4kl9Venx8ITWmkSid lIdoBNRhtHp+l1hNF/QjUhPv5YNjckoctnL5IggaxvoXC8Rn8gNbCNHXO7Bhy5jJSL6xs/uDNxW CgUOIwPiulc93i2dUFZzkyyAWoeBk98xwMKAzs55myK/vUmN
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
 drivers/pwm/pwm-dwc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index ea63dd741f5c..146e40ccc4d3 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -105,12 +105,12 @@ static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (state->enabled) {
 		if (!pwm->state.enabled)
-			pm_runtime_get_sync(chip->dev);
+			pm_runtime_get_sync(pwmchip_parent(chip));
 		return __dwc_pwm_configure_timer(dwc, pwm, state);
 	} else {
 		if (pwm->state.enabled) {
 			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
-			pm_runtime_put_sync(chip->dev);
+			pm_runtime_put_sync(pwmchip_parent(chip));
 		}
 	}
 
@@ -124,7 +124,7 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 duty, period;
 	u32 ctrl, ld, ld2;
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
 	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
@@ -149,7 +149,7 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->period = period;
 	state->duty_cycle = duty;
 
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
-- 
2.42.0


