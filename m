Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7974924164C
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Aug 2020 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgHKG3b (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Aug 2020 02:29:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38916 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgHKG3b (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 11 Aug 2020 02:29:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BC4EF1A1E18;
        Tue, 11 Aug 2020 08:29:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D9661A1E05;
        Tue, 11 Aug 2020 08:29:25 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 85E04402DF;
        Tue, 11 Aug 2020 08:29:19 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/3] pwm: imx-tpm: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 14:24:30 +0800
Message-Id: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	- remove redundant return value print.
---
 drivers/pwm/pwm-imx-tpm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index fcdf6be..aaf629b 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -350,13 +350,9 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 		return PTR_ERR(tpm->base);
 
 	tpm->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(tpm->clk)) {
-		ret = PTR_ERR(tpm->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to get PWM clock: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(tpm->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tpm->clk),
+				     "failed to get PWM clock\n");
 
 	ret = clk_prepare_enable(tpm->clk);
 	if (ret) {
-- 
2.7.4

