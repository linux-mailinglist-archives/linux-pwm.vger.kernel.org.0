Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6A139DAD
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2020 00:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAMXxi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Jan 2020 18:53:38 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:45650 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728802AbgAMXxh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jan 2020 18:53:37 -0500
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Jan 2020 15:53:36 -0800
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg03-sd.qualcomm.com with ESMTP; 13 Jan 2020 15:53:36 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 0A27449AD; Mon, 13 Jan 2020 15:53:35 -0800 (PST)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v4 1/1] pwm: Convert period and duty cycle to u64
Date:   Mon, 13 Jan 2020 15:53:31 -0800
Message-Id: <21a1431edfa86e061528b80021351c25c76976a9.1578959442.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1578959442.git.gurus@codeaurora.org>
References: <cover.1578959442.git.gurus@codeaurora.org>
In-Reply-To: <cover.1578959442.git.gurus@codeaurora.org>
References: <cover.1578959442.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Because period and duty cycle are defined as ints with units of
nanoseconds, the maximum time duration that can be set is limited to
~2.147 seconds. Change their definitions to u64 in the structs of the
PWM framework so that higher durations may be set.

Also make the relevant fixes to those drivers that use the period and
duty_cycle struct members in division operations, viz. replacing the
division operations with 64-bit division macros as appropriate.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/clk/clk-pwm.c                      |  2 +-
 drivers/gpu/drm/i915/display/intel_panel.c |  2 +-
 drivers/hwmon/pwm-fan.c                    |  2 +-
 drivers/media/rc/ir-rx51.c                 |  3 ++-
 drivers/pwm/core.c                         |  4 ++--
 drivers/pwm/pwm-clps711x.c                 |  2 +-
 drivers/pwm/pwm-imx-tpm.c                  |  2 +-
 drivers/pwm/pwm-imx27.c                    |  5 ++---
 drivers/pwm/pwm-sifive.c                   |  2 +-
 drivers/pwm/pwm-sti.c                      |  4 ++--
 drivers/pwm/pwm-stm32-lp.c                 |  2 +-
 drivers/pwm/pwm-sun4i.c                    |  2 +-
 drivers/pwm/sysfs.c                        | 10 +++++-----
 drivers/video/backlight/pwm_bl.c           |  3 ++-
 include/linux/pwm.h                        | 16 ++++++++--------
 15 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 87fe0b0e..7b1f7a0 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -89,7 +89,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
-		clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
+		clk_pwm->fixed_rate = div64_u64(NSEC_PER_SEC, pargs.period);
 
 	if (pargs.period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
 	    pargs.period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index bc14e9c..ca373b8 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1868,7 +1868,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 
 	panel->backlight.min = 0; /* 0% */
 	panel->backlight.max = 100; /* 100% */
-	panel->backlight.level = DIV_ROUND_UP(
+	panel->backlight.level = DIV64_U64_ROUND_UP(
 				 pwm_get_duty_cycle(panel->backlight.pwm) * 100,
 				 CRC_PMIC_PWM_PERIOD_NS);
 	panel->backlight.enabled = panel->backlight.level != 0;
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 42ffd2e..283423a 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -437,7 +437,7 @@ static int pwm_fan_resume(struct device *dev)
 		return 0;
 
 	pwm_get_args(ctx->pwm, &pargs);
-	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
+	duty = DIV_ROUND_UP_ULL(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
 	ret = pwm_config(ctx->pwm, duty, pargs.period);
 	if (ret)
 		return ret;
diff --git a/drivers/media/rc/ir-rx51.c b/drivers/media/rc/ir-rx51.c
index 8574eda..9a5dfd7 100644
--- a/drivers/media/rc/ir-rx51.c
+++ b/drivers/media/rc/ir-rx51.c
@@ -241,7 +241,8 @@ static int ir_rx51_probe(struct platform_device *dev)
 	}
 
 	/* Use default, in case userspace does not set the carrier */
-	ir_rx51.freq = DIV_ROUND_CLOSEST(pwm_get_period(pwm), NSEC_PER_SEC);
+	ir_rx51.freq = DIV_ROUND_CLOSEST_ULL(pwm_get_period(pwm),
+			NSEC_PER_SEC);
 	pwm_put(pwm);
 
 	hrtimer_init(&ir_rx51.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e067873..c866e60 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1156,8 +1156,8 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		if (state.enabled)
 			seq_puts(s, " enabled");
 
-		seq_printf(s, " period: %u ns", state.period);
-		seq_printf(s, " duty: %u ns", state.duty_cycle);
+		seq_printf(s, " period: %llu ns", state.period);
+		seq_printf(s, " duty: %llu ns", state.duty_cycle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
 
diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 924d39a..ba9500a 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -43,7 +43,7 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
 static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
 {
 	/* Duty cycle 0..15 max */
-	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
+	return DIV64_U64_ROUND_CLOSEST(v * 0xf, pwm->args.period);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 9145f61..53bf364 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -126,7 +126,7 @@ static int pwm_imx_tpm_round_state(struct pwm_chip *chip,
 		real_state->duty_cycle = state->duty_cycle;
 
 	tmp = (u64)p->mod * real_state->duty_cycle;
-	p->val = DIV_ROUND_CLOSEST_ULL(tmp, real_state->period);
+	p->val = DIV64_U64_ROUND_CLOSEST(tmp, real_state->period);
 
 	real_state->polarity = state->polarity;
 	real_state->enabled = state->enabled;
diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 59d8b12..070c021 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -208,7 +208,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 	sr = readl(imx->mmio_base + MX3_PWMSR);
 	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
 	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
-		period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
+		period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm),
 					 NSEC_PER_MSEC);
 		msleep(period_ms);
 
@@ -240,8 +240,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	period_cycles /= prescale;
 	c = (unsigned long long)period_cycles * state->duty_cycle;
-	do_div(c, state->period);
-	duty_cycles = c;
+	duty_cycles = div64_u64(c, state->period);
 
 	/*
 	 * according to imx pwm RM, the real period value should be PERIOD
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index cc63f9b..62de0bb 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -181,7 +181,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * consecutively
 	 */
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
-	frac = DIV_ROUND_CLOSEST_ULL(num, state->period);
+	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
 	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
 
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 1508616..857f2ad 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -371,10 +371,10 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 		effective_ticks = clk_get_rate(pc->cpt_clk);
 
 		result->period = (high + low) * NSEC_PER_SEC;
-		result->period /= effective_ticks;
+		do_div(result->period, effective_ticks);
 
 		result->duty_cycle = high * NSEC_PER_SEC;
-		result->duty_cycle /= effective_ticks;
+		do_div(result->duty_cycle, effective_ticks);
 
 		break;
 
diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 67fca62..134c146 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, NSEC_PER_SEC);
 	if (!div) {
 		/* Clock is too slow to achieve requested period. */
-		dev_dbg(priv->chip.dev, "Can't reach %u ns\n",	state->period);
+		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
 		return -EINVAL;
 	}
 
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1afd41e..23ec605 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -285,7 +285,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
 	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
-		usecs_to_jiffies(cstate.period / 1000 + 1);
+		usecs_to_jiffies(div_u64(cstate.period, 1000) + 1);
 	sun4i_pwm->needs_delay[pwm->hwpwm] = true;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 2389b86..3fb1610 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -42,7 +42,7 @@ static ssize_t period_show(struct device *child,
 
 	pwm_get_state(pwm, &state);
 
-	return sprintf(buf, "%u\n", state.period);
+	return sprintf(buf, "%llu\n", state.period);
 }
 
 static ssize_t period_store(struct device *child,
@@ -52,10 +52,10 @@ static ssize_t period_store(struct device *child,
 	struct pwm_export *export = child_to_pwm_export(child);
 	struct pwm_device *pwm = export->pwm;
 	struct pwm_state state;
-	unsigned int val;
+	u64 val;
 	int ret;
 
-	ret = kstrtouint(buf, 0, &val);
+	ret = kstrtou64(buf, 0, &val);
 	if (ret)
 		return ret;
 
@@ -77,7 +77,7 @@ static ssize_t duty_cycle_show(struct device *child,
 
 	pwm_get_state(pwm, &state);
 
-	return sprintf(buf, "%u\n", state.duty_cycle);
+	return sprintf(buf, "%llu\n", state.duty_cycle);
 }
 
 static ssize_t duty_cycle_store(struct device *child,
@@ -212,7 +212,7 @@ static ssize_t capture_show(struct device *child,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
+	return sprintf(buf, "%llu %llu\n", result.period, result.duty_cycle);
 }
 
 static DEVICE_ATTR_RW(period);
diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index efb4efc..3e5dbcf 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -625,7 +625,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		pb->scale = data->max_brightness;
 	}
 
-	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
+	pb->lth_brightness = data->lth_brightness * (div_u64(state.period,
+				pb->scale));
 
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = data->max_brightness;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 0ef808d..df83440 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -39,7 +39,7 @@ enum pwm_polarity {
  * current PWM hardware state.
  */
 struct pwm_args {
-	unsigned int period;
+	u64 period;
 	enum pwm_polarity polarity;
 };
 
@@ -56,8 +56,8 @@ enum {
  * @enabled: PWM enabled status
  */
 struct pwm_state {
-	unsigned int period;
-	unsigned int duty_cycle;
+	u64 period;
+	u64 duty_cycle;
 	enum pwm_polarity polarity;
 	bool enabled;
 };
@@ -105,13 +105,13 @@ static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 	return state.enabled;
 }
 
-static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
+static inline void pwm_set_period(struct pwm_device *pwm, u64 period)
 {
 	if (pwm)
 		pwm->state.period = period;
 }
 
-static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
+static inline u64 pwm_get_period(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
@@ -126,7 +126,7 @@ static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
 		pwm->state.duty_cycle = duty;
 }
 
-static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
+static inline u64 pwm_get_duty_cycle(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
@@ -305,8 +305,8 @@ struct pwm_chip {
  * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
  */
 struct pwm_capture {
-	unsigned int period;
-	unsigned int duty_cycle;
+	u64 period;
+	u64 duty_cycle;
 };
 
 #if IS_ENABLED(CONFIG_PWM)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

