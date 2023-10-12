Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60F57C72CF
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379574AbjJLQbX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379579AbjJLQbG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:06 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB4FCA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-0005Ag-F1; Thu, 12 Oct 2023 18:31:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-001C87-Ru; Thu, 12 Oct 2023 18:30:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-00F5P5-Io; Thu, 12 Oct 2023 18:30:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 045/109] pwm: bcm-iproc: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:13 +0200
Message-ID: <20231012162827.1002444-156-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sJ498qvoNivbkk0deEr4R5sEvVeiQw9QYJAIlTDYq+M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7hDnxIBSmh5IsDrNBdzQOT4MHI2EYFW8mYO py10IFAriyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge4QAKCRCPgPtYfRL+ TtDlCACLyvj49BazdlgBdhnF4j1SL9cbNY5qYQx/qJkwZsmMDl7T9aKy5qMQ4xaycE/SYqiQqur WXyVm4HHUMI5fV2dBhsu1Kv0Wflik5QBOTLW6NgSJucQEdXIgNbtg7xR9d9mVA/6pqfhPvj501B neIdnMXdIr3nYCTlSlqhYJiDEjSgfvgEU8Ut9IJ6QvCxd4ekWACCQMknX4WRumIwXMKnlYnCdj/ hm000xO/GwHvu98VWxm673yr/QUu+ox84szf87ly9Wz6DZCEzrWAcGBFuVlZB+Kl+YuuwA6Bk4p l6lOkMFLtHs6HWiOxVwa54bvcDiYCDz5o8J91UkpqWorRj2z
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

This prepares the pwm-bcm-iproc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-iproc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 758254025683..4c8d82de50a9 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -34,14 +34,13 @@
 #define IPROC_PWM_PRESCALE_MAX			0x3f
 
 struct iproc_pwmc {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct iproc_pwmc *to_iproc_pwmc(struct pwm_chip *chip)
 {
-	return container_of(chip, struct iproc_pwmc, chip);
+	return pwmchip_priv(chip);
 }
 
 static void iproc_pwmc_enable(struct iproc_pwmc *ip, unsigned int channel)
@@ -187,20 +186,20 @@ static const struct pwm_ops iproc_pwm_ops = {
 
 static int iproc_pwmc_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct iproc_pwmc *ip;
 	unsigned int i;
 	u32 value;
 	int ret;
 
-	ip = devm_kzalloc(&pdev->dev, sizeof(*ip), GFP_KERNEL);
-	if (!ip)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 4, sizeof(*ip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ip = to_iproc_pwmc(chip);
 
 	platform_set_drvdata(pdev, ip);
 
-	ip->chip.dev = &pdev->dev;
-	ip->chip.ops = &iproc_pwm_ops;
-	ip->chip.npwm = 4;
+	chip->ops = &iproc_pwm_ops;
 
 	ip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ip->base))
@@ -214,14 +213,14 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 	/* Set full drive and normal polarity for all channels */
 	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
 
-	for (i = 0; i < ip->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		value &= ~(1 << IPROC_PWM_CTRL_TYPE_SHIFT(i));
 		value |= 1 << IPROC_PWM_CTRL_POLARITY_SHIFT(i);
 	}
 
 	writel(value, ip->base + IPROC_PWM_CTRL_OFFSET);
 
-	ret = devm_pwmchip_add(&pdev->dev, &ip->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add PWM chip\n");
-- 
2.42.0

