Return-Path: <linux-pwm+bounces-999-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD1983C1E1
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91731F23408
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B47481A1;
	Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA645BFA
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184657; cv=none; b=q5fS8I/OS05QPszHrmq7GuvazBe4DDvCa+EDlGjOuVn1znx+EwPBgTyWR/1YqKkcOlXgRj7Y2x1r5NaukFp/QmOmCBsLimBFJgCSGbEfaU0vPt4RLuDvIn6x5Axl9XCczVY0gnyVAnTJFgiDVEmNjIx15inkxkbz4/iCR7SG0cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184657; c=relaxed/simple;
	bh=5FRw4Gtk+8yZfOMWXaoX/ZTbPI2wuUUoTIwGPmt3uRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r8E0ou/AjvQGnWxEOdqeJ1akXt6c3qpHufCyNsKdXq9h99vTOA2/cs90rowPvklnkNIuQcWs1688KSxx8OJXJm5+wU2upOeliRwQ1eDacy6ODce4MkiPvd7GgoiteKvdpIo9srZLjngja1/uPV/7h3NckPBAaUb16QY5P6bgvys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-0004NT-FK; Thu, 25 Jan 2024 13:10:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZI-002HSo-E9; Thu, 25 Jan 2024 13:10:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZI-007n2O-1A;
	Thu, 25 Jan 2024 13:10:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 063/111] pwm: intel-lgm: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:25 +0100
Message-ID:  <3bdf79617a06481886dd8154ec9fe05fe7fe5868.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5FRw4Gtk+8yZfOMWXaoX/ZTbPI2wuUUoTIwGPmt3uRQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+EvknMxL4zycAcUkNdF4KplszU00Fx+BU38 gLYsH7gmc6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPhAAKCRCPgPtYfRL+ Tm1iB/4pkD4Q8o0fYOsv9hY+ftYdyU4fa3roBcvWddlcy8mfWwyYrl4d5FixI2M/UxHbA0yxwwr PuHudFD4QHnQUFBOC/noNtYoOTqSE/Dl9Ms2+sol3myjIQSTXwylRoj70Gmig5+XjVBXlGRvHZW aTYWJ8bvqCwTXU42bP/Bzt5ZfCNLOKRQwHQAs2ryJ4Od3lQ3iXFBWeum/ZvtTCOEpJh7uYedHeU +dwCPycDd+JdQctWMkF0VMRwF4kOQTHmsmitl7UUlQqHpncS0OGwOa2LiUvtj4ixJgc74bQPgeM LhjEfU2Y0KfCFOTATQTx9vyjsGWJuL27si+h7h7K8ZWHCZmN
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-intel-lgm driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-intel-lgm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
index 54ecae7f937e..f9cc7c17c8f0 100644
--- a/drivers/pwm/pwm-intel-lgm.c
+++ b/drivers/pwm/pwm-intel-lgm.c
@@ -42,14 +42,13 @@
 #define LGM_PWM_PERIOD_2WIRE_NS		(40 * NSEC_PER_MSEC)
 
 struct lgm_pwm_chip {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	u32 period;
 };
 
 static inline struct lgm_pwm_chip *to_lgm_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lgm_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int lgm_pwm_enable(struct pwm_chip *chip, bool enable)
@@ -168,14 +167,16 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct reset_control *rst;
+	struct pwm_chip *chip;
 	struct lgm_pwm_chip *pc;
 	void __iomem *io_base;
 	struct clk *clk;
 	int ret;
 
-	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_lgm_pwm_chip(chip);
 
 	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
@@ -203,13 +204,11 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
 
-	pc->chip.dev = dev;
-	pc->chip.ops = &lgm_pwm_ops;
-	pc->chip.npwm = 1;
+	chip->ops = &lgm_pwm_ops;
 
 	lgm_pwm_init(pc);
 
-	ret = devm_pwmchip_add(dev, &pc->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
 
-- 
2.43.0


