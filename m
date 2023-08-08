Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C72774881
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbjHHTeV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbjHHTeK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:34:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5421DD09
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-0007Uf-Gv; Tue, 08 Aug 2023 19:19:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-00228t-D0; Tue, 08 Aug 2023 19:19:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-00BTF3-FN; Tue, 08 Aug 2023 19:19:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 076/101] pwm: img: Make use of parent device pointer in driver data
Date:   Tue,  8 Aug 2023 19:19:06 +0200
Message-Id: <20230808171931.944154-77-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zG7py8sOqZb4xXNkkQwX8EHFI6f533yoJvIc6VagwOo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkGO0+mdTnTZSg5XE0rRm4q/zGlslg40ALEA Z2nW07iSfOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5BgAKCRCPgPtYfRL+ TguDB/9vRvgubBE2aoy8aQ5nsIz3Ed1/FN04rxkTrUfuocHA70Oc7Kmc3HrGKPibq1O16eVkmhn doaoevVdEJ+aCn63y7ayzLH3F93ddLmwjrUzhaeaEwQPAM92yn4Wvbvuq+RRcDLiE/JYhc9RxIs OlkU+aLedd2EHf8o7UPEgUa3MY0Q65xK66WpJELcNIBXeSmU9iXgNDuxCOLaU3kf9A/oYaYdW6d U5avZdhrxQbtrIOYr+Jk5NXRlFLjRaaMRaMgzWKX+HiO0w/7aLLoGmMHW2BFAsCBS/dd7lJnXlv vJoySJE6r0pySFPo7+qJwZHz6l0bHnODlzJfOS35iuiNNzy3
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
driver in the same commit as struct pwm_chip::dev, make use of the
already existing pointer to the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 64e35ca1b576..18776e2ca054 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -98,7 +98,7 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (period_ns < imgchip->min_period_ns ||
 	    period_ns > imgchip->max_period_ns) {
-		dev_err(chip->dev, "configured period not in range\n");
+		dev_err(imgchip->dev, "configured period not in range\n");
 		return -ERANGE;
 	}
 
@@ -119,14 +119,14 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		div = PWM_CTRL_CFG_SUB_DIV0_DIV1;
 		timebase = DIV_ROUND_UP(mul, 512);
 	} else {
-		dev_err(chip->dev,
+		dev_err(imgchip->dev,
 			"failed to configure timebase steps/divider value\n");
 		return -EINVAL;
 	}
 
 	duty = DIV_ROUND_UP(timebase * duty_ns, period_ns);
 
-	ret = pm_runtime_resume_and_get(chip->dev);
+	ret = pm_runtime_resume_and_get(imgchip->dev);
 	if (ret < 0)
 		return ret;
 
@@ -140,8 +140,8 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	      (timebase << PWM_CH_CFG_TMBASE_SHIFT);
 	img_pwm_writel(imgchip, PWM_CH_CFG(pwm->hwpwm), val);
 
-	pm_runtime_mark_last_busy(chip->dev);
-	pm_runtime_put_autosuspend(chip->dev);
+	pm_runtime_mark_last_busy(imgchip->dev);
+	pm_runtime_put_autosuspend(imgchip->dev);
 
 	return 0;
 }
@@ -152,7 +152,7 @@ static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(chip->dev);
+	ret = pm_runtime_resume_and_get(imgchip->dev);
 	if (ret < 0)
 		return ret;
 
@@ -176,8 +176,8 @@ static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	val &= ~BIT(pwm->hwpwm);
 	img_pwm_writel(imgchip, PWM_CTRL_CFG, val);
 
-	pm_runtime_mark_last_busy(chip->dev);
-	pm_runtime_put_autosuspend(chip->dev);
+	pm_runtime_mark_last_busy(imgchip->dev);
+	pm_runtime_put_autosuspend(imgchip->dev);
 }
 
 static int img_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.40.1

