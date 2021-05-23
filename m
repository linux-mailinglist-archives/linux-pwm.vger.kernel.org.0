Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE2038DB44
	for <lists+linux-pwm@lfdr.de>; Sun, 23 May 2021 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhEWNgZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 May 2021 09:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhEWNgY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 23 May 2021 09:36:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A25FC061574
        for <linux-pwm@vger.kernel.org>; Sun, 23 May 2021 06:34:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lkoFq-0006SS-3P; Sun, 23 May 2021 15:34:54 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lkoFo-0004zg-S6; Sun, 23 May 2021 15:34:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Alexander Shiyan <shc_work@mail.ru>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: clps711x: Simplify using devm_pwmchip_add()
Date:   Sun, 23 May 2021 15:34:43 +0200
Message-Id: <20210523133443.924247-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=atZxAcDSOtoJBwmz/pIIhfW5Dd6NTf227xy9ncZqIsI=; m=yrTx4MD7F7yctjkCERVFwSEjngDvVB3pLIpp5WkOHVg=; p=mTJZ6yi4D2gNfcbiDq6h1iDbDFRJr9Hi03Qx4yGKCgg=; g=6972aa9eae01c2f866ddcbc9e9c940e9de2cbec0
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCqWcwACgkQwfwUeK3K7AlO1gf/U+7 9O6qjIpZbbFei+vS9unfyDIUlBQS9fyDSZ59DSp6RnY9nzHF6DCV6lb5jQJzIqhcLMr3jjPYfV7D7 1OVpQWtJVb6j/XylOANg0wD7oMH4GZTac0meQQuQERm0qJD0c0fxEJx7xbX9eBV7nOCOgqvwOH9iE PF5k1EcM+XdwVT3bB+Cn0tfyI8LQWYMY7rv/hhT4WspPOPay24HTDu7JmX+mWOO4oUysQ1scCnqE/ HIARaYeIALuuB2Y/zo1CVdSbfua2uo6ito1igOPHn7+v1G6d38+iDwJ9XUmU2UstJRyvpM2isRPab nQKjBY0o7HVVPk9wwI+MmNUlRRXHSKw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With devm_pwmchip_add() we can drop pwmchip_remove() from the device
remove callback. The latter can then go away, too and as this is the
only user of platform_get_drvdata(), the respective call to
platform_set_drvdata() can go, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch depends on my earlier patch "pwm: Add a devm managed function to add
pwm_chips" that you can find at

	https://patchwork.ozlabs.org/project/linux-pwm/patch/20210407080155.55004-2-u.kleine-koenig@pengutronix.de/

or

	https://lore.kernel.org/r/20210407080155.55004-2-u.kleine-koenig@pengutronix.de

Best regards
Uwe

 drivers/pwm/pwm-clps711x.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index f3d17a590305..d7ad88685830 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -134,16 +134,7 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 
 	spin_lock_init(&priv->lock);
 
-	platform_set_drvdata(pdev, priv);
-
-	return pwmchip_add(&priv->chip);
-}
-
-static int clps711x_pwm_remove(struct platform_device *pdev)
-{
-	struct clps711x_chip *priv = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&priv->chip);
+	return devm_pwmchip_add(&pdev->dev, &priv->chip);
 }
 
 static const struct of_device_id __maybe_unused clps711x_pwm_dt_ids[] = {
@@ -158,7 +149,6 @@ static struct platform_driver clps711x_pwm_driver = {
 		.of_match_table = of_match_ptr(clps711x_pwm_dt_ids),
 	},
 	.probe = clps711x_pwm_probe,
-	.remove = clps711x_pwm_remove,
 };
 module_platform_driver(clps711x_pwm_driver);
 

base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
prerequisite-patch-id: fa39cd0c852d109ed957dc44dca5bdcf5dff0685
-- 
2.30.2

