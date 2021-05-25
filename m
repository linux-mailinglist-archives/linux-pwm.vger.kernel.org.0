Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733EB390A81
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 22:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhEYUds (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhEYUds (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 16:33:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF61C061574
        for <linux-pwm@vger.kernel.org>; Tue, 25 May 2021 13:32:18 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lldiq-0004bV-5F; Tue, 25 May 2021 22:32:16 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lldip-0002jH-4S; Tue, 25 May 2021 22:32:15 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] pwm: crc: Simplify using devm_pwmchip_add()
Date:   Tue, 25 May 2021 22:31:56 +0200
Message-Id: <20210525203156.969295-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=vxXUVouDR1/QIYJOQpfbFaW9OLda9yzcfW1jx3S+KNY=; m=yrTx4MD7F7yctjkCERVFwSEjngDvVB3pLIpp5WkOHVg=; p=/D6wco9ZEdxHpTnjJMITnNcTREhh1JJu7smK6X6oXnw=; g=bb9df8898e3cd49032376fdf29a753e6430fe9ae
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCtXjAACgkQwfwUeK3K7AmbCQf+LSw BbIS1+MRvzbZrBPC941sZ9QdKQVQ2gmSEqnHy7M+T3JBZzeQ6+ZMnMN5SJB+cKzpd2wxNeOytwvbh AlEOehjBilVLZIKE509VDcsjGqI5g2o324oHoeQmCB6+BtWaw/VKQ8ZavV0MXQ3Eij/xDtX1GaR0v F/uB+ovqwIHgDAsMi02v5Mlx3IONhp/gvJBNjOdPrOIcC7xurJNnsJssjlXHo6sM5wLuZOb7gDRY9 QBdusmy4JiY67iCgfFgXJbp/KjbUZv3GEEEsBVYWjv6IeUkqxKMXMckNqlMVwBeuCvLAVJTfoEtC5 t32fkeS+Bbo7zOWI7Ga1EE2SarB5aHQ==
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

 drivers/pwm/pwm-crc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 02522a9a3073..7b357d1cf642 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -173,21 +173,11 @@ static int crystalcove_pwm_probe(struct platform_device *pdev)
 	/* get the PMIC regmap */
 	pwm->regmap = pmic->regmap;
 
-	platform_set_drvdata(pdev, pwm);
-
-	return pwmchip_add(&pwm->chip);
-}
-
-static int crystalcove_pwm_remove(struct platform_device *pdev)
-{
-	struct crystalcove_pwm *pwm = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&pwm->chip);
+	return devm_pwmchip_add(&pdev->dev, &pwm->chip);
 }
 
 static struct platform_driver crystalcove_pwm_driver = {
 	.probe = crystalcove_pwm_probe,
-	.remove = crystalcove_pwm_remove,
 	.driver = {
 		.name = "crystal_cove_pwm",
 	},

base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
prerequisite-patch-id: fa39cd0c852d109ed957dc44dca5bdcf5dff0685
-- 
2.30.2

