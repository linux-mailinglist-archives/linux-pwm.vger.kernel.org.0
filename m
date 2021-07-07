Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387F13BECEA
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 19:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhGGRUh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 13:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbhGGRUh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 13:20:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D249FC061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 10:17:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1BBK-0002PV-Q1; Wed, 07 Jul 2021 19:17:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1AkP-0002f6-Oo; Wed, 07 Jul 2021 18:50:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APl-0006J8-5e; Wed, 07 Jul 2021 18:28:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 29/47] pwm: stm32-lp: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:17 +0200
Message-Id: <20210707162835.1772882-30-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
References: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This allows to drop the platform_driver's remove function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index e4a10aac354d..3115abb3f52a 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -209,7 +209,7 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 	priv->chip.ops = &stm32_pwm_lp_ops;
 	priv->chip.npwm = 1;
 
-	ret = pwmchip_add(&priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
 	if (ret < 0)
 		return ret;
 
@@ -218,13 +218,6 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int stm32_pwm_lp_remove(struct platform_device *pdev)
-{
-	struct stm32_pwm_lp *priv = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&priv->chip);
-}
-
 static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
 {
 	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
@@ -256,7 +249,6 @@ MODULE_DEVICE_TABLE(of, stm32_pwm_lp_of_match);
 
 static struct platform_driver stm32_pwm_lp_driver = {
 	.probe	= stm32_pwm_lp_probe,
-	.remove	= stm32_pwm_lp_remove,
 	.driver	= {
 		.name = "stm32-pwm-lp",
 		.of_match_table = of_match_ptr(stm32_pwm_lp_of_match),
-- 
2.30.2

