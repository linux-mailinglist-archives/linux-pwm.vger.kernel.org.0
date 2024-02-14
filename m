Return-Path: <linux-pwm+bounces-1467-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CE0854629
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24431F2E0FA
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736BE19475;
	Wed, 14 Feb 2024 09:34:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931C1B7F9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903293; cv=none; b=CJBgBlJQEu1CBKXDJDnynUtiD20hMmeNrG6oLBVrv2RMlfWgiPX4l45GSAl8ROcXVDd78X82FTf/nI2FbxgdFoz6w3QLD0+2fHfHowCQah2UjbwJOMrmr4gSfDNfJo/WqpJR9jBGudVqTZVTdXJjSzjvk3fi9S1qspCw8bEJmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903293; c=relaxed/simple;
	bh=ykM/0pTSoAze6ExRrtg9M0BB3BcG5phvjAVUEqck2Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXmiXE+o38OKfqBF5y8hhHBTqwJ+PaR2ieqCRJEeYT8ViC4GTse/494ahsL292lBU16sE7et5p6KSRNjOljrT/Hc5gIUfUEHngrFgRk3Arj8U/avMNGApJUT4BrO/U/ezcAtar31tJqBTSq5fAd7jNJRpfeHL978y4+SdygDkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf9-000674-GG; Wed, 14 Feb 2024 10:34:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-000fHc-PS; Wed, 14 Feb 2024 10:34:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-004Y9X-2H;
	Wed, 14 Feb 2024 10:34:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 143/164] pwm: twl-led: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:10 +0100
Message-ID:  <5bac90addb3a178ef958a2a524c6ec7e3eea3e6a.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ykM/0pTSoAze6ExRrtg9M0BB3BcG5phvjAVUEqck2Bw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjv54IR4gE6zf1rFrGBWFFlhdA2ZelnbgIzh T/sap0UKqaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI7wAKCRCPgPtYfRL+ Tu13CAClSS7IuxRqSl7gEq+lhwpsHCAInWFW4BcQBDic9//yvA6dvcP9hdpAdpmDyqGJSAHCNYp y7yqZiufvW3Nrl3f7nL0SuKDAOh9oEezXebDPNR6cXDH0W28eIWp9NYXRyrDrkr7C0kDd4Dug4W WUi50eLXpYaLPGuC80uIbaez1TqkbCh4Z7zv78Kb9XZiQXcVeYQGQ0Dd9uiXf11JHteVRv6OWWL U9fSHpMGokYlSsuZ8/D1q7djR81HWghFdvutPKlxfbIeZ09rsHtcKLKbfbp96+SCUshK4+jciCd 6JbplCF24LX0ZepO/iXsdR9xfcMvu2b54xoTxfeVAt821Qef
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
 drivers/pwm/pwm-twl-led.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 00ef798dae52..4b10a8dab312 100644
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
@@ -345,25 +344,29 @@ static const struct pwm_ops twl6030_pwmled_ops = {
 
 static int twl_pwmled_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct twl_pwmled_chip *twl;
-
-	twl = devm_kzalloc(&pdev->dev, sizeof(*twl), GFP_KERNEL);
-	if (!twl)
-		return -ENOMEM;
+	unsigned int npwm;
+	const struct pwm_ops *ops;
 
 	if (twl_class_is_4030()) {
-		twl->chip.ops = &twl4030_pwmled_ops;
-		twl->chip.npwm = 2;
+		ops = &twl4030_pwmled_ops;
+		npwm = 2;
 	} else {
-		twl->chip.ops = &twl6030_pwmled_ops;
-		twl->chip.npwm = 1;
+		ops = &twl6030_pwmled_ops;
+		npwm = 1;
 	}
 
-	twl->chip.dev = &pdev->dev;
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*twl));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	twl = to_twl(chip);
+
+	chip->ops = ops;
 
 	mutex_init(&twl->mutex);
 
-	return devm_pwmchip_add(&pdev->dev, &twl->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 #ifdef CONFIG_OF
-- 
2.43.0


