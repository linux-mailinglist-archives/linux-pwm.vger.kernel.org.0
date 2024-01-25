Return-Path: <linux-pwm+bounces-949-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EF383C1B5
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C7741C229BF
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51A933CC9;
	Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590503A1B6
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184646; cv=none; b=RJbaoPzrLK8lXzYYIflEmYeIk9UJcRYEhd0I1HctXUHj+U7vvtuiZkUF68mkOZumSzSCrPrVZCiZBPzQrb5+Bz4z7gBRWlyLa6LDHdUi5xiAEcAdH90ZZ8g+2ldE/jhRQOTDnDM/9bZrco3JGp6sO8P5Pd0CKP1fMvoKULKmpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184646; c=relaxed/simple;
	bh=B6tFWYLRiEPZtKv8CkupCDxV8kpG/0Sz1/e6ajUp0I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGmYvDYG7tZ8SE2dXa7Vo7AtJ7bBKtt+DURJmbsSzPu2eCzMr7NcBFKFH8/8JCRzzlZPjsMuDS7lA/AEHoQ56I4xgkaFWzn8b2iMR+Wf4LkYTr014PKm9cLg4RzNUSwCMQ87Jz2WSSYTBid/+MrL0M2XrAoxVK5ZcRjNpOHEfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-0003dF-8u; Thu, 25 Jan 2024 13:10:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-002HPH-Q1; Thu, 25 Jan 2024 13:10:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ7-007myn-2L;
	Thu, 25 Jan 2024 13:10:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 010/111] pwm: dwc: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:32 +0100
Message-ID:  <2f23646817f48f3c66e381b03e7d3fd4fceaf1e7.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=B6tFWYLRiEPZtKv8CkupCDxV8kpG/0Sz1/e6ajUp0I8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9Fcj6DG+206pBh5ZpJQDHhQ0eiWYeK6nxvk ThvnRyUFByJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPRQAKCRCPgPtYfRL+ TgoXB/41UGuD24hies+x+44msuIvzkGTmhfQTOYaDegArASGPnfpiCDF1QhtH2l0Kdq6o2kfnrK laC2r5DBnid6WwuSk3GBUDVYrdlwYVfQFPyCpTV//TP/5VuLmI7UTcMVWTFQVAyWht7NmMKMnyx cbBukg19mm2P2K8KC+Up2UEyHg+TLIXkfnn21zWrFf2AJuexVxc+7uI6pHQV2YJfO7+0R8EZjG0 7Jsc7tfZZBf/9SWkEa3UUziOH2ErlmaccOZSA2+9Kty8SVCQj3ApfIN2BeZJ6B8pWcvhMwNIECw itV8VgKkXUA+mcLM0idBGALrUjAtUsvc/81/Eww9Mce4Ihcy
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
2.43.0


