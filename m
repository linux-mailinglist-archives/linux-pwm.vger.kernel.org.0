Return-Path: <linux-pwm+bounces-1341-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2CF854597
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FDB1F2E030
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3C518AEE;
	Wed, 14 Feb 2024 09:34:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A70E1758C
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903268; cv=none; b=BzVWIQ84DDuiH/4m1UFcg1diqSsPJBwaKuoUAHeOeXXfCT7ZaT+kXM7QgL5gZl7piZ/veBNYXaAYgl753LYiaP+i74OljukoZYB8fB1ZWRqm54w+MIPGiaAXO4MEtU+JiiU6BWobJ6hMSK72/TzAnVC8HkVMlutSu8S8MKhW8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903268; c=relaxed/simple;
	bh=pjKoJkt5G+itH9Jr1SgwiTak3mbHW/dnYfYfs2bBN4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6++iFFn9/K14G+//wK8MdpjZRz2wwxG6z6MLoKRO7EbG8rgU5VU4bLXAX21vOxujDkebR8jTtvDdJBUAX86ag/I1e76vKWSFAau7SqyhF76YtgkV+/yi76yY2mpipgLQAB5PUrk/+JfoQaTTac6iGI0eMrWGxvYNh5BqVdqRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-0004Ps-8D; Wed, 14 Feb 2024 10:34:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-000f7r-NV; Wed, 14 Feb 2024 10:34:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-004Y0R-23;
	Wed, 14 Feb 2024 10:34:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 012/164] pwm: atmel-hlcdc: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:30:59 +0100
Message-ID:  <4724c6a0f052160ac80ba5a3065c9470778b7457.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=pjKoJkt5G+itH9Jr1SgwiTak3mbHW/dnYfYfs2bBN4c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhY0l7YwWooXdOfVU20R+As1H4e9TLg+C2iv 0yO8QQczfaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIWAAKCRCPgPtYfRL+ TrPkB/wOTyGmtX0w6/vg5cKxJ+nHqovMrGUdwcAivWQhlzYE/bqXkcBKLJNxjWBl2ww7Two6GJD JTEFUde6gJE4Bx4GEM+6Tj78MFLZdhjVf1vzX1LGY541KRUelkE+22eg1Nju2h88GG6vS7y2mVq hJHpOkMBA+x2o7vT6PY0XXjR6ba86zGC2dkSfs9vZgUX1f1Hs7OYhQIfTPKQGtXn37+ziTRh064 H9AQjAjiEvYlkxX6LdlGKuk4sccsS/8VAHOp+Hdvq99N4sReDk3dKX8UHOkSqIiyxKb/QvYi16R UaUJ09LwdRLjxkyaDw2HM1eIz1yVVDafTGeFTzwsr2BkZKhG
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-atmel-hlcdc driver to further changes of the pwm
core outlined in the commit introducing devm_pwmchip_alloc(). There is
no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index f3f6c951bda5..166f1d16aba6 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -28,7 +28,6 @@ struct atmel_hlcdc_pwm_errata {
 };
 
 struct atmel_hlcdc_pwm {
-	struct pwm_chip chip;
 	struct atmel_hlcdc *hlcdc;
 	struct clk *cur_clk;
 	const struct atmel_hlcdc_pwm_errata *errata;
@@ -36,7 +35,7 @@ struct atmel_hlcdc_pwm {
 
 static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct atmel_hlcdc_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int atmel_hlcdc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -251,9 +250,10 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 
 	hlcdc = dev_get_drvdata(dev->parent);
 
-	atmel = devm_kzalloc(dev, sizeof(*atmel), GFP_KERNEL);
-	if (!atmel)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*atmel));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	atmel = to_atmel_hlcdc_pwm(chip);
 
 	ret = clk_prepare_enable(hlcdc->periph_clk);
 	if (ret)
@@ -264,10 +264,7 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 		atmel->errata = match->data;
 
 	atmel->hlcdc = hlcdc;
-	chip = &atmel->chip;
 	chip->ops = &atmel_hlcdc_pwm_ops;
-	chip->dev = dev;
-	chip->npwm = 1;
 
 	ret = pwmchip_add(chip);
 	if (ret) {
-- 
2.43.0


