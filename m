Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6604CACC2
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Mar 2022 19:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244346AbiCBSBB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Mar 2022 13:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244345AbiCBSBB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Mar 2022 13:01:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74529D5F49
        for <linux-pwm@vger.kernel.org>; Wed,  2 Mar 2022 10:00:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPTGm-0005Ky-RL; Wed, 02 Mar 2022 19:00:12 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPTGm-002Fx7-C4; Wed, 02 Mar 2022 19:00:11 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPTGl-006Xsh-2O; Wed, 02 Mar 2022 19:00:11 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: atmel-tcb: Drop duplicated tracking of per-channel data
Date:   Wed,  2 Mar 2022 19:00:00 +0100
Message-Id: <20220302180000.333087-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3049; h=from:subject; bh=8H/gpVvC6oYqFejjs0QtbMP2CFNukpst7bwfrrEIKME=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiH7Cc+dgwL6LmRJEy7BrIteyxburUptZxAP20q0MH T/cidM2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYh+wnAAKCRDB/BR4rcrsCaXQCA CU8VRv9hctQ1ehYHeDFcOG7lL2KeE3XuHmmRMCOJe1viOnBxsotUmfF+z6t+TnGUtUTnKl8z1/jDEX SubTSABzoJDl/f4DTv76Bl3oJQhPf0MqNKeelZsO5bn3v1h/s5+8kElTaXWKOUNqX5wHcXSOt2L6WX rZ7xGttT5Bj1dr+AQLGO3L5dDUgBqwcjbP3HYG2eY3u9c0NL2llgUJhrlUcLRv1yRfeeASXKS81UVl J+KgaNYApStD7qmrvEhLDw4S/jVD8pu5PCqrJ3Gt2YolWR8BOVTX8IMFIcrAy9gbloe15+UkeaX4Mh swM1knKLRhw6C/h3ac42z0bYnYQCTU
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

Per-channel data is tracked using struct pwm_device::chip_data and
struct atmel_tcb_pwm_chip::pwms[]. Simplify by using the latter
consistently.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I just found this patch in my pwm tree authored back in November. It
seems I failed to send it out earlier as I find no trace of it in my
mailbox.

Best regards
Uwe

 drivers/pwm/pwm-atmel-tcb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 36f7ea381838..bea622f53ba8 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -72,7 +72,8 @@ static int atmel_tcb_pwm_set_polarity(struct pwm_chip *chip,
 				      struct pwm_device *pwm,
 				      enum pwm_polarity polarity)
 {
-	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
+	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
+	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
 
 	tcbpwm->polarity = polarity;
 
@@ -97,7 +98,6 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 		return ret;
 	}
 
-	pwm_set_chip_data(pwm, tcbpwm);
 	tcbpwm->polarity = PWM_POLARITY_NORMAL;
 	tcbpwm->duty = 0;
 	tcbpwm->period = 0;
@@ -139,7 +139,7 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 static void atmel_tcb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
+	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
 
 	clk_disable_unprepare(tcbpwmc->clk);
 	tcbpwmc->pwms[pwm->hwpwm] = NULL;
@@ -149,7 +149,7 @@ static void atmel_tcb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
+	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
 	unsigned cmr;
 	enum pwm_polarity polarity = tcbpwm->polarity;
 
@@ -206,7 +206,7 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
+	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
 	u32 cmr;
 	enum pwm_polarity polarity = tcbpwm->polarity;
 
@@ -291,7 +291,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 				int duty_ns, int period_ns)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
+	struct atmel_tcb_pwm_device *tcbpwm = tcbpwmc->pwms[pwm->hwpwm];
 	struct atmel_tcb_pwm_device *atcbpwm = NULL;
 	int i = 0;
 	int slowclk = 0;
-- 
2.34.1

