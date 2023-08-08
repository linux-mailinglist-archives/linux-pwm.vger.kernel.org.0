Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B445E774848
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjHHTaU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbjHHT37 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:29:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3075860
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-0007XN-Ug; Tue, 08 Aug 2023 19:19:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-002293-Vx; Tue, 08 Aug 2023 19:19:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-00BTFJ-BL; Tue, 08 Aug 2023 19:19:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 080/101] pwm: lpss: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:10 +0200
Message-Id: <20230808171931.944154-81-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2983; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cC8JvT8beMyjkdOZ1YrFl2I9cnYL1nBhob3wdVNmL9g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkKU/+fRyCO1nBzRAFuf7P0auwXPyBKQkNuC Ma2UQXQBpmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5CgAKCRCPgPtYfRL+ TgChCACy1JnxJo3fqodvhuLx4/lQ1XGAeymDLJz9DF5o7rBIzYGztSezeIP4dGRiG0Wg1fQPfS4 0HF66oTCHBe2xuwgBV7g7ImvGRyos4MgiR2ZzG/pd4Flx8XDlOrKe8Y872JRtHw8/COX3Meqp58 KfV31HyMA8NfBZDg23aRQnhqXR3fr9ur517MYPvxjM7HHGy2QxM1u5qF+Fg55GSyp7tMhF30uPn ShN5a3TGTazxCPFho0cSxeL1zVnKO0d/Z8EEVJ8j+ahhpD21uc5OgK+pXG8ZXrhWcDS4d3+d9WL uBZo8yiFObGP7ejo+7qEMaJIdpYZj8KfXPUT1IJUOLdZl8pb
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
 drivers/pwm/pwm-lpss.c | 16 +++++++++-------
 drivers/pwm/pwm-lpss.h |  1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 13087203d05a..105b06f1a6bc 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -106,15 +106,16 @@ static int pwm_lpss_wait_for_update(struct pwm_device *pwm)
 	 */
 	err = readl_poll_timeout(addr, val, !(val & PWM_SW_UPDATE), 40, ms);
 	if (err)
-		dev_err(pwm->chip->dev, "PWM_SW_UPDATE was not cleared\n");
+		dev_err(lpwm->parent, "PWM_SW_UPDATE was not cleared\n");
 
 	return err;
 }
 
 static inline int pwm_lpss_is_updating(struct pwm_device *pwm)
 {
+	struct pwm_lpss_chip *lpwm = to_lpwm(pwm->chip);
 	if (pwm_lpss_read(pwm) & PWM_SW_UPDATE) {
-		dev_err(pwm->chip->dev, "PWM_SW_UPDATE is still set, skipping update\n");
+		dev_err(lpwm->parent, "PWM_SW_UPDATE is still set, skipping update\n");
 		return -EBUSY;
 	}
 
@@ -190,16 +191,16 @@ static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (state->enabled) {
 		if (!pwm_is_enabled(pwm)) {
-			pm_runtime_get_sync(chip->dev);
+			pm_runtime_get_sync(lpwm->parent);
 			ret = pwm_lpss_prepare_enable(lpwm, pwm, state);
 			if (ret)
-				pm_runtime_put(chip->dev);
+				pm_runtime_put(lpwm->parent);
 		} else {
 			ret = pwm_lpss_prepare_enable(lpwm, pwm, state);
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
-		pm_runtime_put(chip->dev);
+		pm_runtime_put(lpwm->parent);
 	}
 
 	return ret;
@@ -213,7 +214,7 @@ static int pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long base_unit, freq, on_time_div;
 	u32 ctrl;
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(lpwm->parent);
 
 	base_unit_range = BIT(lpwm->info->base_unit_bits);
 
@@ -235,7 +236,7 @@ static int pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->polarity = PWM_POLARITY_NORMAL;
 	state->enabled = !!(ctrl & PWM_ENABLE);
 
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(lpwm->parent);
 
 	return 0;
 }
@@ -262,6 +263,7 @@ struct pwm_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
 		return ERR_PTR(-ENOMEM);
 	lpwm = to_lpwm(chip);
 
+	lpwm->parent = dev;
 	lpwm->regs = base;
 	lpwm->info = info;
 
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index b5267ab5193b..5ccc607c6811 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -18,6 +18,7 @@
 #define LPSS_MAX_PWMS			4
 
 struct pwm_lpss_chip {
+	struct device *parent;
 	void __iomem *regs;
 	const struct pwm_lpss_boardinfo *info;
 };
-- 
2.40.1

