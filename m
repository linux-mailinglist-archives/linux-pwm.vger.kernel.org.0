Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A081354DE1
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 09:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244318AbhDFHbb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Apr 2021 03:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhDFHba (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Apr 2021 03:31:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279A1C06174A
        for <linux-pwm@vger.kernel.org>; Tue,  6 Apr 2021 00:31:23 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTgAf-0007N9-UL; Tue, 06 Apr 2021 09:30:45 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lTgAa-0001YT-Vl; Tue, 06 Apr 2021 09:30:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-fbdev@vger.kernel.org
Subject: [PATCH] pwm: Rename pwm_get_state() to better reflect its semantic
Date:   Tue,  6 Apr 2021 09:30:36 +0200
Message-Id: <20210406073036.26857-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Given that lowlevel drivers usually cannot implement exactly what a
consumer requests with pwm_apply_state() there is some rounding involved.

pwm_get_state() traditionally returned the setting that was requested most
recently by the consumer (opposed to what was actually implemented in
hardware in reply to the last request). To make this semantic obvious
rename the function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/driver-api/pwm.rst           |  6 +++-
 drivers/clk/clk-pwm.c                      |  2 +-
 drivers/gpu/drm/i915/display/intel_panel.c |  4 +--
 drivers/input/misc/da7280.c                |  2 +-
 drivers/input/misc/pwm-beeper.c            |  2 +-
 drivers/input/misc/pwm-vibra.c             |  4 +--
 drivers/pwm/core.c                         |  4 +--
 drivers/pwm/pwm-atmel-hlcdc.c              |  2 +-
 drivers/pwm/pwm-atmel.c                    |  2 +-
 drivers/pwm/pwm-imx27.c                    |  2 +-
 drivers/pwm/pwm-rockchip.c                 |  2 +-
 drivers/pwm/pwm-stm32-lp.c                 |  4 +--
 drivers/pwm/pwm-sun4i.c                    |  2 +-
 drivers/pwm/sysfs.c                        | 18 ++++++------
 drivers/regulator/pwm-regulator.c          |  4 +--
 drivers/video/backlight/pwm_bl.c           | 10 +++----
 include/linux/pwm.h                        | 34 ++++++++++++++--------
 17 files changed, 59 insertions(+), 45 deletions(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index ab62f1bb0366..381f3c46cdac 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -55,7 +55,11 @@ several parameter at once. For example, if you see pwm_config() and
 pwm_{enable,disable}() calls in the same function, this probably means you
 should switch to pwm_apply_state().
 
-The PWM user API also allows one to query the PWM state with pwm_get_state().
+The PWM user API also allows one to query the last applied PWM state with
+pwm_get_last_applied_state(). Note this is different to what the driver has
+actually implemented if the request cannot be implemented exactly with the
+hardware in use. There is currently no way for consumers to get the actually
+implemented settings.
 
 In addition to the PWM state, the PWM API also exposes PWM arguments, which
 are the reference PWM config one should use on this PWM.
diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index da2c8eddfd9f..7cfaff32980b 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -49,7 +49,7 @@ static int clk_pwm_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 	struct clk_pwm *clk_pwm = to_clk_pwm(hw);
 	struct pwm_state state;
 
-	pwm_get_state(clk_pwm->pwm, &state);
+	pwm_get_last_applied_state(clk_pwm->pwm, &state);
 
 	duty->num = state.duty_cycle;
 	duty->den = state.period;
diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 5fdf52643150..3aebf9be6b6a 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -627,7 +627,7 @@ static u32 ext_pwm_get_backlight(struct intel_connector *connector, enum pipe un
 	struct intel_panel *panel = &connector->panel;
 	struct pwm_state state;
 
-	pwm_get_state(panel->backlight.pwm, &state);
+	pwm_get_last_applied_state(panel->backlight.pwm, &state);
 	return pwm_get_relative_duty_cycle(&state, 100);
 }
 
@@ -1915,7 +1915,7 @@ static int ext_pwm_setup_backlight(struct intel_connector *connector,
 
 	if (pwm_is_enabled(panel->backlight.pwm)) {
 		/* PWM is already enabled, use existing settings */
-		pwm_get_state(panel->backlight.pwm, &panel->backlight.pwm_state);
+		pwm_get_last_applied_state(panel->backlight.pwm, &panel->backlight.pwm_state);
 
 		level = pwm_get_relative_duty_cycle(&panel->backlight.pwm_state,
 						    100);
diff --git a/drivers/input/misc/da7280.c b/drivers/input/misc/da7280.c
index b08610d6e575..409670be1d2b 100644
--- a/drivers/input/misc/da7280.c
+++ b/drivers/input/misc/da7280.c
@@ -333,7 +333,7 @@ static int da7280_haptic_set_pwm(struct da7280_haptic *haptics, bool enabled)
 		return -EINVAL;
 	}
 
-	pwm_get_state(haptics->pwm_dev, &state);
+	pwm_get_last_applied_state(haptics->pwm_dev, &state);
 	state.enabled = enabled;
 	if (enabled) {
 		period_mag_multi = (u64)state.period * haptics->gain;
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index d6b12477748a..4c5f09201ecf 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -33,7 +33,7 @@ static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
 	struct pwm_state state;
 	int error;
 
-	pwm_get_state(beeper->pwm, &state);
+	pwm_get_last_applied_state(beeper->pwm, &state);
 
 	state.enabled = true;
 	state.period = period;
diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index 81e777a04b88..d4e286e50aee 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -48,7 +48,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 		vibrator->vcc_on = true;
 	}
 
-	pwm_get_state(vibrator->pwm, &state);
+	pwm_get_last_applied_state(vibrator->pwm, &state);
 	pwm_set_relative_duty_cycle(&state, vibrator->level, 0xffff);
 	state.enabled = true;
 
@@ -59,7 +59,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 	}
 
 	if (vibrator->pwm_dir) {
-		pwm_get_state(vibrator->pwm_dir, &state);
+		pwm_get_last_applied_state(vibrator->pwm_dir, &state);
 		state.duty_cycle = vibrator->direction_duty_cycle;
 		state.enabled = true;
 
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a8eff4b3ee36..cc8a948098eb 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -697,7 +697,7 @@ int pwm_adjust_config(struct pwm_device *pwm)
 	struct pwm_args pargs;
 
 	pwm_get_args(pwm, &pargs);
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 
 	/*
 	 * If the current period is zero it means that either the PWM driver
@@ -1274,7 +1274,7 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		struct pwm_device *pwm = &chip->pwms[i];
 		struct pwm_state state;
 
-		pwm_get_state(pwm, &state);
+		pwm_get_last_applied_state(pwm, &state);
 
 		seq_printf(s, " pwm-%-3d (%-20.20s):", i, pwm->label);
 
diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index dcbc0489dfd4..cb5fae4056ec 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -198,7 +198,7 @@ static int atmel_hlcdc_pwm_resume(struct device *dev)
 	struct pwm_state state;
 	int ret;
 
-	pwm_get_state(&chip->chip.pwms[0], &state);
+	pwm_get_last_applied_state(&chip->chip.pwms[0], &state);
 
 	/* Re-enable the periph clock it was stopped during suspend. */
 	if (!state.enabled) {
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 5813339b597b..4eee895471a7 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -241,7 +241,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 pres, val;
 	int ret;
 
-	pwm_get_state(pwm, &cstate);
+	pwm_get_last_applied_state(pwm, &cstate);
 
 	if (state->enabled) {
 		if (cstate.enabled &&
diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 18055326a2f3..b9d54e209a5c 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -223,7 +223,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret;
 	u32 cr;
 
-	pwm_get_state(pwm, &cstate);
+	pwm_get_last_applied_state(pwm, &cstate);
 
 	clkrate = clk_get_rate(imx->clk_per);
 	c = clkrate * state->period;
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 6ad7d0a50aed..16f99369f4c5 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -198,7 +198,7 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret)
 		return ret;
 
-	pwm_get_state(pwm, &curstate);
+	pwm_get_last_applied_state(pwm, &curstate);
 	enabled = curstate.enabled;
 
 	if (state->polarity != curstate.polarity && enabled &&
diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 134c14621ee0..c9e10aa1a8ef 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -41,7 +41,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	bool reenable;
 	int ret;
 
-	pwm_get_state(pwm, &cstate);
+	pwm_get_last_applied_state(pwm, &cstate);
 	reenable = !cstate.enabled;
 
 	if (!state->enabled) {
@@ -235,7 +235,7 @@ static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
 	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
 	struct pwm_state state;
 
-	pwm_get_state(&priv->chip.pwms[0], &state);
+	pwm_get_last_applied_state(&priv->chip.pwms[0], &state);
 	if (state.enabled) {
 		dev_err(dev, "The consumer didn't stop us (%s)\n",
 			priv->chip.pwms[0].label);
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index ce5c4fc8da6f..b4ae8190c3e9 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -239,7 +239,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long now;
 	bool bypass;
 
-	pwm_get_state(pwm, &cstate);
+	pwm_get_last_applied_state(pwm, &cstate);
 
 	if (!cstate.enabled) {
 		ret = clk_prepare_enable(sun4i_pwm->clk);
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 9903c3a7eced..341def50e2df 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -40,7 +40,7 @@ static ssize_t period_show(struct device *child,
 	const struct pwm_device *pwm = child_to_pwm_device(child);
 	struct pwm_state state;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 
 	return sprintf(buf, "%llu\n", state.period);
 }
@@ -60,7 +60,7 @@ static ssize_t period_store(struct device *child,
 		return ret;
 
 	mutex_lock(&export->lock);
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 	state.period = val;
 	ret = pwm_apply_state(pwm, &state);
 	mutex_unlock(&export->lock);
@@ -75,7 +75,7 @@ static ssize_t duty_cycle_show(struct device *child,
 	const struct pwm_device *pwm = child_to_pwm_device(child);
 	struct pwm_state state;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 
 	return sprintf(buf, "%llu\n", state.duty_cycle);
 }
@@ -95,7 +95,7 @@ static ssize_t duty_cycle_store(struct device *child,
 		return ret;
 
 	mutex_lock(&export->lock);
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 	state.duty_cycle = val;
 	ret = pwm_apply_state(pwm, &state);
 	mutex_unlock(&export->lock);
@@ -110,7 +110,7 @@ static ssize_t enable_show(struct device *child,
 	const struct pwm_device *pwm = child_to_pwm_device(child);
 	struct pwm_state state;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 
 	return sprintf(buf, "%d\n", state.enabled);
 }
@@ -130,7 +130,7 @@ static ssize_t enable_store(struct device *child,
 
 	mutex_lock(&export->lock);
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 
 	switch (val) {
 	case 0:
@@ -159,7 +159,7 @@ static ssize_t polarity_show(struct device *child,
 	const char *polarity = "unknown";
 	struct pwm_state state;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 
 	switch (state.polarity) {
 	case PWM_POLARITY_NORMAL:
@@ -192,7 +192,7 @@ static ssize_t polarity_store(struct device *child,
 		return -EINVAL;
 
 	mutex_lock(&export->lock);
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 	state.polarity = polarity;
 	ret = pwm_apply_state(pwm, &state);
 	mutex_unlock(&export->lock);
@@ -392,7 +392,7 @@ static struct pwm_export *pwm_class_get_state(struct device *parent,
 	put_device(child);	/* for device_find_child() */
 
 	mutex_lock(&export->lock);
-	pwm_get_state(pwm, state);
+	pwm_get_last_applied_state(pwm, state);
 
 	return export;
 }
diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 7629476d94ae..e8ada29f340a 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -58,7 +58,7 @@ static void pwm_regulator_init_state(struct regulator_dev *rdev)
 	unsigned int dutycycle;
 	int i;
 
-	pwm_get_state(drvdata->pwm, &pwm_state);
+	pwm_get_last_applied_state(drvdata->pwm, &pwm_state);
 	dutycycle = pwm_get_relative_duty_cycle(&pwm_state, 100);
 
 	for (i = 0; i < rdev->desc->n_voltages; i++) {
@@ -155,7 +155,7 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 	unsigned int diff_duty;
 	unsigned int voltage;
 
-	pwm_get_state(drvdata->pwm, &pstate);
+	pwm_get_last_applied_state(drvdata->pwm, &pstate);
 
 	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
 
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index e48fded3e414..df950d9b3738 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -44,7 +44,7 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 	struct pwm_state state;
 	int err;
 
-	pwm_get_state(pb->pwm, &state);
+	pwm_get_last_applied_state(pb->pwm, &state);
 	if (pb->enabled)
 		return;
 
@@ -68,7 +68,7 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 {
 	struct pwm_state state;
 
-	pwm_get_state(pb->pwm, &state);
+	pwm_get_last_applied_state(pb->pwm, &state);
 	if (!pb->enabled)
 		return;
 
@@ -92,7 +92,7 @@ static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
 	struct pwm_state state;
 	u64 duty_cycle;
 
-	pwm_get_state(pb->pwm, &state);
+	pwm_get_last_applied_state(pb->pwm, &state);
 
 	if (pb->levels)
 		duty_cycle = pb->levels[brightness];
@@ -115,7 +115,7 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 		brightness = pb->notify(pb->dev, brightness);
 
 	if (brightness > 0) {
-		pwm_get_state(pb->pwm, &state);
+		pwm_get_last_applied_state(pb->pwm, &state);
 		state.duty_cycle = compute_duty_cycle(pb, brightness);
 		pwm_apply_state(pb->pwm, &state);
 		pwm_backlight_power_on(pb);
@@ -567,7 +567,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		 */
 
 		/* Get the PWM period (in nanoseconds) */
-		pwm_get_state(pb->pwm, &state);
+		pwm_get_last_applied_state(pb->pwm, &state);
 
 		ret = pwm_backlight_brightness_default(&pdev->dev, data,
 						       state.period);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e4d84d4db293..35782cd4075b 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -88,12 +88,18 @@ struct pwm_device {
 };
 
 /**
- * pwm_get_state() - retrieve the current PWM state
+ * pwm_get_last_applied_state() - retrieve the PWM state that was passed to
+ *                                pwm_apply_state() before
+ *
+ * If pwm_apply_state() wasn't called before the state returned might be what is
+ * actually implemented in the hardware (if supported by the driver) or a
+ * default setting.
+ *
  * @pwm: PWM device
  * @state: state to fill with the current PWM state
  */
-static inline void pwm_get_state(const struct pwm_device *pwm,
-				 struct pwm_state *state)
+static inline void pwm_get_last_applied_state(const struct pwm_device *pwm,
+					      struct pwm_state *state)
 {
 	*state = pwm->state;
 }
@@ -102,7 +108,7 @@ static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 
 	return state.enabled;
 }
@@ -117,7 +123,7 @@ static inline u64 pwm_get_period(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 
 	return state.period;
 }
@@ -132,7 +138,7 @@ static inline u64 pwm_get_duty_cycle(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 
 	return state.duty_cycle;
 }
@@ -141,7 +147,7 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 
 	return state.polarity;
 }
@@ -175,7 +181,7 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
 	struct pwm_args args;
 
 	/* First get the current state. */
-	pwm_get_state(pwm, state);
+	pwm_get_last_applied_state(pwm, state);
 
 	/* Then fill it with the reference config */
 	pwm_get_args(pwm, &args);
@@ -195,8 +201,12 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
  *
  * For example if you want to get the duty_cycle expressed in percent, call:
  *
- * pwm_get_state(pwm, &state);
+ * pwm_get_last_applied_state(pwm, &state);
  * duty = pwm_get_relative_duty_cycle(&state, 100);
+ *
+ * Note however that this example yields the relative duty cycle that was
+ * requested before which doesn't necessarily exactly matches what is actually
+ * provided by the hardware.
  */
 static inline unsigned int
 pwm_get_relative_duty_cycle(const struct pwm_state *state, unsigned int scale)
@@ -337,7 +347,7 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
 	if (duty_ns < 0 || period_ns < 0)
 		return -EINVAL;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 	if (state.duty_cycle == duty_ns && state.period == period_ns)
 		return 0;
 
@@ -359,7 +369,7 @@ static inline int pwm_enable(struct pwm_device *pwm)
 	if (!pwm)
 		return -EINVAL;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 	if (state.enabled)
 		return 0;
 
@@ -378,7 +388,7 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	if (!pwm)
 		return;
 
-	pwm_get_state(pwm, &state);
+	pwm_get_last_applied_state(pwm, &state);
 	if (!state.enabled)
 		return;
 
-- 
2.30.2

