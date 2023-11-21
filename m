Return-Path: <linux-pwm+bounces-107-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 589207F2FBD
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FB31C21055
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC8E53801;
	Tue, 21 Nov 2023 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00207D7C
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAe-0006eH-Je; Tue, 21 Nov 2023 14:52:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-00Ab2v-T8; Tue, 21 Nov 2023 14:52:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAc-004xhl-Jn; Tue, 21 Nov 2023 14:52:06 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anjelique Melendez <quic_amelende@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Luca Weiss <luca@z3ntu.xyz>,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: linux-leds@vger.kernel.org,
	kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v3 102/108] leds: qcom-lpg: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:44 +0100
Message-ID: <20231121134901.208535-103-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3001; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=eAbaYjwwA0OCRDz5SvWK/v3AsL31VL6v2iCjmT5Ike4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLW8sLmi1+n87lDEoRDBM90YgeTHdjiVYe2De zbidZFqFL2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1vAAKCRCPgPtYfRL+ TigcB/9L1xCZTZZjdkxEICYJTnI13LgdX9pW8OdKlmv7l6967Dpa4c9olmexvixRQScFfvXffEX rd8ByZsH44fXxJzbS5mvmoHD/pr+Fz6FUhxb4eH4Fmi8P1VAdo+B6sgD9Qug6F3gXNUDmy+L+Yy ioig77q1JXU0XUuGcPaWY6mfFoAPwO+dqQMYujKaAs35GYkB/J/7gx8ABX3BgqR06BbQRvUQFmH 6f06MRgp24ks9RJVPrYvrxqAzZFmVKokcQ7SHaFjAcX97kyNFChjGYqboc11obhvx0GmO9zBwDM zS37ALEJTrQMo6COiGjUtdRPhXXLN50XLxHOlhwW0CP7SQkJ
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
 drivers/leds/rgb/leds-qcom-lpg.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 68d82a682bf6..283227e02df6 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -77,7 +77,7 @@ struct lpg {
 
 	struct mutex lock;
 
-	struct pwm_chip pwm;
+	struct pwm_chip *pwm;
 
 	const struct lpg_data *data;
 
@@ -977,9 +977,15 @@ static int lpg_pattern_mc_clear(struct led_classdev *cdev)
 	return lpg_pattern_clear(led);
 }
 
+static inline struct lpg *lpg_pwm_from_chip(struct pwm_chip *chip)
+{
+	struct lpg **lpg = pwmchip_priv(chip);
+	return *lpg;
+}
+
 static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg *lpg = lpg_pwm_from_chip(chip);
 	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
 
 	return chan->in_use ? -EBUSY : 0;
@@ -995,7 +1001,7 @@ static int lpg_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
-	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg *lpg = lpg_pwm_from_chip(chip);
 	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
 	int ret = 0;
 
@@ -1026,7 +1032,7 @@ static int lpg_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			     struct pwm_state *state)
 {
-	struct lpg *lpg = container_of(chip, struct lpg, pwm);
+	struct lpg *lpg = lpg_pwm_from_chip(chip);
 	struct lpg_channel *chan = &lpg->channels[pwm->hwpwm];
 	unsigned int resolution;
 	unsigned int pre_div;
@@ -1089,13 +1095,19 @@ static const struct pwm_ops lpg_pwm_ops = {
 
 static int lpg_add_pwm(struct lpg *lpg)
 {
+	struct pwm_chip *chip;
 	int ret;
 
-	lpg->pwm.dev = lpg->dev;
-	lpg->pwm.npwm = lpg->num_channels;
-	lpg->pwm.ops = &lpg_pwm_ops;
+	lpg->pwm = chip = devm_pwmchip_alloc(lpg->dev, lpg->num_channels,
+					     sizeof(&lpg));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	ret = pwmchip_add(&lpg->pwm);
+	*(struct lpg **)pwmchip_priv(chip) = lpg;
+
+	chip->ops = &lpg_pwm_ops;
+
+	ret = pwmchip_add(chip);
 	if (ret)
 		dev_err(lpg->dev, "failed to add PWM chip: ret %d\n", ret);
 
@@ -1367,7 +1379,7 @@ static void lpg_remove(struct platform_device *pdev)
 {
 	struct lpg *lpg = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&lpg->pwm);
+	pwmchip_remove(lpg->pwm);
 }
 
 static const struct lpg_data pm8916_pwm_data = {
-- 
2.42.0


