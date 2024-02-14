Return-Path: <linux-pwm+bounces-1378-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753F68545CF
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6BFB22E47
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122D418E17;
	Wed, 14 Feb 2024 09:34:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E60182B5
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903277; cv=none; b=rbYkVjRjY01YF778L8aw0Mrrk595EVJukbq466b1Y3IDojoUSHrOXI3R8+mdHAdhw4Jjrv0GcOVvKwEL/NjEj0yk9+Ch98gL8Z5Hd9SqsaO6pcTNyN6sltD5O5CVuNY9TzPrp1DSKx4on52f9LCXQ+3kbaKtmlUVYXSGjcV2yHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903277; c=relaxed/simple;
	bh=k+ii5YsiBKZxDdtcgcdFT/meI/vY4u65c1EPyHvJ2TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipgErFaWXXS64+7wD4ENL85MvKj1eKow3R8HXaz1VUMbPxOJV34XZR7PHryP+oWG6M1rRcM+DMX8gEC/Ya8Oa7zASXcrnVuzMbJ3ZGuMyQdhh2VsPX0h4okmbt9rFIKXAut9IzVWTJIUjiDO0UKQkndsyAucIMe66dWGmUYRAVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-0005Cs-1I; Wed, 14 Feb 2024 10:34:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-000fDZ-21; Wed, 14 Feb 2024 10:34:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-004Y51-3C;
	Wed, 14 Feb 2024 10:34:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 078/164] pwm: omap-dmtimer: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:32:05 +0100
Message-ID:  <6681ebd024c2b8b2315ca3da5cac612e5f433d63.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3453; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=k+ii5YsiBKZxDdtcgcdFT/meI/vY4u65c1EPyHvJ2TM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIikrN2YH/1Jehi2UDYeo222sVosPtwXd3Xl6 r/6460gPieJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIpAAKCRCPgPtYfRL+ TsLxCACkn/TvrO3bLWS2j4hQpSiOMVuFVokyi7YP36OE1RQqhGqZlWUFpZqDejOOp+G3WGZP6xK 5Ds5+I58ky4IlPyM1eygADwtyAaxbK1sBy5sNNValMySQCDeoi3P1cMTkP3NaRU7Pm60eIxHRBQ O8qPiLWRblCHs5+7W3GZfbVqZmB0GAQCJRd1zBpEbZ8VvPw6doFyucnEv38VO+kYIjZOncMDW58 nK+s+4DUJpGRVLIGPgYWkhjvHdTkcWQLuqIb0PLMs+3bBNRgZDMP6GiXC7VrtXRriZMNA7/FAyx FKDcZnWiHCUVMFhGkEGUzE300F/FLFeNfPt1eHumoBXq29LT
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
 drivers/pwm/pwm-omap-dmtimer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 496bd73d29fe..527a7aa0ce61 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -155,7 +155,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	unsigned long clk_rate;
 	struct clk *fclk;
 
-	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
+	dev_dbg(pwmchip_parent(chip), "requested duty cycle: %d ns, period: %d ns\n",
 		duty_ns, period_ns);
 
 	if (duty_ns == pwm_get_duty_cycle(pwm) &&
@@ -164,17 +164,17 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 
 	fclk = omap->pdata->get_fclk(omap->dm_timer);
 	if (!fclk) {
-		dev_err(chip->dev, "invalid pmtimer fclk\n");
+		dev_err(pwmchip_parent(chip), "invalid pmtimer fclk\n");
 		return -EINVAL;
 	}
 
 	clk_rate = clk_get_rate(fclk);
 	if (!clk_rate) {
-		dev_err(chip->dev, "invalid pmtimer fclk rate\n");
+		dev_err(pwmchip_parent(chip), "invalid pmtimer fclk rate\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(chip->dev, "clk rate: %luHz\n", clk_rate);
+	dev_dbg(pwmchip_parent(chip), "clk rate: %luHz\n", clk_rate);
 
 	/*
 	 * Calculate the appropriate load and match values based on the
@@ -196,27 +196,27 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	duty_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, duty_ns);
 
 	if (period_cycles < 2) {
-		dev_info(chip->dev,
+		dev_info(pwmchip_parent(chip),
 			 "period %d ns too short for clock rate %lu Hz\n",
 			 period_ns, clk_rate);
 		return -EINVAL;
 	}
 
 	if (duty_cycles < 1) {
-		dev_dbg(chip->dev,
+		dev_dbg(pwmchip_parent(chip),
 			"duty cycle %d ns is too short for clock rate %lu Hz\n",
 			duty_ns, clk_rate);
-		dev_dbg(chip->dev, "using minimum of 1 clock cycle\n");
+		dev_dbg(pwmchip_parent(chip), "using minimum of 1 clock cycle\n");
 		duty_cycles = 1;
 	} else if (duty_cycles >= period_cycles) {
-		dev_dbg(chip->dev,
+		dev_dbg(pwmchip_parent(chip),
 			"duty cycle %d ns is too long for period %d ns at clock rate %lu Hz\n",
 			duty_ns, period_ns, clk_rate);
-		dev_dbg(chip->dev, "using maximum of 1 clock cycle less than period\n");
+		dev_dbg(pwmchip_parent(chip), "using maximum of 1 clock cycle less than period\n");
 		duty_cycles = period_cycles - 1;
 	}
 
-	dev_dbg(chip->dev, "effective duty cycle: %lld ns, period: %lld ns\n",
+	dev_dbg(pwmchip_parent(chip), "effective duty cycle: %lld ns, period: %lld ns\n",
 		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * duty_cycles,
 				      clk_rate),
 		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * period_cycles,
@@ -228,7 +228,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	omap->pdata->set_load(omap->dm_timer, load_value);
 	omap->pdata->set_match(omap->dm_timer, true, match_value);
 
-	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
+	dev_dbg(pwmchip_parent(chip), "load value: %#08x (%d), match value: %#08x (%d)\n",
 		load_value, load_value,	match_value, match_value);
 
 	return 0;
-- 
2.43.0


