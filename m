Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E2A7C72AD
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379576AbjJLQbE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379570AbjJLQa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00DBDD
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-0004lv-31; Thu, 12 Oct 2023 18:30:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaL-001C60-7G; Thu, 12 Oct 2023 18:30:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-00F5Mr-US; Thu, 12 Oct 2023 18:30:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 012/109] pwm: fsl-ftm: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:40 +0200
Message-ID: <20231012162827.1002444-123-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1912; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=nWr7Fn1CP8UGCXi7544g8G4oBBwlUD+iTlh8wcPSjDU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB66htSaqJ0s2B29OoNxNT6WxK2WSJ8TmmBp8 4rbC1BSgQmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgeugAKCRCPgPtYfRL+ TiJMB/43pl0eBM+XLJL9lLNEoO9Z1PNAR3Dokf1PrbunVvtrPAl94aShVgZ/o5yr0gpElZyWWB2 s8Hscn1U32KWahii4RubOl6DlkD86p9PTTv1WPklm3vomJxG9hKVkQh2GiMgX3yOT5WslJltJ82 TACShnOoiTXheyHSlZ1KCaAfDsyjaElEEICB88eN0Lnkn0DpjKy2oc9FiY6aoonpp+NrQrwB3ty YWIaHE/ukwQtImJk/mCdkgncGG/8lhbtmDA7/fyqN2JuDs4uHt4kNtv5iMIhNtfy4zbwsDK5cIy JIxXlqyuiHz6wRcPouxbu3eiDIbQHi7tpMGakEk/adNgOzrZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index d1b6d1aa4773..47f1f5ac39cf 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -221,10 +221,11 @@ static bool fsl_pwm_is_other_pwm_enabled(struct fsl_pwm_chip *fpc,
 		return false;
 }
 
-static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
+static int fsl_pwm_apply_config(struct pwm_chip *chip,
 				struct pwm_device *pwm,
 				const struct pwm_state *newstate)
 {
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	unsigned int duty;
 	u32 reg_polarity;
 
@@ -232,7 +233,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	bool do_write_period = false;
 
 	if (!fsl_pwm_calculate_period(fpc, newstate->period, &periodcfg)) {
-		dev_err(fpc->chip.dev, "failed to calculate new period\n");
+		dev_err(pwmchip_parent(chip), "failed to calculate new period\n");
 		return -EINVAL;
 	}
 
@@ -246,7 +247,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	 */
 	else if (!fsl_pwm_periodcfg_are_equal(&fpc->period, &periodcfg)) {
 		if (fsl_pwm_is_other_pwm_enabled(fpc, pwm)) {
-			dev_err(fpc->chip.dev,
+			dev_err(pwmchip_parent(chip),
 				"Cannot change period for PWM %u, disable other PWMs first\n",
 				pwm->hwpwm);
 			return -EBUSY;
@@ -322,7 +323,7 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		goto end_mutex;
 	}
 
-	ret = fsl_pwm_apply_config(fpc, pwm, newstate);
+	ret = fsl_pwm_apply_config(chip, pwm, newstate);
 	if (ret)
 		goto end_mutex;
 
-- 
2.42.0

