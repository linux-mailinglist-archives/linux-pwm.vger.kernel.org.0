Return-Path: <linux-pwm+bounces-990-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A805383C1D5
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7787D1C22BF9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A463945978;
	Thu, 25 Jan 2024 12:10:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCB53FE2B
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184655; cv=none; b=DIuJmu4uYKGJjCZtt1xaIjsXYr16MUXbOOh1wYXF2BynyluYPtEBpYzFlAJELRKBRFP8VI0B1qKcB4kE8fhZA4eaiGOoxZn4B8xiLsvigGtHCGU1HWEw7jfTaQDNCfcuIF+qBP8qdH0bnkHxcGnkE22cAmkIwqu3oITtRmHrdhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184655; c=relaxed/simple;
	bh=NehzaEo7GXBjrXbSaZlO0VeN1fRFMx13q1Pu6IBoqD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IGPzwUsxHdImKK5pgZZ3uJixXsUwxduNtn1Jr7dnR6e9yuhOZUEZPafUN3e4jWNomDRuP+ic8sOGwibPJZ17nkiTLOxbUyiwUrXyJiD67aBq0dPPO9PxTSxvbozOsX/uAn8xx3bqMc40RvYHGn6+5jVRA87B0Xg46L1+9ac1ApE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-0004KX-Iy; Thu, 25 Jan 2024 13:10:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-002HSJ-3A; Thu, 25 Jan 2024 13:10:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-007n1r-05;
	Thu, 25 Jan 2024 13:10:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 056/111] pwm: ep93xx: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:18 +0100
Message-ID:  <517a8d02f03e4f10576a17a71d2ca7d5737831f1.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NehzaEo7GXBjrXbSaZlO0VeN1fRFMx13q1Pu6IBoqD8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk97EYU9cdr+zK+M7jeoU4bC+hLZXQ6Ejrd3y ardb8v0MpKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPewAKCRCPgPtYfRL+ TpSUCACPganoIrK7MwP9qgeKIpktxNxSB+z4Hr/nk+0FSccmQpZCpCSPcVAYw3523mdalvvCmeh 5JdimIkxpovWgwLCpGcGjT15EpyaFh3S7Lzxb6MKPeZDZJiB+e9uJDo7EOueUNWN/G2H3RkHoy+ M9dbAuAhN0AbFqmCXRNJ5IpIAaq6XhBRWoaiYjnHnAk3wxA3+jgZ0xlxoJVhlUgC5P4tCtwF6mC eUCpwliVkmjNAKKSwE7ZY3rfQ72Y3y+o97GrEKazYFbpg8frAK4BBG/2WSDqL7MZncEdenYa6aZ OPWR1YN7yoRSv/imWYUV/cM76nauhe2QBMY1hc7vfLhzy4dQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-ep93xx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ep93xx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index e4c3546a61c8..666f2954133c 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -36,12 +36,11 @@
 struct ep93xx_pwm {
 	void __iomem *base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline struct ep93xx_pwm *to_ep93xx_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ep93xx_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int ep93xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -163,12 +162,14 @@ static const struct pwm_ops ep93xx_pwm_ops = {
 
 static int ep93xx_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct ep93xx_pwm *ep93xx_pwm;
 	int ret;
 
-	ep93xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*ep93xx_pwm), GFP_KERNEL);
-	if (!ep93xx_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*ep93xx_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ep93xx_pwm = to_ep93xx_pwm(chip);
 
 	ep93xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ep93xx_pwm->base))
@@ -178,11 +179,9 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(ep93xx_pwm->clk))
 		return PTR_ERR(ep93xx_pwm->clk);
 
-	ep93xx_pwm->chip.dev = &pdev->dev;
-	ep93xx_pwm->chip.ops = &ep93xx_pwm_ops;
-	ep93xx_pwm->chip.npwm = 1;
+	chip->ops = &ep93xx_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &ep93xx_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0


