Return-Path: <linux-pwm+bounces-362-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42608806E9E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB725281BE1
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D2358AE;
	Wed,  6 Dec 2023 11:48:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C709D5A
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:39 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOJ-000791-PW; Wed, 06 Dec 2023 12:48:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-00DwwE-JN; Wed, 06 Dec 2023 12:48:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOH-00FR1h-AR; Wed, 06 Dec 2023 12:48:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	=?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 079/115] pwm: ntxec: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:33 +0100
Message-ID:  <a35d505459f0b827366f923f26f1ff537b2d6341.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=FDvnmRAPIVu9NM3Nf0eOa7RbHwU7rhxKOHj0vx8ZU4A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF75TrWSKCEQWSQLqJ9bUFjoR5yeRqHA79A+J W9SYqN4jzKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBe+QAKCRCPgPtYfRL+ TleEB/9YvykvJ4p9klHzyvU4f64ZgnL7TZOemzvlRzpJCVy1Tftoog0vDrUUyc1fTn763MVhNVF WD/cHv0N7BzG8ou8/9Ui4Pj9wpP9Imi6VilQX2I6YB4AMdGwitio4OI/9ylrieSf5+Zx5d0EJu5 Cv8zzI5/hk+CUA7/MUrhHigp5NFFitWm6lqmChFyXREDJGBY+IJDHPYrbNUZhKFbY/4ooIlyIua BcONOkiB8EdjsM9fUXbnROp9s8FIhr6gCfYfuXh8Ch2lZLjFZncr+FkKMVn/LBBvjFKILc6ZOhe NMjT8LGe1tqDOXK77OTADSYL0SzU699plp3oa/w3u5qQSr0V
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-ntxec driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ntxec.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
index 78606039eda2..4cc019a0c4ef 100644
--- a/drivers/pwm/pwm-ntxec.c
+++ b/drivers/pwm/pwm-ntxec.c
@@ -25,12 +25,11 @@
 
 struct ntxec_pwm {
 	struct ntxec *ec;
-	struct pwm_chip chip;
 };
 
 static struct ntxec_pwm *ntxec_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ntxec_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 #define NTXEC_REG_AUTO_OFF_HI	0xa1
@@ -57,7 +56,7 @@ static struct ntxec_pwm *ntxec_pwm_from_chip(struct pwm_chip *chip)
 static int ntxec_pwm_set_raw_period_and_duty_cycle(struct pwm_chip *chip,
 						   int period, int duty)
 {
-	struct ntxec_pwm *priv = ntxec_pwm_from_chip(chip);
+	struct ntxec *ec = ntxec_pwm_from_chip(chip)->ec;
 
 	/*
 	 * Changes to the period and duty cycle take effect as soon as the
@@ -77,13 +76,13 @@ static int ntxec_pwm_set_raw_period_and_duty_cycle(struct pwm_chip *chip,
 		{ NTXEC_REG_DUTY_LOW, ntxec_reg8(duty) },
 	};
 
-	return regmap_multi_reg_write(priv->ec->regmap, regs, ARRAY_SIZE(regs));
+	return regmap_multi_reg_write(ec->regmap, regs, ARRAY_SIZE(regs));
 }
 
 static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm_dev,
 			   const struct pwm_state *state)
 {
-	struct ntxec_pwm *priv = ntxec_pwm_from_chip(chip);
+	struct ntxec *ec = ntxec_pwm_from_chip(chip)->ec;
 	unsigned int period, duty;
 	int res;
 
@@ -110,18 +109,18 @@ static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm_dev,
 		if (res)
 			return res;
 
-		res = regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1));
+		res = regmap_write(ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1));
 		if (res)
 			return res;
 
 		/* Disable the auto-off timer */
-		res = regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_reg8(0xff));
+		res = regmap_write(ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_reg8(0xff));
 		if (res)
 			return res;
 
-		return regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg8(0xff));
+		return regmap_write(ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg8(0xff));
 	} else {
-		return regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
+		return regmap_write(ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
 	}
 }
 
@@ -135,22 +134,19 @@ static const struct pwm_ops ntxec_pwm_ops = {
 
 static int ntxec_pwm_probe(struct platform_device *pdev)
 {
-	struct ntxec *ec = dev_get_drvdata(pdev->dev.parent);
 	struct ntxec_pwm *priv;
 	struct pwm_chip *chip;
 
 	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = ntxec_pwm_from_chip(chip);
 
-	priv->ec = ec;
+	priv->ec = dev_get_drvdata(pdev->dev.parent);
 
-	chip = &priv->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &ntxec_pwm_ops;
-	chip->npwm = 1;
 
 	return devm_pwmchip_add(&pdev->dev, chip);
 }
-- 
2.42.0


