Return-Path: <linux-pwm+bounces-1035-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388483C20E
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481ED1C224CC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7BB3F8CA;
	Thu, 25 Jan 2024 12:11:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B03C097
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184665; cv=none; b=kLakU/sRZ2ivBzu5e2kd77PbaT8glTFBqPUXJuZS5kIjGnxDuklGfov198kyklWK2Age+UZ0K0Ms+ad2wxWB/8yQM0//3WwXjaxNt13JhryJ8bWwDIuDIIh4jZ8ZwOc6eONvIGBdEmrAeaTMA1OjQKXb9E/pfiqlp3qUUV7jHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184665; c=relaxed/simple;
	bh=CDg5DENx7fvJJUTQlX8qtwT+uKgrppGqalaIRu7TUN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QU0wdrHQKU8AonyNPPkxxH8hbT4xexB8k+1OV7UC5OfEye4/85anpzID709XZ2z5GpBdMfs8Fb13rbxmebvMuZq7XSBm1Z6cuBcLCpJ93YCMuxBT5FngqeaWnUAMW3hNsdLXE9VEKthBi8PP6yFjrbhDuZelSBSR4zMwdbOBRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZR-0004bf-0J; Thu, 25 Jan 2024 13:11:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-002HV8-48; Thu, 25 Jan 2024 13:10:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-007n4r-08;
	Thu, 25 Jan 2024 13:10:59 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 100/111] pwm: visconti: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:10:02 +0100
Message-ID:  <1debdb7798b99db180bf92ea9f38fd1bb9904864.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=CDg5DENx7fvJJUTQlX8qtwT+uKgrppGqalaIRu7TUN4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+vUR8OAGO4TTfgRsObBRSF699ecKeCylvoK kd/tHoJ2UWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPrwAKCRCPgPtYfRL+ TqzIB/9+qKFby9PwLsVpnhWDFLd/dGcob6nGpzmsNjAr8fnBQZ4cau0Hdx/CkENffeZQn+lc/tC Hdgf6iMnLXP+MTyuot1Ypld3ZmGKkEooW0sgAJ+PmuX4/MZb6JBqRkV0eosncUwTUR0MvojpgLb Z4J5Wr6qUIolCLxERCZcvckF0nvND5s46A6bPzQjl7bVK1smNF4AfHrZTJinwbPH/tBtb/hrShv CdOIbStCgzz7HofchphnKWEUVJBl9RWlWj4radRpRlDPR1U1f9rc2aqG171ljqRQSPSDgBDCZ44 khbmpHlTQwruqRt3FrTgSAC/Y65s9Fqlu3lWl0Y5TbwpEdHo
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-visconti driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-visconti.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
index 8d736d558122..9e55380957be 100644
--- a/drivers/pwm/pwm-visconti.c
+++ b/drivers/pwm/pwm-visconti.c
@@ -34,13 +34,12 @@
 #define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
 
 struct visconti_pwm_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 };
 
 static inline struct visconti_pwm_chip *visconti_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct visconti_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -134,22 +133,22 @@ static const struct pwm_ops visconti_pwm_ops = {
 static int visconti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct visconti_pwm_chip *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = visconti_pwm_from_chip(chip);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &visconti_pwm_ops;
-	priv->chip.npwm = 4;
+	chip->ops = &visconti_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Cannot register visconti PWM\n");
 
-- 
2.43.0


