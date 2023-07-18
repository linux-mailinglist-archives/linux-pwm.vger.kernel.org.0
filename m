Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8A375846D
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjGRSTM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGRSTH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB755FC
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHm-0001pB-NT; Tue, 18 Jul 2023 20:18:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHm-000QnB-2H; Tue, 18 Jul 2023 20:18:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-005uo3-85; Tue, 18 Jul 2023 20:18:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 11/18] pwm: keembay: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:42 +0200
Message-Id: <20230718181849.3947851-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uoekT70U4Zudq+P9umavLUrCK4krsurwuumNwfuMzFg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttbz0J/IEa9k4sO8iTH2cQgChvYcbjkVtAwez 17cAHcHVMmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW8wAKCRCPgPtYfRL+ TgDOCACR7t3rMsiUp3waDscwc2WkrM8pqGrmMxKKxsr7k7xZ4pbtfUQy2/x7a1b81Ue+CrhAq33 YMhxf9h2mIMBRDagYN6ygEqmpVJDSsGvIpNI64e7w+2/Ukc/g+QqOzAPhB1ukJg0Kf6kJMjaN5z idYTNA6BLia21KU9clpc5c+2fNRXJ3S4bxKT4zeICsof5HBzyvkuwGPNBBVzn27VYsJgGdXmLo3 dlOXnin1V26ax+pD1Ztomp8pX81mZByEYwBwclDOJ/7yP2p3ofvVnkPqX15viAnvEWYfxTXYeCt Lg1a+sK+fVy+rL6A+MgNuiVM8mt1T1Z3iYGv+Ul6T30+EdvV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
 drivers/pwm/pwm-keembay.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
index ac02d8bb4a0b..ceef94080823 100644
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
@@ -186,12 +185,14 @@ static const struct pwm_ops keembay_pwm_ops = {
 static int keembay_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct keembay_pwm *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	chip = devm_pwmchip_alloc(dev, sizeof(*priv));
+	if (!chip)
 		return -ENOMEM;
+	priv = to_keembay_pwm_dev(chip);
 
 	priv->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(priv->clk))
@@ -205,11 +206,10 @@ static int keembay_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &keembay_pwm_ops;
-	priv->chip.npwm = KMB_TOTAL_PWM_CHANNELS;
+	chip->ops = &keembay_pwm_ops;
+	chip->npwm = KMB_TOTAL_PWM_CHANNELS;
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
 
-- 
2.39.2

