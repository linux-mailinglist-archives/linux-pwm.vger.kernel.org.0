Return-Path: <linux-pwm+bounces-1390-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 259738545CD
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21A1286F3E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA841175A7;
	Wed, 14 Feb 2024 09:34:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3651B12E5C
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903280; cv=none; b=C6gUKhjXWImTNuRRTOlCYwsqXc4dDFlxQskT65LmzWFKqlAL11BCBdHQ9E/ZYrrxR3jUuznyQ4GhqQczgwYjl7pcTLg4VPQO1lMSUdO3ydgUCgrml2RoTfAAEGXxumLbrD8auG+aCCuYwYfmdDNIVrywE+gaw94PiJ4HAx85G3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903280; c=relaxed/simple;
	bh=T5VOlp13zbiWSSSMSPvRL6J3xZ3RTvd6U7NxImZfbn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frYty3TuGJpdlk4qwk7Cvzdv6QePwB7qYapgL4fIiC8D3+hBbv3kwSXuPIsnv+23Wf8gvWNjA83aCGTYGfybi2nVmiFLAU7xYFUylfB2oywHsd9lr/vdqUcKWb8/zbU2j+o+pCXDHPs0u+eNkn09DsLEV+ppoatS9l1WKOHAPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-0005LZ-D1; Wed, 14 Feb 2024 10:34:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-000fE9-Go; Wed, 14 Feb 2024 10:34:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-004Y5e-1Q;
	Wed, 14 Feb 2024 10:34:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 088/164] pwm: rcar: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:32:15 +0100
Message-ID:  <e588e3ccdd0ac1c9c3f3a79b3e52112f83f9d71c.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=T5VOlp13zbiWSSSMSPvRL6J3xZ3RTvd6U7NxImZfbn8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiw7oo+dK/9snpX3Q8eTbvCwGdG9eLc/yfRb 9QRjvpE7ReJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIsAAKCRCPgPtYfRL+ TtITB/wIRumxf8JVI9tbcydsfbLrh48sHyzGGptNxIWthRPveR2JGPn5nuc+l28sRi9Tod+xz6P kmEFOavtnoCfB7DYIfVb9o10S2n84SOMvAtSIvOU9tco/OzngC+R6b2Oif595JoffVbTsW3vP1w 5qd5mrCnmc5HBJAXsTHOpzCyzxp98IuOv33ry4L9aDJV1RV3cYLoRhF0pPLiStiITw56rhq65F0 B36xyF6kE6YE18/fCTkRd4Lor37WhAwr+7BO1rcmZb8XET3OsI68zvelUa9xdN6/UdR1wyNx2sK 84et0ENRWZNvOiIFqYlWCWYdycbUc5WgjDOYqbP50GurvzLQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct rcar_pwm_chip. Use the pwm_chip as driver
data instead of the rcar_pwm_chip to get access to the pwm_chip in
the .remove() callbacks without using rcar_pwm->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rcar.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 4838762137d1..1dfcc74efcfd 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -202,6 +202,7 @@ static const struct pwm_ops rcar_pwm_ops = {
 
 static int rcar_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct rcar_pwm_chip *rcar_pwm;
 	int ret;
 
@@ -219,15 +220,16 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(rcar_pwm->clk);
 	}
 
-	platform_set_drvdata(pdev, rcar_pwm);
+	chip = &rcar_pwm->chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &rcar_pwm_ops;
+	chip->npwm = 1;
 
-	rcar_pwm->chip.dev = &pdev->dev;
-	rcar_pwm->chip.ops = &rcar_pwm_ops;
-	rcar_pwm->chip.npwm = 1;
+	platform_set_drvdata(pdev, chip);
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = pwmchip_add(&rcar_pwm->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
 		pm_runtime_disable(&pdev->dev);
@@ -239,9 +241,9 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 
 static void rcar_pwm_remove(struct platform_device *pdev)
 {
-	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&rcar_pwm->chip);
+	pwmchip_remove(chip);
 
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.43.0


