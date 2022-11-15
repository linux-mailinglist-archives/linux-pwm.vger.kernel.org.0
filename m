Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83E16296F4
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Nov 2022 12:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbiKOLP0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Nov 2022 06:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiKOLO6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Nov 2022 06:14:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5A6BC0B
        for <linux-pwm@vger.kernel.org>; Tue, 15 Nov 2022 03:14:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt8-0006We-IW; Tue, 15 Nov 2022 12:13:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt6-004QgX-Ks; Tue, 15 Nov 2022 12:13:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1outt6-00GmRZ-M8; Tue, 15 Nov 2022 12:13:56 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 1/5] pwm: fsl-ftm: Use regmap_clear_bits and regmap_set_bits where applicable
Date:   Tue, 15 Nov 2022 12:13:43 +0100
Message-Id: <20221115111347.3705732-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
References: <20221115111347.3705732-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SPekvbDmZnWhtruMA5ZVyZjhbuCa7kZTXWW+Niu7114=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjc3RWmPV9fxBb+6lhUWDNcO9mHwSofxpw0mBHjnUu h0fRLMGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY3N0VgAKCRDB/BR4rcrsCQ6fB/ 0ZHC09KQOau4/VEBacHSfY2jJ8dhhXDpJ7KkTEU2ybLo96HX+XrmbWbL/eSwgMFXSil49ShqazpGz6 GpYN9jb+HudQtrhh4HzXxIz1UVlowCvyJIlSkuqWk47BscNIKVsXME+vmTS5g03lmRWyLYUYEynSzY gB8rhnPmRp4CmYFJtCeAR1gQjdNq89EhrZiSgX1K3GNn8no5JFhIBwU/8bYE7yIoyAmp58fB4Gt2MH +yb9pZBG3zmB+5aWFtdCrqZmzTminLZ082PSu2Gr6T0U+0dBcj2BaOZgFVuzn+jmcBOU3wjuJLrjHd HSfLtc1xmW8sNPu8l80EIRpxvKAMp7
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Found using coccinelle and the following semantic patch:

@@
expression map, reg, bits;
@@

- regmap_update_bits(map, reg, bits, bits)
+ regmap_set_bits(map, reg, bits)

@@
expression map, reg, bits;
@@

- regmap_update_bits(map, reg, bits, 0)
+ regmap_clear_bits(map, reg, bits)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 0247757f9a72..5caadbd6194e 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -65,13 +65,12 @@ static void ftm_clear_write_protection(struct fsl_pwm_chip *fpc)
 
 	regmap_read(fpc->regmap, FTM_FMS, &val);
 	if (val & FTM_FMS_WPEN)
-		regmap_update_bits(fpc->regmap, FTM_MODE, FTM_MODE_WPDIS,
-				   FTM_MODE_WPDIS);
+		regmap_set_bits(fpc->regmap, FTM_MODE, FTM_MODE_WPDIS);
 }
 
 static void ftm_set_write_protection(struct fsl_pwm_chip *fpc)
 {
-	regmap_update_bits(fpc->regmap, FTM_FMS, FTM_FMS_WPEN, FTM_FMS_WPEN);
+	regmap_set_bits(fpc->regmap, FTM_FMS, FTM_FMS_WPEN);
 }
 
 static bool fsl_pwm_periodcfg_are_equal(const struct fsl_pwm_periodcfg *a,
@@ -94,8 +93,7 @@ static int fsl_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	ret = clk_prepare_enable(fpc->ipg_clk);
 	if (!ret && fpc->soc->has_enable_bits) {
 		mutex_lock(&fpc->lock);
-		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16),
-				   BIT(pwm->hwpwm + 16));
+		regmap_set_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16));
 		mutex_unlock(&fpc->lock);
 	}
 
@@ -108,8 +106,7 @@ static void fsl_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	if (fpc->soc->has_enable_bits) {
 		mutex_lock(&fpc->lock);
-		regmap_update_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16),
-				   0);
+		regmap_clear_bits(fpc->regmap, FTM_SC, BIT(pwm->hwpwm + 16));
 		mutex_unlock(&fpc->lock);
 	}
 
@@ -317,8 +314,8 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (!newstate->enabled) {
 		if (oldstate->enabled) {
-			regmap_update_bits(fpc->regmap, FTM_OUTMASK,
-					   BIT(pwm->hwpwm), BIT(pwm->hwpwm));
+			regmap_set_bits(fpc->regmap, FTM_OUTMASK,
+					BIT(pwm->hwpwm));
 			clk_disable_unprepare(fpc->clk[FSL_PWM_CLK_CNTEN]);
 			clk_disable_unprepare(fpc->clk[fpc->period.clk_select]);
 		}
@@ -342,8 +339,7 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			goto end_mutex;
 		}
 
-		regmap_update_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm),
-				   0);
+		regmap_clear_bits(fpc->regmap, FTM_OUTMASK, BIT(pwm->hwpwm));
 	}
 
 end_mutex:
-- 
2.38.1

