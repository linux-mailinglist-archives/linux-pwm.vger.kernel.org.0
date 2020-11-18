Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EEE2B7BA3
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Nov 2020 11:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgKRKqz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Nov 2020 05:46:55 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:55911 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgKRKqy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 18 Nov 2020 05:46:54 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 2664044091A;
        Wed, 18 Nov 2020 12:31:09 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/5] gpio: mvebu: switch pwm duration registers to regmap
Date:   Wed, 18 Nov 2020 12:30:43 +0200
Message-Id: <a461384f84682c212e276fdd7d33972e75b67fd9.1605694661.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605694661.git.baruch@tkos.co.il>
References: <cover.1605694661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit 2233bf7a92e ("gpio: mvebu: switch to regmap for register access")
changed most readl/writel registers access calls to the regmap API in
preparation for Armada 7K/8K support. PWM duration registers were left using
readl/writel, as the driver does not support PWM for Armada 7K/8K.

Switch PWM duration registers to regmap as first step in adding Armada 7K/8K
PWM functionality support.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 68 +++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index bdc4d813a42e..946571e70928 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -92,7 +92,7 @@
 #define MVEBU_MAX_GPIO_PER_BANK		32
 
 struct mvebu_pwm {
-	void __iomem		*membase;
+	struct regmap		*regs;
 	unsigned long		 clk_rate;
 	struct gpio_desc	*gpiod;
 	struct pwm_chip		 chip;
@@ -278,17 +278,17 @@ mvebu_gpio_write_level_mask(struct mvebu_gpio_chip *mvchip, u32 val)
 }
 
 /*
- * Functions returning addresses of individual registers for a given
+ * Functions returning offsets of individual registers for a given
  * PWM controller.
  */
-static void __iomem *mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mvpwm)
+static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mvpwm)
 {
-	return mvpwm->membase + PWM_BLINK_ON_DURATION_OFF;
+	return PWM_BLINK_ON_DURATION_OFF;
 }
 
-static void __iomem *mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
+static unsigned int mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
 {
-	return mvpwm->membase + PWM_BLINK_OFF_DURATION_OFF;
+	return PWM_BLINK_OFF_DURATION_OFF;
 }
 
 /*
@@ -599,6 +599,13 @@ static void mvebu_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static const struct regmap_config mvebu_gpio_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+};
+
 /*
  * Functions implementing the pwm_chip methods
  */
@@ -659,9 +666,8 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 
 	spin_lock_irqsave(&mvpwm->lock, flags);
 
-	val = (unsigned long long)
-		readl_relaxed(mvebu_pwmreg_blink_on_duration(mvpwm));
-	val *= NSEC_PER_SEC;
+	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), &u);
+	val = (unsigned long long) u * NSEC_PER_SEC;
 	do_div(val, mvpwm->clk_rate);
 	if (val > UINT_MAX)
 		state->duty_cycle = UINT_MAX;
@@ -670,9 +676,8 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 	else
 		state->duty_cycle = 1;
 
-	val = (unsigned long long)
-		readl_relaxed(mvebu_pwmreg_blink_off_duration(mvpwm));
-	val *= NSEC_PER_SEC;
+	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
+	val = (unsigned long long) u * NSEC_PER_SEC;
 	do_div(val, mvpwm->clk_rate);
 	if (val < state->duty_cycle) {
 		state->period = 1;
@@ -725,8 +730,8 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	spin_lock_irqsave(&mvpwm->lock, flags);
 
-	writel_relaxed(on, mvebu_pwmreg_blink_on_duration(mvpwm));
-	writel_relaxed(off, mvebu_pwmreg_blink_off_duration(mvpwm));
+	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), on);
+	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), off);
 	if (state->enabled)
 		mvebu_gpio_blink(&mvchip->chip, pwm->hwpwm, 1);
 	else
@@ -751,10 +756,10 @@ static void __maybe_unused mvebu_pwm_suspend(struct mvebu_gpio_chip *mvchip)
 
 	regmap_read(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
 		    &mvpwm->blink_select);
-	mvpwm->blink_on_duration =
-		readl_relaxed(mvebu_pwmreg_blink_on_duration(mvpwm));
-	mvpwm->blink_off_duration =
-		readl_relaxed(mvebu_pwmreg_blink_off_duration(mvpwm));
+	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm),
+		    &mvpwm->blink_on_duration);
+	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm),
+		    &mvpwm->blink_off_duration);
 }
 
 static void __maybe_unused mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
@@ -763,10 +768,10 @@ static void __maybe_unused mvebu_pwm_resume(struct mvebu_gpio_chip *mvchip)
 
 	regmap_write(mvchip->regs, GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset,
 		     mvpwm->blink_select);
-	writel_relaxed(mvpwm->blink_on_duration,
-		       mvebu_pwmreg_blink_on_duration(mvpwm));
-	writel_relaxed(mvpwm->blink_off_duration,
-		       mvebu_pwmreg_blink_off_duration(mvpwm));
+	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm),
+		     mvpwm->blink_on_duration);
+	regmap_write(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm),
+		     mvpwm->blink_off_duration);
 }
 
 static int mvebu_pwm_probe(struct platform_device *pdev,
@@ -775,6 +780,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct mvebu_pwm *mvpwm;
+	void __iomem *base;
 	u32 set;
 
 	if (!of_device_is_compatible(mvchip->chip.of_node,
@@ -812,9 +818,14 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
 
-	mvpwm->membase = devm_platform_ioremap_resource_byname(pdev, "pwm");
-	if (IS_ERR(mvpwm->membase))
-		return PTR_ERR(mvpwm->membase);
+	base = devm_platform_ioremap_resource_byname(pdev, "pwm");
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
+					    &mvebu_gpio_regmap_config);
+	if (IS_ERR(mvpwm->regs))
+		return PTR_ERR(mvpwm->regs);
 
 	mvpwm->clk_rate = clk_get_rate(mvchip->clk);
 	if (!mvpwm->clk_rate) {
@@ -1021,13 +1032,6 @@ static int mvebu_gpio_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct regmap_config mvebu_gpio_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.fast_io = true,
-};
-
 static int mvebu_gpio_probe_raw(struct platform_device *pdev,
 				struct mvebu_gpio_chip *mvchip)
 {
-- 
2.29.2

