Return-Path: <linux-pwm+bounces-1047-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ACD83C21D
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1408C1F24055
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4258436B0E;
	Thu, 25 Jan 2024 12:11:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ADF3FE2B
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184667; cv=none; b=klQbUfiSgyBa5H12fr5Jl8vRQsIyVKybJD4zhypCI3akrdPSe+Trp7prleQCLbpcHwoqR2g4bj35eN02JQ2hfnEYZnwyExr7zDGBqZTgftmry0OHFOBzc6rBDFULra8iH4d3MMGLfbO5NA2fAN5QL6nOGE6sSLtCRZH1/h5POZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184667; c=relaxed/simple;
	bh=pbimw4e1snhdJV1OL+Hd8nlXssUcoYI3zeJdziV6/04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9JA77ocnKC3iNYopWd5PLIJqT9mgqEYyJZuEzxM1G3OShiLWOnahBxTd2EBvfcLqd4lb4HrmJYdpZtiTmdY7URCzTgiQs6RvnAksYGy8v6DdyQYNO6DX+nPtb/kAh4g4VmzPQFByOg1iGkXyDXaSm28AL9IwzFuYootcYPoxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-0004ZA-E7; Thu, 25 Jan 2024 13:10:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-002HUk-37; Thu, 25 Jan 2024 13:10:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-007n4T-03;
	Thu, 25 Jan 2024 13:10:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de,
	Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v5 094/111] pwm: sun4i: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:56 +0100
Message-ID:  <3fbc44ec7f4a5b8c388ebddb8fc9c98d2eb04834.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3137; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=pbimw4e1snhdJV1OL+Hd8nlXssUcoYI3zeJdziV6/04=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+ovSOLzS0QBSxAO37SsCRl6WlZNV2yQM532 +KI5vxIZ1WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPqAAKCRCPgPtYfRL+ TmiTB/9RSOvADji5DhMKskrIzH8FgyRWsSbXa0Ivb77Apq8oM+u13NHEmx5xWmyspbmx4cG4Vy1 s36owWy4rycjf72wTGYzizrnTg/W4APlv+3sRGnYTS53zybIzA/0dp5lRrT7uZcxERbdEJlj04I j//7OLQoKzJKm5YP8qnrFqx1wDq+0JE/iFlhXGHaT0toVCvxxwaRx5ZXqSkTxqmwpzH9la9/azl ltZGMSOhARoKupbwp9CVHRQWxsNH34GDmFKTkJUcWkaLXEmPlEuuFTRmn3+DQ0K18HLg7pQmsGj cEiElqZzAuGlFUca/aI+f2vMOXAvyECx8z/RSQavqqBJXn8X
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sun4i driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 44edf1ce5739..36a8dc65b19c 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -81,7 +81,6 @@ struct sun4i_pwm_data {
 };
 
 struct sun4i_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
@@ -92,7 +91,7 @@ struct sun4i_pwm_chip {
 
 static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sun4i_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline u32 sun4i_pwm_readl(struct sun4i_pwm_chip *chip,
@@ -384,17 +383,22 @@ MODULE_DEVICE_TABLE(of, sun4i_pwm_dt_ids);
 
 static int sun4i_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct sun4i_pwm_chip *sun4ichip;
+	const struct sun4i_pwm_data *data;
 	int ret;
 
-	sun4ichip = devm_kzalloc(&pdev->dev, sizeof(*sun4ichip), GFP_KERNEL);
-	if (!sun4ichip)
-		return -ENOMEM;
-
-	sun4ichip->data = of_device_get_match_data(&pdev->dev);
-	if (!sun4ichip->data)
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
 		return -ENODEV;
 
+	chip = devm_pwmchip_alloc(&pdev->dev, data->npwm, sizeof(*sun4ichip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	sun4ichip = to_sun4i_pwm_chip(chip);
+
+	sun4ichip->data = data;
+
 	sun4ichip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sun4ichip->base))
 		return PTR_ERR(sun4ichip->base);
@@ -451,19 +455,18 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto err_bus;
 	}
 
-	sun4ichip->chip.dev = &pdev->dev;
-	sun4ichip->chip.ops = &sun4i_pwm_ops;
-	sun4ichip->chip.npwm = sun4ichip->data->npwm;
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
 
@@ -477,9 +480,10 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
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


