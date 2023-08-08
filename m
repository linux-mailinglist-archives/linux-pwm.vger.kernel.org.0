Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772827748C5
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbjHHTjF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbjHHTiu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 15:38:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09781DD77
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNC-0007TE-Ty; Tue, 08 Aug 2023 19:19:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNB-00228X-HL; Tue, 08 Aug 2023 19:19:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-00BTEq-NO; Tue, 08 Aug 2023 19:19:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 073/101] pwm: dwc: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:03 +0200
Message-Id: <20230808171931.944154-74-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=K1Wv/KH7OTchK6FNwVZBXtDyr0CXi/as9LDQmGu+ZZk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpRLlczrCw5YzouWkTd9/09rY/XJ1IQrnIV1vPMtvzyxP NJ6/vXiTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmciKA/X9xq5XB9Ekhpi2H 50zfxTnB5PudNHfPtf335Osz3HyP897gEa+J1Ird8amNocPz8p+UU+5T3NL9qrK7zW6k//eUcvD qKX/G3vVBufjEnvt2uVHJl5aJ30vziWFv2+3KmFjYOCX9H08XQ8VPc8Hz+v5y8rslP+mZc7SpBX rEyMVpPz0iMa3EST9lp8eyozoiLZ4XE4o26l6238SUOm+Lpq758sa6Nj32S8/igkqlFb4Z2m3/H /K5x02mV2iD1SG1vb9PzTp0M+x2o/qhzYLPHjkJzDCR7F/LJ57Zu6Jp19KVxfc+Z8wS0FMr1vzj yJCWLsQ/O2/iu3vf3ffcvlmbP+Hk0pdmoZN+B9x406sNAA==
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
 drivers/pwm/pwm-dwc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 19b9a23d5ee1..71e322e045f8 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -51,6 +51,7 @@ struct dwc_pwm_ctx {
 };
 
 struct dwc_pwm {
+	struct device *parent;
 	void __iomem *base;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
@@ -153,12 +154,12 @@ static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (state->enabled) {
 		if (!pwm->state.enabled)
-			pm_runtime_get_sync(chip->dev);
+			pm_runtime_get_sync(dwc->parent);
 		return __dwc_pwm_configure_timer(dwc, pwm, state);
 	} else {
 		if (pwm->state.enabled) {
 			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
-			pm_runtime_put_sync(chip->dev);
+			pm_runtime_put_sync(dwc->parent);
 		}
 	}
 
@@ -171,7 +172,7 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	u64 duty, period;
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(dwc->parent);
 
 	state->enabled = !!(dwc_pwm_readl(dwc,
 				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
@@ -189,7 +190,7 @@ static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	state->polarity = PWM_POLARITY_INVERSED;
 
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(dwc->parent);
 
 	return 0;
 }
@@ -202,8 +203,9 @@ static const struct pwm_ops dwc_pwm_ops = {
 static struct pwm_chip *dwc_pwm_alloc(struct device *dev)
 {
 	struct pwm_chip *chip;
+	struct dwc_pwm *dwc;
 
-	chip = devm_pwmchip_alloc(dev, DWC_TIMERS_TOTAL, sizeof(struct dwc_pwm));
+	chip = devm_pwmchip_alloc(dev, DWC_TIMERS_TOTAL, sizeof(*dwc));
 	if (!chip)
 		return NULL;
 
@@ -211,6 +213,9 @@ static struct pwm_chip *dwc_pwm_alloc(struct device *dev)
 
 	dev_set_drvdata(dev, chip);
 
+	dwc = to_dwc_pwm(chip);
+	dwc->parent = dev;
+
 	return chip;
 }
 
-- 
2.40.1

