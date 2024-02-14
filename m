Return-Path: <linux-pwm+bounces-1406-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754FB8545E3
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AD61F2E10F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD95618E28;
	Wed, 14 Feb 2024 09:34:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA51134A3
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903282; cv=none; b=pxyS8GI2Oj4lhUFO9YAfWIsoBmLatRBo+VdPOG3br+dI8Za9tV7vIx3oQf2V3AXwLRqzKuOgZua9jSaEQ+HEdSFmXMo5fCe+lLBAwZnBMtITw2PC+kgZtilrtNofcALUD5CSDNwuFHBYvucBk1NhYI55ht4IvLIwWuYIvW9hvvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903282; c=relaxed/simple;
	bh=7i3UuGU4VhJ8MvjOYeg7N7jtaE9P2g0RopAgsnPVdWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHsnywhKj4NrHdWtOlHr+bsODidK8XRZGs0r+R60cDWkCWwUcuBua/XjmnTS4p0VeXPAhYDtZrYAQBMW6tu9s9yr1M9al4Lirdp6vvSGmzWm407lNmzI01XGowDS3KVdZM4xZcs2Vy8B+X1J88+ukBQQ5PRbcKzl2zNgC1wFoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-0005Ol-6z; Wed, 14 Feb 2024 10:34:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-000fET-4a; Wed, 14 Feb 2024 10:34:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-004Y5y-0E;
	Wed, 14 Feb 2024 10:34:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 093/164] pwm: rz-mtu3: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:32:20 +0100
Message-ID:  <90e6b5d5215425f3a5ff4468ba8aedf3d387f812.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2739; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=7i3UuGU4VhJ8MvjOYeg7N7jtaE9P2g0RopAgsnPVdWM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIi2Dn6BNTlxJrCY3uIp8KOwCvp/3u/s5B3n8 znB8JOPC2GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyItgAKCRCPgPtYfRL+ Ti2CB/9+QmzWXMtjH0/6CN09YLnuBfvCDS2a/lMy4TGZAZKSCdNx0TRA8WnOhMxe4PHROXq6+Sr gyjjZmKOrOXyMC3hjNnzjemzxJZJ28bqHTYsF2e03sRwT+tFml7rn9VSaJLvIf10Hjo5F8IOlmp UcHt26s2QytVoO8eXgsxX5v2Jovpu37llSRGF1pc/cwX5HyKxL/bnJS98k94J7z/zfkDXfwl+0w J5WkO8kBnwXJUXaCQMXFNdqAPgANLaBku2XMkM9qA+FtwvpBbZVFWWkNdz3Tji4DKTp+Py0KdoA l5RHB6tEn0N1SyAv5PEBp97UhxqhirdveFtJpPJGaQoMZhYI
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
 drivers/pwm/pwm-rz-mtu3.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index bdda315b3bd3..acdc45ff90cf 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -219,7 +219,7 @@ static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 	u8 val;
 	int rc;
 
-	rc = pm_runtime_resume_and_get(rz_mtu3_pwm->chip.dev);
+	rc = pm_runtime_resume_and_get(pwmchip_parent(&rz_mtu3_pwm->chip));
 	if (rc)
 		return rc;
 
@@ -265,7 +265,7 @@ static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 
 	mutex_unlock(&rz_mtu3_pwm->lock);
 
-	pm_runtime_put_sync(rz_mtu3_pwm->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(&rz_mtu3_pwm->chip));
 }
 
 static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -465,8 +465,8 @@ static void rz_mtu3_pwm_pm_disable(void *data)
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = data;
 
 	clk_rate_exclusive_put(rz_mtu3_pwm->clk);
-	pm_runtime_disable(rz_mtu3_pwm->chip.dev);
-	pm_runtime_set_suspended(rz_mtu3_pwm->chip.dev);
+	pm_runtime_disable(pwmchip_parent(&rz_mtu3_pwm->chip));
+	pm_runtime_set_suspended(pwmchip_parent(&rz_mtu3_pwm->chip));
 }
 
 static int rz_mtu3_pwm_probe(struct platform_device *pdev)
-- 
2.43.0


