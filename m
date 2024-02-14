Return-Path: <linux-pwm+bounces-1392-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C488C8545D1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0981F2CF9B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5011B179BD;
	Wed, 14 Feb 2024 09:34:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAC1862E
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903281; cv=none; b=QRTO5qRsA8bW0U8Pt0QbbpsrHUsASXUYv+BW/bNfwoRlNQS0vRUYdA2AX6gFpI+qCCswn6LG6ZdB1s6n0/A8Gt/ja4T1NWlyMd98Uuc/T3oQImlI5pj7K+gLsuvqZ3FGmn9x+guxR/8Pg59/UgJZmYs5sdQ5cO2BEfqjM505LCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903281; c=relaxed/simple;
	bh=kX6EFouZB5MYYiTP4tBFnKgAGjASoigtowFicYD6b3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVesj6E8UOrXPrb4eO2awEl8zyomDHjOixKuFlS3F6EEAxOF8Hnjr5VaZvfuIJequzKuunLsifDIlvuM/rY6sU4kah967R4DmCHerU1HkrtY1OuG5sGrWIL26/pNjD8E44tEzOJe4olx9HY7BWtNKDTuDvJbJuNQF+3687m0b1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-000581-Ds; Wed, 14 Feb 2024 10:34:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-000fDD-3s; Wed, 14 Feb 2024 10:34:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-004Y4d-07;
	Wed, 14 Feb 2024 10:34:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-pwm@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 072/164] pwm: meson: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:59 +0100
Message-ID:  <6cc57880e910e6ffd8df15bc4a41c42fe9523293.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2224; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=kX6EFouZB5MYYiTP4tBFnKgAGjASoigtowFicYD6b3E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIidWfVfn7Dw31SNgaFp2QH7liUSRq2yticDS k3FNJPT/eCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyInQAKCRCPgPtYfRL+ TjH1B/9AxarRd3srRCG4XrdO83IxtL0DmP5pCLuH6j5u/UYe7Kk+l/xY/+94TOtwPBYp1BTVmJI b6EzX4/KHExsWdsEzep5p8Jt5jyMcM6h4AbZN3kpYWXSdyfy9As0Im1B8t16p6iQEsYvb6CfAfR j3YKtbEnOMGLoUP8qPyIjd7SPTbTyNjf1Jo/yM43unho5vWK4C8Fmzm8NKbYgJcgBmoCYBphUMz t71ruog4QHRUlskKN6z24IDsiIJZp6I07JFTaTdmQe7XYxX/R/Ehn85k7cdijUmlvTs3YQZ60Ma 1IgMCwWM4ojT4nxudd55eWUf1X8Oc9u29UiMWvPxRZOvSSLj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-meson driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-meson.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 8f67d6ba443d..40a5b64c26f5 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -102,7 +102,6 @@ struct meson_pwm_data {
 };
 
 struct meson_pwm {
-	struct pwm_chip chip;
 	const struct meson_pwm_data *data;
 	struct meson_pwm_channel channels[MESON_NUM_PWMS];
 	void __iomem *base;
@@ -115,7 +114,7 @@ struct meson_pwm {
 
 static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct meson_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -529,29 +528,29 @@ static int meson_pwm_init_channels(struct pwm_chip *chip)
 
 static int meson_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct meson_pwm *meson;
 	int err;
 
-	meson = devm_kzalloc(&pdev->dev, sizeof(*meson), GFP_KERNEL);
-	if (!meson)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, MESON_NUM_PWMS, sizeof(*meson));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	meson = to_meson_pwm(chip);
 
 	meson->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(meson->base))
 		return PTR_ERR(meson->base);
 
 	spin_lock_init(&meson->lock);
-	meson->chip.dev = &pdev->dev;
-	meson->chip.ops = &meson_pwm_ops;
-	meson->chip.npwm = MESON_NUM_PWMS;
+	chip->ops = &meson_pwm_ops;
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 
-	err = meson_pwm_init_channels(&meson->chip);
+	err = meson_pwm_init_channels(chip);
 	if (err < 0)
 		return err;
 
-	err = devm_pwmchip_add(&pdev->dev, &meson->chip);
+	err = devm_pwmchip_add(&pdev->dev, chip);
 	if (err < 0)
 		return dev_err_probe(&pdev->dev, err,
 				     "failed to register PWM chip\n");
-- 
2.43.0


