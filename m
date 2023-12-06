Return-Path: <linux-pwm+bounces-361-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7535E806EA0
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F911F21653
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19702358A8;
	Wed,  6 Dec 2023 11:48:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3F110C4
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOG-0006h5-4o; Wed, 06 Dec 2023 12:48:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOD-00Dwus-Sc; Wed, 06 Dec 2023 12:48:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOD-00FR08-Ja; Wed, 06 Dec 2023 12:48:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 056/115] pwm: crc: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:10 +0100
Message-ID:  <ebb9d544a0a4350812dba7d1076f19ae8b25ae0d.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=2vytv7M2c+tJ9NwnqLqefxSF0hybTzP7MpNKUdZrs94=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6nNEknttBafC/Ov6g3W9YynLlT+p5nndYyc N4zPGsZVjyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBepwAKCRCPgPtYfRL+ TuNfB/40qzM4JirCBMfDS1EJHZaHcSxmbpej2o3TnxNX9Jr8tanZW82yljlW7QDcllHkxAFLP/9 fQAvG3r4EBXvnsSQswiNb49XuywiMD/9CWgETgbU5Rc4YWAKja/A5OEOZhwB4+68gtuwxTDHHnT +aZc9MbgF9Q+9i3uodUaatTLARrfQPBZVRczSm8CREU9ONfr25c/zhspr00oJeblNDApF2NonmO 0zyqsLfOHIUhTzcB6nFZXhFvnJrCCK7sDGAHRXtvyqxw5CQL2QfYp5aJbU/I5gtcIkBBk/Ako71 AYL22U/wp7pVTtrX+AocayZ6HB1YVAd2jrFaoTD1CmVifBAs
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-crc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-crc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index c8a852345a97..98ee5cdbd0ba 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -26,17 +26,15 @@
 
 /**
  * struct crystalcove_pwm - Crystal Cove PWM controller
- * @chip: the abstract pwm_chip structure.
  * @regmap: the regmap from the parent device.
  */
 struct crystalcove_pwm {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 };
 
 static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct crystalcove_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int crc_pwm_calc_clk_div(int period_ns)
@@ -160,22 +158,22 @@ static const struct pwm_ops crc_pwm_ops = {
 
 static int crystalcove_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct crystalcove_pwm *crc_pwm;
 	struct device *dev = pdev->dev.parent;
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
-	crc_pwm = devm_kzalloc(&pdev->dev, sizeof(*crc_pwm), GFP_KERNEL);
-	if (!crc_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*crc_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	crc_pwm = to_crc_pwm(chip);
 
-	crc_pwm->chip.dev = &pdev->dev;
-	crc_pwm->chip.ops = &crc_pwm_ops;
-	crc_pwm->chip.npwm = 1;
+	chip->ops = &crc_pwm_ops;
 
 	/* get the PMIC regmap */
 	crc_pwm->regmap = pmic->regmap;
 
-	return devm_pwmchip_add(&pdev->dev, &crc_pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver crystalcove_pwm_driver = {
-- 
2.42.0


