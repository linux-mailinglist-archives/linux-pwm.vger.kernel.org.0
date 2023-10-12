Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C217C72CB
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379570AbjJLQbV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379619AbjJLQbF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:05 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FF6A9
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-00059O-3I; Thu, 12 Oct 2023 18:31:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-001C83-LB; Thu, 12 Oct 2023 18:30:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-00F5P1-C6; Thu, 12 Oct 2023 18:30:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 044/109] pwm: bcm2835: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:12 +0200
Message-ID: <20231012162827.1002444-155-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=DhblHPLhYqlBi4jJxlQe7TCYxhpnnUz9uHQ1UV6SvRk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7g16TuL/RQRs1cg4UqW6yTvicFYDJrfWCHV 85s040bohSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge4AAKCRCPgPtYfRL+ TszFB/418n6fELyPtX3DOhLSfzsXgVkNTXRpbs4OLR5fglF6mkpe+yUdYo/e1GzLqw2fyiCFwEP kTT7w4DQN17Dfw/nTiF6TIaxxZwfdEnx9FTd2F4cUHyjVmKaaEo4sF7L9gL1PFCAdbuLdoIS2kc n9DaqgGtNT7KcPz3sNPX6bN01GIKFKPPXsFR/bRExXplTIHBm35IGxz+gIzmR6CL5fuFwy5NfN5 aavwLRMhOh9UrQ7u8cvkwgO2ZSb57v5rwcjGXi7BI77MsCf3X9xzrBaNg97fFTLFl+7E9I/H4eR ZWgVFwyHSB2KcRpah/XmOF213ly/wIhmp8UxUnpvNqvZqma2
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

This prepares the pwm-bcm2835 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm2835.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 8c69ddfea2d0..15ba04090b31 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -24,7 +24,6 @@
 #define PERIOD_MIN		0x2
 
 struct bcm2835_pwm {
-	struct pwm_chip chip;
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
@@ -32,7 +31,7 @@ struct bcm2835_pwm {
 
 static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct bcm2835_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int bcm2835_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -133,12 +132,14 @@ static const struct pwm_ops bcm2835_pwm_ops = {
 
 static int bcm2835_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct bcm2835_pwm *pc;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_bcm2835_pwm(chip);
 
 	pc->dev = &pdev->dev;
 
@@ -151,11 +152,9 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &bcm2835_pwm_ops;
-	pc->chip.npwm = 2;
+	chip->ops = &bcm2835_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add pwmchip\n");
-- 
2.42.0

