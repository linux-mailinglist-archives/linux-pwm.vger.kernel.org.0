Return-Path: <linux-pwm+bounces-1315-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF61854579
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9FB1C2048B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2944517C9E;
	Wed, 14 Feb 2024 09:34:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71815168CE
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903263; cv=none; b=HwF0ysjHTxN1u/u/jz5eu1ZmUrAtRh8h4pNICVARaMrCLJZMub5JhcBiHGM9+1u0q7SNYAArSQ3k+arb3DEzGIThff8aolQ3PYuLO503okV6dqdffZ6lZSf7JGcJnm29pmnaHnfrfJ1YYof5zF0wh8g5lVoKyL/fjr680e5iz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903263; c=relaxed/simple;
	bh=u+gejKb/n3TvTOBDvd4t8DanspzxeNANqWHoGQIrSWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLCwb3t5avawEH/O4MJ+bOFhL1Yu4PShMJQw61qu7RGd4QcckqLcVISkZrJ514p4wp/1FmPQZhFRQpj9QCwjCol2CoW2tB8fVaxpXhHlGmLBg6DE0ixAFVuUVIoK71axWA2NgiX5GcOEOHMq/OKVypDh1ff1sn1hAwZEWVhFOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-0004OQ-4M; Wed, 14 Feb 2024 10:34:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-000f6k-Nw; Wed, 14 Feb 2024 10:34:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-004Y03-29;
	Wed, 14 Feb 2024 10:34:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 006/164] pwm: ab8500: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:30:53 +0100
Message-ID:  <9c952baafe7e53c482adf23215138724b61e376b.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=u+gejKb/n3TvTOBDvd4t8DanspzxeNANqWHoGQIrSWQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhR8wClpbmm9+HKBw3CaMMQ4QnqHb3iwxxOE bRxcgdG5XSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIUQAKCRCPgPtYfRL+ Thd4B/91u5ese2QAAjkyqDnzEPQ3MdKAT+hJC37zhJ+hcS1uSa63PGNHD0ldLqHt/GVveGP+a1P 7sMMTvYcU4S6fwZKO7XQFwmly6S8mc8CLPJcTXdV8q/Q74iVdiCTyMIPqEL7vUmaO2cneo/8MUf 17dWKe4WBz4KLB2S9rI6kmImSLJ/rQZp2McXkZGgjYIiIKgNMg2V4/wQnYYd4y1GahcGKa2CN2f gKSS6FXvq6jWYCd6RrdNP84hq3P8d0LoOixN6zHvPciMIHTMXYLtQFU9ZFYfR8gknby9ffbWTNz 3NlbkEbQmsB5XQ0T54wYYsKqxzwvjuGSobYnzbvAaanoOpn/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-ab8500 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 9043e5643f44..f000adab85b0 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -24,13 +24,12 @@
 #define AB8500_PWM_CLKRATE 9600000
 
 struct ab8500_pwm_chip {
-	struct pwm_chip chip;
 	unsigned int hwid;
 };
 
 static struct ab8500_pwm_chip *ab8500_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ab8500_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -196,14 +195,13 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	 * Nothing to be done in probe, this is required to get the
 	 * device which is required for ab8500 read and write
 	 */
-	ab8500 = devm_kzalloc(&pdev->dev, sizeof(*ab8500), GFP_KERNEL);
-	if (ab8500 == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*ab8500));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	ab8500 = ab8500_pwm_from_chip(chip);
 
-	chip = &ab8500->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &ab8500_pwm_ops;
-	chip->npwm = 1;
 	ab8500->hwid = pdev->id - 1;
 
 	err = devm_pwmchip_add(&pdev->dev, chip);
-- 
2.43.0


