Return-Path: <linux-pwm+bounces-364-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052C9806EA6
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6ACB20E09
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDD3358B4;
	Wed,  6 Dec 2023 11:48:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5CFD5F
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:39 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-0006rs-Gd; Wed, 06 Dec 2023 12:48:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-00DwvO-Bq; Wed, 06 Dec 2023 12:48:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOF-00FR0n-2u; Wed, 06 Dec 2023 12:48:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 065/115] pwm: imx-tpm: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:19 +0100
Message-ID:  <54815ba81395492a7098755951d0ce7616a7f4fe.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2604; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=IqWcFhKaTv9UNQgLZexIqkabCeqEQIrEyOSq8yEUOcA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF7PwkpMqA0J3kT10LjOULI/mZrq/AFkwTuIn yRRWqElUo2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBezwAKCRCPgPtYfRL+ TmjgB/9AIi1lxWWg1vxRKkmysRtJ2SOe80CJSTQIJgYqOzeU/8DR8Gj/WPsRvMY+1CilGjp+pq/ yMgGRvrQcnZsaClTRRA4j+Myxl/r0Fu+MYe2TOnabBXisNyMbEc6ww+sERKAFlJNzN5ITlVnqoj 3kGLqbxiJdegqRhe1yoMY7vGve6So6V7wPeyI9MRQvO4DFZSvkxcUnSMokwAKcGpGHl7YPv39vA aT1NzPVNkN8ZOUoKx5I30wSvuDn63gZQRGzdL4+yEKP58UpfaqJXPnb/9qswGoT2Oy3AYGgWgyn +1ELC5IXPZBuOYB8bvKzAIGIEFIiiedqubshi4DKNF7SmbIl
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
index 9fc290e647e1..04f8ab315748 100644
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


