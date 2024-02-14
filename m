Return-Path: <linux-pwm+bounces-1351-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBE28545A1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435AC1C268D0
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B464518E2E;
	Wed, 14 Feb 2024 09:34:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87F182BF
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903270; cv=none; b=QTHSQMDr1BHrGMm2VI9j6yTtL+d4oMvDPYxZtACQ2O2sEx+ev0t6+UxMMzSX4K/C+6WuYjrHG1q+qRiKIOux01cslGA6kS1InF9c/CV4li2EUagYo9uCULSPQ1lBdSn++7OWDHS3YmAC13AcOIjiEDOlo4leU7lCdrRkD4JBiR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903270; c=relaxed/simple;
	bh=oMOTYsAddTqamv8bCcMPzRJoOq2skuSbhlD7/KezWlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZvpBkMnnffeIHxGoiGpC13bxPSMHn1+FY3kpRdYok7jMnZw00hZHIiQWZDbu4nBM/sQJ0TWdd03w0thdHhRpEGqZAP+Bp2hO7oSo9IURBw1OuIwQGPD2WLPgfYItrI8Zyup7zd5+Jh4ZMyoEP4YSXWfGkIGSvaxfW/ZWrIao1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-0004gz-3O; Wed, 14 Feb 2024 10:34:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-000fBX-MI; Wed, 14 Feb 2024 10:34:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-004Y2f-1z;
	Wed, 14 Feb 2024 10:34:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 044/164] pwm: img: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:31 +0100
Message-ID:  <bbea7e6e4c5412c6b0773faa9f165b6311cd53b6.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2557; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=oMOTYsAddTqamv8bCcMPzRJoOq2skuSbhlD7/KezWlE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIh83onFyjP59qcvy92qSJ5NHyC0drheQ/YRN n0ch8mfzRKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIfAAKCRCPgPtYfRL+ Tt8MB/9kT8gu6C/Jo1Sh//TKpoZuGA5gBskew+b0At7yCYGQmnoejLjyiBrvyWd2DcQu5mdJ0Ix WQUKNEnSaauqxBLBl4jwUedz68Tifn+cqIRA39z9EPYYozChmCde4UBqcmaBkQxtnCoIqpnuFwV BuxJpsZsj4q4sjeWMRsu7wsPDHMgvdvxEGluQyHbh5CGTc77KPnkTuoMTsfQJVBWRihkhWsWExS vsNuKUi8W2jCxGDzaKyIL96BhkOxw0xb/qeMGEdVFug/U8nKBiJDXPVvgub97tKY8n/kSJ2RKnW e980BkHBjE+js3YFzQApVX8RPARbZnHnyp36nkqX0Jm+4Z5R
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
 drivers/pwm/pwm-img.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 5f423445873d..a4ffe3d71d56 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -98,7 +98,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (period_ns < imgchip->min_period_ns ||
 	    period_ns > imgchip->max_period_ns) {
-		dev_err(chip->dev, "configured period not in range\n");
+		dev_err(pwmchip_parent(chip), "configured period not in range\n");
 		return -ERANGE;
 	}
 
@@ -119,14 +119,14 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		div = PWM_CTRL_CFG_SUB_DIV0_DIV1;
 		timebase = DIV_ROUND_UP(mul, 512);
 	} else {
-		dev_err(chip->dev,
+		dev_err(pwmchip_parent(chip),
 			"failed to configure timebase steps/divider value\n");
 		return -EINVAL;
 	}
 
 	duty = DIV_ROUND_UP(timebase * duty_ns, period_ns);
 
-	ret = pm_runtime_resume_and_get(chip->dev);
+	ret = pm_runtime_resume_and_get(pwmchip_parent(chip));
 	if (ret < 0)
 		return ret;
 
@@ -140,8 +140,8 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	      (timebase << PWM_CH_CFG_TMBASE_SHIFT);
 	img_pwm_writel(imgchip, PWM_CH_CFG(pwm->hwpwm), val);
 
-	pm_runtime_mark_last_busy(chip->dev);
-	pm_runtime_put_autosuspend(chip->dev);
+	pm_runtime_mark_last_busy(pwmchip_parent(chip));
+	pm_runtime_put_autosuspend(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -152,7 +152,7 @@ static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(chip->dev);
+	ret = pm_runtime_resume_and_get(pwmchip_parent(chip));
 	if (ret < 0)
 		return ret;
 
@@ -176,8 +176,8 @@ static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val &= ~BIT(pwm->hwpwm);
 	img_pwm_writel(imgchip, PWM_CTRL_CFG, val);
 
-	pm_runtime_mark_last_busy(chip->dev);
-	pm_runtime_put_autosuspend(chip->dev);
+	pm_runtime_mark_last_busy(pwmchip_parent(chip));
+	pm_runtime_put_autosuspend(pwmchip_parent(chip));
 }
 
 static int img_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.43.0


