Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB8F2CB5AF
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 08:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgLBHQj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 02:16:39 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:50279 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387604AbgLBHQj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 2 Dec 2020 02:16:39 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 481184407E8;
        Wed,  2 Dec 2020 09:15:56 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 4/6] gpio: mvebu: add pwm support for Armada 8K/7K
Date:   Wed,  2 Dec 2020 09:15:35 +0200
Message-Id: <28708be005a648fce31f2643c3897280507dc264.1606892239.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606892239.git.baruch@tkos.co.il>
References: <cover.1606892239.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use the pwm-offset DT property to store the location of PWM signal
duration registers.

Since we have more than two GPIO chips per system, we can't use the
alias id to differentiate between them. Use the offset value for that.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v3: Split mvebu_pwm_probe() move out of this patch into a separate fix
    (Andrew Lunn)
---
 drivers/gpio/gpio-mvebu.c | 101 +++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 33 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 672681a976f5..5cb8d1969eef 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -70,7 +70,12 @@
  */
 #define PWM_BLINK_ON_DURATION_OFF	0x0
 #define PWM_BLINK_OFF_DURATION_OFF	0x4
+#define PWM_BLINK_COUNTER_B_OFF		0x8
 
+/* Armada 8k variant gpios register offsets */
+#define AP80X_GPIO0_OFF_A8K		0x1040
+#define CP11X_GPIO0_OFF_A8K		0x100
+#define CP11X_GPIO1_OFF_A8K		0x140
 
 /* The MV78200 has per-CPU registers for edge mask and level mask */
 #define GPIO_EDGE_MASK_MV78200_OFF(cpu)	  ((cpu) ? 0x30 : 0x18)
@@ -93,6 +98,7 @@
 
 struct mvebu_pwm {
 	struct regmap		*regs;
+	u32			 offset;
 	unsigned long		 clk_rate;
 	struct gpio_desc	*gpiod;
 	struct pwm_chip		 chip;
@@ -283,12 +289,12 @@ mvebu_gpio_write_level_mask(struct mvebu_gpio_chip *mvchip, u32 val)
  */
 static unsigned int mvebu_pwmreg_blink_on_duration(struct mvebu_pwm *mvpwm)
 {
-	return PWM_BLINK_ON_DURATION_OFF;
+	return mvpwm->offset + PWM_BLINK_ON_DURATION_OFF;
 }
 
 static unsigned int mvebu_pwmreg_blink_off_duration(struct mvebu_pwm *mvpwm)
 {
-	return PWM_BLINK_OFF_DURATION_OFF;
+	return mvpwm->offset + PWM_BLINK_OFF_DURATION_OFF;
 }
 
 /*
@@ -781,51 +787,80 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct mvebu_pwm *mvpwm;
 	void __iomem *base;
+	u32 offset;
 	u32 set;
 
-	if (!of_device_is_compatible(mvchip->chip.of_node,
-				     "marvell,armada-370-gpio"))
-		return 0;
-
-	/*
-	 * There are only two sets of PWM configuration registers for
-	 * all the GPIO lines on those SoCs which this driver reserves
-	 * for the first two GPIO chips. So if the resource is missing
-	 * we can't treat it as an error.
-	 */
-	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
+	if (of_device_is_compatible(mvchip->chip.of_node,
+				    "marvell,armada-370-gpio")) {
+		/*
+		 * There are only two sets of PWM configuration registers for
+		 * all the GPIO lines on those SoCs which this driver reserves
+		 * for the first two GPIO chips. So if the resource is missing
+		 * we can't treat it as an error.
+		 */
+		if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
+			return 0;
+		offset = 0;
+	} else if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
+		int ret = of_property_read_u32(dev->of_node, "pwm-offset",
+					       &offset);
+		if (ret < 0)
+			return 0;
+	} else {
 		return 0;
+	}
 
 	if (IS_ERR(mvchip->clk))
 		return PTR_ERR(mvchip->clk);
 
-	/*
-	 * Use set A for lines of GPIO chip with id 0, B for GPIO chip
-	 * with id 1. Don't allow further GPIO chips to be used for PWM.
-	 */
-	if (id == 0)
-		set = 0;
-	else if (id == 1)
-		set = U32_MAX;
-	else
-		return -EINVAL;
-	regmap_write(mvchip->regs,
-		     GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset, set);
-
 	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
 	if (!mvpwm)
 		return -ENOMEM;
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
+	mvpwm->offset = offset;
+
+	if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
+		mvpwm->regs = mvchip->regs;
+
+		switch (mvchip->offset) {
+		case AP80X_GPIO0_OFF_A8K:
+		case CP11X_GPIO0_OFF_A8K:
+			/* Blink counter A */
+			set = 0;
+			break;
+		case CP11X_GPIO1_OFF_A8K:
+			/* Blink counter B */
+			set = U32_MAX;
+			mvpwm->offset += PWM_BLINK_COUNTER_B_OFF;
+			break;
+		default:
+			return -EINVAL;
+		}
+	} else {
+		base = devm_platform_ioremap_resource_byname(pdev, "pwm");
+		if (IS_ERR(base))
+			return PTR_ERR(base);
 
-	base = devm_platform_ioremap_resource_byname(pdev, "pwm");
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+		mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
+						    &mvebu_gpio_regmap_config);
+		if (IS_ERR(mvpwm->regs))
+			return PTR_ERR(mvpwm->regs);
 
-	mvpwm->regs = devm_regmap_init_mmio(&pdev->dev, base,
-					    &mvebu_gpio_regmap_config);
-	if (IS_ERR(mvpwm->regs))
-		return PTR_ERR(mvpwm->regs);
+		/*
+		 * Use set A for lines of GPIO chip with id 0, B for GPIO chip
+		 * with id 1. Don't allow further GPIO chips to be used for PWM.
+		 */
+		if (id == 0)
+			set = 0;
+		else if (id == 1)
+			set = U32_MAX;
+		else
+			return -EINVAL;
+	}
+
+	regmap_write(mvchip->regs,
+		     GPIO_BLINK_CNT_SELECT_OFF + mvchip->offset, set);
 
 	mvpwm->clk_rate = clk_get_rate(mvchip->clk);
 	if (!mvpwm->clk_rate) {
-- 
2.29.2

