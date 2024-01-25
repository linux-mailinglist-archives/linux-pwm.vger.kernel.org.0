Return-Path: <linux-pwm+bounces-1004-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF2583C1EA
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5301F2258E
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4F37709;
	Thu, 25 Jan 2024 12:10:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545547F43
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184659; cv=none; b=HCkuAfbqD/sPMQipNJQbfsNdP2T+4VRDb+bIBpY5AQYcLXs6k+ZhRCMAlbadNbjrplXRxBDwBeZKWNR95EkQ68nnHZbHQ5k67zFO9bVNALvrwqI3r4tG0uJ3g0RTJFma6Ggc4d1K/q3qN+gQ5ntAiMIioGdzJtR+WhLl1dBUPAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184659; c=relaxed/simple;
	bh=zaexTqZbDea+1T5ODHlpi8H+vbuSfxVuSfiw4opuuIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQuR3B3nRiifKz8m/kAIqpMHi1L4A6K+zJsWmOosS5iQDYG/A717aAkRyoN7e2IpP4M9KQeAmilLXvobJcbn5D3pQ9JqjRgKznuLs3HpwWTta8tS7Lz2mL9K+Lxh1Pm6y7kcg4uWq7dlx1boOgn4dftXy8ERJAgaVz//9Zmt+io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-0004Q1-Uk; Thu, 25 Jan 2024 13:10:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-002HTB-LM; Thu, 25 Jan 2024 13:10:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-007n2m-1q;
	Thu, 25 Jan 2024 13:10:53 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 069/111] pwm: lpc32xx: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:31 +0100
Message-ID:  <5e32d14f20bbd1ea78b20d4f24af6d63d7d0df2f.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2413; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=zaexTqZbDea+1T5ODHlpi8H+vbuSfxVuSfiw4opuuIA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+LwrmSRQ128wGA/R6iDpLRU0hjwr68+Jo1v q7UGfKc6D2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPiwAKCRCPgPtYfRL+ ThMXB/9nfyjsn113qb4NLTNMVOFCBu8l2P5LsRxvx2/cT2PtgxN3+tAO0Wznqjb1Lcnrq03yBiW 79SAcU/AWi3KkPET003aVC0TiGK409QWGcQGFK1aR2D9eb3RXHA0XW59d7Ixd9ic7AaTH09QvFC 2szmmYDi6F/R3Jo4+g8bflLHFDCvjTV6zR9G5Qw4QzxKpKGJXEuZ5YdTMZ5iZkAnseZlnbWhHkC cv+MGCCU4YU320HbiI5pHLd52MhVK67JV/xHVetmMEC3dQ7VXzdXL0EYGpiPTU3GAmxsw6g0X5h wZ2La7L9Jb5iiypcHHg3P56Zz+9LvGHBVhp0jwFOGKVHUdIX
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-lpc32xx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc32xx.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 1d9f3e7a2434..c748537e57d1 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 
 struct lpc32xx_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 };
@@ -23,8 +22,10 @@ struct lpc32xx_pwm_chip {
 #define PWM_ENABLE	BIT(31)
 #define PWM_PIN_LEVEL	BIT(30)
 
-#define to_lpc32xx_pwm_chip(_chip) \
-	container_of(_chip, struct lpc32xx_pwm_chip, chip)
+static inline struct lpc32xx_pwm_chip *to_lpc32xx_pwm_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static int lpc32xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			      int duty_ns, int period_ns)
@@ -119,13 +120,15 @@ static const struct pwm_ops lpc32xx_pwm_ops = {
 
 static int lpc32xx_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct lpc32xx_pwm_chip *lpc32xx;
 	int ret;
 	u32 val;
 
-	lpc32xx = devm_kzalloc(&pdev->dev, sizeof(*lpc32xx), GFP_KERNEL);
-	if (!lpc32xx)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*lpc32xx));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	lpc32xx = to_lpc32xx_pwm_chip(chip);
 
 	lpc32xx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc32xx->base))
@@ -135,16 +138,14 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(lpc32xx->clk))
 		return PTR_ERR(lpc32xx->clk);
 
-	lpc32xx->chip.dev = &pdev->dev;
-	lpc32xx->chip.ops = &lpc32xx_pwm_ops;
-	lpc32xx->chip.npwm = 1;
+	chip->ops = &lpc32xx_pwm_ops;
 
 	/* If PWM is disabled, configure the output to the default value */
 	val = readl(lpc32xx->base);
 	val &= ~PWM_PIN_LEVEL;
 	writel(val, lpc32xx->base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &lpc32xx->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip, error %d\n", ret);
 		return ret;
-- 
2.43.0


