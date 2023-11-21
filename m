Return-Path: <linux-pwm+bounces-81-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 395127F2FA7
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DD7281B4E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653553809;
	Tue, 21 Nov 2023 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CA1702
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-0006Sa-62; Tue, 21 Nov 2023 14:52:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAa-00Ab2E-DK; Tue, 21 Nov 2023 14:52:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAa-004xhB-3y; Tue, 21 Nov 2023 14:52:04 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 093/108] pwm: tegra: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:35 +0100
Message-ID: <20231121134901.208535-94-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2569; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IVxivwViCvf6mlnIWgQw+fkT5k+uuDSJeGaKYqBS8jo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWzUgTphMFCYobi8vF1ciSiVFmO8tJU/D+TO AHKpJGySzuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1swAKCRCPgPtYfRL+ TvnkB/91qsWELYOEDWrSIVM6i7uEw43ggLOKY5ViV3zqQKNV+dyLE5rAco3VEpoR5DxCS9Frpcg lX9sCi42LUlk+4pQsyKSm0UKuJwtcufLt7gw9XFUnOmsSBTH1LsVYTyBZk/9us0O3oxMDgTqEEt ZT1cvss4OMZBgtVxWmaT/J9wL/fp8XjCkjR9pQCfFwRsePZxOQ/xDhIFPentgvYGD4UDzBt4q0g mb5yzxFLZPQe1PssvD9aRx2wTEmaJUVldzRxdIr2ExpG9upBl8FcXAcit3smBwW+5LXplU4Kf6S Yll7TNlmBshUzT+0dBEeJAYpBAMO6CBhCEXbb4fiN6ExCdnd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-tegra driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 39ea51e08c94..f41791d7630d 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -65,7 +65,6 @@ struct tegra_pwm_soc {
 };
 
 struct tegra_pwm_chip {
-	struct pwm_chip chip;
 	struct device *dev;
 
 	struct clk *clk;
@@ -81,7 +80,7 @@ struct tegra_pwm_chip {
 
 static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct tegra_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
@@ -272,14 +271,19 @@ static const struct pwm_ops tegra_pwm_ops = {
 
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct tegra_pwm_chip *pc;
+	const struct tegra_pwm_soc *soc;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	soc = of_device_get_match_data(&pdev->dev);
 
-	pc->soc = of_device_get_match_data(&pdev->dev);
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_tegra_pwm_chip(chip);
+
+	pc->soc = soc;
 	pc->dev = &pdev->dev;
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
@@ -328,11 +332,9 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	reset_control_deassert(pc->rst);
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &tegra_pwm_ops;
-	pc->chip.npwm = pc->soc->num_channels;
+	chip->ops = &tegra_pwm_ops;
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		reset_control_assert(pc->rst);
@@ -350,9 +352,10 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 static void tegra_pwm_remove(struct platform_device *pdev)
 {
-	struct tegra_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	reset_control_assert(pc->rst);
 
-- 
2.42.0


