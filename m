Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0197C7312
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379552AbjJLQdB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379507AbjJLQc7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:32:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B7ACF
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:32:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-0000fB-8E; Thu, 12 Oct 2023 18:32:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycH-001CBt-Kz; Thu, 12 Oct 2023 18:32:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycH-00F5VI-By; Thu, 12 Oct 2023 18:32:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 099/109] pwm: vt8500: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:32:28 +0200
Message-ID: <20231012163227.1004288-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HzjuSrKnWX8ZPRAZT/TNFfYQbfuRgII0D79E6MOrP6Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB+cqNYRp9Emm0I4TN4q5I0oFssqH6D7Hu9+y 21ExAPYH7uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfnAAKCRCPgPtYfRL+ TvbHB/9EWmTmnJaHYbA+9rYD6Z4GyinlrHZk1aLKRLExfOrlE2OdCtfW6+17+aj0Q+X8YLwhtv1 bYqoxrMW9ASeiE2cuR71t9qxSh7WNLA2EeE5WpjH6FSNjJDqaLR8HmU6rtNTG3fA7Ca/V5DErfX gbWuc5Lz+VlbeRWm02b6zS2vNHbbV4o6ANUKcZLcPfBSUPjDrYH+wmFN9AvPM+Jm3NrYRgqqjXa bKk+AoOyc9Ri9NHiKhKO8zuO0eWXXR5+n4VHVRp7YdFmXpZ5Atjuv4bVr7xtyCsmJUsMSVEE4Rl QXrRgi/FWoOCkC8tXlG/GQfD21tg7nzvyRycNaJFlmkXVLuN
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

This prepares the pwm-vt8500 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 16046f936d98..22c8695c3337 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -45,12 +45,14 @@
 #define STATUS_ALL_UPDATE	0x0F
 
 struct vt8500_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
-#define to_vt8500_chip(chip)	container_of(chip, struct vt8500_chip, chip)
+static inline struct vt8500_chip *to_vt8500_chip(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 #define msecs_to_loops(t) (loops_per_jiffy / 1000 * HZ * t)
 static inline void vt8500_pwm_busy_wait(struct pwm_chip *chip, int nr, u8 bitmask)
@@ -232,6 +234,7 @@ MODULE_DEVICE_TABLE(of, vt8500_pwm_dt_ids);
 
 static int vt8500_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct vt8500_chip *vt8500;
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
@@ -239,13 +242,12 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	if (!np)
 		return dev_err_probe(&pdev->dev, -EINVAL, "invalid devicetree node\n");
 
-	vt8500 = devm_kzalloc(&pdev->dev, sizeof(*vt8500), GFP_KERNEL);
-	if (vt8500 == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, VT8500_NR_PWMS, sizeof(*vt8500));
+	if (chip == NULL)
 		return -ENOMEM;
+	vt8500 = to_vt8500_chip(chip);
 
-	vt8500->chip.dev = &pdev->dev;
-	vt8500->chip.ops = &vt8500_pwm_ops;
-	vt8500->chip.npwm = VT8500_NR_PWMS;
+	chip->ops = &vt8500_pwm_ops;
 
 	vt8500->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(vt8500->clk))
@@ -255,7 +257,7 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(vt8500->base))
 		return PTR_ERR(vt8500->base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &vt8500->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.42.0

