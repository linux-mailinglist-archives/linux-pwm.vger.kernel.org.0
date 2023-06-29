Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45690742370
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jun 2023 11:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjF2JtA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Jun 2023 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjF2Js4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Jun 2023 05:48:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395D91727
        for <linux-pwm@vger.kernel.org>; Thu, 29 Jun 2023 02:48:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGh-0006UU-7P; Thu, 29 Jun 2023 11:48:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGg-00AroH-HV; Thu, 29 Jun 2023 11:48:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGf-000kwv-N8; Thu, 29 Jun 2023 11:48:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 5/8] pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
Date:   Thu, 29 Jun 2023 11:48:36 +0200
Message-Id: <20230629094839.757092-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
References: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3449; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XWvHRo/FqTNSUcZn9kfl0d5Tlm7+iJEvW8bKi58Ky6Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBknVNpHbj3EogkRylIrLmybR6rBH9xLOGqFQZy1 prZItBqRZqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZJ1TaQAKCRCPgPtYfRL+ Tm1nB/wMDYqBg2tQ8n/mR217NdlCFuTdPJC1PXTHZVGOHsReo675nL5CCsPGTMYCBpYNx2A3ycJ xfle4gRYgNZrOPF+mQZdD0GaF40QzMoUKs1iBCzEenyUWmPftuAZYqYA6kESBPFWJHUFB6Nqjmp Bwh3AixSxI0IZEwg4rKcRKQ93uIQfhOur5LM8vCMvGtJBIt4cwtZSi9qucGP7HDDytS0Cifs8Up /puN8uWZLmbBJtokgnieCMrGh5cvzT/JBNH/tow5+H7KLT8iBg35odERjz38syCZhgNxiG1MRfl fgrMWcXhzanw8PF3JO4mE+uIhcwI4hcARgCZ/4Uq+ynx0uhh
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

Instead of distributing the driver's bookkeeping over 5 (i.e.
TPU_CHANNEL_MAX + 1) separately allocated memory chunks, put all
together in struct tpu_device. This reduces the number of memory
allocations and so fragmentation and maybe even the number of cache
misses. Also &tpu->tpd[pwm->hwpwm] is cheaper to evaluate than
pwm_get_chip_data(pwm) as the former is just an addition in machine code
while the latter involves a function call.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index d7311614c846..613dd549edf8 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -85,6 +85,7 @@ struct tpu_device {
 
 	void __iomem *base;
 	struct clk *clk;
+	struct tpu_pwm_device tpd[TPU_CHANNEL_MAX];
 };
 
 #define to_tpu_device(c)	container_of(c, struct tpu_device, chip)
@@ -215,9 +216,7 @@ static int tpu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (pwm->hwpwm >= TPU_CHANNEL_MAX)
 		return -EINVAL;
 
-	tpd = kzalloc(sizeof(*tpd), GFP_KERNEL);
-	if (tpd == NULL)
-		return -ENOMEM;
+	tpd = &tpu->tpd[pwm->hwpwm];
 
 	tpd->tpu = tpu;
 	tpd->channel = pwm->hwpwm;
@@ -228,24 +227,22 @@ static int tpu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	tpd->timer_on = false;
 
-	pwm_set_chip_data(pwm, tpd);
-
 	return 0;
 }
 
 static void tpu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
+	struct tpu_device *tpu = to_tpu_device(chip);
+	struct tpu_pwm_device *tpd = &tpu->tpd[pwm->hwpwm];
 
 	tpu_pwm_timer_stop(tpd);
-	kfree(tpd);
 }
 
 static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  u64 duty_ns, u64 period_ns, bool enabled)
 {
-	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
 	struct tpu_device *tpu = to_tpu_device(chip);
+	struct tpu_pwm_device *tpd = &tpu->tpd[pwm->hwpwm];
 	unsigned int prescaler;
 	bool duty_only = false;
 	u32 clk_rate;
@@ -353,7 +350,8 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int tpu_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 				enum pwm_polarity polarity)
 {
-	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
+	struct tpu_device *tpu = to_tpu_device(chip);
+	struct tpu_pwm_device *tpd = &tpu->tpd[pwm->hwpwm];
 
 	tpd->polarity = polarity;
 
@@ -362,7 +360,8 @@ static int tpu_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tpu_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
+	struct tpu_device *tpu = to_tpu_device(chip);
+	struct tpu_pwm_device *tpd = &tpu->tpd[pwm->hwpwm];
 	int ret;
 
 	ret = tpu_pwm_timer_start(tpd);
@@ -384,7 +383,8 @@ static int tpu_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static void tpu_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
+	struct tpu_device *tpu = to_tpu_device(chip);
+	struct tpu_pwm_device *tpd = &tpu->tpd[pwm->hwpwm];
 
 	/* The timer must be running to modify the pin output configuration. */
 	tpu_pwm_timer_start(tpd);
-- 
2.39.2

