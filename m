Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5397E6E6D66
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Apr 2023 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjDRUVK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Apr 2023 16:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjDRUVK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Apr 2023 16:21:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C12A5F7
        for <linux-pwm@vger.kernel.org>; Tue, 18 Apr 2023 13:21:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1porp3-00015Z-5c; Tue, 18 Apr 2023 22:21:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1porp1-00CBOu-S9; Tue, 18 Apr 2023 22:21:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1porp1-00EKQX-7N; Tue, 18 Apr 2023 22:21:03 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: sifive: Simplify using devm_clk_get_prepared()
Date:   Tue, 18 Apr 2023 22:21:02 +0200
Message-Id: <20230418202102.117658-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NYxZWUDL6nqiY43zsSH7XZr/b16Ctti/9W/FJz0Ev7A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkPvutB00RQEQfGSGcQrUwuEACxMe9MCrSPmiH0 NPEB58pXAWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZD77rQAKCRCPgPtYfRL+ Tvb8CACjjgcTK4kMt/9A7UXWDyzc0XLdesSwzd5wx1e2NnXtckUcrIezj7JlWsHxA6/Rl9qyuM2 vJU4CDn2dB4USGlC1t9RmYgd2tOxhd4hU8bBtOeTZ6Nj/vFK5NsDXnTF6rwDgBhpSMVbl17IxN2 l9l5d+QGXtDLlmb9kvRvDDQK0zC1p0QxlHx4bTVhc6glYXYDC3M5EyvUdeaFUgktG7uvSt4ra+k bejXUd7AXfM/WobXW90sehZAzjapj+bzFU/g9GE0lE/F1Rx6JzUYWhf4iQQonuXzTG5MY3W+DEO KsQBzbulbaZhlXiJDHI0ZFzZNWQp0BGPplUppGszqWe0nmax
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

Instead of preparing the clk after it was requested and unpreparing in
.probe()'s error path and .remove(), use devm_clk_get_prepared() which
copes for unpreparing automatically.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 5b0574f635f6..ae49d67ab2b1 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -244,12 +244,12 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	if (IS_ERR(ddata->regs))
 		return PTR_ERR(ddata->regs);
 
-	ddata->clk = devm_clk_get(dev, NULL);
+	ddata->clk = devm_clk_get_prepared(dev, NULL);
 	if (IS_ERR(ddata->clk))
 		return dev_err_probe(dev, PTR_ERR(ddata->clk),
 				     "Unable to find controller clock\n");
 
-	ret = clk_prepare_enable(ddata->clk);
+	ret = clk_enable(ddata->clk);
 	if (ret) {
 		dev_err(dev, "failed to enable clock for pwm: %d\n", ret);
 		return ret;
@@ -308,7 +308,6 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 		clk_disable(ddata->clk);
 		--enabled_clks;
 	}
-	clk_unprepare(ddata->clk);
 
 	return ret;
 }
@@ -327,8 +326,6 @@ static void pwm_sifive_remove(struct platform_device *dev)
 		if (pwm->state.enabled)
 			clk_disable(ddata->clk);
 	}
-
-	clk_unprepare(ddata->clk);
 }
 
 static const struct of_device_id pwm_sifive_of_match[] = {

base-commit: 247ee6c780406513c6031a7f4ea41f1648b03295
-- 
2.39.2

