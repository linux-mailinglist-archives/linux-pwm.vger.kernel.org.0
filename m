Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4389218F6C0
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 15:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgCWOYn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 10:24:43 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:44248 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgCWOYm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 10:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1584973468; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yFhcprmOzxpMiwoYxds7swTiLYTsus746ycaH+2xYtY=;
        b=h8GbycEh2bYf6uy0w95JLKw1D9lRsduBxc6a6nXuGNYY8FexqxSoj+La0NB/eeOU5oYWeg
        NMFtB7dBDG7gEfUUvE+O8Qhk9SguaS+ceOxRxLW+/CedHSVJ8S58Kf5GXf7+OI55JyWG3Z
        NiPISsMel+mMv/BBxuwHluz4cr8Aa6g=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v4 3/4] pwm: jz4740: Obtain regmap from parent node
Date:   Mon, 23 Mar 2020 15:24:20 +0100
Message-Id: <20200323142421.42817-3-paul@crapouillou.net>
In-Reply-To: <20200323142421.42817-1-paul@crapouillou.net>
References: <20200323142421.42817-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The TCU registers are shared between a handful of drivers, accessing
them through the same regmap.

While this driver is devicetree-compatible, it is never (as of now)
probed from devicetree, so this change does not introduce a ABI problem
with current devicetree files.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: This patch is now after the patch introducing TCU clocks, so the code
    	changed a bit.
    v3-v4: No change

 drivers/pwm/Kconfig      |  1 +
 drivers/pwm/pwm-jz4740.c | 67 ++++++++++++++++++++++++++--------------
 2 files changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 69f00eb9bd36..82fb4d39ced7 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -226,6 +226,7 @@ config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
 	depends on COMMON_CLK
+	select MFD_SYSCON
 	help
 	  Generic PWM framework driver for Ingenic JZ47xx based
 	  machines.
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 0b41baf40e4a..df6906c51b8d 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -13,17 +13,19 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/kernel.h>
+#include <linux/mfd/ingenic-tcu.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
-
-#include <asm/mach-jz4740/timer.h>
+#include <linux/regmap.h>
 
 #define NUM_PWM 8
 
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
+	struct regmap *map;
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
@@ -75,36 +77,39 @@ static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+
+	/* Enable PWM output */
+	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
+			   TCU_TCSR_PWM_EN, TCU_TCSR_PWM_EN);
 
-	ctrl |= JZ_TIMER_CTRL_PWM_ENABLE;
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
-	jz4740_timer_enable(pwm->hwpwm);
+	/* Start counter */
+	regmap_write(jz->map, TCU_REG_TESR, BIT(pwm->hwpwm));
 
 	return 0;
 }
 
 static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->hwpwm);
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
 
 	/*
 	 * Set duty > period. This trick allows the TCU channels in TCU2 mode to
 	 * properly return to their init level.
 	 */
-	jz4740_timer_set_duty(pwm->hwpwm, 0xffff);
-	jz4740_timer_set_period(pwm->hwpwm, 0x0);
+	regmap_write(jz->map, TCU_REG_TDHRc(pwm->hwpwm), 0xffff);
+	regmap_write(jz->map, TCU_REG_TDFRc(pwm->hwpwm), 0x0);
 
 	/*
 	 * Disable PWM output.
 	 * In TCU2 mode (channel 1/2 on JZ4750+), this must be done before the
 	 * counter is stopped, while in TCU1 mode the order does not matter.
 	 */
-	ctrl &= ~JZ_TIMER_CTRL_PWM_ENABLE;
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+	regmap_update_bits(jz->map, TCU_REG_TCSRc(pwm->hwpwm),
+			   TCU_TCSR_PWM_EN, 0);
 
 	/* Stop counter */
-	jz4740_timer_disable(pwm->hwpwm);
+	regmap_write(jz->map, TCU_REG_TECR, BIT(pwm->hwpwm));
 }
 
 static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -114,7 +119,6 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct clk *clk = pwm_get_chip_data(pwm);
 	unsigned long long tmp = 0xffffull * NSEC_PER_SEC;
 	unsigned long period, duty;
-	uint16_t ctrl;
 	long rate;
 	int err;
 
@@ -162,24 +166,32 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return err;
 	}
 
-	jz4740_timer_set_count(pwm->hwpwm, 0);
-	jz4740_timer_set_duty(pwm->hwpwm, duty);
-	jz4740_timer_set_period(pwm->hwpwm, period);
+	/* Reset counter to 0 */
+	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
+
+	/* Set duty */
+	regmap_write(jz4740->map, TCU_REG_TDHRc(pwm->hwpwm), duty);
 
-	ctrl = jz4740_timer_get_ctrl(pwm->hwpwm);
-	ctrl |= JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
+	/* Set period */
+	regmap_write(jz4740->map, TCU_REG_TDFRc(pwm->hwpwm), period);
 
+	/* Set abrupt shutdown */
+	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
+
+	/* Set polarity */
 	switch (state->polarity) {
 	case PWM_POLARITY_NORMAL:
-		ctrl &= ~JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
+		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+				   TCU_TCSR_PWM_INITL_HIGH, 0);
 		break;
 	case PWM_POLARITY_INVERSED:
-		ctrl |= JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
+		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
+				   TCU_TCSR_PWM_INITL_HIGH,
+				   TCU_TCSR_PWM_INITL_HIGH);
 		break;
 	}
 
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
-
 	if (state->enabled)
 		jz4740_pwm_enable(chip, pwm);
 
@@ -196,12 +208,19 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct jz4740_pwm_chip *jz4740;
+	struct device *dev = &pdev->dev;
 
-	jz4740 = devm_kzalloc(&pdev->dev, sizeof(*jz4740), GFP_KERNEL);
+	jz4740 = devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
 	if (!jz4740)
 		return -ENOMEM;
 
-	jz4740->chip.dev = &pdev->dev;
+	jz4740->map = device_node_to_regmap(dev->parent->of_node);
+	if (!jz4740->map) {
+		dev_err(dev, "regmap not found\n");
+		return -EINVAL;
+	}
+
+	jz4740->chip.dev = dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
 	jz4740->chip.npwm = NUM_PWM;
 	jz4740->chip.base = -1;
-- 
2.25.1

