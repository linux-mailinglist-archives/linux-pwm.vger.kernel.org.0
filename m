Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3197C72EA
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347340AbjJLQbi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379554AbjJLQbO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:14 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A0ACF
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaZ-0005b7-M6; Thu, 12 Oct 2023 18:31:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaX-001C9Y-0J; Thu, 12 Oct 2023 18:31:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaW-00F5Qi-NO; Thu, 12 Oct 2023 18:31:04 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 069/109] pwm: mediatek: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:37 +0200
Message-ID: <20231012162827.1002444-180-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2926; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NvNSjL4xJ1Ai1FiR6lC3rZ+UFrgPRfr2vb9OTrIV/7A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB79Uu/87wnUssX/8X0eWA6GQqyeJkdm+Wk1t N1CWkWND32JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge/QAKCRCPgPtYfRL+ TsbSB/wJ7odWzpVa2pOgRz6DO8lMhdbwdniHcICyNUp/kX+JG0d7GDGvqfZ5t+7RKHI/rINiEyo kkJwO742bs4zwwi0kEfp1TnKWOgX1zlfC6xrN0VDLp7+8UDPxKVTJ6NAT6KLCf7vmbmsq2R7ssm YvXuFNCLHKKsxLB4enqhHOSIoDTSn7vm9KYVd+C4IoJx9skr0dOm93pmx8hsKCjteO7piSwSaGS quvz0LqkVMXqb7UPdULejPozs/y/7vhhJFNZV0frEATRtCwJFlENJO2+iVoMhVp24Tm6v+tvuoT VEb4Ovyq5CCY9swqy7mIwYvgzQ2hyrVrDIGU6arQycj7VUBF
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

This prepares the pwm-mediatek driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mediatek.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index ba76d9753f1b..bc614618086d 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -51,7 +51,6 @@ struct pwm_mediatek_of_data {
  * @soc: pointer to chip's platform data
  */
 struct pwm_mediatek_chip {
-	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clk_top;
 	struct clk *clk_main;
@@ -70,7 +69,7 @@ static const unsigned int mtk_pwm_reg_offset_v2[] = {
 static inline struct pwm_mediatek_chip *
 to_pwm_mediatek_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_mediatek_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
@@ -233,21 +232,26 @@ static const struct pwm_ops pwm_mediatek_ops = {
 
 static int pwm_mediatek_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_mediatek_chip *pc;
+	const struct pwm_mediatek_of_data *soc;
 	unsigned int i;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	soc = of_device_get_match_data(&pdev->dev);
 
-	pc->soc = of_device_get_match_data(&pdev->dev);
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_pwm_mediatek_chip(chip);
+
+	pc->soc = soc;
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, pc->soc->num_pwms,
+	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, soc->num_pwms,
 				    sizeof(*pc->clk_pwms), GFP_KERNEL);
 	if (!pc->clk_pwms)
 		return -ENOMEM;
@@ -262,7 +266,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_main),
 				     "Failed to get main clock\n");
 
-	for (i = 0; i < pc->soc->num_pwms; i++) {
+	for (i = 0; i < soc->num_pwms; i++) {
 		char name[8];
 
 		snprintf(name, sizeof(name), "pwm%d", i + 1);
@@ -273,11 +277,9 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 					     "Failed to get %s clock\n", name);
 	}
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &pwm_mediatek_ops;
-	pc->chip.npwm = pc->soc->num_pwms;
+	chip->ops = &pwm_mediatek_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-- 
2.42.0

