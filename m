Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019C77C7303
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379638AbjJLQbp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347319AbjJLQbQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EDCE4
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyac-0005kz-Oq; Thu, 12 Oct 2023 18:31:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaa-001CAe-OZ; Thu, 12 Oct 2023 18:31:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaa-00F5Rt-FU; Thu, 12 Oct 2023 18:31:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 086/109] pwm: spear: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:54 +0200
Message-ID: <20231012162827.1002444-197-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mNY4nxSmQEktElUNAFUQLRUK3zDlGO6/+c2FO+pl/JE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQNeUGGj/yz5eONtioeVNpkvELHpF9qhb3Ii3COowbyF i1fPl/sZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTGBTuDgFYCK5Z9n/hxzluCkUZs0fEDa/ XPfnvasHub0D5S61vC8v1DsuGLFr/eUozeYM9j2HL3hNvql3OaElJOm9b8nJrLqVO/33akgq2Nw +HmaWYnV/5+s5v9PD9rNOuTLD/rZmxGNbB9P1llNnK+4oyHLf4NURN3frml+mM+Tv6392kE6ROR LUqfifPa1r/op3vu25LLavOC3me1xUeezU8bht1dSLraLFerO+iVy65Xh0Y5I055rDRtej5b/yx UV/4Pdf5b/je2z2IpeFObKBdxZLLSli2ZRjfOlM8k4RvsczDk5IKl97uLpazJeReXo5f8htafGS slKVUw/61+wU1gqpOuB97IloZW7iln6Fhd9vle5Yml4FAA==
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

This prepares the pwm-spear driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-spear.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index ff991319feef..5679732cd77e 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -53,12 +53,11 @@
 struct spear_pwm_chip {
 	void __iomem *mmio_base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline struct spear_pwm_chip *to_spear_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct spear_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u32 spear_pwm_readl(struct spear_pwm_chip *chip, unsigned int num,
@@ -194,13 +193,15 @@ static const struct pwm_ops spear_pwm_ops = {
 static int spear_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pwm_chip *chip;
 	struct spear_pwm_chip *pc;
 	int ret;
 	u32 val;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_spear_pwm_chip(chip);
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
@@ -211,9 +212,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "Failed to get clock\n");
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &spear_pwm_ops;
-	pc->chip.npwm = NUM_PWM;
+	chip->ops = &spear_pwm_ops;
 
 	if (of_device_is_compatible(np, "st,spear1340-pwm")) {
 		ret = clk_enable(pc->clk);
@@ -232,7 +231,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
 		clk_disable(pc->clk);
 	}
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-- 
2.42.0

