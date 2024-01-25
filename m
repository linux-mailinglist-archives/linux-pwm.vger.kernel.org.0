Return-Path: <linux-pwm+bounces-1009-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B99B83C1EC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C221A290C7F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3D541742;
	Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBCE376E1
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184660; cv=none; b=C4vidcmXOmqeMLTk9uouG0m0KiqR5X6d+i+f81gsVSMx54xg/y4sJsGIVsTZpltb+mfooycWFBFxD+Q7VDxTAj+coL7kbrtbwt23QxRkkmxo2QRWodNAl9312B3J68wbyieoVw/Qwp3gMSwBQPuy60Nl+p+hqfpLlvRuRH/2HwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184660; c=relaxed/simple;
	bh=efjqoTt2JNTkS/blkL8nCUoyaB7R1fYI93LJBT5sUFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3Dc8cuKmUzzfvDlUM49+GJ0NH+HFpAW1+339LXb1a3F3hm1ZcnUwuKsI1zezznxdBPijjacGsOjB+AuQoM8u5f7v5TfmRfWmvurXAetZTgzIjAORpPK3xMfbZmlXLkhX4pZADOq6j4ya+dVAAngjnGLkmixcnzwPFEKSONC5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-0004Qe-Jl; Thu, 25 Jan 2024 13:10:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-002HTJ-2H; Thu, 25 Jan 2024 13:10:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-007n2u-3B;
	Thu, 25 Jan 2024 13:10:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v5 071/111] pwm: mediatek: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:33 +0100
Message-ID:  <4036b71713b5d451d8a26bafc79beec3048f370e.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=efjqoTt2JNTkS/blkL8nCUoyaB7R1fYI93LJBT5sUFk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+NihwCwdSqi5FKXniJt2QUk7GmBCYrZVtZP GJhTUnavFqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPjQAKCRCPgPtYfRL+ TjTDB/4qzFNHTch2lxkrVdZPgh21vLc9VCCQPOfTj5KZt77Nbv1qpJMi7KYeN7S7hIMzpBV+a44 ftjupQiH0NLezjX8m519bwLsz+QjvCr+GtJFBU2Nn7jePIvIbu3JJy59J5KRVVTmtl7LY/aYHGd IpdvnfkSUUv03Hn3Ix0wOPx/gZFiwAhzz+7yZnQZyApz6eEUxrs+jQe/6/lWOVWMuDRS+Qp/Mm/ eLdCUnCzcI+JGtpNEuh7PRXUPV4UQldRtDYl7D/FZpKMdK09Zfx7qHgiNcBbi72icHGqr6er+lf jlL++n2ft0YFLan1cMOE80BH4072qDBNfl3Uml+A/NWlx7Su
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-mediatek driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mediatek.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 6cf7543a3826..c5fca0f1ebc7 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -42,7 +42,6 @@ struct pwm_mediatek_of_data {
 
 /**
  * struct pwm_mediatek_chip - struct representing PWM chip
- * @chip: linux PWM chip representation
  * @regs: base address of PWM chip
  * @clk_top: the top clock generator
  * @clk_main: the clock used by PWM core
@@ -50,7 +49,6 @@ struct pwm_mediatek_of_data {
  * @soc: pointer to chip's platform data
  */
 struct pwm_mediatek_chip {
-	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clk_top;
 	struct clk *clk_main;
@@ -69,7 +67,7 @@ static const unsigned int mtk_pwm_reg_offset_v2[] = {
 static inline struct pwm_mediatek_chip *
 to_pwm_mediatek_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_mediatek_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
@@ -232,21 +230,26 @@ static const struct pwm_ops pwm_mediatek_ops = {
 
 static int pwm_mediatek_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_mediatek_chip *pc;
+	const struct pwm_mediatek_of_data *soc;
 	unsigned int i;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	soc = of_device_get_match_data(&pdev->dev);
 
-	pc->soc = of_device_get_match_data(&pdev->dev);
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_pwm_mediatek_chip(chip);
+
+	pc->soc = soc;
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, pc->soc->num_pwms,
+	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, soc->num_pwms,
 				    sizeof(*pc->clk_pwms), GFP_KERNEL);
 	if (!pc->clk_pwms)
 		return -ENOMEM;
@@ -261,7 +264,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_main),
 				     "Failed to get main clock\n");
 
-	for (i = 0; i < pc->soc->num_pwms; i++) {
+	for (i = 0; i < soc->num_pwms; i++) {
 		char name[8];
 
 		snprintf(name, sizeof(name), "pwm%d", i + 1);
@@ -272,11 +275,9 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 					     "Failed to get %s clock\n", name);
 	}
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &pwm_mediatek_ops;
-	pc->chip.npwm = pc->soc->num_pwms;
+	chip->ops = &pwm_mediatek_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-- 
2.43.0


