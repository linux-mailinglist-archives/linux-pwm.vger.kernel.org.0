Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02A774692
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjHHS6w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjHHS6g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330B75851
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN5-0007Ap-4c; Tue, 08 Aug 2023 19:19:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00225G-Bb; Tue, 08 Aug 2023 19:19:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN2-00BTC9-20; Tue, 08 Aug 2023 19:19:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 032/101] pwm: lpss-*: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:22 +0200
Message-Id: <20230808171931.944154-33-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5601; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8weEtYs6n4O6WXl9Z2dwQUMxePRFSULOJbCZbLHehyo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njUgwTKfg3jKwOp74f8fwlNfZE7oTcW28lak QX2Ne6pXRaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ41AAKCRCPgPtYfRL+ Tto+CACcKIcF691Vi5XVrxy1Z5QaaJKwnxb4C++deNRZ2Iw2tUYi/m6Y4Hl739/6qm1tfuiv/IW wR3Np0R12CkMQNUrY56QpgEmgLkzURWyCjfyh2QwX8h6W54k7pVFtu347a3BVFCoWouTr4wwoWH ysuxTjAk16XpeRBGsatk9IN1tkSn1izavQ89eleCddp3yf06OBN7LznvzDGdOFG7ZugZy74Xtw6 sqv4/D3q36C9S+Z8ixh2SHM3baKM9SawMJd2LYBGIxpUqaOzFwUtvWT/KGeknuFs1lAHs5whKp3 iIoTAQ3Uuru9JTU0MmJtalTrO20iTiabJv9BqnoG3JWe3/zk
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

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
index a6ea3ce7e019..13087203d05a 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(pwm_lpss_tng_info);
 
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_lpss_chip, chip);
+	return pwmchip_priv(chip);
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
2.40.1

