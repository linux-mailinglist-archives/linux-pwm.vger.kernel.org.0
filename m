Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B53BC518
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 11:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfIXJo1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 05:44:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58946 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbfIXJo1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 24 Sep 2019 05:44:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8BFCA2001B0;
        Tue, 24 Sep 2019 11:44:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B85720038C;
        Tue, 24 Sep 2019 11:44:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DCE10402EE;
        Tue, 24 Sep 2019 17:44:15 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     thierry.reding@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] pwm: pwm-mxs: use devm_platform_ioremap_resource() to simplify code
Date:   Tue, 24 Sep 2019 17:42:48 +0800
Message-Id: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use the new helper devm_platform_ioremap_resource() which wraps the
platform_get_resource() and devm_ioremap_resource() together, to
simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
	- This is a resend version of patch: https://patchwork.kernel.org/patch/11048365/
---
 drivers/pwm/pwm-mxs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 04c0f6b..b14376b 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -126,15 +126,13 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct mxs_pwm_chip *mxs;
-	struct resource *res;
 	int ret;
 
 	mxs = devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
 	if (!mxs)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mxs->base = devm_ioremap_resource(&pdev->dev, res);
+	mxs->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mxs->base))
 		return PTR_ERR(mxs->base);
 
-- 
2.7.4

