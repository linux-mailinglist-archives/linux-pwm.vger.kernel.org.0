Return-Path: <linux-pwm+bounces-9-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E977F2F58
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03877B20FC5
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED253810;
	Tue, 21 Nov 2023 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D78D7E
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:48 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAJ-0004yg-3H; Tue, 21 Nov 2023 14:51:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-00Aaww-LI; Tue, 21 Nov 2023 14:51:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAI-004xb7-C7; Tue, 21 Nov 2023 14:51:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 009/108] pwm: dwc: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:11 +0100
Message-ID: <20231121134901.208535-10-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XgmTTfzI3pPaBpiBliNfjawjKnjYqW4ajGt6ALaiu6A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVXiWDOpvpLbVRquRhPZJqAByZCFAxBa4JJd X9Ry7AsT7CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1VwAKCRCPgPtYfRL+ TstEB/9Ql0g8jKwgnM+Yv7PSWOk4n1L1UomDQRb/WKwR+yAAXZ3pSTgtG6bRZshIXMbSAJCVKtw Blv3f25K/UzIZILBT8km4oKNsQG1zbAGoSyQ+d9PsS2L3Zp/c+OMg0Ts06tnvZLtKHu9fQeu1dO Tlyk8sajyZXY0R9XSnmP+OjCQA8yfuTAXFjpBs3p0fM6YgtSNJQYva3COfx+YYyClrZM12kNUxE f7ivM7hBPccil9bdv86a+AOrVCOCDfJ/k3wH/04gtAVkynmUEYMsHt5azn0lUgqfogvp+CkN3Nh kaMrurZfMhrrGEGTjYe7TFAifFDVIu/m9qiTdIqAyQuOW+qz
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


