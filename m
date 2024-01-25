Return-Path: <linux-pwm+bounces-959-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7A83C1BD
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604D11C225B6
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69093FE2B;
	Thu, 25 Jan 2024 12:10:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC71CA83
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184647; cv=none; b=C3VPThNu4aCn1RnAP5nAbpEFI+V47mF2qqRCBH70p7s5shmR60L/TbjFE59tuo2ifSX8iRJcto0ak5hpcyeejVGK7P6XcrImH4or/MXEd4Wm5Qbn+YKSK4Do/ofxmNabivJYgKv+O2AEQq6QmpBvoYHVN0zftWbHBTqmMq8Ui88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184647; c=relaxed/simple;
	bh=u2r7D2TDN80H4d0qF3yQKlo+3jCu3zkNXxewBJ/GKYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcNP9eVEzN6uFmEcJnQCu5u7tiSqhgm7XfkcYXnAyCOx96bl0bp6lu3XgPbO9yxCZFLVyYfrShP5z/qR/q5S7iTiOCA5hMIXDgJQM0ewWsy9TaM4aW2WOgOCGZiQNh3RS7bmJmStfkKdx/jkAbMIph/s0J/0cOZHcIwIqVfK650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-0003jU-CH; Thu, 25 Jan 2024 13:10:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-002HQ2-W3; Thu, 25 Jan 2024 13:10:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-007mzV-2x;
	Thu, 25 Jan 2024 13:10:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 021/111] pwm: omap: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:43 +0100
Message-ID:  <7d1644fa25ed8e52fa593d2f2d6faa32ba76f14d.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3441; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=u2r7D2TDN80H4d0qF3yQKlo+3jCu3zkNXxewBJ/GKYM=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRN/kFJZypPJYrxbOvwmiO79XXMO8vTNQvmpkprpm086 7D339PCTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmoizC/of/0GXG2nCbg1v8 IwWvWudGRh3W2KtQ+vDZtDobnvV/1m1ifuUn0i2kVcn9P/O01szAsJ2FCQ49fI0frYqlp/MviUr unh977OZyll43DX1Wxg1mHUbmqj1HTz7ZtGPy0gVH3OSkFXRzc7mO7GyvytsS/eDZN51PQTxybw Ks0r+f7P+stK/3Y9WftR6F+6aX8XToxRVEJpdf5zRLn3j7ide05jbd1fePhu7/u3HrLgHv1J1P4 nraFU8kxepaz1xipJVZc3ORTvgRm6+N9mn7Z10zyV7/UMmiL+DfyRMGEpJ6AWUz37bFXEnYE7yg d8U7ThER4wSNI06d0rNWVJQYHzxs9e6KUN31LLWy+KosAA==
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


