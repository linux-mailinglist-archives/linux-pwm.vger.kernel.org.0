Return-Path: <linux-pwm+bounces-1340-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E88F0854593
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E741C25816
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381218651;
	Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490311804E
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903268; cv=none; b=K7kWIB51HvZ5GrWQb0hxvQOFcNXv+qyMlvQfdRPVJhb0b/k9pbpzDA5E0LVRNgOK3rGHMoYLzwEhtYiTZCd9y6T1WZ34jaufFQmjZcJfZ/6ZEBSspR9v5tenxu/oYinRdNcrjDf9ANg9c6cCvswgt48i/WhCOJUqjse78yVCt44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903268; c=relaxed/simple;
	bh=NehzaEo7GXBjrXbSaZlO0VeN1fRFMx13q1Pu6IBoqD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfER5ogT8DhUU9IZ64gfKCz309Sos58xFZxawgZV8+OnJWKRTGCxtpwfAjFVbgZDENiIRjYf7MrITlCuNZ8rCkVdalW4T0LFeMqNbDNPSU/5SI617EboAcdP9KwWLEX9boQfupL8wDWS7oy3jOhPGOUmvDA0tkhE7SSciaHivnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-0004dt-3P; Wed, 14 Feb 2024 10:34:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-000fAy-Gd; Wed, 14 Feb 2024 10:34:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-004Y29-1Q;
	Wed, 14 Feb 2024 10:34:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 036/164] pwm: ep93xx: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:23 +0100
Message-ID:  <9420eeca1eb18fada4a15c897f60696b7b22b532.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=NehzaEo7GXBjrXbSaZlO0VeN1fRFMx13q1Pu6IBoqD8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHcW8tj4+05m3W1zVCmC3mR9mekO6OGJ6zIvsirnsq 4S4RF93MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjARxVr2/yWTblvqB0W2TvHL L9iUlnjjedfTQ4/j1ubfNnrYdf7F7PxopW7JsolX5bbL/rT4OynPiq/myMWwLJkfX3yOmwXYfY2 rbn0uV5GwaHXd0hdtk94/UF3b/1dSV+DGzn/ca6JW/NKTkfx/cGkla2fRB36T+VXVt/gy/SrOdo oL1VUfi+1atufS9bMBYaZPsnf8c5u5/3KGCl/LzF+smn8TC+sf5H1PuSiR9cFF7mTFz0fWQfZ1A SsXixV8cbwe4PI+9YJnhOFuX3ENnlfF1hpbTmuFf67b48170Xh98cZ+b08G+Xc+1avXvmN3rNrP /iyk0jRMTGob3/OqmHIRmbjbzW63z91buqLXZgmj8XEDAA==
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


