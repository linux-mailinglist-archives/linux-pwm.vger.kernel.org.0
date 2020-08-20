Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABE124C81A
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 00:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgHTW4R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Aug 2020 18:56:17 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:53949 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgHTW4C (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Aug 2020 18:56:02 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id AD6071BF205;
        Thu, 20 Aug 2020 22:55:57 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 2/4] pwm: atmel-tcb: switch to new binding
Date:   Fri, 21 Aug 2020 00:55:44 +0200
Message-Id: <20200820225546.2246517-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
References: <20200820225546.2246517-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

The PWM is now a subnode of the used TCB. This is cleaner and it mainly
allows to stop wasting TCB channels when only 2 or 4 PWMs are used.

This also removes the atmel_tclib dependency

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/Kconfig         |   3 +-
 drivers/pwm/pwm-atmel-tcb.c | 241 ++++++++++++++++++++----------------
 2 files changed, 137 insertions(+), 107 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 7dbcf6973d33..15cea751bd85 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -75,7 +75,8 @@ config PWM_ATMEL_HLCDC_PWM
 
 config PWM_ATMEL_TCB
 	tristate "Atmel TC Block PWM support"
-	depends on ATMEL_TCLIB && OF
+	depends on OF
+	select REGMAP_MMIO
 	help
 	  Generic PWM framework driver for Atmel Timer Counter Block.
 
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 85c53701958c..82edb44fbbd8 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -16,13 +16,16 @@
 #include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 #include <soc/at91/atmel_tcb.h>
 
-#define NPWM	6
+#define NPWM	2
 
 #define ATMEL_TC_ACMR_MASK	(ATMEL_TC_ACPA | ATMEL_TC_ACPC |	\
 				 ATMEL_TC_AEEVT | ATMEL_TC_ASWTRG)
@@ -48,11 +51,17 @@ struct atmel_tcb_channel {
 struct atmel_tcb_pwm_chip {
 	struct pwm_chip chip;
 	spinlock_t lock;
-	struct atmel_tc *tc;
+	u8 channel;
+	u8 width;
+	struct regmap *regmap;
+	struct clk *clk;
+	struct clk *slow_clk;
 	struct atmel_tcb_pwm_device *pwms[NPWM];
-	struct atmel_tcb_channel bkup[NPWM / 2];
+	struct atmel_tcb_channel bkup;
 };
 
+const u8 atmel_tcb_divisors[] = { 2, 8, 32, 128, 0, };
+
 static inline struct atmel_tcb_pwm_chip *to_tcb_chip(struct pwm_chip *chip)
 {
 	return container_of(chip, struct atmel_tcb_pwm_chip, chip);
@@ -74,10 +83,6 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm;
-	struct atmel_tc *tc = tcbpwmc->tc;
-	void __iomem *regs = tc->regs;
-	unsigned group = pwm->hwpwm / 2;
-	unsigned index = pwm->hwpwm % 2;
 	unsigned cmr;
 	int ret;
 
@@ -85,7 +90,7 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 	if (!tcbpwm)
 		return -ENOMEM;
 
-	ret = clk_prepare_enable(tc->clk[group]);
+	ret = clk_prepare_enable(tcbpwmc->clk);
 	if (ret) {
 		devm_kfree(chip->dev, tcbpwm);
 		return ret;
@@ -98,28 +103,31 @@ static int atmel_tcb_pwm_request(struct pwm_chip *chip,
 	tcbpwm->div = 0;
 
 	spin_lock(&tcbpwmc->lock);
-	cmr = __raw_readl(regs + ATMEL_TC_REG(group, CMR));
+	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), &cmr);
 	/*
 	 * Get init config from Timer Counter registers if
 	 * Timer Counter is already configured as a PWM generator.
 	 */
 	if (cmr & ATMEL_TC_WAVE) {
-		if (index == 0)
-			tcbpwm->duty =
-				__raw_readl(regs + ATMEL_TC_REG(group, RA));
+		if (pwm->hwpwm == 0)
+			regmap_read(tcbpwmc->regmap,
+				    ATMEL_TC_REG(tcbpwmc->channel, RA),
+				    &tcbpwm->duty);
 		else
-			tcbpwm->duty =
-				__raw_readl(regs + ATMEL_TC_REG(group, RB));
+			regmap_read(tcbpwmc->regmap,
+				    ATMEL_TC_REG(tcbpwmc->channel, RB),
+				    &tcbpwm->duty);
 
 		tcbpwm->div = cmr & ATMEL_TC_TCCLKS;
-		tcbpwm->period = __raw_readl(regs + ATMEL_TC_REG(group, RC));
+		regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, RC),
+			    &tcbpwm->period);
 		cmr &= (ATMEL_TC_TCCLKS | ATMEL_TC_ACMR_MASK |
 			ATMEL_TC_BCMR_MASK);
 	} else
 		cmr = 0;
 
 	cmr |= ATMEL_TC_WAVE | ATMEL_TC_WAVESEL_UP_AUTO | ATMEL_TC_EEVT_XC0;
-	__raw_writel(cmr, regs + ATMEL_TC_REG(group, CMR));
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), cmr);
 	spin_unlock(&tcbpwmc->lock);
 
 	tcbpwmc->pwms[pwm->hwpwm] = tcbpwm;
@@ -131,9 +139,8 @@ static void atmel_tcb_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
-	struct atmel_tc *tc = tcbpwmc->tc;
 
-	clk_disable_unprepare(tc->clk[pwm->hwpwm / 2]);
+	clk_disable_unprepare(tcbpwmc->clk);
 	tcbpwmc->pwms[pwm->hwpwm] = NULL;
 	devm_kfree(chip->dev, tcbpwm);
 }
@@ -142,10 +149,6 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
-	struct atmel_tc *tc = tcbpwmc->tc;
-	void __iomem *regs = tc->regs;
-	unsigned group = pwm->hwpwm / 2;
-	unsigned index = pwm->hwpwm % 2;
 	unsigned cmr;
 	enum pwm_polarity polarity = tcbpwm->polarity;
 
@@ -161,10 +164,10 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 		polarity = !polarity;
 
 	spin_lock(&tcbpwmc->lock);
-	cmr = __raw_readl(regs + ATMEL_TC_REG(group, CMR));
+	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), &cmr);
 
 	/* flush old setting and set the new one */
-	if (index == 0) {
+	if (pwm->hwpwm == 0) {
 		cmr &= ~ATMEL_TC_ACMR_MASK;
 		if (polarity == PWM_POLARITY_INVERSED)
 			cmr |= ATMEL_TC_ASWTRG_CLEAR;
@@ -178,20 +181,22 @@ static void atmel_tcb_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 			cmr |= ATMEL_TC_BSWTRG_SET;
 	}
 
-	__raw_writel(cmr, regs + ATMEL_TC_REG(group, CMR));
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), cmr);
 
 	/*
 	 * Use software trigger to apply the new setting.
 	 * If both PWM devices in this group are disabled we stop the clock.
 	 */
 	if (!(cmr & (ATMEL_TC_ACPC | ATMEL_TC_BCPC))) {
-		__raw_writel(ATMEL_TC_SWTRG | ATMEL_TC_CLKDIS,
-			     regs + ATMEL_TC_REG(group, CCR));
-		tcbpwmc->bkup[group].enabled = 1;
+		regmap_write(tcbpwmc->regmap,
+			     ATMEL_TC_REG(tcbpwmc->channel, CCR),
+			     ATMEL_TC_SWTRG | ATMEL_TC_CLKDIS);
+		tcbpwmc->bkup.enabled = 1;
 	} else {
-		__raw_writel(ATMEL_TC_SWTRG, regs +
-			     ATMEL_TC_REG(group, CCR));
-		tcbpwmc->bkup[group].enabled = 0;
+		regmap_write(tcbpwmc->regmap,
+			     ATMEL_TC_REG(tcbpwmc->channel, CCR),
+			     ATMEL_TC_SWTRG);
+		tcbpwmc->bkup.enabled = 0;
 	}
 
 	spin_unlock(&tcbpwmc->lock);
@@ -201,10 +206,6 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
-	struct atmel_tc *tc = tcbpwmc->tc;
-	void __iomem *regs = tc->regs;
-	unsigned group = pwm->hwpwm / 2;
-	unsigned index = pwm->hwpwm % 2;
 	u32 cmr;
 	enum pwm_polarity polarity = tcbpwm->polarity;
 
@@ -220,12 +221,12 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		polarity = !polarity;
 
 	spin_lock(&tcbpwmc->lock);
-	cmr = __raw_readl(regs + ATMEL_TC_REG(group, CMR));
+	regmap_read(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), &cmr);
 
 	/* flush old setting and set the new one */
 	cmr &= ~ATMEL_TC_TCCLKS;
 
-	if (index == 0) {
+	if (pwm->hwpwm == 0) {
 		cmr &= ~ATMEL_TC_ACMR_MASK;
 
 		/* Set CMR flags according to given polarity */
@@ -248,7 +249,7 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	 * this config till next config call.
 	 */
 	if (tcbpwm->duty != tcbpwm->period && tcbpwm->duty > 0) {
-		if (index == 0) {
+		if (pwm->hwpwm == 0) {
 			if (polarity == PWM_POLARITY_INVERSED)
 				cmr |= ATMEL_TC_ACPA_SET | ATMEL_TC_ACPC_CLEAR;
 			else
@@ -263,19 +264,24 @@ static int atmel_tcb_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	cmr |= (tcbpwm->div & ATMEL_TC_TCCLKS);
 
-	__raw_writel(cmr, regs + ATMEL_TC_REG(group, CMR));
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CMR), cmr);
 
-	if (index == 0)
-		__raw_writel(tcbpwm->duty, regs + ATMEL_TC_REG(group, RA));
+	if (pwm->hwpwm == 0)
+		regmap_write(tcbpwmc->regmap,
+			     ATMEL_TC_REG(tcbpwmc->channel, RA),
+			     tcbpwm->duty);
 	else
-		__raw_writel(tcbpwm->duty, regs + ATMEL_TC_REG(group, RB));
+		regmap_write(tcbpwmc->regmap,
+			     ATMEL_TC_REG(tcbpwmc->channel, RB),
+			     tcbpwm->duty);
 
-	__raw_writel(tcbpwm->period, regs + ATMEL_TC_REG(group, RC));
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, RC),
+		     tcbpwm->period);
 
 	/* Use software trigger to apply the new setting */
-	__raw_writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
-		     regs + ATMEL_TC_REG(group, CCR));
-	tcbpwmc->bkup[group].enabled = 1;
+	regmap_write(tcbpwmc->regmap, ATMEL_TC_REG(tcbpwmc->channel, CCR),
+		     ATMEL_TC_SWTRG | ATMEL_TC_CLKEN);
+	tcbpwmc->bkup.enabled = 1;
 	spin_unlock(&tcbpwmc->lock);
 	return 0;
 }
@@ -285,15 +291,12 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct atmel_tcb_pwm_chip *tcbpwmc = to_tcb_chip(chip);
 	struct atmel_tcb_pwm_device *tcbpwm = pwm_get_chip_data(pwm);
-	unsigned group = pwm->hwpwm / 2;
-	unsigned index = pwm->hwpwm % 2;
 	struct atmel_tcb_pwm_device *atcbpwm = NULL;
-	struct atmel_tc *tc = tcbpwmc->tc;
 	int i;
 	int slowclk = 0;
 	unsigned period;
 	unsigned duty;
-	unsigned rate = clk_get_rate(tc->clk[group]);
+	unsigned rate = clk_get_rate(tcbpwmc->clk);
 	unsigned long long min;
 	unsigned long long max;
 
@@ -301,13 +304,13 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Find best clk divisor:
 	 * the smallest divisor which can fulfill the period_ns requirements.
 	 */
-	for (i = 0; i < 5; ++i) {
-		if (atmel_tc_divisors[i] == 0) {
+	for (i = 0; i < ARRAY_SIZE(atmel_tcb_divisors); ++i) {
+		if (atmel_tcb_divisors[i] == 0) {
 			slowclk = i;
 			continue;
 		}
-		min = div_u64((u64)NSEC_PER_SEC * atmel_tc_divisors[i], rate);
-		max = min << tc->tcb_config->counter_width;
+		min = div_u64((u64)NSEC_PER_SEC * atmel_tcb_divisors[i], rate);
+		max = min << tcbpwmc->width;
 		if (max >= period_ns)
 			break;
 	}
@@ -316,11 +319,11 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * If none of the divisor are small enough to represent period_ns
 	 * take slow clock (32KHz).
 	 */
-	if (i == 5) {
+	if (i == ARRAY_SIZE(atmel_tcb_divisors)) {
 		i = slowclk;
-		rate = clk_get_rate(tc->slow_clk);
+		rate = clk_get_rate(tcbpwmc->slow_clk);
 		min = div_u64(NSEC_PER_SEC, rate);
-		max = min << tc->tcb_config->counter_width;
+		max = min << tcbpwmc->width;
 
 		/* If period is too big return ERANGE error */
 		if (max < period_ns)
@@ -330,17 +333,13 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = div_u64(duty_ns, min);
 	period = div_u64(period_ns, min);
 
-	if (index == 0)
-		atcbpwm = tcbpwmc->pwms[pwm->hwpwm + 1];
+	if (pwm->hwpwm == 0)
+		atcbpwm = tcbpwmc->pwms[1];
 	else
-		atcbpwm = tcbpwmc->pwms[pwm->hwpwm - 1];
+		atcbpwm = tcbpwmc->pwms[0];
 
 	/*
-	 * PWM devices provided by TCB driver are grouped by 2:
-	 * - group 0: PWM 0 & 1
-	 * - group 1: PWM 2 & 3
-	 * - group 2: PWM 4 & 5
-	 *
+	 * PWM devices provided by the TCB driver are grouped by 2.
 	 * PWM devices in a given group must be configured with the
 	 * same period_ns.
 	 *
@@ -376,32 +375,63 @@ static const struct pwm_ops atmel_tcb_pwm_ops = {
 	.owner = THIS_MODULE,
 };
 
+static struct atmel_tcb_config tcb_rm9200_config = {
+	.counter_width = 16,
+};
+
+static struct atmel_tcb_config tcb_sam9x5_config = {
+	.counter_width = 32,
+};
+
+static const struct of_device_id atmel_tcb_of_match[] = {
+	{ .compatible = "atmel,at91rm9200-tcb", .data = &tcb_rm9200_config, },
+	{ .compatible = "atmel,at91sam9x5-tcb", .data = &tcb_sam9x5_config, },
+	{ /* sentinel */ }
+};
+
 static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct atmel_tcb_pwm_chip *tcbpwm;
+	const struct atmel_tcb_config *config;
 	struct device_node *np = pdev->dev.of_node;
-	struct atmel_tc *tc;
+	struct regmap *regmap;
+	struct clk *clk;
+	struct clk *slow_clk;
+	char clk_name[] = "t0_clk";
 	int err;
-	int tcblock;
+	int channel;
 
-	err = of_property_read_u32(np, "tc-block", &tcblock);
+	err = of_property_read_u32(np, "reg", &channel);
 	if (err < 0) {
 		dev_err(&pdev->dev,
-			"failed to get Timer Counter Block number from device tree (error: %d)\n",
+			"failed to get Timer Counter Block channel from device tree (error: %d)\n",
 			err);
 		return err;
 	}
 
-	tc = atmel_tc_alloc(tcblock);
-	if (tc == NULL) {
-		dev_err(&pdev->dev, "failed to allocate Timer Counter Block\n");
-		return -ENOMEM;
-	}
+	regmap = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	slow_clk = of_clk_get_by_name(np->parent, "slow_clk");
+	if (IS_ERR(slow_clk))
+		return PTR_ERR(slow_clk);
+
+	clk_name[1] += channel;
+	clk = of_clk_get_by_name(np->parent, clk_name);
+	if (IS_ERR(clk))
+		clk = of_clk_get_by_name(np->parent, "t0_clk");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	match = of_match_node(atmel_tcb_of_match, np->parent);
+	config = match->data;
 
 	tcbpwm = devm_kzalloc(&pdev->dev, sizeof(*tcbpwm), GFP_KERNEL);
 	if (tcbpwm == NULL) {
 		err = -ENOMEM;
-		goto err_free_tc;
+		goto err_slow_clk;
 	}
 
 	tcbpwm->chip.dev = &pdev->dev;
@@ -410,11 +440,15 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	tcbpwm->chip.of_pwm_n_cells = 3;
 	tcbpwm->chip.base = -1;
 	tcbpwm->chip.npwm = NPWM;
-	tcbpwm->tc = tc;
+	tcbpwm->channel = channel;
+	tcbpwm->regmap = regmap;
+	tcbpwm->clk = clk;
+	tcbpwm->slow_clk = slow_clk;
+	tcbpwm->width = config->counter_width;
 
-	err = clk_prepare_enable(tc->slow_clk);
+	err = clk_prepare_enable(slow_clk);
 	if (err)
-		goto err_free_tc;
+		goto err_slow_clk;
 
 	spin_lock_init(&tcbpwm->lock);
 
@@ -427,10 +461,10 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_disable_clk:
-	clk_disable_unprepare(tcbpwm->tc->slow_clk);
+	clk_disable_unprepare(tcbpwm->slow_clk);
 
-err_free_tc:
-	atmel_tc_free(tc);
+err_slow_clk:
+	clk_put(slow_clk);
 
 	return err;
 }
@@ -440,14 +474,14 @@ static int atmel_tcb_pwm_remove(struct platform_device *pdev)
 	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
 	int err;
 
-	clk_disable_unprepare(tcbpwm->tc->slow_clk);
+	clk_disable_unprepare(tcbpwm->slow_clk);
+	clk_put(tcbpwm->slow_clk);
+	clk_put(tcbpwm->clk);
 
 	err = pwmchip_remove(&tcbpwm->chip);
 	if (err < 0)
 		return err;
 
-	atmel_tc_free(tcbpwm->tc);
-
 	return 0;
 }
 
@@ -461,38 +495,33 @@ MODULE_DEVICE_TABLE(of, atmel_tcb_pwm_dt_ids);
 static int atmel_tcb_pwm_suspend(struct device *dev)
 {
 	struct atmel_tcb_pwm_chip *tcbpwm = dev_get_drvdata(dev);
-	void __iomem *base = tcbpwm->tc->regs;
-	int i;
+	struct atmel_tcb_channel *chan = &tcbpwm->bkup;
+	unsigned int channel = tcbpwm->channel;
 
-	for (i = 0; i < (NPWM / 2); i++) {
-		struct atmel_tcb_channel *chan = &tcbpwm->bkup[i];
+	regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, CMR), &chan->cmr);
+	regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, RA), &chan->ra);
+	regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, RB), &chan->rb);
+	regmap_read(tcbpwm->regmap, ATMEL_TC_REG(channel, RC), &chan->rc);
 
-		chan->cmr = readl(base + ATMEL_TC_REG(i, CMR));
-		chan->ra = readl(base + ATMEL_TC_REG(i, RA));
-		chan->rb = readl(base + ATMEL_TC_REG(i, RB));
-		chan->rc = readl(base + ATMEL_TC_REG(i, RC));
-	}
 	return 0;
 }
 
 static int atmel_tcb_pwm_resume(struct device *dev)
 {
 	struct atmel_tcb_pwm_chip *tcbpwm = dev_get_drvdata(dev);
-	void __iomem *base = tcbpwm->tc->regs;
-	int i;
+	struct atmel_tcb_channel *chan = &tcbpwm->bkup;
+	unsigned int channel = tcbpwm->channel;
 
-	for (i = 0; i < (NPWM / 2); i++) {
-		struct atmel_tcb_channel *chan = &tcbpwm->bkup[i];
+	regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, CMR), chan->cmr);
+	regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, RA), chan->ra);
+	regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, RB), chan->rb);
+	regmap_write(tcbpwm->regmap, ATMEL_TC_REG(channel, RC), chan->rc);
+
+	if (chan->enabled)
+		regmap_write(tcbpwm->regmap,
+			     ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
+			     ATMEL_TC_REG(channel, CCR));
 
-		writel(chan->cmr, base + ATMEL_TC_REG(i, CMR));
-		writel(chan->ra, base + ATMEL_TC_REG(i, RA));
-		writel(chan->rb, base + ATMEL_TC_REG(i, RB));
-		writel(chan->rc, base + ATMEL_TC_REG(i, RC));
-		if (chan->enabled) {
-			writel(ATMEL_TC_CLKEN | ATMEL_TC_SWTRG,
-				base + ATMEL_TC_REG(i, CCR));
-		}
-	}
 	return 0;
 }
 #endif
-- 
2.26.2

