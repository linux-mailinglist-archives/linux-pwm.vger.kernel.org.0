Return-Path: <linux-pwm+bounces-1383-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3598545D6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D64D0B22CD6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B399168BC;
	Wed, 14 Feb 2024 09:34:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF7118AE0
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903279; cv=none; b=UDPyWW1o+O1CaQDNu1GU47wF4DC9iU1EywOm6fQ8GutZL9UVqwc+wt/Mi0W2w+XWU19110hKwtg5pfZnky1iJYk9U13UyJSSrDH+7uOjN2mR9pAP+uztzM6RXlXcAWf3LS+Qm269gD75BoaSkglr4K+7r7nAuu7WKFs3oCkGImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903279; c=relaxed/simple;
	bh=YBf4qdXfFKhO1EZiWTtDg4jPeYb5bcjCQweR4HPsB/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PATu4Z4rh+0H0fEz+bshgTiA0s94kO84NDoh7kh/SvtfZydGdofQLGP6qysTlX+dkOKERpzEEasRnAMuOC42U/gJ7FNBH4pRtl6tJ9YDFO0EIvTTK7bjHIzog41jNvbokMwBEQ1BmWo2fxnf8QqkPLf1zehalWMdZrTjZpH+rsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-0005Dc-R1; Wed, 14 Feb 2024 10:34:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-000fDd-6v; Wed, 14 Feb 2024 10:34:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-004Y55-0S;
	Wed, 14 Feb 2024 10:34:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 079/164] pwm: omap-dmtimer: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:32:06 +0100
Message-ID:  <809672026f3d583ba4fc4bd92b525951df172106.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2495; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=YBf4qdXfFKhO1EZiWTtDg4jPeYb5bcjCQweR4HPsB/0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIil1M3tvmgf3V+i3V77ZJlivtw2kXBiK2SZV MeF1jWt36KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIpQAKCRCPgPtYfRL+ TocvCACJlifrBI7nGpthc6T/L46JdCUsdLqiZBiDOhIOWxGS5qcKajuuQqszBf3Bz2Gk+9GhhH7 zGCRK0X0prJ+hGQTZ+aiVpO5co872JQ0C7kzmyDFSzo9PaN239i16GLcZ1nz0fXtMJtm8lE4Et8 TYNt+ujz0S8zZ+aYU0cA1c2mIKBxqwdYfsS7V3PlrJVMstA72b8X2Ct/Ao48bPyNlhvkqTnLpX/ JfQ04fymbrev0tjwNXWpmMZKbN7GUWa7OB1v7UwSy1Zr7ZgD4cKjSdgDK/5tnCvLX6zqFKahgrp SREYEus5D3ObYArjqi7x0FsLCW/DsywcCSVXIRJg4i+G50GY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct pwm_omap_dmtimer_chip. Use the pwm_chip as
driver data instead of the pwm_omap_dmtimer_chip to get access to the
pwm_chip in pwm_omap_dmtimer_remove() without using omap->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 527a7aa0ce61..729d3be2a013 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -311,6 +311,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	struct dmtimer_platform_data *timer_pdata;
 	const struct omap_dm_timer_ops *pdata;
 	struct platform_device *timer_pdev;
+	struct pwm_chip *chip;
 	struct pwm_omap_dmtimer_chip *omap;
 	struct omap_dm_timer *dm_timer;
 	struct device_node *timer;
@@ -373,6 +374,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_alloc_omap;
 	}
+	chip = &omap->chip;
 
 	omap->pdata = pdata;
 	omap->dm_timer = dm_timer;
@@ -392,11 +394,11 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(pdev->dev.of_node, "ti,clock-source", &v))
 		omap->pdata->set_source(omap->dm_timer, v);
 
-	omap->chip.dev = &pdev->dev;
-	omap->chip.ops = &pwm_omap_dmtimer_ops;
-	omap->chip.npwm = 1;
+	chip->dev = &pdev->dev;
+	chip->ops = &pwm_omap_dmtimer_ops;
+	chip->npwm = 1;
 
-	ret = pwmchip_add(&omap->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM\n");
 		goto err_pwmchip_add;
@@ -404,7 +406,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	of_node_put(timer);
 
-	platform_set_drvdata(pdev, omap);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 
@@ -432,9 +434,10 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 static void pwm_omap_dmtimer_remove(struct platform_device *pdev)
 {
-	struct pwm_omap_dmtimer_chip *omap = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 
-	pwmchip_remove(&omap->chip);
+	pwmchip_remove(chip);
 
 	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
 		omap->pdata->stop(omap->dm_timer);
-- 
2.43.0


