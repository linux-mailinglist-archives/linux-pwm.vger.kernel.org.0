Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47457C7300
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379548AbjJLQbu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbjJLQbT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806AEA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyad-0005nF-Fl; Thu, 12 Oct 2023 18:31:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyab-001CAq-CM; Thu, 12 Oct 2023 18:31:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyab-00F5S5-3K; Thu, 12 Oct 2023 18:31:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 089/109] pwm: stm32-lp: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:57 +0200
Message-ID: <20231012162827.1002444-200-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6ngcYUxsqgyTLwQYOU+B3mousb7KNeFpyg0y2P8hr8Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8VKLC1z6miQH4Ip27wPSaVetwpQQDxNKbzK XWgMnCK5vaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfFQAKCRCPgPtYfRL+ TuQyB/4zCAkdRWO5KP9T6TGj2SJd9/weHtgKua94mUP7Q2nUZrUr3j/ptYrDnhDfoGoeDgHwuMS o2hBrzCOYdUtMOmhZIzXQ+RTE+zVq2KNSvJHOKCmnlxn7KvYGfsOyRoSWsgqy2iSXmaZq9zpjLa vFpIdRDLtdNhD1aw4VlgCKASRK05haOeQYBefGl8Hpbw6+9GonvrfT+DK6vjn4jWHp1SWpiq48H sLLklp0qbF5YnvQ1/4BqvwebW+FXK3PL9rzPM1jdGaJYFtGL/nmfA3b1oyfLYUvcHCp6UU+u1nk bf0GlJd9CocHFuZP+xyllnLYz/maMyveg1ReLglV9Wwr4kRt
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

This prepares the pwm-stm32-lp driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 1ed04664355f..1f0ba6f2ad85 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -18,14 +18,13 @@
 #include <linux/pwm.h>
 
 struct stm32_pwm_lp {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct regmap *regmap;
 };
 
 static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
 {
-	return container_of(chip, struct stm32_pwm_lp, chip);
+	return pwmchip_priv(chip);
 }
 
 /* STM32 Low-Power Timer is preceded by a configurable power-of-2 prescaler */
@@ -196,20 +195,20 @@ static const struct pwm_ops stm32_pwm_lp_ops = {
 static int stm32_pwm_lp_probe(struct platform_device *pdev)
 {
 	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct stm32_pwm_lp *priv;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_stm32_pwm_lp(chip);
 
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
-	priv->chip.dev = &pdev->dev;
-	priv->chip.ops = &stm32_pwm_lp_ops;
-	priv->chip.npwm = 1;
+	chip->ops = &stm32_pwm_lp_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return ret;
 
@@ -220,13 +219,13 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 
 static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
 {
-	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	struct pwm_state state;
 
-	pwm_get_state(&priv->chip.pwms[0], &state);
+	pwm_get_state(&chip->pwms[0], &state);
 	if (state.enabled) {
 		dev_err(dev, "The consumer didn't stop us (%s)\n",
-			priv->chip.pwms[0].label);
+			chip->pwms[0].label);
 		return -EBUSY;
 	}
 
-- 
2.42.0

