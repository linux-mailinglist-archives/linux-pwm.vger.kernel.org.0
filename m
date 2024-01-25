Return-Path: <linux-pwm+bounces-982-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EB183C1D1
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C881C22CCD
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2FA45030;
	Thu, 25 Jan 2024 12:10:54 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673193D98E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184654; cv=none; b=Nlqrprbcovin43EygNWzMi7XoDuJv0YxukFFIo2/JBnKtnvGH8i2i19lOKQkP5l1AGPYu/K56JKo0ae1mL4lOAEZ+RUO2qPSyRuuPwPtmhBxryzZf5q9AK2Q88bYKtlbg0nGyaloYU4DEJT9bu6TaEXVhWe8g7qJwKePWfohip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184654; c=relaxed/simple;
	bh=jjY2kkYkkj8AYXzFgZVbJHxcNLlKbgf5gvxM/X6Wwys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mojuLf4RYwLo0r9P1Stu18L+OpT62pqKNF6aUxjh/nK+kTGOGyby7BtTDzaqwaBPOMaFmr0SebRt+YtWNB26pYfx6FQLJGYWuBBx2iuYzdgbfCIvVRGvvoqFgWLdsUZBTY5dIec0mQQRidhDtr6MzGu69WiSjiUphgGfXIJjnNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZB-0003nb-Ut; Thu, 25 Jan 2024 13:10:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZB-002HQM-1K; Thu, 25 Jan 2024 13:10:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-007mzp-36;
	Thu, 25 Jan 2024 13:10:44 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pwm@vger.kernel.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v5 026/111] pwm: samsung: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:48 +0100
Message-ID:  <e45e1d89d451e9329d68b046cb0bfda529ebd0ea.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=jjY2kkYkkj8AYXzFgZVbJHxcNLlKbgf5gvxM/X6Wwys=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9Y1IufeL63Y1mple+o5ralvOu3YuMO/Y+uD 901bGwiQQyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPWAAKCRCPgPtYfRL+ TkhVB/9BdSGxcu86jJ0V9wqEHF09XJgSSHoGyC4OxM/N1dQoP9yAjfztp7WOsvVbqq6JD3eOnV1 lEnmCx+YmAEPzoZ8x0GfyLhT05o0/Xg4ClmpIKPUiwKzHJ3aPtih/3/WQOFEGT1tIPKIwtPgPzG MRjKMQ8ccDEgvu2ALI5lQlBw2wW8njbKueZRN23aG4oWkUpfq/sJUYk+oYtnUpLJ5FRzOwxspb6 RFab5yUM5xXAaiA9czUE/YPSbqiWLiXfk5SGjpsPVrvxsr1J+KFxwKBctubWb0bCF8QuK4qiLPq OUue2dAY0xE+c3MjJGejqKDuMvhEvKrJDPQAA5x8yaxYYC6I
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
 drivers/pwm/pwm-samsung.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 6e77302f7368..a97cae49406e 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -197,12 +197,12 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *our_chip,
 				return rate;
 		}
 
-		dev_warn(our_chip->chip.dev,
+		dev_warn(pwmchip_parent(&our_chip->chip),
 			"tclk of PWM %d is inoperational, using tdiv\n", chan);
 	}
 
 	rate = pwm_samsung_get_tin_rate(our_chip, chan);
-	dev_dbg(our_chip->chip.dev, "tin parent at %lu\n", rate);
+	dev_dbg(pwmchip_parent(&our_chip->chip), "tin parent at %lu\n", rate);
 
 	/*
 	 * Compare minimum PWM frequency that can be achieved with possible
@@ -232,7 +232,7 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 
 	if (!(our_chip->variant.output_mask & BIT(pwm->hwpwm))) {
-		dev_warn(chip->dev,
+		dev_warn(pwmchip_parent(chip),
 			"tried to request PWM channel %d without output\n",
 			pwm->hwpwm);
 		return -EINVAL;
@@ -326,12 +326,12 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		period = NSEC_PER_SEC / period_ns;
 
-		dev_dbg(our_chip->chip.dev, "duty_ns=%d, period_ns=%d (%u)\n",
+		dev_dbg(pwmchip_parent(chip), "duty_ns=%d, period_ns=%d (%u)\n",
 						duty_ns, period_ns, period);
 
 		tin_rate = pwm_samsung_calc_tin(our_chip, pwm->hwpwm, period);
 
-		dev_dbg(our_chip->chip.dev, "tin_rate=%lu\n", tin_rate);
+		dev_dbg(pwmchip_parent(chip), "tin_rate=%lu\n", tin_rate);
 
 		tin_ns = NSEC_PER_SEC / tin_rate;
 		tcnt = period_ns / tin_ns;
@@ -355,8 +355,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* -1UL will give 100% duty. */
 	--tcmp;
 
-	dev_dbg(our_chip->chip.dev,
-				"tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
+	dev_dbg(pwmchip_parent(chip), "tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
 
 	/* Update PWM registers. */
 	writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
@@ -368,7 +367,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * shortly afer this update (before it autoreloaded the new values).
 	 */
 	if (oldtcmp == (u32) -1) {
-		dev_dbg(our_chip->chip.dev, "Forcing manual update");
+		dev_dbg(pwmchip_parent(chip), "Forcing manual update");
 		pwm_samsung_manual_update(our_chip, pwm);
 	}
 
@@ -509,7 +508,7 @@ MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 
 static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 {
-	struct device_node *np = our_chip->chip.dev->of_node;
+	struct device_node *np = pwmchip_parent(&our_chip->chip)->of_node;
 	const struct of_device_id *match;
 	struct property *prop;
 	const __be32 *cur;
@@ -523,7 +522,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
-			dev_err(our_chip->chip.dev,
+			dev_err(pwmchip_parent(&our_chip->chip),
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
 								__func__);
 			continue;
-- 
2.43.0


