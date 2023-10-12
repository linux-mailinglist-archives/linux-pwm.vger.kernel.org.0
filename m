Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF767C72F9
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379615AbjJLQbo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343912AbjJLQbQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FF9E6
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyad-0005lm-3u; Thu, 12 Oct 2023 18:31:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaa-001CAi-V0; Thu, 12 Oct 2023 18:31:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaa-00F5Rx-Lx; Thu, 12 Oct 2023 18:31:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 087/109] pwm: sprd: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:55 +0200
Message-ID: <20231012162827.1002444-198-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3399; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PZhLAxkeOyb+AWx4AV+gS2Lz+9GH68bc6B306U2AspE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8TNkF+04ydJIoChGv97giXcctKOo7ARsYAi 73nhkuVpPeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfEwAKCRCPgPtYfRL+ TmXfB/0TzFxTAvUDgR67rTcaJ5upgdVJTs4DsayBefEyeKb5As8etoqB7X5WbEsH38QkXwk+RAo iUh494s2cl0I/8k4hk37RtLR//4APVNuxJQ9SxG5CUaefqIXmJZmjt3egSQrLmtsQ2klx+hUFrx C2LPOsdw2NJ5OwMe70Z9laHQyBdK2ngJEFMEkYujOUzx5fkS0NzB56l0o93W86Z63IxDXhu+liD HarlX9HdRxIEFo0+awjAbUodRx4E0jbX4oPxjA1MR7GEHe7UfLvU2oF/u79cQNfog0tFPH+a5wL ZsA9QczZNhq3BmQx1/Kee8ZhC9u8j5CibNlVCSJwp4HsbO7X
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-sprd driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sprd.c | 50 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index 77939e161006..b7ecd875b605 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -35,14 +35,13 @@ struct sprd_pwm_chn {
 struct sprd_pwm_chip {
 	void __iomem *base;
 	struct device *dev;
-	struct pwm_chip chip;
 	int num_pwms;
 	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
 };
 
 static inline struct sprd_pwm_chip* sprd_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sprd_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -215,65 +214,66 @@ static const struct pwm_ops sprd_pwm_ops = {
 	.get_state = sprd_pwm_get_state,
 };
 
-static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
+static int sprd_pwm_clk_init(struct device *dev,
+			     struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM])
 {
 	struct clk *clk_pwm;
 	int ret, i;
 
 	for (i = 0; i < SPRD_PWM_CHN_NUM; i++) {
-		struct sprd_pwm_chn *chn = &spc->chn[i];
 		int j;
 
 		for (j = 0; j < SPRD_PWM_CHN_CLKS_NUM; ++j)
-			chn->clks[j].id =
+			chn[i].clks[j].id =
 				sprd_pwm_clks[i * SPRD_PWM_CHN_CLKS_NUM + j];
 
-		ret = devm_clk_bulk_get(spc->dev, SPRD_PWM_CHN_CLKS_NUM,
-					chn->clks);
+		ret = devm_clk_bulk_get(dev, SPRD_PWM_CHN_CLKS_NUM,
+					chn[i].clks);
 		if (ret) {
 			if (ret == -ENOENT)
 				break;
 
-			return dev_err_probe(spc->dev, ret,
+			return dev_err_probe(dev, ret,
 					     "failed to get channel clocks\n");
 		}
 
-		clk_pwm = chn->clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
-		chn->clk_rate = clk_get_rate(clk_pwm);
+		clk_pwm = chn[i].clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
+		chn[i].clk_rate = clk_get_rate(clk_pwm);
 	}
 
 	if (!i)
-		return dev_err_probe(spc->dev, -ENODEV, "no available PWM channels\n");
+		return dev_err_probe(dev, -ENODEV, "no available PWM channels\n");
 
-	spc->num_pwms = i;
-
-	return 0;
+	return i;
 }
 
 static int sprd_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct sprd_pwm_chip *spc;
+	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
 	int ret;
 
-	spc = devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
-	if (!spc)
-		return -ENOMEM;
+	ret = sprd_pwm_clk_init(&pdev->dev, chn);
+	if (ret < 0)
+		return ret;
+
+	chip = devm_pwmchip_alloc(&pdev->dev, ret, sizeof(*spc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	spc = sprd_pwm_from_chip(chip);
 
 	spc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spc->base))
 		return PTR_ERR(spc->base);
 
 	spc->dev = &pdev->dev;
+	memcpy(spc->chn, chn, sizeof(chn));
 
-	ret = sprd_pwm_clk_init(spc);
-	if (ret)
-		return ret;
+	chip->ops = &sprd_pwm_ops;
+	chip->npwm = spc->num_pwms;
 
-	spc->chip.dev = &pdev->dev;
-	spc->chip.ops = &sprd_pwm_ops;
-	spc->chip.npwm = spc->num_pwms;
-
-	ret = devm_pwmchip_add(&pdev->dev, &spc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		dev_err(&pdev->dev, "failed to add PWM chip\n");
 
-- 
2.42.0

