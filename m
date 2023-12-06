Return-Path: <linux-pwm+bounces-394-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CA3806EC7
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92B3B20EF0
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA6347B8;
	Wed,  6 Dec 2023 11:49:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708ECD6D
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqON-0007UA-DO; Wed, 06 Dec 2023 12:48:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOK-00DwxB-Vm; Wed, 06 Dec 2023 12:48:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOK-00FR2d-Mm; Wed, 06 Dec 2023 12:48:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 092/115] pwm: sprd: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:46 +0100
Message-ID:  <3a1117b2f36cd5b070d89e38115189819b7df30b.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3406; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=u7dElkScNIbJx8d2+f7wFyBNucpqeOOpTYWrojK9ybM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8X6DcIUrfLXWG89gXyVBJ9guwyEaGzEk0tM 0uqTAcQXAKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfFwAKCRCPgPtYfRL+ TumhB/9V2Yi18fOvnp+Mtp5g8cVPgPeNHXBCbLwLEZdZrT2GKSkWPvwi7oB0pV6VU7wA4WIFPey h7XiCUZB3Dps8dvMaJJ7l1m5FFm4HEBYlzuGEo4ILCku46MbEmwOLxuZDLxXRe29woEWb3M0tsI n7TCoP1pOFs/faEdQFY829PfkRQQrlkhlP36AVYAhYSEWFV2ikQGdRtdZktag22jA0Wyec4ZvCO UOFizKlTY5n//8M3r4ReL4q0jM152CYnTtmAhuZ5vAmZz4Zj5rXAYcSeh/ZQjrjBFFjQVPzrVwo BWj3rRRxNA8OWCvOr+9vEH+YVs/N4rbjxeKP77eXaHam8Rt5
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
index 77939e161006..4cecc20f873c 100644
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
+	return pwmchip_get_drvdata(chip);
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


