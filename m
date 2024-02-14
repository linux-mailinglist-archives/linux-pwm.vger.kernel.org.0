Return-Path: <linux-pwm+bounces-1314-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CB485457A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1B031F2E0DD
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AA318021;
	Wed, 14 Feb 2024 09:34:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0221401D
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903263; cv=none; b=l+K5HDPhoLCl6Pq+1WQxyJ7NQOgqOXYUmxkPCKb+18r0ULgADDEod5YbSVxy1j4Tu0VVqwWx3QrAzzLMZkAfPoZ4iyJGALB1+mFiE9FyyObPog+ad0i5KIYC+jQt81wDua/noe8eJvrsbT/vuZqUu0X0tPMZnG9fwu6lg3uV1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903263; c=relaxed/simple;
	bh=NzDEL+u7F2a54H4wAxwSi2DYIpmxT7EUioxE8IrVQw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h0EihloNq4uPeqGbjMT7jIDxkcS+qrQ5sUZwP8NYh8TY19ePs+GjzIAGhkQtqK4+jn2sl+DuFWffjSGefaGX5dNLQz8+DD67i3mBleKCCBoRpxDrAV1JIH4E+2oYjMu+PIWwx7GO9rvpNNKCfmMZPn8UIEzWzO1AjXerEv4ol0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-0004OB-R4; Wed, 14 Feb 2024 10:34:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-000f6a-Dm; Wed, 14 Feb 2024 10:34:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-004Xzu-16;
	Wed, 14 Feb 2024 10:34:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 004/164] pwm: ab8500: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:30:51 +0100
Message-ID:  <24028d8d0add621a0c054235e6281a05a83d8fb4.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3167; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NzDEL+u7F2a54H4wAxwSi2DYIpmxT7EUioxE8IrVQw8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhPPzpIm139H3p+lvO+z12wX3JPX8FGiYv6u zGsTIL5MW6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyITwAKCRCPgPtYfRL+ TuptCACaps8AxY3QvTdT0XhErMiDUT4Zl3CZCv6tg4evjO5ktkHg2BiuREnESu94HhKTIjzLjm7 DfNWqSEwkFKcnDZg/aqvUfjsA00agYrZbSDq+Ljg1PNV4e6iqH9Qkxkt5wu62f6R+Cbvo5hXhbO Ns4KfXjctlgyl3WSyf2oqnLMAnDERdOocO0OWGgqOTqZxKVoHXgWNTKdXva1dnXBgj6R/sOmX7U ci20+tUJu1nIehvaHpn1yiiwAljDqHsaNz5yS1uIIoYtpPUEmBPt62gDJ27QBz8B4CmTB4WJuRv 1IkwzFAqlORTraPP9WLR48QLILp3mwzO2mzXZeSTnnaQUcJP
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
 drivers/pwm/pwm-ab8500.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 670d33daea84..719e4ccf1800 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -92,12 +92,12 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * when disabled.
 	 */
 	if (!state->enabled || duty_steps == 0) {
-		ret = abx500_mask_and_set_register_interruptible(chip->dev,
+		ret = abx500_mask_and_set_register_interruptible(pwmchip_parent(chip),
 					AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 					1 << ab8500->hwid, 0);
 
 		if (ret < 0)
-			dev_err(chip->dev, "%s: Failed to disable PWM, Error %d\n",
+			dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM, Error %d\n",
 								pwm->label, ret);
 		return ret;
 	}
@@ -115,22 +115,22 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	reg = AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2);
 
-	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_set_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 			reg, lower_val);
 	if (ret < 0)
 		return ret;
 
-	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_set_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 			(reg + 1), higher_val);
 	if (ret < 0)
 		return ret;
 
 	/* enable */
-	ret = abx500_mask_and_set_register_interruptible(chip->dev,
+	ret = abx500_mask_and_set_register_interruptible(pwmchip_parent(chip),
 				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 				1 << ab8500->hwid, 1 << ab8500->hwid);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM, Error %d\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM, Error %d\n",
 							pwm->label, ret);
 
 	return ret;
@@ -144,7 +144,7 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ab8500_pwm_chip *ab8500 = ab8500_pwm_from_chip(chip);
 	unsigned int div, duty_steps;
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL7_REG,
 						&ctrl7);
 	if (ret)
@@ -157,13 +157,13 @@ static int ab8500_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2),
 						&lower_val);
 	if (ret)
 		return ret;
 
-	ret = abx500_get_register_interruptible(chip->dev, AB8500_MISC,
+	ret = abx500_get_register_interruptible(pwmchip_parent(chip), AB8500_MISC,
 						AB8500_PWM_OUT_CTRL2_REG + (ab8500->hwid * 2),
 						&higher_val);
 	if (ret)
-- 
2.43.0


