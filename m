Return-Path: <linux-pwm+bounces-404-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF348806ECE
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621191F21657
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FBD34CFA;
	Wed,  6 Dec 2023 11:49:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D1D6E
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOP-0007e1-6T; Wed, 06 Dec 2023 12:48:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00Dwxl-K4; Wed, 06 Dec 2023 12:48:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOM-00FR3C-BP; Wed, 06 Dec 2023 12:48:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 101/115] pwm: twl-led: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:55 +0100
Message-ID:  <8c5f535bec16c031e3992c107d45bf0835b8813d.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1CGw8jsJZF22p/+aYL70RuhQ6opjvn+E75DFJq1kGfc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF8/0JFzitdYwHZAFO/qYp5O5Y3QycnbMQkh3 HPT6cCVGv+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfPwAKCRCPgPtYfRL+ TlzFB/0eH9vb4dhoZ2N4mfygoB36QjVuNhgMhRbQ7xJg7/lQgteHmkLbRThwTstdvfAHp9s1nyG Bfd7F1655b/1UcGqHV+srcLIz+oE9q0CzAi67DKUQGLa/BcKWTQJtolNsqkAhBZ+lc6El0aLlcL sMF7Iwy5bO0ULDxEhk1wiQt6OYUXs/+bTweff5kKYudr2+3EHosoVdZdmnZKIoAW36OBxbk+X32 dsBsEUuc+Wk3+qquXsuwnZhndU+xYoOJRekKs9tbr/Cv5cKy7misjwTtWpAAmYdUQa7ZNc/gcu8 lStWITA8tPsMsGTw1UHY68ZYmXhd33q7mOGrTttDqA4loTMd
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
index 51a2f34b0e0c..6f1b36d2ff70 100644
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


