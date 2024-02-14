Return-Path: <linux-pwm+bounces-1442-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D01854608
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3231F2E02A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74D13FFC;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF381A731
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903290; cv=none; b=SImDVMtSmpGOKIvOPPHz3dZF4DYpom72ELvGpPc74qMy16vPXAMWQ777ANecw+vT6vQFkVSyoey6pN9xh3KRMad5Amg6sntF3Ad6t3s/81tZa/uwA0AYbXAxKAJmRB1xLf9xvqAYB+a5J0LAqnAzOUz79ejSCnSa/HPpIMJg/Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903290; c=relaxed/simple;
	bh=TmoTEsyxx/eGvrPeTzNfn/3WoLAs7xC/w5jM8VEJxiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/6v77VuaZ6xaz2llF+P68O6/Fzr6IZeGeVcHmaakToS/GfhMMvZxHeW7z3TsdWMBv+FQgSF3eNvksxXXDWyRk1oMMrOkTU5a2o7+qgbO1VAfZnLK0GVU/lz+mBkUCqpLLbsDaHBDHayg4KMV9N7OEO69rLFnsjjfY+7pLfqJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-00066F-4M; Wed, 14 Feb 2024 10:34:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-000fHU-G2; Wed, 14 Feb 2024 10:34:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-004Y9P-1M;
	Wed, 14 Feb 2024 10:34:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 141/164] pwm: twl: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:08 +0100
Message-ID:  <c65e796d46df71cd8d0d0941921997b9501f1cb3.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1858; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=TmoTEsyxx/eGvrPeTzNfn/3WoLAs7xC/w5jM8VEJxiI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjtGOaRj8qUBMWTriFyGYcYdKuaBZ5qIJiIm IYvCcm5SWeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI7QAKCRCPgPtYfRL+ TnzoCACtEkgpdLK4d7IsTNtOxGReKlopDKjqX9Rf6K6XFs4bF7Zte7/s6Ds0Fmyc+TBtVohDgIh 1BX8agfzVn42HncvQMDvG470Co5HvFsnL5Z3D23CUTMV6n2crgfU/HKcj9K1sDID6SAYAEvF2MZ Jb+WtYkkw6gValJwS2t/sLGpwEM2+lPWZI0KvFgAl2QKvOuIl+nQSLfFQ2zzLLmgG77f6B5t5ow bl12xQ2d4FN5D72tTu/KTT2QL/BNBOltvIpZHiBtuH0akk5ipcaISOYYhIumZI45su+JiTp647c fXqjwfs1rnjCJKRyzcyGIndX8IoHqM82BUPg3iMpChmx6nqe
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


