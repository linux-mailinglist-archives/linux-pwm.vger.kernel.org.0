Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BA57C72D0
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379579AbjJLQbX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379593AbjJLQbG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A57A9
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaU-0005DI-7d; Thu, 12 Oct 2023 18:31:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaS-001C8E-BG; Thu, 12 Oct 2023 18:31:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaS-00F5PI-1s; Thu, 12 Oct 2023 18:31:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 047/109] pwm: berlin: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:15 +0200
Message-ID: <20231012162827.1002444-158-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3382; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MypTKBUp2JXDAdQuKnke2IE2XhB8pVWWBuwrA/aQSn8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7jK6telqsD99xeGVDv9HqflPuNXxo1LJS9R I+k46GATDWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge4wAKCRCPgPtYfRL+ Tl0kCACym6eQDnjDNbYUgkLxrrviuhWACJSO5a74CBwl4UUnIUkDibl+4S10FrAcKxKeCbB+zTf FGjTv24z5zjGdbhAlW4wXBK+slMAa/d3RgNI28vKKB0686dDYCzMdjwJBgxKHqOMU5vq6/TiJAt QWCMXE1EvTMShiRaA7M9VlDLgzJ1hAG8XEXeIwyekhHQM8ocCGNl7jcI50WaaYoYXRLlu4F76XQ 4A2IK9FB15c2lZ+1cg2YUbwTexYOBah5egAEF4zZsaeE+hbHw+UcJVAsbQ6tnj62mE+lVhepsw5 hkhzXswH13mGPprBdaHurjgNU8hrBSFBkSq+u/KNhWviCNwH
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

This prepares the pwm-berlin driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-berlin.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index ba2d79991769..fd5901dda874 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -49,7 +49,6 @@ struct berlin_pwm_channel {
 };
 
 struct berlin_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct berlin_pwm_channel channel[BERLIN_PWM_NUMPWMS];
@@ -57,7 +56,7 @@ struct berlin_pwm_chip {
 
 static inline struct berlin_pwm_chip *to_berlin_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct berlin_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u32 berlin_pwm_readl(struct berlin_pwm_chip *bpc,
@@ -198,12 +197,14 @@ MODULE_DEVICE_TABLE(of, berlin_pwm_match);
 
 static int berlin_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct berlin_pwm_chip *bpc;
 	int ret;
 
-	bpc = devm_kzalloc(&pdev->dev, sizeof(*bpc), GFP_KERNEL);
-	if (!bpc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, BERLIN_PWM_NUMPWMS, sizeof(*bpc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	bpc = to_berlin_pwm_chip(chip);
 
 	bpc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bpc->base))
@@ -213,15 +214,13 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(bpc->clk))
 		return PTR_ERR(bpc->clk);
 
-	bpc->chip.dev = &pdev->dev;
-	bpc->chip.ops = &berlin_pwm_ops;
-	bpc->chip.npwm = BERLIN_PWM_NUMPWMS;
+	chip->ops = &berlin_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &bpc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-	platform_set_drvdata(pdev, bpc);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
@@ -229,10 +228,11 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int berlin_pwm_suspend(struct device *dev)
 {
-	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	unsigned int i;
 
-	for (i = 0; i < bpc->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
 		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
@@ -248,7 +248,8 @@ static int berlin_pwm_suspend(struct device *dev)
 
 static int berlin_pwm_resume(struct device *dev)
 {
-	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	unsigned int i;
 	int ret;
 
@@ -256,7 +257,7 @@ static int berlin_pwm_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < bpc->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
 		berlin_pwm_writel(bpc, i, channel->ctrl, BERLIN_PWM_CONTROL);
-- 
2.42.0

