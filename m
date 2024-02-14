Return-Path: <linux-pwm+bounces-1460-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216B6854621
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BB21F2E0C2
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F7134D1;
	Wed, 14 Feb 2024 09:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09E312E7D
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=TqBpVnEUPAJxfd56F0b02mJNADF8ihCDJI6WMMO+M7Ovr1yqtFyO3D7aEAGSLN2PYtJSqFchQ6dgdfZ2F0tdbTLjs57273N0/s8jUKKVxPepHDD6ctW6NXHHi4eElLFsl5EVgCv0mcDClfuHk/a8u+Y6w4jkqDWWAXs7iIX6t4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=W5Wp/YX5ZNL5lRXSmQet2h8oEA52+3pGK0CF32hVD4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OINMdFMUV3IXbXsmY85pR6B6K0Nk6yeTdOYx8X/oJdr5nen8Q2sJuN9DsKxIfZeNZ8Z+B8FbEBJRmM0R5JvSNVFBlLTnE1+SVTkdU476UczgKzRzq4QHDjTUUO3Y9l75hVvxDg2vBRAN0SwNXUAkycgH4opuQmziJeElU1Dnas8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfA-0006CQ-Ba; Wed, 14 Feb 2024 10:34:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-000fIB-09; Wed, 14 Feb 2024 10:34:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-004YA3-2z;
	Wed, 14 Feb 2024 10:34:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pwm@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 151/164] gpio: mvebu: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:18 +0100
Message-ID:  <2edc3adbb2c40b76b3b3dac82de82f3036bec1d5.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=W5Wp/YX5ZNL5lRXSmQet2h8oEA52+3pGK0CF32hVD4A=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHT8sJr/jnz9/Y5/1ke3xDfqcZbrpxj16T1VDFyz/7 iCXtWh9J6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATuW7E/k9bN29+MtdPo5RF 6vrZYUfLljq8TIytVryReuPtq218LqwL2ILYWie4zObqTuWfHGLUw/P/zrp6pTVCP54Yv11x9vg 8V5fTfh69iZf++ic4vK+XlF9341Hhfe6FqexLnbNqeT5/uBewt+RDd+NzA0enyteWS7oc9mu9ms xsPmflKY3bxxJ6T2TZ2Wh4Tbq/98DhYi5lXcsEr+9WP3Qr2k/LlxsXRIiVMVadOGMTX7H3zeuLf 73r94pfDBR1y/b95PZqR6j/3QR19lL7P2bmCap7082mz/Rn8Om6/js21OzjMe397xl7nTSrZljL 2Oq+zmrtaN07s+5OyYmHJZVOTYpRtzOfSYu8srpQLCEDAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm sub-driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
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


