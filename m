Return-Path: <linux-pwm+bounces-1339-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F38A8545A5
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4381B228BC
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002118645;
	Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A77217565
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903268; cv=none; b=IySNKSjVc63g2lYHHp1CrYD6aXFmcXB/Tb8TIiAmSuSO9DQEvGXMidsOrNvFUTdBkrkARG/VSglopUqpx3BCtANUlQ88l9jF2tir/Qp+Vg7SxGmZuO4WV03aZuqG5m2OMw6sUBeplLVP1eotApZmGcPAJtflTHIRE4jVU/uSl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903268; c=relaxed/simple;
	bh=jrVyDZvg8gKYkS6j285BImE03F03juDv/ToT5nL9bKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOuAkh8BOa3RLhuBjp7s9F5TlrFpRVpdGf9AHUc78eccZX7ND8a1BMgTPcF1fSUo1i3ugJiMemqFeoKgHKDjHd3TF8PiMIxr31x9LQ5THbPHwfC8qws6THz15Qq4Q9uKXouZqZhNIENoEUAafTpRWlztzh4v7VDCH0GIQq1nUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-0004cO-H4; Wed, 14 Feb 2024 10:34:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-000fAV-RE; Wed, 14 Feb 2024 10:34:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-004Y1j-2T;
	Wed, 14 Feb 2024 10:34:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 032/164] pwm: dwc: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:31:19 +0100
Message-ID:  <008ce5ab84b8e3baa3e81ab6d36dbb0e4be5c319.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3418; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=jrVyDZvg8gKYkS6j285BImE03F03juDv/ToT5nL9bKU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhvvk3lIFhlItEgQYpEl+hiMrIc8kN0TbnrY jFmh2mQLJ2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIbwAKCRCPgPtYfRL+ Tnp1B/0eCf67zP00Vo66aHx3xIPbN6AWKJiqGyFZlPp7Qor91hpkAqzGQzKy46nlYQBTU6ITiIh AVbOK8wkWn3BvCi9wJd5+dJt8jwoQN4VMUx8bSAet1BbuGxnf1bzxQMHgwNUgPXtOhOjMx9HUeM U4I7rCHvlzuYzrHXDfRNInFlHJSfwcq1vLHTlOP6EGELmnS77j+BL5LyYThvd/ZedTQnGutkfto 1Imca/t3Jwr66DeKaWP+muaJ0o78NgzDfkWXXvANlHw5y9Z/Poeq+8Po1VlNJBn+Lm6nKCiWpXl 9rdqJMW5zEwHuUP4XH+5l+OuRJ/Nh4ZuWn7aBAMbDar6XEeC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct dwc_pwm. Use the pwm_chip as driver
data and return value of dwc_pwm_alloc() instead of the dwc_pwm to get
access to the pwm_chip in dwc_pwm_probe() and dwc_pwm_suspend() without
using dwc->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc-core.c | 16 +++++++++-------
 drivers/pwm/pwm-dwc.c      | 17 ++++++++++-------
 drivers/pwm/pwm-dwc.h      |  2 +-
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index ea63dd741f5c..ac7a0b2cb8b9 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -159,21 +159,23 @@ static const struct pwm_ops dwc_pwm_ops = {
 	.get_state = dwc_pwm_get_state,
 };
 
-struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+struct pwm_chip *dwc_pwm_alloc(struct device *dev)
 {
+	struct pwm_chip *chip;
 	struct dwc_pwm *dwc;
 
 	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
 	if (!dwc)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+	chip = &dwc->chip;
 
 	dwc->clk_ns = 10;
-	dwc->chip.dev = dev;
-	dwc->chip.ops = &dwc_pwm_ops;
-	dwc->chip.npwm = DWC_TIMERS_TOTAL;
+	chip->dev = dev;
+	chip->ops = &dwc_pwm_ops;
+	chip->npwm = DWC_TIMERS_TOTAL;
 
-	dev_set_drvdata(dev, dwc);
-	return dwc;
+	dev_set_drvdata(dev, chip);
+	return chip;
 }
 EXPORT_SYMBOL_GPL(dwc_pwm_alloc);
 
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 4929354f8cd9..72df11593793 100644
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
-		return -ENOMEM;
+	chip = dwc_pwm_alloc(dev);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
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
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 64795247c54c..432a3b4c81fd 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -57,4 +57,4 @@ static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)
 	writel(value, dwc->base + offset);
 }
 
-extern struct dwc_pwm *dwc_pwm_alloc(struct device *dev);
+extern struct pwm_chip *dwc_pwm_alloc(struct device *dev);
-- 
2.43.0


