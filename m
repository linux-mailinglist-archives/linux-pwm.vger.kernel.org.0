Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B819759E5C
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGSTU2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 15:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGSTU1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 15:20:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9521FD2
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 12:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCig-0000M9-Se; Wed, 19 Jul 2023 21:20:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCig-000fi0-8Y; Wed, 19 Jul 2023 21:20:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCif-006B2p-BW; Wed, 19 Jul 2023 21:20:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 4/5] pwm: atmel-tcb: Unroll atmel_tcb_pwm_set_polarity() into only caller
Date:   Wed, 19 Jul 2023 21:20:12 +0200
Message-Id: <20230719192013.4051193-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6RtdRmEA/1/I6/kU+/9IY5NVenhVbQYWdZ85hNB9qsc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkuDdpjXupQyy3CyWlFzrfjWXtndBWebkXMNlbi goNc22KiVaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLg3aQAKCRCPgPtYfRL+ TiKYB/4/wo2dXiiTzpqdiwP1resWcWZU2hHCf95RC9TdTdU1UbEeCFEnd4XymYFJ1sUv9psDGqe J5LKsnvSEUtidlFBg4PL2N0Um4XK9qDadjehXt0UbBdDwp3zKeUzylCbkXNDxvXYY2ibI48JjVR aXj1JtqDfaWX95PMyDQoto4Q7ArgRflZPEQshsmQLGosPWOQdcZjYah2AEJnftCEvE7bZD2ofvp OehAP9YNdQwBCMd8F/jCHdvePf/I5rFaXofg4qZXORUAiRpjzC1lXs5qkzY+c0NtG35p4IPP9KJ GEGjTPrvq7w7y7uGSEbJFLJl0TSKAXM0dqQ2ozZS9HfbxYuu
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

atmel_tcb_pwm_set_polarity() is only called once and effectively wraps
an assignment only. Replace the function call by the respective
assignment.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index ae274bd7907d..32a60d7f8ed2 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -68,18 +68,6 @@ static inline struct atmel_tcb_pwm_chip *to_tcb_chip(struct pwm_chip *chip)
 	return container_of(chip, struct atmel_tcb_pwm_chip, chip);
 }
 
-static int atmel_tcb_pwm_set_polarity(struct pwm_chip *chip,
-				      struct pwm_device *pwm,
-				      enum pwm_polarity polarity)
-{
-	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
-	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
-
-	tcbpwm->polarity = polarity;
-
-	return 0;
-}
-
 static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 				 struct pwm_device *pwm)
 {
@@ -357,11 +345,12 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			       const struct pwm_state *state)
 {
+	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
+	struct atmel_tcb_pwm_device *tcbpwm = &tcbpwmc->pwms[pwm->hwpwm];
 	int duty_cycle, period;
 	int ret;
 
-	/* This function only sets a flag in driver data */
-	atmel_tcb_pwm_set_polarity(chip, pwm, state->polarity);
+	tcbpwm->polarity = state->polarity;
 
 	if (!state->enabled) {
 		atmel_tcb_pwm_disable(chip, pwm);
-- 
2.39.2

