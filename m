Return-Path: <linux-pwm+bounces-346-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9422806E8D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90AE1C20D4D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3F034540;
	Wed,  6 Dec 2023 11:48:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16776D41
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-0006kB-GD; Wed, 06 Dec 2023 12:48:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOE-00Dwuz-7a; Wed, 06 Dec 2023 12:48:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOD-00FR0G-V2; Wed, 06 Dec 2023 12:48:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 058/115] pwm: dwc: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:12 +0100
Message-ID:  <2224f2f85e6a5491cf74ff834cab4c91f3cf3a7a.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4156; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gudrQehSmv+FU7T+FeUV1788nfliO+7kyLX2fLvKeQg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6u2YAtJA29aLRp1tKbzJ9eTqUzIzLi3RbIV 0ELEcZTlcSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBergAKCRCPgPtYfRL+ Ti0yB/4thiMPZbNmWXHwFOm2vYFngxcgCreqhCS7XGv98DJyca4KDPNEPZ0KuaBHBy3XBrwPysU q81M4sPdEviDThjhDlYHKH+pp2z9Tn5JQdN2N6Gb3Df6kpusE3SpR6OkNH5B3wUDhKj65zZ9JDZ Y6dqiU0VvSEGKkKPMItjx6C6gYWpPGGLcH23JbtACstZuWQ7jXDoo4hJHJBLW/b0oJvNFlE4e7m VkfdLvOxM2EJoBgNO6kinDEVj/JCcUBEh/vRSh2Ol+BVQDCao8KN87cvUDtLCQ2ez9wKMXKUold e5KIQeV0zlmNvbXGtLFbwvPR+QZ2twOcV3pBiXI/aBfKCSiI
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

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
index 4929354f8cd9..1a20babb16fc 100644
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
 
@@ -74,13 +76,14 @@ static void dwc_pwm_remove(struct pci_dev *pci)
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
@@ -94,7 +97,8 @@ static int dwc_pwm_suspend(struct device *dev)
 static int dwc_pwm_resume(struct device *dev)
 {
 	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct pwm_chip *chip = pci_get_drvdata(pdev);
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 64795247c54c..83f4091031fc 100644
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
+       return pwmchip_get_drvdata(chip);
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


