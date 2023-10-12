Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D127C72CD
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379566AbjJLQbW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379620AbjJLQbF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:05 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B247ACF
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-0005Bt-Jj; Thu, 12 Oct 2023 18:31:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaS-001C8A-2S; Thu, 12 Oct 2023 18:31:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-00F5P9-PU; Thu, 12 Oct 2023 18:30:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 046/109] pwm: bcm-kona: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:14 +0200
Message-ID: <20231012162827.1002444-157-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2115; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6uQ+gQRpp9b2E6GpmmxJDmApJQvDAxDJ/6PjecsbMsw=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7isCY49v82+fjC2TzYYRPsh/j3v8wknSP5C /pft4XC+HeJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge4gAKCRCPgPtYfRL+ TiYZB/i3KFJmbMXq3Vx+YRfQqG2V9d4VhmrdJ76s05oINPoUgcHvNSZTsWvKnWCwYRbisGaQpIY jiuoXzv/rdi8gAg8TKfJvM/vsgbHtrX3D2xUtuxkN9xTOJneJZ//5wtBHBjb8CWhMvMpWKyoRuO Ku2K8nAzbsgAOdbPE5ESwYZ2/g4f/wJ8R3+OLgFBSJOCW3AjPKFWm7f08tmRH+nX7QEC1JFWhyT hVdK1qiFYNotzDgVNFxaZaUjZ0LfbGXi58b+CpbVibDuv1WOb4qbfzhcdEmDXqjxdKmW29UU2g3 ieepNbGzrXzXZrZfpZElyCNYEX81RyCAZjxaQiEDUiodarg=
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

This prepares the pwm-bcm-kona driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-kona.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 53bb52c9da08..71bc999c576f 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -56,14 +56,13 @@
 #define DUTY_CYCLE_HIGH_MAX			0x00ffffff
 
 struct kona_pwmc {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct kona_pwmc *to_kona_pwmc(struct pwm_chip *chip)
 {
-	return container_of(chip, struct kona_pwmc, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -273,18 +272,18 @@ static const struct pwm_ops kona_pwm_ops = {
 
 static int kona_pwmc_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct kona_pwmc *kp;
 	unsigned int chan;
 	unsigned int value = 0;
 	int ret = 0;
 
-	kp = devm_kzalloc(&pdev->dev, sizeof(*kp), GFP_KERNEL);
-	if (kp == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, 6, sizeof(*kp));
+	if (chip == NULL)
 		return -ENOMEM;
+	kp = to_kona_pwmc(chip);
 
-	kp->chip.dev = &pdev->dev;
-	kp->chip.ops = &kona_pwm_ops;
-	kp->chip.npwm = 6;
+	chip->ops = &kona_pwm_ops;
 
 	kp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kp->base))
@@ -304,14 +303,14 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	}
 
 	/* Set push/pull for all channels */
-	for (chan = 0; chan < kp->chip.npwm; chan++)
+	for (chan = 0; chan < chip->npwm; chan++)
 		value |= (1 << PWM_CONTROL_TYPE_SHIFT(chan));
 
 	writel(value, kp->base + PWM_CONTROL_OFFSET);
 
 	clk_disable_unprepare(kp->clk);
 
-	ret = devm_pwmchip_add(&pdev->dev, &kp->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 
-- 
2.42.0

