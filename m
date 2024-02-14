Return-Path: <linux-pwm+bounces-1432-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF98545F7
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C8C1C27171
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF1E1B966;
	Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE2199B9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903288; cv=none; b=SF9bWnLfegXiFsRTdr7XxyRLzuKjagaN3IQ208xCz6Seo5dbwgI1nNmxFGxllcp10lVLPrlnnrF44889GqfhgIMoeuayiQuAOeUBL1YcxkAY6KbbNhvaqWJ3GmbWtMh9RJbfBy9dYv7bsXfBSlbvS3jdwVzpkCX3S9nk+RIDct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903288; c=relaxed/simple;
	bh=dtj8pBhqbTvcBaJAEjUaKJM7LAj26UkY+/gbMpOgPPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLpxbjf8NeYepwF6DXsHRAL1LlpIt7gx3HAduZc2Jv24+nNJCb+XdeVyjjBaS6vvvk9X51DY5efKQ7ltfeKGrFaQUGO2too8dT21dhAM2amIxfLOeG8/wz6QYYnXDgK3GTIN9BUxosYFvbvwcfzrzQIu6mOtEgu5/qQDCIEPrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-0005Tq-QF; Wed, 14 Feb 2024 10:34:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-000fEo-UE; Wed, 14 Feb 2024 10:34:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-004Y6J-2l;
	Wed, 14 Feb 2024 10:34:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pwm@vger.kernel.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 098/164] pwm: samsung: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:32:25 +0100
Message-ID:  <421ee291a065aeae7a1552f22da4173313e789ad.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3488; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=dtj8pBhqbTvcBaJAEjUaKJM7LAj26UkY+/gbMpOgPPc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIi8dRtUNe0zYA+s0OHD5sj0QsHY4X9kSVwDe Uj6zO+Q6myJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIvAAKCRCPgPtYfRL+ TsP5B/98DHYE2m1eQEfspjC38cwFhD/0cfp6nXL8UnHUglrlUDv2OcJB6R90d05IF1jL9A2gZZX G27m3+MIAMQbBE1D+eEdY+Qy8cXcJU+FgYFYQzddOBYTm44kOE9hfUBTHzYwBrhNMZiQ3AgNhyD cMKaZ9vb8mSmskMYCC9vcaJr+0/XuqV7yNjAtTLTZNib8JJlC57Jp2/tin12K+epNeCjTAjBrrQ wlR/tdZ+FKA4zWSTwWnflo48ogRgE4qj+FYqENuvkf6E+iiAgRgeYghTe2vVQoXK6mcdrPRzKhY zVVwowv0fzaXNJdhn/cmcgvr7EeiLFy6kbyp630rZ7md2ypF
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
 drivers/pwm/pwm-samsung.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index ecd612adf19d..cabdcdf37ec9 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -198,12 +198,12 @@ static unsigned long pwm_samsung_calc_tin(struct pwm_chip *chip,
 				return rate;
 		}
 
-		dev_warn(chip->dev,
+		dev_warn(pwmchip_parent(chip),
 			"tclk of PWM %d is inoperational, using tdiv\n", chan);
 	}
 
 	rate = pwm_samsung_get_tin_rate(our_chip, chan);
-	dev_dbg(chip->dev, "tin parent at %lu\n", rate);
+	dev_dbg(pwmchip_parent(chip), "tin parent at %lu\n", rate);
 
 	/*
 	 * Compare minimum PWM frequency that can be achieved with possible
@@ -233,7 +233,7 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 
 	if (!(our_chip->variant.output_mask & BIT(pwm->hwpwm))) {
-		dev_warn(chip->dev,
+		dev_warn(pwmchip_parent(chip),
 			"tried to request PWM channel %d without output\n",
 			pwm->hwpwm);
 		return -EINVAL;
@@ -327,12 +327,12 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		period = NSEC_PER_SEC / period_ns;
 
-		dev_dbg(chip->dev, "duty_ns=%d, period_ns=%d (%u)\n",
+		dev_dbg(pwmchip_parent(chip), "duty_ns=%d, period_ns=%d (%u)\n",
 						duty_ns, period_ns, period);
 
 		tin_rate = pwm_samsung_calc_tin(chip, pwm->hwpwm, period);
 
-		dev_dbg(chip->dev, "tin_rate=%lu\n", tin_rate);
+		dev_dbg(pwmchip_parent(chip), "tin_rate=%lu\n", tin_rate);
 
 		tin_ns = NSEC_PER_SEC / tin_rate;
 		tcnt = period_ns / tin_ns;
@@ -356,7 +356,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* -1UL will give 100% duty. */
 	--tcmp;
 
-	dev_dbg(chip->dev, "tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
+	dev_dbg(pwmchip_parent(chip), "tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
 
 	/* Update PWM registers. */
 	writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
@@ -368,7 +368,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * shortly afer this update (before it autoreloaded the new values).
 	 */
 	if (oldtcmp == (u32) -1) {
-		dev_dbg(chip->dev, "Forcing manual update");
+		dev_dbg(pwmchip_parent(chip), "Forcing manual update");
 		pwm_samsung_manual_update(our_chip, pwm);
 	}
 
@@ -510,7 +510,7 @@ MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 {
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
-	struct device_node *np = chip->dev->of_node;
+	struct device_node *np = pwmchip_parent(chip)->of_node;
 	const struct of_device_id *match;
 	struct property *prop;
 	const __be32 *cur;
@@ -524,7 +524,7 @@ static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
-			dev_err(chip->dev,
+			dev_err(pwmchip_parent(chip),
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
 								__func__);
 			continue;
-- 
2.43.0


