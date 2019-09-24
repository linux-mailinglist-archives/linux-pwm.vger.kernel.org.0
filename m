Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE4BC460
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfIXJCA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 05:02:00 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49584 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfIXJB7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 24 Sep 2019 05:01:59 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C0AD1200857;
        Tue, 24 Sep 2019 11:01:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8EF1620077E;
        Tue, 24 Sep 2019 11:01:52 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 22B6A4029F;
        Tue, 24 Sep 2019 17:01:47 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it repeatedly
Date:   Tue, 24 Sep 2019 16:59:53 +0800
Message-Id: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add helper variable dev = &pdev->dev to simply the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 434a351..3afee29 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -290,27 +290,28 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct pwm_imx27_chip *imx;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
+	imx = devm_kzalloc(dev, sizeof(*imx), GFP_KERNEL);
 	if (imx == NULL)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, imx);
 
-	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
+	imx->clk_ipg = devm_clk_get(dev, "ipg");
 	if (IS_ERR(imx->clk_ipg)) {
-		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
+		dev_err(dev, "getting ipg clock failed with %ld\n",
 				PTR_ERR(imx->clk_ipg));
 		return PTR_ERR(imx->clk_ipg);
 	}
 
-	imx->clk_per = devm_clk_get(&pdev->dev, "per");
+	imx->clk_per = devm_clk_get(dev, "per");
 	if (IS_ERR(imx->clk_per)) {
 		int ret = PTR_ERR(imx->clk_per);
 
 		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"failed to get peripheral clock: %d\n",
 				ret);
 
@@ -318,7 +319,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	}
 
 	imx->chip.ops = &pwm_imx27_ops;
-	imx->chip.dev = &pdev->dev;
+	imx->chip.dev = dev;
 	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 
-- 
2.7.4

