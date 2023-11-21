Return-Path: <linux-pwm+bounces-42-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C46E7F2F75
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6201C214EC
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE0253805;
	Tue, 21 Nov 2023 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319BFD7C
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-0005Pl-Kr; Tue, 21 Nov 2023 14:51:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-00Aayp-8U; Tue, 21 Nov 2023 14:51:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAN-004xdI-W0; Tue, 21 Nov 2023 14:51:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 038/108] pwm: ab8500: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:40 +0100
Message-ID: <20231121134901.208535-39-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iuOiOOR77ki3z9y7/Se6t+44wfrdR9+cG1nAMH6IJEc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLV2rHyCygjRpSdPjgYowjkodl8XG2o63BTWv O29IMn1h1WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1dgAKCRCPgPtYfRL+ TnqsCACC1AzjuRfb8RQ6wL9Ymdsb1z7ldP1TbH7n//80iCX3HM3LIWhALL+QMfHmYQ/cVZ96Zoo RLFgLYGquHwtwHGIdlA8sWxx6GmAt12iSnZUgjVh9nyPce7hGiPaEc6H/0l7FI+BDgEH0Cr1dbW hVpdqbEIvrwviiaOhk4cFPdLSF37SKn82fEwelIJYdgNXfEakAtLo/7r9GinGOpFsScXWSh55WH bwAK+FVfTxEkTd8W7uBbSzmJQSubp0YosN4n4n6dX4S/VBuZQCrH9Nem97x/KZpYeeCG+jgDFm+ YOMjS2Vy2++lo8WScGxu690ax+PdoBoWmFJhbpODLhI1k5ln
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-ab8500 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 719e4ccf1800..f642103931c7 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -24,13 +24,12 @@
 #define AB8500_PWM_CLKRATE 9600000
 
 struct ab8500_pwm_chip {
-	struct pwm_chip chip;
 	unsigned int hwid;
 };
 
 static struct ab8500_pwm_chip *ab8500_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ab8500_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -185,6 +184,7 @@ static const struct pwm_ops ab8500_pwm_ops = {
 
 static int ab8500_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct ab8500_pwm_chip *ab8500;
 	int err;
 
@@ -195,16 +195,16 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	 * Nothing to be done in probe, this is required to get the
 	 * device which is required for ab8500 read and write
 	 */
-	ab8500 = devm_kzalloc(&pdev->dev, sizeof(*ab8500), GFP_KERNEL);
-	if (ab8500 == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*ab8500));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	ab8500->chip.dev = &pdev->dev;
-	ab8500->chip.ops = &ab8500_pwm_ops;
-	ab8500->chip.npwm = 1;
+	ab8500 = pwmchip_priv(chip);
+
+	chip->ops = &ab8500_pwm_ops;
 	ab8500->hwid = pdev->id - 1;
 
-	err = devm_pwmchip_add(&pdev->dev, &ab8500->chip);
+	err = devm_pwmchip_add(&pdev->dev, chip);
 	if (err < 0)
 		return dev_err_probe(&pdev->dev, err, "Failed to add pwm chip\n");
 
-- 
2.42.0


