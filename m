Return-Path: <linux-pwm+bounces-1033-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C7683C207
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4B1290C3E
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8344502A;
	Thu, 25 Jan 2024 12:11:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6C4502C
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184664; cv=none; b=huVLWy5wJ2ux6dYPa/JK/40YuUuiaQ8a5wCUn9cUUVNHJgG8LobmwbFZnP3kVJKOOAwF5ZzcdqU1gejSefW+Eh9tuYxE5PDabz+XAQ8la8Zxk5AhIBvu7Y8Mra/BriFvLaFYHV4+K8oTtqOplzNHqhrfzkm+G+DILnDvQGGAx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184664; c=relaxed/simple;
	bh=TmoTEsyxx/eGvrPeTzNfn/3WoLAs7xC/w5jM8VEJxiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXbQ92zKBBnV1k7a+BLGvan/0tw7zUDoWYxUBoATvi7i5uSbO4AdiEtpGxg6H7nt3zQbe6O8Q0Y1HMrA/NEQFdxsnIrBx7DU/RW1SsvbH6idn8VnrWkqYo8rM17XrWh4bIxvCoxxy6IOl4oHGaBp+VV9a6PfSQiqTFN+ZjCQIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZQ-0004ak-SQ; Thu, 25 Jan 2024 13:11:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-002HV2-To; Thu, 25 Jan 2024 13:10:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-007n4n-2i;
	Thu, 25 Jan 2024 13:10:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 099/111] pwm: twl: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:10:01 +0100
Message-ID:  <4ecd641777fd2bb7c07ac92821fd0a0348aee81a.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=TmoTEsyxx/eGvrPeTzNfn/3WoLAs7xC/w5jM8VEJxiI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+unhblnoltqBoLmwRHKtADHhy3Q2w9oc+TI Hc7J+lJlBaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPrgAKCRCPgPtYfRL+ TuQBB/0aZQXP0PbSDbe0z/ZBwy2zqc+Q7v+ESkkEvC0Ju0kuJpqk9yCKDDtVYvPT448XApdQvMF UEUgtu480hhxzKpVMUoe5bsyxYBCv5E0/Z6zXfKaVJ0O3Ufc7VvVrQjxN9RbIzB+SuwV88BlSzn yLD/cDJpf3wjCmvnXtXs3XQDcQhVW43R2eSvJ+CBJdbhsjBFUNZT/Hg2SvzfjtzGnXSzK3aRrmS 0js3Ir28JfD2omLl32NKW11TsYDJPOT7zgmKiFJtiLMcoi6yrVmZENsATAi/YuCaa2D2ly5z6SR uHWNO97ZgkW+yIoiQwUQOOjiNICioqGmQjBHz8aIjuq1ek21
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-twol driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-twl.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 7233ae039bdb..8f981ffff4b4 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -46,7 +46,6 @@
 #define TWL6030_PWM_TOGGLE(pwm, x)	((x) << (pwm * 3))
 
 struct twl_pwm_chip {
-	struct pwm_chip chip;
 	struct mutex mutex;
 	u8 twl6030_toggle3;
 	u8 twl4030_pwm_mux;
@@ -54,7 +53,7 @@ struct twl_pwm_chip {
 
 static inline struct twl_pwm_chip *to_twl(struct pwm_chip *chip)
 {
-	return container_of(chip, struct twl_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int twl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -341,23 +340,22 @@ static const struct pwm_ops twl6030_pwm_ops = {
 
 static int twl_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct twl_pwm_chip *twl;
 
-	twl = devm_kzalloc(&pdev->dev, sizeof(*twl), GFP_KERNEL);
-	if (!twl)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*twl));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	twl = to_twl(chip);
 
 	if (twl_class_is_4030())
-		twl->chip.ops = &twl4030_pwm_ops;
+		chip->ops = &twl4030_pwm_ops;
 	else
-		twl->chip.ops = &twl6030_pwm_ops;
-
-	twl->chip.dev = &pdev->dev;
-	twl->chip.npwm = 2;
+		chip->ops = &twl6030_pwm_ops;
 
 	mutex_init(&twl->mutex);
 
-	return devm_pwmchip_add(&pdev->dev, &twl->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 #ifdef CONFIG_OF
-- 
2.43.0


