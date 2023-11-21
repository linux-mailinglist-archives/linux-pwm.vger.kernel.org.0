Return-Path: <linux-pwm+bounces-88-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB227F2FAA
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEF8281AF4
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458D33D3B8;
	Tue, 21 Nov 2023 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A12510F8
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-0006Jw-Q9; Tue, 21 Nov 2023 14:52:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAY-00Ab1o-Qs; Tue, 21 Nov 2023 14:52:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAY-004xgn-Hq; Tue, 21 Nov 2023 14:52:02 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 087/108] pwm: sti: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:29 +0100
Message-ID: <20231121134901.208535-88-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3482; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fSsIXuXmbkGj+bGQ29yJ5GxSuvsd+2Mmb14ZZnx9bZs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWsLD0P0H3V886R2b5ONXF1cSVkVggLzfmHk PihEVnwQQCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1rAAKCRCPgPtYfRL+ TsLSB/0TA6hz9J/FKiXVaVujY+FbJ7PvzNX1nAHv1k6zGnZ1ErpuZvm4IpKAoWx7Hh4XB7FNWiG 1ZfnuM8pn2Co3xSQuumMVTlMgxu7ocwWDREZgeG+QgfrGGFLJbnBI/zrvktKU47fhp+qWWKhtdk Bep6IqTvoPHZq8t20B59VxhFDA5GJ96tEZ7LogoJRwEZZWmLqQdKSD/7SgqUP/YRecWnfAquNQm lclAauwxCkk8MvhYZcGYgBB4NUfBsukP551dw0gUDc5h4qtKkScpHXzI2aHHB5Hlhttew5mIVmj 2UfF+yeCtv6+dtlz1pvqTHn9fU9G5J4/mEsIIk5886n3fQ7X
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sti driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index dc92cea31cd0..9de9083bb407 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -94,7 +94,6 @@ struct sti_pwm_chip {
 	struct regmap_field *pwm_cpt_en;
 	struct regmap_field *pwm_cpt_int_en;
 	struct regmap_field *pwm_cpt_int_stat;
-	struct pwm_chip chip;
 	struct pwm_device *cur;
 	unsigned long configured;
 	unsigned int en_count;
@@ -114,7 +113,7 @@ static const struct reg_field sti_pwm_regfields[MAX_REGFIELDS] = {
 
 static inline struct sti_pwm_chip *to_sti_pwmchip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sti_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -503,10 +502,6 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	u32 num_devs;
 	int ret;
 
-	ret = of_property_read_u32(np, "st,pwm-num-chan", &num_devs);
-	if (!ret)
-		cdata->pwm_num_devs = num_devs;
-
 	ret = of_property_read_u32(np, "st,capture-num-chan", &num_devs);
 	if (!ret)
 		cdata->cpt_num_devs = num_devs;
@@ -561,13 +556,18 @@ static int sti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sti_pwm_compat_data *cdata;
+	struct pwm_chip *chip;
 	struct sti_pwm_chip *pc;
 	unsigned int i;
 	int irq, ret;
+	u32 num_devs = 0;
 
-	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	of_property_read_u32(dev->of_node, "st,pwm-num-chan", &num_devs);
+
+	chip = devm_pwmchip_alloc(dev, num_devs, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_sti_pwmchip(chip);
 
 	cdata = devm_kzalloc(dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
@@ -600,7 +600,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	cdata->reg_fields = sti_pwm_regfields;
 	cdata->max_prescale = 0xff;
 	cdata->max_pwm_cnt = 255;
-	cdata->pwm_num_devs = 0;
+	cdata->pwm_num_devs = num_devs;
 	cdata->cpt_num_devs = 0;
 
 	pc->cdata = cdata;
@@ -644,9 +644,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
-	pc->chip.dev = dev;
-	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.npwm = pc->cdata->pwm_num_devs;
+	chip->ops = &sti_pwm_ops;
+	chip->npwm = pc->cdata->pwm_num_devs;
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
@@ -655,23 +654,24 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		mutex_init(&ddata->lock);
 	}
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		clk_unprepare(pc->pwm_clk);
 		clk_unprepare(pc->cpt_clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void sti_pwm_remove(struct platform_device *pdev)
 {
-	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	clk_unprepare(pc->pwm_clk);
 	clk_unprepare(pc->cpt_clk);
-- 
2.42.0


