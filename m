Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B373FF46F
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Nov 2019 18:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfKPRmz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 16 Nov 2019 12:42:55 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40058 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfKPRmz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 16 Nov 2019 12:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1573925779; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UZyanXzXls4c19uG65qfb6hEzWSLmlkAYeotsvvQuKU=;
        b=W/j+ivnvYfLvDfeciI3NN6+1V8w4+JO5y6xgM2xqPomEqohdZRJfftPftEaj9m+8XU5xUL
        t7oz4ukRliqPyfSsbRy6moh24P/vrb5Qjhx+nuPFRyFRyQmxWQj/wq3kyUzfDvzfvlwRWC
        6SDdGd31vrY/Pk4UM09pwvgophh8euA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 1/3] pwm: jz4740: Use clocks from TCU driver
Date:   Sat, 16 Nov 2019 18:36:11 +0100
Message-Id: <20191116173613.72647-2-paul@crapouillou.net>
In-Reply-To: <20191116173613.72647-1-paul@crapouillou.net>
References: <20191116173613.72647-1-paul@crapouillou.net>
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

Notes:
    v2: This patch is now before the patch introducing regmap, so the code
        has changed a bit.

 drivers/pwm/Kconfig      |  1 +
 drivers/pwm/pwm-jz4740.c | 45 ++++++++++++++++++++++++++++------------
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index e3a2518503ed..e998e5cb01b0 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -225,6 +225,7 @@ config PWM_IMX_TPM
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
+	depends on COMMON_CLK
 	help
 	  Generic PWM framework driver for Ingenic JZ47xx based
 	  machines.
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 9d78cc21cb12..fd83644f9323 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -24,7 +24,6 @@
 
 struct jz4740_pwm_chip {
 	struct pwm_chip chip;
-	struct clk *clk;
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
@@ -34,6 +33,11 @@ static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 
 static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct jz4740_pwm_chip *jz = to_jz4740(chip);
+	struct clk *clk;
+	char clk_name[16];
+	int ret;
+
 	/*
 	 * Timers 0 and 1 are used for system tasks, so they are unavailable
 	 * for use as PWMs.
@@ -41,16 +45,31 @@ static int jz4740_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (pwm->hwpwm < 2)
 		return -EBUSY;
 
-	jz4740_timer_start(pwm->hwpwm);
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
+	struct clk *clk = pwm_get_chip_data(pwm);
+
 	jz4740_timer_set_ctrl(pwm->hwpwm, 0);
 
-	jz4740_timer_stop(pwm->hwpwm);
+	clk_disable_unprepare(clk);
+	clk_put(clk);
 }
 
 static int jz4740_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -91,17 +110,21 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
+	struct clk *clk = pwm_get_chip_data(pwm),
+		   *parent_clk = clk_get_parent(clk);
+	unsigned long rate, period, duty;
 	unsigned long long tmp;
-	unsigned long period, duty;
 	unsigned int prescaler = 0;
 	uint16_t ctrl;
 
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
 
@@ -117,14 +140,14 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	jz4740_pwm_disable(chip, pwm);
 
+	clk_set_rate(clk, rate);
+
 	jz4740_timer_set_count(pwm->hwpwm, 0);
 	jz4740_timer_set_duty(pwm->hwpwm, duty);
 	jz4740_timer_set_period(pwm->hwpwm, period);
 
-	ctrl = JZ_TIMER_CTRL_PRESCALER(prescaler) | JZ_TIMER_CTRL_SRC_EXT |
-		JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
-
-	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+	ctrl = jz4740_timer_get_ctrl(pwm->hwpwm);
+	ctrl |= JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
 
 	switch (state->polarity) {
 	case PWM_POLARITY_NORMAL:
@@ -158,10 +181,6 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!jz4740)
 		return -ENOMEM;
 
-	jz4740->clk = devm_clk_get(&pdev->dev, "ext");
-	if (IS_ERR(jz4740->clk))
-		return PTR_ERR(jz4740->clk);
-
 	jz4740->chip.dev = &pdev->dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
 	jz4740->chip.npwm = NUM_PWM;
-- 
2.24.0

