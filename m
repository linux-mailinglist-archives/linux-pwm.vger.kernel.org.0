Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2EC7C7316
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379171AbjJLQdD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347324AbjJLQc7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:32:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B99D7
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:32:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycJ-0000gK-4D; Thu, 12 Oct 2023 18:32:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-001CCB-MD; Thu, 12 Oct 2023 18:32:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-00F5Vb-DJ; Thu, 12 Oct 2023 18:32:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 104/109] staging: greybus: pwm: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:32:33 +0200
Message-ID: <20231012163227.1004288-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5295; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fwjcap6W0aI98URg3C1letdN7qUAdNMgeP8loXrtGPU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB+hIAhmG2u+fFH19s6+yjfH8JQO7XGrXgkJd kYoaF/+fSeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfoQAKCRCPgPtYfRL+ TuH6B/9SEv5LDXMxkaHXeYpz3aVN22YrKMBRDQh6a0q6YYXfFS0xyMS+iOQuq6KJ0pnFrjYV3+R E8w6qlwHUQTdL58TyclC/63NqZ3vKvT3IZKZQrTa4SZfeAKoTAE+rRTuZ1VuNDOWEvMOTaNiQMy KcTqpYx+2jGrmCfUkQ42LWj1BSjb2CDxGgy4fRrHMZMb3xKY0W+7v5z3/4NhF5sBez+AF2FT1on 9PlCrj2BbZr6aeTHmOVWBjl3Rr6WIGl9FBavxYyeyuqcyJ4PJ8uKrE77LRsYZvcQ74WZ6i3I+K4 K8HSBLj/qfQaACfAGYrNYfmaf1XKeWH8YQr+0b/o8H6RJ0ai
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/staging/greybus/pwm.c | 75 ++++++++++-------------------------
 1 file changed, 20 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
index 75e0518791d8..897a1f1ea9d2 100644
--- a/drivers/staging/greybus/pwm.c
+++ b/drivers/staging/greybus/pwm.c
@@ -16,26 +16,11 @@
 
 struct gb_pwm_chip {
 	struct gb_connection	*connection;
-	u8			pwm_max;	/* max pwm number */
-	struct pwm_chip		chip;
 };
 
 static inline struct gb_pwm_chip *pwm_chip_to_gb_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct gb_pwm_chip, chip);
-}
-
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
+	return pwmchip_priv(chip);
 }
 
 static int gb_pwm_activate_operation(struct pwm_chip *chip, u8 which)
@@ -45,9 +30,6 @@ static int gb_pwm_activate_operation(struct pwm_chip *chip, u8 which)
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
@@ -71,9 +53,6 @@ static int gb_pwm_deactivate_operation(struct pwm_chip *chip,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
@@ -97,9 +76,6 @@ static int gb_pwm_config_operation(struct pwm_chip *chip,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 	request.duty = cpu_to_le32(duty);
 	request.period = cpu_to_le32(period);
@@ -125,9 +101,6 @@ static int gb_pwm_set_polarity_operation(struct pwm_chip *chip,
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 	request.polarity = polarity;
 
@@ -151,9 +124,6 @@ static int gb_pwm_enable_operation(struct pwm_chip *chip, u8 which)
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	gbphy_dev = to_gbphy_dev(pwmchip_parent(chip));
@@ -176,9 +146,6 @@ static int gb_pwm_disable_operation(struct pwm_chip *chip, u8 which)
 	struct gbphy_device *gbphy_dev;
 	int ret;
 
-	if (which > pwmc->pwm_max)
-		return -EINVAL;
-
 	request.which = which;
 
 	ret = gb_operation_sync(pwmc->connection, GB_PWM_TYPE_DISABLE,
@@ -263,38 +230,37 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
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
 	pwmc->connection = connection;
+
 	gb_connection_set_data(connection, pwmc);
-	gb_gbphy_set_data(gbphy_dev, pwmc);
+	gb_gbphy_set_data(gbphy_dev, chip);
 
 	ret = gb_connection_enable(connection);
 	if (ret)
 		goto exit_connection_destroy;
 
-	/* Query number of pwms present */
-	ret = gb_pwm_count_operation(pwmc);
-	if (ret)
-		goto exit_connection_disable;
-
-	chip = &pwmc->chip;
-
-	chip->dev = &gbphy_dev->dev;
 	chip->ops = &gb_pwm_ops;
-	chip->npwm = pwmc->pwm_max + 1;
 
 	ret = pwmchip_add(chip);
 	if (ret) {
@@ -310,14 +276,13 @@ static int gb_pwm_probe(struct gbphy_device *gbphy_dev,
 	gb_connection_disable(connection);
 exit_connection_destroy:
 	gb_connection_destroy(connection);
-exit_pwmc_free:
-	kfree(pwmc);
 	return ret;
 }
 
 static void gb_pwm_remove(struct gbphy_device *gbphy_dev)
 {
-	struct gb_pwm_chip *pwmc = gb_gbphy_get_data(gbphy_dev);
+	struct pwm_chip *chip = gb_gbphy_get_data(gbphy_dev);
+	struct gb_pwm_chip *pwmc = pwm_chip_to_gb_pwm_chip(chip);
 	struct gb_connection *connection = pwmc->connection;
 	int ret;
 
@@ -325,7 +290,7 @@ static void gb_pwm_remove(struct gbphy_device *gbphy_dev)
 	if (ret)
 		gbphy_runtime_get_noresume(gbphy_dev);
 
-	pwmchip_remove(&pwmc->chip);
+	pwmchip_remove(chip);
 	gb_connection_disable(connection);
 	gb_connection_destroy(connection);
 	kfree(pwmc);
-- 
2.42.0

