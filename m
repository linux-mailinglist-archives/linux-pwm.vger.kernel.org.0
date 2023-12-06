Return-Path: <linux-pwm+bounces-385-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3E9806EB6
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6151C20A11
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5412634550;
	Wed,  6 Dec 2023 11:48:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6AB10E0
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:41 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqON-0007TK-0D; Wed, 06 Dec 2023 12:48:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOK-00Dwx6-QY; Wed, 06 Dec 2023 12:48:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOK-00FR2a-He; Wed, 06 Dec 2023 12:48:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 091/115] pwm: spear: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:45 +0100
Message-ID:  <3c943d7f45fbf25d34c91beb77126ee7e12d2fac.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JDZ+b8KyJpgZU37+SMNbCG8SPJQizrlIvLigFbBAAYc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8Q4aI3u6L4Zb6Vs1822u7f5BdbKb4P/jWVl S++mB3emEqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfEAAKCRCPgPtYfRL+ TirXB/43djLMpOR1RX+MF0HMFnNCxK7aJGbZ1fLrrXuDReJNnACan8ChnDH4Z0G29m0Qhh4H6cP xc9f0nwJuhe/VsCyE1krgIys/hra+ia7AqbvLzOOedSZJolewqqRJW1mFOzt16/bExcHpIrppeS bRghsCs6KROZ74E4BR6PQjv5rXGTjBOirDjbehyLL1ZDLglFU1RNeTOkT7yBnhZduHTpCLqhiPY o3581CiEioM2J9/Jt8mOdxbQYiYPAtcI0dk/xH+0i+3Z06VSaNssqFhRSub/lOLCbmymd3E2RdM h0u5o/8O4vSVdiG4VYK8r2JokeLE+ttsCsQM0d+yQC4Wg68/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-spear driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-spear.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index ff991319feef..f1e08cb28ea6 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -53,12 +53,11 @@
 struct spear_pwm_chip {
 	void __iomem *mmio_base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline struct spear_pwm_chip *to_spear_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct spear_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline u32 spear_pwm_readl(struct spear_pwm_chip *chip, unsigned int num,
@@ -194,13 +193,15 @@ static const struct pwm_ops spear_pwm_ops = {
 static int spear_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pwm_chip *chip;
 	struct spear_pwm_chip *pc;
 	int ret;
 	u32 val;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_spear_pwm_chip(chip);
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
@@ -211,9 +212,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "Failed to get clock\n");
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &spear_pwm_ops;
-	pc->chip.npwm = NUM_PWM;
+	chip->ops = &spear_pwm_ops;
 
 	if (of_device_is_compatible(np, "st,spear1340-pwm")) {
 		ret = clk_enable(pc->clk);
@@ -232,7 +231,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
 		clk_disable(pc->clk);
 	}
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-- 
2.42.0


