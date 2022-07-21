Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8D457C902
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiGUKbn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Jul 2022 06:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiGUKbm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 06:31:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FFA61D58
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 03:31:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSz-0002Vx-QO; Thu, 21 Jul 2022 12:31:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSy-002IMg-FZ; Thu, 21 Jul 2022 12:31:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSx-006ZIJ-Dh; Thu, 21 Jul 2022 12:31:35 +0200
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
Subject: [PATCH 2/7] pwm: sifive: Fold pwm_sifive_enable() into its only caller
Date:   Thu, 21 Jul 2022 12:31:24 +0200
Message-Id: <20220721103129.304697-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; h=from:subject; bh=sKOWXDCL91kq58t0FdekJeukQkU6Bwjo3++M3hvFQls=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi2Srv+TgOLs1G9g7euiKgebUIZ8RhD3suhSpXS9Vw WaUQQwiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtkq7wAKCRDB/BR4rcrsCaQaB/ 0UHu0XNU/HMCeI8tIqAxgqTzAnvVsOD0HiVNK5OiNnKzTx5up6NUB1+1vZj5Jog1MjDfMpaBUTekek UYsWcQ4T/l21c0qoq1sKJZHDMFf0H/d/mdj8/1u5Oafi5Ky79GyIuUpzfaEDEppmH9SmwEjf72b3/T K1Q9AAW3+bQF3hpHfrgXgwYpuI7x2GQc4tbxSm3/KCbhnGogkdzkUf8dYc33zYfqcU3LBXVZGMsJuz Qu5JbIkJo3W8zmeKkOVROAtuhAwtJBRIlQFe2EWzZqD39MG2wojWy9R/m4GsutzgIIsXz0Qv7B+0LG WU/grNk7VedR5GloHAORBj5FJaibM2
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

There is only a single caller of pwm_sifive_enable() which only enables
or disables the clk. Put this implementation directly into
pwm_sifive_apply() which allows further simplification in the next
change.

There is no change in behaviour.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index b7fc33b08d82..91cf90bd4083 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -124,24 +124,6 @@ static void pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->polarity = PWM_POLARITY_INVERSED;
 }
 
-static int pwm_sifive_enable(struct pwm_chip *chip, bool enable)
-{
-	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
-	int ret;
-
-	if (enable) {
-		ret = clk_enable(ddata->clk);
-		if (ret) {
-			dev_err(ddata->chip.dev, "Enable clk failed\n");
-			return ret;
-		}
-	} else {
-		clk_disable(ddata->clk);
-	}
-
-	return 0;
-}
-
 static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -192,8 +174,14 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
 
-	if (state->enabled != enabled)
-		pwm_sifive_enable(chip, state->enabled);
+	if (state->enabled != enabled) {
+		if (state->enabled) {
+			if (clk_enable(ddata->clk))
+				dev_err(ddata->chip.dev, "Enable clk failed\n");
+		} else {
+			clk_disable(ddata->clk);
+		}
+	}
 
 exit:
 	clk_disable(ddata->clk);
-- 
2.36.1

