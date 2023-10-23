Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958987D3E36
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 19:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjJWRqz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 13:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJWRqv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 13:46:51 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C907DFF
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 10:46:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0p-0001MG-II; Mon, 23 Oct 2023 19:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0o-003lPe-Bi; Mon, 23 Oct 2023 19:46:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0o-004VD4-2N; Mon, 23 Oct 2023 19:46:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 04/11] pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Mon, 23 Oct 2023 19:46:21 +0200
Message-ID: <20231023174616.2282067-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lafix394cAMj8XnsilJcRkI4ZkU8Zn986OVrdQwWFIk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlNrFtDXjCquvoLQm/d/X5mXE+zN96MnfaLnv9E uVA1UpG2MOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTaxbQAKCRCPgPtYfRL+ TpEmCACM0S3LmhSaZ2/FrumpJwd8xC1HGRkLwZHTs6B69eR7kWBP+lPmW2riyvH2t7mVGk1JLrC mMSQJBua356/STwdQ1vEkf9TkdAIEJGJW9O0JcaZk8n+cGpdjaUun8W4FVA8ftMTqkK0Sd5yLLU /b4zuG+67JTFCPbjSWtX0NycFAoVAdWJVx3uoBYqmbrfkNHf9J5MqINzKdHy5iylhl3LAsyugSr 0oF+MWKae0ajVePF+U9MqKfIq7q7CfSdLUTeNKhsaJAZC6u3MuyButJXJO2BljqLFHEzzLmqwD4 qPhQfiRJwogajZ7lrHW3Ca1gaVNGkRXYtCoGBb1QNUGdj1RQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used, so the corresponding
#ifdef can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-brcmstb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index b723c2d4f485..0fdeb0b2dbf3 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -259,7 +259,6 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int brcmstb_pwm_suspend(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
@@ -275,17 +274,16 @@ static int brcmstb_pwm_resume(struct device *dev)
 
 	return clk_prepare_enable(p->clk);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops, brcmstb_pwm_suspend,
-			 brcmstb_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops, brcmstb_pwm_suspend,
+				brcmstb_pwm_resume);
 
 static struct platform_driver brcmstb_pwm_driver = {
 	.probe = brcmstb_pwm_probe,
 	.driver = {
 		.name = "pwm-brcmstb",
 		.of_match_table = brcmstb_pwm_of_match,
-		.pm = &brcmstb_pwm_pm_ops,
+		.pm = pm_ptr(&brcmstb_pwm_pm_ops),
 	},
 };
 module_platform_driver(brcmstb_pwm_driver);
-- 
2.42.0

