Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B05A57C903
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiGUKbo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Jul 2022 06:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiGUKbm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 06:31:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFDED125
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 03:31:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSz-0002Vz-QO; Thu, 21 Jul 2022 12:31:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSy-002IMl-IZ; Thu, 21 Jul 2022 12:31:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSx-006ZIM-JH; Thu, 21 Jul 2022 12:31:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH 3/7] pwm: sifive: Reduce time the controller lock is held
Date:   Thu, 21 Jul 2022 12:31:25 +0200
Message-Id: <20220721103129.304697-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2153; h=from:subject; bh=J40tL02o9FO4AFx8pwx3mZeFbRQCIoDJSyD9wHvo7Bo=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi2Srys/0egwS0iYQbrd+sk9wZXWLS+eWFR8ARYEas Y8+EXc2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtkq8gAKCRDB/BR4rcrsCcG1B/ 4ipirIA6LplygiukGiSZZJ+OP+ym5swDwJGcI5D7TWYk/jD+kmQTsvzSnbG2mCSIP16fp1MyZKacCf 96W3WZvxXLQBs4XkAP60pZ2YX/5puZJE77TNMepcAAD18FENyT6EwnfYeeWy3Ben9qjUepVX3iyhhR 7qIlP6yK+fkUnH7ml5OgvkVCTf3sOwYoMoiEEPafbAMlJImjxDxy0OvQagk4X9KQCYkxBfJ8Y4QpUM goss5DoYNMsC3TruNIMaLoeWecmB6+mZgTh3xNE8vgg+4KqT4yQyW1BrjVzIjhhiWAX3a1ZkGJ4X+q FmnEpj4OvVzXhVtxEisAM8PTwPpApB
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

The lock is only to serialize access and update to user_count and
approx_period between different PWMs served by the same pwm_chip.
So the lock needs only to be taken during the check if the (chip global)
period can and/or needs to be changed.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 91cf90bd4083..6017e311a879 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -41,7 +41,7 @@
 
 struct pwm_sifive_ddata {
 	struct pwm_chip	chip;
-	struct mutex lock; /* lock to protect user_count */
+	struct mutex lock; /* lock to protect user_count and approx_period */
 	struct notifier_block notifier;
 	struct clk *clk;
 	void __iomem *regs;
@@ -76,6 +76,7 @@ static void pwm_sifive_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_unlock(&ddata->lock);
 }
 
+/* Called holding ddata->lock */
 static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 				    unsigned long rate)
 {
@@ -144,7 +145,6 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 	}
 
-	mutex_lock(&ddata->lock);
 	cur_state = pwm->state;
 	enabled = cur_state.enabled;
 
@@ -163,14 +163,17 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
 
+	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
 		if (ddata->user_count != 1) {
+			mutex_unlock(&ddata->lock);
 			ret = -EBUSY;
 			goto exit;
 		}
 		ddata->approx_period = state->period;
 		pwm_sifive_update_clock(ddata, clk_get_rate(ddata->clk));
 	}
+	mutex_unlock(&ddata->lock);
 
 	writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
 
@@ -185,7 +188,6 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 exit:
 	clk_disable(ddata->clk);
-	mutex_unlock(&ddata->lock);
 	return ret;
 }
 
-- 
2.36.1

