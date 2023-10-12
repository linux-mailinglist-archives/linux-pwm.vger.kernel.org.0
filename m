Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE7E7C72D8
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379613AbjJLQb1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379627AbjJLQbK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE92CC
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaW-0005NO-HG; Thu, 12 Oct 2023 18:31:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaU-001C8k-3d; Thu, 12 Oct 2023 18:31:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaT-00F5Pr-Ql; Thu, 12 Oct 2023 18:31:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 056/109] pwm: hibvt: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:24 +0200
Message-ID: <20231012162827.1002444-167-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2992; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=H8zUpd6JrWoh58k1PJzTBVEr8mAeOolpVMPZzRPQkW4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQNuXeJ+xQ/2QioaL5ZsjDFwVn9xTw+LglF9dkOodx7u XSiPwh2MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCR7Ons/0t6N1Xd9JY8Hx3v Z8jsKcLam5YsHaV57myM+DtHp/36+bcsn2uv8fueoZPjOnn6/Vr9KTMFGdWOyS5d6Ttht8FjLb1 213/6mt9+5xj1NBufXs74b7ZvlpK3t13IhbLCAjeVhPW9P/ZXPvVltt3xOVny+sGc/YJmM+8dbl rzp/zWmYncBzkdrD9E+Uv/yTJcdOgJt/KDs08/v3J5nXL6yiHtxHcXViWuftxfHs2u6SIuLDpf5 EztjlSH/Rq7eeevny2vUxh+POGWpoiNkMGRW2IMopq36u5PDF4dIz5DkOvWi5UaO/Tjrxg7GetF 9X3am/S09J1Uht3v6I2fbQLMeZbwT7K789omamLslYlaAA==
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

This prepares the pwm-hibvt driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-hibvt.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index c435776e2f78..60be59ce4320 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -33,7 +33,6 @@
 #define PWM_DUTY_MASK       GENMASK(31, 0)
 
 struct hibvt_pwm_chip {
-	struct pwm_chip	chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct reset_control *rstc;
@@ -65,7 +64,7 @@ static const struct hibvt_pwm_soc hi3559v100_soc_info = {
 
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct hibvt_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static void hibvt_pwm_set_bits(void __iomem *base, u32 offset,
@@ -191,12 +190,14 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 {
 	const struct hibvt_pwm_soc *soc =
 				of_device_get_match_data(&pdev->dev);
+	struct pwm_chip	*chip;
 	struct hibvt_pwm_chip *pwm_chip;
 	int ret, i;
 
-	pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*pwm_chip), GFP_KERNEL);
-	if (pwm_chip == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms, sizeof(*pwm_chip));
+	if (chip == NULL)
 		return -ENOMEM;
+	pwm_chip = to_hibvt_pwm_chip(chip);
 
 	pwm_chip->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pwm_chip->clk)) {
@@ -205,9 +206,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pwm_chip->clk);
 	}
 
-	pwm_chip->chip.ops = &hibvt_pwm_ops;
-	pwm_chip->chip.dev = &pdev->dev;
-	pwm_chip->chip.npwm = soc->num_pwms;
+	chip->ops = &hibvt_pwm_ops;
 	pwm_chip->soc = soc;
 
 	pwm_chip->base = devm_platform_ioremap_resource(pdev, 0);
@@ -228,29 +227,31 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	msleep(30);
 	reset_control_deassert(pwm_chip->rstc);
 
-	ret = pwmchip_add(&pwm_chip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		clk_disable_unprepare(pwm_chip->clk);
 		return ret;
 	}
 
-	for (i = 0; i < pwm_chip->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		hibvt_pwm_set_bits(pwm_chip->base, PWM_CTRL_ADDR(i),
 				PWM_KEEP_MASK, (0x1 << PWM_KEEP_SHIFT));
 	}
 
-	platform_set_drvdata(pdev, pwm_chip);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void hibvt_pwm_remove(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct hibvt_pwm_chip *pwm_chip;
 
-	pwm_chip = platform_get_drvdata(pdev);
+	chip = platform_get_drvdata(pdev);
+	pwm_chip = to_hibvt_pwm_chip(chip);
 
-	pwmchip_remove(&pwm_chip->chip);
+	pwmchip_remove(chip);
 
 	reset_control_assert(pwm_chip->rstc);
 	msleep(30);
-- 
2.42.0

