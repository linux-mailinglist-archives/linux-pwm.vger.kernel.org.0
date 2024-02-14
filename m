Return-Path: <linux-pwm+bounces-1451-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B742854613
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF37B1F2E107
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3FE15AE0;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3951B5B2
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903291; cv=none; b=AnKo24i3zOZKLiZYapHXGYxtbVUOxQHJR+eDdMhhvM/VSKX8irV+D0vNcux8LKoihzsluh4uTnI8JYegJtlfkBlQKiytf4APnXyoTGzhespfd1x05XK0Rwpx5bOkKvtiT3Y0sj6VtAzNjEOdMPU7+gS+5xk+FYC483xDcA2IPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903291; c=relaxed/simple;
	bh=z1gQZoys4P8bA1+ZJre1ybdaKOOuB6xjRq+7J6lh71Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stS+duPeohR9ThTVatRIwa+CVcByRke2mM7u/NOBKHDFR2Fbi+C3KSUZ/SkoaQ5+eiw+HjZs40FnuB0PA9zvUp+RBm+QtXGqpEieyy405IlrlRYgXqadfT+1+myC1wFxQUryPFoBldFjZ6wRlNGXXTa3H51vLEOvCjvyE21QxbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-0005yV-4M; Wed, 14 Feb 2024 10:34:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-000fGq-Vl; Wed, 14 Feb 2024 10:34:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-004Y8b-2v;
	Wed, 14 Feb 2024 10:34:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pwm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 131/164] pwm: tegra: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:58 +0100
Message-ID:  <8719be3d57b0b5cf575b312e5ff41fe0717e3a43.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=z1gQZoys4P8bA1+ZJre1ybdaKOOuB6xjRq+7J6lh71Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjh/YLb5Y9ftNgTYNQrKzRW3xJlEOSWTO4iU vS07Qxh4cyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI4QAKCRCPgPtYfRL+ Ti53CACPYMDhgDU3mlSY6vt7lr1gm6b1sAR904yYfnkmqkkyaJwsSNLHC6NKGTA6qGGPOj87q/G RVVIa5L5fX/+VT1P1joj65T2nOe6l8adsiq8Ka8ojHv+sMmazw1Ubht/E5hpPkG7gk2B7y6QQav mBFdIrRYwuEHsuTvG9joEEzHoa/u//Dlz8YSfAFPC0YtK7JnQRmieYM3OsWwW8baYG/5ZtDADcg oA7WuJjRlYbzinTYlqUlI9PqaTRIlmvp8x30yUShSXlR37jTav2x5PKDMQi+Twx9lzNA9aEPXyI MI0Avhz+VNVvoznk12RLcxkQNh289lGYO+qh+8dbJgMf5nsr
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
 drivers/pwm/pwm-tegra.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index f61c24376523..a3d69976148f 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -65,8 +65,6 @@ struct tegra_pwm_soc {
 };
 
 struct tegra_pwm_chip {
-	struct pwm_chip chip;
-
 	struct clk *clk;
 	struct reset_control*rst;
 
@@ -80,7 +78,7 @@ struct tegra_pwm_chip {
 
 static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct tegra_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
@@ -273,14 +271,17 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
 	struct tegra_pwm_chip *pc;
+	const struct tegra_pwm_soc *soc;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
-	chip = &pc->chip;
+	soc = of_device_get_match_data(&pdev->dev);
 
-	pc->soc = of_device_get_match_data(&pdev->dev);
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_tegra_pwm_chip(chip);
+
+	pc->soc = soc;
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->regs))
@@ -328,9 +329,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	reset_control_deassert(pc->rst);
 
-	chip->dev = &pdev->dev;
 	chip->ops = &tegra_pwm_ops;
-	chip->npwm = pc->soc->num_channels;
 
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
-- 
2.43.0


