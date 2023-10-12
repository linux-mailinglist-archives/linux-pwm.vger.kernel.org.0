Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894917C72B8
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379596AbjJLQbJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379598AbjJLQa7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF981D7
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-0004tB-7w; Thu, 12 Oct 2023 18:30:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-001C6u-QH; Thu, 12 Oct 2023 18:30:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-00F5Nr-HH; Thu, 12 Oct 2023 18:30:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 026/109] pwm: samsung: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:54 +0200
Message-ID: <20231012162827.1002444-137-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3577; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=D7zsUiKkpx+xMG5mGiMXr04HsSLcOc5V2YOuEr891SU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7KI601PyOnPOhKUJiYf2RIhf+QWWvWMqwlR wQEZoQ0X4WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgeygAKCRCPgPtYfRL+ Tmp6B/sEELD7c/SfZATT2yG7eCcFFBYT8laKV1QCkeEjSMJJLc4Rby/Jxg1pE2e/+wz9SAe4HOY qLokEfntvcyMmlk5BFhXIRFBWsdrHo7u4vSzD/R0Q+Z3wOqxjAkQhBSsCELK4N4y0uQH5iPlg6E f6OtJnItB5YHuoJ5PQqrThfG1X3pPblgiawZfNdFXQHErdIIGd+bz+uc4KXMSLIs98e5Zn3no2N V6+A26RwzEcAtea6fhjWwT8lgN/oO5Cq8Wu6PDndzYVRvIGSjCo1xvu/Ndh658xYKC2q1gstndx vv+5eCKSDXCW2cMZLo7eRvYHgkcGQLRFT4JW1XbWufO4P2P0
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

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 10fe2c13cd80..ac0d1f6e9c6b 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -196,12 +196,12 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *our_chip,
 				return rate;
 		}
 
-		dev_warn(our_chip->chip.dev,
+		dev_warn(pwmchip_parent(&our_chip->chip),
 			"tclk of PWM %d is inoperational, using tdiv\n", chan);
 	}
 
 	rate = pwm_samsung_get_tin_rate(our_chip, chan);
-	dev_dbg(our_chip->chip.dev, "tin parent at %lu\n", rate);
+	dev_dbg(pwmchip_parent(&our_chip->chip), "tin parent at %lu\n", rate);
 
 	/*
 	 * Compare minimum PWM frequency that can be achieved with possible
@@ -231,7 +231,7 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 
 	if (!(our_chip->variant.output_mask & BIT(pwm->hwpwm))) {
-		dev_warn(chip->dev,
+		dev_warn(pwmchip_parent(chip),
 			"tried to request PWM channel %d without output\n",
 			pwm->hwpwm);
 		return -EINVAL;
@@ -325,12 +325,12 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		period = NSEC_PER_SEC / period_ns;
 
-		dev_dbg(our_chip->chip.dev, "duty_ns=%d, period_ns=%d (%u)\n",
+		dev_dbg(pwmchip_parent(chip), "duty_ns=%d, period_ns=%d (%u)\n",
 						duty_ns, period_ns, period);
 
 		tin_rate = pwm_samsung_calc_tin(our_chip, pwm->hwpwm, period);
 
-		dev_dbg(our_chip->chip.dev, "tin_rate=%lu\n", tin_rate);
+		dev_dbg(pwmchip_parent(chip), "tin_rate=%lu\n", tin_rate);
 
 		tin_ns = NSEC_PER_SEC / tin_rate;
 		tcnt = period_ns / tin_ns;
@@ -354,8 +354,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* -1UL will give 100% duty. */
 	--tcmp;
 
-	dev_dbg(our_chip->chip.dev,
-				"tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
+	dev_dbg(pwmchip_parent(chip), "tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
 
 	/* Update PWM registers. */
 	writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
@@ -367,7 +366,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * shortly afer this update (before it autoreloaded the new values).
 	 */
 	if (oldtcmp == (u32) -1) {
-		dev_dbg(our_chip->chip.dev, "Forcing manual update");
+		dev_dbg(pwmchip_parent(chip), "Forcing manual update");
 		pwm_samsung_manual_update(our_chip, pwm);
 	}
 
@@ -508,7 +507,7 @@ MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 
 static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 {
-	struct device_node *np = our_chip->chip.dev->of_node;
+	struct device_node *np = pwmchip_parent(&our_chip->chip)->of_node;
 	const struct of_device_id *match;
 	struct property *prop;
 	const __be32 *cur;
@@ -522,7 +521,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
-			dev_err(our_chip->chip.dev,
+			dev_err(pwmchip_parent(&our_chip->chip),
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
 								__func__);
 			continue;
-- 
2.42.0

