Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CC57C730D
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347274AbjJLQc6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347190AbjJLQc6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:32:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5414CA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:32:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycI-0000fN-8D; Thu, 12 Oct 2023 18:32:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycH-001CBw-RY; Thu, 12 Oct 2023 18:32:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqycH-00F5VL-IV; Thu, 12 Oct 2023 18:32:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 100/109] pwm: xilinx: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:32:29 +0200
Message-ID: <20231012163227.1004288-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ccXCsHO+01FJmKZCD9dTukfb/pa80Oz4PHVbSCoWmzk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB+dFkWwaeUiLqSnjObjsNpqx2ultYHIWs2R7 fjYsjpw9qKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfnQAKCRCPgPtYfRL+ Tn0FB/0Yd+FcYR8TZgZnvQ8J5n4981kGPX5epmjH+tHv+jfdvbb8Xe+p6R8aEjw54VzsTIJMjm/ JU4N/Vw6aon54AN+97DEyQ1rM+blutvN72gf/jsKsmsUJdsoLAD9t6wMMaDvvSltBXU6ErPOm97 2blfRpIVYeSGbQo4T8WY0/WLKJNgZHG6UzJPyRvhdXgzqKxVJHhKS+HsdDjUSqfdWLnDH++jrf1 vR2DLWfj5RPmZjO+xqSbd2I639AGtGikEKog86n5S51gp5n/c61IkL8ept5gGYy0Ki5EULXHlqr dmgEOLeWDDB25utvQxTY1ZgjZWMyfGygKe4kclFHJYPyt/dG
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

This prepares the pwm-xilinx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-xilinx.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
index 5f3c2a6fed11..47184916239b 100644
--- a/drivers/pwm/pwm-xilinx.c
+++ b/drivers/pwm/pwm-xilinx.c
@@ -80,15 +80,10 @@ unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
 #define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
 #define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
 
-struct xilinx_pwm_device {
-	struct pwm_chip chip;
-	struct xilinx_timer_priv priv;
-};
-
 static inline struct xilinx_timer_priv
 *xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
 {
-	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
+	return pwmchip_priv(chip);
 }
 
 static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
@@ -213,8 +208,8 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	int ret;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct pwm_chip *chip;
 	struct xilinx_timer_priv *priv;
-	struct xilinx_pwm_device *xilinx_pwm;
 	u32 pwm_cells, one_timer, width;
 	void __iomem *regs;
 
@@ -225,11 +220,11 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
 
-	xilinx_pwm = devm_kzalloc(dev, sizeof(*xilinx_pwm), GFP_KERNEL);
-	if (!xilinx_pwm)
-		return -ENOMEM;
-	platform_set_drvdata(pdev, xilinx_pwm);
-	priv = &xilinx_pwm->priv;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = xilinx_pwm_chip_to_priv(chip);
+	platform_set_drvdata(pdev, chip);
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
@@ -278,10 +273,8 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Clock enable failed\n");
 	clk_rate_exclusive_get(priv->clk);
 
-	xilinx_pwm->chip.dev = dev;
-	xilinx_pwm->chip.ops = &xilinx_pwm_ops;
-	xilinx_pwm->chip.npwm = 1;
-	ret = pwmchip_add(&xilinx_pwm->chip);
+	chip->ops = &xilinx_pwm_ops;
+	ret = pwmchip_add(chip);
 	if (ret) {
 		clk_rate_exclusive_put(priv->clk);
 		clk_disable_unprepare(priv->clk);
@@ -293,11 +286,12 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 
 static void xilinx_pwm_remove(struct platform_device *pdev)
 {
-	struct xilinx_pwm_device *xilinx_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
 
-	pwmchip_remove(&xilinx_pwm->chip);
-	clk_rate_exclusive_put(xilinx_pwm->priv.clk);
-	clk_disable_unprepare(xilinx_pwm->priv.clk);
+	pwmchip_remove(chip);
+	clk_rate_exclusive_put(priv->clk);
+	clk_disable_unprepare(priv->clk);
 }
 
 static const struct of_device_id xilinx_pwm_of_match[] = {
-- 
2.42.0

