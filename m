Return-Path: <linux-pwm+bounces-1371-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6944C8545BB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECF0289842
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8218045;
	Wed, 14 Feb 2024 09:34:35 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08DD168CC
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903275; cv=none; b=KVhQjzWfobo212RdcSns/5tJLaLhuVG9jfo2XUDNkaJp1qZWjPWZJcKk6njAWNih5kemhFz85eAkH7NGcHBRX/nBRRd/8/yzPibYgCEF15eKn0FWRLOmyPwG+9NIVOw5foC/hk5KaEqP+TacLKEJ7bmQxvVNYea3V6W12J6pNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903275; c=relaxed/simple;
	bh=MFtSyVVhuFf8aJtBBT9xCKFdFlNzZwELSw07Ki+RCLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXDW48vGPtgj7/EFVSUgqzkb1wNGxxk2ueKLnlersudS0GbofNxDfrypSXct7mU4uBcZckgjH2aGEAbU4ky3y3LT5Ip+lcVOoi2aetmnb/8HA/lDpSuzpzFWq3ENOcO5mEorNCzaocHgZNYHC6ugWlc0/Ej7gRapILwLPk9H4M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-0004yW-7P; Wed, 14 Feb 2024 10:34:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-000fCf-Lk; Wed, 14 Feb 2024 10:34:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-004Y3t-1v;
	Wed, 14 Feb 2024 10:34:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 063/164] pwm: lpc18xx-sct: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:50 +0100
Message-ID:  <d480891340e927705843cd09e5777d4daaa6c9cc.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2018; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=MFtSyVVhuFf8aJtBBT9xCKFdFlNzZwELSw07Ki+RCLI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiTG24niAzJdEnN7lcf6OV9nLPjQr0PQc5Yq l4ksZ65xUGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIkwAKCRCPgPtYfRL+ TikdB/9sCRSfX2aS8SITDexQCpDJaZv3TkZ+1JU1Hvq8S1Wfb3sUCLFoIAavrhAZF2xbmT2IQLk sY4LJzSy48P2j7RvowpwC5XnJbEC2Xgcez1dsM8hfCc7fiXUSH6FtKtR4ydTSBG0NEvFfD/2yUt v2WoLUThYudQwW/rr7ipCuu5o2QHcrKKaijkBwiAHAORVwZ+A2ja6bDJZJ/xKuKIMB+sVU5Bx2O XcbQCo0pLWrxdxX0QJAGnJOWyqBElH0mh3CNXSVeXZwlnfewftgJtP+N0p5iM7x01UapTg5i8q1 FflBasCfTnH2HO2ncGEmsmGdz1m/yWxXVOMEGirmv/0mKHmq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-lpc18xx-sct driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 9b1e8141aec7..04b76d257fd8 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -92,7 +92,6 @@ struct lpc18xx_pwm_data {
 };
 
 struct lpc18xx_pwm_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *pwm_clk;
 	unsigned long clk_rate;
@@ -109,7 +108,7 @@ struct lpc18xx_pwm_chip {
 static inline struct lpc18xx_pwm_chip *
 to_lpc18xx_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lpc18xx_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline void lpc18xx_pwm_writel(struct lpc18xx_pwm_chip *lpc18xx_pwm,
@@ -353,11 +352,10 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	int ret;
 	u64 val;
 
-	lpc18xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*lpc18xx_pwm),
-				   GFP_KERNEL);
-	if (!lpc18xx_pwm)
-		return -ENOMEM;
-	chip = &lpc18xx_pwm->chip;
+	chip = devm_pwmchip_alloc(&pdev->dev, LPC18XX_NUM_PWMS, sizeof(*lpc18xx_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 
 	lpc18xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc18xx_pwm->base))
@@ -388,9 +386,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm->min_period_ns = DIV_ROUND_UP(NSEC_PER_SEC,
 						  lpc18xx_pwm->clk_rate);
 
-	chip->dev = &pdev->dev;
 	chip->ops = &lpc18xx_pwm_ops;
-	chip->npwm = LPC18XX_NUM_PWMS;
 
 	/* SCT counter must be in unify (32 bit) mode */
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CONFIG,
-- 
2.43.0


