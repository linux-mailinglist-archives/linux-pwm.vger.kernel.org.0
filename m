Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9BB77469D
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjHHS65 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjHHS6k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376897280
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN6-0007HW-Cx; Tue, 08 Aug 2023 19:19:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN4-00225s-Ng; Tue, 08 Aug 2023 19:19:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00BTCk-Vs; Tue, 08 Aug 2023 19:19:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 041/101] pwm: pxa: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:31 +0200
Message-Id: <20230808171931.944154-42-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2389; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=osJKNHT95KS0lDnuO1jcln6gWhds8XhgESHPMdesFxQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njeT0pEWvPY6f6+MtzV/7TBAZzau9coRKQHf aJdTa3f7peJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ43gAKCRCPgPtYfRL+ TtCYCACEt9wy7O/829rPcCBVRBN1AD0tIaRAhIE2fnSxSVP5AUrbRw/a+UEUeWfSLe9uDqJ3ZWd hAFanQXISqdrRJu1YJXjmIjPYGaF0dQWbu/9LYPJzLvgBbkg4oG50B6WLSAZLKhHkIhsumhydhh C0BqgwTh/PNUSoGDi2b4HLQF7GXFdbRbeoL9LrPQSMzW/wk6YfeOCKaii70joJROwbIPeMDt0X2 JX1G+F/FXlOiRME5bLtSgq38fW4aIMNB3RbrOiCg93aU8km/r3udwisDyvmqIcx7w3vg2ry5Xge +0g0JM+1przPOFUMWdoidWEJDJVEnUAWv343+QQd8cDbj2eK
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

This prepares the pwm-pxa driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pxa.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index faf6b35b9336..afdcaadce0b8 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -49,7 +49,6 @@ MODULE_DEVICE_TABLE(platform, pwm_id_table);
 #define PWMDCR_FD	(1 << 10)
 
 struct pxa_pwm_chip {
-	struct pwm_chip	chip;
 	struct device	*dev;
 
 	struct clk	*clk;
@@ -58,7 +57,7 @@ struct pxa_pwm_chip {
 
 static inline struct pxa_pwm_chip *to_pxa_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pxa_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -159,6 +158,7 @@ MODULE_DEVICE_TABLE(of, pwm_of_match);
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct pwm_chip *chip;
 	struct pxa_pwm_chip *pc;
 	int ret = 0;
 
@@ -168,28 +168,29 @@ static int pwm_probe(struct platform_device *pdev)
 	if (id == NULL)
 		return -EINVAL;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (pc == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev,
+				  (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1,
+				  sizeof(*pc));
+	if (chip == NULL)
 		return -ENOMEM;
+	pc = to_pxa_pwm_chip(chip);
 
 	pc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk))
 		return PTR_ERR(pc->clk);
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &pxa_pwm_ops;
-	pc->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
+	chip->ops = &pxa_pwm_ops;
 
 	if (IS_ENABLED(CONFIG_OF)) {
-		pc->chip.of_xlate = of_pwm_single_xlate;
-		pc->chip.of_pwm_n_cells = 1;
+		chip->of_xlate = of_pwm_single_xlate;
+		chip->of_pwm_n_cells = 1;
 	}
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		return ret;
-- 
2.40.1

