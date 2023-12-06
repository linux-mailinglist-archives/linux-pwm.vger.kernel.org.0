Return-Path: <linux-pwm+bounces-397-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B18D806EC2
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D04E1C20C7A
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2585334572;
	Wed,  6 Dec 2023 11:49:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BA210E3
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-0007bP-FO; Wed, 06 Dec 2023 12:48:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00Dwxf-93; Wed, 06 Dec 2023 12:48:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00FR35-0G; Wed, 06 Dec 2023 12:48:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v4 099/115] pwm: tegra: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:53 +0100
Message-ID:  <b77ac0d6b6c145384e363341df83dd8352dd923f.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2576; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=01ELkliR5CsdkXhfCNySQ9YLYwIepbE2qckDT6QAyO0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSCeOOPkRkLX0YduMjHJHrAhX3mP0aPSTN9VH9rxabLB i1b97Cpk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJLLjDwTDJee+rYJPDPeVv nZREVoet6/DgW3rFu8Uyr18upOlW0qvbDl/vzp+kWVWxzt3e6P92j5t8/3iD33pmZmqy9Kw33Pr KwbeSSZSlaFdl4kKpyd8irv0OaDmWuroisMvXdZ19o3R6jjTTj4DK6UeOqxvzlx5dLJnJn1W34K R3q+yBit8SC6U/vph2PFBo6beOXabXQ0S+OvD9fyxzzTvh9JnH1cUfFT5I6E34EqDx93qFatBO/ 7IilU1avddKfmVrPe7/vDHjqo5xRcUmSRVZxySG1sr/1qxlm94en5LaPt84zffv7asRzO+WM/uk LD0nki5z9z+/adaVmzEW7lX730hs9Yub58n6OW2STVETAA==
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
index 82ee2f0754f9..5eb7bdfb84d8 100644
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
+	return pwmchip_get_drvdata(chip);
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


