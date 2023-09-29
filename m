Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA217B37B9
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjI2QTb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjI2QT3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939C31A5
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-0007o4-GR; Fri, 29 Sep 2023 18:19:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-009r5c-3Q; Fri, 29 Sep 2023 18:19:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD4-006165-QO; Fri, 29 Sep 2023 18:19:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 05/11] pwm: mtk-disp: Simplify using devm_pwmchip_add()
Date:   Fri, 29 Sep 2023 18:19:12 +0200
Message-Id: <20230929161918.2410424-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=J2X1TCgGm2aiqZ1DsX5bUui3ufiRtvhRg3HnY+fgzOs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFvj54D2J0JZGcHBTpeSmu5Mae16b94F5WOmVo 8PHPZe9K+OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRb4+QAKCRCPgPtYfRL+ TrIqB/9hQa72vyvBBSQ/n+Cx0Zvc7D1UUcOtRDbErHARp2Cx9dBlB/s9aVRGHAwIOatI+D+x/ux di1XfnnjLvpj81RMSVOZRRU/edU8HCobPdH56lBHyCEV+AR9DcKQlkquo67RN8iB8h7Jq3bzO8l Jk6DzEUsH6u+afQpGm/8i6Aox9UcxdDkF7jq2Uqu3jO5r/s3RH386wbDK25CNh2SKp+hBvPolqI 72ZK0jp1MQCfgIvqwx7TeV1UQ+KXmx0MglzyATwPmO+SUrfgwm6yihukDdWVQtG2swSQobKsQzk oNfWwZ2SRi4l0vTDdCPHGbsXCgpGvB6tuwaleRJYvqA12E1R
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With devm_pwmchip_add() pwmchip_remove() can be dropped from the remove
callback. Then the remove callback is empty and can go away, too. With
mtk_disp_pwm_remove() the last user of platform_get_drvdata() is gone and
so platform_set_drvdata() can be dropped, too.

Also use dev_err_probe() for simplified (and improved) error reporting.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mtk-disp.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index a83bd6e18b07..e34fb4409695 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -247,34 +247,25 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 
 	mdp->clk_main = devm_clk_get(&pdev->dev, "main");
 	if (IS_ERR(mdp->clk_main))
-		return PTR_ERR(mdp->clk_main);
+		return dev_err_probe(&pdev->dev, PTR_ERR(mdp->clk_main),
+				     "Failed to get main clock\n");
 
 	mdp->clk_mm = devm_clk_get(&pdev->dev, "mm");
 	if (IS_ERR(mdp->clk_mm))
-		return PTR_ERR(mdp->clk_mm);
+		return dev_err_probe(&pdev->dev, PTR_ERR(mdp->clk_mm),
+				     "Failed to get mm clock\n");
 
 	mdp->chip.dev = &pdev->dev;
 	mdp->chip.ops = &mtk_disp_pwm_ops;
 	mdp->chip.npwm = 1;
 
-	ret = pwmchip_add(&mdp->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %pe\n", ERR_PTR(ret));
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, mdp);
+	ret = devm_pwmchip_add(&pdev->dev, &mdp->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
 	return 0;
 }
 
-static void mtk_disp_pwm_remove(struct platform_device *pdev)
-{
-	struct mtk_disp_pwm *mdp = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&mdp->chip);
-}
-
 static const struct mtk_pwm_data mt2701_pwm_data = {
 	.enable_mask = BIT(16),
 	.con0 = 0xa8,
@@ -320,7 +311,6 @@ static struct platform_driver mtk_disp_pwm_driver = {
 		.of_match_table = mtk_disp_pwm_of_match,
 	},
 	.probe = mtk_disp_pwm_probe,
-	.remove_new = mtk_disp_pwm_remove,
 };
 module_platform_driver(mtk_disp_pwm_driver);
 
-- 
2.40.1

