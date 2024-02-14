Return-Path: <linux-pwm+bounces-1413-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B18545E2
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302BF1C270F9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6A6199A1;
	Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EFA18E2F
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903284; cv=none; b=PlcDXjyXRQAak5gBZadfw6GZmEF3IH4a/tXJ9wM1DTNnMj7DmVk0zV7PrNiMTNDsHX8RGeNZN/tPj8nVAi0/HjmTyzUS4eR1O1zTlJTB/VFNlSDowxEvGrJ3hfoJ5F6AOcCiPgyVysecDUDin/u5oqyCUngUMEHqpjmLcLUSARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903284; c=relaxed/simple;
	bh=TLX1fzaB+PggD9g+jvHf8+ubH/FK4HbNYlXqdFKLuls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1lb8etUA8rXj+3STHOTMRMaiIVRcP+C51yd6g31xb8z5kTPlhcBBNS2LMyXVpkGWd7FzVXkWcmvukdvuebPR8H/1XvK/22NFIY7aV8tpRfFj+cCGiIceAdzFd68PLfiF7/bi23wwgVvqOZudMsecDjajIv+cQ870O3B7GP4FmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-0005hg-IN; Wed, 14 Feb 2024 10:34:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-000fFd-3B; Wed, 14 Feb 2024 10:34:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-004Y7N-05;
	Wed, 14 Feb 2024 10:34:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 112/164] pwm: sti: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:39 +0100
Message-ID:  <da6fbb5e98e988400e037b0d2ac0c1749822d702.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3592; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=TLX1fzaB+PggD9g+jvHf8+ubH/FK4HbNYlXqdFKLuls=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjLThDSiXLFmXu7KMqYJkhEEO+LcbuFD6ZCQ ktS7e6sc6aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIywAKCRCPgPtYfRL+ ToGMB/9jmLY90/m6Zegi4ZzBQcorhmVCIWg0CUE73r8c8j7Kp3knF8/hsBIxjMTnE9Yy1e+DI22 JExMFtOs58fqC9aSHags/ExnFUKtpPymokNcYVtwTiRcsZcKv8FhbJuapAOFFVQtreHyPhoE3yq Deo0nkWz8Vk4svT5BOZYHSeAd3HyIq/6S9h+Kz/ArLIeuAu5ivRkdw+6r6QcaNXra8Xgf4iJiqF v7Vc5l9TrG3lr6/HagiY3/Uv0PVKaK0vHIjKyRsvVcYxnIy6LGYh01sHAhiYhfN1QAopZpNt6fN FqXyNtSmVymQAj2O+hv/6GEIJ4j0MD/plPuaOq+Ot2m6ji+5
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sti driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 50 +++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 826eb547cc96..39d80da0e14a 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -94,7 +94,6 @@ struct sti_pwm_chip {
 	struct regmap_field *pwm_cpt_en;
 	struct regmap_field *pwm_cpt_int_en;
 	struct regmap_field *pwm_cpt_int_stat;
-	struct pwm_chip chip;
 	struct pwm_device *cur;
 	unsigned long configured;
 	unsigned int en_count;
@@ -114,7 +113,7 @@ static const struct reg_field sti_pwm_regfields[MAX_REGFIELDS] = {
 
 static inline struct sti_pwm_chip *to_sti_pwmchip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sti_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /*
@@ -507,23 +506,7 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 {
 	struct device *dev = pc->dev;
 	const struct reg_field *reg_fields;
-	struct device_node *np = dev->of_node;
 	struct sti_pwm_compat_data *cdata = pc->cdata;
-	u32 num_devs;
-	int ret;
-
-	ret = of_property_read_u32(np, "st,pwm-num-chan", &num_devs);
-	if (!ret)
-		cdata->pwm_num_devs = num_devs;
-
-	ret = of_property_read_u32(np, "st,capture-num-chan", &num_devs);
-	if (!ret)
-		cdata->cpt_num_devs = num_devs;
-
-	if (!cdata->pwm_num_devs && !cdata->cpt_num_devs) {
-		dev_err(dev, "No channels configured\n");
-		return -EINVAL;
-	}
 
 	reg_fields = cdata->reg_fields;
 
@@ -569,16 +552,33 @@ static const struct regmap_config sti_pwm_regmap_config = {
 static int sti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	u32 num_devs;
+	unsigned int pwm_num_devs = 0;
+	unsigned int cpt_num_devs = 0;
 	struct sti_pwm_compat_data *cdata;
 	struct pwm_chip *chip;
 	struct sti_pwm_chip *pc;
 	unsigned int i;
 	int irq, ret;
 
-	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
-	chip = &pc->chip;
+	ret = of_property_read_u32(np, "st,pwm-num-chan", &num_devs);
+	if (!ret)
+		pwm_num_devs = num_devs;
+
+	ret = of_property_read_u32(np, "st,capture-num-chan", &num_devs);
+	if (!ret)
+		cpt_num_devs = num_devs;
+
+	if (!pwm_num_devs && !cpt_num_devs) {
+		dev_err(dev, "No channels configured\n");
+		return -EINVAL;
+	}
+
+	chip = devm_pwmchip_alloc(dev, max(pwm_num_devs, cpt_num_devs), sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_sti_pwmchip(chip);
 
 	cdata = devm_kzalloc(dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
@@ -611,8 +611,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	cdata->reg_fields = sti_pwm_regfields;
 	cdata->max_prescale = 0xff;
 	cdata->max_pwm_cnt = 255;
-	cdata->pwm_num_devs = 0;
-	cdata->cpt_num_devs = 0;
+	cdata->pwm_num_devs = pwm_num_devs;
+	cdata->cpt_num_devs = cpt_num_devs;
 
 	pc->cdata = cdata;
 	pc->dev = dev;
@@ -655,9 +655,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
-	chip->dev = dev;
 	chip->ops = &sti_pwm_ops;
-	chip->npwm = max(cdata->pwm_num_devs, cdata->cpt_num_devs);
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
-- 
2.43.0


