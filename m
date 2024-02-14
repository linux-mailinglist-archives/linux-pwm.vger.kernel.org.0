Return-Path: <linux-pwm+bounces-1446-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C672585460B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6346F1F2E0ED
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789FC1428A;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2661AAD0
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903290; cv=none; b=ofgGZr35yETqaPDRakz/I0WlglNCalaP0Bw0M7fGZmUOostHjrvDRO0nicZDoghNLIoz+vRKFlJSETewAELS7v0MZKSyypdrneKULCiQrA6LSG5dJsO1LO44QIQuWIN3DSnrN1j/EJycD0EyRAQ5g08ciZ8DTkEvRvZuKmV0JMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903290; c=relaxed/simple;
	bh=AueSBh20l+IvmTnMku/uAxXaCwl5AScvfIDtGYeyXxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iT7fVydrUUWde2nma+Ut42OJfWBo3+gspDNU2zIn/REeT3RqkvlDTOfWA+dfGbLkAx5FqKSAzUkhgKcedJQHUS2JPZ5FVcWuQGgG9IB7nQGTtc94T2kIgOEb+5JH4DBcQaiMfDtLgZdFYZ/9udrAj9pwaHPw91bvTh7FkVU/Jbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-0005st-Vy; Wed, 14 Feb 2024 10:34:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-000fGT-3o; Wed, 14 Feb 2024 10:34:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-004Y8D-08;
	Wed, 14 Feb 2024 10:34:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 125/164] pwm: sun4i: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:32:52 +0100
Message-ID:  <f8e3fb96fe341ba0a4bed982aa731c5c7c355b83.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2191; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=AueSBh20l+IvmTnMku/uAxXaCwl5AScvfIDtGYeyXxg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjaRcrH/Di3kXiX+2H/62isgprTTbchcjoRV XNyA2Z72KSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI2gAKCRCPgPtYfRL+ Tk7uCACQKU8wijfW5XTvrUoBIFZpXyJP4eFodXHJNx5MUXhZp+D7toClZKgb7XRdVgCsbAxnLdn CzEnmZTpm3beiNytFEAkZnC33LdIMo/sh7PWQ7Zeo1hmcL2/SOE926dzq+2vJWR7fTgHBziHF6x oGb80w8h9qONuV7o3QKZqL4eSsgw3jZs7ou3Yxo8QG3TYD8XJmAeNWN2QUyY78TrR0RCx3u9Ubm GIqlxCc409hLFN8CPQnVWqLnRGhCVU6AIDUkYN13tc0YB0yg0MKtZaUVvh5JfgVcbCjgTUWJQ1Z +UFDKwc14laD4XSymg32R/GWoUJidJ00KG4Tk3FQE3aW5P89
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct sun4i_pwm_chip. Use the pwm_chip as driver
data instead of the sun4i_pwm_chip to get access to the pwm_chip in
sun4i_pwm_remove() without using sun4ichip->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 44edf1ce5739..c2f579043915 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -384,12 +384,14 @@ MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
 
 static int sun4i_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct sun4i_pwm_chip *sun4ichip;
 	int ret;
 
 	sun4ichip = devm_kzalloc(&pdev->dev, sizeof(*sun4ichip), GFP_KERNEL);
 	if (!sun4ichip)
 		return -ENOMEM;
+	chip = &sun4ichip->chip;
 
 	sun4ichip->data = of_device_get_match_data(&pdev->dev);
 	if (!sun4ichip->data)
@@ -451,19 +453,19 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto err_bus;
 	}
 
-	sun4ichip->chip.dev = &pdev->dev;
-	sun4ichip->chip.ops = &sun4i_pwm_ops;
-	sun4ichip->chip.npwm = sun4ichip->data->npwm;
+	chip->dev = &pdev->dev;
+	chip->ops = &sun4i_pwm_ops;
+	chip->npwm = sun4ichip->data->npwm;
 
 	spin_lock_init(&sun4ichip->ctrl_lock);
 
-	ret = pwmchip_add(&sun4ichip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 		goto err_pwm_add;
 	}
 
-	platform_set_drvdata(pdev, sun4ichip);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 
@@ -477,9 +479,10 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 static void sun4i_pwm_remove(struct platform_device *pdev)
 {
-	struct sun4i_pwm_chip *sun4ichip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct sun4i_pwm_chip *sun4ichip = to_sun4i_pwm_chip(chip);
 
-	pwmchip_remove(&sun4ichip->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(sun4ichip->bus_clk);
 	reset_control_assert(sun4ichip->rst);
-- 
2.43.0


