Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4447F7746B1
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjHHS7F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjHHS6s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE01B1DD55
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN8-0007N6-TK; Tue, 08 Aug 2023 19:19:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN7-00226r-A9; Tue, 08 Aug 2023 19:19:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN6-00BTDT-AO; Tue, 08 Aug 2023 19:19:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 052/101] pwm: sti: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:42 +0200
Message-Id: <20230808171931.944154-53-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3482; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XazPW3cTp4NMXxZdU7TT6xw76+l4PjBPiqnpEYSy22I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njrNc54fsfJncjPv1XUH2jE9qa97/yvgrc4E AnIi2sp5bqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ46wAKCRCPgPtYfRL+ TkVRCACCOUQBjxSGYg7+QHfdeNdGWaO1PQVjC9+FzKIlE6udrrjEkokHHiJCDpPU3oz9nZMQBWm Wx0WsFDY05Iq9aTsGzZXBe62nWuFNtnHXU9UvcB0uAvDwf48wTV8yIVT9U082WU8UoETw39yz8o OdT+0Xu0faBFB3QlNQOKB64q1o2a+SyyMr0iDlu5S74YlOGlrG/wRPsYOrl8u7VId/LmO/8FD9c wegR72zufeDfWFcnmOV3ZE8HJh9p0El0NWCPvKqS2ssKNjn5O4b1l8YGdOlbvYzBwjaqYYqwMlP wbL8JH04edAiqwRCXuwQsc15QBfuezo/QAEd3gqDzYpnfPFF
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

This prepares the pwm-sti driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index dc92cea31cd0..9de9083bb407 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -94,7 +94,6 @@ struct sti_pwm_chip {
 	struct regmap_field *pwm_cpt_en;
 	struct regmap_field *pwm_cpt_int_en;
 	struct regmap_field *pwm_cpt_int_stat;
-	struct pwm_chip chip;
 	struct pwm_device *cur;
 	unsigned long configured;
 	unsigned int en_count;
@@ -114,7 +113,7 @@ static const struct reg_field sti_pwm_regfields[MAX_REGFIELDS] = {
 
 static inline struct sti_pwm_chip *to_sti_pwmchip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sti_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 /*
@@ -503,10 +502,6 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
 	u32 num_devs;
 	int ret;
 
-	ret = of_property_read_u32(np, "st,pwm-num-chan", &num_devs);
-	if (!ret)
-		cdata->pwm_num_devs = num_devs;
-
 	ret = of_property_read_u32(np, "st,capture-num-chan", &num_devs);
 	if (!ret)
 		cdata->cpt_num_devs = num_devs;
@@ -561,13 +556,18 @@ static int sti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sti_pwm_compat_data *cdata;
+	struct pwm_chip *chip;
 	struct sti_pwm_chip *pc;
 	unsigned int i;
 	int irq, ret;
+	u32 num_devs = 0;
 
-	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	of_property_read_u32(dev->of_node, "st,pwm-num-chan", &num_devs);
+
+	chip = devm_pwmchip_alloc(dev, num_devs, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_sti_pwmchip(chip);
 
 	cdata = devm_kzalloc(dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
@@ -600,7 +600,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	cdata->reg_fields = sti_pwm_regfields;
 	cdata->max_prescale = 0xff;
 	cdata->max_pwm_cnt = 255;
-	cdata->pwm_num_devs = 0;
+	cdata->pwm_num_devs = num_devs;
 	cdata->cpt_num_devs = 0;
 
 	pc->cdata = cdata;
@@ -644,9 +644,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
-	pc->chip.dev = dev;
-	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.npwm = pc->cdata->pwm_num_devs;
+	chip->ops = &sti_pwm_ops;
+	chip->npwm = pc->cdata->pwm_num_devs;
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
@@ -655,23 +654,24 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		mutex_init(&ddata->lock);
 	}
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		clk_unprepare(pc->pwm_clk);
 		clk_unprepare(pc->cpt_clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void sti_pwm_remove(struct platform_device *pdev)
 {
-	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	clk_unprepare(pc->pwm_clk);
 	clk_unprepare(pc->cpt_clk);
-- 
2.40.1

