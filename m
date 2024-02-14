Return-Path: <linux-pwm+bounces-1431-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDD38545FB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B9571C21EFF
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7504C12E54;
	Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC21A29A
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903288; cv=none; b=bFATfEr7bafrlcwsGJzkeS9f0HXGvY0TEV6/lXviRMc8u8VuIBpcEPZwf+1JsuhEGpQLEG8+ybwVAc+xvzFb5lz6k3LhZORkCKEH/uJbkBlbqYBwx75GQgvbdz8T0Q35k0PWeOUHLRgFobbWWW/iNQrb98BDyTZSXCJs5+LKSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903288; c=relaxed/simple;
	bh=xzH0PR7gBbvWCkb/is/73c3/j0KzpFtKuqTvh0Z2Ceg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEJpFeEHxFE0PR8UZwS4n/fUQC0vlmhQzzXcx5OCGsxKiEc0SAO9RQMlLOioPcu2D4CUqTzN8I84qGDAS2oGZWZvKigGE2SYQJUz5i3X8lSRabGxc4IRgcrRRaJxetrWOef3OrH9j7s4R9WutEWyPhlGXlHJ92O3EfEbDJ2Mqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-0005zU-SW; Wed, 14 Feb 2024 10:34:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-000fGu-4b; Wed, 14 Feb 2024 10:34:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-004Y8f-0C;
	Wed, 14 Feb 2024 10:34:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 132/164] pwm: tiecap: Simplify code to determine the pwmchip's parent device
Date: Wed, 14 Feb 2024 10:32:59 +0100
Message-ID:  <628f4b8c4ba1321075fc1dff70453a1c79ffb814.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=xzH0PR7gBbvWCkb/is/73c3/j0KzpFtKuqTvh0Z2Ceg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIji37dzFNjAhL+ZJWalzRjUM41IwJr+jtCnY tgnkAwsmDuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI4gAKCRCPgPtYfRL+ TvV0B/9ypv5mv1LxBEuUVf+QkEY5oQO/xp25FYs91TUVIwEDDyzNbCpRPzjYZPBm0BgBZeF7EVt PY5hodFlWJfXeCnKFWNrI5RBCs3u2J9glTGpftNPknovJrhHqz7ZrCML7F1TDhijZUDsGq+eAD8 C+BabYacVWGMMwMoltL1QZnMGak4ci1ISyXRs+/RECIpdyo7c2tERAMZoGbO3frcM9j4Y7s+eyD L0sGyJ9GIXRjGlJK2rd+Vs5Je5oKlERz26n+kQrIVD4XGg6X2Z8wgoVIO0VS1Izu0jTaZDjFlHU AtsdVH3tZBQI8936JAZYPMip93qR8AA7sXyqaunSwxu/uLIY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

There is already a pointer to the pwmchip, make use of it directly
instead of using the struct ecap_pwm_chip *pc just obtained from
it. This also has the advantage of not using struct ecap_pwm_chip::chip
any more which will be dropped soon.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index d974f4414ac9..b93e3be318d5 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -70,7 +70,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		duty_cycles = (u32)c;
 	}
 
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(chip->dev);
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -100,7 +100,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		writew(value, pc->mmio_base + ECCTL2);
 	}
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(chip->dev);
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
 	u16 value;
 
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(chip->dev);
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -124,7 +124,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writew(value, pc->mmio_base + ECCTL2);
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(chip->dev);
 
 	return 0;
 }
@@ -135,7 +135,7 @@ static int ecap_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u16 value;
 
 	/* Leave clock enabled on enabling PWM */
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(chip->dev);
 
 	/*
 	 * Enable 'Free run Time stamp counter mode' to start counter
@@ -162,7 +162,7 @@ static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	writew(value, pc->mmio_base + ECCTL2);
 
 	/* Disable clock on PWM disable */
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(chip->dev);
 }
 
 static int ecap_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.43.0


