Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8637746AA
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjHHS7D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjHHS6q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36F175DF6
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00074Q-JB; Tue, 08 Aug 2023 19:19:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN2-00224q-5z; Tue, 08 Aug 2023 19:19:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN0-00BTBi-Kd; Tue, 08 Aug 2023 19:19:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 025/101] pwm: intel-lgm: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:15 +0200
Message-Id: <20230808171931.944154-26-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=K7ZP8Gd7VftLMG6r24l5znCa3ooU9r0JPcPukmF3Y08=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njMukO6yD4k4LFQ3ADlLlqu3vxl8pJMB5I2S +iwR4JDeNuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4zAAKCRCPgPtYfRL+ TtsgB/9ORZnZZQ+T9SgfRAZ+2D9GOhO4NSH1rllYv/kiOOIzkVUviNqWqjtC9GqEeNxipzq7qyE jXWMHETVOMByNP71OzC6c1G7UHq9BXS7brz/uNCRjsag93FQmm0Mm4a6/f848AgCe44Vo2Og31U JE9LBETdk55u1AS4VsE6si5zyxuCHTilUayIfh0ZYbp5fn8LZ5RscK3JjRTEfiH1OY0fReP6o68 D7xz8DXqhjdAmuLI6JcpDQ3E5KI+cjaIwvJlmIAME2sdvKJ2hAIpc3sKlA12F4uQRndixP1iXg+ xFpyCuYJ8qXdWcFpCF8/tYl/VVFn9ZWQwP4JzK1fPpEnovqN
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

This prepares the pwm-intel-lgm driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-intel-lgm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
index 54ecae7f937e..9abd8859f869 100644
--- a/drivers/pwm/pwm-intel-lgm.c
+++ b/drivers/pwm/pwm-intel-lgm.c
@@ -42,14 +42,13 @@
 #define LGM_PWM_PERIOD_2WIRE_NS		(40 * NSEC_PER_MSEC)
 
 struct lgm_pwm_chip {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	u32 period;
 };
 
 static inline struct lgm_pwm_chip *to_lgm_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct lgm_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int lgm_pwm_enable(struct pwm_chip *chip, bool enable)
@@ -168,14 +167,16 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct reset_control *rst;
+	struct pwm_chip *chip;
 	struct lgm_pwm_chip *pc;
 	void __iomem *io_base;
 	struct clk *clk;
 	int ret;
 
-	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_lgm_pwm_chip(chip);
 
 	io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(io_base))
@@ -203,13 +204,11 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
 
-	pc->chip.dev = dev;
-	pc->chip.ops = &lgm_pwm_ops;
-	pc->chip.npwm = 1;
+	chip->ops = &lgm_pwm_ops;
 
 	lgm_pwm_init(pc);
 
-	ret = devm_pwmchip_add(dev, &pc->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
 
-- 
2.40.1

