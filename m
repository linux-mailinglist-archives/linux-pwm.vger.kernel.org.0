Return-Path: <linux-pwm+bounces-411-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8CC806ED5
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444BB281BF3
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD2934CEF;
	Wed,  6 Dec 2023 11:49:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC85D50
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOP-0007j6-NI; Wed, 06 Dec 2023 12:48:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqON-00DwyB-QH; Wed, 06 Dec 2023 12:48:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqON-00FR3e-Gt; Wed, 06 Dec 2023 12:48:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <keescook@chromium.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	linux-leds@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 108/115] leds: qcom-lpg: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:45:02 +0100
Message-ID:  <60605623e9e41d6f4b25e9c0eaf09d99bbc825f2.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=pvhY4Y0JLdiqVhBwOjMIbLiR5NL0oEVp+2u1SCdBGyk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF9X2vmR/YE9bA6uWt931rHgfeSo8ftDHS2tD 7l9+gb7i9OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfVwAKCRCPgPtYfRL+ TrqiB/45axpfyNtYf+7C1G/VIJWVX/ii239LT4Fp4h0AhOHiWH0JfGRchNca4IVSz6ykrreNp7q x3ZBzmIguPHrXbLIB2nEVhmTsHk2020lq8gfm7ztUtDoFVzsRK5E9kyf+TEemf5shzdLiU3n8YN 0pkRP3FmQq9XYn7RU8nyuC2gv+vhZu438vqJ0X7h7CiUXmOrU9guhYVPSB/rRLyuRXLRfsePW7Y 66gCrvTa34U9LNE/E8axYBqv6XWSZVe4JfahnuZ0rU7Ota1Z2aVy6sPgvvrINubhVnXMH9LMMHd dM9UbNF+GYD79neO6yszxU9Rv0TnvLBObXXliwxgRSFtGAMW
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm sub-driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 156b73d1f4a2..0a7acf59a420 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -77,7 +77,7 @@ struct lpg {
 
 	struct mutex lock;
 
-	struct pwm_chip pwm;
+	struct pwm_chip *pwm;
 
 	const struct lpg_data *data;
 
@@ -978,7 +978,7 @@ static int lpg_pattern_mc_clear(struct led_classdev *cdev)
 
 static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lpg, pwm);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -1093,13 +1093,17 @@ static const struct pwm_ops lpg_pwm_ops = {
 
 static int lpg_add_pwm(struct lpg *lpg)
 {
+	struct pwm_chip *chip;
 	int ret;
 
-	lpg->pwm.dev = lpg->dev;
-	lpg->pwm.npwm = lpg->num_channels;
-	lpg->pwm.ops = &lpg_pwm_ops;
+	lpg->pwm = chip = devm_pwmchip_alloc(lpg->dev, lpg->num_channels, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	ret = devm_pwmchip_add(lpg->dev, &lpg->pwm);
+	chip->ops = &lpg_pwm_ops;
+	pwmchip_set_drvdata(chip, lpg);
+
+	ret = devm_pwmchip_add(lpg->dev, chip);
 	if (ret)
 		dev_err_probe(lpg->dev, ret, "failed to add PWM chip\n");
 
-- 
2.42.0


