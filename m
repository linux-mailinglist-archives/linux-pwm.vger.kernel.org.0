Return-Path: <linux-pwm+bounces-91-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FECA7F2FAE
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22DB1C21824
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EB053805;
	Tue, 21 Nov 2023 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A09D1705
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-0006J2-09; Tue, 21 Nov 2023 14:52:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAY-00Ab1l-Kg; Tue, 21 Nov 2023 14:52:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAY-004xgj-Bb; Tue, 21 Nov 2023 14:52:02 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 086/108] pwm: sprd: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:28 +0100
Message-ID: <20231121134901.208535-87-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3399; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PZhLAxkeOyb+AWx4AV+gS2Lz+9GH68bc6B306U2AspE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWrNkF+04ydJIoChGv97giXcctKOo7ARsYAi 73nhkuVpPeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1qwAKCRCPgPtYfRL+ ThWVCACxkG4awtmStby+avGdx/RRHZVU8aFRpcwgzMTDUYMCTKLdgkib6+R0oYubqH1jxxxGVHF 7xDmmY0GPjAG/qZbm0AeOCXxssZ6QUvEz8nILxSWaDcu/c5JnCveP9BaAHIkuWGL46XqPs+4kd4 xl8gYx5HmggYjAby0FDJlcuoTAmE4ia5d0n76RI94AE244RTfqBQggpj/TCloRIjty3bOnRXH7M Aj3IHt+31gRvI0GPNAMMaFQA4qmNXvFh7wI29MjAu9h1tXsbBibX6RsepFU42VZ/H9lkbpw/FWl 6QZ+tRl5dtzKbiH4NkLbuBGJ95x9m2YytaMhlguYMiAkxBMD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sprd driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sprd.c | 50 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index 77939e161006..b7ecd875b605 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -35,14 +35,13 @@ struct sprd_pwm_chn {
 struct sprd_pwm_chip {
 	void __iomem *base;
 	struct device *dev;
-	struct pwm_chip chip;
 	int num_pwms;
 	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
 };
 
 static inline struct sprd_pwm_chip* sprd_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sprd_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -215,65 +214,66 @@ static const struct pwm_ops sprd_pwm_ops = {
 	.get_state = sprd_pwm_get_state,
 };
 
-static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
+static int sprd_pwm_clk_init(struct device *dev,
+			     struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM])
 {
 	struct clk *clk_pwm;
 	int ret, i;
 
 	for (i = 0; i < SPRD_PWM_CHN_NUM; i++) {
-		struct sprd_pwm_chn *chn = &spc->chn[i];
 		int j;
 
 		for (j = 0; j < SPRD_PWM_CHN_CLKS_NUM; ++j)
-			chn->clks[j].id =
+			chn[i].clks[j].id =
 				sprd_pwm_clks[i * SPRD_PWM_CHN_CLKS_NUM + j];
 
-		ret = devm_clk_bulk_get(spc->dev, SPRD_PWM_CHN_CLKS_NUM,
-					chn->clks);
+		ret = devm_clk_bulk_get(dev, SPRD_PWM_CHN_CLKS_NUM,
+					chn[i].clks);
 		if (ret) {
 			if (ret == -ENOENT)
 				break;
 
-			return dev_err_probe(spc->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "failed to get channel clocks\n");
 		}
 
-		clk_pwm = chn->clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
-		chn->clk_rate = clk_get_rate(clk_pwm);
+		clk_pwm = chn[i].clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
+		chn[i].clk_rate = clk_get_rate(clk_pwm);
 	}
 
 	if (!i)
-		return dev_err_probe(spc->dev, -ENODEV, "no available PWM channels\n");
+		return dev_err_probe(dev, -ENODEV, "no available PWM channels\n");
 
-	spc->num_pwms = i;
-
-	return 0;
+	return i;
 }
 
 static int sprd_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct sprd_pwm_chip *spc;
+	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
 	int ret;
 
-	spc = devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
-	if (!spc)
-		return -ENOMEM;
+	ret = sprd_pwm_clk_init(&pdev->dev, chn);
+	if (ret < 0)
+		return ret;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, ret, sizeof(*spc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	spc = sprd_pwm_from_chip(chip);
 
 	spc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spc->base))
 		return PTR_ERR(spc->base);
 
 	spc->dev = &pdev->dev;
+	memcpy(spc->chn, chn, sizeof(chn));
 
-	ret = sprd_pwm_clk_init(spc);
-	if (ret)
-		return ret;
+	chip->ops = &sprd_pwm_ops;
+	chip->npwm = spc->num_pwms;
 
-	spc->chip.dev = &pdev->dev;
-	spc->chip.ops = &sprd_pwm_ops;
-	spc->chip.npwm = spc->num_pwms;
-
-	ret = devm_pwmchip_add(&pdev->dev, &spc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		dev_err(&pdev->dev, "failed to add PWM chip\n");
 
-- 
2.42.0


