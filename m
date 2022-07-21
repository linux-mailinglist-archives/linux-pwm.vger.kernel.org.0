Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC3D57C900
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiGUKbm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Jul 2022 06:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGUKbl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 06:31:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0427479A
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 03:31:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETT0-0002W2-4g; Thu, 21 Jul 2022 12:31:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSz-002IMw-C6; Thu, 21 Jul 2022 12:31:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSy-006ZIV-3T; Thu, 21 Jul 2022 12:31:36 +0200
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
Subject: [PATCH 6/7] pwm: sifive: Ensure the clk is enabled exactly one per running PWM
Date:   Thu, 21 Jul 2022 12:31:28 +0200
Message-Id: <20220721103129.304697-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3052; h=from:subject; bh=3zYgBnySD37iMkEgERXBOZoG3gCLgbZr9s4K5gsrSaA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi2Sr7s1Xee6KOfmM8IAOEhYJt8QASWiil0jdPQCuL 7xvik02JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtkq+wAKCRDB/BR4rcrsCWApB/ 9NmQ9Q2qgZCanYCyvqEAK0xeFbuNNq+pNUjV8I2bonDCLHyDawvdSynIyKzsXmnJsroYGrZuYcARPs ucb5MqG89QIvc94pYH/Nl2EAOz46lzslSUeKuml/WX8qndJbdqwnOYSHvX/8wo8aSdqgrOCH+/IHQ2 NT/n8pFBMDGO482OwHemUB7URNV1IJezr3U/ga5yxdZn9ZIfV2vhzt/jKn7J/WBeI10WQ2snXRz0eI uWDsQg04L2Nb/8Phl5S+mtQ5tTX+uUOziII2Dop+FtcJ5/fww+nEZeBSj2R39btihQA5zuPaWtQpky t198LoUZn2O2oeQ0LtHN95Gu9wfjRK
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

.apply() assumes the clk to be for a given PWM iff the PWM is enabled.
So make sure this is the case when .probe() completes. And in .remove()
disable the according number of times.

This fixes a clk enable/disable imbalance, if some PWMs are already running
at probe time.

Fixes: 9e37a53eb051 (pwm: sifive: Add a driver for SiFive SoC PWM)
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 46 ++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 34d23d56fa25..da40ade0ebdf 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -216,6 +216,8 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	struct pwm_sifive_ddata *ddata;
 	struct pwm_chip *chip;
 	int ret;
+	u32 val;
+	unsigned int enabled_pwms = 0, enabled_clks = 1;
 
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
@@ -242,6 +244,33 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	val = readl(ddata->regs + PWM_SIFIVE_PWMCFG);
+	if (val & PWM_SIFIVE_PWMCFG_EN_ALWAYS) {
+		unsigned int i;
+
+		for (i = 0; i < chip->npwm; ++i) {
+			val = readl(ddata->regs + PWM_SIFIVE_PWMCMP(i));
+			if (val > 0)
+				++enabled_pwms;
+		}
+	}
+
+	/* The clk should be on once for each running PWM. */
+	if (enabled_pwms) {
+		while (enabled_clks < enabled_pwms) {
+			/* This is not expected to fail as the clk is already on */
+			ret = clk_enable(ddata->clk);
+			if (unlikely(ret)) {
+				dev_err_probe(dev, ret, "Failed to enable clk\n");
+				goto disable_clk;
+			}
+			++enabled_clks;
+		}
+	} else {
+		clk_disable(ddata->clk);
+		enabled_clks = 0;
+	}
+
 	/* Watch for changes to underlying clock frequency */
 	ddata->notifier.notifier_call = pwm_sifive_clock_notifier;
 	ret = clk_notifier_register(ddata->clk, &ddata->notifier);
@@ -264,7 +293,11 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 unregister_clk:
 	clk_notifier_unregister(ddata->clk, &ddata->notifier);
 disable_clk:
-	clk_disable_unprepare(ddata->clk);
+	while (enabled_clks) {
+		clk_disable(ddata->clk);
+		--enabled_clks;
+	}
+	clk_unprepare(ddata->clk);
 
 	return ret;
 }
@@ -272,21 +305,16 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 static int pwm_sifive_remove(struct platform_device *dev)
 {
 	struct pwm_sifive_ddata *ddata = platform_get_drvdata(dev);
-	bool is_enabled = false;
 	struct pwm_device *pwm;
 	int ch;
 
 	for (ch = 0; ch < ddata->chip.npwm; ch++) {
 		pwm = &ddata->chip.pwms[ch];
-		if (pwm->state.enabled) {
-			is_enabled = true;
-			break;
-		}
+		if (pwm->state.enabled)
+			clk_disable(ddata->clk);
 	}
-	if (is_enabled)
-		clk_disable(ddata->clk);
 
-	clk_disable_unprepare(ddata->clk);
+	clk_unprepare(ddata->clk);
 	pwmchip_remove(&ddata->chip);
 	clk_notifier_unregister(ddata->clk, &ddata->notifier);
 
-- 
2.36.1

