Return-Path: <linux-pwm+bounces-264-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B4B7FE9DE
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 08:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4F9281ADD
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 07:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4352031D;
	Thu, 30 Nov 2023 07:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C1619F
	for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 23:41:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8bgF-0004hQ-Qq; Thu, 30 Nov 2023 08:41:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8bgE-00Ca6c-Vy; Thu, 30 Nov 2023 08:41:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8bgE-00BOc8-Me; Thu, 30 Nov 2023 08:41:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] pwm: crc: Use consistent variable naming for driver data
Date: Thu, 30 Nov 2023 08:41:34 +0100
Message-ID: <20231130074133.969806-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=x2ipI6d+Z4hDf8zwMIyWnlW63Qbzjozx0MsCviUGqYM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlaDyt8lXRxrDwgnZOHZAaiLu+Mift5EosDi7ik 7AlcJCAzpqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWg8rQAKCRCPgPtYfRL+ TpTPCACwNkOEfeWXeUbK1nBtVL0MJmf6+T+KvB1EaIwReDkcl7snc3IOCyY1MWdvw0yid8daoZt XTDGPIm+cUzvvziCdmjJmuHAdUBTKoEUDQzU3lPKGfWtf/YnrW4fab9/0VxIzFwd6p/N0dUG3+q qUD47Vix30sdL/Z49j6HJm7CrOjIK8RQ+2VxnzyEy0l1Ij9gFT1+SzieXJSR+npsYk3iXu4+7mh ib9ilbE6Iutcz8wss4uo8HQmTnHnEpGOylg1wDwbdZK83ivTNw7AvmlJtX6IaVjOrf89+/VRZjs +J+Ga+4yFjcLEOwxoEjn9tgV8WSjGbp37hvDYfDMFAe888YQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

All but one local variable of type pointer to struct crystalcove_pwm are
called "crc_pwm", the one outlier is called "pwm" which is usually
reserved for variables of type pointer to struct pwm_device.

So rename that one "pwm" to "crc_pwm" for consistency.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-crc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 2b0b659eee97..e09358901ab5 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -160,22 +160,22 @@ static const struct pwm_ops crc_pwm_ops = {
 
 static int crystalcove_pwm_probe(struct platform_device *pdev)
 {
-	struct crystalcove_pwm *pwm;
+	struct crystalcove_pwm *crc_pwm;
 	struct device *dev = pdev->dev.parent;
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
+	crc_pwm = devm_kzalloc(&pdev->dev, sizeof(*crc_pwm), GFP_KERNEL);
+	if (!crc_pwm)
 		return -ENOMEM;
 
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &crc_pwm_ops;
-	pwm->chip.npwm = 1;
+	crc_pwm->chip.dev = &pdev->dev;
+	crc_pwm->chip.ops = &crc_pwm_ops;
+	crc_pwm->chip.npwm = 1;
 
 	/* get the PMIC regmap */
-	pwm->regmap = pmic->regmap;
+	crc_pwm->regmap = pmic->regmap;
 
-	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, &crc_pwm->chip);
 }
 
 static struct platform_driver crystalcove_pwm_driver = {

base-commit: 53a2eaaf19c4e652ac53b5b2441582a555768516
-- 
2.42.0.586.gbc5204569f7d.dirty


