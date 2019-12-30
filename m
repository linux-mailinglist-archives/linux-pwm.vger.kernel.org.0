Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1791A12CC0A
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Dec 2019 04:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfL3DGJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 29 Dec 2019 22:06:09 -0500
Received: from inva021.nxp.com ([92.121.34.21]:48334 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfL3DGJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 29 Dec 2019 22:06:09 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6BC782011C5;
        Mon, 30 Dec 2019 04:06:07 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A9212011C9;
        Mon, 30 Dec 2019 04:06:02 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 34F094029B;
        Mon, 30 Dec 2019 11:05:56 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] pwm: imx27: Eliminate error message for defer probe
Date:   Mon, 30 Dec 2019 11:02:40 +0800
Message-Id: <1577674960-12011-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

For defer probe error, no need to output error message which
will cause confusion.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 59d8b12..35a7ac42 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -319,9 +319,13 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg)) {
-		dev_err(&pdev->dev, "getting ipg clock failed with %ld\n",
-				PTR_ERR(imx->clk_ipg));
-		return PTR_ERR(imx->clk_ipg);
+		int ret = PTR_ERR(imx->clk_ipg);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"getting ipg clock failed with %d\n",
+				ret);
+		return ret;
 	}
 
 	imx->clk_per = devm_clk_get(&pdev->dev, "per");
-- 
2.7.4

