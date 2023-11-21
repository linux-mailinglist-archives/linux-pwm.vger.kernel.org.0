Return-Path: <linux-pwm+bounces-61-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B96A7F2F94
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEA38B20D48
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264AC54F84;
	Tue, 21 Nov 2023 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B102D10EC
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAW-0005tQ-FB; Tue, 21 Nov 2023 14:52:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAU-00Ab0N-3J; Tue, 21 Nov 2023 14:51:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAT-004xf9-QW; Tue, 21 Nov 2023 14:51:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 064/108] pwm: lp3943: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:06 +0100
Message-ID: <20231121134901.208535-65-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=nmbYPiEX73YZqU9wYOiRPHISAgyO5+Qz7Jmrgty0MT4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWT4Yra4RzGD/94mpDfTEsugXcQsoV7qO7ON Rn1S16BFFaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1kwAKCRCPgPtYfRL+ TnZpB/9tcaWJlLYdBiorZ8XF1hnUJlrLOo/Z15p0VOh1tJATRNE0Bgygi54ioe8sVKaKcVHpx3v 2lAhAyl4ufkdrI0+dbC2U+y6no7ml+IjAt35Xkf6YNVW2UB63WrAPbyIeD0dxl3HXsnnlm4FtMb PPHgstc7wKYZUJdyllHa6ygUnURv1hIKFz2L5VSndWFAlg9d8NqsqpdYl7JfmMn5usqRB6NtPpV k9hew9J6+aVdo170DFXuySc0aetCGcudiEI5CHvN9eIEMNL/7K+fn8HZ2ri07v9s8q9r7AV+cy8 NoP8DfWtaPPLL4lNQ5xDELOzPb8pnz5UWZ6r6FLkHTwksRWP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-lp3943 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lp3943.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 32350a357278..c8d728a6259c 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -20,7 +20,6 @@
 #define LP3943_MAX_PERIOD		1600000
 
 struct lp3943_pwm {
-	struct pwm_chip chip;
 	struct lp3943 *lp3943;
 	struct lp3943_platform_data *pdata;
 	struct lp3943_pwm_map pwm_map[LP3943_NUM_PWMS];
@@ -28,7 +27,7 @@ struct lp3943_pwm {
 
 static inline struct lp3943_pwm *to_lp3943_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lp3943_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static struct lp3943_pwm_map *
@@ -273,12 +272,14 @@ static int lp3943_pwm_parse_dt(struct device *dev,
 static int lp3943_pwm_probe(struct platform_device *pdev)
 {
 	struct lp3943 *lp3943 = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct lp3943_pwm *lp3943_pwm;
 	int ret;
 
-	lp3943_pwm = devm_kzalloc(&pdev->dev, sizeof(*lp3943_pwm), GFP_KERNEL);
-	if (!lp3943_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, LP3943_NUM_PWMS, sizeof(*lp3943_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	lp3943_pwm = to_lp3943_pwm(chip);
 
 	lp3943_pwm->pdata = lp3943->pdata;
 	if (!lp3943_pwm->pdata) {
@@ -292,11 +293,9 @@ static int lp3943_pwm_probe(struct platform_device *pdev)
 	}
 
 	lp3943_pwm->lp3943 = lp3943;
-	lp3943_pwm->chip.dev = &pdev->dev;
-	lp3943_pwm->chip.ops = &lp3943_pwm_ops;
-	lp3943_pwm->chip.npwm = LP3943_NUM_PWMS;
+	chip->ops = &lp3943_pwm_ops;
 
-	return devm_pwmchip_add(&pdev->dev, &lp3943_pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 #ifdef CONFIG_OF
-- 
2.42.0


