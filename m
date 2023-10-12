Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC87C7313
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379466AbjJLQdC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379542AbjJLQc7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:32:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF08D6
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:32:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-0000fz-Sc; Thu, 12 Oct 2023 18:32:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-001CC7-Fc; Thu, 12 Oct 2023 18:32:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-00F5VX-6i; Thu, 12 Oct 2023 18:32:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 103/109] leds: qcom-lpg: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:32:32 +0200
Message-ID: <20231012163227.1004288-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2962; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=M/+YrrRNVhGADFKY1/9Jqz6O7NSfLJ8wFbirQ3DzoFQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB+g48Qq2HM32kjLOjj0eYxExgrFbf8+eWuwd ur6zwRcWTuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfoAAKCRCPgPtYfRL+ TuDVCAClHq4UxLfh8IznTB47FJH5Byed5OloxEWWaZFgtF1ILh9yvy/hQp3sgb9TAZFALqoFvgm USZi2xQtNFhtoMYZNlLXeeqD8LOHNSC/nDsPY7QWnqR8Buo7SYU/AXaS0MwuAuQuGQaDJKOR9Vs kUukEJ0pJCFclkIJK6+RicEmcARUOPvC/o9anzFk38qk4Y66BIftC0ophqaH5xDI+asCM3gSrFb dOVvv/HudxdEiP+yXv3gXdwoZcnwd54fJQ3JVhFC6CBsWdMZD7o1s6RpU1AQ8ANtMGccVlvFYAr YS7NT9xRiupU18ZZNSe9PFwCdDc4mAQGMNv/0LYvVpONLZsm
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

This prepares the pwm sub-driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/leds/rgb/leds-qcom-lpg.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index c8525f59748c..57289af9480f 100644
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
 
@@ -1367,7 +1379,7 @@ static int lpg_remove(struct platform_device *pdev)
 {
 	struct lpg *lpg = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&lpg->pwm);
+	pwmchip_remove(lpg->pwm);
 
 	return 0;
 }
-- 
2.42.0

