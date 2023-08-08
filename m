Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA82774409
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjHHSOs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjHHSOS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B51A1DD79
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-0007Tg-8j; Tue, 08 Aug 2023 19:19:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-00228f-Sf; Tue, 08 Aug 2023 19:19:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-00BTEz-6s; Tue, 08 Aug 2023 19:19:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 075/101] pwm: fsl-ftm: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:05 +0200
Message-Id: <20230808171931.944154-76-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0XKobqxyrapOr+hYznUDyFVfHxTF+IoV2oDTPa7CdeU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkFYDu4XCJ7n+V64rXFFW2G+s7osn4c0neWu USxTSCLpxGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5BQAKCRCPgPtYfRL+ ToJjCACX5Ly/WzmP3B3OgUouOAKNWFkSBk6YmICQE3sq8ryi7GMrEd7zZ7Lkh4M777owb7P//pm fs0WRMOTciRyTLRkknklfx4EreZh4JvzI7mZfW/6Wyaul7A7WYH4j6y0H0Hk/Ej0cNASPGMmkrv +U28FoUGL/zzXccxCh2vYGtijR/3zpssk4he2esi8wctNY8wGKWaXErXDZ39T059saX9NBNIK/3 2marN2Dv/gwS8N3qGbojcdCxV8XhvaupWYRNfPi2HjN4rfcKUhwcx5j4rxjr1NzIu2DwFU9mLIr +18o82r0UBAXMY1vJXbtEhpsSib5yA4W85u9CSEdMhUTz+u7
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
 drivers/pwm/pwm-fsl-ftm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index f56c7e9f491a..48e37a9df629 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -40,6 +40,7 @@ struct fsl_pwm_periodcfg {
 };
 
 struct fsl_pwm_chip {
+	struct device *parent;
 	struct mutex lock;
 	struct regmap *regmap;
 
@@ -232,7 +233,7 @@ static int fsl_pwm_apply_config(struct pwm_chip *chip,
 	bool do_write_period = false;
 
 	if (!fsl_pwm_calculate_period(fpc, newstate->period, &periodcfg)) {
-		dev_err(chip->dev, "failed to calculate new period\n");
+		dev_err(fpc->parent, "failed to calculate new period\n");
 		return -EINVAL;
 	}
 
@@ -246,7 +247,7 @@ static int fsl_pwm_apply_config(struct pwm_chip *chip,
 	 */
 	else if (!fsl_pwm_periodcfg_are_equal(&fpc->period, &periodcfg)) {
 		if (fsl_pwm_is_other_pwm_enabled(fpc, pwm)) {
-			dev_err(chip->dev,
+			dev_err(fpc->parent,
 				"Cannot change period for PWM %u, disable other PWMs first\n",
 				pwm->hwpwm);
 			return -EBUSY;
@@ -404,6 +405,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 
 	mutex_init(&fpc->lock);
 
+	fpc->parent = &pdev->dev;
 	fpc->soc = of_device_get_match_data(&pdev->dev);
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.40.1

