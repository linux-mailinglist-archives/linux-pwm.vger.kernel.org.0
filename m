Return-Path: <linux-pwm+bounces-998-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68D983C1E0
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9916A290DFB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD551481AE;
	Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9204845974
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184657; cv=none; b=oDu64WO/CGTXmYuaaPLedqkNOBOZcwDuC+fSKEf5bWgjIRNXsLhj9VgrxuyzIO7xmxHBAmO9zqelT8jvWWxepEgJ53VkYVys1quz98Rxjtu+AjuiLUYhuLCCqv3rmFZTvfnk6UrmU+mbNdvQXsYhij3r7GCzxB96/1ytWI+7wBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184657; c=relaxed/simple;
	bh=tbiGp63L/S7w22iJkzOIhD7LLwswGphHaG03oglAbok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quKcnfAbKVlhE7jbwis+TzpKe9pA2PoLA2Iql9aNOrsC6Rqom81UJj8W214tI+cS8kMJl5KnbmOxweWXPzgBN4CJo5Ye+y+0Ipu7YHo5CqHVE5H4NB8ywG86H49EeDW12dUc8nrlYModzX9lp/TT//6XB0Dv5jqUnsq6xxtxJzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZI-0004M3-Q8; Thu, 25 Jan 2024 13:10:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-002HSa-S4; Thu, 25 Jan 2024 13:10:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-007n2C-2V;
	Thu, 25 Jan 2024 13:10:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 060/111] pwm: imx1: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:22 +0100
Message-ID:  <93774b5353d24af8aa2e8823c321babb20d16716.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tbiGp63L/S7w22iJkzOIhD7LLwswGphHaG03oglAbok=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+AayXd8vcBw3Wj0goE4JaBJFRrcLr+eNs+X 84o/+CKqqiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPgAAKCRCPgPtYfRL+ TrUcCAC6HQcncc0T9tii5v/tFwAtydkbzZrCqKiwCGaMIZ6LveLXNdUaZd43zkXmFpnMp7SNJdB H0xKQDdbc5F/isvPfe6dn+qS5PsldJtz1G3olSYJkzLSGEKJk42hg1kOMT1rkUKwLJjsZaH2ctD 2F80OnXW9GUm1+0IQzBQXAw6Rj2F8K+e5M9XGPRhW9PCGZyvDVUB72dDiMT+01yPL4hbfijJ1Rx 0/XeAxQnVZ6reZjOL0JcHNaJNj6rjb08o6kzOVlIqfNazgR+WMl1cL8rkDdfmjS6v0qNyESa9d0 8AHrOMvxTYh3+JAWt7euf+XZhHb2NFPA8MhLu5B2+d/wmzB0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-imx1 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx1.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index d175d895f22a..1d2aae2d278f 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -28,10 +28,12 @@ struct pwm_imx1_chip {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	void __iomem *mmio_base;
-	struct pwm_chip chip;
 };
 
-#define to_pwm_imx1_chip(chip)	container_of(chip, struct pwm_imx1_chip, chip)
+static inline struct pwm_imx1_chip *to_pwm_imx1_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static int pwm_imx1_clk_prepare_enable(struct pwm_chip *chip)
 {
@@ -156,11 +158,13 @@ MODULE_DEVICE_TABLE(of, pwm_imx1_dt_ids);
 
 static int pwm_imx1_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_imx1_chip *imx;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
-	if (!imx)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	imx = to_pwm_imx1_chip(chip);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
@@ -172,15 +176,13 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
-	imx->chip.ops = &pwm_imx1_ops;
-	imx->chip.dev = &pdev->dev;
-	imx->chip.npwm = 1;
+	chip->ops = &pwm_imx1_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	return devm_pwmchip_add(&pdev->dev, &imx->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver pwm_imx1_driver = {
-- 
2.43.0


