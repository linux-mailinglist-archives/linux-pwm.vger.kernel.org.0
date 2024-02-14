Return-Path: <linux-pwm+bounces-1386-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D698545C7
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8371C27001
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C2017589;
	Wed, 14 Feb 2024 09:34:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF11863F
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903280; cv=none; b=hluRBLV3zOs8upANOuKN0OP8Dc1SIsgTdf/yi6b3CEE+rluC6ue5NQL4W8hOr1ld1SnwpmhShPRXXH8u2A506L/fWgLl7jBGoEt8MREFrJBUoILQL3q1ed4+E7OuEbF4MFmH6D5AVkPgw+vqJrhpLW8ORgELD9WTLd2yisTAxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903280; c=relaxed/simple;
	bh=MbksikhrFe2+cIq8JkZ1a1wrryjv2J/w24px7Bciwsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExEImT1KcUpRqwCiDKdiZLCN0gDtsY1Mbx5zfinzCvh30+2HkjemxxE1PiiJCGJeugSPojPaRMhATb9Dq30Bwpfv57We87W2FSNdBC5mxKXZG1CsyKOggL9aDDX1ZRit9BtqOudDJzkh9zQibn7em3mG9huj19CukKN3chaOGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-0005Ag-K0; Wed, 14 Feb 2024 10:34:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-000fDP-IF; Wed, 14 Feb 2024 10:34:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBev-004Y4p-1Z;
	Wed, 14 Feb 2024 10:34:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v6 075/164] pwm: mtk-disp: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:02 +0100
Message-ID:  <a70bf253dc41c61d9b901423710c97f235e372c3.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=MbksikhrFe2+cIq8JkZ1a1wrryjv2J/w24px7Bciwsw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIihfEUe+P2Au0+Ds1rdA4i5NuI4cs8yEyfaR 9/IXXjJLX6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIoQAKCRCPgPtYfRL+ TgFhB/9RyFBE3JtdEgMwThz2E8luf65p0NdjcC/slHQC/wiczIzYIKItruhFvdHwrGPDwbyzYSa MCK7YoK6vi3C6+bkncYD0gebq+0b4z7Oc36ZmM0oFK1YCeFX/m1mhzFELLRqAB6fatAtXypkQde hsE6PHuPbU0wDnREupWjm6zh8APN0wzxw0cwsIZjbStQGOFLBZlgxVrqpODYZT/Fh34ZN2qaKfj EuxshcqckGZZMozEk7XuKIsQeJJWfEynd3lTnSw2FXBZgLVJBNU0CV/TRPg1Lu0zfe8vcKW3JEN w8LP/r48bgsH99MbUPH1KekHjZhnfOH8FGIoLE341UfNv8WV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-mtk-disp driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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


