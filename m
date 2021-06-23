Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735D83B1227
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Jun 2021 05:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhFWDaQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Jun 2021 23:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhFWDaP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Jun 2021 23:30:15 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E89C06175F
        for <linux-pwm@vger.kernel.org>; Tue, 22 Jun 2021 20:27:59 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso564539otp.8
        for <linux-pwm@vger.kernel.org>; Tue, 22 Jun 2021 20:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QItPr6T1RPBt6mEwivZSkGNEZySuAQegnYarkYAo8JE=;
        b=EPe9pl8cAj5c8B0wbDryT9Tb8apyctr6BhlbyVzugoXQv+pXuvbRAilgSuk8hjM6SX
         DcHUBJ7yIXXrfRqHH28WGA+RYtGvv4z3i8tFBB9ZTmDKSKSc8rnnRoDQa7hj4Ng7Q7G3
         6QxH4WS5a/fB/WjfQ2OqYGQEWBpWlDw0GSx8wbuCRz07Fi2Xm5809up6Xma7g+q7VwSB
         JAwkNrlnQZjkjAoPzOiFaKifYPsjIssC2u0L80KbkW5715wHQFoAbV1UnLUA+TLdsqtt
         BiQuS8I8IrLDj3YFp5AsxanIo3k+dYycCDAoV6zq8X0R10e0De9E3XCDyQUKgfUOUpwE
         2wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QItPr6T1RPBt6mEwivZSkGNEZySuAQegnYarkYAo8JE=;
        b=Z24CRsbxyy4yMoT9nOe0rx4ag7irTMbc7jS+92QXABCZTKKLkj1pbGtjToKYBzKpOI
         DERwHD4/9ZCavC/Ndu8lggx+hwnwkyXNhzQHKgUbnFo/NgMcMbZAu7xc7XrQJcX2Adet
         A9J7BjAIHCYfZjCHpuk63sKoZBLTqJg/wbV27JrBJoyZTorqgRjYOI0T/ggFfwYWc1pH
         bgT05WTleDf2CKFLHCyOTwWc9XNZZXKa/zWP8uX9ntCOTyrNRtrOdfU5kj3NkTyu4Qy0
         bvmuBXzClkWCG5KmGPWBFiLeOHOE8E2L/2kdesPY5WRdL2u48z3xmUhZab3w+Bv+3VUh
         mbAQ==
X-Gm-Message-State: AOAM530g/BaZYINsIO/XHoO5lMYxuPeUiZpnAjVwT3zR1PsriaJZTIgr
        dABvmhss2sQgXb/s6a/yACai7A==
X-Google-Smtp-Source: ABdhPJwfkeXkMtCcOR7AD5cLNMp/FoIj6qs0EpAHnEbwrsDShHPLDflWbxuEYb37qfSlSoxjBFFcYA==
X-Received: by 2002:a9d:12a9:: with SMTP id g38mr6230094otg.114.1624418878397;
        Tue, 22 Jun 2021 20:27:58 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id c205sm4708363oib.20.2021.06.22.20.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 20:27:58 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH v4 2/2] drm/bridge: ti-sn65dsi86: Implement the pwm_chip
Date:   Tue, 22 Jun 2021 22:27:55 -0500
Message-Id: <20210623032755.1170809-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210623032755.1170809-1-bjorn.andersson@linaro.org>
References: <20210623032755.1170809-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The SN65DSI86 provides the ability to supply a PWM signal on GPIO 4,
with the primary purpose of controlling the backlight of the attached
panel. Add an implementation that exposes this using the standard PWM
framework, to allow e.g. pwm-backlight to expose this to the user.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Use proper division operations for u64 divisions
- Calculate duty cycle per backlight / (scale + 1)
- Only mux in PWM when state->enabled
- Include linux/bitfield.h (for FIELD_{GET,PUT} on arm)
- Cap max period to avoid overflows

Changes since v2:
- Corrected calculation of scale, to include a 1 instead of 1/NSEC_TO_SEC and
  rounded the period up in get_state, to make sure its idempotent
- Changed duty_cycle calculation to make sure it idempotent over my tested period
- Documented "Limitations"
- Documented muxing operation after pm_runtime_get_sync()

 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 344 +++++++++++++++++++++++++-
 1 file changed, 343 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 5d712c8c3c3b..a5a0fa38a0ac 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -4,7 +4,9 @@
  * datasheet: https://www.ti.com/lit/ds/symlink/sn65dsi86.pdf
  */
 
+#include <linux/atomic.h>
 #include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
@@ -15,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of_graph.h>
 #include <linux/pm_runtime.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -91,6 +94,13 @@
 #define SN_ML_TX_MODE_REG			0x96
 #define  ML_TX_MAIN_LINK_OFF			0
 #define  ML_TX_NORMAL_MODE			BIT(0)
+#define SN_PWM_PRE_DIV_REG			0xA0
+#define SN_BACKLIGHT_SCALE_REG			0xA1
+#define  BACKLIGHT_SCALE_MAX			0xFFFF
+#define SN_BACKLIGHT_REG			0xA3
+#define SN_PWM_EN_INV_REG			0xA5
+#define  SN_PWM_INV_MASK			BIT(0)
+#define  SN_PWM_EN_MASK				BIT(1)
 #define SN_AUX_CMD_STATUS_REG			0xF4
 #define  AUX_IRQ_STATUS_AUX_RPLY_TOUT		BIT(3)
 #define  AUX_IRQ_STATUS_AUX_SHORT		BIT(5)
@@ -113,11 +123,14 @@
 
 #define SN_LINK_TRAINING_TRIES		10
 
+#define SN_PWM_GPIO_IDX			3 /* 4th GPIO */
+
 /**
  * struct ti_sn65dsi86 - Platform data for ti-sn65dsi86 driver.
  * @bridge_aux:   AUX-bus sub device for MIPI-to-eDP bridge functionality.
  * @gpio_aux:     AUX-bus sub device for GPIO controller functionality.
  * @aux_aux:      AUX-bus sub device for eDP AUX channel functionality.
+ * @pwm_aux:      AUX-bus sub device for PWM controller functionality.
  *
  * @dev:          Pointer to the top level (i2c) device.
  * @regmap:       Regmap for accessing i2c.
@@ -145,11 +158,17 @@
  *                bitmap so we can do atomic ops on it without an extra
  *                lock so concurrent users of our 4 GPIOs don't stomp on
  *                each other's read-modify-write.
+ *
+ * @pchip:        pwm_chip if the PWM is exposed.
+ * @pwm_enabled:  Used to track if the PWM signal is currently enabled.
+ * @pwm_refclk_freq: Cache for the reference clock input to the PWM.
+ * @pwm_pin_busy: Track if GPIO4 is currently requested for GPIO or PWM.
  */
 struct ti_sn65dsi86 {
 	struct auxiliary_device		bridge_aux;
 	struct auxiliary_device		gpio_aux;
 	struct auxiliary_device		aux_aux;
+	struct auxiliary_device		pwm_aux;
 
 	struct device			*dev;
 	struct regmap			*regmap;
@@ -172,6 +191,12 @@ struct ti_sn65dsi86 {
 	struct gpio_chip		gchip;
 	DECLARE_BITMAP(gchip_output, SN_NUM_GPIOS);
 #endif
+#if defined(CONFIG_PWM)
+	struct pwm_chip			pchip;
+	bool				pwm_enabled;
+	unsigned int			pwm_refclk_freq;
+	atomic_t			pwm_pin_busy;
+#endif
 };
 
 static const struct regmap_range ti_sn65dsi86_volatile_ranges[] = {
@@ -190,6 +215,25 @@ static const struct regmap_config ti_sn65dsi86_regmap_config = {
 	.cache_type = REGCACHE_NONE,
 };
 
+static int ti_sn65dsi86_read_u16(struct ti_sn65dsi86 *pdata,
+				 unsigned int reg, u16 *val)
+{
+	unsigned int tmp;
+	int ret;
+
+	ret = regmap_read(pdata->regmap, reg, &tmp);
+	if (ret)
+		return ret;
+	*val = tmp;
+
+	ret = regmap_read(pdata->regmap, reg + 1, &tmp);
+	if (ret)
+		return ret;
+	*val |= tmp << 8;
+
+	return 0;
+}
+
 static void ti_sn65dsi86_write_u16(struct ti_sn65dsi86 *pdata,
 				   unsigned int reg, u16 val)
 {
@@ -253,6 +297,14 @@ static void ti_sn_bridge_set_refclk_freq(struct ti_sn65dsi86 *pdata)
 
 	regmap_update_bits(pdata->regmap, SN_DPPLL_SRC_REG, REFCLK_FREQ_MASK,
 			   REFCLK_FREQ(i));
+
+#if defined(CONFIG_PWM)
+	/*
+	 * The PWM refclk is based on the value written to SN_DPPLL_SRC_REG,
+	 * regardless of its actual sourcing.
+	 */
+	pdata->pwm_refclk_freq = ti_sn_bridge_refclk_lut[i];
+#endif
 }
 
 static void ti_sn65dsi86_enable_comms(struct ti_sn65dsi86 *pdata)
@@ -1044,6 +1096,266 @@ static int ti_sn_bridge_parse_dsi_host(struct ti_sn65dsi86 *pdata)
 	return 0;
 }
 
+#if defined(CONFIG_PWM)
+static int ti_sn_pwm_pin_request(struct ti_sn65dsi86 *pdata)
+{
+	return atomic_xchg(&pdata->pwm_pin_busy, 1) ? -EBUSY : 0;
+}
+
+static void ti_sn_pwm_pin_release(struct ti_sn65dsi86 *pdata)
+{
+	atomic_set(&pdata->pwm_pin_busy, 0);
+}
+
+static struct ti_sn65dsi86 *pwm_chip_to_ti_sn_bridge(struct pwm_chip *chip)
+{
+	return container_of(chip, struct ti_sn65dsi86, pchip);
+}
+
+static int ti_sn_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct ti_sn65dsi86 *pdata = pwm_chip_to_ti_sn_bridge(chip);
+
+	return ti_sn_pwm_pin_request(pdata);
+}
+
+static void ti_sn_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct ti_sn65dsi86 *pdata = pwm_chip_to_ti_sn_bridge(chip);
+
+	ti_sn_pwm_pin_release(pdata);
+}
+
+/*
+ * Limitations:
+ * - The PWM signal is not driven when the chip is powered down, or in its
+ *   reset state and the driver does not implement the "suspend state"
+ *   described in the documentation. In order to save power, state->enabled is
+ *   interpreted as denoting if the signal is expected to be valid, and is used to keep
+ *   the determine if the chip needs to be kept powered.
+ * - Changing both period and duty_cycle is not done atomically, so the output
+ *   might briefly be a mix of the two settings.
+ */
+static int ti_sn_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	struct ti_sn65dsi86 *pdata = pwm_chip_to_ti_sn_bridge(chip);
+	unsigned int pwm_en_inv;
+	unsigned int backlight;
+	unsigned int pre_div;
+	unsigned int scale;
+	u64 period_max;
+	u64 actual;
+	u64 period;
+	int ret;
+
+	if (!pdata->pwm_enabled) {
+		ret = pm_runtime_get_sync(pdata->dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (state->enabled) {
+		if (!pdata->pwm_enabled) {
+			/*
+			 * The chip might have been powered down while we
+			 * didn't hold a PM runtime reference, so mux in the
+			 * PWM function on the GPIO pin again.
+			 */
+			ret = regmap_update_bits(pdata->regmap, SN_GPIO_CTRL_REG,
+						 SN_GPIO_MUX_MASK << (2 * SN_PWM_GPIO_IDX),
+						 SN_GPIO_MUX_SPECIAL << (2 * SN_PWM_GPIO_IDX));
+			if (ret) {
+				dev_err(pdata->dev, "failed to mux in PWM function\n");
+				goto out;
+			}
+		}
+
+		/*
+		 * Per the datasheet the PWM frequency is given by:
+		 *
+		 *   PWM_FREQ = REFCLK_FREQ / (PWM_PRE_DIV * BACKLIGHT_SCALE + 1)
+		 *
+		 * which can be rewritten:
+		 *
+		 *   T_pwm * REFCLK_FREQ - 1 = PWM_PRE_DIV * BACKLIGHT_SCALE
+		 *
+		 * In order to keep BACKLIGHT_SCALE within its 16 bits,
+		 * PWM_PRE_DIV must be:
+		 *
+		 *   PWM_PRE_DIV >= (T_pwm * REFCLK_FREQ - 1) / BACKLIGHT_SCALE_MAX;
+		 *
+		 * To simplify the search and optimize the resolution of the
+		 * PWM, the lowest possible PWM_PRE_DIV is used. Finally the
+		 * scale is calculated as:
+		 *
+		 *   BACKLIGHT_SCALE = (T_pwm * REFCLK_FREQ - 1) / PWM_PRE_DIV
+		 *
+		 * Here T_pwm is represented in seconds, so appropriate scaling
+		 * to nanoseconds is necessary.
+		 */
+
+		/* Minimum T_pwm is (0 * 0 + 1) / REFCLK_FREQ */
+		if (state->period <= NSEC_PER_SEC / pdata->pwm_refclk_freq) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/*
+		 * Maximum T_pwm is (255 * 65535 + 1) / * REFCLK_FREQ
+		 * Limit period to this to avoid overflows
+		 */
+		period_max = div_u64((u64)NSEC_PER_SEC * (255 * 65535 + 1), pdata->pwm_refclk_freq);
+		if (period > period_max)
+			period = period_max;
+		else
+			period = state->period;
+
+		pre_div = DIV64_U64_ROUND_UP((period * pdata->pwm_refclk_freq - NSEC_PER_SEC),
+					     ((u64)NSEC_PER_SEC * BACKLIGHT_SCALE_MAX));
+		scale = div64_u64(period * pdata->pwm_refclk_freq - NSEC_PER_SEC,
+				  (u64)NSEC_PER_SEC * pre_div);
+
+		/*
+		 * The documentation has the duty ratio given as:
+		 *
+		 *     duty          BACKLIGHT
+		 *   ------- = ---------------------
+		 *    period    BACKLIGHT_SCALE + 1
+		 *
+		 * Solve for BACKLIGHT gives us:
+		 */
+		actual = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (pre_div * scale + 1),
+					  pdata->pwm_refclk_freq);
+		backlight = div64_u64(state->duty_cycle * (scale + 1), actual);
+		if (backlight > scale)
+			backlight = scale;
+
+		ret = regmap_write(pdata->regmap, SN_PWM_PRE_DIV_REG, pre_div);
+		if (ret) {
+			dev_err(pdata->dev, "failed to update PWM_PRE_DIV\n");
+			goto out;
+		}
+
+		ti_sn65dsi86_write_u16(pdata, SN_BACKLIGHT_SCALE_REG, scale);
+		ti_sn65dsi86_write_u16(pdata, SN_BACKLIGHT_REG, backlight);
+	}
+
+	pwm_en_inv = FIELD_PREP(SN_PWM_EN_MASK, !!state->enabled) |
+		     FIELD_PREP(SN_PWM_INV_MASK, state->polarity == PWM_POLARITY_INVERSED);
+	ret = regmap_write(pdata->regmap, SN_PWM_EN_INV_REG, pwm_en_inv);
+	if (ret) {
+		dev_err(pdata->dev, "failed to update PWM_EN/PWM_INV\n");
+		goto out;
+	}
+
+	pdata->pwm_enabled = !!state->enabled;
+out:
+
+	if (!pdata->pwm_enabled)
+		pm_runtime_put_sync(pdata->dev);
+
+	return ret;
+}
+
+static void ti_sn_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct ti_sn65dsi86 *pdata = pwm_chip_to_ti_sn_bridge(chip);
+	unsigned int pwm_en_inv;
+	unsigned int pre_div;
+	u16 backlight;
+	u16 scale;
+	int ret;
+
+	ret = regmap_read(pdata->regmap, SN_PWM_EN_INV_REG, &pwm_en_inv);
+	if (ret)
+		return;
+
+	ret = ti_sn65dsi86_read_u16(pdata, SN_BACKLIGHT_SCALE_REG, &scale);
+	if (ret)
+		return;
+
+	ret = ti_sn65dsi86_read_u16(pdata, SN_BACKLIGHT_REG, &backlight);
+	if (ret)
+		return;
+
+	ret = regmap_read(pdata->regmap, SN_PWM_PRE_DIV_REG, &pre_div);
+	if (ret)
+		return;
+
+	state->enabled = FIELD_GET(SN_PWM_EN_MASK, pwm_en_inv);
+	if (FIELD_GET(SN_PWM_INV_MASK, pwm_en_inv))
+		state->polarity = PWM_POLARITY_INVERSED;
+	else
+		state->polarity = PWM_POLARITY_NORMAL;
+
+	state->period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * (pre_div * scale + 1), pdata->pwm_refclk_freq);
+	state->duty_cycle = DIV_ROUND_UP_ULL(state->period * backlight, scale + 1);
+}
+
+static const struct pwm_ops ti_sn_pwm_ops = {
+	.request = ti_sn_pwm_request,
+	.free = ti_sn_pwm_free,
+	.apply = ti_sn_pwm_apply,
+	.get_state = ti_sn_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int ti_sn_pwm_probe(struct auxiliary_device *adev,
+		const struct auxiliary_device_id *id)
+{
+	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
+
+	pdata->pchip.dev = pdata->dev;
+	pdata->pchip.ops = &ti_sn_pwm_ops;
+	pdata->pchip.npwm = 1;
+	pdata->pchip.of_xlate = of_pwm_single_xlate;
+	pdata->pchip.of_pwm_n_cells = 1;
+
+	return pwmchip_add(&pdata->pchip);
+}
+
+static void ti_sn_pwm_remove(struct auxiliary_device *adev)
+{
+	struct ti_sn65dsi86 *pdata = dev_get_drvdata(adev->dev.parent);
+
+	pwmchip_remove(&pdata->pchip);
+
+	if (pdata->pwm_enabled)
+		pm_runtime_put_sync(pdata->dev);
+}
+
+static const struct auxiliary_device_id ti_sn_pwm_id_table[] = {
+	{ .name = "ti_sn65dsi86.pwm", },
+	{},
+};
+
+static struct auxiliary_driver ti_sn_pwm_driver = {
+	.name = "pwm",
+	.probe = ti_sn_pwm_probe,
+	.remove = ti_sn_pwm_remove,
+	.id_table = ti_sn_pwm_id_table,
+};
+
+static int __init ti_sn_pwm_register(void)
+{
+	return auxiliary_driver_register(&ti_sn_pwm_driver);
+}
+
+static void ti_sn_pwm_unregister(void)
+{
+	auxiliary_driver_unregister(&ti_sn_pwm_driver);
+}
+
+#else
+static inline int ti_sn_pwm_pin_request(struct ti_sn65dsi86 *pdata) { return 0; }
+static inline void ti_sn_pwm_pin_release(struct ti_sn65dsi86 *pdata) {}
+
+static inline int ti_sn_pwm_register(void) { return 0; }
+static inline void ti_sn_pwm_unregister(void) {}
+#endif
+
 #if defined(CONFIG_OF_GPIO)
 
 static int tn_sn_bridge_of_xlate(struct gpio_chip *chip,
@@ -1176,10 +1488,26 @@ static int ti_sn_bridge_gpio_direction_output(struct gpio_chip *chip,
 	return ret;
 }
 
+static int ti_sn_bridge_gpio_request(struct gpio_chip *chip, unsigned int offset)
+{
+	struct ti_sn65dsi86 *pdata = gpiochip_get_data(chip);
+
+	if (offset == SN_PWM_GPIO_IDX)
+		return ti_sn_pwm_pin_request(pdata);
+
+	return 0;
+}
+
+
 static void ti_sn_bridge_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
+	struct ti_sn65dsi86 *pdata = gpiochip_get_data(chip);
+
 	/* We won't keep pm_runtime if we're input, so switch there on free */
 	ti_sn_bridge_gpio_direction_input(chip, offset);
+
+	if (offset == SN_PWM_GPIO_IDX)
+		ti_sn_pwm_pin_release(pdata);
 }
 
 static const char * const ti_sn_bridge_gpio_names[SN_NUM_GPIOS] = {
@@ -1201,6 +1529,7 @@ static int ti_sn_gpio_probe(struct auxiliary_device *adev,
 	pdata->gchip.owner = THIS_MODULE;
 	pdata->gchip.of_xlate = tn_sn_bridge_of_xlate;
 	pdata->gchip.of_gpio_n_cells = 2;
+	pdata->gchip.request = ti_sn_bridge_gpio_request;
 	pdata->gchip.free = ti_sn_bridge_gpio_free;
 	pdata->gchip.get_direction = ti_sn_bridge_gpio_get_direction;
 	pdata->gchip.direction_input = ti_sn_bridge_gpio_direction_input;
@@ -1500,6 +1829,12 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
 			return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_PWM)) {
+		ret = ti_sn65dsi86_add_aux_device(pdata, &pdata->pwm_aux, "pwm");
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * NOTE: At the end of the AUX channel probe we'll add the aux device
 	 * for the bridge. This is because the bridge can't be used until the
@@ -1543,10 +1878,14 @@ static int __init ti_sn65dsi86_init(void)
 	if (ret)
 		goto err_main_was_registered;
 
-	ret = auxiliary_driver_register(&ti_sn_aux_driver);
+	ret = ti_sn_pwm_register();
 	if (ret)
 		goto err_gpio_was_registered;
 
+	ret = auxiliary_driver_register(&ti_sn_aux_driver);
+	if (ret)
+		goto err_pwm_was_registered;
+
 	ret = auxiliary_driver_register(&ti_sn_bridge_driver);
 	if (ret)
 		goto err_aux_was_registered;
@@ -1555,6 +1894,8 @@ static int __init ti_sn65dsi86_init(void)
 
 err_aux_was_registered:
 	auxiliary_driver_unregister(&ti_sn_aux_driver);
+err_pwm_was_registered:
+	ti_sn_pwm_unregister();
 err_gpio_was_registered:
 	ti_sn_gpio_unregister();
 err_main_was_registered:
@@ -1568,6 +1909,7 @@ static void __exit ti_sn65dsi86_exit(void)
 {
 	auxiliary_driver_unregister(&ti_sn_bridge_driver);
 	auxiliary_driver_unregister(&ti_sn_aux_driver);
+	ti_sn_pwm_unregister();
 	ti_sn_gpio_unregister();
 	i2c_del_driver(&ti_sn65dsi86_driver);
 }
-- 
2.31.0

