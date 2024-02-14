Return-Path: <linux-pwm+bounces-1359-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 001988545AC
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94391F2E0C2
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0169F168AF;
	Wed, 14 Feb 2024 09:34:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8118B02
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903271; cv=none; b=ZXoVwxCve0jS94cGAUvWnnbhqoySVUyhUcs3/8/SVOCn7VsbPzPEQZDdkTeR7R2ENh4lPW4VIFeJho+iPPou0hI8rIVI9XLPtkwntq6wVWPOzWsRTJnBsG/an+FwyV+tUwmtSCOsrig/I5FMM/5Gvbx2UTgFoi1aWn81wDIDIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903271; c=relaxed/simple;
	bh=aV+8xYJnCvfIi2Ta/CNMW2gzEdLgM6XRsj1xOw9beLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2wO8JXuzmeOS684rLSOFAox/RtEeHHoZm64Fs0onGNHDNKTqHgL6xuQ8PlBkZn6IJgtyOHFKMMp8867UjaKi99lxjSoyZDFcxkXjXg8QbR3eKOTEPAiXNe5148RRUybJW6g+pgfYlEZInw9Wzhk6kypyo3bTHutbI7VhFqcQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-0004lg-8Z; Wed, 14 Feb 2024 10:34:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-000fBx-L8; Wed, 14 Feb 2024 10:34:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-004Y33-1q;
	Wed, 14 Feb 2024 10:34:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 050/164] pwm: imx-tpm: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:37 +0100
Message-ID:  <5de5d53295fa445d58a79f83421dd3406166c3c6.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2599; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=aV+8xYJnCvfIi2Ta/CNMW2gzEdLgM6XRsj1xOw9beLQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiE/gw/YmlmFDigqQyu8T9Vq/opOc0QDk9gQ 4+iAIXSPJKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIhAAKCRCPgPtYfRL+ TmvqB/0cP4uicdQzdlVh23o8AAcr/9AMQbQ9cCTPO6hAoWmajR+nMwXrXsSChYGmb+6TRjoUiPd +meksPH5p6+LCH+RyqHXRArVuDlfZBN200wJIrrJQr5Ho3wTIYT1zUBI1GD5QRG5piuytRnb9We AzxPNm0rSR5Toog9IWoqvphMK6zjQV3PWj9EBaN5elnYIDKPhoXuzEv9KHq3l8vJHXkzoH6jhvH 0mN2S3GhqmujbO4RPAQPfVcT1rAiIl7/wdnDXnFOJOMNrey98QumZ5YiQ3Qrzh+GbMZ69U2iLFs AaIumHHJZnMAO7wJXWr3AmbQVJGRyRvYWLBNJhFuz67Fimkq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-tmp driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx-tpm.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 9fc290e647e1..b04b974c5f32 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -57,7 +57,6 @@
 #define PWM_IMX_TPM_MOD_MOD	GENMASK(PWM_IMX_TPM_MOD_WIDTH - 1, 0)
 
 struct imx_tpm_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct mutex lock;
@@ -75,7 +74,7 @@ struct imx_tpm_pwm_param {
 static inline struct imx_tpm_pwm_chip *
 to_imx_tpm_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct imx_tpm_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /*
@@ -336,35 +335,40 @@ static const struct pwm_ops imx_tpm_pwm_ops = {
 
 static int pwm_imx_tpm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct imx_tpm_pwm_chip *tpm;
+	void __iomem *base;
 	int ret;
+	unsigned int npwm;
 	u32 val;
 
-	tpm = devm_kzalloc(&pdev->dev, sizeof(*tpm), GFP_KERNEL);
-	if (!tpm)
-		return -ENOMEM;
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	/* get number of channels */
+	val = readl(base + PWM_IMX_TPM_PARAM);
+	npwm = FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);
+
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*tpm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	tpm = to_imx_tpm_pwm_chip(chip);
 
 	platform_set_drvdata(pdev, tpm);
 
-	tpm->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(tpm->base))
-		return PTR_ERR(tpm->base);
+	tpm->base = base;
 
 	tpm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(tpm->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(tpm->clk),
 				     "failed to get PWM clock\n");
 
-	tpm->chip.dev = &pdev->dev;
-	tpm->chip.ops = &imx_tpm_pwm_ops;
-
-	/* get number of channels */
-	val = readl(tpm->base + PWM_IMX_TPM_PARAM);
-	tpm->chip.npwm = FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);
+	chip->ops = &imx_tpm_pwm_ops;
 
 	mutex_init(&tpm->lock);
 
-	ret = devm_pwmchip_add(&pdev->dev, &tpm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.43.0


