Return-Path: <linux-pwm+bounces-1007-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3E383C1E7
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4C3290DED
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87533FE3F;
	Thu, 25 Jan 2024 12:10:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ADD33CC9
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184659; cv=none; b=LsMXppoS5qDvy3E2+APlxc6dEoc2WgcXJSWJ/byUUmuewOChcgJKEb/068stDYqMFU2HsirRBK5RQLr9nkSgf1LQTXMXxI64ilP1LECTo6sgVmE6QxgwRo9f8V0qt9uqrTHo27Z54ZAChi3RBvK/3H9bpa6lXLfXjaNjW32NoxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184659; c=relaxed/simple;
	bh=tbf+Q2Gxrb81SZI03PQrpWoV9hGmidTqVonqvgzF990=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTVNGYJKilZI+M5rr69v+mUMWRA4YN3th99+q9l5iIyBX9t82qJCuaoEWIPFIZ1dDVfgEwYgBBhhLXgsLFva7B62Uh2yIEqZhT/Rya4A4ewQV63Nqd3J9HJOfe0WkBLy/LHaNkDa1+rM+t7paRETmiASfuwLRXeZoTR8vMSV0kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-0004RC-OT; Thu, 25 Jan 2024 13:10:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-002HTN-8J; Thu, 25 Jan 2024 13:10:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-007n2y-0X;
	Thu, 25 Jan 2024 13:10:54 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-pwm@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 072/111] pwm: meson: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:34 +0100
Message-ID:  <bf6f7c6253041f60ee8f35b5c9c9e8d595332fb0.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tbf+Q2Gxrb81SZI03PQrpWoV9hGmidTqVonqvgzF990=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+Ps9GWUz16FfY73NvDjTCMhYVcOfguNy68z bzG8PvGCR2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPjwAKCRCPgPtYfRL+ TqjuCACTkTZutcwEYIAetP5/AnxvzOgESXYd5G4R2im/Y3HsmdptBtCo5AOOfuzXrbfejfnh74I iG5FTd+XcdAShxd3o91Yiv5Fc6ktPwv3ckxk+GDnd/y0+EKX9jAlgMP7ggC14b0Xg7MCL253ufx q0lV7JWwmrNn9n82i9O6PrzwH1IjQ5ZT6gNjm6ANh7oqn728Wk09If78UNy1De8YxVH+XLA5Bqz FLdS4pu+lb/I1bpLoTRfLI3rTuNAD3HGo6E/fAbexVkcUT0hJGYBbHEjJd7Y1NQ5YvDDwR169/2 DpoAM+Klwutd44wmbOSqFnbswNBAsYTAcmSJbij2W7ACJO0E
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
 drivers/pwm/pwm-meson.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index dd0e18437be9..40a5b64c26f5 100644
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
@@ -449,7 +448,7 @@ static int meson_pwm_init_channels(struct pwm_chip *chip)
 		mux_parent_data[i].name = meson->data->parent_names[i];
 	}
 
-	for (i = 0; i < meson->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
 		struct clk_parent_data div_parent = {}, gate_parent = {};
 		struct clk_init_data init = {};
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


