Return-Path: <linux-pwm+bounces-989-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F21C83C1D4
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D1D1C22BA8
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0645966;
	Thu, 25 Jan 2024 12:10:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C0145023
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184655; cv=none; b=Epdlx5cX4Is289HAoUXJ7yhDvqyAYjkGIWdKOLe25OpTJ/8uGMeXaN45KhkN3JuK4l5p2ajA5x5+vMZmhjMhionJG6yAqSQxw70SbvSmCdjoZbto/4yEwIyPT1M/WFBd4AbmpNJuCgyZyeEv6YqMfU/SDaQqXkW1SLe+iM/+agg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184655; c=relaxed/simple;
	bh=ub0WxYuNvfVeLqdF4qWEv1rpq9BZQti4qy+xj5yg8qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmPBFjx3uy78p5NAJES4HFcg6/Mkz3ppvOrkJPaZvsPp9bV66h4iFHOP/BbrrZD7TBlBx1De5M0EGqx8eZIL/BQFaEwevXcoa7/xkwvL7eJWAuHUfmNWQ6nKCHSw/kJ/tjfXa/Oun+HC1ZR5PxVqV0y0gO48WFbZ6Km/r5VFF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-0004KD-Fa; Thu, 25 Jan 2024 13:10:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-002HSF-TU; Thu, 25 Jan 2024 13:10:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-007n1n-2h;
	Thu, 25 Jan 2024 13:10:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 055/111] pwm: dwc: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:17 +0100
Message-ID:  <0705dd2b796e50e73959be1054b536f1ccc349d3.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4156; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ub0WxYuNvfVeLqdF4qWEv1rpq9BZQti4qy+xj5yg8qE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk96kbrruJUZGTkJoA9FUDXFnLvcWCrILaBqW a0vvy3WAxSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPegAKCRCPgPtYfRL+ TgVpB/4nReQNmG8PSGSCE/sFj0VMXGBR9tFqlnzH3Ffa0oT/8eHEzEQGgAPVVZ8sX8GRgBLsp7e Dicwup63VMOAB6INn+5Ux29Xrec0iYIbHrzh8u5+g0gBLxEJYeV6kkd+sHY9fqJk9+oHuna8ISs KwCm4qcLugVZkxuvrMYbtkMihfqvxZb65wJGWyaFLE2TJ1kMCNbHa8ThIoAQ8GacIh8G7auCTcW vn9u0Adytvxtxo3jiPQeKSQm0FWuz30H7jV5IWkkbtTT/zg5H3MMHiS/LzB8Fqf4JvNCn7IQORn xHhEFzeV7QksOk/ajq1iXG0eesKc6HOzMqSzbrUq1fn53BjX
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
2.43.0


