Return-Path: <linux-pwm+bounces-1424-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8104C8545F1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DA3D1F2E0E8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C72B1B5BB;
	Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448C19474
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903287; cv=none; b=lqlFepc9e7PrdVhJN6uPinzCwmSmLIIsFbspBX3lqbzBHd5mvdoLFdNUP/RCk1f1FNLr01A/Kwj7czAyqZhQgmbViP8qEDa2SWEnL6XK9yqb0Txky9zPlhHXsPoM23edvZlJ3G1HI79KjFNsztCMJVliF3LYixsT26iOkteZJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903287; c=relaxed/simple;
	bh=14MfV+FXrX/aTvW2MLXTLmHT0CglDRMiyFAOzxxibSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ci9cweROP2etNsbvTviWr/DNn5nhmaekFOhSInSDBNDDIfgpZuxlqHGK4ItuuJe9UpnwpD1RBtdWc1PCxD3RAK5QwF2kgQ0NGOud6iQqHe095pQJa92wZAOndLwG/WO7zYmIbEGS4GpoiLxt4BzBITXyFunS+m7N4udoSAlNH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-0005jX-9X; Wed, 14 Feb 2024 10:34:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-000fFl-Cn; Wed, 14 Feb 2024 10:34:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-004Y7U-11;
	Wed, 14 Feb 2024 10:34:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 114/164] pwm: stm32: Change prototype of a helper to prepare further changes
Date: Wed, 14 Feb 2024 10:32:41 +0100
Message-ID:  <33790c64563cb0434d7156d96f189c6037b3eb0b.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=14MfV+FXrX/aTvW2MLXTLmHT0CglDRMiyFAOzxxibSU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHecu1gXPzzUPOtNe/yIl7YvfP489k+6fn3urYYJ15 ESPbguGTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmUriJ/Z9N2r1LBXrmkyQM XoRdENM9Kjy188Bit1n3zZVObvRhm2/68MHk31tj926Qe9z0b6PvhpbIU1nqhUbKViveypS5sXc nTlLfuEN01hQNzrDl4Qa1TpI86v0Xc7YcaLnxqtZYcYuqzbTPsd7vLU6+kfx5LtW4qeRi2/kGQ6 dAoQg32yrpKdKcBzIfTSlPNOy/PYsvkE+2NE38FqdxTPMR5rO5JrMcFpQp9DtV/5aQf/XzRHxsK e9d67jy3++a37z9kj9zeofR+8eik+asVTTolJzX+ZLN9r5al1jTAUVfva/FhS4nWlLUJIPjmz/Z MFfERWwqeiAhto/hIWO1A9uE0P5nTPxv8v6VeVjyrD0NAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will make it harder to
determine the pwm_chip from a given stm32_pwm. To just not have to do
that, rework stm32_pwm_raw_capture() to take a pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 202114c00ad3..ec15bc51d930 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -90,11 +90,12 @@ static u32 active_channels(struct stm32_pwm *dev)
  * - Period     = t2 - t0
  * - Duty cycle = t1 - t0
  */
-static int stm32_pwm_raw_capture(struct stm32_pwm *priv, struct pwm_device *pwm,
+static int stm32_pwm_raw_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 				 unsigned long tmo_ms, u32 *raw_prd,
 				 u32 *raw_dty)
 {
-	struct device *parent = priv->chip.dev->parent;
+	struct stm32_pwm *priv = to_stm32_pwm_dev(chip);
+	struct device *parent = pwmchip_parent(chip)->parent;
 	enum stm32_timers_dmas dma_id;
 	u32 ccen, ccr;
 	int ret;
@@ -170,7 +171,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = clk_enable(priv->clk);
 	if (ret) {
-		dev_err(chip->dev, "failed to enable counter clock\n");
+		dev_err(pwmchip_parent(chip), "failed to enable counter clock\n");
 		goto unlock;
 	}
 
@@ -208,7 +209,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 			   TIM_CCER_CC12P : TIM_CCER_CC34P, pwm->hwpwm < 2 ?
 			   TIM_CCER_CC2P : TIM_CCER_CC4P);
 
-	ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd, &raw_dty);
+	ret = stm32_pwm_raw_capture(chip, pwm, tmo_ms, &raw_prd, &raw_dty);
 	if (ret)
 		goto stop;
 
@@ -229,7 +230,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 		/* 2nd measure with new scale */
 		psc /= scale;
 		regmap_write(priv->regmap, TIM_PSC, psc);
-		ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd,
+		ret = stm32_pwm_raw_capture(chip, pwm, tmo_ms, &raw_prd,
 					    &raw_dty);
 		if (ret)
 			goto stop;
@@ -257,7 +258,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 			   FIELD_PREP(TIM_CCMR_IC1PSC, icpsc) |
 			   FIELD_PREP(TIM_CCMR_IC2PSC, icpsc));
 
-	ret = stm32_pwm_raw_capture(priv, pwm, tmo_ms, &raw_prd, &raw_dty);
+	ret = stm32_pwm_raw_capture(chip, pwm, tmo_ms, &raw_prd, &raw_dty);
 	if (ret)
 		goto stop;
 
-- 
2.43.0


