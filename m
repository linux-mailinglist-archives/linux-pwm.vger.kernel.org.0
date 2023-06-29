Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE043742372
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jun 2023 11:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjF2JtC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Jun 2023 05:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjF2Js4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Jun 2023 05:48:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93F2D4C
        for <linux-pwm@vger.kernel.org>; Thu, 29 Jun 2023 02:48:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGi-0006UT-3M; Thu, 29 Jun 2023 11:48:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGg-00AroF-GG; Thu, 29 Jun 2023 11:48:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEoGf-000kwz-TN; Thu, 29 Jun 2023 11:48:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, George Stark <gnstark@sberdevices.ru>
Subject: [PATCH 6/8] pwm: sti: Reduce number of allocations and drop usage of chip_data
Date:   Thu, 29 Jun 2023 11:48:37 +0200
Message-Id: <20230629094839.757092-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
References: <20230629094839.757092-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3282; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=nSWpR0cKXowRfDOnbQjfrAtNnhI5uJsTqOzSE3SnQ68=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBknVNqVu6GSBvx7JgBM/hsw8agkLwf+fvXkU5e/ 3qJ2PbBB8qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZJ1TagAKCRCPgPtYfRL+ TsMPB/4sOMmgtH+f2xwVf4t8bV2GgbNNaaa4W9oxw0rieS7QkW40WFM+yz5V9+4qN84SYaUwZDo kzgzACA8Q1Qvyseqavc30pA25YMwmDpxbiXhcTP7NKjVi0k4oPhXHVXMuFdbe2C/If31mCM9UQm Q8dmQew3dj7oiPeHXmqW4XwZvghbnPTM18VXmmFLf1WEtSjtFNboMRvG1OqcaPtbDo1nY/OERfp ORJBZleFo/dz7sPtafpu8w0TYJ4fv1vu2YKqr2MfapEiAZsP5KrjpKOCpBWW+CC841KOYZfdaJp IzJppQCAv/0VDhkvFR5ik5RzWlic1zH0jHP9MEi91XHi2hX2
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

Instead of using one allocation per capture channel, use a single one
for the whole chip. Also store it in driver data instead of chip data.

This has several advantages:

 - driver data isn't cleared when pwm_put() is called
 - Reduces memory fragmentation

Also register the pwm chip only after the per capture channel data is
initialized as the capture callback relies on this initialization and it
might be called even before pwmchip_add() returns.

It would be still better to have struct sti_pwm_compat_data and the
per-channel data struct sti_cpt_ddata in a single memory chunk, but
that's not easily possible because the number of capture channels isn't
known yet when the driver data struct is allocated.

Fixes: e926b12c611c ("pwm: Clear chip_data in pwm_put()")
Reported-by: George Stark <gnstark@sberdevices.ru>
Fixes: c97267ae831d ("pwm: sti: Add PWM capture callback")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index b1d1373648a3..c8800f84b917 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -79,6 +79,7 @@ struct sti_pwm_compat_data {
 	unsigned int cpt_num_devs;
 	unsigned int max_pwm_cnt;
 	unsigned int max_prescale;
+	struct sti_cpt_ddata *ddata;
 };
 
 struct sti_pwm_chip {
@@ -314,7 +315,7 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 	struct sti_pwm_compat_data *cdata = pc->cdata;
-	struct sti_cpt_ddata *ddata = pwm_get_chip_data(pwm);
+	struct sti_cpt_ddata *ddata = &cdata->ddata[pwm->hwpwm];
 	struct device *dev = pc->dev;
 	unsigned int effective_ticks;
 	unsigned long long high, low;
@@ -440,7 +441,7 @@ static irqreturn_t sti_pwm_interrupt(int irq, void *data)
 	while (cpt_int_stat) {
 		devicenum = ffs(cpt_int_stat) - 1;
 
-		ddata = pwm_get_chip_data(&pc->chip.pwms[devicenum]);
+		ddata = &pc->cdata->ddata[devicenum];
 
 		/*
 		 * Capture input:
@@ -638,12 +639,23 @@ static int sti_pwm_probe(struct platform_device *pdev)
 			dev_err(dev, "failed to prepare clock\n");
 			return ret;
 		}
+
+		cdata->ddata = devm_kzalloc(dev, cdata->cpt_num_devs * sizeof(*cdata->ddata), GFP_KERNEL);
+		if (!cdata->ddata)
+			return -ENOMEM;
 	}
 
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.npwm = pc->cdata->pwm_num_devs;
 
+	for (i = 0; i < cdata->cpt_num_devs; i++) {
+		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
+
+		init_waitqueue_head(&ddata->wait);
+		mutex_init(&ddata->lock);
+	}
+
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		clk_unprepare(pc->pwm_clk);
@@ -651,19 +663,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	for (i = 0; i < cdata->cpt_num_devs; i++) {
-		struct sti_cpt_ddata *ddata;
-
-		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-		if (!ddata)
-			return -ENOMEM;
-
-		init_waitqueue_head(&ddata->wait);
-		mutex_init(&ddata->lock);
-
-		pwm_set_chip_data(&pc->chip.pwms[i], ddata);
-	}
-
 	platform_set_drvdata(pdev, pc);
 
 	return 0;
-- 
2.39.2

