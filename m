Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977467746B3
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjHHS7F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHHS6t (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FEB7584D
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00075Q-P3; Tue, 08 Aug 2023 19:19:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN2-00224v-AM; Tue, 08 Aug 2023 19:19:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-00BTBw-F9; Tue, 08 Aug 2023 19:19:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 029/101] pwm: lp3943: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:19 +0200
Message-Id: <20230808171931.944154-30-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pLYVzGYx4s0jPLvW18a+pCkIObnVBWleRS6CeKzMSXo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njR51Y3c2m5PMgVhsBkUVmjrR8WFoku+/BXc e3FIkL8K6CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ40QAKCRCPgPtYfRL+ Tkv5CACqzuaPlJmvqumGAgFfMpLAVOACk2M/OMKukckSFV/rWg+fUUUTwjx2D1symOFbhhRYk5c jCIz/uw96g+7T031wJceb046+H/SoGwsY0wMKdVuXCgguRCJIJLpxm5ROoAeSMiszTLz/sQB1yo 5w2/ajsm6Qo++d+tD6abwGuCP1nvRvGNYrKAEUX+MY7Jc2QChuw7Mde7HYc0gBVix7iXFpXWvCo oj9JcforMz5knuFqoeoGrTLwUfVAwj9Fya3FpKeaKUIdnMMBQga0chWQyT5q/2FtBBjDSVVdjtR po+94WO+9VLejvRtImIfDB7/1VMduX3eN1n27vBZwHMl7svl
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

This prepares the pwm-lp3943 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lp3943.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index 32350a357278..c8d728a6259c 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -20,7 +20,6 @@
 #define LP3943_MAX_PERIOD		1600000
 
 struct lp3943_pwm {
-	struct pwm_chip chip;
 	struct lp3943 *lp3943;
 	struct lp3943_platform_data *pdata;
 	struct lp3943_pwm_map pwm_map[LP3943_NUM_PWMS];
@@ -28,7 +27,7 @@ struct lp3943_pwm {
 
 static inline struct lp3943_pwm *to_lp3943_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lp3943_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static struct lp3943_pwm_map *
@@ -273,12 +272,14 @@ static int lp3943_pwm_parse_dt(struct device *dev,
 static int lp3943_pwm_probe(struct platform_device *pdev)
 {
 	struct lp3943 *lp3943 = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct lp3943_pwm *lp3943_pwm;
 	int ret;
 
-	lp3943_pwm = devm_kzalloc(&pdev->dev, sizeof(*lp3943_pwm), GFP_KERNEL);
-	if (!lp3943_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, LP3943_NUM_PWMS, sizeof(*lp3943_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	lp3943_pwm = to_lp3943_pwm(chip);
 
 	lp3943_pwm->pdata = lp3943->pdata;
 	if (!lp3943_pwm->pdata) {
@@ -292,11 +293,9 @@ static int lp3943_pwm_probe(struct platform_device *pdev)
 	}
 
 	lp3943_pwm->lp3943 = lp3943;
-	lp3943_pwm->chip.dev = &pdev->dev;
-	lp3943_pwm->chip.ops = &lp3943_pwm_ops;
-	lp3943_pwm->chip.npwm = LP3943_NUM_PWMS;
+	chip->ops = &lp3943_pwm_ops;
 
-	return devm_pwmchip_add(&pdev->dev, &lp3943_pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 #ifdef CONFIG_OF
-- 
2.40.1

