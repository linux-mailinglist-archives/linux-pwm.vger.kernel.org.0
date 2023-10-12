Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F34B7C72C8
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347337AbjJLQbU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379566AbjJLQbD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:03 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36C5D6
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-00052p-In; Thu, 12 Oct 2023 18:30:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaQ-001C7p-PX; Thu, 12 Oct 2023 18:30:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaQ-00F5Ol-GM; Thu, 12 Oct 2023 18:30:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 040/109] pwm: apple: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:08 +0200
Message-ID: <20231012162827.1002444-151-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EWFaSHTVoFTH6Q8XFdZqH8m+52FGb/WrCzVZKfXOE7M=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQNudsNsczb8+b/mPEl+0jh7W2VtspHJuy+ty+Hr748P nnbAlvVTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmolbA/t/n/Ib7c3s7F1Tv nOO6vK268OZfo4IItYPnfriHW4g96fpyeuo9j2X+utPkGfNsNqQ/SHB3ZOw/mLe7NCjbjN3v+gE dk4LQ3bO8dx7P0HGP83ga8ir0e8aaNTw7pST0EyqaXq9azGezfcq1lc7JIa8kV5poWnR38X94eY HB1H1NWOdUr0YVl0mLrAUMYl1Uvbkj69zD1E3l5wTf5hENWVvAz61dHXEuJv98hOEO7jkmqYcOK NbU9h/7qMolv89MvfHnR5Fs1kiJtca+DDxv3ET9OZxen76TvLmPgUVwtrPkL3OlhSnTeqtS35h4 rJVVPLIw/KNMAL/3CZlPM+eu/Cvx9Fr5Ws7fE+e4mNwCAA==
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

This prepares the pwm-apple driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-apple.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c
index 4d755b628d9e..1560b6f88821 100644
--- a/drivers/pwm/pwm-apple.c
+++ b/drivers/pwm/pwm-apple.c
@@ -32,14 +32,13 @@
 #define APPLE_PWM_CTRL_OUTPUT_ENABLE BIT(14)
 
 struct apple_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	u64 clkrate;
 };
 
 static inline struct apple_pwm *to_apple_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct apple_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -103,13 +102,16 @@ static const struct pwm_ops apple_pwm_ops = {
 
 static int apple_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct apple_pwm *fpwm;
 	struct clk *clk;
 	int ret;
 
-	fpwm = devm_kzalloc(&pdev->dev, sizeof(*fpwm), GFP_KERNEL);
-	if (!fpwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*fpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	fpwm = to_apple_pwm(chip);
 
 	fpwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fpwm->base))
@@ -129,11 +131,9 @@ static int apple_pwm_probe(struct platform_device *pdev)
 	if (fpwm->clkrate > NSEC_PER_SEC)
 		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");
 
-	fpwm->chip.dev = &pdev->dev;
-	fpwm->chip.npwm = 1;
-	fpwm->chip.ops = &apple_pwm_ops;
+	chip->ops = &apple_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &fpwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
 
-- 
2.42.0

