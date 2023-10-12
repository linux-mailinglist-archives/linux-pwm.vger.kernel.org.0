Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F877C72F7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379609AbjJLQbo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379647AbjJLQbQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77738E3
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyac-0005kT-O5; Thu, 12 Oct 2023 18:31:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaa-001CAa-IU; Thu, 12 Oct 2023 18:31:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaa-00F5Rp-9J; Thu, 12 Oct 2023 18:31:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 085/109] pwm: sl28cpld: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:53 +0200
Message-ID: <20231012162827.1002444-196-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SP6HObl80sKwkBdnebMV0NaVHrkgjH2XzfH7ob63+Ig=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8QwWhMGtDGaaPSLdY7QUxl+KNrnFVHd6FOT AAi9Ii1Hz+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfEAAKCRCPgPtYfRL+ TvfkB/9WygesFu6BWG6w+d5vF0GyG5RzKYHDp+9kcZUc4zKMcMcsMr0QgH3oaBMmQbX/2erdlIw Zvwr2sscQAaxD4+44sA9bLMJG4gakMmoLHhLmcQ7CdNKttKDNjUhKmNM9+XU9X8Zztl/UI2bXSQ JK4rdVzIWxRtmfHARwX4XJBSLUaTerbm1FxQLSsd8eyjs/H7lHPwwOL7JHONEmqQYR5q8JSmwjM 6FbBVnqL295uPHWBviid7+6uqi11tEqWAB73ek2QLb8EjdjZH2SZ8+poqP/wVMT1RE0TxOMh9XP MNCHcL94TXJjgHoCgsLXOuwBkY0HoWNKaneyTDGEwoXfy1SL
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

This prepares the pwm-sl28cpld driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sl28cpld.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 88b01ff9e460..30f96d10a3b8 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -81,14 +81,13 @@
 	regmap_write((priv)->regmap, (priv)->offset + (reg), (val))
 
 struct sl28cpld_pwm {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	u32 offset;
 };
 
 static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sl28cpld_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int sl28cpld_pwm_get_state(struct pwm_chip *chip,
@@ -213,9 +212,10 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = sl28cpld_pwm_from_chip(chip);
 
 	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!priv->regmap) {
@@ -231,10 +231,7 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize the pwm_chip structure */
-	chip = &priv->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &sl28cpld_pwm_ops;
-	chip->npwm = 1;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret) {
-- 
2.42.0

