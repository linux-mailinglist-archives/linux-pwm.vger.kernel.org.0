Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2155424153C
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Aug 2020 05:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHKD2p (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Aug 2020 23:28:45 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43630 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727868AbgHKD2o (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 10 Aug 2020 23:28:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 29E151A1D89;
        Tue, 11 Aug 2020 05:28:43 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C49C1A082B;
        Tue, 11 Aug 2020 05:28:38 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D1322402A5;
        Tue, 11 Aug 2020 05:28:32 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/3] pwm: imx27: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 11:23:43 +0800
Message-Id: <1597116224-26221-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597116224-26221-1-git-send-email-Anson.Huang@nxp.com>
References: <1597116224-26221-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index c50d453..fabd30d1 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -315,27 +315,16 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, imx);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(imx->clk_ipg)) {
-		int ret = PTR_ERR(imx->clk_ipg);
-
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"getting ipg clock failed with %d\n",
-				ret);
-		return ret;
-	}
+	if (IS_ERR(imx->clk_ipg))
+		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_ipg),
+				     "getting ipg clock failed with %ld\n",
+				     PTR_ERR(imx->clk_ipg));
 
 	imx->clk_per = devm_clk_get(&pdev->dev, "per");
-	if (IS_ERR(imx->clk_per)) {
-		int ret = PTR_ERR(imx->clk_per);
-
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to get peripheral clock: %d\n",
-				ret);
-
-		return ret;
-	}
+	if (IS_ERR(imx->clk_per))
+		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
+				     "failed to get peripheral clock: %ld\n",
+				     PTR_ERR(imx->clk_per));
 
 	imx->chip.ops = &pwm_imx27_ops;
 	imx->chip.dev = &pdev->dev;
-- 
2.7.4

