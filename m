Return-Path: <linux-pwm+bounces-1449-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC985460E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DEC289781
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADBC14AAE;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A21AAD7
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903291; cv=none; b=BgMyMYUViqjXK2FFsAFudgH/Fh5URwn+BPfr6dryMA+6lkz0briwkxlQh1t2EmMEHXHpMdIUecyKr+24fLIDiTW4Lj61u3Cnapncdbxl+/j9Mf6LUWy+dk4J4AVmwegfldG2K+N18XrTT3Mu0YxI1Xw3WvBWknrh5PAdtDbGftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903291; c=relaxed/simple;
	bh=VF916AdZ78JlJ0SXwxTExhTiVpOym5KKgRYivv6Ziis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsoioRuDkc+MlaPUCuJQ6284FmmSJU9qYziAmrNdDHh6ff9klQRGAylm4802b2Gz21Lb3AyKwsUGTcan6aIz+aEHafuCoC6D5o4k+RG0vTO0xe56vPOQbRFJnHt4Lwia23/KHVzp7oB3HQBmxUy3ckREM1PemIAv0YY0XhHcEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-0005xb-K9; Wed, 14 Feb 2024 10:34:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-000fGm-Qe; Wed, 14 Feb 2024 10:34:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-004Y8W-2Q;
	Wed, 14 Feb 2024 10:34:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pwm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 130/164] pwm: tegra: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:32:57 +0100
Message-ID:  <2813c63bf1317dee808f4c5c4a9411999f2d5746.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2947; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=VF916AdZ78JlJ0SXwxTExhTiVpOym5KKgRYivv6Ziis=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjgDA92l+Vp08pf0DuRT8U7DSfoVYOPFmKn9 25xgRemO/2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI4AAKCRCPgPtYfRL+ TnREB/93dL9/Ft/5k5RZnjQdlJxTf+pybj4EEChiZPBGrXqUJFzUcP9mkdq18E34vqPNEJ08i+Z mt/7epSZvWbOcVEs4FWx+IKENAL6m1KRnmrO797BtG8NZ4IVykNFCT0KUSf/s8EZWLpiFNZOBQ9 RomBlYBeXCpysjsjxzspYM/KW+VjQVYLZ+8mrz5R92jQCIN93hiTF68iohnSoQrOY0JtoF+vbvw gp3u1QP6f6XmMUYZW0n/77DgEwJyvKbLbeq5KQvfpXfWFfa+wmlBwxX52gIrZtnKhXm5rLVLveW vB7ZbqpYOzfH9nHvYFhOHRVeNgZqxnsJPPU7u+Qg+HgnQIRj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct tegra_pwm_chip. Use the pwm_chip as driver
data instead of the tegra_pwm_chip to get access to the pwm_chip in
tegra_pwm_remove() without using pc->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 0d5f57c9ee26..f61c24376523 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -271,12 +271,14 @@ static const struct pwm_ops tegra_pwm_ops = {
 
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct tegra_pwm_chip *pc;
 	int ret;
 
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc)
 		return -ENOMEM;
+	chip = &pc->chip;
 
 	pc->soc = of_device_get_match_data(&pdev->dev);
 
@@ -284,7 +286,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 
 	pc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk))
@@ -326,11 +328,11 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	reset_control_deassert(pc->rst);
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &tegra_pwm_ops;
-	pc->chip.npwm = pc->soc->num_channels;
+	chip->dev = &pdev->dev;
+	chip->ops = &tegra_pwm_ops;
+	chip->npwm = pc->soc->num_channels;
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		reset_control_assert(pc->rst);
@@ -348,9 +350,10 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 static void tegra_pwm_remove(struct platform_device *pdev)
 {
-	struct tegra_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	reset_control_assert(pc->rst);
 
@@ -359,7 +362,8 @@ static void tegra_pwm_remove(struct platform_device *pdev)
 
 static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
 {
-	struct tegra_pwm_chip *pc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int err;
 
 	clk_disable_unprepare(pc->clk);
@@ -375,7 +379,8 @@ static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
 
 static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 {
-	struct tegra_pwm_chip *pc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int err;
 
 	err = pinctrl_pm_select_default_state(dev);
-- 
2.43.0


