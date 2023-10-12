Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBD97C72E1
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379542AbjJLQbc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379507AbjJLQbL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C442A9
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaY-0005VD-D8; Thu, 12 Oct 2023 18:31:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaV-001C9B-Nr; Thu, 12 Oct 2023 18:31:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaV-00F5QK-Eq; Thu, 12 Oct 2023 18:31:03 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 063/109] pwm: jz4740: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:31 +0200
Message-ID: <20231012162827.1002444-174-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bRQ+F+aeB8vQEGLPrJ2M2/SlRwuHDUTUKoEQayEnhZU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB72VHXq2IQFQmVQaZqkQIXfVZ3J3PxxEWEQ6 rIqiqwGIeSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge9gAKCRCPgPtYfRL+ TrNuB/4r6GqOOUYilmDg4a7cVQs6fc6ushuPufsTFKc12i/K+GMZLhm4+fLKVg/nNOj0FvZvCy3 G8W+FtwvL7skU+3N5KJpTGg1S8ROxDnvVRcXe8QulKefuBm1xI/fq/fyANOHs5i72xmWXLHUcck JFlnyutbvdHkal3Bc/hFMxTkHvOocfD2aHQ9cALSaVXJHhpvFFFSVbmEL79Zk/NTvy0nP1msugR ufGU6iUL1bYIAIy268XeS8yOGF2x0YYfEqCLJTnyGrJ6zdXHqtGr0DBSITk5a6GJaYU8EMviSFv NUvbJuvqAkGWgCqwSH/gRVCu8CP9xO6en8i+q8kzUS2KX3Gs
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

This prepares the pwm-jz4740 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 555c2db3968d..84ad5c3eb599 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -25,14 +25,13 @@ struct soc_info {
 };
 
 struct jz4740_pwm_chip {
-	struct pwm_chip chip;
 	struct regmap *map;
 	struct clk *clk[];
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 {
-	return container_of(chip, struct jz4740_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned int channel)
@@ -222,6 +221,7 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct jz4740_pwm_chip *jz;
 	const struct soc_info *info;
 
@@ -229,10 +229,10 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	jz = devm_kzalloc(dev, struct_size(jz, clk, info->num_pwms),
-			      GFP_KERNEL);
-	if (!jz)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, info->num_pwms, struct_size(jz, clk, info->num_pwms));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	jz = to_jz4740(chip);
 
 	jz->map = device_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(jz->map)) {
@@ -240,11 +240,9 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(jz->map);
 	}
 
-	jz->chip.dev = dev;
-	jz->chip.ops = &jz4740_pwm_ops;
-	jz->chip.npwm = info->num_pwms;
+	chip->ops = &jz4740_pwm_ops;
 
-	return devm_pwmchip_add(dev, &jz->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct soc_info jz4740_soc_info = {
-- 
2.42.0

