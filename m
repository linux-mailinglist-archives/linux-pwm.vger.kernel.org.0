Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6A2559E1
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Aug 2020 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgH1MOn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Aug 2020 08:14:43 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:52828 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgH1MOd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Aug 2020 08:14:33 -0400
Received: from erd988.prtnl (erd988.prtnl [192.168.224.30])
        by sparta.prtnl (Postfix) with ESMTP id 08BD344ACC17;
        Fri, 28 Aug 2020 14:14:30 +0200 (CEST)
From:   David Jander <david@protonic.nl>
To:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v2 1/3] drivers: pwm: pwm-pcs9685.c: Make comments more consistent
Date:   Fri, 28 Aug 2020 14:14:13 +0200
Message-Id: <20200828121415.1292388-2-david@protonic.nl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828121415.1292388-1-david@protonic.nl>
References: <20200828121415.1292388-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Make all explanatory comments start with an uppercase char.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/pwm/pwm-pca9685.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 76cd22bd6614..0f1a3e07e501 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -91,7 +91,7 @@ static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
 	mutex_lock(&pca->lock);
 	if (pwm_idx >= PCA9685_MAXCHAN) {
 		/*
-		 * "all LEDs" channel:
+		 * "All LEDs" channel:
 		 * pretend already in use if any of the PWMs are requested
 		 */
 		if (!bitmap_empty(pca->pwms_inuse, PCA9685_MAXCHAN)) {
@@ -100,7 +100,7 @@ static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
 		}
 	} else {
 		/*
-		 * regular channel:
+		 * Regular channel:
 		 * pretend already in use if the "all LEDs" channel is requested
 		 */
 		if (test_bit(PCA9685_MAXCHAN, pca->pwms_inuse)) {
@@ -257,7 +257,7 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (prescale >= PCA9685_PRESCALE_MIN &&
 			prescale <= PCA9685_PRESCALE_MAX) {
 			/*
-			 * putting the chip briefly into SLEEP mode
+			 * Putting the chip briefly into SLEEP mode
 			 * at this point won't interfere with the
 			 * pm_runtime framework, because the pm_runtime
 			 * state is guaranteed active here.
@@ -475,12 +475,12 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	regmap_write(pca->regmap, PCA9685_MODE2, mode2);
 
-	/* clear all "full off" bits */
+	/* Clear all "full off" bits */
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
 
 	pca->chip.ops = &pca9685_pwm_ops;
-	/* add an extra channel for ALL_LED */
+	/* Add an extra channel for ALL_LED */
 	pca->chip.npwm = PCA9685_MAXCHAN + 1;
 
 	pca->chip.dev = &client->dev;
@@ -496,10 +496,10 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	/* the chip comes out of power-up in the active state */
+	/* The chip comes out of power-up in the active state */
 	pm_runtime_set_active(&client->dev);
 	/*
-	 * enable will put the chip into suspend, which is what we
+	 * Enable will put the chip into suspend, which is what we
 	 * want as all outputs are disabled at this point
 	 */
 	pm_runtime_enable(&client->dev);
-- 
2.25.1

