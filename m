Return-Path: <linux-pwm+bounces-1010-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F7883C21F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3749BB2244A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC7836B0E;
	Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31583A1B6
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184660; cv=none; b=ObFHjf/zP2tOuw3hrlC5uUI0tbPXWwQSv8No0QAhp8C6+Fb1iQq/ZRw6OabUnI9vmTDWH9QjzoKAUqWVQp9lYI20oYPzWBq07qHQ6/78t83FlnjLPMZ9FfNTsN8K+wwNbN+dWNcy1P+qzfZxaghLrtxns7x/qKExpULgzPe4JzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184660; c=relaxed/simple;
	bh=UNgqLeMXr58KAB5LmcXwr6O+sjdR2/n1zhLr20cCLt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pX5UWflro+j6L3KYNGzNA2IJyv5h5EqVJEKa6zDwQT5/0ved6VYgVyMljrGP5cb+K6W32kAUjXMNJ+KftxpP7ilLyNcxtXFd5vvKpILQ6jDZNOTC5v4oNKpoc10ZNcZseYb4oRUYxyz21vxYR7ujNlmpbA4rU/96qBTpWiddr+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-0004S4-Uy; Thu, 25 Jan 2024 13:10:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-002HTX-Q2; Thu, 25 Jan 2024 13:10:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-007n3A-2K;
	Thu, 25 Jan 2024 13:10:54 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 075/111] pwm: mxs: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:37 +0100
Message-ID:  <f1c4846f155f67ccbba7b32fd91615390e43412b.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=UNgqLeMXr58KAB5LmcXwr6O+sjdR2/n1zhLr20cCLt0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+SoUl8mI/vlGobtYcaW4a2khiwRZFgy1pi0 kVy9p7C9geJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPkgAKCRCPgPtYfRL+ TrneB/9NNsQCezDzdiMvfCHIXzcUcdpxBL4zm8gvDuqWxzChkgNt+WGpZzQj4oH/i9K5sXM3LVZ PlxtLsN4tM7w4CWVtXa82UFv0BuutXfNYo7YkY8I2PvdFIrsR6545eR044iKfil+ZX1lrmujddt XmoHCgx/nLxQpZf1Z9b4nMv5Xo9QjtiGnckhOZCY5/wSlg4lZ4dJGrLufN1WDAD5ohVQWw3H+hD 78MZTyUOFdRem2BK+oh7cZSteIl0+tz6agaaQIaVvLmwOfoUD5bCLWkYUJT5PbQYyP2bV0gyp5m PRtDChSabzXVq2N8ltAJATDvdReSHDavD6lM08Lxfgg8KtUo
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-mxs driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

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


