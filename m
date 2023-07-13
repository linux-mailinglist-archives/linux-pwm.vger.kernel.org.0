Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9A87527B9
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jul 2023 17:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGMPvz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Jul 2023 11:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbjGMPvy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jul 2023 11:51:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441F02689
        for <linux-pwm@vger.kernel.org>; Thu, 13 Jul 2023 08:51:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJybd-0004il-9k; Thu, 13 Jul 2023 17:51:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJybc-00E9KB-3U; Thu, 13 Jul 2023 17:51:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJybb-004abh-9x; Thu, 13 Jul 2023 17:51:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] pwm: stm32: Simplify using devm_pwmchip_add()
Date:   Thu, 13 Jul 2023 17:51:42 +0200
Message-Id: <20230713155142.2454010-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713155142.2454010-1-u.kleine-koenig@pengutronix.de>
References: <20230713155142.2454010-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=apBYvwQ8Xvzmv3dzNjz7fDsp+SOzPk4mArfRVsDwhU4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksB2N6DlpaPS3SS+ZcmJGhd7ysiMqTSeyyJ1Bz QLQ8bm6PziJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLAdjQAKCRCPgPtYfRL+ ToSCCACIrNWk/VA/bapZ39Eum/kzghluzIhE1Hp/a+FHN+p+xuW/rhzoCj4lqogYH3CsFcYjpI3 JkaS7z03qMv9ZLkhG0GsDXK48Tplvb13b4KzwSqzb6bF/6gvXVJrdfRzDt257jbzFyycOzYnfx4 XRUv2ldHOV/PtP/Ttop/BTJH3wYwZ5GMBXl6Pkzri2BopKXmskPLFSgXjxx34gF0ZZ2jy4dfxAl DZN10tJi9KYMZB7Cu6fwAT9rKexws5wUwv8Qgnsi0fhnoN9XBcEMugdrvzGbUGNvPJIBKqSw4hA SuaSiYzwxZSPVGI2P2pIonDMzEU3A5veySG+hQbyg0rIZ2eG
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This allows to drop the platform_driver's remove function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 687967d3265f..3d6be7749e23 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -637,7 +637,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	priv->chip.ops = &stm32pwm_ops;
 	priv->chip.npwm = stm32_pwm_detect_channels(priv);
 
-	ret = pwmchip_add(&priv->chip);
+	ret = devm_pwmchip_add(dev, &priv->chip);
 	if (ret < 0)
 		return ret;
 
@@ -646,13 +646,6 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void stm32_pwm_remove(struct platform_device *pdev)
-{
-	struct stm32_pwm *priv = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&priv->chip);
-}
-
 static int __maybe_unused stm32_pwm_suspend(struct device *dev)
 {
 	struct stm32_pwm *priv = dev_get_drvdata(dev);
@@ -697,7 +690,6 @@ MODULE_DEVICE_TABLE(of, stm32_pwm_of_match);
 
 static struct platform_driver stm32_pwm_driver = {
 	.probe	= stm32_pwm_probe,
-	.remove_new = stm32_pwm_remove,
 	.driver	= {
 		.name = "stm32-pwm",
 		.of_match_table = stm32_pwm_of_match,
-- 
2.39.2

