Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BC54B52AC
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 15:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbiBNOD4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 09:03:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354852AbiBNODz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 09:03:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4AE14095;
        Mon, 14 Feb 2022 06:03:46 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E600A1F417FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644847425;
        bh=QaLaTj9ziNtqxf12oz66KYW1D7p03OX8Bk66flIHsxs=;
        h=From:To:Cc:Subject:Date:From;
        b=IiLx73dq4wyKSkdrAxRCsYed1Zpv5mkzLr5ixnDofJ6LIi5Gp/scc2V/6seFoGTbD
         0JeOtZrdJQnmrVFPgJaEcbng/zlJ3X5WkP4zV+bWCJX8DjiRAwkSuquklkDtMCTIXT
         YiBAgFXOzEJ9nW7jRJF0GW28e4FnFDZLrvwYIBiXXp1C6Syw44mn7xtIi9ncE+jAyU
         q2tpv2InOkV3ykX4R398AWYmVyCUmlULeD2I5nqjKcbD1KFnHO6nUAgFXmq5c8/Lp8
         gIyZxUdgDX+LUqn5cYos3bA0FnuNIFMRNfVpILa+Q4dR7r/RvAV5F6MXGF3mu3oMPb
         eRrgGYgpyqz+A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 1/3] pwm: pwm-mediatek: Simplify error handling with dev_err_probe()
Date:   Mon, 14 Feb 2022 15:03:37 +0100
Message-Id: <20220214140339.112500-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use dev_err_probe() to simplify handling errors in pwm_mediatek_probe().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pwm/pwm-mediatek.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 0d4dd80e9f07..c7d5ca09a684 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -227,18 +227,14 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pc->clk_top = devm_clk_get(&pdev->dev, "top");
-	if (IS_ERR(pc->clk_top)) {
-		dev_err(&pdev->dev, "clock: top fail: %ld\n",
-			PTR_ERR(pc->clk_top));
-		return PTR_ERR(pc->clk_top);
-	}
+	if (IS_ERR(pc->clk_top))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_top),
+				     "clock: top failed\n");
 
 	pc->clk_main = devm_clk_get(&pdev->dev, "main");
-	if (IS_ERR(pc->clk_main)) {
-		dev_err(&pdev->dev, "clock: main fail: %ld\n",
-			PTR_ERR(pc->clk_main));
-		return PTR_ERR(pc->clk_main);
-	}
+	if (IS_ERR(pc->clk_main))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_main),
+				     "clock: main failed\n");
 
 	for (i = 0; i < pc->soc->num_pwms; i++) {
 		char name[8];
@@ -246,11 +242,9 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 		snprintf(name, sizeof(name), "pwm%d", i + 1);
 
 		pc->clk_pwms[i] = devm_clk_get(&pdev->dev, name);
-		if (IS_ERR(pc->clk_pwms[i])) {
-			dev_err(&pdev->dev, "clock: %s fail: %ld\n",
-				name, PTR_ERR(pc->clk_pwms[i]));
-			return PTR_ERR(pc->clk_pwms[i]);
-		}
+		if (IS_ERR(pc->clk_pwms[i]))
+			return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_pwms[i]),
+					     "clock: %s failed\n", name);
 	}
 
 	pc->chip.dev = &pdev->dev;
@@ -258,10 +252,8 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 	pc->chip.npwm = pc->soc->num_pwms;
 
 	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
 	return 0;
 }
-- 
2.33.1

