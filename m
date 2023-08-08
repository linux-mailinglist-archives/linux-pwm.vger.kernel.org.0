Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6809E774DE8
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Aug 2023 00:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjHHWDF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 18:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjHHWDC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 18:03:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B1E1DD72
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-0007S9-8T; Tue, 08 Aug 2023 19:19:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-00228I-Sq; Tue, 08 Aug 2023 19:19:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN9-00BTEb-Tb; Tue, 08 Aug 2023 19:19:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 069/101] staging: greybus: pwm: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:59 +0200
Message-Id: <20230808171931.944154-70-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4657; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=x3C7TUMxdrK5/Nsk7DDgMXh+EhnsIoMUvi9AIixzYMo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nj+4QO1W4bVq6g2ZF6coZ1d+3o06J58nCQyn 0JXbvLCrs2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4/gAKCRCPgPtYfRL+ TrPqB/9KPFJjuEoKyqLGcSJV1TLPKcL0tGIfeBmM8LM++l+agpTqTKFE+XcmhNqM2iMpKPviYe4 byz1K9qpq5NBqrCXh3OHUg/K9YNHuEafbNDBYgXUCSweJTYjKEvfa1Ypt3DkkDjXY24blxvh+ng PRA2mM2SroMP0eYcS5kjGuZ03030FDLjXg/MUnzVLkbILVY3kzeBTgBfRpICpVORjKJ5doRZ6bU TBkNLi3qMAW75ktBe/OzgsDksjx8HQE9/iG9YGN/GZcRu9UWCER2gW2JAN8t2TNXhfWO2Gla1by 5OJDPvUz79qql/hgxVBOOivZbSkddK1dgN7660mXqCcgHfVi
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

This prepares the greybus pwm driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/staging/greybus/pwm.c | 63 +++++++++--------------------------
 1 file changed, 15 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index a3cb68cfa0f9..60b3bddae08a 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -16,7 +16,6 @@
 
 struct gb_pwm_chip {
 	struct gb_connection	*connection;
-	u8			pwm_max;	/* max pwm number */
 
 	struct pwm_chip		chip;
 };
@@ -26,19 +25,6 @@ static inline struct gb_pwm_chip *pwm_chip_to_gb_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct gb_pwm_chip, chip);
 }
 
-static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
-{
-	struct gb_pwm_count_response response;
-	int ret;
-
-	ret = gb_operation_sync(pwmc->connection, GB_PWM_TYPE_PWM_COUNT,
-				NULL, 0, &response, sizeof(response));
-	if (ret)
-		return ret;
-	pwmc->pwm_max = response.count;
-	return 0;
-}
-
 static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
 				     u8 which)
 {
@@ -46,9 +32,6 @@ static int gb_pwm_activate_operation(struct gb_pwm_chip *pwmc,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
@@ -71,9 +54,6 @@ static int gb_pwm_deactivate_operation(struct gb_pwm_chip *pwmc,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
@@ -96,9 +76,6 @@ static int gb_pwm_config_operation(struct gb_pwm_chip *pwmc,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 	request.duty = cpu_to_le32(duty);
 	request.period = cpu_to_le32(period);
@@ -123,9 +100,6 @@ static int gb_pwm_set_polarity_operation(struct gb_pwm_chip *pwmc,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 	request.polarity = polarity;
 
@@ -149,9 +123,6 @@ static int gb_pwm_enable_operation(struct gb_pwm_chip *pwmc,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	gbphy_dev = to_gbphy_dev(pwmc->chip.dev);
@@ -174,9 +145,6 @@ static int gb_pwm_disable_operation(struct gb_pwm_chip *pwmc,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	ret = gb_operation_sync(pwmc->connection, GB_PWM_TYPE_DISABLE,
@@ -266,20 +234,28 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 	struct gb_connection *connection;
 	struct gb_pwm_chip *pwmc;
 	struct pwm_chip *chip;
+	struct gb_pwm_count_response response;
 	int ret;
 
-	pwmc = kzalloc(sizeof(*pwmc), GFP_KERNEL);
-	if (!pwmc)
-		return -ENOMEM;
-
 	connection = gb_connection_create(gbphy_dev->bundle,
 					  le16_to_cpu(gbphy_dev->cport_desc->id),
 					  NULL);
-	if (IS_ERR(connection)) {
-		ret = PTR_ERR(connection);
-		goto exit_pwmc_free;
+	if (IS_ERR(connection))
+		return PTR_ERR(connection);
+
+	ret = gb_operation_sync(pwmc->connection, GB_PWM_TYPE_PWM_COUNT,
+				NULL, 0, &response, sizeof(response));
+	if (ret)
+		goto exit_connection_destroy;
+
+	chip = devm_pwmchip_alloc(&gbphy_dev->dev, response.count, sizeof(*pwmc));
+	if (IS_ERR(chip)) {
+		ret = PTR_ERR(chip);
+		goto exit_connection_destroy;
 	}
 
+	pwmc = pwmchip_priv(chip);
+
 	pwmc->connection = connection;
 	gb_connection_set_data(connection, pwmc);
 	gb_gbphy_set_data(gbphy_dev, pwmc);
@@ -288,16 +264,9 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 	if (ret)
 		goto exit_connection_destroy;
 
-	/* Query number of pwms present */
-	ret = gb_pwm_count_operation(pwmc);
-	if (ret)
-		goto exit_connection_disable;
-
 	chip = &pwmc->chip;
 
-	chip->dev = &gbphy_dev->dev;
 	chip->ops = &gb_pwm_ops;
-	chip->npwm = pwmc->pwm_max + 1;
 
 	ret = pwmchip_add(chip);
 	if (ret) {
@@ -313,8 +282,6 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 	gb_connection_disable(connection);
 exit_connection_destroy:
 	gb_connection_destroy(connection);
-exit_pwmc_free:
-	kfree(pwmc);
 	return ret;
 }
 
-- 
2.40.1

