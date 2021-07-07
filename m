Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265E53BECE5
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 19:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhGGRUe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGRUe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 13:20:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B38C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 10:17:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1BBH-0002Jq-O8; Wed, 07 Jul 2021 19:17:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1AkP-0002f6-PT; Wed, 07 Jul 2021 18:50:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APl-0006J5-0y; Wed, 07 Jul 2021 18:28:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 28/47] pwm: sl28cpld: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:16 +0200
Message-Id: <20210707162835.1772882-29-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/pwm-sl28cpld.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 7a69c1a0c060..589aeaaa6ac8 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -231,9 +231,7 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 	chip->ops = &sl28cpld_pwm_ops;
 	chip->npwm = 1;
 
-	platform_set_drvdata(pdev, priv);
-
-	ret = pwmchip_add(&priv->pwm_chip);
+	ret = devm_pwmchip_add(&pdev->dev, &priv->pwm_chip);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add PWM chip (%pe)",
 			ERR_PTR(ret));
@@ -243,13 +241,6 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sl28cpld_pwm_remove(struct platform_device *pdev)
-{
-	struct sl28cpld_pwm *priv = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&priv->pwm_chip);
-}
-
 static const struct of_device_id sl28cpld_pwm_of_match[] = {
 	{ .compatible = "kontron,sl28cpld-pwm" },
 	{}
@@ -258,7 +249,6 @@ MODULE_DEVICE_TABLE(of, sl28cpld_pwm_of_match);
 
 static struct platform_driver sl28cpld_pwm_driver = {
 	.probe = sl28cpld_pwm_probe,
-	.remove	= sl28cpld_pwm_remove,
 	.driver = {
 		.name = "sl28cpld-pwm",
 		.of_match_table = sl28cpld_pwm_of_match,
-- 
2.30.2

