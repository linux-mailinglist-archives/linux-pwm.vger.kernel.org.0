Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6A8759E5B
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 21:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjGSTU1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 15:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjGSTU1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 15:20:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC991FE8
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 12:20:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCig-0000Ld-98; Wed, 19 Jul 2023 21:20:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCif-000fhp-Ia; Wed, 19 Jul 2023 21:20:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCie-006B2i-SZ; Wed, 19 Jul 2023 21:20:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 2/5] pwm: atmel-tcb: Fix resource freeing in error path and remove
Date:   Wed, 19 Jul 2023 21:20:10 +0200
Message-Id: <20230719192013.4051193-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
References: <20230719192013.4051193-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=68P5lTizHcnr3m1NXsflTQG+JDPaKJsegvL2wfUzU98=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkuDdnQxP7niozGA7H4RUf2e1PXbk1eLR4sHqD3 iUIfiW9lYaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLg3ZwAKCRCPgPtYfRL+ TtKTCAChytflverWQQ21dV8fnTI0hAvHPSC5TPnkcpH4tUuIGElUPsLGsOZjlddh5LH5c7n8IcX Dfyd1rdQIHNTgKM0Cj/OWSQ2XkaY2rVFaJErmxvIjhMYcWo2FevVGYSrOXj9OCyGl5YTNNf5RlV r/oeKBxD5dFZTMa+2Zex9ZItUGzhpNahlfbcI5hciAWUtxrvjIVhyWJskgDabBpBbkjVgon1FDi hZiDH+0ZI7sxtAztxD/M50i9PtqK21DooBPKQlDhpz/hI8064u7d1xSPzwQDyZxZRvAfb/cmW1r xodpaZhNE+rl2k7Btkiy4Xwl5hV/6v5OgNzE3McnUobUDYFB
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

Several resources were not freed in the error path and the remove
function. Add the forgotten items.

Fixes: 34cbcd72588f ("pwm: atmel-tcb: Add sama5d2 support")
Fixes: 061f8572a31c ("pwm: atmel-tcb: Switch to new binding")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 613dd1810fb5..2826fc216d29 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -450,16 +450,20 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	tcbpwm->clk = of_clk_get_by_name(np->parent, clk_name);
 	if (IS_ERR(tcbpwm->clk))
 		tcbpwm->clk = of_clk_get_by_name(np->parent, "t0_clk");
-	if (IS_ERR(tcbpwm->clk))
-		return PTR_ERR(tcbpwm->clk);
+	if (IS_ERR(tcbpwm->clk)) {
+		err = PTR_ERR(tcbpwm->clk);
+		goto err_slow_clk;
+	}
 
 	match = of_match_node(atmel_tcb_of_match, np->parent);
 	config = match->data;
 
 	if (config->has_gclk) {
 		tcbpwm->gclk = of_clk_get_by_name(np->parent, "gclk");
-		if (IS_ERR(tcbpwm->gclk))
-			return PTR_ERR(tcbpwm->gclk);
+		if (IS_ERR(tcbpwm->gclk)) {
+			err = PTR_ERR(tcbpwm->gclk);
+			goto err_clk;
+		}
 	}
 
 	tcbpwm->chip.dev = &pdev->dev;
@@ -470,7 +474,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 	err = clk_prepare_enable(tcbpwm->slow_clk);
 	if (err)
-		goto err_slow_clk;
+		goto err_gclk;
 
 	spin_lock_init(&tcbpwm->lock);
 
@@ -485,6 +489,12 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 err_disable_clk:
 	clk_disable_unprepare(tcbpwm->slow_clk);
 
+err_gclk:
+	clk_put(tcbpwm->gclk);
+
+err_clk:
+	clk_put(tcbpwm->clk);
+
 err_slow_clk:
 	clk_put(tcbpwm->slow_clk);
 
@@ -498,8 +508,9 @@ static void atmel_tcb_pwm_remove(struct platform_device *pdev)
 	pwmchip_remove(&tcbpwm->chip);
 
 	clk_disable_unprepare(tcbpwm->slow_clk);
-	clk_put(tcbpwm->slow_clk);
+	clk_put(tcbpwm->gclk);
 	clk_put(tcbpwm->clk);
+	clk_put(tcbpwm->slow_clk);
 }
 
 static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
-- 
2.39.2

