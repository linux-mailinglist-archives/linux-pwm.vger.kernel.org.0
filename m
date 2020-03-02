Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5A84176408
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Mar 2020 20:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgCBTe2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Mar 2020 14:34:28 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:54615 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbgCBTe1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Mar 2020 14:34:27 -0500
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Mar 2020 11:34:26 -0800
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 02 Mar 2020 11:34:26 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 75C924B04; Mon,  2 Mar 2020 11:34:26 -0800 (PST)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [RESEND v6 1/2] pwm: Convert drivers to use 64-bit period and duty cycle
Date:   Mon,  2 Mar 2020 11:34:22 -0800
Message-Id: <28090aef9900ad483cbfbe77883e5ffcd8745907.1583177501.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583177501.git.gurus@codeaurora.org>
References: <cover.1583177501.git.gurus@codeaurora.org>
In-Reply-To: <cover.1583177501.git.gurus@codeaurora.org>
References: <cover.1583177501.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Because period and duty cycle are defined in the PWM framework structs
as ints with units of nanoseconds, the maximum time duration that can be
set is limited to ~2.147 seconds. Redefining them as u64 values will
enable larger time durations to be set.

As a first step, prepare drivers to handle the switch to u64 period and
duty_cycle by making the relevant fixes to those drivers that use the
period and duty_cycle pwm struct members in division operations, viz.
replacing the division operations with 64-bit division macros as
appropriate. The actual switch to u64 period and duty_cycle follows as a
separate patch.

Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
macros:
- DIV_ROUND_UP_ULL
- DIV_ROUND_CLOSEST_ULL
- div_u64

Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
DIV64_* macros:
- DIV64_U64_ROUND_CLOSEST
- div64_u64

The kbuild test robot helped to improve this patch by catching a couple
of code sites that had to be adapted.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/clk/clk-pwm.c                      | 2 +-
 drivers/gpu/drm/i915/display/intel_panel.c | 2 +-
 drivers/hwmon/pwm-fan.c                    | 2 +-
 drivers/media/rc/ir-rx51.c                 | 3 ++-
 drivers/pwm/pwm-clps711x.c                 | 2 +-
 drivers/pwm/pwm-imx-tpm.c                  | 2 +-
 drivers/pwm/pwm-imx27.c                    | 5 ++---
 drivers/pwm/pwm-sifive.c                   | 2 +-
 drivers/pwm/pwm-sti.c                      | 5 +++--
 drivers/pwm/pwm-stm32-lp.c                 | 2 +-
 drivers/pwm/pwm-sun4i.c                    | 2 +-
 drivers/video/backlight/pwm_bl.c           | 3 ++-
 12 files changed, 17 insertions(+), 15 deletions(-)

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
index bc14e9c..843cac1 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1868,7 +1868,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 
 	panel->backlight.min = 0; /* 0% */
 	panel->backlight.max = 100; /* 100% */
-	panel->backlight.level = DIV_ROUND_UP(
+	panel->backlight.level = DIV_ROUND_UP_ULL(
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
index 35a7ac42..b7d38d0 100644
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
index 1508616..5a7f337 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -371,10 +371,11 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 		effective_ticks = clk_get_rate(pc->cpt_clk);
 
 		result->period = (high + low) * NSEC_PER_SEC;
-		result->period /= effective_ticks;
+		result->period = div_u64(result->period, effective_ticks);
 
 		result->duty_cycle = high * NSEC_PER_SEC;
-		result->duty_cycle /= effective_ticks;
+		result->duty_cycle = div_u64(result->duty_cycle,
+				effective_ticks);
 
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
index 3e3efa6..772fdf4 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -286,7 +286,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
 	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
-		usecs_to_jiffies(cstate.period / 1000 + 1);
+		usecs_to_jiffies(div_u64(cstate.period, 1000) + 1);
 	sun4i_pwm->needs_delay[pwm->hwpwm] = true;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
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
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

