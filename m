Return-Path: <linux-pwm+bounces-102-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA37F2FB8
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B071C21132
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BBC5380F;
	Tue, 21 Nov 2023 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E16D6D
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAd-0006at-D3; Tue, 21 Nov 2023 14:52:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-00Ab2g-3r; Tue, 21 Nov 2023 14:52:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-004xhZ-Qs; Tue, 21 Nov 2023 14:52:05 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Anderson <sean.anderson@seco.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 099/108] pwm: xilinx: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:41 +0100
Message-ID: <20231121134901.208535-100-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ccXCsHO+01FJmKZCD9dTukfb/pa80Oz4PHVbSCoWmzk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLW5FkWwaeUiLqSnjObjsNpqx2ultYHIWs2R7 fjYsjpw9qKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1uQAKCRCPgPtYfRL+ ThlXB/9ghA+asD2fIehcQq3Tr78Q4kGlRtxIpA9SbQHBtYp6V1hF28VBTdcYeWrpmwG/ZAq1x8V UvBNseOtetXHbZppNyTFDxdVGWp/UFBBTWTFA/R4Y1wFtpLjgShfrY3/jNtfN5ael55Hz3aUmic 8rFk6QOfLJhe4oTXiC2mQnrv65wnVydtC4A16qeryTUjnIqxHHUuc4dpZLd/7XZkSnkODv0CCtY fuylJdVTmXD+DsicIBDpUSI4Fn3zlQ2/qunnVJxkdEkI72kDgQZ2++4vVkIRX+I4c/czyf30pri zkeLjnCrZ+5BMRN49xFM/UVhmEq1U6CnHwAkHE4Y+Cv7UskQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-xilinx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-xilinx.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
index 5f3c2a6fed11..47184916239b 100644
--- a/drivers/pwm/pwm-xilinx.c
+++ b/drivers/pwm/pwm-xilinx.c
@@ -80,15 +80,10 @@ unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
 #define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
 #define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
 
-struct xilinx_pwm_device {
-	struct pwm_chip chip;
-	struct xilinx_timer_priv priv;
-};
-
 static inline struct xilinx_timer_priv
 *xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
 {
-	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
+	return pwmchip_priv(chip);
 }
 
 static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
@@ -213,8 +208,8 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	int ret;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct pwm_chip *chip;
 	struct xilinx_timer_priv *priv;
-	struct xilinx_pwm_device *xilinx_pwm;
 	u32 pwm_cells, one_timer, width;
 	void __iomem *regs;
 
@@ -225,11 +220,11 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
 
-	xilinx_pwm = devm_kzalloc(dev, sizeof(*xilinx_pwm), GFP_KERNEL);
-	if (!xilinx_pwm)
-		return -ENOMEM;
-	platform_set_drvdata(pdev, xilinx_pwm);
-	priv = &xilinx_pwm->priv;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = xilinx_pwm_chip_to_priv(chip);
+	platform_set_drvdata(pdev, chip);
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
@@ -278,10 +273,8 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Clock enable failed\n");
 	clk_rate_exclusive_get(priv->clk);
 
-	xilinx_pwm->chip.dev = dev;
-	xilinx_pwm->chip.ops = &xilinx_pwm_ops;
-	xilinx_pwm->chip.npwm = 1;
-	ret = pwmchip_add(&xilinx_pwm->chip);
+	chip->ops = &xilinx_pwm_ops;
+	ret = pwmchip_add(chip);
 	if (ret) {
 		clk_rate_exclusive_put(priv->clk);
 		clk_disable_unprepare(priv->clk);
@@ -293,11 +286,12 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 
 static void xilinx_pwm_remove(struct platform_device *pdev)
 {
-	struct xilinx_pwm_device *xilinx_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
 
-	pwmchip_remove(&xilinx_pwm->chip);
-	clk_rate_exclusive_put(xilinx_pwm->priv.clk);
-	clk_disable_unprepare(xilinx_pwm->priv.clk);
+	pwmchip_remove(chip);
+	clk_rate_exclusive_put(priv->clk);
+	clk_disable_unprepare(priv->clk);
 }
 
 static const struct of_device_id xilinx_pwm_of_match[] = {
-- 
2.42.0


