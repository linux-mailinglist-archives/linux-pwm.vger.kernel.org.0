Return-Path: <linux-pwm+bounces-342-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA6D806E80
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5401C20BB2
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269723457C;
	Wed,  6 Dec 2023 11:48:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA79137
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOC-0006QJ-G0; Wed, 06 Dec 2023 12:48:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOB-00Dwu9-Sy; Wed, 06 Dec 2023 12:48:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOB-00FQzM-K6; Wed, 06 Dec 2023 12:48:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 044/115] pwm: ab8500: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:43:58 +0100
Message-ID:  <ec02fc2671420a2dce401be5506ad041bb44d817.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=EpaqVKfoXGh212IAe6dkd/Asvh1/g9kSGFS62OE534E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6U0+9FWnqMv49gGBKB56godFKxKlZOGZqPq v08WVpPScSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBelAAKCRCPgPtYfRL+ ThiYCACYtee3Oj2fboGhvK5DYoeKJ3R96b2LHxFGAb9es8/FZc8zOOYEBB7VF4sQDUoZ8LAs7zG APNJLRfr43bLko/ItZdVKvfRxjau6d//LvQSTtvYkPAwCFfjj2uHW/FZflbS6Aa16oTAh/X3SlZ iKXcIILgYGEvFCqMxSNGTuGL/7+gbjS88+0goByJ2ZhxWkP2pD1fRYZObgyLK+bnGMavzPv4y57 l9e7jkawr8RhiLl1FhVwoeks7hpMe2kQh0W8LnpM3OQWgEK6aqckjp/ELw+ZmP9Ir7YW1KREYjy w4CFsvbnjws7kZ7p+dhdKcPgTc5NK0jxqBvdb9dg4D1L/GZj
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
index 719e4ccf1800..f000adab85b0 100644
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
+	return pwmchip_get_drvdata(chip);
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
+	ab8500 = ab8500_pwm_from_chip(chip);
+
+	chip->ops = &ab8500_pwm_ops;
 	ab8500->hwid = pdev->id - 1;
 
-	err = devm_pwmchip_add(&pdev->dev, &ab8500->chip);
+	err = devm_pwmchip_add(&pdev->dev, chip);
 	if (err < 0)
 		return dev_err_probe(&pdev->dev, err, "Failed to add pwm chip\n");
 
-- 
2.42.0


