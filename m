Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803E1774697
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjHHS6y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjHHS6i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E098CBD
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMz-0006rG-K8; Tue, 08 Aug 2023 19:19:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-00223d-NL; Tue, 08 Aug 2023 19:19:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMx-00BTAp-Mw; Tue, 08 Aug 2023 19:19:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 011/101] pwm: brcmstb: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:01 +0200
Message-Id: <20230808171931.944154-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2062; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=qPAeo41Bb/fVK+klzbKq3+8uYNIoieh5plb8Uk6JMd8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0ni8njbkWQ4GJHbLVzSTvA6LA+jEVg0kZuFv9 z/j/ID+VHiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4vAAKCRCPgPtYfRL+ Tgh0B/9jG+EcD9CqZ/lrEO/GlTLF6ZrHawU0pEmkUrACWWacEQ1IxSjP1Sv5IZFu2qO6IlrsLuv 8uWK5K5J+7mwpNDcTRUbQJ4jFAJcOr00U5KrpFvdkEy9kbaZj4I2ZFZBEpI5iLIHjsxgvBv42i5 8ZdLWU/dQe9o33C0bnP/I7R7ATaOZ0mlp4WDEuQaj1aXkJwDDEODruaMaAoIlCLBr04N+IrbTG3 ZA1KSJTw3fsshoU8xVpzvnAfYwJWkTCC6lYg/PTcNBWV74E737/V5ffBOnOsvxQuQwYeIPEwkyW AH10eKt1Ho+tSydfx5CrUqikUeQV1hzqzAaA7Jws+wjRpBa7
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

This prepares the pwm-brcmstb driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-brcmstb.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 62bd01c08350..6671d9cf310f 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -54,7 +54,6 @@
 struct brcmstb_pwm {
 	void __iomem *base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline u32 brcmstb_pwm_readl(struct brcmstb_pwm *p,
@@ -77,7 +76,7 @@ static inline void brcmstb_pwm_writel(struct brcmstb_pwm *p, u32 value,
 
 static inline struct brcmstb_pwm *to_brcmstb_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct brcmstb_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -230,12 +229,14 @@ MODULE_DEVICE_TABLE(of, brcmstb_pwm_of_match);
 
 static int brcmstb_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct brcmstb_pwm *p;
 	int ret;
 
-	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*p));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	p = to_brcmstb_pwm(chip);
 
 	p->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(p->clk))
@@ -244,15 +245,13 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, p);
 
-	p->chip.dev = &pdev->dev;
-	p->chip.ops = &brcmstb_pwm_ops;
-	p->chip.npwm = 2;
+	chip->ops = &brcmstb_pwm_ops;
 
 	p->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(p->base))
 		return PTR_ERR(p->base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &p->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.40.1

