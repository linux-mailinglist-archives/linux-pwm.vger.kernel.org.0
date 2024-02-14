Return-Path: <linux-pwm+bounces-1384-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE188545C6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF48C289D95
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35366171A3;
	Wed, 14 Feb 2024 09:34:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947118C3B
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903280; cv=none; b=fWozT5gjCX4DRPpJyOiljKIURP2S5w5PIjjdlBVLZXn+M2thF7DNfzQ12zeT001ocnUPXPUUpCnB0y7XDjcemdYZHxXZ2VFMGgVWRrp0G05tALuZ1XM7JQNvCWUnWbda9V1pgrgfKgsAEpKBn4Fl/AeOVNtighUrzHLjEU97FDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903280; c=relaxed/simple;
	bh=mBUKByv9X+vTByfPoG96X3bjuPCfaGkZJLWY9+HxndA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+Vbcg9KBARqV7mr2QR/C2t2rKmwh4tQAKmKjLw7q77hDWi8H0JIyPcdxqLsZ1EVBqMGLkyhCfOyG41Akc83jeySPk5LuIsLChNfkxJW0yPt+g36r1nfuxRWr75Y1TXx8uB+qI1SiwbrHz1hszbNaVu/s5ReiZAmHw4xXK3z0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-0005EM-Kh; Wed, 14 Feb 2024 10:34:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-000fDg-Bc; Wed, 14 Feb 2024 10:34:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-004Y59-0v;
	Wed, 14 Feb 2024 10:34:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 080/164] pwm: omap-dmtimer: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:07 +0100
Message-ID:  <78d1448b0fd1136b010f629feffb9d89c853e472.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=mBUKByv9X+vTByfPoG96X3bjuPCfaGkZJLWY9+HxndA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIimMnVnyItkfpwMynond6qilyXz0GmLqyxkP 6b73RGWaW2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIpgAKCRCPgPtYfRL+ ToyoB/9V/voI8IPHSaWYUf8EzpBLWyxtbrhx52ht73En4wjUsVIZ2cy1sZfKkyas2S6BXd/XAxm I07sZH1ocLYsqbHQ/PRngcz5XoyG0NKtSoSriBygrMqnCMfCsSEixr9F+2rO9bg23Ure26efu+W u3Nd9WXRhyyewmQ1IQM576zJxr2UqpXb2OYuyMLygb39xvmjittw2MrU8TcVilUky+XEp2m+2U8 UYzFlgZLqWHbIETMMukxwEjFs+rrFCSoz9d1JeTRVfympO/YCmfCTAitsjtCb1f4AOGs9J+JppB +6c/x3mtSmwoZFxQYhgfYrJ10YVPra1Vzz92X4ruaJPU7CC/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-omap-dmtimer driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 729d3be2a013..cd51c4a938f5 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -53,13 +53,11 @@
 /**
  * struct pwm_omap_dmtimer_chip - Structure representing a pwm chip
  *				  corresponding to omap dmtimer.
- * @chip:		PWM chip structure representing PWM controller
  * @dm_timer:		Pointer to omap dm timer.
  * @pdata:		Pointer to omap dm timer ops.
  * @dm_timer_pdev:	Pointer to omap dm timer platform device
  */
 struct pwm_omap_dmtimer_chip {
-	struct pwm_chip chip;
 	/* Mutex to protect pwm apply state */
 	struct omap_dm_timer *dm_timer;
 	const struct omap_dm_timer_ops *pdata;
@@ -69,7 +67,7 @@ struct pwm_omap_dmtimer_chip {
 static inline struct pwm_omap_dmtimer_chip *
 to_pwm_omap_dmtimer_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_omap_dmtimer_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /**
@@ -369,12 +367,12 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 		goto err_request_timer;
 	}
 
-	omap = devm_kzalloc(&pdev->dev, sizeof(*omap), GFP_KERNEL);
-	if (!omap) {
-		ret = -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*omap));
+	if (IS_ERR(chip)) {
+		ret = PTR_ERR(chip);
 		goto err_alloc_omap;
 	}
-	chip = &omap->chip;
+	omap = to_pwm_omap_dmtimer_chip(chip);
 
 	omap->pdata = pdata;
 	omap->dm_timer = dm_timer;
@@ -394,9 +392,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	if (!of_property_read_u32(pdev->dev.of_node, "ti,clock-source", &v))
 		omap->pdata->set_source(omap->dm_timer, v);
 
-	chip->dev = &pdev->dev;
 	chip->ops = &pwm_omap_dmtimer_ops;
-	chip->npwm = 1;
 
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
-- 
2.43.0


