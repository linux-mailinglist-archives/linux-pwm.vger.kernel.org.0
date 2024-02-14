Return-Path: <linux-pwm+bounces-1346-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32DA854599
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1223C1C260AD
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DC618E06;
	Wed, 14 Feb 2024 09:34:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDC618038
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903269; cv=none; b=ILaKSN2xcrLK00EUpQ7JhIia1CWrpspAPB9LZ8xkh6E+c6lx5q67X8QLI6eAzIka7n5NKtE8PSBZwR0ktRFer2yPuh3kt6mZU3COks8ZThoZwYpS/HPPGjuvYSmF0hiG1HD0tDQdduebscM7B2sbeVckTD/+hRgTOoMyF0e5c5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903269; c=relaxed/simple;
	bh=X/4UcDo56ez7kU36FULCetCXHpDbQL7EYdMum+t/PhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaTp9VwAzQI6ZYYfiGs2dxQqcMrWmqf7hw+hT8pYXmeg2oWg13dLKzRoplrzkSJ/UzV6ndTrnVgl0t9t2LzCPcwbERp0ulbZozoY1dcboG6q62mqZ8pXqDspxGsegS291JXRYTTvcahUMYDEpW1q3P+ktF93bwVxeTHeCwanXgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-0004bt-IS; Wed, 14 Feb 2024 10:34:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-000fAI-MN; Wed, 14 Feb 2024 10:34:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-004Y1f-1z;
	Wed, 14 Feb 2024 10:34:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Benson Leung <bleung@chromium.org>,
	linux-pwm@vger.kernel.org
Cc: Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	kernel@pengutronix.de,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v6 031/164] pwm: cros-ec: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:18 +0100
Message-ID:  <b0afe9e25340f0a274ff3806687cf37a6cc31557.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2989; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=X/4UcDo56ez7kU36FULCetCXHpDbQL7EYdMum+t/PhY=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHXlL38yaqJ1SsVay8riusvIRk56nUzPl0iyjhfZ2x XTebl/RyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBE1jiz/49VLv5aO3O65TvO C7lq7aef1lSU7OV7WcU2d5OOuKJk549dv0IK7uwJ25z3IL2g4erzN3pOMgEH3O6sjNz/8NPv3PP HghPtQ7hdqo3O/qveuKI3lKWO7Suz3/wsbs6FLgUy02ZbRUUq/cp49a4j0dDEUeb/mr1PH/ffPL 95W9JfvuCc5Y8VfL9kfLjh+SmqsibckSmCo+lb9M252dPfXjE93CQ9adq7niVOLIW+lq39oW1+R gaPjbau61qW62CsvrmCv+DKOrdYOxNFucADH/+5GhnGrvgvOM9rxdeAyPnlYsUCZ88o7NHvbAi+ 16U/u8U+YlfBfbtFNS923Cq8qtgY6tBlbrpdfq7bgkkHAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-cros-ec driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.
The probe function had to be changed a bit because the number of PWMs
must be determined before allocation of the pwm_chip and its private
data now.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-cros-ec.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 968e300e9f06..606ccfdaf4cc 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -19,13 +19,11 @@
  * struct cros_ec_pwm_device - Driver data for EC PWM
  *
  * @ec: Pointer to EC device
- * @chip: PWM controller chip
  * @use_pwm_type: Use PWM types instead of generic channels
  * @channel: array with per-channel data
  */
 struct cros_ec_pwm_device {
 	struct cros_ec_device *ec;
-	struct pwm_chip chip;
 	bool use_pwm_type;
 	struct cros_ec_pwm *channel;
 };
@@ -40,7 +38,7 @@ struct cros_ec_pwm {
 
 static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct cros_ec_pwm_device, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int cros_ec_dt_type_to_pwm_type(u8 dt_index, u8 *pwm_type)
@@ -264,34 +262,35 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct cros_ec_pwm_device *ec_pwm;
 	struct pwm_chip *chip;
+	bool use_pwm_type = false;
+	unsigned int npwm;
 	int ret;
 
 	if (!ec)
 		return dev_err_probe(dev, -EINVAL, "no parent EC device\n");
 
-	ec_pwm = devm_kzalloc(dev, sizeof(*ec_pwm), GFP_KERNEL);
-	if (!ec_pwm)
-		return -ENOMEM;
-	chip = &ec_pwm->chip;
-	ec_pwm->ec = ec;
-
-	if (of_device_is_compatible(np, "google,cros-ec-pwm-type"))
-		ec_pwm->use_pwm_type = true;
-
-	/* PWM chip */
-	chip->dev = dev;
-	chip->ops = &cros_ec_pwm_ops;
-	chip->of_xlate = cros_ec_pwm_xlate;
-
-	if (ec_pwm->use_pwm_type) {
-		chip->npwm = CROS_EC_PWM_DT_COUNT;
+	if (of_device_is_compatible(np, "google,cros-ec-pwm-type")) {
+		use_pwm_type = true;
+		npwm = CROS_EC_PWM_DT_COUNT;
 	} else {
 		ret = cros_ec_num_pwms(ec);
 		if (ret < 0)
 			return dev_err_probe(dev, ret, "Couldn't find PWMs\n");
-		chip->npwm = ret;
+		npwm = ret;
 	}
 
+	chip = devm_pwmchip_alloc(dev, npwm, sizeof(*ec_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	ec_pwm = pwm_to_cros_ec_pwm(chip);
+	ec_pwm->use_pwm_type = use_pwm_type;
+	ec_pwm->ec = ec;
+
+	/* PWM chip */
+	chip->ops = &cros_ec_pwm_ops;
+	chip->of_xlate = cros_ec_pwm_xlate;
+
 	ec_pwm->channel = devm_kcalloc(dev, chip->npwm, sizeof(*ec_pwm->channel),
 					GFP_KERNEL);
 	if (!ec_pwm->channel)
-- 
2.43.0


