Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44087C7305
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379580AbjJLQbv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379552AbjJLQbU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:20 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BC7CF
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyae-0005ph-9m; Thu, 12 Oct 2023 18:31:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyac-001CB6-69; Thu, 12 Oct 2023 18:31:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyab-00F5SQ-TR; Thu, 12 Oct 2023 18:31:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 093/109] pwm: sunplus: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:30:01 +0200
Message-ID: <20231012162827.1002444-204-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1953; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bs9mFTxGeJpLT/z8UrAL+8cfArkIwcPmeyWmFstIrUY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8aFVRCLx8FGervCfWy5pFe3t0j6iw+9cIl/ SyBWdMKIKyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfGgAKCRCPgPtYfRL+ TjL+B/4oDAPZpbl0nY7rgE+Rc1hfUxz4z+QsYF3iTXb0Zs00/QC8U87sp7Okf/7WUV6vRq7eeD9 Te/Zqb8nkMV8DfOIFu2016U8SnLGJRb8MD5Zp/7uAKQppCO0OqMh6OYNAQie5seNzIpPSVxM2jm IkOLYAyVzE/DsEa1RI1N/rEWCFeZUMC0fLU6U06to0OyhpEPgaqHNPgr+7dlzBRVOhHfKXsDAl0 nxJ4yAVwk57NvOMj/TZvjrVlKOYY8eb+J024vkYsEgnuVH3imLpQQDb2st1/w3zjXPdlql1uhDY mBXK36Lzn16K+WGhOUNGxAy9cbEdv/MW5xrXxmYRgzT7Jmkt
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-sunplus driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sunplus.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
index 773e2f80526e..46181b9149b0 100644
--- a/drivers/pwm/pwm-sunplus.c
+++ b/drivers/pwm/pwm-sunplus.c
@@ -43,14 +43,13 @@
 #define SP7021_PWM_NUM			4
 
 struct sunplus_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sunplus_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -175,12 +174,14 @@ static void sunplus_pwm_clk_release(void *data)
 static int sunplus_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct sunplus_pwm *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, SP7021_PWM_NUM, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_sunplus_pwm(chip);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -203,11 +204,9 @@ static int sunplus_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &sunplus_pwm_ops;
-	priv->chip.npwm = SP7021_PWM_NUM;
+	chip->ops = &sunplus_pwm_ops;
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Cannot register sunplus PWM\n");
 
-- 
2.42.0

