Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D123BEC27
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhGGQba (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhGGQba (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95B2C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APn-000446-NI; Wed, 07 Jul 2021 18:28:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APm-0002c5-OZ; Wed, 07 Jul 2021 18:28:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APj-0006IX-N0; Wed, 07 Jul 2021 18:28:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 20/47] pwm: keembay: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:08 +0200
Message-Id: <20210707162835.1772882-21-u.kleine-koenig@pengutronix.de>
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

This allows to drop the platform_driver's remove function. This is the
only user of driver data so this can go away, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-keembay.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
index 521a825c8ba0..733811b05721 100644
--- a/drivers/pwm/pwm-keembay.c
+++ b/drivers/pwm/pwm-keembay.c
@@ -207,22 +207,13 @@ static int keembay_pwm_probe(struct platform_device *pdev)
 	priv->chip.ops = &keembay_pwm_ops;
 	priv->chip.npwm = KMB_TOTAL_PWM_CHANNELS;
 
-	ret = pwmchip_add(&priv->chip);
+	ret = devm_pwmchip_add(dev, &priv->chip);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
 
-	platform_set_drvdata(pdev, priv);
-
 	return 0;
 }
 
-static int keembay_pwm_remove(struct platform_device *pdev)
-{
-	struct keembay_pwm *priv = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&priv->chip);
-}
-
 static const struct of_device_id keembay_pwm_of_match[] = {
 	{ .compatible = "intel,keembay-pwm" },
 	{ }
@@ -231,7 +222,6 @@ MODULE_DEVICE_TABLE(of, keembay_pwm_of_match);
 
 static struct platform_driver keembay_pwm_driver = {
 	.probe	= keembay_pwm_probe,
-	.remove	= keembay_pwm_remove,
 	.driver	= {
 		.name = "pwm-keembay",
 		.of_match_table = keembay_pwm_of_match,
-- 
2.30.2

