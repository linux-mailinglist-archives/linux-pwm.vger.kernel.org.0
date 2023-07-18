Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4131075846A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjGRSTK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGRSTG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C813E
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:18:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-0001oH-LT; Tue, 18 Jul 2023 20:18:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHk-000Qml-Vb; Tue, 18 Jul 2023 20:18:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHk-005unh-38; Tue, 18 Jul 2023 20:18:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 05/18] pwm: clk: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:36 +0200
Message-Id: <20230718181849.3947851-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2375; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Z5bNiwxQxy0jJM+bj0yzkW4i+MM6qU1DkFyejZ2cgAs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttbsIcdFs1fZLZuQeKxmkF7dwcOMJlrkPzwBr EJftYdIvnCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW7AAKCRCPgPtYfRL+ TvJQCACMMubpoQ1a45GyZXaaawIOB3yG+Ws+Al5l/NHUdXLPLxMR3TyJ4Y4LqUFrE+zPOWbQ8S2 x2AUtFR5VFLEPZnEWm0scPZReWX5f0Ppl0B78R+2Qqy353+6TvTfz6sg029sPuv1mvmIWNcri4t WjyD8MkePCyU7xt3b5tR3JRPLTMHhyAvv1oXEMcfBVuTzZPymFp7EIO6poMR7Q2MMdlUOR5ZMjv uHQw5kWD/cc5JdKYVkKz3+IrgqEPbJ4zw1SEyqIokl7pb8SV+8y+FhR7r6LT99kngqNpefLP9H1 65ZT85tbBEKRY+wL9Gwq7niiLAvBBBS4+sNVA33iLjDjCPUF
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

This prepares the pwm-clk driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clk.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index 0ee4d2aee4df..5affa343a059 100644
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
@@ -82,35 +84,37 @@ static const struct pwm_ops pwm_clk_ops = {
 
 static int pwm_clk_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_clk_chip *pcchip;
 	int ret;
 
-	pcchip = devm_kzalloc(&pdev->dev, sizeof(*pcchip), GFP_KERNEL);
-	if (!pcchip)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*pcchip));
+	if (!chip)
 		return -ENOMEM;
+	pcchip = to_pwm_clk_chip(chip);
 
 	pcchip->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(pcchip->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
 				     "Failed to get clock\n");
 
-	pcchip->chip.dev = &pdev->dev;
-	pcchip->chip.ops = &pwm_clk_ops;
-	pcchip->chip.npwm = 1;
+	chip->ops = &pwm_clk_ops;
+	chip->npwm = 1;
 
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
2.39.2

