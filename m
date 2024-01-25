Return-Path: <linux-pwm+bounces-996-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29D83C1DF
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F32C1F23218
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BCB46447;
	Thu, 25 Jan 2024 12:10:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1789A37709
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184656; cv=none; b=p4l3mdQb4VV64jkjtXAb8C1+uTz42/427+h/5WR0xKiM/JZNV0kujJQ2sMRQMmhoqnwSVyiiNhw7y225LNu/k2YS3fjlJ48yZ4CkwYG+2Hrme1brVfamu6nV4rMriFRqvYXjYlVhhIwtNDA+4+Uobm16kRdlvddOi8twCPhOa7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184656; c=relaxed/simple;
	bh=EIr0Xh1RoXTpQ77hUf5Ud6VIi77dbKsZjwo2XN7Zo3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhTooAFrN28e3PnRVebKX7JPICsyZAbnCUD4kgISgHsMVwgY58NweSYp6cDveFVt31IsJCgoxXegNLXAHDloQC5GoxQeEKMlFRWQPpgmBzjyjqLsTpvHYQW7B7q3qARkn7xWz5roU8gEzhNZ75jxhsCiLLaDcAoCewOeYGy/XHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-0004JI-5v; Thu, 25 Jan 2024 13:10:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-002HS8-IN; Thu, 25 Jan 2024 13:10:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-007n1f-1b;
	Thu, 25 Jan 2024 13:10:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 053/111] pwm: crc: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:15 +0100
Message-ID:  <5e69c77d14f5d9c173796fd23b238a7c9b7725df.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=EIr0Xh1RoXTpQ77hUf5Ud6VIi77dbKsZjwo2XN7Zo3o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk94XSWfzzU+T5yy9vvh9apJkoO7nPwIzYuBD me2Nv6UVlOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPeAAKCRCPgPtYfRL+ Tv90B/9SpmCY/JnFYa9lN2XN4u/Nk/kwfcyTvwGhV1tbuWXA6qI4+vkffCsXxNEnpCrMheS3im0 YzqR9NDHitCVpGeM0psof9vUst3CIsJEI6aKAjpvsXXfc6EqZyBgijILNigtsQ5lhJVO5AlMJAF 4UFmiSI5I3IsrQbPeAi8gjL0LdfWOWwc5WHVU7RFu8oOvnCFKRFS6IzUYR/KDqAJT8Y+TCXVKMZ 9v48cTZ1Dzmd7u7KehJ4hFz8JRaiAnqEdLPnSzYsl9U9x0GCgYiXrDRLnZbDbgxv1EOVfiqKGKW jyRn3iBwEjFccUFaQFGlw0gfnG/6sJh9709TunYu4+bbtjGE
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-crc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-crc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index c8a852345a97..98ee5cdbd0ba 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -26,17 +26,15 @@
 
 /**
  * struct crystalcove_pwm - Crystal Cove PWM controller
- * @chip: the abstract pwm_chip structure.
  * @regmap: the regmap from the parent device.
  */
 struct crystalcove_pwm {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 };
 
 static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct crystalcove_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int crc_pwm_calc_clk_div(int period_ns)
@@ -160,22 +158,22 @@ static const struct pwm_ops crc_pwm_ops = {
 
 static int crystalcove_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct crystalcove_pwm *crc_pwm;
 	struct device *dev = pdev->dev.parent;
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
-	crc_pwm = devm_kzalloc(&pdev->dev, sizeof(*crc_pwm), GFP_KERNEL);
-	if (!crc_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*crc_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	crc_pwm = to_crc_pwm(chip);
 
-	crc_pwm->chip.dev = &pdev->dev;
-	crc_pwm->chip.ops = &crc_pwm_ops;
-	crc_pwm->chip.npwm = 1;
+	chip->ops = &crc_pwm_ops;
 
 	/* get the PMIC regmap */
 	crc_pwm->regmap = pmic->regmap;
 
-	return devm_pwmchip_add(&pdev->dev, &crc_pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver crystalcove_pwm_driver = {
-- 
2.43.0


