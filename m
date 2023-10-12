Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185777C72D2
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379606AbjJLQbY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379623AbjJLQbH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:07 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1CDCC
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaU-0005FT-Oz; Thu, 12 Oct 2023 18:31:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaS-001C8L-Nq; Thu, 12 Oct 2023 18:31:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaS-00F5PQ-Ev; Thu, 12 Oct 2023 18:31:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 049/109] pwm: clk: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:17 +0200
Message-ID: <20231012162827.1002444-160-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2393; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dqPmpUBWXhxQUDh+Jp+d35ZL8f3SurIXjN24EPVpkDA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7mxJLGRLm3rmmVBeNuH6OIDDxcANvDOm4GB fQQsE2hsuWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge5gAKCRCPgPtYfRL+ TlQeB/sFOUvwxclea22EfdWJO9hM37Jc0M5cgwRFwXEl//NjVTqiY+5PVpxzUm/5snIDgsTWLS3 y48mV+zlVTmH5fcM1ZQw7gev7IFPYUJGLRIRqjaxPt1X17iE6ftoIYkA2/3tE/o/uM5mqDGuLrb Nr5T+gUxn5Th6oA3UfSwelplSjuAZAIw1+uJ/hqDq9a3cm42DnG5bmC2rGHcZWF+zuWkkBIX4jo yDj5c4KxRmLvnFXtk+g/NYV2ooDDi9P8fh069rPkYFNkD2EOMaY9n8GKCjFBHjyiaUFFTO7wsZ1 4Rbjpx6zWRMM3hoHh8dbWsaBSArYo8yAZjBiGjsqKBRbwKQb
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

This prepares the pwm-clk driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clk.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index 9dd88b386907..86bf1ddedf89 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -28,12 +28,14 @@
 #include <linux/pwm.h>
 
 struct pwm_clk_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	bool clk_enabled;
 };
 
-#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, chip)
+static inline struct pwm_clk_chip *to_pwm_clk_chip(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
@@ -81,35 +83,36 @@ static const struct pwm_ops pwm_clk_ops = {
 
 static int pwm_clk_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_clk_chip *pcchip;
 	int ret;
 
-	pcchip = devm_kzalloc(&pdev->dev, sizeof(*pcchip), GFP_KERNEL);
-	if (!pcchip)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pcchip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pcchip = to_pwm_clk_chip(chip);
 
 	pcchip->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(pcchip->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
 				     "Failed to get clock\n");
 
-	pcchip->chip.dev = &pdev->dev;
-	pcchip->chip.ops = &pwm_clk_ops;
-	pcchip->chip.npwm = 1;
+	chip->ops = &pwm_clk_ops;
 
-	ret = pwmchip_add(&pcchip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
 
-	platform_set_drvdata(pdev, pcchip);
+	platform_set_drvdata(pdev, chip);
 	return 0;
 }
 
 static void pwm_clk_remove(struct platform_device *pdev)
 {
-	struct pwm_clk_chip *pcchip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct pwm_clk_chip *pcchip = to_pwm_clk_chip(chip);
 
-	pwmchip_remove(&pcchip->chip);
+	pwmchip_remove(chip);
 
 	if (pcchip->clk_enabled)
 		clk_disable(pcchip->clk);
-- 
2.42.0

