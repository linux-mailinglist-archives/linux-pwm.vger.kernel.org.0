Return-Path: <linux-pwm+bounces-1022-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2FD83C20D
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26A6CB222FB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B17E4439A;
	Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DB7376E1
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184661; cv=none; b=scNofjDobvT5dXggSsfZz2e1GT17Sna8OXxFgXtgnp0zIc0iUvcq/ZpD0K2G8fuTndoyg8Z+iM3bhNaUdQhI7yXQT/MnKA20ure69ay0CZMI1T8PJjl9iZngoQ6+/c+1kDXHf8j/4NvD5uctozdApkRrlpFhuqNM6gMCzhKjDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184661; c=relaxed/simple;
	bh=KXMRZnPMpyetSzcEGj7wsuZDM+TsE68XGGw5zlR4WEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7Yfgw1C0EyP3U8S7sORSuaWMGQ8tn1cwZat5niv+RWJGmuNBuQyXmZ61Z1pkg56Mwyp+ZFyHStyEWT6wTPJxJ0xKAgJyCXEh2QeyrQvlV8/0XlAysg98ZtRgo8cZeSI6X+QTYRoI/JpQPo9aSKGdEkdZqZ+I8T5XQgmEO5JC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-0004QC-6K; Thu, 25 Jan 2024 13:10:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-002HTF-S2; Thu, 25 Jan 2024 13:10:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-007n2q-2X;
	Thu, 25 Jan 2024 13:10:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Hans de Goede <hdegoede@redhat.com>,
	=?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 070/111] pwm: lpss-*: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:32 +0100
Message-ID:  <bc53a67d67a2e102406f5378f159130c95fc649a.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5608; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=KXMRZnPMpyetSzcEGj7wsuZDM+TsE68XGGw5zlR4WEk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+MMiRVJrJctVItHQ5yfCPCroBdTQpG8/hfK SIqx7ehdyqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPjAAKCRCPgPtYfRL+ Tm/bCACMW1HA4Eefm1nFUk4Lw7EwD7QMLUksossyYUR4FYia99hW9yxIj5rvz2Rq4TBoJYW3SwT eVXzaR+k666ZoqvZcih2aGOCQxlTHB1hf6G6Ptvg27thxRxvfFMkD4jPTm0KuBVNLbi4+pGg76S G1QJ4fmPI8cxlFlQ/0IiwP+thyv4GH5S7cLwg2sOOY2rB+MNy/NLiJ78JL6z4g9t1FINewmYmEy s+qy6Zosh78xdVhoD0IuEE4FrhwnIynM1aEZ8Y4vajmDPp+N1w9QneLX3PciWxTynWvw3Pgt8os 0OA1mf3u2RLfOWR03xLNAFxSciQdsk1s9kPUUJfLi8JVvN1b
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
 drivers/pwm/pwm-lpss-pci.c                 | 10 +++++-----
 drivers/pwm/pwm-lpss-platform.c            | 10 +++++-----
 drivers/pwm/pwm-lpss.c                     | 20 ++++++++++----------
 drivers/pwm/pwm-lpss.h                     |  1 -
 include/linux/platform_data/x86/pwm-lpss.h |  4 ++--
 5 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index b4134bee2863..abaeac0e3226 100644
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
@@ -30,11 +30,11 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 		return err;
 
 	info = (struct pwm_lpss_boardinfo *)id->driver_data;
-	lpwm = devm_pwm_lpss_probe(&pdev->dev, pcim_iomap_table(pdev)[0], info);
-	if (IS_ERR(lpwm))
-		return PTR_ERR(lpwm);
+	chip = devm_pwm_lpss_probe(&pdev->dev, pcim_iomap_table(pdev)[0], info);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	pci_set_drvdata(pdev, lpwm);
+	pci_set_drvdata(pdev, chip);
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_allow(&pdev->dev);
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 319809aac2c4..90aeafa02a3b 100644
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
@@ -31,11 +31,11 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	lpwm = devm_pwm_lpss_probe(&pdev->dev, base, info);
-	if (IS_ERR(lpwm))
-		return PTR_ERR(lpwm);
+	chip = devm_pwm_lpss_probe(&pdev->dev, base, info);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	platform_set_drvdata(pdev, lpwm);
+	platform_set_drvdata(pdev, chip);
 
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


