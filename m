Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A9A747F03
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jul 2023 10:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjGEIHL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Jul 2023 04:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjGEIHJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Jul 2023 04:07:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F371D10FA
        for <linux-pwm@vger.kernel.org>; Wed,  5 Jul 2023 01:07:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXN-0003pQ-Ap; Wed, 05 Jul 2023 10:06:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXM-00CDNQ-Kr; Wed, 05 Jul 2023 10:06:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXL-002Ob3-Gu; Wed, 05 Jul 2023 10:06:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 4/8] pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
Date:   Wed,  5 Jul 2023 10:06:46 +0200
Message-Id: <20230705080650.2353391-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
References: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WORoxSGxHF7VOM19DK3mIZMqxydOYBZfVszkTWxNPgA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkpSSRDNYWbKvuTNEwQkGDmDECELmmFiRo1+X+6 6kmVKWM7bWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKUkkQAKCRCPgPtYfRL+ TpHpCACLFJ5wf8vDzSjqwXcR9y31jb5K/WLJ987h9fQW3XNyRvWMfSRm3a0nsDt3/DGd3yl7Bx2 U6LUB5h4lSds7tPzj3JfEaK7r2Mmu1JFz0PWKv+AKJA6CKh1TjBOdehORfg71OV/vgU8i8MVNOi BqRp+bY9s8zLIwG3sCJZSG4n/CfOdmwsiecSm0Ep37G3I7g1iwWOsnHAWyuuPOzM/gap9oVpSVm DNQXMLQLsCbmPmJp+ok0qmwrvddY6NnCJSDATE0UWCoMU6qPNwPGFvCRKMis91gleNpELm9GCMG Zv9rOQ0HAMpQ7Dhho1GrfZc6iiBlbD5KHyu6+rcGvpTY+q7m
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Instead of distributing the driver's bookkeeping over 3 (i.e.
LP3943_NUM_PWMS + 1) separately allocated memory chunks, put all together
in struct lp3943_pwm. This reduces the number of memory allocations and
so fragmentation and maybe even the number of cache misses. Also
&lp3943_pwm->pwm_map[pwm->hwpwm] is cheaper to evaluate than
pwm_get_chip_data(pwm) as the former is just an addition in machine code
while the latter involves a function call.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lp3943.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 35675e4058c6..00e7f63a73fe 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -22,6 +22,7 @@ struct lp3943_pwm {
 	struct pwm_chip chip;
 	struct lp3943 *lp3943;
 	struct lp3943_platform_data *pdata;
+	struct lp3943_pwm_map pwm_map[LP3943_NUM_PWMS];
 };
 
 static inline struct lp3943_pwm *to_lp3943_pwm(struct pwm_chip *_chip)
@@ -34,13 +35,9 @@ lp3943_pwm_request_map(struct lp3943_pwm *lp3943_pwm, int hwpwm)
 {
 	struct lp3943_platform_data *pdata = lp3943_pwm->pdata;
 	struct lp3943 *lp3943 = lp3943_pwm->lp3943;
-	struct lp3943_pwm_map *pwm_map;
+	struct lp3943_pwm_map *pwm_map = &lp3943_pwm->pwm_map[hwpwm];
 	int i, offset;
 
-	pwm_map = kzalloc(sizeof(*pwm_map), GFP_KERNEL);
-	if (!pwm_map)
-		return ERR_PTR(-ENOMEM);
-
 	pwm_map->output = pdata->pwms[hwpwm]->output;
 	pwm_map->num_outputs = pdata->pwms[hwpwm]->num_outputs;
 
@@ -48,10 +45,8 @@ lp3943_pwm_request_map(struct lp3943_pwm *lp3943_pwm, int hwpwm)
 		offset = pwm_map->output[i];
 
 		/* Return an error if the pin is already assigned */
-		if (test_and_set_bit(offset, &lp3943->pin_used)) {
-			kfree(pwm_map);
+		if (test_and_set_bit(offset, &lp3943->pin_used))
 			return ERR_PTR(-EBUSY);
-		}
 	}
 
 	return pwm_map;
@@ -66,7 +61,7 @@ static int lp3943_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (IS_ERR(pwm_map))
 		return PTR_ERR(pwm_map);
 
-	return pwm_set_chip_data(pwm, pwm_map);
+	return 0;
 }
 
 static void lp3943_pwm_free_map(struct lp3943_pwm *lp3943_pwm,
@@ -79,14 +74,12 @@ static void lp3943_pwm_free_map(struct lp3943_pwm *lp3943_pwm,
 		offset = pwm_map->output[i];
 		clear_bit(offset, &lp3943->pin_used);
 	}
-
-	kfree(pwm_map);
 }
 
 static void lp3943_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct lp3943_pwm *lp3943_pwm = to_lp3943_pwm(chip);
-	struct lp3943_pwm_map *pwm_map = pwm_get_chip_data(pwm);
+	struct lp3943_pwm_map *pwm_map = &lp3943_pwm->pwm_map[pwm->hwpwm];
 
 	lp3943_pwm_free_map(lp3943_pwm, pwm_map);
 }
@@ -158,7 +151,7 @@ static int lp3943_pwm_set_mode(struct lp3943_pwm *lp3943_pwm,
 static int lp3943_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct lp3943_pwm *lp3943_pwm = to_lp3943_pwm(chip);
-	struct lp3943_pwm_map *pwm_map = pwm_get_chip_data(pwm);
+	struct lp3943_pwm_map *pwm_map = &lp3943_pwm->pwm_map[pwm->hwpwm];
 	u8 val;
 
 	if (pwm->hwpwm == 0)
@@ -177,7 +170,7 @@ static int lp3943_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void lp3943_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct lp3943_pwm *lp3943_pwm = to_lp3943_pwm(chip);
-	struct lp3943_pwm_map *pwm_map = pwm_get_chip_data(pwm);
+	struct lp3943_pwm_map *pwm_map = &lp3943_pwm->pwm_map[pwm->hwpwm];
 
 	/*
 	 * LP3943 outputs are open-drain, so the pin should be configured
-- 
2.39.2

