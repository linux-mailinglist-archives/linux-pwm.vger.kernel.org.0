Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B2851E597
	for <lists+linux-pwm@lfdr.de>; Sat,  7 May 2022 10:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383686AbiEGIdB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 7 May 2022 04:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346054AbiEGIdA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 7 May 2022 04:33:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F62CC86
        for <linux-pwm@vger.kernel.org>; Sat,  7 May 2022 01:29:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nnFoO-0002EA-Ma; Sat, 07 May 2022 10:29:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nnFoO-000rlq-Jy; Sat, 07 May 2022 10:29:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nnFoM-00883N-A1; Sat, 07 May 2022 10:29:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: lpc32xx: Implement .apply() callback
Date:   Sat,  7 May 2022 10:29:01 +0200
Message-Id: <20220507082901.162933-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; h=from:subject; bh=NDAjARmoaTPE3Jv09PVoWfPR6qZ+DeIyn+HnWT7+3aM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBidi3JD5bQDLifqbxmec6ccBoJcbMVgp8GiYhb/0L6 4+cEJLGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYnYtyQAKCRDB/BR4rcrsCSa3CA CTbOFFayXIt2dCwESYS4E2IvZ3FAgqfR6LD0rahF6/JtYAHDUzCYw2EWk4H7WueSBd63H4BcG8v3qu JdBweHXHgL+6fWBWPid+372YRgDziJLiTSaXHrtEvJ0y7zfu9LI9NZtqz9R1Y+QW6SkYqGT0zrE9vH zzG42rJTLug0fJJfatJM3WQI2TXhXWGRfwmfV1CdWpdkF7I+lPa3P3K2yuF7uepfnWL6Wxn7/1ewHV +PXHA58UopZUKYaKQEKo6CI0NTHkl4jIE9M3OTWrAzlYRblgYzCoxYJPiVN4Z7ZH2CEYf3Y7rco55C wyRPNEFgWY/rdRIrJnhUYi0wDoQqdc
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

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().
This just pushed a variant of pwm_apply_legacy() into the driver that was
slightly simplified because the driver doesn't provide a .set_polarity()
callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc32xx.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index ddeab5687cb8..86a0ea0f6955 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -88,10 +88,33 @@ static void lpc32xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(lpc32xx->clk);
 }
 
+static int lpc32xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			lpc32xx_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = lpc32xx_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = lpc32xx_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops lpc32xx_pwm_ops = {
-	.config = lpc32xx_pwm_config,
-	.enable = lpc32xx_pwm_enable,
-	.disable = lpc32xx_pwm_disable,
+	.apply = lpc32xx_pwm_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: 2bf8ee0faa988b5cec3503ebf2f970a0e84d24ee
-- 
2.35.1

