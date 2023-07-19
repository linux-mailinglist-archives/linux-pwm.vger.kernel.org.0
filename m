Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA8759E5E
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 21:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGSTU3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 15:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjGSTU2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 15:20:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA3A1FE6
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 12:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCig-0000Lf-Dv; Wed, 19 Jul 2023 21:20:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCif-000fht-OS; Wed, 19 Jul 2023 21:20:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCif-006B2m-3Q; Wed, 19 Jul 2023 21:20:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 3/5] pwm: atmel-tcb: Put per-channel data into driver data
Date:   Wed, 19 Jul 2023 21:20:11 +0200
Message-Id: <20230719192013.4051193-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3867; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PywXd2NsSBKcG4uMgoh/WGkS453g3eOfsK+Kx8SQ+/s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkuDdoU0gwRFZBmOfe1VYeJSKLreb6AruCDpHUK 5ITyKKyKdeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLg3aAAKCRCPgPtYfRL+ TqFSB/9poyk12wE2wWuOJDgjRTBd7sU7Y/Uph1EIEGK3LcJ7YEqb81MmpqbKXxjDGb5Uh5nvghj rOh/y4+nriRGsoOFRYvuXgdgN4N+b6pmd63LqAoG7yBqN06Nbs1bqfOu9MhlWd97yLMgpopQOXn zcTdevF0JeslWoNCtZraDfc7PKVAMFzbcoLLGpR/p6uhiNzoIHbgCwnIi4XfIHSGNS2+eIkNBVL T9Wl5ju8hXIe5H45/GIAqvxhfjS+jiNqTOdJWT4gmVlWVMCECJSj6uYG9rU8AhbnZjs9ORmPX/0 lt2PQdc7Rpke3XP/3hW5m+vdtfR3UChMIZMdKiO1x1Ea9vdS
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

This simplifies the code, reduces the number of memory allocations and
pointer dereferences.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 2826fc216d29..ae274bd7907d 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -57,7 +57,7 @@ struct atmel_tcb_pwm_chip {
 	struct clk *clk;
 	struct clk *gclk;
 	struct clk *slow_clk;
-	struct atmel_tcb_pwm_device *pwms[NPWM];
+	struct atmel_tcb_pwm_device pwms[NPWM];
 	struct atmel_tcb_channel bkup;
 };
 
@@ -73,7 +73,7 @@ static int atmel_tcb_pwm_set_polarity(struct pwm_chip *chip,
 				      enum pwm_polarity polarity)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
+	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
 
 	tcbpwm->polarity = polarity;
 
@@ -84,19 +84,13 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 				 struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm;
+	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
 	unsigned cmr;
 	int ret;
 
-	tcbpwm = devm_kzalloc(chip->dev, sizeof(*tcbpwm), GFP_KERNEL);
-	if (!tcbpwm)
-		return -ENOMEM;
-
 	ret = clk_prepare_enable(tcbpwmc->clk);
-	if (ret) {
-		devm_kfree(chip->dev, tcbpwm);
+	if (ret)
 		return ret;
-	}
 
 	tcbpwm->polarity = PWM_POLARITY_NORMAL;
 	tcbpwm->duty = 0;
@@ -131,25 +125,20 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), cmr);
 	spin_unlock(&tcbpwmc->lock);
 
-	tcbpwmc->pwms[pwm->hwpwm] = tcbpwm;
-
 	return 0;
 }
 
 static void atmel_tcb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
 
 	clk_disable_unprepare(tcbpwmc->clk);
-	tcbpwmc->pwms[pwm->hwpwm] = NULL;
-	devm_kfree(chip->dev, tcbpwm);
 }
 
 static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
+	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
 	unsigned cmr;
 	enum pwm_polarity polarity = tcbpwm->polarity;
 
@@ -206,7 +195,7 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
+	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
 	u32 cmr;
 	enum pwm_polarity polarity = tcbpwm->polarity;
 
@@ -291,7 +280,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 				int duty_ns, int period_ns)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
+	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
 	struct atmel_tcb_pwm_device *atcbpwm = NULL;
 	int i = 0;
 	int slowclk = 0;
@@ -338,9 +327,9 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	period = div_u64(period_ns, min);
 
 	if (pwm->hwpwm == 0)
-		atcbpwm = tcbpwmc->pwms[1];
+		atcbpwm = &tcbpwmc->pwms[1];
 	else
-		atcbpwm = tcbpwmc->pwms[0];
+		atcbpwm = &tcbpwmc->pwms[0];
 
 	/*
 	 * PWM devices provided by the TCB driver are grouped by 2.
-- 
2.39.2

