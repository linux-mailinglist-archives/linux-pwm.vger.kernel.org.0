Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14AC293461
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Oct 2020 07:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391721AbgJTFqZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Oct 2020 01:46:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49754 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390986AbgJTFqV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 20 Oct 2020 01:46:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A98531A0572;
        Tue, 20 Oct 2020 07:46:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 48A131A073B;
        Tue, 20 Oct 2020 07:46:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 64F2F402F3;
        Tue, 20 Oct 2020 07:46:08 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [RESEND PATCH V2 3/3] pwm: imx1: Use dev_err_probe() to simplify error handling
Date:   Tue, 20 Oct 2020 13:41:07 +0800
Message-Id: <1603172467-19786-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603172467-19786-1-git-send-email-Anson.Huang@nxp.com>
References: <1603172467-19786-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
changes since V1:
	- remove redundant return value print.
---
 drivers/pwm/pwm-imx1.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index f8b2c2e..4877734 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -145,23 +145,14 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, imx);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(imx->clk_ipg)) {
-		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
-				PTR_ERR(imx->clk_ipg));
-		return PTR_ERR(imx->clk_ipg);
-	}
+	if (IS_ERR(imx->clk_ipg))
+		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_ipg),
+				     "getting ipg clock failed\n");
 
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
+				     "failed to get peripheral clock\n");
 
 	imx->chip.ops = &pwm_imx1_ops;
 	imx->chip.dev = &pdev->dev;
-- 
2.7.4

