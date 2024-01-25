Return-Path: <linux-pwm+bounces-1039-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D9183C213
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD58D1C225BF
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB664439F;
	Thu, 25 Jan 2024 12:11:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE6033CC9
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184665; cv=none; b=KYuYgpthzasbL0VtyGkAV40HVg1abYjt3yKaTKwCOwS7OJDJcXPgxVY7/zFnIdOeU+bWXmQqEnUCTvhO8a5+ThQp3p1xj19kCWcC1aebRh1V0P6ABfv38Mo7SCZ3XZCDFKP+ffl/dQ9d84NvJ2hUXnwoGBDzIA2lPePZ3D3vkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184665; c=relaxed/simple;
	bh=XVNtllv3/agHO1euaKNS93tCXeA+kBs0Qnq+p0BRlR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egACQaxgzO5foL/hqxxzvIvqVtFFSC38SPfl98kYY+wqRnizzSOuYFTa24koBB+KYXzkf+ZTFKRSAVxTS6u44N0kY+1p7YNGQ6IuVN9WlmM3LgsEEi3m03cqzPPTvDWLfT5aDhIOkpUzx71R4MP2tXK8W+w6X/CdM/UwyNHK31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZR-0004dh-4h; Thu, 25 Jan 2024 13:11:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-002HVL-Py; Thu, 25 Jan 2024 13:10:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-007n53-2L;
	Thu, 25 Jan 2024 13:10:59 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pwm@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v5 103/111] gpio: mvebu: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:10:05 +0100
Message-ID:  <c57f631ef5167554a30d627320dca617cd5ef210.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=XVNtllv3/agHO1euaKNS93tCXeA+kBs0Qnq+p0BRlR0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+ziE5ykHdExP8+Gt+ZAyQo7gGrjzGAK3bi0 DpMH5wd4TyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPswAKCRCPgPtYfRL+ TsQZB/414JR3WIuwraL0yw+a4d6Vz7SnSUyr3byOJi5fuqwDJc5OJXIwwthvMZ5ymn21VrHwUO8 Xgq1ZTPO/8sLcmJL123Kq61XV5T19itWpGtq8IaHrXggQl2hWQpf0IQvtlFpXdfJ4XPjXESnscx ErAP7uuGVzdUdLL15bq7GY3QIj26Ivno2AUUZGCv3eBFnu+0SI0nFDQECBRVKpEqN8l1ZaV0Io6 spYPoZ3c8cv4c1KjMXRAcQHytX+ridp9xYCUrFkT/NPpbAZ3yXbSaFaTwj9tqhLfQAMLQXjUs9m 41QA8IQSniN7443ohLtHpylhffnj4FSux8f3lGZkuEk6viJR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm sub-driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-mvebu.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a13f3c18ccd4..8cfd3a89c018 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -99,7 +99,6 @@ struct mvebu_pwm {
 	u32			 offset;
 	unsigned long		 clk_rate;
 	struct gpio_desc	*gpiod;
-	struct pwm_chip		 chip;
 	spinlock_t		 lock;
 	struct mvebu_gpio_chip	*mvchip;
 
@@ -615,7 +614,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
  */
 static struct mvebu_pwm *to_mvebu_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mvebu_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -789,6 +788,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct mvebu_pwm *mvpwm;
+	struct pwm_chip *chip;
 	void __iomem *base;
 	u32 offset;
 	u32 set;
@@ -813,9 +813,11 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	if (IS_ERR(mvchip->clk))
 		return PTR_ERR(mvchip->clk);
 
-	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
-	if (!mvpwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, mvchip->chip.ngpio, sizeof(*mvpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mvpwm = to_mvebu_pwm(chip);
+
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
 	mvpwm->offset = offset;
@@ -868,13 +870,11 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	mvpwm->chip.dev = dev;
-	mvpwm->chip.ops = &mvebu_pwm_ops;
-	mvpwm->chip.npwm = mvchip->chip.ngpio;
+	chip->ops = &mvebu_pwm_ops;
 
 	spin_lock_init(&mvpwm->lock);
 
-	return devm_pwmchip_add(dev, &mvpwm->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.43.0


