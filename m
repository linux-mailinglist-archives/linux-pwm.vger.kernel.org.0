Return-Path: <linux-pwm+bounces-1030-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1960C83C208
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CA251C22042
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14FB41742;
	Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4437709
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184664; cv=none; b=cIBWo9aYiD3jbG74j7DdbNktC4VMLZ4r7p+Q1fp0bY36oigZLaEhBVQ7xqwyupQ2JYXwKdYF2bnwybTiiNc2sjQFyru/QJjYKSg9Qd509XG+XW9Zf+tjtUiBgkjQHddZug68X++wm1TIIyx5mr5utdHcYsvppWx+2YckA/6aB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184664; c=relaxed/simple;
	bh=1/ExSQodunL8E1MTbW6G57v8+Mf0pThwI4BsYJjNA64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5nGOTBmUS1V3xThv+FG/dQPuZOjO5lT3qJn+voSzd6Ll+6k3x5kUnPvosxBwifon9MjNjphZ1G33B9MpEOZMGQSip/s180Lf6AnSmX8ZDPVhPghAga/BIQs6GNyrED7GNSwGJyKCpxFHpCQk7PcEC9Jf6qg1C9KBLDKg/BldWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZQ-0004aO-MF; Thu, 25 Jan 2024 13:11:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-002HUz-Or; Thu, 25 Jan 2024 13:10:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-007n4j-2F;
	Thu, 25 Jan 2024 13:10:58 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 098/111] pwm: twl-led: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:10:00 +0100
Message-ID:  <8a4b2f1c2e693297ce2513457f0cd31c2f3441cf.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1/ExSQodunL8E1MTbW6G57v8+Mf0pThwI4BsYJjNA64=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+tmv8AEYSjyUo5avBFOn6sruGx5b8T6gPFY 6FHlP1epBiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPrQAKCRCPgPtYfRL+ TuhHCACDOSa9mMnSl+8j5kroJiJfyfZPrEZrAcanKUUvz8wcwotZ2SM/JIUedX/AV+kUXuHogLC 3Cdyotpf9l1XvyulhGNqfnlvppeUFqTFvvo6jPdgd4gM4+SAxgXJu1p29/UYTImPMbZoh+XwnP7 QY0NAtL3jhUa15v89loQUFVuqFDHeBO/t+RACsQQyTWk6i4kR7WAeAnz+lxo2HSyn13Nq98SinT GvAligjkKwjKZq7VYA/jcVZCJ9LwpySaFgNPxigskeC0Cj/+cRGey7eecxPEaI3x63TCADjE0+M ebNrySllSQFK2j0jUTB8A567oaNwvjAsOW6J/qvZBlxMtDyM
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-twl-led driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-twl-led.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 00ef798dae52..9f2b78cb83fd 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -62,13 +62,12 @@
 #define TWL6040_LED_MODE_MASK	0x03
 
 struct twl_pwmled_chip {
-	struct pwm_chip chip;
 	struct mutex mutex;
 };
 
 static inline struct twl_pwmled_chip *to_twl(struct pwm_chip *chip)
 {
-	return container_of(chip, struct twl_pwmled_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int twl4030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -345,25 +344,28 @@ static const struct pwm_ops twl6030_pwmled_ops = {
 
 static int twl_pwmled_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct twl_pwmled_chip *twl;
+	unsigned int npwm;
 
-	twl = devm_kzalloc(&pdev->dev, sizeof(*twl), GFP_KERNEL);
-	if (!twl)
-		return -ENOMEM;
+	if (twl_class_is_4030())
+		npwm = 2;
+	else
+		npwm = 1;
 
-	if (twl_class_is_4030()) {
-		twl->chip.ops = &twl4030_pwmled_ops;
-		twl->chip.npwm = 2;
-	} else {
-		twl->chip.ops = &twl6030_pwmled_ops;
-		twl->chip.npwm = 1;
-	}
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*twl));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	twl = to_twl(chip);
 
-	twl->chip.dev = &pdev->dev;
+	if (twl_class_is_4030())
+		chip->ops = &twl4030_pwmled_ops;
+	else
+		chip->ops = &twl6030_pwmled_ops;
 
 	mutex_init(&twl->mutex);
 
-	return devm_pwmchip_add(&pdev->dev, &twl->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 #ifdef CONFIG_OF
-- 
2.43.0


