Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C47774877
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjHHTd0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjHHTdK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:33:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B87798E
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNH-0007li-Ne; Tue, 08 Aug 2023 19:20:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNH-0022Aj-48; Tue, 08 Aug 2023 19:20:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-00BTGc-75; Tue, 08 Aug 2023 19:20:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 099/101] staging: greybus: pwm: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:29 +0200
Message-Id: <20230808171931.944154-100-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7khy3GeDMlsJgGBxCW9xPSS44tgb/X/iSUd0WTt7KcQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkglOZrT4BjnDi/3CeeWsl5DhxUl5VupGBbO 7OVhkGqveSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5IAAKCRCPgPtYfRL+ TnIfB/4/1BxDPAL/WhwJp4adujLxEZN711nWsyH+w6GetLBUvoVmcXqYHuA6+c97pJzsfcLHyfC fpmrlOdlxkGmzkwkt16OOYzHYtx4YNN4IjuZ16PGGQlLE1BQXjrflcMsAgV7cMmfnsgEsV4/7sI BfjMLw8rV4+305cIZF9rm1yni1wvH9YNwQ+SDQTFEaDpYlGJQeAJipgYZNRztro1nvCTzQrrU2N pBK6+iHNDH3qBpHOnXzwcwi1ucaU18OocjJn0OjYn4jSqRVuQtgEW4PbgNBYZHWok/0qTDg4/PD rbIStcbOiGZIXlpane0l2vU65kwnwLHmFnwVafW0jPXPRJ/H
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/pwm.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 60b3bddae08a..6af07ebcbaa4 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -16,7 +16,7 @@
 
 struct gb_pwm_chip {
 	struct gb_connection	*connection;
-
+	struct device		*parent;
 	struct pwm_chip		chip;
 };
 
@@ -34,7 +34,7 @@ static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmc->parent);
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -56,7 +56,7 @@ static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmc->parent);
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -80,7 +80,7 @@ static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
 	request.duty = cpu_to_le32(duty);
 	request.period = cpu_to_le32(period);
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmc->parent);
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -103,7 +103,7 @@ static int gb_pwm_set_polarity_operation(struct gb_pwm_chip *pwmc,
 	request.which = which;
 	request.polarity = polarity;
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmc->parent);
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -125,7 +125,7 @@ static int gb_pwm_enable_operation(struct gb_pwm_chip *pwmc,
 
 	request.which = which;
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmc->parent);
 	ret = gbphy_runtime_get_sync(gbphy_dev);
 	if (ret)
 		return ret;
@@ -150,7 +150,7 @@ static int gb_pwm_disable_operation(struct gb_pwm_chip *pwmc,
 	ret = gb_operation_sync(pwmc->connection, GB_PWM_TYPE_DISABLE,
 				&request, sizeof(request), NULL, 0);
 
-	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
+	gbphy_dev = to_gbphy_dev(pwmc->parent);
 	gbphy_runtime_put_autosuspend(gbphy_dev);
 
 	return ret;
@@ -168,7 +168,7 @@ static void gb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 
 	if (pwm_is_enabled(pwm))
-		dev_warn(chip->dev, "freeing PWM device without disabling\n");
+		dev_warn(pwmc->parent, "freeing PWM device without disabling\n");
 
 	gb_pwm_deactivate_operation(pwmc, pwm->hwpwm);
 }
@@ -256,6 +256,7 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 
 	pwmc = pwmchip_priv(chip);
 
+	pwmc->parent = &gbphy_dev->dev;
 	pwmc->connection = connection;
 	gb_connection_set_data(connection, pwmc);
 	gb_gbphy_set_data(gbphy_dev, pwmc);
-- 
2.40.1

