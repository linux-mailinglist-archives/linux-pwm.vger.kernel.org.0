Return-Path: <linux-pwm+bounces-955-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA89883C1C9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C647FB21F7B
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C20937709;
	Thu, 25 Jan 2024 12:10:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80F3EA62
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184647; cv=none; b=fuh5mpzERuBNjBpCE9/rSRl2d9Nh+t1TyMptn4hNAOT0Zh6CreIjKuekA2ssAG2CyJBIcVCFHLNtnb19OWgBVbcyPGhNfPjgz9PWNFUPC4MjAreaQg4OJtMl4YH9diVy6eD+pmMC4YRfdp8UTNMDyZeNQsh0+q3LeJrpNTBk08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184647; c=relaxed/simple;
	bh=toAW/efX1boJm8BkufsQI2RsQDbOMmC1WhC5mdC1O8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjnXgxdq1ydlH7Z+l6VT+kfsjd5MB1i97hKK+RGB7uoCHaW0y6Ab0wjZbRRR08Fq7STN5JMNYIH9qJEQsFKNDdf1Pu2gXYL8l6oZefZvRmT3zms+EOas9wtR3/XQZT6tmCzyFZPpKgW7rbuJSkaD10SYHV23KN4znC3sCFzTtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ8-0003Zp-BR; Thu, 25 Jan 2024 13:10:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ6-002HP1-Rn; Thu, 25 Jan 2024 13:10:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ6-007myO-2W;
	Thu, 25 Jan 2024 13:10:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 005/111] pwm: atmel: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:27 +0100
Message-ID:  <33b1da62f00242be38a5804ef046f2c7f65402c9.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2827; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=toAW/efX1boJm8BkufsQI2RsQDbOMmC1WhC5mdC1O8Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk8/hWYPV9wcyN0d9t8ww6T4FARCszgsYBCgd CrF7YrXrrGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPPwAKCRCPgPtYfRL+ Tmh0CACRtfusaeNOqY7cy6oTyJOATo3TYMTHD5EXWKMMaoGM06TJMW3Kj0fPD36eiIQLj+CMu37 80xpkLPTapUWmzUsEcJeEo2LUzTa78QFB7gEy9zd212aaVOTv9T69Osy50/1tv93PZH4QkewnvQ Q/3xFgqKFIpRtEs5e6Jm9v8iCuiKPS1m1kftHe4QdYz+lGyWMdxafSb7vmb7i/IIykiuw1kGrlY 275IHrB0qllB+FAK4GqgP6ZIrMcFvS/iIDRI0lLcFCJKEf/DdP6czXOQT+bb2hQpWV93SQQjajd 7nGL25GeKWtR7V53jMEwYC5SeqRB/6WddmZyyS6FCCMj3eo5
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
 drivers/pwm/pwm-atmel.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 47bcc8a3bf9d..4ef91fe6f147 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -210,7 +210,7 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 	shift = fls(cycles) - atmel_pwm->data->cfg.period_bits;
 
 	if (shift > PWM_MAX_PRES) {
-		dev_err(chip->dev, "pres exceeds the maximum value\n");
+		dev_err(pwmchip_parent(chip), "pres exceeds the maximum value\n");
 		return -EINVAL;
 	} else if (shift > 0) {
 		*pres = shift;
@@ -321,7 +321,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = atmel_pwm_calculate_cprd_and_pres(chip, clkrate, state, &cprd,
 							&pres);
 		if (ret) {
-			dev_err(chip->dev,
+			dev_err(pwmchip_parent(chip),
 				"failed to calculate cprd and prescaler\n");
 			return ret;
 		}
@@ -333,7 +333,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		} else {
 			ret = clk_enable(atmel_pwm->clk);
 			if (ret) {
-				dev_err(chip->dev, "failed to enable clock\n");
+				dev_err(pwmchip_parent(chip), "failed to enable clock\n");
 				return ret;
 			}
 		}
@@ -462,8 +462,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
-static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
+static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
 {
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned int i, cnt = 0;
 	unsigned long sr;
 	int ret = 0;
@@ -480,7 +481,7 @@ static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
 	for (i = 0; i < cnt; i++) {
 		ret = clk_enable(atmel_pwm->clk);
 		if (ret) {
-			dev_err(atmel_pwm->chip.dev,
+			dev_err(pwmchip_parent(chip),
 				"failed to enable clock for pwm %pe\n",
 				ERR_PTR(ret));
 
@@ -525,7 +526,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 	atmel_pwm->chip.npwm = 4;
 
-	ret = atmel_pwm_enable_clk_if_on(atmel_pwm, true);
+	ret = atmel_pwm_enable_clk_if_on(&atmel_pwm->chip, true);
 	if (ret < 0)
 		return ret;
 
@@ -538,7 +539,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 disable_clk:
-	atmel_pwm_enable_clk_if_on(atmel_pwm, false);
+	atmel_pwm_enable_clk_if_on(&atmel_pwm->chip, false);
 
 	return ret;
 }
-- 
2.43.0


