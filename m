Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAEF7C72D7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379597AbjJLQb0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379629AbjJLQbJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:09 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9410FA9
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaV-0005KE-W6; Thu, 12 Oct 2023 18:31:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-001C8a-Ij; Thu, 12 Oct 2023 18:31:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-00F5Pg-9X; Thu, 12 Oct 2023 18:31:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 053/109] pwm: dwc: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:21 +0200
Message-ID: <20231012162827.1002444-164-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4149; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NIrd/vwsqAJrALwLcLxPpJ+KPOw0YXlNsFB7qUGrrbA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7qGXH92gVh9ZuxYIodZ33E4SJEAhpeEyqrY EgAHwOc/kmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge6gAKCRCPgPtYfRL+ Tm0kB/9QKNtvreGG5SeaHNz8xqfDsSaaV7ImxcRo6+sn48fRP4lX3PGV0F5Ff2K4xzC2wJYJoF9 JjTlnuwhUKxdQdf47nkW8KD3+mc52QuO35NRGtUl7meLHwvVT+GWbTpx3peSNU65PXN/XyviV9S 7Yhn7S6jwdTM6S5L5fENxlSQv+95K4dz3QsrtPNEt30U4P2v5fcpa5FFGS3bZJhK/KbPMbfZ88d IJaIZG73qOZ8V9cV8zqkx6bXtFDZqt7orhamIZgMK+uClycgu2Pri5hJLkBXBY+TQrcp60LPuQB iMW9EITz2qCz6GEO+p8i5vxXhuJYiI7h7B/T+RPFIWfSxvh8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-dwc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc-core.c | 17 +++++++++--------
 drivers/pwm/pwm-dwc.c      | 18 +++++++++++-------
 drivers/pwm/pwm-dwc.h      |  9 ++++++---
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index 146e40ccc4d3..761c215ce5ee 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -159,21 +159,22 @@ static const struct pwm_ops dwc_pwm_ops = {
 	.get_state = dwc_pwm_get_state,
 };
 
-struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+struct pwm_chip *dwc_pwm_alloc(struct device *dev)
 {
+	struct pwm_chip *chip;
 	struct dwc_pwm *dwc;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
-	if (!dwc)
+	chip = devm_pwmchip_alloc(dev, DWC_TIMERS_TOTAL, sizeof(struct dwc_pwm));
+	if (!chip)
 		return NULL;
+	dwc = to_dwc_pwm(chip);
 
 	dwc->clk_ns = 10;
-	dwc->chip.dev = dev;
-	dwc->chip.ops = &dwc_pwm_ops;
-	dwc->chip.npwm = DWC_TIMERS_TOTAL;
 
-	dev_set_drvdata(dev, dwc);
-	return dwc;
+	chip->ops = &dwc_pwm_ops;
+
+	dev_set_drvdata(dev, chip);
+	return chip;
 }
 EXPORT_SYMBOL_GPL(dwc_pwm_alloc);
 
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index bd9cadb497d7..8be703c4fb96 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -28,12 +28,14 @@
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	struct device *dev = &pci->dev;
+	struct pwm_chip *chip;
 	struct dwc_pwm *dwc;
 	int ret;
 
-	dwc = dwc_pwm_alloc(dev);
-	if (!dwc)
+	chip = dwc_pwm_alloc(dev);
+	if (!chip)
 		return -ENOMEM;
+	dwc = to_dwc_pwm(chip);
 
 	ret = pcim_enable_device(pci);
 	if (ret) {
@@ -55,7 +57,7 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	ret = devm_pwmchip_add(dev, &dwc->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret)
 		return ret;
 
@@ -75,13 +77,14 @@ static void dwc_pwm_remove(struct pci_dev *pci)
 static int dwc_pwm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct pwm_chip *chip = pci_get_drvdata(pdev);
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-		if (dwc->chip.pwms[i].state.enabled) {
+		if (chip->pwms[i].state.enabled) {
 			dev_err(dev, "PWM %u in use by consumer (%s)\n",
-				i, dwc->chip.pwms[i].label);
+				i, chip->pwms[i].label);
 			return -EBUSY;
 		}
 		dwc->ctx[i].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
@@ -95,7 +98,8 @@ static int dwc_pwm_suspend(struct device *dev)
 static int dwc_pwm_resume(struct device *dev)
 {
 	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct pwm_chip *chip = pci_get_drvdata(pdev);
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 64795247c54c..c9e581067997 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -40,12 +40,15 @@ struct dwc_pwm_ctx {
 };
 
 struct dwc_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	unsigned int clk_ns;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
-#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
+
+static inline struct dwc_pwm *to_dwc_pwm(struct pwm_chip *chip)
+{
+       return pwmchip_priv(chip);
+}
 
 static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
 {
@@ -57,4 +60,4 @@ static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)
 	writel(value, dwc->base + offset);
 }
 
-extern struct dwc_pwm *dwc_pwm_alloc(struct device *dev);
+extern struct pwm_chip *dwc_pwm_alloc(struct device *dev);
-- 
2.42.0

