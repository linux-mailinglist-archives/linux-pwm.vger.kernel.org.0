Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1356D77494A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjHHTvC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHHTup (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:50:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C965FE8
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 09:56:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTGAZ-0007if-FO; Tue, 08 Aug 2023 08:26:15 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTGAY-001v5N-3j; Tue, 08 Aug 2023 08:26:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTGAX-00BKsD-04; Tue, 08 Aug 2023 08:26:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: jz4740: Consistently name driver data "jz"
Date:   Tue,  8 Aug 2023 08:26:08 +0200
Message-Id: <20230808062608.897710-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4302; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CgCI6Nwvk9+sysDh3jA/wC6GMwE7Q3uqtKVdUn6NQqE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0d//BGdKQSIjqbmTKx1EqIjjeJIj/3pWze3B+ 0Q5sqqYYquJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNHf/wAKCRCPgPtYfRL+ TgvmCACesHKB5NI1pvKf4rTN1vuMShRlk4XkvVlj0uVqmIn5HMncpkaLM8YpEeJT06OlyOVfyEe lkXj+MkSpkBFBbDfxEo++qM/zWvhf908sn0IRbWvGYhenBu29DIIGdPVJxwSNhu+lK/OJZtwlDE DlDcEgy0zpU46tmj8zqVlmxYXhkVoPYwZCgGIybgO+XXPEtklgG9MZigsDg4q9G/YVK3F/EZUe7 6MuaCt0j/OHU7nuK2mBfN4Qa7ZdtF9AVik+bPyokqVpUbvYe8rW6kbxXiKuch35mOvmdGn7UQ0J vaFQdor8d3m4wTmt6WAC9IIZmNawMmGoHQLuJoVFbc+YY+a0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Most but not all pointers to driver data are already called "jz":

	$ git grep 'struct jz4740_pwm_chip \*' v6.5-rc1 -- drivers/pwm/pwm-jz4740.c
	v6.5-rc1:drivers/pwm/pwm-jz4740.c:static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
	v6.5-rc1:drivers/pwm/pwm-jz4740.c:static bool jz4740_pwm_can_use_chn(struct jz4740_pwm_chip *jz,
	v6.5-rc1:drivers/pwm/pwm-jz4740.c:      struct jz4740_pwm_chip *jz = to_jz4740(chip);
	v6.5-rc1:drivers/pwm/pwm-jz4740.c:      struct jz4740_pwm_chip *jz = to_jz4740(chip);
	v6.5-rc1:drivers/pwm/pwm-jz4740.c:      struct jz4740_pwm_chip *jz = to_jz4740(chip);
	v6.5-rc1:drivers/pwm/pwm-jz4740.c:      struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
	v6.5-rc1:drivers/pwm/pwm-jz4740.c:      struct jz4740_pwm_chip *jz4740;

Adapt the two variables called "jz4740" to use the same name for
consistency.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index ef1293f2a897..6b2124266273 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -121,7 +121,7 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
-	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
+	struct jz4740_pwm_chip *jz = to_jz4740(pwm->chip);
 	unsigned long long tmp = 0xffffull * NSEC_PER_SEC;
 	struct clk *clk = pwm_get_chip_data(pwm);
 	unsigned long period, duty;
@@ -173,16 +173,16 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	/* Reset counter to 0 */
-	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
+	regmap_write(jz->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
 
 	/* Set duty */
-	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
+	regmap_write(jz->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
 
 	/* Set period */
-	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
+	regmap_write(jz->map, TCU_REG_TDFRc(pwm->hwpwm), period);
 
 	/* Set abrupt shutdown */
-	regmap_set_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+	regmap_set_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
 			TCU_TCSR_PWM_SD);
 
 	/*
@@ -199,10 +199,10 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * state instead of its inactive state.
 	 */
 	if ((state->polarity == PWM_POLARITY_NORMAL) ^ state->enabled)
-		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+		regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
 				   TCU_TCSR_PWM_INITL_HIGH, 0);
 	else
-		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+		regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
 				   TCU_TCSR_PWM_INITL_HIGH,
 				   TCU_TCSR_PWM_INITL_HIGH);
 
@@ -222,28 +222,28 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct jz4740_pwm_chip *jz4740;
+	struct jz4740_pwm_chip *jz;
 	const struct soc_info *info;
 
 	info = device_get_match_data(dev);
 	if (!info)
 		return -EINVAL;
 
-	jz4740 = devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
-	if (!jz4740)
+	jz = devm_kzalloc(dev, sizeof(*jz), GFP_KERNEL);
+	if (!jz)
 		return -ENOMEM;
 
-	jz4740->map = device_node_to_regmap(dev->parent->of_node);
-	if (IS_ERR(jz4740->map)) {
-		dev_err(dev, "regmap not found: %ld\n", PTR_ERR(jz4740->map));
-		return PTR_ERR(jz4740->map);
+	jz->map = device_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(jz->map)) {
+		dev_err(dev, "regmap not found: %ld\n", PTR_ERR(jz->map));
+		return PTR_ERR(jz->map);
 	}
 
-	jz4740->chip.dev = dev;
-	jz4740->chip.ops = &jz4740_pwm_ops;
-	jz4740->chip.npwm = info->num_pwms;
+	jz->chip.dev = dev;
+	jz->chip.ops = &jz4740_pwm_ops;
+	jz->chip.npwm = info->num_pwms;
 
-	return devm_pwmchip_add(dev, &jz4740->chip);
+	return devm_pwmchip_add(dev, &jz->chip);
 }
 
 static const struct soc_info jz4740_soc_info = {

base-commit: 3ccb179aa40d931eb00ef8910d7b812a95659563
-- 
2.40.1

