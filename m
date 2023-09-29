Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35807B37C3
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbjI2QTe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjI2QTd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03BB199
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD6-0007pu-KR; Fri, 29 Sep 2023 18:19:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD6-009r5x-7a; Fri, 29 Sep 2023 18:19:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-00616P-US; Fri, 29 Sep 2023 18:19:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 10/11] pwm: samsung: Consistently use the same name for driver data
Date:   Fri, 29 Sep 2023 18:19:17 +0200
Message-Id: <20230929161918.2410424-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11554; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fvMmapQpvcgi3G1vUj/8AwqFDd99etIhH4g2QOykLb8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFvj/gbWXEKrYLjF8TTiGERGR7LleEdpKPyJ21 GR70VSC7PeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRb4/wAKCRCPgPtYfRL+ TmwzB/9oYTszR+/WhQ6Z/EgXPHaDf4zLm5s3RpnTocJ3RPgyA3oVnzb4sMX1bIib4JO36SQrOxZ zBrbUm6RoWmIqqY+fve1dJ9f434Y5NEGRM/ctOzOAw2Z7pcwwc7MEmLCaFREZujHDV8eo3hKj/V xjBU7LUzRUIp+UTCzzTUe/4iX4j9FLKA4ek1qB9aSn45OzfB2xCqU+cYNDfJuqtJpnP7qK+X7bE 1fA6MRQrvfOa0HQRhqmwfgkG2oqvFuLAeJHERYZRJqOWj2YNXpMQCq8FfCP5X/knSf3YOYouMcJ DQ1kYMm75NEgwj5zXnwE7tKR00blKodiqt06WT05zFm6NOhK
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver uses mostly "chip" to name samsung_pwm_chip pointers:

$ git grep -Pho 'samsung_pwm_chip \*[a-zA-Z0-9_]+(*nla:[a-zA-Z0-9_(])' v6.5-rc1 -- drivers/pwm/pwm-samsung.c | sort | uniq -c
     10 samsung_pwm_chip *chip
      6 samsung_pwm_chip *our_chip
      1 samsung_pwm_chip *pwm

However "chip" is supposed to be used for struct pwm_chip pointers and
"pwm" for struct pwm_device pointers. So consistently use "our_chip".

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 130 +++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index e8828f57ab15..8d13a05d8d12 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -117,21 +117,21 @@ static inline unsigned int to_tcon_channel(unsigned int channel)
 	return (channel == 0) ? 0 : (channel + 1);
 }
 
-static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
+static void __pwm_samsung_manual_update(struct samsung_pwm_chip *our_chip,
 				      struct pwm_device *pwm)
 {
 	unsigned int tcon_chan = to_tcon_channel(pwm->hwpwm);
 	u32 tcon;
 
-	tcon = readl(chip->base + REG_TCON);
+	tcon = readl(our_chip->base + REG_TCON);
 	tcon |= TCON_MANUALUPDATE(tcon_chan);
-	writel(tcon, chip->base + REG_TCON);
+	writel(tcon, our_chip->base + REG_TCON);
 
 	tcon &= ~TCON_MANUALUPDATE(tcon_chan);
-	writel(tcon, chip->base + REG_TCON);
+	writel(tcon, our_chip->base + REG_TCON);
 }
 
-static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
+static void pwm_samsung_set_divisor(struct samsung_pwm_chip *our_chip,
 				    unsigned int channel, u8 divisor)
 {
 	u8 shift = TCFG1_SHIFT(channel);
@@ -139,39 +139,39 @@ static void pwm_samsung_set_divisor(struct samsung_pwm_chip *pwm,
 	u32 reg;
 	u8 bits;
 
-	bits = (fls(divisor) - 1) - pwm->variant.div_base;
+	bits = (fls(divisor) - 1) - our_chip->variant.div_base;
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	reg = readl(pwm->base + REG_TCFG1);
+	reg = readl(our_chip->base + REG_TCFG1);
 	reg &= ~(TCFG1_MUX_MASK << shift);
 	reg |= bits << shift;
-	writel(reg, pwm->base + REG_TCFG1);
+	writel(reg, our_chip->base + REG_TCFG1);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
-static int pwm_samsung_is_tdiv(struct samsung_pwm_chip *chip, unsigned int chan)
+static int pwm_samsung_is_tdiv(struct samsung_pwm_chip *our_chip, unsigned int chan)
 {
-	struct samsung_pwm_variant *variant = &chip->variant;
+	struct samsung_pwm_variant *variant = &our_chip->variant;
 	u32 reg;
 
-	reg = readl(chip->base + REG_TCFG1);
+	reg = readl(our_chip->base + REG_TCFG1);
 	reg >>= TCFG1_SHIFT(chan);
 	reg &= TCFG1_MUX_MASK;
 
 	return (BIT(reg) & variant->tclk_mask) == 0;
 }
 
-static unsigned long pwm_samsung_get_tin_rate(struct samsung_pwm_chip *chip,
+static unsigned long pwm_samsung_get_tin_rate(struct samsung_pwm_chip *our_chip,
 					      unsigned int chan)
 {
 	unsigned long rate;
 	u32 reg;
 
-	rate = clk_get_rate(chip->base_clk);
+	rate = clk_get_rate(our_chip->base_clk);
 
-	reg = readl(chip->base + REG_TCFG0);
+	reg = readl(our_chip->base + REG_TCFG0);
 	if (chan >= 2)
 		reg >>= TCFG0_PRESCALER1_SHIFT;
 	reg &= TCFG0_PRESCALER_MASK;
@@ -179,28 +179,28 @@ static unsigned long pwm_samsung_get_tin_rate(struct samsung_pwm_chip *chip,
 	return rate / (reg + 1);
 }
 
-static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *chip,
+static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *our_chip,
 					  unsigned int chan, unsigned long freq)
 {
-	struct samsung_pwm_variant *variant = &chip->variant;
+	struct samsung_pwm_variant *variant = &our_chip->variant;
 	unsigned long rate;
 	struct clk *clk;
 	u8 div;
 
-	if (!pwm_samsung_is_tdiv(chip, chan)) {
-		clk = (chan < 2) ? chip->tclk0 : chip->tclk1;
+	if (!pwm_samsung_is_tdiv(our_chip, chan)) {
+		clk = (chan < 2) ? our_chip->tclk0 : our_chip->tclk1;
 		if (!IS_ERR(clk)) {
 			rate = clk_get_rate(clk);
 			if (rate)
 				return rate;
 		}
 
-		dev_warn(chip->chip.dev,
+		dev_warn(our_chip->chip.dev,
 			"tclk of PWM %d is inoperational, using tdiv\n", chan);
 	}
 
-	rate = pwm_samsung_get_tin_rate(chip, chan);
-	dev_dbg(chip->chip.dev, "tin parent at %lu\n", rate);
+	rate = pwm_samsung_get_tin_rate(our_chip, chan);
+	dev_dbg(our_chip->chip.dev, "tin parent at %lu\n", rate);
 
 	/*
 	 * Compare minimum PWM frequency that can be achieved with possible
@@ -220,7 +220,7 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *chip,
 		div = variant->div_base;
 	}
 
-	pwm_samsung_set_divisor(chip, chan, BIT(div));
+	pwm_samsung_set_divisor(our_chip, chan, BIT(div));
 
 	return rate >> div;
 }
@@ -302,14 +302,14 @@ static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
-static void pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
+static void pwm_samsung_manual_update(struct samsung_pwm_chip *our_chip,
 				      struct pwm_device *pwm)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	__pwm_samsung_manual_update(chip, pwm);
+	__pwm_samsung_manual_update(our_chip, pwm);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
@@ -393,7 +393,7 @@ static int pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return __pwm_samsung_config(chip, pwm, duty_ns, period_ns, false);
 }
 
-static void pwm_samsung_set_invert(struct samsung_pwm_chip *chip,
+static void pwm_samsung_set_invert(struct samsung_pwm_chip *our_chip,
 				   unsigned int channel, bool invert)
 {
 	unsigned int tcon_chan = to_tcon_channel(channel);
@@ -402,17 +402,17 @@ static void pwm_samsung_set_invert(struct samsung_pwm_chip *chip,
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	tcon = readl(chip->base + REG_TCON);
+	tcon = readl(our_chip->base + REG_TCON);
 
 	if (invert) {
-		chip->inverter_mask |= BIT(channel);
+		our_chip->inverter_mask |= BIT(channel);
 		tcon |= TCON_INVERT(tcon_chan);
 	} else {
-		chip->inverter_mask &= ~BIT(channel);
+		our_chip->inverter_mask &= ~BIT(channel);
 		tcon &= ~TCON_INVERT(tcon_chan);
 	}
 
-	writel(tcon, chip->base + REG_TCON);
+	writel(tcon, our_chip->base + REG_TCON);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
@@ -517,9 +517,9 @@ static const struct of_device_id samsung_pwm_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 
-static int pwm_samsung_parse_dt(struct samsung_pwm_chip *chip)
+static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 {
-	struct device_node *np = chip->chip.dev->of_node;
+	struct device_node *np = our_chip->chip.dev->of_node;
 	const struct of_device_id *match;
 	struct property *prop;
 	const __be32 *cur;
@@ -529,22 +529,22 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *chip)
 	if (!match)
 		return -ENODEV;
 
-	memcpy(&chip->variant, match->data, sizeof(chip->variant));
+	memcpy(&our_chip->variant, match->data, sizeof(our_chip->variant));
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
-			dev_err(chip->chip.dev,
+			dev_err(our_chip->chip.dev,
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
 								__func__);
 			continue;
 		}
-		chip->variant.output_mask |= BIT(val);
+		our_chip->variant.output_mask |= BIT(val);
 	}
 
 	return 0;
 }
 #else
-static int pwm_samsung_parse_dt(struct samsung_pwm_chip *chip)
+static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 {
 	return -ENODEV;
 }
@@ -553,21 +553,21 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *chip)
 static int pwm_samsung_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct samsung_pwm_chip *chip;
+	struct samsung_pwm_chip *our_chip;
 	unsigned int chan;
 	int ret;
 
-	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
+	our_chip = devm_kzalloc(&pdev->dev, sizeof(*our_chip), GFP_KERNEL);
+	if (our_chip == NULL)
 		return -ENOMEM;
 
-	chip->chip.dev = &pdev->dev;
-	chip->chip.ops = &pwm_samsung_ops;
-	chip->chip.npwm = SAMSUNG_PWM_NUM;
-	chip->inverter_mask = BIT(SAMSUNG_PWM_NUM) - 1;
+	our_chip->chip.dev = &pdev->dev;
+	our_chip->chip.ops = &pwm_samsung_ops;
+	our_chip->chip.npwm = SAMSUNG_PWM_NUM;
+	our_chip->inverter_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
-		ret = pwm_samsung_parse_dt(chip);
+		ret = pwm_samsung_parse_dt(our_chip);
 		if (ret)
 			return ret;
 	} else {
@@ -576,58 +576,58 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
-		memcpy(&chip->variant, pdev->dev.platform_data,
-							sizeof(chip->variant));
+		memcpy(&our_chip->variant, pdev->dev.platform_data,
+							sizeof(our_chip->variant));
 	}
 
-	chip->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(chip->base))
-		return PTR_ERR(chip->base);
+	our_chip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(our_chip->base))
+		return PTR_ERR(our_chip->base);
 
-	chip->base_clk = devm_clk_get(&pdev->dev, "timers");
-	if (IS_ERR(chip->base_clk)) {
+	our_chip->base_clk = devm_clk_get(&pdev->dev, "timers");
+	if (IS_ERR(our_chip->base_clk)) {
 		dev_err(dev, "failed to get timer base clk\n");
-		return PTR_ERR(chip->base_clk);
+		return PTR_ERR(our_chip->base_clk);
 	}
 
-	ret = clk_prepare_enable(chip->base_clk);
+	ret = clk_prepare_enable(our_chip->base_clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable base clock\n");
 		return ret;
 	}
 
 	for (chan = 0; chan < SAMSUNG_PWM_NUM; ++chan)
-		if (chip->variant.output_mask & BIT(chan))
-			pwm_samsung_set_invert(chip, chan, true);
+		if (our_chip->variant.output_mask & BIT(chan))
+			pwm_samsung_set_invert(our_chip, chan, true);
 
 	/* Following clocks are optional. */
-	chip->tclk0 = devm_clk_get(&pdev->dev, "pwm-tclk0");
-	chip->tclk1 = devm_clk_get(&pdev->dev, "pwm-tclk1");
+	our_chip->tclk0 = devm_clk_get(&pdev->dev, "pwm-tclk0");
+	our_chip->tclk1 = devm_clk_get(&pdev->dev, "pwm-tclk1");
 
-	platform_set_drvdata(pdev, chip);
+	platform_set_drvdata(pdev, our_chip);
 
-	ret = pwmchip_add(&chip->chip);
+	ret = pwmchip_add(&our_chip->chip);
 	if (ret < 0) {
 		dev_err(dev, "failed to register PWM chip\n");
-		clk_disable_unprepare(chip->base_clk);
+		clk_disable_unprepare(our_chip->base_clk);
 		return ret;
 	}
 
 	dev_dbg(dev, "base_clk at %lu, tclk0 at %lu, tclk1 at %lu\n",
-		clk_get_rate(chip->base_clk),
-		!IS_ERR(chip->tclk0) ? clk_get_rate(chip->tclk0) : 0,
-		!IS_ERR(chip->tclk1) ? clk_get_rate(chip->tclk1) : 0);
+		clk_get_rate(our_chip->base_clk),
+		!IS_ERR(our_chip->tclk0) ? clk_get_rate(our_chip->tclk0) : 0,
+		!IS_ERR(our_chip->tclk1) ? clk_get_rate(our_chip->tclk1) : 0);
 
 	return 0;
 }
 
 static void pwm_samsung_remove(struct platform_device *pdev)
 {
-	struct samsung_pwm_chip *chip = platform_get_drvdata(pdev);
+	struct samsung_pwm_chip *our_chip = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&chip->chip);
+	pwmchip_remove(&our_chip->chip);
 
-	clk_disable_unprepare(chip->base_clk);
+	clk_disable_unprepare(our_chip->base_clk);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.40.1

