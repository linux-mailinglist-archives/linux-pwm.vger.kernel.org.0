Return-Path: <linux-pwm+bounces-1473-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A713185468D
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630E5283843
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677EF16428;
	Wed, 14 Feb 2024 09:53:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5C16415
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904414; cv=none; b=X1/hsicco0B1OQ4tSrw32wq5fqlVnvYheRKULc+1C8gDWQX8tkleHbpIa3xlYna0ffP20Z2yL3TPKuzOc77c7A95FUR9sbEfqkGMOqMFefT9Zbvlh6oedwR8mOKdeXj9G+FvXziux87Iu6YRYw9WKFKUEiYyhZWi/6u4rXclPzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904414; c=relaxed/simple;
	bh=p/7hUJXVWflEAKCLVWD9H+4B8NbCAeSs6htsRE3nxVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7RpYwo7qGqXbUo2S4QmvsMieoOR/bcz345UXutX7kEnsuOC2QKz4ooXR31WiupFO4BA/Goq32xEcVULeKXgAKdnU42h4Y4FsyVGeIbWrPBf8KYaOkHehHNzxhH81sZlAfqiBJCIpasO3CD6IgNWDmISlf2W/c8jWhuA3K2HweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfA-0006F9-DI; Wed, 14 Feb 2024 10:34:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-000fIR-JY; Wed, 14 Feb 2024 10:34:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-004YAJ-1g;
	Wed, 14 Feb 2024 10:34:41 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pwm@vger.kernel.org
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 155/164] staging: greybus: pwm: Change prototype of helpers to prepare further changes
Date: Wed, 14 Feb 2024 10:33:22 +0100
Message-ID:  <ef9b346d5bab508d4ded81cf115bf244938d04f1.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8202; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=p/7hUJXVWflEAKCLVWD9H+4B8NbCAeSs6htsRE3nxVQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIj8M/ResyyAEOV8yan5qARVXWXrKNyK/zkDV G8rjThNL5CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI/AAKCRCPgPtYfRL+ TrzdCACf954aWsHjdY/K4hJ+t5yvKOkWwLiJA1Q3ZreTocp3Y5mTZBASQHTRTgHYEOBdFCCIFum hGoh5OBXy29oVzPbPkf+m69FfvljIVON2csF8jIR9K7+y4Oybg6jONqjQIHn6HsPe2YwtLN+VRD TciWFHF1FkfFo1bD6N31RWK3ViYyUaPhhijJ4qx4RwK6ElW/SXbnTHDrY6jgb17N0+wVV1hXQ30 bI9ArDU2jYJG/JRIu5BfC9rvSy/9EFTDhpGbOCKuFJHR/YsywIgUyC9G80IdrigiAeffkVGB5qU dd3OFvH2W2J8de4257G/4OM99R8tSxwRB0mS2POka+l9oViG
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will make it harder to
determine the pwm_chip from a given gb_pwm_chip. To just not have
to do that, rework gb_pwm_activate_operation(),
gb_pwm_deactivate_operation(), gb_pwm_config_operation(),
gb_pwm_set_polarity_operation(), gb_pwm_enable_operation() and
gb_pwm_disable_operation() to take a pwm_chip. Also use the pwm_chip as
driver data instead of the gb_pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/pwm.c | 60 +++++++++++++++++------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index a3cb68cfa0f9..97b49d436c54 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -39,9 +39,9 @@ static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
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
@@ -51,7 +51,7 @@ static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(chip->dev);
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -64,9 +64,9 @@ static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
 	return ret;
 }
 
-static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
-				       u8 which)
+static int gb_pwm_deactivate_operation(struct pwm_chip *chip, u8 which)
 {
+	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 	struct gb_pwm_deactivate_request request;
 	struct gbphy_device *gbphy_dev;
 	int ret;
@@ -76,7 +76,7 @@ static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(chip->dev);
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
+	gbphy_dev = to_gbphy_dev(chip->dev);
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
+	gbphy_dev = to_gbphy_dev(chip->dev);
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
+	gbphy_dev = to_gbphy_dev(chip->dev);
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
+	gbphy_dev = to_gbphy_dev(chip->dev);
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
 		dev_warn(chip->dev, "freeing PWM device without disabling\n");
 
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
@@ -282,7 +279,7 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 
 	pwmc->connection = connection;
 	gb_connection_set_data(connection, pwmc);
-	gb_gbphy_set_data(gbphy_dev, pwmc);
+	gb_gbphy_set_data(gbphy_dev, chip);
 
 	ret = gb_connection_enable(connection);
 	if (ret)
@@ -320,7 +317,8 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 
 static void gb_pwm_remove(struct gbphy_device *gbphy_dev)
 {
-	struct gb_pwm_chip *pwmc = gb_gbphy_get_data(gbphy_dev);
+	struct pwm_chip *chip = gb_gbphy_get_data(gbphy_dev);
+	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 	struct gb_connection *connection = pwmc->connection;
 	int ret;
 
@@ -328,7 +326,7 @@ static void gb_pwm_remove(struct gbphy_device *gbphy_dev)
 	if (ret)
 		gbphy_runtime_get_noresume(gbphy_dev);
 
-	pwmchip_remove(&pwmc->chip);
+	pwmchip_remove(chip);
 	gb_connection_disable(connection);
 	gb_connection_destroy(connection);
 	kfree(pwmc);
-- 
2.43.0


