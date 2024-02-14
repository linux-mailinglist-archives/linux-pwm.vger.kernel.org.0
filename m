Return-Path: <linux-pwm+bounces-1465-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A5854625
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B7528AC85
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E73D134A9;
	Wed, 14 Feb 2024 09:34:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0613FED
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903293; cv=none; b=JZNxVjycBbubnSRB7xiID+JSUKWO8bg6+Za/y8dx1loOJxg6mS/f2xHhhwr+bNR6/UEcEyEPkE81tugRUtID7/BqH7HHY82vzcIo/HtDcyoJgJaHUpphNfn3CocuDo+Z3MRia7dQPC9JbfItxtxNxZqKtbFdnjPlVV9zfroe6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903293; c=relaxed/simple;
	bh=0SYLkEACQ8T9AGYR57XhymGkN9/LFLhJpbaYpX97npw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqFHvL78qhj+ZVf57w++TgOyGQ4ctxYvphwOfGImIYnmuDaPV4jFTFuNzD86pVO5vDkJv2RusNjaLVc7vI614c8vRWtIIQ+FSxROVMzJ/EPnA48m9cm1uA92lNVvjVuCUgV40on9QvMcP9W7jTr78D5biL1hrK3+E5zHFOBbjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfB-0006BN-5F; Wed, 14 Feb 2024 10:34:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-000fI3-Ma; Wed, 14 Feb 2024 10:34:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-004Y9v-1z;
	Wed, 14 Feb 2024 10:34:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Anderson <sean.anderson@seco.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 149/164] pwm: xilinx: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:33:16 +0100
Message-ID:  <738b9929c1d13bde64050f8bbc4ce8d85f58cc7a.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2515; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=0SYLkEACQ8T9AGYR57XhymGkN9/LFLhJpbaYpX97npw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIj2a6DGhXDiU1Z6aUiYCWWWQW9gEgMV3inMX qS/8CiV40CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI9gAKCRCPgPtYfRL+ Tn9BB/oCWEPoJqHqeucqUnA/H0dRS9PaYdQkNJvfa8bFh529CNuNG6EmxBMMDxr1vEH4TBW5OHv ae1T6JUTMThxqwufl7aTSCib+f4HO83gp5u23ZxkZGjmv9iuQ6BPFp4yF7MEIc0lrV2kRGt7btt 4kZM/IZF0Jc0+yxyGVsenhKA2zsKzvBxT9xV1yIVzOjMEJ0tSd9wyv/P8NTZiGyltL3fTSiDkn2 BDbG1dB272qKH4MekygiNmgE2jc8IheosgITEV6drW5YQ998xQ/TCmMv+X20iylqISHzP7yO3up 4yiuaFpqWSqbA5w5ql7M6ocKtTxF0W6jMQ3PgfFe2bncQADS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct xilinx_pwm_device. Use the pwm_chip as driver
data instead of the xilinx_pwm_device to get access to the pwm_chip in
xilinx_pwm_remove() without using xilinx_pwm->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-xilinx.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
index 5f3c2a6fed11..0ca79fe8c105 100644
--- a/drivers/pwm/pwm-xilinx.c
+++ b/drivers/pwm/pwm-xilinx.c
@@ -214,6 +214,7 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct xilinx_timer_priv *priv;
+	struct pwm_chip *chip;
 	struct xilinx_pwm_device *xilinx_pwm;
 	u32 pwm_cells, one_timer, width;
 	void __iomem *regs;
@@ -228,8 +229,9 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	xilinx_pwm = devm_kzalloc(dev, sizeof(*xilinx_pwm), GFP_KERNEL);
 	if (!xilinx_pwm)
 		return -ENOMEM;
-	platform_set_drvdata(pdev, xilinx_pwm);
 	priv = &xilinx_pwm->priv;
+	chip = &xilinx_pwm->chip;
+	platform_set_drvdata(pdev, chip);
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
@@ -278,10 +280,10 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Clock enable failed\n");
 	clk_rate_exclusive_get(priv->clk);
 
-	xilinx_pwm->chip.dev = dev;
-	xilinx_pwm->chip.ops = &xilinx_pwm_ops;
-	xilinx_pwm->chip.npwm = 1;
-	ret = pwmchip_add(&xilinx_pwm->chip);
+	chip->dev = dev;
+	chip->ops = &xilinx_pwm_ops;
+	chip->npwm = 1;
+	ret = pwmchip_add(chip);
 	if (ret) {
 		clk_rate_exclusive_put(priv->clk);
 		clk_disable_unprepare(priv->clk);
@@ -293,11 +295,12 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 
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
2.43.0


