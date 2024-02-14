Return-Path: <linux-pwm+bounces-1439-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C0B854606
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E242F28A792
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5542113AD8;
	Wed, 14 Feb 2024 09:34:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5291AADE
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903289; cv=none; b=IboJ4b6ZMBwFER8Ys55gIa2S4wxd3bQ/j6ubsThhSXAc2I5KxRXHOwmJ0sytWKTYsh9p1WCs3b6ra9LNbmAvoUUoY5gpQo+Kv8JUf9p6EUhLbI9sNAIN15YPeO/SHrE+K9pbnBPjaUMkXUf2xW3ipE301DGNXsd6ZbnhLN5RA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903289; c=relaxed/simple;
	bh=j+ll1jcK/Tz1Xx6dt5wVgay2IUKDTlBkIX93unWwzRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSgRe0Ke0kgVHg92DbfmeFMw84vxClbyCFxQMPT8G3ZMYhucct61aO2ZdwX5/0xjgil+hpVtP7qn1g6Y+S5zSJHZGMHWdkc3R37Ra2EkcEXSu6NLDMKlmCnbDomTaunLgR1PYtlb8IGBz0+8RE7KOqpNS2MyKpboD1Z/2UR1s6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf9-00069W-8y; Wed, 14 Feb 2024 10:34:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-000fHp-8C; Wed, 14 Feb 2024 10:34:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-004Y9j-0Z;
	Wed, 14 Feb 2024 10:34:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 146/164] pwm: vt8500: Introduce a local pwm_chip variable in .probe()
Date: Wed, 14 Feb 2024 10:33:13 +0100
Message-ID:  <7d903b608609d46cf1ee1e06530f516f42af1ebb.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=j+ll1jcK/Tz1Xx6dt5wVgay2IUKDTlBkIX93unWwzRs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjyE2JyHtqSobupAVUTnyaXx+U7SK81qJd0L aylHFyMJ4iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI8gAKCRCPgPtYfRL+ TrTXCACKWdn+1TnbAzOS8B1SxWUnr0+CXxBrP3i56jQI3PdDuJWiigcFFng5yVkSlk61wZU+8AV aUHuWn2G80bz6dNDtjAELl+xwTPYfFcP/rpa0mkwL7C/6ny3vx411jVYJlXGPWX1i8fvpG26e8Z kwDRyJBkmzl2krZe5f1i5XRkhWrdLsx3UErxffVQ3avO0csNS5xYBS9SqGfmSu7o0fgQvj1CCC2 qFqmZyeJIHXuSEBvyfKxfs9sl8epBsB/Nm9CUcFcEXQ9S+j5CroCf9gGMwisljo7HAMkFZ4YNUU ibFOlvl3zfz1B15V4316wpfttWrQlkaw93/K7nDpBhIFLui9
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This simplifies converting the driver to pwmchip_alloc() as there is only
a single code line left that makes use of struct vt8500_chip::chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 3646bd45b101..6da9b8f88afc 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -232,6 +232,7 @@ MODULE_DEVICE_TABLE(of, vt8500_pwm_dt_ids);
 
 static int vt8500_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct vt8500_chip *vt8500;
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
@@ -243,9 +244,10 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	if (vt8500 == NULL)
 		return -ENOMEM;
 
-	vt8500->chip.dev = &pdev->dev;
-	vt8500->chip.ops = &vt8500_pwm_ops;
-	vt8500->chip.npwm = VT8500_NR_PWMS;
+	chip = &vt8500->chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &vt8500_pwm_ops;
+	chip->npwm = VT8500_NR_PWMS;
 
 	vt8500->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(vt8500->clk))
@@ -255,7 +257,7 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(vt8500->base))
 		return PTR_ERR(vt8500->base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &vt8500->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.43.0


