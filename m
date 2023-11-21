Return-Path: <linux-pwm+bounces-75-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FD17F2F9B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5BE61C2165E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D355381D;
	Tue, 21 Nov 2023 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4B510E5
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAW-0005k5-84; Tue, 21 Nov 2023 14:52:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAS-00Ab06-RW; Tue, 21 Nov 2023 14:51:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAS-004xef-I9; Tue, 21 Nov 2023 14:51:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 059/108] pwm: imx-tpm: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:01 +0100
Message-ID: <20231121134901.208535-60-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2597; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2zAl5auADeQLR+xhMYx4N/RSv4mq3GETWHP3hp61S3s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWNWdTB4A07/W3uClT6ZyMpIrHv10Rqs6mRf TSf7MQ51uuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1jQAKCRCPgPtYfRL+ Ts6dB/4ub/XNMGaem7OawJUeUByYNXvYQrqXq0UPT0btwT1qsz4UZbotGLeLIYipKH6TzN//QT/ xjbAVYBjWD/gFGPIOUoyMKhmWfrMTaUI69sEL9rSUQUJCdfswY+nzpSspTsD3a4gX7WXOP8W2Du 0QHNUxfvCK9FvTKxPFMC3FFVWT2Nky8Dp3GXBTPv6t1TEDMS9XMSyHBGrun8xy8sB3AlGEorC63 ify4dqXrbMCVTK/n86u+yOxhBbpNQD0g9wdv1IU4AqqiQTswsRwT/0COD336kfel5SR3Fj4aQ2h gFeFAZwpBLk+xhSA0FRkKHz91OMypBoCqMOt1qBECC+Kj4ne
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
index 9fc290e647e1..ed8da73f371b 100644
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
+	return pwmchip_priv(chip);
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
+	val = readl(tpm->base + PWM_IMX_TPM_PARAM);
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
2.42.0


