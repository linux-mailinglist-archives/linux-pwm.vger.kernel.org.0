Return-Path: <linux-pwm+bounces-1375-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F98545BE
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDDE1C26F89
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C59618C36;
	Wed, 14 Feb 2024 09:34:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E913712E54
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903277; cv=none; b=FPh6SN6Rzr+PsU8l3nZyM2V9Q0HFivUIcs8Msm1kmI6b+SZQpxDLcmYyM+LfBaZprbfvhAbR+HtxFjdE1vPymI2uEaZFZozpqph4RPlpZewmGP4guxTChEuseapA1s0xwndk7RqEzyLpbVcoLCejUatizuJd6tlySr68OcMxkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903277; c=relaxed/simple;
	bh=B9VUhvkgygZAgRAvaM36LwEI86UjigwMLLNV/WXVJrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgC9Z/knOaRnI0cCdx3/qT95xoahoEVkIJLXHpE313IcfprO5c5n0H87a9DOhVLS3MilssftxbA2QHtTMns+D2o62CvQ3eK5XDJQg7vLetCZfu/XzZ0iqPvYWdNTo598yAvjEWvmVfLI122Ir4awulRB45QSMXQJSed+ksn0mMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-00050B-SN; Wed, 14 Feb 2024 10:34:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-000fCm-VT; Wed, 14 Feb 2024 10:34:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-004Y41-2s;
	Wed, 14 Feb 2024 10:34:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 065/164] pwm: lpss: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:52 +0100
Message-ID:  <77617ba84bed7807a05779109432a292dd79f72f.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2486; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=B9VUhvkgygZAgRAvaM36LwEI86UjigwMLLNV/WXVJrA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiVT96w41zq28fkkRsyy9Xn/2pIReLHHsgRG yA5Gdr7OH6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIlQAKCRCPgPtYfRL+ TqagCACMohP9utj1ayki6+kjhViTJfqSnuORn4Ryzihd7sVdeWNcvla79v0o9dJHMMsTARyTYzJ XtaEBR6kqPrYFTwrWivloqCM9op+P6KEIb69K6C6qJgwuy2g8aQSBrfOMGwz0cPlE6MU5jAIwkt ifRH1Gz6KnNZGH1GBqz9hLJHAiTDEuvCdXl3UlxMAH5LOdSWPAPUe/vVJ0m1TOacMmhUC115Rcg jD26/WK1ZYNkGS9OKS2ipH6ZOW4CutChdeHP6TgcgrsK3ENejKy/kj42rwhF7shxoiRe/Bh8PqK yAeWgrAZSnBy7W0xC3cbEDjAigw12TwemHIZdsWPRzqBrgde
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


