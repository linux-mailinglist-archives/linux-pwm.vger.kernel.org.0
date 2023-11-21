Return-Path: <linux-pwm+bounces-52-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AC87F2F85
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734EE1F24126
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79B25381B;
	Tue, 21 Nov 2023 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED410CB
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAR-0005UN-U1; Tue, 21 Nov 2023 14:51:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAQ-00AazS-Dp; Tue, 21 Nov 2023 14:51:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAQ-004xdx-4x; Tue, 21 Nov 2023 14:51:54 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 048/108] pwm: clk: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:50 +0100
Message-ID: <20231121134901.208535-49-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2393; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dqPmpUBWXhxQUDh+Jp+d35ZL8f3SurIXjN24EPVpkDA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWBxJLGRLm3rmmVBeNuH6OIDDxcANvDOm4GB fQQsE2hsuWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1gQAKCRCPgPtYfRL+ TgPPCAC2J/eHB2m5k5whkjp+esn2nmq5MZofd4ZRdGLxoa8dyhqqc+lr0HFZ4Ynaa9ZDr1Nhcly C8qaui4t5eJk/ae4wOT9KTRqpgvjZOU35X/C+RPDWs6cBerbhMmOHoyX1GK7kJhZKIYPttoxj/E RcQpga6pS6qKP6gIFPx3p5dWO7hi1AAKIawNto+lKLlJ0ZGN4t6fW9niIqwRV6bB9odRsDeP8xA 7aSxh62G2HYZHnvWMZRqc5+TFk+1Y7jHd0oi4tLSsmcqZUbYsNi16YegBiH9VUEwL0Xw8Slpm7e +kBMoVHtt4jqlOSo/umoLS3JKhckGmrTj2BbyLchK7JjjaKd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-clk driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clk.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index 9dd88b386907..86bf1ddedf89 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -28,12 +28,14 @@
 #include <linux/pwm.h>
 
 struct pwm_clk_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	bool clk_enabled;
 };
 
-#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, chip)
+static inline struct pwm_clk_chip *to_pwm_clk_chip(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
@@ -81,35 +83,36 @@ static const struct pwm_ops pwm_clk_ops = {
 
 static int pwm_clk_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_clk_chip *pcchip;
 	int ret;
 
-	pcchip = devm_kzalloc(&pdev->dev, sizeof(*pcchip), GFP_KERNEL);
-	if (!pcchip)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pcchip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pcchip = to_pwm_clk_chip(chip);
 
 	pcchip->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(pcchip->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
 				     "Failed to get clock\n");
 
-	pcchip->chip.dev = &pdev->dev;
-	pcchip->chip.ops = &pwm_clk_ops;
-	pcchip->chip.npwm = 1;
+	chip->ops = &pwm_clk_ops;
 
-	ret = pwmchip_add(&pcchip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
 
-	platform_set_drvdata(pdev, pcchip);
+	platform_set_drvdata(pdev, chip);
 	return 0;
 }
 
 static void pwm_clk_remove(struct platform_device *pdev)
 {
-	struct pwm_clk_chip *pcchip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct pwm_clk_chip *pcchip = to_pwm_clk_chip(chip);
 
-	pwmchip_remove(&pcchip->chip);
+	pwmchip_remove(chip);
 
 	if (pcchip->clk_enabled)
 		clk_disable(pcchip->clk);
-- 
2.42.0


