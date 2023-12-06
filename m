Return-Path: <linux-pwm+bounces-338-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AB4806E7E
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51D52B20E2A
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7CF34558;
	Wed,  6 Dec 2023 11:48:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866091A5
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:31 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO7-00060i-8L; Wed, 06 Dec 2023 12:48:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-00Dwrq-6L; Wed, 06 Dec 2023 12:48:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO5-00FQx1-TS; Wed, 06 Dec 2023 12:48:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 009/115] pwm: atmel: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:23 +0100
Message-ID:  <3b4d48109b6fcb9aecae030a9f9c879cd3ae0835.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2827; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=kchnmBeM6dTUrRyczIW+qjV7tOiXzRrzwU7RLUUbwus=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF5chU+b5D7vwTaJXn21pHe0sOg+Pdic6Sx/l lGxsIvJzLWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeXAAKCRCPgPtYfRL+ TqAhCACPRAs4FxPWUTac9ahYreoSAWs9bV1ny25mHhs66Q3qn0xp08BCyRI/nO4SFUzube/OQOe CBAJH1oxy86p0yxhLIYQmXaK2zCWdX4OPcxtGDhFrAHVhMKQ6EjnUuLWVrjsS9sBHQ8fyYl0bQW zOSt7nQWt7L42zgbH/JdaP9wT/A6QLcufapZmyyBZJHV0sCCYiLcg5PJls0caeEmrH9+ZH7VGfU L9Ie8O/On5s668h4xXVT8k2SBtxRFZu5svVnl3ITfW24FUwGJiKhHIKmhkvQvZieN/tT1mUC0Nl tCtM15lfcT4KUNNxklwxJ8ixN85GY/On6adhebV62o+HUfI2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 47bcc8a3bf9d..4ef91fe6f147 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -210,7 +210,7 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 	shift = fls(cycles) - atmel_pwm->data->cfg.period_bits;
 
 	if (shift > PWM_MAX_PRES) {
-		dev_err(chip->dev, "pres exceeds the maximum value\n");
+		dev_err(pwmchip_parent(chip), "pres exceeds the maximum value\n");
 		return -EINVAL;
 	} else if (shift > 0) {
 		*pres = shift;
@@ -321,7 +321,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = atmel_pwm_calculate_cprd_and_pres(chip, clkrate, state, &cprd,
 							&pres);
 		if (ret) {
-			dev_err(chip->dev,
+			dev_err(pwmchip_parent(chip),
 				"failed to calculate cprd and prescaler\n");
 			return ret;
 		}
@@ -333,7 +333,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		} else {
 			ret = clk_enable(atmel_pwm->clk);
 			if (ret) {
-				dev_err(chip->dev, "failed to enable clock\n");
+				dev_err(pwmchip_parent(chip), "failed to enable clock\n");
 				return ret;
 			}
 		}
@@ -462,8 +462,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
-static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
+static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
 {
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned int i, cnt = 0;
 	unsigned long sr;
 	int ret = 0;
@@ -480,7 +481,7 @@ static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
 	for (i = 0; i < cnt; i++) {
 		ret = clk_enable(atmel_pwm->clk);
 		if (ret) {
-			dev_err(atmel_pwm->chip.dev,
+			dev_err(pwmchip_parent(chip),
 				"failed to enable clock for pwm %pe\n",
 				ERR_PTR(ret));
 
@@ -525,7 +526,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 	atmel_pwm->chip.npwm = 4;
 
-	ret = atmel_pwm_enable_clk_if_on(atmel_pwm, true);
+	ret = atmel_pwm_enable_clk_if_on(&atmel_pwm->chip, true);
 	if (ret < 0)
 		return ret;
 
@@ -538,7 +539,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 disable_clk:
-	atmel_pwm_enable_clk_if_on(atmel_pwm, false);
+	atmel_pwm_enable_clk_if_on(&atmel_pwm->chip, false);
 
 	return ret;
 }
-- 
2.42.0


