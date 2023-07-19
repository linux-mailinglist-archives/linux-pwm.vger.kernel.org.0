Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61802759E5A
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 21:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGSTU1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 15:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSTU0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 15:20:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5CB1FC8
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 12:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCig-0000M2-Q4; Wed, 19 Jul 2023 21:20:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCig-000fhx-6d; Wed, 19 Jul 2023 21:20:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCie-006B2f-Id; Wed, 19 Jul 2023 21:20:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 1/5] pwm: atmel-tcb: Harmonize resource allocation order
Date:   Wed, 19 Jul 2023 21:20:09 +0200
Message-Id: <20230719192013.4051193-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2kq+R+5Zn44CCOqOoCGazyrrt9TPf/LePHtMVSTCn5s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkuDdlHE1LvDQq5IQiEv3g9LlVYoPt0P6DzkAlE ucBc2JysLiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLg3ZQAKCRCPgPtYfRL+ Tm2SB/0ULFnRxRVG8KLLtX4vCtw3byYDNeoGXgXxXhMHHSqkzPKHWDEU7TR6PwiKGmG5d097a/I uTEldH9kMvozzIaYApeSqXoiz/IdQcGBl4J8xP6D0A52PuY7JxYyGYarGpGwf/cLT4eSCdRCOPy L0Cz6FSMCS90X3wJPPfTBVHSAPL6On/FpmP1CtrmRU/60azVvwTEf6BcfUFv+x5oDvCszcotkMA KE1xBnKDRDfvspLP1/Q6S9Ef7prXWg42Q2JdFthFZzztyuj4QD5rKKCBzDy+EsFSlt9iMWNtUI4 Y/lFcHGMSmhSXWA8/bgL8DEDn8LYybcc+KoQauKPmzP2QykB
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Allocate driver data as first resource in the probe function. This way it
can be used during allocation of the other resources (instead of assigning
these to local variables first and update driver data only when it's
allocated). Also as driver data is allocated using a devm function this
should happen first to have the order of freeing resources in the error
path and the remove function in reverse.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 49 +++++++++++++++----------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 4a116dc44f6e..613dd1810fb5 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -422,13 +422,14 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	struct atmel_tcb_pwm_chip *tcbpwm;
 	const struct atmel_tcb_config *config;
 	struct device_node *np = pdev->dev.of_node;
-	struct regmap *regmap;
-	struct clk *clk, *gclk = NULL;
-	struct clk *slow_clk;
 	char clk_name[] = "t0_clk";
 	int err;
 	int channel;
 
+	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
+	if (tcbpwm == NULL)
+		return -ENOMEM;
+
 	err = of_property_read_u32(np, "reg", &channel);
 	if (err < 0) {
 		dev_err(&pdev->dev,
@@ -437,47 +438,37 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	regmap = syscon_node_to_regmap(np->parent);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	tcbpwm->regmap = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(tcbpwm->regmap))
+		return PTR_ERR(tcbpwm->regmap);
 
-	slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
-	if (IS_ERR(slow_clk))
-		return PTR_ERR(slow_clk);
+	tcbpwm->slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
+	if (IS_ERR(tcbpwm->slow_clk))
+		return PTR_ERR(tcbpwm->slow_clk);
 
 	clk_name[1] += channel;
-	clk = of_clk_get_by_name(np->parent, clk_name);
-	if (IS_ERR(clk))
-		clk = of_clk_get_by_name(np->parent, "t0_clk");
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	tcbpwm->clk = of_clk_get_by_name(np->parent, clk_name);
+	if (IS_ERR(tcbpwm->clk))
+		tcbpwm->clk = of_clk_get_by_name(np->parent, "t0_clk");
+	if (IS_ERR(tcbpwm->clk))
+		return PTR_ERR(tcbpwm->clk);
 
 	match = of_match_node(atmel_tcb_of_match, np->parent);
 	config = match->data;
 
 	if (config->has_gclk) {
-		gclk = of_clk_get_by_name(np->parent, "gclk");
-		if (IS_ERR(gclk))
-			return PTR_ERR(gclk);
-	}
-
-	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
-	if (tcbpwm == NULL) {
-		err = -ENOMEM;
-		goto err_slow_clk;
+		tcbpwm->gclk = of_clk_get_by_name(np->parent, "gclk");
+		if (IS_ERR(tcbpwm->gclk))
+			return PTR_ERR(tcbpwm->gclk);
 	}
 
 	tcbpwm->chip.dev = &pdev->dev;
 	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
 	tcbpwm->chip.npwm = NPWM;
 	tcbpwm->channel = channel;
-	tcbpwm->regmap = regmap;
-	tcbpwm->clk = clk;
-	tcbpwm->gclk = gclk;
-	tcbpwm->slow_clk = slow_clk;
 	tcbpwm->width = config->counter_width;
 
-	err = clk_prepare_enable(slow_clk);
+	err = clk_prepare_enable(tcbpwm->slow_clk);
 	if (err)
 		goto err_slow_clk;
 
@@ -495,7 +486,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	clk_disable_unprepare(tcbpwm->slow_clk);
 
 err_slow_clk:
-	clk_put(slow_clk);
+	clk_put(tcbpwm->slow_clk);
 
 	return err;
 }
-- 
2.39.2

