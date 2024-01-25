Return-Path: <linux-pwm+bounces-954-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED85B83C1BB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C21F21777
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583C7374F5;
	Thu, 25 Jan 2024 12:10:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEC3D99E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184647; cv=none; b=JG+K4cqggM0pO/7F4c4AoDAuo8BiDToSOSiUIypyRECTKz9X6QDaRMcy5J0kU0YbFtzGhWpAbcbAYn+nqwbl7VMMcQN19tctWS3CjT5gGSNzoYAc2Kwk7/x6FZ1n55p3SHo73C17B3DT0SHnhpsxB6AQbNpEkAdOSB/BCK3tlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184647; c=relaxed/simple;
	bh=PNPQamBsT4Zn4V3oUXhqfORlkwxK5GpAVyXPuBqnRYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMfALgkRQSN2tyE/Oclu8atQuzGSDXZiiVFxF24CGkzznIJrGmV4JsO++3+0u6BoSH5xuw5YoP/x5fQBOVa/Z0opY9cEc/yIgIzrsl3ynW0voNil1Q8ZulZ0erUWJtQ8mAfhc+XUAPFDYmj5/gH81Vkv7iXYHpIy24Yc78o10BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-0003iN-IN; Thu, 25 Jan 2024 13:10:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-002HPl-4v; Thu, 25 Jan 2024 13:10:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-007mzF-0F;
	Thu, 25 Jan 2024 13:10:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 017/111] pwm: lpss: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:39 +0100
Message-ID:  <8f91c9226935c1dde5f8f1ae51e7b458560ba620.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=PNPQamBsT4Zn4V3oUXhqfORlkwxK5GpAVyXPuBqnRYE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9NrR+fUMqQObDbSzYCUeKCvTuAlYjBMLJ8U i9IAf8M3x6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPTQAKCRCPgPtYfRL+ Th1JCACO7VYHLOPBY9oJw5ygwFKX3hTvz70sxUx8SasmdS18JdUUzkGyVImWJBCgsU/qMolQ/b1 18pKENP61tHG6KG7p3lopmtZG2qu+CaZPNFMxYeMFfNhXQ3yohJ0/M1rgYiHZs+S16sHLjhErqJ crVDt7oJExkLmwTnHCqnq30Ld2ksU0JGRWfa6+1VVVsOyYisqUDwFWUMAwZx329YYFRbsYjr90k AQHh1pQ3f3hTKj2XOF49voHX53K986YX75ldBIxnLzR3kW8HXiDmu+I3ME8HsgBmccyyYp59W41 6U2PAO3rrumGptRJfaLPNchavPWj8FoN81/tsMQ6cEtop00f
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
 drivers/pwm/pwm-lpss.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index a6ea3ce7e019..394c768f5a5f 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -106,7 +106,7 @@ static int pwm_lpss_wait_for_update(struct pwm_device *pwm)
 	 */
 	err = readl_poll_timeout(addr, val, !(val & PWM_SW_UPDATE), 40, ms);
 	if (err)
-		dev_err(pwm->chip->dev, "PWM_SW_UPDATE was not cleared\n");
+		dev_err(pwmchip_parent(pwm->chip), "PWM_SW_UPDATE was not cleared\n");
 
 	return err;
 }
@@ -114,7 +114,7 @@ static int pwm_lpss_wait_for_update(struct pwm_device *pwm)
 static inline int pwm_lpss_is_updating(struct pwm_device *pwm)
 {
 	if (pwm_lpss_read(pwm) & PWM_SW_UPDATE) {
-		dev_err(pwm->chip->dev, "PWM_SW_UPDATE is still set, skipping update\n");
+		dev_err(pwmchip_parent(pwm->chip), "PWM_SW_UPDATE is still set, skipping update\n");
 		return -EBUSY;
 	}
 
@@ -190,16 +190,16 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (state->enabled) {
 		if (!pwm_is_enabled(pwm)) {
-			pm_runtime_get_sync(chip->dev);
+			pm_runtime_get_sync(pwmchip_parent(chip));
 			ret = pwm_lpss_prepare_enable(lpwm, pwm, state);
 			if (ret)
-				pm_runtime_put(chip->dev);
+				pm_runtime_put(pwmchip_parent(chip));
 		} else {
 			ret = pwm_lpss_prepare_enable(lpwm, pwm, state);
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
-		pm_runtime_put(chip->dev);
+		pm_runtime_put(pwmchip_parent(chip));
 	}
 
 	return ret;
@@ -213,7 +213,7 @@ static int pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long base_unit, freq, on_time_div;
 	u32 ctrl;
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	base_unit_range = BIT(lpwm->info->base_unit_bits);
 
@@ -235,7 +235,7 @@ static int pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->polarity = PWM_POLARITY_NORMAL;
 	state->enabled = !!(ctrl & PWM_ENABLE);
 
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pwmchip_parent(chip));
 
 	return 0;
 }
-- 
2.43.0


