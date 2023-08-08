Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234BD774401
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjHHSOn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjHHSOO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1331DD05
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNA-0007Pf-Ly; Tue, 08 Aug 2023 19:19:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN8-00227Y-UZ; Tue, 08 Aug 2023 19:19:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN8-00BTE4-Aq; Tue, 08 Aug 2023 19:19:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 061/101] pwm: twl-led: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:51 +0200
Message-Id: <20230808171931.944154-62-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=F6xDGsNgrvplUfcivfEHUMKhELtgQq1V6O0gsvBPshI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpRLFV9f5fj+PKPGpvGibM3UJZ3aokv6GkUuMHZaaQQ4M O2yO72/k9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJuHGw/zNsTkuXD5o2a37W 5d0Tb/RI2v+Qkjvt4rTD4F2gjH510npfmWSbqZU+jtYT+V7WK5t9v62WrMR2antt0ssFkn6ch76 G68q99cuX+lu/XyEn+TzPr+r6x3Pq/dY+Z+TtfGb6wN7xhVTktX8ngvknJsqVrZJ+7Ni7zfdCnY NoS2a91iqTi/y3118RPcmzvXkP85qcPM751ff/XH7vJO39vnFWnLfaT/ugV+8PVB+yucoY0bFjB ef0EFWW9K0B5XNnO+92CjdpCZY6aVvxe09W/rcTqXsd1ld6n9xvqvnEdeefk3p3uqO1Xr3Qa5WZ EpRekCivlilmxR7drb/8ZacWk+3l19MC13FKXIhwKpsAAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-twl-led driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-twl-led.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 625233f4703a..4591ffab7863 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -62,13 +62,12 @@
 #define TWL6040_LED_MODE_MASK	0x03
 
 struct twl_pwmled_chip {
-	struct pwm_chip chip;
 	struct mutex mutex;
 };
 
 static inline struct twl_pwmled_chip *to_twl(struct pwm_chip *chip)
 {
-	return container_of(chip, struct twl_pwmled_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int twl4030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -345,25 +344,28 @@ static const struct pwm_ops twl6030_pwmled_ops = {
 
 static int twl_pwmled_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct twl_pwmled_chip *twl;
+	unsigned int npwm;
 
-	twl = devm_kzalloc(&pdev->dev, sizeof(*twl), GFP_KERNEL);
-	if (!twl)
-		return -ENOMEM;
+	if (twl_class_is_4030())
+		npwm = 2;
+	else
+		npwm = 1;
 
-	if (twl_class_is_4030()) {
-		twl->chip.ops = &twl4030_pwmled_ops;
-		twl->chip.npwm = 2;
-	} else {
-		twl->chip.ops = &twl6030_pwmled_ops;
-		twl->chip.npwm = 1;
-	}
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*twl));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	twl = to_twl(chip);
 
-	twl->chip.dev = &pdev->dev;
+	if (twl_class_is_4030())
+		chip->ops = &twl4030_pwmled_ops;
+	else
+		chip->ops = &twl6030_pwmled_ops;
 
 	mutex_init(&twl->mutex);
 
-	return devm_pwmchip_add(&pdev->dev, &twl->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 #ifdef CONFIG_OF
-- 
2.40.1

