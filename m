Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E663E37951A
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 19:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhEJRL4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 13:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhEJRL4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 13:11:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D680C061574
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 10:10:51 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg9Qe-0000l9-VQ; Mon, 10 May 2021 19:10:48 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg9Qe-0005YF-9B; Mon, 10 May 2021 19:10:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH] pwm: meson: Simplify using devm_pwmchip_add
Date:   Mon, 10 May 2021 19:10:46 +0200
Message-Id: <20210510171046.984246-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this obviously depends on https://lore.kernel.org/r/20210407080155.55004-2-u.kleine-koenig@pengutronix.de

Best regards
Uwe

 drivers/pwm/pwm-meson.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 9eb060613cb4..d9de4562e003 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -560,31 +560,21 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	err = pwmchip_add(&meson->chip);
+	err = devm_pwmchip_add(&meson->chip);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", err);
 		return err;
 	}
 
-	platform_set_drvdata(pdev, meson);
-
 	return 0;
 }
 
-static int meson_pwm_remove(struct platform_device *pdev)
-{
-	struct meson_pwm *meson = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&meson->chip);
-}
-
 static struct platform_driver meson_pwm_driver = {
 	.driver = {
 		.name = "meson-pwm",
 		.of_match_table = meson_pwm_matches,
 	},
 	.probe = meson_pwm_probe,
-	.remove = meson_pwm_remove,
 };
 module_platform_driver(meson_pwm_driver);
 

base-commit: 6efb943b8616ec53a5e444193dccf1af9ad627b5
prerequisite-patch-id: fa39cd0c852d109ed957dc44dca5bdcf5dff0685
-- 
2.30.2

