Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9840657C8FE
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 12:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiGUKbl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Jul 2022 06:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiGUKbl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 06:31:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D09249B68
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 03:31:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSz-0002Vy-QN; Thu, 21 Jul 2022 12:31:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSy-002IMk-IB; Thu, 21 Jul 2022 12:31:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSx-006ZIS-UD; Thu, 21 Jul 2022 12:31:35 +0200
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
Subject: [PATCH 5/7] pwm: sifive: Simplify clk handling
Date:   Thu, 21 Jul 2022 12:31:27 +0200
Message-Id: <20220721103129.304697-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; h=from:subject; bh=0fFwEZkhwtAHdV9/NUnEXXx4U/lJdZQ7HP84P2BZd3U=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi2Sr4PlqUFDXOkb1eWHlVrO1iKgp5d1w/4C1/TlH0 MQzpDGWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtkq+AAKCRDB/BR4rcrsCdnlB/ 9ZVYl1QMEBzPLGFquFuYMSf8xCwaQK/lcVrfciCCMgu4uOZ6A3srCMqVyMBQwJo9ZPa+jf+UFw4/GE n2aV5tusUN6QVOVZ5a3qgmCzehMnZv5hNWyjMPM+DPB38nHdMVebwHIrgFZB1QGC7zEx4VGNQ/NGN6 5rVN58ustUhIbTBPSlYKxA5pYdfBVSOYsw+M/pzQa1ALWRYW8dxmzxmLcnS0tvlltknksaVmSeKurf u/d4W3x8A6aoA7JTUpuCJsL83OnrXkVhmVqtH8Uc3OLUu4LwA4TrxgGvTmWx8J3TdC4KalbjkwANpZ KfbRdkbB2YdwEezoyAWsxjXwKhCdie
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

The clk is necessary for both register access and (enabled) operation of
the PWM. Instead of

	clk_enable()
	update_hw()
	if pwm_got_enabled():
		clk_enable()
	elif pwm_got_disabled():
		clk_disable()
	clk_disable()

which is some cases only calls clk_enable() to immediately afterwards
call clk_disable again, do:

	if (!prev_state.enabled)
		clk_enable()

	# clk enabled exactly once

	update_hw()

	if (!next_state.enabled)
		clk_disable()

which is much easier.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index d833536b5e7a..34d23d56fa25 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -168,24 +168,24 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 	mutex_unlock(&ddata->lock);
 
-	ret = clk_enable(ddata->clk);
-	if (ret) {
-		dev_err(ddata->chip.dev, "Enable clk failed\n");
-		return ret;
+	/*
+	 * If the PWM is enabled the clk is already on. So only enable it
+	 * conditionally to have it on exactly once afterwards independent of
+	 * the PWM state.
+	 */
+	if (!enabled) {
+		ret = clk_enable(ddata->clk);
+		if (ret) {
+			dev_err(ddata->chip.dev, "Enable clk failed\n");
+			return ret;
+		}
 	}
 
 	writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
 
-	if (state->enabled != enabled) {
-		if (state->enabled) {
-			if (clk_enable(ddata->clk))
-				dev_err(ddata->chip.dev, "Enable clk failed\n");
-		} else {
-			clk_disable(ddata->clk);
-		}
-	}
+	if (!state->enabled)
+		clk_disable(ddata->clk);
 
-	clk_disable(ddata->clk);
 	return 0;
 }
 
-- 
2.36.1

