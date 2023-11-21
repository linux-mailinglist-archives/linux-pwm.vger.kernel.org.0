Return-Path: <linux-pwm+bounces-90-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B067F2FAF
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB831F24422
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9052953800;
	Tue, 21 Nov 2023 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C5710D3
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-0006WK-Ee; Tue, 21 Nov 2023 14:52:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAb-00Ab2O-1W; Tue, 21 Nov 2023 14:52:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAa-004xhJ-Oi; Tue, 21 Nov 2023 14:52:04 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 095/108] pwm: twl-led: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:37 +0100
Message-ID: <20231121134901.208535-96-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=nii58utaHBqG9hIG3F2ztT/5M/S4TlWsZCz8MweGyPs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLW1CFKFIKQ00X0H2DnZ/6ChFuzehO54XUSOK JDPNpn96JqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1tQAKCRCPgPtYfRL+ TsT0B/9ONOx16m64JhjnaoZZWmq69HNejBI6kqZptZwujbfxOB4gEE+eJeYVT3pUva6r1JCS9g6 CPSvHtrDBKYSebDNFtlJPmRwUOuooG6op1CSMYd8CpkQwU5gqqw2EHmUYjHT7tF3w+E1xXF/Ik3 iS4Yw7rRoLO4rvJJGzelA5jthTEWH9Jd8RePgltfU+yFxZyPTO8hIkDjZ6rfTDw+1WUfP0bO8ED O6vLYAXfgbWPoUFgerMt/cXl+kdWCQO3/DYJ/CHrK87QmOVfhIgB8PC5VrSsggkjwijQbp1/7Nl 8piFevpiZiVZha0g2/I50CA5b+PKTppIWKc745eB2dZf61wa
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
index f1a9f04295ea..692f761affd3 100644
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
+	return pwmchip_priv(chip);
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
2.42.0


