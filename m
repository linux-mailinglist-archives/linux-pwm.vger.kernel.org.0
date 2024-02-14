Return-Path: <linux-pwm+bounces-1332-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E785459C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD901B2271F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6539418622;
	Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804DA1802B
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903267; cv=none; b=H00py32JJXcpQk8QD/CRs6LGoS4+HdRndvgknGAGR5phv+pwf7qZ55tRuFqj7GCc4eRQS1mw77FEOSIXEKr6uOJs1Tb3rCLro+xhqRXbJ+bCOnlgKU/MfdZFykECVDctIzhsASonx+uEQguN9tscj8WE93OlU0KQ7Cy3xMFy+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903267; c=relaxed/simple;
	bh=eafBf3ZZ8I/sSXUPjSPuFiBp6HGP0s1PDuvrDMZLxg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdSjTvXWS5UDbKrF9lI2WfSMdeduSZuV8wVjybgPUU6J3u5D/eN1PaMhf4S+Ni6Yy3Y+91g4GfFSDbgXjxi7IbcVa/TIQndXeMhNv4h0P4SY+XvyZW9lPHdwoT28os4Fb9Z7Y0GX8zmxmX/zkULXBn5h980GjwgbDIe9rFBFnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-0004d0-Lc; Wed, 14 Feb 2024 10:34:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-000fAp-5H; Wed, 14 Feb 2024 10:34:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-004Y1r-0H;
	Wed, 14 Feb 2024 10:34:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 034/164] pwm: dwc-core: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:21 +0100
Message-ID:  <5240ba82ac227e3723678041bd69b9c7a9e3db43.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=eafBf3ZZ8I/sSXUPjSPuFiBp6HGP0s1PDuvrDMZLxg4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhxNnQDM3PwFrltuMK0Ycj1upshGz7jPvRCX 8h5xWjUETGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIcQAKCRCPgPtYfRL+ ToQJB/4w1wqZXNdtPI3k7xugkt851OQMo7XkSN8qZ+77sLvs/A6pAk9wCFaPcyCMBVLn8y+jvcd hgGZ7XuX+XQifTR2fjkZRjK/RKBD6LYHFf5hDk4fOqPCOWy9qcQBVicg6DX3Y8InieJm7SoTcOQ A0GSJKDVeUQy7qx7V3SfQ+ao1SNtJlbjk3ne5ksMjTtCiAT9RfEKYepoHX701Ktdan+hvDwL7yS M8WmkFdNNFv99dDZSjnn8O2N5KJK/A8kRAgV2XJj/BEBYwZbpjyd8nqjkYxQ656nULQp8tSy1cT tCWakbtMB09uGVEx/PPiMHfrxlacPwLP4nAIQwLgVs2CAOVj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the accessor
function provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index de1d2ac3316c..043736972cb9 100644
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


