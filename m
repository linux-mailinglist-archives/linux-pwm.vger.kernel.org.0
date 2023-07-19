Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6A7759E5F
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 21:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjGSTUa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 15:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjGSTU2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 15:20:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B124C1FED
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 12:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCih-0000ME-1C; Wed, 19 Jul 2023 21:20:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCig-000fi5-CJ; Wed, 19 Jul 2023 21:20:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCif-006B2s-Mg; Wed, 19 Jul 2023 21:20:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 5/5] pwm: atmel-tcb: Don't track polarity in driver data
Date:   Wed, 19 Jul 2023 21:20:13 +0200
Message-Id: <20230719192013.4051193-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3345; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2l4igXG2vYma5k0U32frSZlmMea9tUW1UgDZy13RiCk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpQd5llz1UI8POLjdnB7czLJeufeDbK4ksAiU3tX7+wek 5uyjVqdjMYsDIxcDLJiiiz2jWsyrarkIjvX/rsMM4iVCWQKAxenAEzk9EYOhuY7r2f2bNJkEttQ W2Qbns+wqze8b8nLmYxGyVYlO/KFzxRbyevtT77IYyD/yWbz/tTGveK/d/SvLZx19MV5PcWgksO Z/bfr4w37LxkxpR3Q4f7I256XEtF0as3aSyqJDj1L94itiF5z1Tbd7+usyZYd1YWtbgt0bCa775 FKPMt2Pu7Bw19Cqzi/aCk9W3KzmMXJxfzSNcF376ZrtHM2zxZvMo/dGpS5QSf/6fcVKmf/114I3 XG8+/uW/APeL1kYzOwakyR2H2XwOr6ir0VROWTZsYCWaZv7Dx99/rD84b4JWe885f8LdLds1Sia fE7MWY+/46cJp0eXpLirk3L2piesu9VkNJbIzN0/J+IGAA==
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

struct atmel_tcb_pwm_device::polarity is only used in atmel_tcb_pwm_enable
and atmel_tcb_pwm_disable(). These functions are only called by
atmel_tcb_pwm_apply() after the member variable was assigned to
state->polarity. So the value assigned in atmel_tcb_pwm_request() is
never used and the member can be dropped from struct atmel_tcb_pwm_device.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 32a60d7f8ed2..30c966238e41 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -34,7 +34,6 @@
 				 ATMEL_TC_BEEVT | ATMEL_TC_BSWTRG)
 
 struct atmel_tcb_pwm_device {
-	enum pwm_polarity polarity;	/* PWM polarity */
 	unsigned div;			/* PWM clock divider */
 	unsigned duty;			/* PWM duty expressed in clk cycles */
 	unsigned period;		/* PWM period expressed in clk cycles */
@@ -80,7 +79,6 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 	if (ret)
 		return ret;
 
-	tcbpwm->polarity = PWM_POLARITY_NORMAL;
 	tcbpwm->duty = 0;
 	tcbpwm->period = 0;
 	tcbpwm->div = 0;
@@ -123,12 +121,12 @@ static void atmel_tcb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(tcbpwmc->clk);
 }
 
-static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
+				  enum pwm_polarity polarity)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
 	unsigned cmr;
-	enum pwm_polarity polarity = tcbpwm->polarity;
 
 	/*
 	 * If duty is 0 the timer will be stopped and we have to
@@ -180,12 +178,12 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	spin_unlock(&tcbpwmc->lock);
 }
 
-static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+				enum pwm_polarity polarity)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
 	u32 cmr;
-	enum pwm_polarity polarity = tcbpwm->polarity;
 
 	/*
 	 * If duty is 0 the timer will be stopped and we have to
@@ -345,15 +343,11 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			       const struct pwm_state *state)
 {
-	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
 	int duty_cycle, period;
 	int ret;
 
-	tcbpwm->polarity = state->polarity;
-
 	if (!state->enabled) {
-		atmel_tcb_pwm_disable(chip, pwm);
+		atmel_tcb_pwm_disable(chip, pwm, state->polarity);
 		return 0;
 	}
 
@@ -364,7 +358,7 @@ static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret)
 		return ret;
 
-	return atmel_tcb_pwm_enable(chip, pwm);
+	return atmel_tcb_pwm_enable(chip, pwm, state->polarity);
 }
 
 static const struct pwm_ops atmel_tcb_pwm_ops = {
-- 
2.39.2

