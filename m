Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F6747F00
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jul 2023 10:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjGEIHK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Jul 2023 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjGEIHI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Jul 2023 04:07:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ECB10DD
        for <linux-pwm@vger.kernel.org>; Wed,  5 Jul 2023 01:07:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXN-0003pM-7B; Wed, 05 Jul 2023 10:06:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXM-00CDNM-IV; Wed, 05 Jul 2023 10:06:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qGxXL-002Ob6-NV; Wed, 05 Jul 2023 10:06:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 5/8] pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
Date:   Wed,  5 Jul 2023 10:06:47 +0200
Message-Id: <20230705080650.2353391-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
References: <20230705080650.2353391-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3449; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dtKPsVXm+RNhVEpbq+oyaOc0WXDL80CyigaXgONk7Ws=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkpSSSN57tUMcVDMU3NCRHzhS7wrB+V49KpSDyl 80WH5D9R5uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKUkkgAKCRCPgPtYfRL+ ToKaB/46QAW+rVJ+BW8clQwnbm1b0g/XsTn2MJb0t/IhwXFClS6nCxtZmh8G3mCtQGEIakMMxLL cEASX1pDTywHG0RVxLw3iI2vAHueCz6c0kqg9Rj3U1ueo1u6crh9e1uo156SnhwO9grASYX4Ym2 uiVsw38kuGZRe7aEJ94YzFU9ZwxukWmbrFymorgUB1FFP3Vepk8T6kX3ckbnXIFYlCxN6jrbZqH nrUmmCauYzQAZpwZnOmH/R5m/Bg4czNFE3ZYLENhRrc41UJoe3ZMk77aVy8zqEFihepBVSBT8WQ ujpS8KKFUaaz2JvfUI8G1PudC/bRK1OmvixU9RQIOvN2aQaG
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Instead of distributing the driver's bookkeeping over 5 (i.e.
TPU_CHANNEL_MAX + 1) separately allocated memory chunks, put all together
in struct tpu_device. This reduces the number of memory allocations and
so fragmentation and maybe even the number of cache misses. Also
&tpu->tpd[pwm->hwpwm] is cheaper to evaluate than pwm_get_chip_data(pwm)
as the former is just an addition in machine code while the latter involves
a function call.

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

