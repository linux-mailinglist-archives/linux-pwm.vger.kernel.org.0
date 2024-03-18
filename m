Return-Path: <linux-pwm+bounces-1798-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C278387ED88
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 17:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA871F2288E
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Mar 2024 16:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D34535A9;
	Mon, 18 Mar 2024 16:28:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F092535B9
	for <linux-pwm@vger.kernel.org>; Mon, 18 Mar 2024 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779307; cv=none; b=OWKSbwldqNEkN3h/ds9B6ex7QxTHQToMdZ4707SDLjxDc+RS13+4Olj2G5govwvy+0zQfVBWQmiu0XLscUu3cPqkXhYxL6/Bvy4iI7bvQvDx8HNMb1dzyez/PZ1JBmlCHRrNF8Y7ZhWdaCzja3hXjOa77LfdpqouEdnYH8RAga4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779307; c=relaxed/simple;
	bh=sxjjnfKkYkaoM01hMvDCymVFNJG1Id02ALiMxmvvPbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABpjTns4VSmxFwDwTOhq8qIV/t5/c8gVrbpm+8uXQTIEDF6mNgfudW7ZyaBDUOh4gBHHP218uNscuvFeqqR7CN5euf7QCR0iFOBStm6kH0Q+bLxKewqoAQDjkoraCcdpIrCe/BSPj+9QD+gN1bIr2YhCoNtRIjxGvMaSMlQNCAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmFqA-0007vn-3z; Mon, 18 Mar 2024 17:27:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmFq7-00771N-B1; Mon, 18 Mar 2024 17:27:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rmFq7-0084aK-0o;
	Mon, 18 Mar 2024 17:27:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/2] hwmon: (aspeed-g6-pwm-tacho): Make use of devm_pwmchip_alloc() function
Date: Mon, 18 Mar 2024 17:09:50 +0100
Message-ID:  <e95e41eea5a138ae206c9116ba3cb1d9e0178284.1710777536.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=sxjjnfKkYkaoM01hMvDCymVFNJG1Id02ALiMxmvvPbo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl+GdPmc9wc8K9hxy5Ng9vDwdtqZxaBjb9CTpYf Tijn2ND/PWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZfhnTwAKCRCPgPtYfRL+ TsWGB/0VWpThd/3Z7VCJWJhy7lkvW+lLYQQOv3fW/k7u63Rs78a3iRHCeyEQHW5raCK7FTrDPWS zVrJ//f99TxO5qTBQxebilOzDFycu4eouXx2QTcRy+WgdggIAkakj+JQLIg93keGIUeR/NLqb5e niCxliwGuBAfAXa0a/gQH4dH9FVM5l78POWEfrK9Lf+LXG7EgalDaLnZGSGYjboZ2XKEyXaFfI5 g0L7+UcYO06WP7QN3LGjcft91lea5S9rfeQQWjeZ6Coqy1b6Is2lHKkDBiSatfkunnR6i4finQy 9UoazMLDz5S1r6Bsd2CqwA0h1YS7ausQcattsrUckPU2CmK1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the aspeed-g6-pwm-tacho driver to further changes of the
pwm core outlined in the commit introducing devm_pwmchip_alloc(). There
is no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/hwmon/aspeed-g6-pwm-tach.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 64def5e4cdf6..332c02216668 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -136,7 +136,6 @@ struct aspeed_pwm_tach_data {
 	struct clk *clk;
 	struct reset_control *reset;
 	unsigned long clk_rate;
-	struct pwm_chip chip;
 	bool tach_present[TACH_ASPEED_NR_TACHS];
 	u32 tach_divisor;
 };
@@ -144,7 +143,7 @@ struct aspeed_pwm_tach_data {
 static inline struct aspeed_pwm_tach_data *
 aspeed_pwm_chip_to_data(struct pwm_chip *chip)
 {
-	return container_of(chip, struct aspeed_pwm_tach_data, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int aspeed_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -459,6 +458,7 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 	int ret;
 	struct device_node *child;
 	struct aspeed_pwm_tach_data *priv;
+	struct pwm_chip *chip;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -487,11 +487,14 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &aspeed_pwm_ops;
-	priv->chip.npwm = PWM_ASPEED_NR_PWMS;
+	chip = devm_pwmchip_alloc(dev, PWM_ASPEED_NR_PWMS, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	pwmchip_set_drvdata(chip, priv);
+	chip->ops = &aspeed_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
 
-- 
2.43.0


