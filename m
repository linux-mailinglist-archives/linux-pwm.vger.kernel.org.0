Return-Path: <linux-pwm+bounces-1362-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 250368545B2
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 837FEB22A52
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD810175A9;
	Wed, 14 Feb 2024 09:34:33 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9246418B04
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903273; cv=none; b=orxZk92ESt9QkpvZ3WK5Z2AKPohFWkq1ZzWcz6aZwdiLKPyHOerQ0/LWAF5HLzlLgl06TFtG7rUIFqh3udzIYaQ3x8lMSNZpfpYhzz4bKQjrlIm4Jm/8y8kWHZ9CSnvxcVJyi2X1NiN7jKyWLRd0Rs4f3BBv4978GsZIwfh5pfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903273; c=relaxed/simple;
	bh=5FRw4Gtk+8yZfOMWXaoX/ZTbPI2wuUUoTIwGPmt3uRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BvWCHhyRBKdK5suY4OB2x1M8ojCfrkrGm8iYV1ufDW+Zx6UQr+E/vU6K2uncdAEn/CXQR/NyDDCDKn3g4+NIXMYQc9GXFHOHcsKxiwWFm6BrPyd0X/7bvJ3mO9FH2MkfXdlAofp/sgs1NRGHjDyYoz/rt4C3kFooD71bsIO6aKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-0004mr-Sq; Wed, 14 Feb 2024 10:34:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-000fC0-PI; Wed, 14 Feb 2024 10:34:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-004Y37-2I;
	Wed, 14 Feb 2024 10:34:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 051/164] pwm: intel-lgm: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:38 +0100
Message-ID:  <3b2be81b046fe2213736ad37153131d5f4c859f5.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2029; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5FRw4Gtk+8yZfOMWXaoX/ZTbPI2wuUUoTIwGPmt3uRQ=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHa1+Ps5MDqlW/EavmdpWnEwLXtEz8fTm88tXpcyu+ roqqWNzJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATkZjD/k99U9rKSsfma+IT 9EQdjOpNVP7wHmXaq8iX2m5ynnFW6N+CmrmfklwPZx0I1rrT6vxD+uQqHeWvKbxlFy5Hms5xWFG TGh7BI+1z/N6dqSzb2RgDJU+nKPBNerjceb13h/6mqcam8YtspXdef98iqHN1+YJpGw97sOzwPt 5WKlY84YjSJrv91ln19k+4Qm9tdN308u3DAJ3TCvnevn46d4Imm4We/B349PrFtZtrE2rslmtUT 3F+K/pTIMhE4UfjB73rp+al6f2t/70kUM+u1064qWjOhK+MZcwJpU+2LMzeFB+Z6rba0/1VgJKl z1JDi1XCZy4GCT74E93coSzVeuPrdMMP5c49fRFFRXaZAA==
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


