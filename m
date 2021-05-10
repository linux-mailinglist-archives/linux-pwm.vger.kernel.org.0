Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F8637976E
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhEJTKw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 15:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhEJTKv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 15:10:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3221CC061574
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 12:09:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lgBHj-0007Yu-Bt; Mon, 10 May 2021 21:09:43 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lgBHi-0003S1-Tm; Mon, 10 May 2021 21:09:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Romain Perier <romain.perier@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH v2] pwm: meson: Simplify using devm_pwmchip_add
Date:   Mon, 10 May 2021 21:09:25 +0200
Message-Id: <20210510190924.990912-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CABgxDoJbnFb+=oSMNrhbBGbFCRZWBQ54Dkyy02YnYm5bveD4gA@mail.gmail.com>
References: <CABgxDoJbnFb+=oSMNrhbBGbFCRZWBQ54Dkyy02YnYm5bveD4gA@mail.gmail.com>
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

Hi Romain,

On Mon, May 10, 2021 at 08:42:07PM +0200, Romain Perier wrote:
> The "struct device *" as first argument is missing, nop ?

Damn, you're right. Here comes v2 after enabling the meson driver in my
test .config :-\

Best regards
Uwe


 drivers/pwm/pwm-meson.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 9eb060613cb4..fc5a0acb7eb9 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -560,31 +560,21 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	err = pwmchip_add(&meson->chip);
+	err = devm_pwmchip_add(&pdev->dev, &meson->chip);
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

