Return-Path: <linux-pwm+bounces-1450-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2752854610
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAA628A936
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D33314F8C;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5851B814
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903291; cv=none; b=qczuKYeVEnY3naTvFPMyqxl7jTU/5zsj6Pyqkw81FHvzZKtV5AfdyZkYZ5/OulpdLrfdTsVAVIv/pvI0nE4+pTwMxav9XeDfoChuL5OoFdOicqNWvnJWFRy69qY2MBm7talzw0WH08BOm8CFKsVxnN+RIJgS601ka9LFSnmtf5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903291; c=relaxed/simple;
	bh=gzmpzVfqggGNfr+S+rO98BpLG4fSThwCnRBApLleERQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BN2KtYOE8dpBgUWg5NKpF8rhX6GcVRZ7zYBsGcv/zfuqXn/Sgpsl+UQnemwTCRrwxFngWP9EfXty1drDDLNc5MVCnXsYAF/p1I+Wg4HjZc77y9RLNwbzutVkkczeYHFl5Pi1CeB3umg8AKcgTQ1YpvKXyKP6Lo8qASymJNAWTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-00051u-Iz; Wed, 14 Feb 2024 10:34:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-000fCu-A1; Wed, 14 Feb 2024 10:34:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-004Y4J-0h;
	Wed, 14 Feb 2024 10:34:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pwm@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	kernel@pengutronix.de,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 067/164] pwm: lpss-*: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:54 +0100
Message-ID:  <b567ab5dd992e361eb884fa6c2cac11be9c7dde3.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6419; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gzmpzVfqggGNfr+S+rO98BpLG4fSThwCnRBApLleERQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiXO9vU/I4HWIXQf+QzW7hOkySXBCdgMGIf0 yD3H1Jv9kyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIlwAKCRCPgPtYfRL+ Ts0gCACYjl5guzFar8+s8qCX3/Xz+rU4xcwf2EJDvE32M8AlfM9BBb3rqDAiauEL+Xvg4tL2gaG uU2w3ZzvZsv7kKRMNe5SZPWn9zMCNBRy8F2NHUgFo1Py4mcc8pTnr510z7eL6WprvzOXISbhG5k Culmc9SVC5g4NDrAeNdKZJjiei/BDFY/Z2e5qvSwy87PVl0ELy3xLl8Vq2hBaHWwRTlxKoJlwH3 +/tZirlCe+nF+OvL4tq5AKuUw7jeXD1Q0PDOlnbeYW8qIP/4kNg5TbK6AZrgC0I2nYolmrVnpxC P3u1mHm5xuUEuMXcQ9tBjsORvIbpbRgtFEhCG2abF+8WYPr1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-lpc drivers to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pinctrl/intel/pinctrl-intel.c      |  6 +++---
 drivers/pwm/pwm-lpss-pci.c                 |  8 ++++----
 drivers/pwm/pwm-lpss-platform.c            |  8 ++++----
 drivers/pwm/pwm-lpss.c                     | 20 ++++++++++----------
 drivers/pwm/pwm-lpss.h                     |  1 -
 include/linux/platform_data/x86/pwm-lpss.h |  4 ++--
 6 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index d6f29e6faab7..89bd7ce6711a 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1492,7 +1492,7 @@ static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
 		.base_unit_bits = 22,
 		.bypass = true,
 	};
-	struct pwm_lpss_chip *pwm;
+	struct pwm_chip *chip;
 
 	if (!(community->features & PINCTRL_FEATURE_PWM))
 		return 0;
@@ -1500,8 +1500,8 @@ static int intel_pinctrl_probe_pwm(struct intel_pinctrl *pctrl,
 	if (!IS_REACHABLE(CONFIG_PWM_LPSS))
 		return 0;
 
-	pwm = devm_pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
-	return PTR_ERR_OR_ZERO(pwm);
+	chip = devm_pwm_lpss_probe(pctrl->dev, community->regs + PWMC, &info);
+	return PTR_ERR_OR_ZERO(chip);
 }
 
 int intel_pinctrl_probe(struct platform_device *pdev,
diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 34acfe99b74f..25045c229520 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -18,7 +18,7 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
 	const struct pwm_lpss_boardinfo *info;
-	struct pwm_lpss_chip *lpwm;
+	struct pwm_chip *chip;
 	int err;
 
 	err = pcim_enable_device(pdev);
@@ -30,9 +30,9 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 		return err;
 
 	info = (struct pwm_lpss_boardinfo *)id->driver_data;
-	lpwm = devm_pwm_lpss_probe(&pdev->dev, pcim_iomap_table(pdev)[0], info);
-	if (IS_ERR(lpwm))
-		return PTR_ERR(lpwm);
+	chip = devm_pwm_lpss_probe(&pdev->dev, pcim_iomap_table(pdev)[0], info);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_allow(&pdev->dev);
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 5f6ee300e342..dbc9f5b17bdc 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -20,7 +20,7 @@
 static int pwm_lpss_probe_platform(struct platform_device *pdev)
 {
 	const struct pwm_lpss_boardinfo *info;
-	struct pwm_lpss_chip *lpwm;
+	struct pwm_chip *chip;
 	void __iomem *base;
 
 	info = device_get_match_data(&pdev->dev);
@@ -31,9 +31,9 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	lpwm = devm_pwm_lpss_probe(&pdev->dev, base, info);
-	if (IS_ERR(lpwm))
-		return PTR_ERR(lpwm);
+	chip = devm_pwm_lpss_probe(&pdev->dev, base, info);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
 	/*
 	 * On Cherry Trail devices the GFX0._PS0 AML checks if the controller
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 394c768f5a5f..b79fd3405e15 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(pwm_lpss_tng_info);
 
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_lpss_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline u32 pwm_lpss_read(const struct pwm_device *pwm)
@@ -245,9 +245,10 @@ static const struct pwm_ops pwm_lpss_ops = {
 	.get_state = pwm_lpss_get_state,
 };
 
-struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
+struct pwm_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
 					  const struct pwm_lpss_boardinfo *info)
 {
+	struct pwm_chip *chip;
 	struct pwm_lpss_chip *lpwm;
 	unsigned long c;
 	int i, ret;
@@ -256,9 +257,10 @@ struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base
 	if (WARN_ON(info->npwm > LPSS_MAX_PWMS))
 		return ERR_PTR(-ENODEV);
 
-	lpwm = devm_kzalloc(dev, sizeof(*lpwm), GFP_KERNEL);
-	if (!lpwm)
+	chip = devm_pwmchip_alloc(dev, info->npwm, sizeof(*lpwm));
+	if (!chip)
 		return ERR_PTR(-ENOMEM);
+	lpwm = to_lpwm(chip);
 
 	lpwm->regs = base;
 	lpwm->info = info;
@@ -267,23 +269,21 @@ struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base
 	if (!c)
 		return ERR_PTR(-EINVAL);
 
-	lpwm->chip.dev = dev;
-	lpwm->chip.ops = &pwm_lpss_ops;
-	lpwm->chip.npwm = info->npwm;
+	chip->ops = &pwm_lpss_ops;
 
-	ret = devm_pwmchip_add(dev, &lpwm->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret) {
 		dev_err(dev, "failed to add PWM chip: %d\n", ret);
 		return ERR_PTR(ret);
 	}
 
 	for (i = 0; i < lpwm->info->npwm; i++) {
-		ctrl = pwm_lpss_read(&lpwm->chip.pwms[i]);
+		ctrl = pwm_lpss_read(&chip->pwms[i]);
 		if (ctrl & PWM_ENABLE)
 			pm_runtime_get(dev);
 	}
 
-	return lpwm;
+	return chip;
 }
 EXPORT_SYMBOL_GPL(devm_pwm_lpss_probe);
 
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index bf841250385f..b5267ab5193b 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -18,7 +18,6 @@
 #define LPSS_MAX_PWMS			4
 
 struct pwm_lpss_chip {
-	struct pwm_chip chip;
 	void __iomem *regs;
 	const struct pwm_lpss_boardinfo *info;
 };
diff --git a/include/linux/platform_data/x86/pwm-lpss.h b/include/linux/platform_data/x86/pwm-lpss.h
index c852fe24fe2a..752c06b47cc8 100644
--- a/include/linux/platform_data/x86/pwm-lpss.h
+++ b/include/linux/platform_data/x86/pwm-lpss.h
@@ -27,7 +27,7 @@ struct pwm_lpss_boardinfo {
 	bool other_devices_aml_touches_pwm_regs;
 };
 
-struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
-					  const struct pwm_lpss_boardinfo *info);
+struct pwm_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
+				     const struct pwm_lpss_boardinfo *info);
 
 #endif	/* __PLATFORM_DATA_X86_PWM_LPSS_H */
-- 
2.43.0


