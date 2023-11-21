Return-Path: <linux-pwm+bounces-82-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE487F2FA8
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B67C281CB4
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8725380C;
	Tue, 21 Nov 2023 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313EE10FB
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAY-00063l-Vq; Tue, 21 Nov 2023 14:52:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAV-00Ab0r-PU; Tue, 21 Nov 2023 14:51:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAV-004xff-GH; Tue, 21 Nov 2023 14:51:59 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 072/108] pwm: mxs: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:14 +0100
Message-ID: <20231121134901.208535-73-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2580; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pjAx0J8kLJ1PZzC7JsCtWxKBVn2eyCVdftzhlgIGlbo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWcf0zfJsiVoNvGwaUbXxiRexrMexLm4/9J1 li+/1p/9fOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1nAAKCRCPgPtYfRL+ To46CACUSxboH8pMBjIrN+XM8aJzkf9vK3XxuyXoyhoIN2pDNgtfY8AGPqu/nfQGJ9qpJzhKgvM TJ8ItPjJhx+hxtgoGLKGF4Yl98g45TfjC6gCXnWu9a3JFA16ARDR+AQPXs64rXvqaxrtEQeqpQk xP7vflxyIW4jiGX0/Vp9RxjsO+SxJ6hnytZQQgezc8vbZajRIbGZY505a3H0Reqero5hbHJF+Oh FgRZA6NrU+tHOogBqi/K5zz8IqhVuyfWLszSH69zfaL95cgy4u2veBztNvaDoFLcIgLLekQkViz SZ02yTmia6OJaMJMJ7N5kThhddMoqyctfuiWv1vgx1QXduHn
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-mxs driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mxs.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 1b5e787d78f1..7c05b22bc7c9 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -37,12 +37,14 @@ static const u8 cdiv_shift[PERIOD_CDIV_MAX] = {
 };
 
 struct mxs_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 };
 
-#define to_mxs_pwm_chip(_chip) container_of(_chip, struct mxs_pwm_chip, chip)
+static inline struct mxs_pwm_chip *to_mxs_pwm_chip(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
@@ -120,12 +122,21 @@ static const struct pwm_ops mxs_pwm_ops = {
 static int mxs_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pwm_chip *chip;
 	struct mxs_pwm_chip *mxs;
+	u32 npwm;
 	int ret;
 
-	mxs = devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
-	if (!mxs)
-		return -ENOMEM;
+	ret = of_property_read_u32(np, "fsl,pwm-number", &npwm);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
+		return ret;
+	}
+
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*mxs));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mxs = to_mxs_pwm_chip(chip);
 
 	mxs->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mxs->base))
@@ -135,21 +146,14 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(mxs->clk))
 		return PTR_ERR(mxs->clk);
 
-	mxs->chip.dev = &pdev->dev;
-	mxs->chip.ops = &mxs_pwm_ops;
-
-	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
-		return ret;
-	}
+	chip->ops = &mxs_pwm_ops;
 
 	/* FIXME: Only do this if the PWM isn't already running */
 	ret = stmp_reset_block(mxs->base);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to reset PWM\n");
 
-	ret = devm_pwmchip_add(&pdev->dev, &mxs->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
 		return ret;
-- 
2.42.0


