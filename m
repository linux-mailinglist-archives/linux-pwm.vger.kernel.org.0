Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A56486CA83
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jul 2019 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfGRIB1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Jul 2019 04:01:27 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2578 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGRIB1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Jul 2019 04:01:27 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jul 2019 04:01:18 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35d3024f6001-9a38b; Thu, 18 Jul 2019 15:51:19 +0800 (CST)
X-RM-TRANSID: 2ee35d3024f6001-9a38b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15d3024f6bc7-f01c1;
        Thu, 18 Jul 2019 15:51:19 +0800 (CST)
X-RM-TRANSID: 2ee15d3024f6bc7-f01c1
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     thierry.reding@gmail.com
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: sifive: remove redundant dev_err message
Date:   Thu, 18 Jul 2019 15:51:11 +0800
Message-Id: <1563436271-31356-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

devm_ioremap_resource already contains error message, so remove
the redundant dev_err message

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/pwm/pwm-sifive.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index a7c107f..bb4f02c 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -250,10 +250,8 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ddata->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(ddata->regs)) {
-		dev_err(dev, "Unable to map IO resources\n");
+	if (IS_ERR(ddata->regs))
 		return PTR_ERR(ddata->regs);
-	}
 
 	ddata->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ddata->clk)) {
-- 
1.9.1



