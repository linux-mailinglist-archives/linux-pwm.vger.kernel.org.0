Return-Path: <linux-pwm+bounces-110-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C24E7F2FC8
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA6E1C215BF
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E914537F5;
	Tue, 21 Nov 2023 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B4D6F
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:13 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAa-0006F8-Uu; Tue, 21 Nov 2023 14:52:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAX-00Ab1U-Pq; Tue, 21 Nov 2023 14:52:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAX-004xgJ-GX; Tue, 21 Nov 2023 14:52:01 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 082/108] pwm: samsung: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:24 +0100
Message-ID: <20231121134901.208535-83-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5851; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=y/uVb42LenA50HPvF4HpLvqJvAahWXuiZd7QSbIZxSc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWnxTgYrAtCxgaPchYu25kxb1HR2miuepyi0 YVPUkV4ccmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1pwAKCRCPgPtYfRL+ TsctB/45xqtxmt0Nnu4gYTSw+EkDoICjRBIko2/gdMQeErofn/tT8o2/MTfm3yh435SfSzKn+L+ sxgYb7YWJdL3u/LXCen0kDE8MzRkoD3ogeUkxkxhfL0SgxoHwy6WC16CJACiPy22dW1KSZ7OtKz dGi1XrRVDsWUiuchu4ke8EUkkfPCd84EWp1+SrXBHVVznciIhcZHMiHhdAmtSt2dE+l3XQ1FCCz Uf2wp1CoDbkn52AV+l9u+lqDMmIX7L+B5+kIh0iGUDOgrX/D9q4i3apn9OKR7s1mbJ5vn82WYSW eg88xceHq84rGVleiwozt2NTo0O74VIvxXAm+zcCEvJQyRNZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-samsung driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 45 +++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index a97cae49406e..acdd456de76c 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -80,7 +80,6 @@ struct samsung_pwm_channel {
  * @channel:		per channel driver data
  */
 struct samsung_pwm_chip {
-	struct pwm_chip chip;
 	struct samsung_pwm_variant variant;
 	u8 inverter_mask;
 	u8 disabled_mask;
@@ -110,7 +109,7 @@ static DEFINE_SPINLOCK(samsung_pwm_lock);
 static inline
 struct samsung_pwm_chip *to_samsung_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct samsung_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline unsigned int to_tcon_channel(unsigned int channel)
@@ -181,9 +180,10 @@ static unsigned long pwm_samsung_get_tin_rate(struct samsung_pwm_chip *our_chip,
 	return rate / (reg + 1);
 }
 
-static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *our_chip,
+static unsigned long pwm_samsung_calc_tin(struct pwm_chip *chip,
 					  unsigned int chan, unsigned long freq)
 {
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 	struct samsung_pwm_variant *variant = &our_chip->variant;
 	unsigned long rate;
 	struct clk *clk;
@@ -197,12 +197,12 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *our_chip,
 				return rate;
 		}
 
-		dev_warn(pwmchip_parent(&our_chip->chip),
+		dev_warn(pwmchip_parent(chip),
 			"tclk of PWM %d is inoperational, using tdiv\n", chan);
 	}
 
 	rate = pwm_samsung_get_tin_rate(our_chip, chan);
-	dev_dbg(pwmchip_parent(&our_chip->chip), "tin parent at %lu\n", rate);
+	dev_dbg(pwmchip_parent(chip), "tin parent at %lu\n", rate);
 
 	/*
 	 * Compare minimum PWM frequency that can be achieved with possible
@@ -329,7 +329,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		dev_dbg(pwmchip_parent(chip), "duty_ns=%d, period_ns=%d (%u)\n",
 						duty_ns, period_ns, period);
 
-		tin_rate = pwm_samsung_calc_tin(our_chip, pwm->hwpwm, period);
+		tin_rate = pwm_samsung_calc_tin(chip, pwm->hwpwm, period);
 
 		dev_dbg(pwmchip_parent(chip), "tin_rate=%lu\n", tin_rate);
 
@@ -506,9 +506,10 @@ static const struct of_device_id samsung_pwm_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 
-static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
+static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 {
-	struct device_node *np = pwmchip_parent(&our_chip->chip)->of_node;
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
+	struct device_node *np = pwmchip_parent(chip)->of_node;
 	const struct of_device_id *match;
 	struct property *prop;
 	const __be32 *cur;
@@ -522,7 +523,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
-			dev_err(pwmchip_parent(&our_chip->chip),
+			dev_err(pwmchip_parent(chip),
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
 								__func__);
 			continue;
@@ -533,7 +534,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 	return 0;
 }
 #else
-static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
+static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 {
 	return -ENODEV;
 }
@@ -542,21 +543,22 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 static int pwm_samsung_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct samsung_pwm_chip *our_chip;
 	unsigned int chan;
 	int ret;
 
-	our_chip = devm_kzalloc(&pdev->dev, sizeof(*our_chip), GFP_KERNEL);
-	if (our_chip == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, SAMSUNG_PWM_NUM, sizeof(*chip));
+	if (chip == NULL)
 		return -ENOMEM;
+	our_chip = to_samsung_pwm_chip(chip);
+
+	chip->ops = &pwm_samsung_ops;
 
-	our_chip->chip.dev = &pdev->dev;
-	our_chip->chip.ops = &pwm_samsung_ops;
-	our_chip->chip.npwm = SAMSUNG_PWM_NUM;
 	our_chip->inverter_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
-		ret = pwm_samsung_parse_dt(our_chip);
+		ret = pwm_samsung_parse_dt(chip);
 		if (ret)
 			return ret;
 	} else {
@@ -595,7 +597,7 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, our_chip);
 
-	ret = pwmchip_add(&our_chip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(dev, "failed to register PWM chip\n");
 		clk_disable_unprepare(our_chip->base_clk);
@@ -612,17 +614,18 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 static void pwm_samsung_remove(struct platform_device *pdev)
 {
-	struct samsung_pwm_chip *our_chip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 
-	pwmchip_remove(&our_chip->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(our_chip->base_clk);
 }
 
 static int pwm_samsung_resume(struct device *dev)
 {
-	struct samsung_pwm_chip *our_chip = dev_get_drvdata(dev);
-	struct pwm_chip *chip = &our_chip->chip;
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 	unsigned int i;
 
 	for (i = 0; i < SAMSUNG_PWM_NUM; i++) {
-- 
2.42.0


