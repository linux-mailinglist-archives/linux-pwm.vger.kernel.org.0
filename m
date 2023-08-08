Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D40D77469A
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjHHS6z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjHHS6j (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EB21986
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-0006oY-Rs; Tue, 08 Aug 2023 19:19:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-00223S-5T; Tue, 08 Aug 2023 19:19:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMx-00BTAf-1i; Tue, 08 Aug 2023 19:19:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 008/101] pwm: bcm-iproc: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:17:58 +0200
Message-Id: <20230808171931.944154-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ONeI5lzKyDa0vgYiAZM9rYmynRY3xk/HTItsGgTtyE0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0ni51panSkhPS7BAWJeHU1f7eFsxHplUnIHTz rrO+71AnqSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4uQAKCRCPgPtYfRL+ TpzmCACi91WHpvkMntgz0oKpzuWuWF/6/WMUzhao1q5I9K4nqq4VL/lVImBVbuFWgEWAK5S1lle s/NVYdlQozJdjuEzdHOsbyERuc+P/q5xunxAkVCXF1GzxQj2f+moTEtiVJbI8m/NJF0S6FUaJq8 +qgCWzTTPQ4HrQtMiCl/+BUNjryf7A+qiuPwJBIxodBYT6WD7Eg4nvmRE2D5s/TmvyCAF4VsHdw 4r2kITWTlRnwwHH7mZWRMUBM9Y8CrNtFc/XllBdj6YmdHZyH3yvpKPFn44Lkd4kJcq4ocMnpQXp P905yClKdAV4uKB70DZ1z2hdIfKaYobUzri2zRa907xcWyME
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
2.40.1

