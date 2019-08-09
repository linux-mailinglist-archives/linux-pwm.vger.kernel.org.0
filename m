Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD02879F3
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 14:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406742AbfHIMbD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 08:31:03 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55208 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfHIMbD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 08:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565353848; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztdntlULi2//kmwN3M0R+/9utSFqgCJaLwbklJ839Ao=;
        b=CAz4OOgKJVf+UPDK6lli2TibjjWo0DNSbV3VQ7gvwNdk1X7UojAHWl8TTw4KRh9t9+PwN9
        k1ucz0KIABA4GqERveJ7SaNtdz6ns9ptR/Dsm8dzLVVVmfdUQukNzAsKXkSHAAZjC5VFH8
        N5dN5s9mzySwO2jI2CMY8+CIlh/tYCM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 2/7] pwm: jz4740: Use clocks from TCU driver
Date:   Fri,  9 Aug 2019 14:30:26 +0200
Message-Id: <20190809123031.24219-3-paul@crapouillou.net>
In-Reply-To: <20190809123031.24219-1-paul@crapouillou.net>
References: <20190809123031.24219-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The ingenic-timer "TCU" driver provides us with clocks, that can be
(un)gated, reparented or reclocked from devicetree, instead of having
these settings hardcoded in this driver.

While this driver is devicetree-compatible, it is never (as of now)
probed from devicetree, so this change does not introduce a ABI problem
with current devicetree files.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/pwm/Kconfig      |  1 +
 drivers/pwm/pwm-jz4740.c | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index cc4df0ec978a..d2557c6fcf65 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -225,6 +225,7 @@ config PWM_IMX_TPM
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
+	depends on COMMON_CLK
 	select MFD_SYSCON
 	help
 	  Generic PWM framework driver for Ingenic JZ47xx based
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 7aea5e0c6e18..6ec8794d3b99 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -20,7 +20,6 @@
 
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
-	struct clk *clk;
 	struct regmap *map;
 };
 
@@ -32,6 +31,9 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk;
+	char clk_name[16];
+	int ret;
 
 	/*
 	 * Timers 0 and 1 are used for system tasks, so they are unavailable
@@ -40,16 +42,29 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (pwm->hwpwm < 2)
 		return -EBUSY;
 
-	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
+	snprintf(clk_name, sizeof(clk_name), "timer%u", pwm->hwpwm);
+
+	clk = clk_get(chip->dev, clk_name);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		clk_put(clk);
+		return ret;
+	}
+
+	pwm_set_chip_data(pwm, clk);
 
 	return 0;
 }
 
 static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk = pwm_get_chip_data(pwm);
 
-	regmap_write(jz->map, TCU_REG_TSCR, BIT(pwm->hwpwm));
+	clk_disable_unprepare(clk);
+	clk_put(clk);
 }
 
 static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -93,16 +108,20 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    struct pwm_state *state)
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
+	struct clk *clk = pwm_get_chip_data(pwm),
+		   *parent_clk = clk_get_parent(clk);
+	unsigned long rate, period, duty;
 	unsigned long long tmp;
-	unsigned long period, duty;
 	unsigned int prescaler = 0;
 
-	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
+	rate = clk_get_rate(parent_clk);
+	tmp = (unsigned long long)rate * state->period;
 	do_div(tmp, 1000000000);
 	period = tmp;
 
 	while (period > 0xffff && prescaler < 6) {
 		period >>= 2;
+		rate >>= 2;
 		++prescaler;
 	}
 
@@ -122,10 +141,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
 
-	/* Set clock prescale */
-	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
-			   TCU_TCSR_PRESCALE_MASK,
-			   prescaler << TCU_TCSR_PRESCALE_LSB);
+	clk_set_rate(clk, rate);
 
 	/* Reset counter to 0 */
 	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
@@ -171,10 +187,6 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!jz4740)
 		return -ENOMEM;
 
-	jz4740->clk = devm_clk_get(&pdev->dev, "ext");
-	if (IS_ERR(jz4740->clk))
-		return PTR_ERR(jz4740->clk);
-
 	jz4740->map = device_node_to_regmap(dev->parent->of_node);
 	if (!jz4740->map) {
 		dev_err(dev, "regmap not found\n");
-- 
2.21.0.593.g511ec345e18

