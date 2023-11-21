Return-Path: <linux-pwm+bounces-43-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD507F2F84
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F212FB20EAB
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CD953801;
	Tue, 21 Nov 2023 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB610D5
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAS-0005XY-FC; Tue, 21 Nov 2023 14:51:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAQ-00Aazb-U1; Tue, 21 Nov 2023 14:51:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAQ-004xe5-L8; Tue, 21 Nov 2023 14:51:54 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 050/108] pwm: crc: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:52 +0100
Message-ID: <20231121134901.208535-51-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=asN3OQZ6Hhkc4vNJgvfexJV8KxWJpq068DbL7i11wpA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWDmzTTKcVQAE6+0QpWN23xXVP7JpN1GUb1a 3TaSPQfApaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1gwAKCRCPgPtYfRL+ TmjYCACR7zTJLVhiQA832eV7vyfkGtGDzPcinApr7ebR+KTMpbriVereHsRveg3hLVR2nkaOm+4 enZKarMqrwTruzRlraqe97ATE9oHA1vOTlfNwn6O2PeoxQ3FNkHw5liLv3Fatu1ecWcTwWgEX7W UjIHd+bgsoO6s+wjUSBo082VmMKtSX7oL6/54UPTs6gV9wRX5ajViZIds4Wi0iVGjyf5cdh3O9T eN4bq/ImtPO4KDmG8vXgZeFiWbbWwL1nzlVlGpsAkQWtf6grR84gRcGXKNFjpqyw90HCvTtpvqE U2KlHOwhddpYKaNNMWT1FqYqFVGrpjs5e4enFM8ZqbMdxT7N
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
 drivers/pwm/pwm-crc.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index d08c3112aaba..27cde9be90b3 100644
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
+	return pwmchip_priv(chip);
 }
 
 static int crc_pwm_calc_clk_div(int period_ns)
@@ -160,22 +158,22 @@ static const struct pwm_ops crc_pwm_ops = {
 
 static int crystalcove_pwm_probe(struct platform_device *pdev)
 {
-	struct crystalcove_pwm *pwm;
+	struct pwm_chip *chip;
+	struct crystalcove_pwm *crc_pwm;
 	struct device *dev = pdev->dev.parent;
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
 
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*crc_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	crc_pwm = to_crc_pwm(chip);
 
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &crc_pwm_ops;
-	pwm->chip.npwm = 1;
+	chip->ops = &crc_pwm_ops;
 
 	/* get the PMIC regmap */
-	pwm->regmap = pmic->regmap;
+	crc_pwm->regmap = pmic->regmap;
 
-	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver crystalcove_pwm_driver = {
-- 
2.42.0


