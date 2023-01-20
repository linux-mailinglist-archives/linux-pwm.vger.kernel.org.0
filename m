Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B264C675407
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jan 2023 13:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjATMAi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 20 Jan 2023 07:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjATMAh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 20 Jan 2023 07:00:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C7F748
        for <linux-pwm@vger.kernel.org>; Fri, 20 Jan 2023 04:00:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIq4F-0001AP-D5; Fri, 20 Jan 2023 13:00:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIq4E-007MQ3-8T; Fri, 20 Jan 2023 13:00:22 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIq4D-00ENg0-Hm; Fri, 20 Jan 2023 13:00:21 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 2/2] backlight: pwm_bl: Don't rely on a disabled PWM emiting inactive state
Date:   Fri, 20 Jan 2023 13:00:18 +0100
Message-Id: <20230120120018.161103-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120120018.161103-1-u.kleine-koenig@pengutronix.de>
References: <20230120120018.161103-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3378; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3M18JepJfTGb5m9P8ayAdk02ozkDerKKEZZRJa5QyAI=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjyoJJt15jx6Kow8IBg/U6EFtJQCoxDIfgvjhFmyDp lLphq6mJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY8qCSQAKCRDB/BR4rcrsCba/B/ 9BccL7O6OygZX40tqrIMZFJcxCFqDYsp1WQ2xg+Ag+GGW4eHBSOJI51XnGPp/Bje3wH4ZtAf7RCffS gQdyPbNWla2Vo3m5Zqk0qC0g7pknzOraRxrd4suD1s4s1xBIwoOnmJGVV3egHYiLSXd957QGs7BkTH 7mrpV61OUHQwEcJb+QYEZcrXkBtuG5T+6zK04qKR48kgENjz9JElhUMLJaI3zRdcqrYtXRZmnJmiMe X8FnYT1YlMycu0WHQ37Nmj5FP8PgmaGwZzUBrNLrJKEfr+plvrxwpkcBrAqIjdsOcCJL5GbKAt7DJ9 j11B6BSD1qrcLKa0d2kHxgvuOBfHQU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Most but not all PWMs drive the PWM pin to its inactive state when
disabled. However if there is no enable_gpio and no regulator the PWM
must drive the inactive state to actually disable the backlight.

So keep the PWM on in this case.

Note that to determine if there is a regulator some effort is required
because it might happen that there isn't actually one but the regulator
core gave us a dummy. (A nice side effect is that this makes the
regulator actually optional even on fully constrained systems.)

This fixes backlight disabling e.g. on i.MX6 when an inverted PWM is
used.

Hint for the future: If this change results in a regression, the bug is
in the lowlevel PWM driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/backlight/pwm_bl.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 0509fecd5715..fb388148d98f 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -45,9 +45,11 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 	if (pb->enabled)
 		return;
 
-	err = regulator_enable(pb->power_supply);
-	if (err < 0)
-		dev_err(pb->dev, "failed to enable power supply\n");
+	if (pb->power_supply) {
+		err = regulator_enable(pb->power_supply);
+		if (err < 0)
+			dev_err(pb->dev, "failed to enable power supply\n");
+	}
 
 	if (pb->post_pwm_on_delay)
 		msleep(pb->post_pwm_on_delay);
@@ -69,7 +71,8 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 	if (pb->pwm_off_delay)
 		msleep(pb->pwm_off_delay);
 
-	regulator_disable(pb->power_supply);
+	if (pb->power_supply)
+		regulator_disable(pb->power_supply);
 	pb->enabled = false;
 }
 
@@ -109,8 +112,16 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		pwm_backlight_power_off(pb);
 
 		pwm_get_state(pb->pwm, &state);
-		state.enabled = false;
 		state.duty_cycle = 0;
+		/*
+		 * We cannot assume a disabled PWM to drive its output to the
+		 * inactive state. If we have an enable GPIO and/or a regulator
+		 * we assume that this isn't relevant and we can disable the PWM
+		 * to save power. If however there is neither an enable GPIO nor
+		 * a regulator keep the PWM on be sure to get a constant
+		 * inactive output.
+		 */
+		state.enabled = !pb->power_supply && !pb->enable_gpio;
 		pwm_apply_state(pb->pwm, &state);
 	}
 
@@ -408,7 +419,7 @@ static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
 	if (pb->enable_gpio && gpiod_get_value_cansleep(pb->enable_gpio) == 0)
 		active = false;
 
-	if (!regulator_is_enabled(pb->power_supply))
+	if (pb->power_supply && !regulator_is_enabled(pb->power_supply))
 		active = false;
 
 	if (!pwm_is_enabled(pb->pwm))
@@ -489,10 +500,13 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
-	pb->power_supply = devm_regulator_get(&pdev->dev, "power");
+	pb->power_supply = devm_regulator_get_optional(&pdev->dev, "power");
 	if (IS_ERR(pb->power_supply)) {
 		ret = PTR_ERR(pb->power_supply);
-		goto err_alloc;
+		if (ret == -ENODEV)
+			pb->power_supply = NULL;
+		else
+			goto err_alloc;
 	}
 
 	pb->pwm = devm_pwm_get(&pdev->dev, NULL);
-- 
2.39.0

