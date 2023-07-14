Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD81754404
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 22:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbjGNU4k (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjGNU4i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 16:56:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A76B35AE
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 13:56:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq7-00086r-1B; Fri, 14 Jul 2023 22:56:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq6-00EQSu-8D; Fri, 14 Jul 2023 22:56:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKPq5-004u4E-Cj; Fri, 14 Jul 2023 22:56:33 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 09/10] pwm: sl28cpld: Consistenly name pwm_chip variables "chip"
Date:   Fri, 14 Jul 2023 22:56:22 +0200
Message-Id: <20230714205623.2496590-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
References: <20230714205623.2496590-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SJjW17FBiHxP3Y8vj01SqXzTORFrpwS9wr9b6xSM75U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksbZwDvNLmoDKHzo0CRLIlABxtnccR4EbGTRnW dEXwyHmfmOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLG2cAAKCRCPgPtYfRL+ TvE3B/9RybQX/FULwrVe+GidmZEcZkGGbBVcuYP0/tN2Z7m8HOLGeKMpaaTruW50J1l0e/Fc52e tPMRyieoV5ffIbIaZ+N3E8Gcf63A9u/Mt5NXfRSmOzUh56Lqg+fxQWcUIpusc7HHumxK54g0PhL RP06zKJYV1IfWo2xo3XhfYSy6Kw9L5HV54h3GxwAJzbFFRWqg6QuPxNE5UHoy5GTglWRMzJMzyy g2yAPAk+Rdf03tvDjiWS13sueVjkFCmSF8H1YHCRknL0OrqZWj9fd5Qv2wAlo3d9mBV6DvqeVT7 I14zFtZ4RonTZlTpqyeHNdJVFlNNUTuuNNSVeA6yseXhLags
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Nearly all pwm drivers use the name "chip" for the member in the driver
struct pointing to the pwm_chip. Also all local variables and function
parameters with this type use this name. Rename the struct pwm_chip
member accordingly for consistency.

Also rename the parameter of the macro sl28cpld_pwm_from_chip to "chip".

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sl28cpld.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index e64900ad4ba1..98b0024f9658 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -80,12 +80,12 @@
 	regmap_write((priv)->regmap, (priv)->offset + (reg), (val))
 
 struct sl28cpld_pwm {
-	struct pwm_chip pwm_chip;
+	struct pwm_chip chip;
 	struct regmap *regmap;
 	u32 offset;
 };
-#define sl28cpld_pwm_from_chip(_chip) \
-	container_of(_chip, struct sl28cpld_pwm, pwm_chip)
+#define sl28cpld_pwm_from_chip(chip) \
+	container_of(chip, struct sl28cpld_pwm, chip)
 
 static int sl28cpld_pwm_get_state(struct pwm_chip *chip,
 				  struct pwm_device *pwm,
@@ -228,12 +228,12 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize the pwm_chip structure */
-	chip = &priv->pwm_chip;
+	chip = &priv->chip;
 	chip->dev = &pdev->dev;
 	chip->ops = &sl28cpld_pwm_ops;
 	chip->npwm = 1;
 
-	ret = devm_pwmchip_add(&pdev->dev, &priv->pwm_chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add PWM chip (%pe)",
 			ERR_PTR(ret));
-- 
2.39.2

