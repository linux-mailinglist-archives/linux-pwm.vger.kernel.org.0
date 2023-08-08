Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D877E774411
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjHHSOz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjHHSO2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E905575878
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-0007h4-KB; Tue, 08 Aug 2023 19:20:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-00229t-Ua; Tue, 08 Aug 2023 19:20:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-00BTFs-5o; Tue, 08 Aug 2023 19:20:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 089/101] pwm: samsung: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:19 +0200
Message-Id: <20230808171931.944154-90-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3902; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uzJfFHu8t2xnAQFZjRiBncSViI0gzi66tsmDyl8H2sA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkUxFzCvxhywYsQV6pfY8U3GXvhdNrL6B3Yl hiY34vRnk6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5FAAKCRCPgPtYfRL+ Trh4CACa6AkoG7Q7lvgWp+AheAbrmhwaj6ZmPJ23fSD0othVaGu3PKdZnPULFesOwwo3lhz36W/ 00/KHYqbYWn0H/cDIwyjJFsGZfY9sR8djnU/YB9W+73k8iCmqG7M1nL2ljmF4n8s1M12hquUBn5 VEOCK7xDZgSSPoyM2xx4wSmilo3vxQXr6JYXqelkq6DA1i1dXhTDFDAOThfw4dbb1wsA8BrCUYT qk/auT1vYMp5ewbY/rkEjnrKD9JheSqyYXp7NWT7i3nSxGmMQdTZNUmv71JcfeSx98JnFVLPHS4 Yces1+c2hIAHx2xtQLS03bKe3tB/gBC5p9AtuXAqJFUOZ3lr
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
 drivers/pwm/pwm-samsung.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 88d66c281015..4ef2cb5d3ad3 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -79,6 +79,7 @@ struct samsung_pwm_channel {
  * @tclk1:		external clock 1 (can be ERR_PTR if not present)
  */
 struct samsung_pwm_chip {
+	struct device *parent;
 	struct samsung_pwm_variant variant;
 	u8 inverter_mask;
 	u8 disabled_mask;
@@ -196,12 +197,12 @@ static unsigned long pwm_samsung_calc_tin(struct pwm_chip *chip,
 				return rate;
 		}
 
-		dev_warn(chip->dev,
+		dev_warn(our_chip->parent,
 			"tclk of PWM %d is inoperational, using tdiv\n", chan);
 	}
 
 	rate = pwm_samsung_get_tin_rate(our_chip, chan);
-	dev_dbg(chip->dev, "tin parent at %lu\n", rate);
+	dev_dbg(our_chip->parent, "tin parent at %lu\n", rate);
 
 	/*
 	 * Compare minimum PWM frequency that can be achieved with possible
@@ -231,7 +232,7 @@ static int pwm_samsung_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 
 	if (!(our_chip->variant.output_mask & BIT(pwm->hwpwm))) {
-		dev_warn(chip->dev,
+		dev_warn(our_chip->parent,
 			"tried to request PWM channel %d without output\n",
 			pwm->hwpwm);
 		return -EINVAL;
@@ -325,12 +326,12 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		period = NSEC_PER_SEC / period_ns;
 
-		dev_dbg(chip->dev, "duty_ns=%d, period_ns=%d (%u)\n",
+		dev_dbg(our_chip->parent, "duty_ns=%d, period_ns=%d (%u)\n",
 						duty_ns, period_ns, period);
 
 		tin_rate = pwm_samsung_calc_tin(chip, pwm->hwpwm, period);
 
-		dev_dbg(chip->dev, "tin_rate=%lu\n", tin_rate);
+		dev_dbg(our_chip->parent, "tin_rate=%lu\n", tin_rate);
 
 		tin_ns = NSEC_PER_SEC / tin_rate;
 		tcnt = period_ns / tin_ns;
@@ -354,7 +355,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* -1UL will give 100% duty. */
 	--tcmp;
 
-	dev_dbg(chip->dev,
+	dev_dbg(our_chip->parent,
 				"tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
 
 	/* Update PWM registers. */
@@ -367,7 +368,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * shortly afer this update (before it autoreloaded the new values).
 	 */
 	if (oldtcmp == (u32) -1) {
-		dev_dbg(chip->dev, "Forcing manual update");
+		dev_dbg(our_chip->parent, "Forcing manual update");
 		pwm_samsung_manual_update(our_chip, pwm);
 	}
 
@@ -509,7 +510,7 @@ MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 {
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
-	struct device_node *np = chip->dev->of_node;
+	struct device_node *np = our_chip->parent->of_node;
 	const struct of_device_id *match;
 	struct property *prop;
 	const __be32 *cur;
@@ -523,7 +524,7 @@ static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
-			dev_err(chip->dev,
+			dev_err(our_chip->parent,
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
 								__func__);
 			continue;
@@ -554,6 +555,7 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 	our_chip = to_samsung_pwm_chip(chip);
 
 	chip->ops = &pwm_samsung_ops;
+	our_chip->parent = &pdev->dev;
 	our_chip->inverter_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
-- 
2.40.1

