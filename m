Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F8B241537
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Aug 2020 05:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgHKD2n (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Aug 2020 23:28:43 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48460 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgHKD2n (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 10 Aug 2020 23:28:43 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0D9C200725;
        Tue, 11 Aug 2020 05:28:41 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 85E06201D74;
        Tue, 11 Aug 2020 05:28:37 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B047140243;
        Tue, 11 Aug 2020 05:28:31 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] pwm: imx-tpm: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 11:23:42 +0800
Message-Id: <1597116224-26221-1-git-send-email-Anson.Huang@nxp.com>
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
 drivers/pwm/pwm-imx-tpm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index fcdf6be..e46fad3 100644
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
+				     "failed to get PWM clock: %ld\n", PTR_ERR(tpm->clk));
 
 	ret = clk_prepare_enable(tpm->clk);
 	if (ret) {
-- 
2.7.4

