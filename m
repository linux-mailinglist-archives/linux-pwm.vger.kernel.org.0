Return-Path: <linux-pwm+bounces-365-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9F806EA1
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3C2281C04
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA57358B7;
	Wed,  6 Dec 2023 11:48:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8F1D51
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:38 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOI-0006uc-PN; Wed, 06 Dec 2023 12:48:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-00DwvY-L8; Wed, 06 Dec 2023 12:48:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-00FR0v-CJ; Wed, 06 Dec 2023 12:48:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 067/115] pwm: iqs620a: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:21 +0100
Message-ID:  <ac1b04dad456bdcbf9e2db4d2ccd7650175e6beb.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4074; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=UGp3M07fISyM8vxAeSFh/mcOle0nEfqhEahYeTRHLHo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF7XiFKu+ilCCysonAwtTTvvrh37ZyrchsEbz 7TyHRD2Nt+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBe1wAKCRCPgPtYfRL+ Tt/hCACtjSDClcdYQd/nP2JPbH6YIBYKmBXv8/1jx/wP7Cg5oQUioAKVH14pURG5F89iri8hUrv gx8Ksm/R4CoZsIgURDcD2cgWkpdO2H5pYc6mmmNZYX+JcJTJIHeFgG7iuOHVkcQUk4Spt9eXjXS otBcN2geuUAhoUiZ03cMrc2yu8GirSvPKzwCI5SdA+rVSSsc8hDGx/pioj0uAw7UphNAUsfKge+ gwdpef3Wq8nF7rbaph7dHP4j3hAR1JPzYHzpdc34BBxABWNu2/OtIKVUvJpIywfum9sBLmSRtxL IIPwEO747duR3iZsw/xz4FHtLui93utIJCt/NN89Q/cn7R6M
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-iqs620a driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-iqs620a.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 378ab036edfe..f2d1ed8df3eb 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -34,12 +34,17 @@
 
 struct iqs620_pwm_private {
 	struct iqs62x_core *iqs62x;
-	struct pwm_chip chip;
+	struct device *dev;
 	struct notifier_block notifier;
 	struct mutex lock;
 	unsigned int duty_scale;
 };
 
+static inline struct iqs620_pwm_private *iqs620_pwm_from_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
 static int iqs620_pwm_init(struct iqs620_pwm_private *iqs620_pwm,
 			   unsigned int duty_scale)
 {
@@ -73,7 +78,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period < IQS620_PWM_PERIOD_NS)
 		return -EINVAL;
 
-	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
+	iqs620_pwm = iqs620_pwm_from_chip(chip);
 
 	/*
 	 * The duty cycle generated by the device is calculated as follows:
@@ -107,9 +112,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static int iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
-	struct iqs620_pwm_private *iqs620_pwm;
-
-	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
+	struct iqs620_pwm_private *iqs620_pwm = iqs620_pwm_from_chip(chip);
 
 	mutex_lock(&iqs620_pwm->lock);
 
@@ -155,7 +158,7 @@ static int iqs620_pwm_notifier(struct notifier_block *notifier,
 	mutex_unlock(&iqs620_pwm->lock);
 
 	if (ret) {
-		dev_err(iqs620_pwm->chip.dev,
+		dev_err(iqs620_pwm->dev,
 			"Failed to re-initialize device: %d\n", ret);
 		return NOTIFY_BAD;
 	}
@@ -170,28 +173,32 @@ static const struct pwm_ops iqs620_pwm_ops = {
 
 static void iqs620_pwm_notifier_unregister(void *context)
 {
-	struct iqs620_pwm_private *iqs620_pwm = context;
+	struct pwm_chip *chip = context;
+	struct iqs620_pwm_private *iqs620_pwm = iqs620_pwm_from_chip(chip);
 	int ret;
 
 	ret = blocking_notifier_chain_unregister(&iqs620_pwm->iqs62x->nh,
 						 &iqs620_pwm->notifier);
 	if (ret)
-		dev_err(iqs620_pwm->chip.dev,
+		dev_err(iqs620_pwm->dev,
 			"Failed to unregister notifier: %d\n", ret);
 }
 
 static int iqs620_pwm_probe(struct platform_device *pdev)
 {
 	struct iqs62x_core *iqs62x = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct iqs620_pwm_private *iqs620_pwm;
 	unsigned int val;
 	int ret;
 
-	iqs620_pwm = devm_kzalloc(&pdev->dev, sizeof(*iqs620_pwm), GFP_KERNEL);
-	if (!iqs620_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*iqs620_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	iqs620_pwm = iqs620_pwm_from_chip(chip);
 
 	iqs620_pwm->iqs62x = iqs62x;
+	iqs620_pwm->dev = &pdev->dev;
 
 	ret = regmap_read(iqs62x->regmap, IQS620_PWR_SETTINGS, &val);
 	if (ret)
@@ -205,9 +212,7 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 		iqs620_pwm->duty_scale = val + 1;
 	}
 
-	iqs620_pwm->chip.dev = &pdev->dev;
-	iqs620_pwm->chip.ops = &iqs620_pwm_ops;
-	iqs620_pwm->chip.npwm = 1;
+	chip->ops = &iqs620_pwm_ops;
 
 	mutex_init(&iqs620_pwm->lock);
 
@@ -221,11 +226,11 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 
 	ret = devm_add_action_or_reset(&pdev->dev,
 				       iqs620_pwm_notifier_unregister,
-				       iqs620_pwm);
+				       chip);
 	if (ret)
 		return ret;
 
-	ret = devm_pwmchip_add(&pdev->dev, &iqs620_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to add device: %d\n", ret);
 
-- 
2.42.0


