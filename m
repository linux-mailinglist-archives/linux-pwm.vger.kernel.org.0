Return-Path: <linux-pwm+bounces-1382-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A398545C3
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D2B1C26D90
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089FA168A9;
	Wed, 14 Feb 2024 09:34:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA8A182DD
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903279; cv=none; b=q0uTBL1elAAu0ht3nSD++NIW9U+uBSRkGOsx5jKy7OxBjwfCgYdmLO0paiWj8WNk7JfTuEwA8emNp+MrdLPEGV7RskRuVp18TqHb/+ZWpIDi9MNMr6Vizgg1Fxiqy1R8d8FVk21Ayk7IuC6YU1wmjz0djiVer1GBSaeXQgI6r2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903279; c=relaxed/simple;
	bh=J7Q/ySzr1SnXL3Xb1UpGW2qKuGEU0uAEaDqOHNNsQbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdPv/pcekWuvFIG0l/+Z7d3NKeHMv6FSKfZaRgIPZcDtMRaFtUt7u4EHRVfFNDLVdxjy1XrfnqwYyBVb8IQzWYqlj7OimWP/0qMJG7kEpptReeRKSx9VYPqxO4ZW9n8XUReRhFdiKLhINq7hUSEBJpQ5QVaGULhdD9375N+h6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-0005BL-OR; Wed, 14 Feb 2024 10:34:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-000fDT-Nj; Wed, 14 Feb 2024 10:34:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-004Y4t-26;
	Wed, 14 Feb 2024 10:34:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 076/164] pwm: mxs: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:03 +0100
Message-ID:  <39203f3bfbf4e97654db78bdc7e0c9a2b72c1368.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=J7Q/ySzr1SnXL3Xb1UpGW2qKuGEU0uAEaDqOHNNsQbA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiienos8NlNA5Wn/vmFIeeF8BMW+W6L88TKE 3qMZVd0uxmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIogAKCRCPgPtYfRL+ Ts4GB/9mAH5SxUERaXpyeeyvLUo9MhJvj2z0zVnOmGuX5KEtIaKdnf8f/F8f60rXPh2aWZh0AeC vJyCpvuEfUlfxQPcS0TKg0m7BR3RfTCkUL++bwc3bLYEfBKTZIyjZKvedBsrtMUT22czjnpsu50 MT0T8Gc4xApTZGZOxHRDc5evC+4LO4sN7oQzk3pna0nCuAAgbQL4toY0gNGOZXbYdNG2eBB9e36 TxstaeBg6h0pOkTrA6kuK5sSoembDzIJV5XaJkzbeDaXUp/PU7giQDpOLxleOdZv+aHwD098zVL uJVjmjWu/0kahulP8zD7VTtQX6SbDmnUbnKrgutvF39ESc8Z
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-mxs driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Also convert the to_mxs_pwm_chip() helper macro to a static inline to
get some type safety.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mxs.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 1b5e787d78f1..8cad214b1c29 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -37,12 +37,14 @@ static const u8 cdiv_shift[PERIOD_CDIV_MAX] = {
 };
 
 struct mxs_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 };
 
-#define to_mxs_pwm_chip(_chip) container_of(_chip, struct mxs_pwm_chip, chip)
+static inline struct mxs_pwm_chip *to_mxs_pwm_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
@@ -120,12 +122,21 @@ static const struct pwm_ops mxs_pwm_ops = {
 static int mxs_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pwm_chip *chip;
 	struct mxs_pwm_chip *mxs;
+	u32 npwm;
 	int ret;
 
-	mxs = devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
-	if (!mxs)
-		return -ENOMEM;
+	ret = of_property_read_u32(np, "fsl,pwm-number", &npwm);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
+		return ret;
+	}
+
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*mxs));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mxs = to_mxs_pwm_chip(chip);
 
 	mxs->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mxs->base))
@@ -135,21 +146,14 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(mxs->clk))
 		return PTR_ERR(mxs->clk);
 
-	mxs->chip.dev = &pdev->dev;
-	mxs->chip.ops = &mxs_pwm_ops;
-
-	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get pwm number: %d\n", ret);
-		return ret;
-	}
+	chip->ops = &mxs_pwm_ops;
 
 	/* FIXME: Only do this if the PWM isn't already running */
 	ret = stmp_reset_block(mxs->base);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to reset PWM\n");
 
-	ret = devm_pwmchip_add(&pdev->dev, &mxs->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add pwm chip %d\n", ret);
 		return ret;
-- 
2.43.0


