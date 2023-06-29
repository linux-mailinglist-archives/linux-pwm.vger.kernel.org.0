Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE395742373
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jun 2023 11:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjF2JtD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Jun 2023 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjF2Js6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Jun 2023 05:48:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BD52D50
        for <linux-pwm@vger.kernel.org>; Thu, 29 Jun 2023 02:48:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGh-0006UR-0Q; Thu, 29 Jun 2023 11:48:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGf-00Aro6-UN; Thu, 29 Jun 2023 11:48:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGf-000kwn-A6; Thu, 29 Jun 2023 11:48:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-mips@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/8] pwm: jz4740: Put per-channel clk into driver data
Date:   Thu, 29 Jun 2023 11:48:34 +0200
Message-Id: <20230629094839.757092-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
References: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1843; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BNcyLyO1aA/JMy+GZlQNt66HAk1rZSLQbjRlPuLBvLY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBknVNnFbjMM5/BgK4deOspaDLNeW9SamEzyGCOO R0ENB5uJpaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZJ1TZwAKCRCPgPtYfRL+ TuvoB/9mmEbYVFZlMGzt3UAaIge2vFt34ojHkfUSiPlZLlcAyXN3XxGRua4wEXl6XXHY+k35cth 15E16TZkwqxy2PnEcwnFv5kFcnpVTqxnKc/p4atZu67wImhFRuTPLsiHEaIYNo3BhEU055KmVxC 4os/o0U7BGOXVdvyPZ2fWgprmbyXWmfNiSGYUyk2UyPjPuiLIINGA3MQavtt9j5iwylSXf5yE7F oGCpGdQz2NgjdqOXixg2A7l/20p63EteIqCPxb53CAbjPKWSXEkVmlP5eUh3giD8K+phIzahSbn k4v5R9oGuaKyG8z3L6+6FOwrYWirSalvG8qtigLlRcyn5nrF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Stop using chip_data which is about to go away. Instead track the
per-channel clk in struct jz4740_pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 3b7067f6cd0d..e0a57d71a60c 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -27,6 +27,7 @@ struct soc_info {
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
 	struct regmap *map;
+	struct clk *clk[];
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
@@ -70,14 +71,15 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		return err;
 	}
 
-	pwm_set_chip_data(pwm, clk);
+	jz->clk[pwm->hwpwm] = clk;
 
 	return 0;
 }
 
 static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct clk *clk = pwm_get_chip_data(pwm);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk = jz->clk[pwm->hwpwm];
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
@@ -123,7 +125,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	unsigned long long tmp = 0xffffull * NSEC_PER_SEC;
-	struct clk *clk = pwm_get_chip_data(pwm);
+	struct clk *clk = jz4740->clk[pwm->hwpwm];
 	unsigned long period, duty;
 	long rate;
 	int err;
@@ -229,7 +231,8 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	jz4740 = devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
+	jz4740 = devm_kzalloc(dev, sizeof(*jz4740) + info->num_pwms * sizeof(jz4740->clk[0]),
+			      GFP_KERNEL);
 	if (!jz4740)
 		return -ENOMEM;
 
-- 
2.39.2

