Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAD6774406
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjHHSOq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbjHHSOR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F841DD71
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-0007SA-9z; Tue, 08 Aug 2023 19:19:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-00228H-Sh; Tue, 08 Aug 2023 19:19:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-00BTEf-3h; Tue, 08 Aug 2023 19:19:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 070/101] pwm: Ensure a struct pwm have the same lifetime as its pwm_chip
Date:   Tue,  8 Aug 2023 19:19:00 +0200
Message-Id: <20230808171931.944154-71-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7CXWxPdgRl4kEnzdpD0GY6jMC0J5Q0jFzh+m/hcmAW0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nj/THmESU6Dbrjdge/BnFlWWh9ngZHr28mBb 5DaLMZEblaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4/wAKCRCPgPtYfRL+ TvYMCACUe0PxrLzkdyAI9dM4JUfHc2oYLXVJ+9tpK1V6JWY8aP9r0+pAx1E7QlmGxaZytzv+9kl M652Kx4NYTZ10d1X1FahBu6b+NfTTwdIpOzdQySnYHvTUTr2DbDWCZRyf0KfL3kkDVGFj2e+5pG ijbpblm1TwdNnRDsRy2qTBF9DCKzHYHDIrXCa07Or335q7TOJepU1Peo64bZcRXC37+2xVaSZXy UA4TNKrdZAwevuZ5dD/wKu7yHCFNnt/Bo3B2hRriTdzhK/h6tNqkDSVw695dqi4lDLPHKpGCg5w 47HcdvB5mfafy3Cx7s+CX7Ih1+dbWyGTChFSnsKiNq6hme+d
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

It's required to not free the memory underlying a requested PWM
while a consumer still has a reference to it. While currently a pwm_chip
doesn't life long enough in all cases, linking the struct pwm to the
pwm_chip results in the right lifetime as soon as the pwmchip is living
long enough. This happens with the following commits.

Note this is a breaking change for all pwm drivers that don't use
pwmchip_alloc().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 24 +++++++++---------------
 include/linux/pwm.h |  2 +-
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index cfcddf62ab01..3b8d41fdda1b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -198,7 +198,7 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 
 void *pwmchip_priv(struct pwm_chip *chip)
 {
-	return &chip[1];
+	return &chip->pwms[chip->npwm];
 }
 EXPORT_SYMBOL_GPL(pwmchip_priv);
 
@@ -208,7 +208,7 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 	size_t alloc_size;
 	unsigned int i;
 
-	alloc_size = sizeof(*chip) + sizeof_priv;
+	alloc_size = sizeof(*chip) + npwm * sizeof(struct pwm_device) + sizeof_priv;
 
 	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
 	if (!chip)
@@ -217,6 +217,13 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 	chip->dev = parent;
 	chip->npwm = npwm;
 
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
+
+		pwm->chip = chip;
+		pwm->hwpwm = i;
+	}
+
 	return chip;
 }
 EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
@@ -243,26 +250,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*pwm), GFP_KERNEL);
-	if (!chip->pwms)
-		return -ENOMEM;
-
 	mutex_lock(&pwm_lock);
 
 	ret = idr_alloc(&pwmchip_idr, chip, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		mutex_unlock(&pwm_lock);
-		kfree(chip->pwms);
 		return ret;
 	}
 
 	chip->id = ret;
-	for (i = 0; i < chip->npwm; i++) {
-		struct pwm_device *pwm = &chip->pwms[i];
-
-		pwm->chip = chip;
-		pwm->hwpwm = i;
-	}
 
 	mutex_unlock(&pwm_lock);
 
@@ -293,8 +289,6 @@ void pwmchip_remove(struct pwm_chip *chip)
 	idr_remove(&pwmchip_idr, chip->id);
 
 	mutex_unlock(&pwm_lock);
-
-	kfree(chip->pwms);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 3c0da17e193c..fbcba204de44 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -301,7 +301,7 @@ struct pwm_chip {
 	unsigned int of_pwm_n_cells;
 
 	/* only used internally by the PWM framework */
-	struct pwm_device *pwms;
+	struct pwm_device pwms[];
 };
 
 #if IS_ENABLED(CONFIG_PWM)
-- 
2.40.1

