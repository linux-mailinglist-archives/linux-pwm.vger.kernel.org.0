Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9633565F7
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 10:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244446AbhDGICv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 04:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244593AbhDGICY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 04:02:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FBBC06174A
        for <linux-pwm@vger.kernel.org>; Wed,  7 Apr 2021 01:02:07 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU38X-0002Ji-Gm; Wed, 07 Apr 2021 10:02:05 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lU38W-0001yI-Fb; Wed, 07 Apr 2021 10:02:04 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] pwm: lpss: Simplify using devm_pwmchip_add
Date:   Wed,  7 Apr 2021 10:01:55 +0200
Message-Id: <20210407080155.55004-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210407080155.55004-1-u.kleine-koenig@pengutronix.de>
References: <20210407080155.55004-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss-pci.c      | 4 ----
 drivers/pwm/pwm-lpss-platform.c | 4 +---
 drivers/pwm/pwm-lpss.c          | 8 +-------
 drivers/pwm/pwm-lpss.h          | 1 -
 4 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index cf749ea0de9f..c893ec3d2fb4 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -69,12 +69,8 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 
 static void pwm_lpss_remove_pci(struct pci_dev *pdev)
 {
-	struct pwm_lpss_chip *lpwm = pci_get_drvdata(pdev);
-
 	pm_runtime_forbid(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
-
-	pwm_lpss_remove(lpwm);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 986786be1e49..928570430cef 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -85,10 +85,8 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 
 static int pwm_lpss_remove_platform(struct platform_device *pdev)
 {
-	struct pwm_lpss_chip *lpwm = platform_get_drvdata(pdev);
-
 	pm_runtime_disable(&pdev->dev);
-	return pwm_lpss_remove(lpwm);
+	return 0;
 }
 
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index c81cb0ef984a..b73ae5542d93 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -237,7 +237,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 	lpwm->chip.base = -1;
 	lpwm->chip.npwm = info->npwm;
 
-	ret = pwmchip_add(&lpwm->chip);
+	ret = devm_pwmchip_add(dev, &lpwm->chip);
 	if (ret) {
 		dev_err(dev, "failed to add PWM chip: %d\n", ret);
 		return ERR_PTR(ret);
@@ -253,12 +253,6 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 }
 EXPORT_SYMBOL_GPL(pwm_lpss_probe);
 
-int pwm_lpss_remove(struct pwm_lpss_chip *lpwm)
-{
-	return pwmchip_remove(&lpwm->chip);
-}
-EXPORT_SYMBOL_GPL(pwm_lpss_remove);
-
 MODULE_DESCRIPTION("PWM driver for Intel LPSS");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 70db7e389d66..8b3476f25e06 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -35,6 +35,5 @@ struct pwm_lpss_boardinfo {
 
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 				     const struct pwm_lpss_boardinfo *info);
-int pwm_lpss_remove(struct pwm_lpss_chip *lpwm);
 
 #endif	/* __PWM_LPSS_H */
-- 
2.30.2

