Return-Path: <linux-pwm+bounces-59-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0D77F2F8A
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFE81C21953
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C488F537F5;
	Tue, 21 Nov 2023 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6971310DD
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-0005PL-CI; Tue, 21 Nov 2023 14:51:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAN-00Aayh-Tv; Tue, 21 Nov 2023 14:51:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAN-004xd1-Ks; Tue, 21 Nov 2023 14:51:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v3 036/108] staging: greybus: pwm: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:38 +0100
Message-ID: <20231121134901.208535-37-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7260; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jpdApB4VpVV6JyKzGy62ySXnPuypB5bG/1JU/y0CImA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLV0Lyj9BOUz8VOflfgEti2rfiRFVXeKtxY4p BmDrawxZuCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1dAAKCRCPgPtYfRL+ ThaQB/9B9muXTVxgkECFZ4/FsZt27L4vQfumMIZQpySvOl9v3vS2x+Diz/loNDqB9+ImhDXcMyc qt3x7kiIWjrgenu2shQ9YoWqBiAl1qtPePrOZ4+wSEXBbasXMmGHebvek5+XthkvAKa95wxSTgD h0i7Of9vWMHmwC+JU8N+KqGC16kbbTYnSd9jCACYRIItYPZvHKsB11NXkXOa8ZxUjcakYqm9E/d Z0gLMkX4K0juug75g0RUmCeDismJdE3drkxHp798qrTzoYgfUTh5x9Wdmj6W51JgNGCnN1PL5aN 8za6BLzByDc96eXEqP4NVMJ2Q2s332CvUeo0aXJY2RaikBOD
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
 drivers/staging/greybus/pwm.c | 55 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index a3cb68cfa0f9..75e0518791d8 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -17,7 +17,6 @@
 struct gb_pwm_chip {
 	struct gb_connection	*connection;
 	u8			pwm_max;	/* max pwm number */
-
 	struct pwm_chip		chip;
 };
 
@@ -39,9 +38,9 @@ static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
 	return 0;
 }
 
-static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
-				     u8 which)
+static int gb_pwm_activate_operation(struct pwm_chip *chip, u8 which)
 {
+	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 	struct gb_pwm_activate_request request;
 	struct gbphy_device *gbphy_dev;
 	int ret;
@@ -51,7 +50,7 @@ static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -64,9 +63,10 @@ static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
 	return ret;
 }
 
-static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
+static int gb_pwm_deactivate_operation(struct pwm_chip *chip,
 				       u8 which)
 {
+	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 	struct gb_pwm_deactivate_request request;
 	struct gbphy_device *gbphy_dev;
 	int ret;
@@ -76,7 +76,7 @@ static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -89,9 +89,10 @@ static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
 	return ret;
 }
 
-static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
+static int gb_pwm_config_operation(struct pwm_chip *chip,
 				   u8 which, u32 duty, u32 period)
 {
+	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 	struct gb_pwm_config_request request;
 	struct gbphy_device *gbphy_dev;
 	int ret;
@@ -103,7 +104,7 @@ static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
 	request.duty = cpu_to_le32(duty);
 	request.period = cpu_to_le32(period);
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -116,9 +117,10 @@ static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
 	return ret;
 }
 
-static int gb_pwm_set_polarity_operation(struct gb_pwm_chip *pwmc,
+static int gb_pwm_set_polarity_operation(struct pwm_chip *chip,
 					 u8 which, u8 polarity)
 {
+	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 	struct gb_pwm_polarity_request request;
 	struct gbphy_device *gbphy_dev;
 	int ret;
@@ -129,7 +131,7 @@ static int gb_pwm_set_polarity_operation(struct gb_pwm_chip *pwmc,
 	request.which = which;
 	request.polarity = polarity;
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -142,9 +144,9 @@ static int gb_pwm_set_polarity_operation(struct gb_pwm_chip *pwmc,
 	return ret;
 }
 
-static int gb_pwm_enable_operation(struct gb_pwm_chip *pwmc,
-				   u8 which)
+static int gb_pwm_enable_operation(struct pwm_chip *chip, u8 which)
 {
+	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 	struct gb_pwm_enable_request request;
 	struct gbphy_device *gbphy_dev;
 	int ret;
@@ -154,7 +156,7 @@ static int gb_pwm_enable_operation(struct gb_pwm_chip *pwmc,
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -167,9 +169,9 @@ static int gb_pwm_enable_operation(struct gb_pwm_chip *pwmc,
 	return ret;
 }
 
-static int gb_pwm_disable_operation(struct gb_pwm_chip *pwmc,
-				    u8 which)
+static int gb_pwm_disable_operation(struct pwm_chip *chip, u8 which)
 {
+	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 	struct gb_pwm_disable_request request;
 	struct gbphy_device *gbphy_dev;
 	int ret;
@@ -182,7 +184,7 @@ static int gb_pwm_disable_operation(struct gb_pwm_chip *pwmc,
 	ret = gb_operation_sync(pwmc->connection, GB_PWM_TYPE_DISABLE,
 				&request, sizeof(request), NULL, 0);
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
 	gbphy_runtime_put_autosuspend(gbphy_dev);
 
 	return ret;
@@ -190,19 +192,15 @@ static int gb_pwm_disable_operation(struct gb_pwm_chip *pwmc,
 
 static int gb_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
-
-	return gb_pwm_activate_operation(pwmc, pwm->hwpwm);
+	return gb_pwm_activate_operation(chip, pwm->hwpwm);
 };
 
 static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
-
 	if (pwm_is_enabled(pwm))
-		dev_warn(chip->dev, "freeing PWM device without disabling\n");
+		dev_warn(pwmchip_parent(chip), "freeing PWM device without disabling\n");
 
-	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
+	gb_pwm_deactivate_operation(chip, pwm->hwpwm);
 }
 
 static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -212,22 +210,21 @@ static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	bool enabled = pwm->state.enabled;
 	u64 period = state->period;
 	u64 duty_cycle = state->duty_cycle;
-	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 
 	/* Set polarity */
 	if (state->polarity != pwm->state.polarity) {
 		if (enabled) {
-			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
+			gb_pwm_disable_operation(chip, pwm->hwpwm);
 			enabled = false;
 		}
-		err = gb_pwm_set_polarity_operation(pwmc, pwm->hwpwm, state->polarity);
+		err = gb_pwm_set_polarity_operation(chip, pwm->hwpwm, state->polarity);
 		if (err)
 			return err;
 	}
 
 	if (!state->enabled) {
 		if (enabled)
-			gb_pwm_disable_operation(pwmc, pwm->hwpwm);
+			gb_pwm_disable_operation(chip, pwm->hwpwm);
 		return 0;
 	}
 
@@ -243,13 +240,13 @@ static int gb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty_cycle > period)
 		duty_cycle = period;
 
-	err = gb_pwm_config_operation(pwmc, pwm->hwpwm, duty_cycle, period);
+	err = gb_pwm_config_operation(chip, pwm->hwpwm, duty_cycle, period);
 	if (err)
 		return err;
 
 	/* enable/disable */
 	if (!enabled)
-		return gb_pwm_enable_operation(pwmc, pwm->hwpwm);
+		return gb_pwm_enable_operation(chip, pwm->hwpwm);
 
 	return 0;
 }
-- 
2.42.0


