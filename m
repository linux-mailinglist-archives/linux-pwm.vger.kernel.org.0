Return-Path: <linux-pwm+bounces-1013-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7A183C1F3
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B270C1C22BAB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEED645022;
	Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44B636122
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184660; cv=none; b=nuhX9+Fa6nyo7m/c5k6g7Ok9tULKKt6P28zhSdvy8t2ebzd4EkH5zK33fOslRC7r5U/O2rT2X2/mnCNcD0n58sd+wBAE+29pHx9zOrrV73WTd5JNr3uhew/BZNwrD8SZzi2UEHOKsX6lPvIVpd4RvaeBjKZqZ+zn0X1OeSkJQ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184660; c=relaxed/simple;
	bh=GBLmuONAg1sBI8HP1ChJ031DZ0t8wiTvxNd4lqFmn0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2d/EwVYkOaU7gbo8UPHn6DVDNL/NDui/b0LqKK2Kfr1grFruX9L2b+C7EYuAQbtxcigOFrUzspJuKVLxYqblomUgWPe3LmXF/ZsZrFMyi8x+V9mgDijeHKjo8bhQNDFnfEPx8Y4b2mYsQ02ZzGkXjoDeBsFqgLpzOhh7dEsR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-0004Rw-V4; Thu, 25 Jan 2024 13:10:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-002HTU-Jl; Thu, 25 Jan 2024 13:10:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-007n36-1i;
	Thu, 25 Jan 2024 13:10:54 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v5 074/111] pwm: mtk-disp: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:36 +0100
Message-ID:  <77d027ef065580f5f29fc003bb0cad6bda1abdb1.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GBLmuONAg1sBI8HP1ChJ031DZ0t8wiTvxNd4lqFmn0s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+R3qfd2M9eC00TKIyuTdbSKXkYyP+QERKKk 9IdeES1fUyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPkQAKCRCPgPtYfRL+ TjdsCAC5kkRUjvz3BywQfS+hgjj+9os0Sz+9Z8nKNZBRE9v9reG3RweAk07BuGW5zW7dA8Eb6CW y6T2DgGXm7Mtj0qWbkPbYmxEozzsaqi8P/cT8rH/AXWPaCiTXKlgZncm6iuMWJCSaVpOD6+rKMc TgM//dVPN0c93BXcVur3TCusBbV+7w6Mdfp9SXLXvJ2BJm67Pj1kQPcrEQww90PU0Pupz613Kz/ EUxqmpEVGALwxgGoFEZ7OMsKJzTZr7LdgZdlEjFeSuwplH08Ec6ikEWBaCx7Q7MrthBEfYR4qq3 SD+GYkFPuRZRTFp32b5ESvVvCUbhI7Xpf4AkQFduhKNK7HkV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-mtk-disp driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mtk-disp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 186aa5c04435..bafd6b6195f6 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -42,7 +42,6 @@ struct mtk_pwm_data {
 };
 
 struct mtk_disp_pwm {
-	struct pwm_chip chip;
 	const struct mtk_pwm_data *data;
 	struct clk *clk_main;
 	struct clk *clk_mm;
@@ -52,7 +51,7 @@ struct mtk_disp_pwm {
 
 static inline struct mtk_disp_pwm *to_mtk_disp_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mtk_disp_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void mtk_disp_pwm_update_bits(struct mtk_disp_pwm *mdp, u32 offset,
@@ -231,12 +230,14 @@ static const struct pwm_ops mtk_disp_pwm_ops = {
 
 static int mtk_disp_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct mtk_disp_pwm *mdp;
 	int ret;
 
-	mdp = devm_kzalloc(&pdev->dev, sizeof(*mdp), GFP_KERNEL);
-	if (!mdp)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*mdp));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mdp = to_mtk_disp_pwm(chip);
 
 	mdp->data = of_device_get_match_data(&pdev->dev);
 
@@ -254,11 +255,9 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(mdp->clk_mm),
 				     "Failed to get mm clock\n");
 
-	mdp->chip.dev = &pdev->dev;
-	mdp->chip.ops = &mtk_disp_pwm_ops;
-	mdp->chip.npwm = 1;
+	chip->ops = &mtk_disp_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &mdp->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-- 
2.43.0


