Return-Path: <linux-pwm+bounces-1352-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EEF8545A3
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33592855C7
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A1618E3A;
	Wed, 14 Feb 2024 09:34:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF714ABA
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903270; cv=none; b=efsgOXYEMcVLpe6CGWnRq4BrHJPYPBPsQ3G2OpGlnH82eaLfUPysRZlg20UPPM4cBl91UGXzGwzdTrXHron5QIBfmi33V1sVRKpFKWSZXNwueBvfvom1I8voMbj5QQFAgm31xMt2frlKalBvWlBFmzaCt3yVC+n29Fl2Z6IIrbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903270; c=relaxed/simple;
	bh=Aj8gGeIocPZrDIi5mgKUf3W0gAaRlhhgB9wJRb94QCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3LvFMhuBMlTPZ1+r+kvdZJxvE/IdIhYLbPHWvee8pLb1HxDhRjwcYM7mroccfr+psCmbSNaHpne5MFo6WmEbWNtioq/dGpN+dIhr0M94mf1tYk/xZnpyq+MqJMsfAxeGeSyaZfwU2fr+laE/ouCt+BxoBSrkvwBJejad4unhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-0004Xt-91; Wed, 14 Feb 2024 10:34:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-000f9Q-Ed; Wed, 14 Feb 2024 10:34:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-004Y19-1D;
	Wed, 14 Feb 2024 10:34:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 023/164] pwm: clk: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:31:10 +0100
Message-ID:  <cfbb7c571489ac3d9ca13835b3bd038aaca69638.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Aj8gGeIocPZrDIi5mgKUf3W0gAaRlhhgB9wJRb94QCY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhlg0Vww5UA/7erTb5bv1u7MEI/d8Ic0t5HY GQcj/LMSsOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIZQAKCRCPgPtYfRL+ TllNB/9xwTBQnG8F9m8wI6Ab9lV+E9q6cY9DZ2l3ycQ+YI+ioPLZjTKKjRbYajIY13MSkad/ZON jMwpgJdeSvems9lXEHkxGhnLHQPm7iBeA6kBu/Lihzzk+xx0fc4hA5T/x679qnADR3ph9/siOXo H+FkACQ1prfjpn8NjTsGVWYo8ks44GJu+prl7LPW9EeXIbxqK4oawuzYiGaDtf3FgUbWvGX+Vdt PTK/0EchOD0rEj7B0p0hPy9Cg1E6TkL1HVgY8U/Iv+6blQaEmwM2Tf2Xrdw7PmjXtH4UyihkvMc 7+SpV8nxhDa63ESJlvw6dNdtHDWYp9OWPMK1AW3YbkVCEQYe
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct pwm_clk_chip. Use the pwm_chip as driver data
instead of the pwm_clk_chip to get access to the pwm_chip in
pwm_clk_remove() without using pcchip->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clk.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index 9dd88b386907..aef35d9a6a61 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -81,35 +81,38 @@ static const struct pwm_ops pwm_clk_ops = {
 
 static int pwm_clk_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_clk_chip *pcchip;
 	int ret;
 
 	pcchip = devm_kzalloc(&pdev->dev, sizeof(*pcchip), GFP_KERNEL);
 	if (!pcchip)
 		return -ENOMEM;
+	chip = &pcchip->chip;
 
 	pcchip->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(pcchip->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
 				     "Failed to get clock\n");
 
-	pcchip->chip.dev = &pdev->dev;
-	pcchip->chip.ops = &pwm_clk_ops;
-	pcchip->chip.npwm = 1;
+	chip->dev = &pdev->dev;
+	chip->ops = &pwm_clk_ops;
+	chip->npwm = 1;
 
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
2.43.0


