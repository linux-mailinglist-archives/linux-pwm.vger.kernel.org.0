Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F0D7746AB
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjHHS7D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHHS6q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B0E175DF9
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-000760-TK; Tue, 08 Aug 2023 19:19:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN2-00224z-DC; Tue, 08 Aug 2023 19:19:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-00BTBr-7W; Tue, 08 Aug 2023 19:19:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 028/101] pwm: keembay: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:18 +0200
Message-Id: <20230808171931.944154-29-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UVwlUSMW832jSHJQ49VdpQzcAC87mDoJqGzwq0ju/Dk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njQNIeKZwkBc3rq9Cm+gaXSGc3p2Yeoq3yrS 8mqs7jLsw2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ40AAKCRCPgPtYfRL+ TreFB/43qksJzLs1QbplOOw7o7KYijHZYslhSkdFfuFQPMpIpLvQHUuy7y+zXTOoxOzh+C2YqHT 535K0SakwEZmrVqIyDlEHM/8H3GRY4MBwZC3211sy/mQMmtsVciwphDZoOYDlcKW86nJxk3D2xY 0RzsQTou9UprvWwAXFb0+kUkE0Okbw4jodyUAe6N3BY2b05Wcct2Hi2OOY+7CD8rst8de11cfGL RwYkdaoeyVJ9TSjP3alsGTU8KE0oi5jrbWfWMjgaI1XnAJh7lz1iwaLizvBdE3aaMa34pV73YmQ yot69mNVcJvh+FGrMaeTMOrLzEGn/3DgVfzib2gk2zrbe/Le
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

This prepares the pwm-keembay driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-keembay.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
index ac824ecc3f64..2af5e6565705 100644
--- a/drivers/pwm/pwm-keembay.c
+++ b/drivers/pwm/pwm-keembay.c
@@ -36,7 +36,6 @@
 #define KMB_PWM_HIGHLOW_OFFSET(ch)	(0x20 + 4 * (ch))
 
 struct keembay_pwm {
-	struct pwm_chip chip;
 	struct device *dev;
 	struct clk *clk;
 	void __iomem *base;
@@ -44,7 +43,7 @@ struct keembay_pwm {
 
 static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip *chip)
 {
-	return container_of(chip, struct keembay_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static void keembay_clk_unprepare(void *data)
@@ -185,12 +184,14 @@ static const struct pwm_ops keembay_pwm_ops = {
 static int keembay_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct keembay_pwm *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, KMB_TOTAL_PWM_CHANNELS, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_keembay_pwm_dev(chip);
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk))
@@ -204,11 +205,9 @@ static int keembay_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &keembay_pwm_ops;
-	priv->chip.npwm = KMB_TOTAL_PWM_CHANNELS;
+	chip->ops = &keembay_pwm_ops;
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
 
-- 
2.40.1

