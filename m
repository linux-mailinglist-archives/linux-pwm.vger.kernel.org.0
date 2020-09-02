Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9225925AAE8
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgIBMM5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 08:12:57 -0400
Received: from smtp1.axis.com ([195.60.68.17]:61016 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIBMMu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 2 Sep 2020 08:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=6867; q=dns/txt; s=axis-central1;
  t=1599048770; x=1630584770;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ip3VtO7k6LwWujnwUQKx9Wyf+0HrQ1MaLXhrhQUI6gc=;
  b=O4TEDdUdHRbQ8AikhBfcCblIFDrHTHVtqeK26Yuj6Vi5aY0lX9robDv4
   rb/8b9mS3nFmwT6m1l0keqaavJOwAKGLx6Bvme+miSZKYy4ax/05j6KLl
   tS2pBHWJoh9+Qu1bmqPyfML2lcIfknVMu63uVEk7IHYYON0q8UwzyVTAj
   Rheu8kKr7ZWGovlzdR2/N/UqTuGfVoTRJKrxNcQo7iz1LXtO/tLpNsXZW
   q55SC8LQ27S83c3dGfSYLiBhwq0YZpDUpZyz5G8k2VKpc/cXE8fWEpG5p
   ruAbEdGi7LADDKLVXkVXYrLbyL2cpQjMz0Mcyop47UYfSCa82IO2Q9xED
   A==;
IronPort-SDR: ENdkKUh1lPR481Pk/V38pdb3k/Lfb+VRC/It9xCiJ9zS/VnUhzrzaGBtZbd6mdCcVkRwnUeUOF
 wp/0MkdkfgU7Bs/enMbybWfuncb1qIsMzAJZotforXyw4sJXdWEZBWUkqLrq01YamoiM/9QLnP
 EYrKlzKBpz8OC9cnUe6nW/PkppSc5WzOaLI0skCzqM9w6dFXXlvrMahaxGFU+XyQlLPY+Vcig7
 nSSB7XFK2nYuVmFc7jq2xywDbtpAOPpYinypPDPYV9e1yMyEqnfm8NZy1+89i1D6OAiJeTfDBP
 mes=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="12474750"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>
CC:     <kernel@axis.com>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <oliver@schinagl.nl>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 0/2] GPIO PWM driver
Date:   Wed, 2 Sep 2020 14:12:34 +0200
Message-ID: <20200902121236.20514-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a software PWM which toggles a GPIO from a high-resolution timer.

This will naturally not be as accurate or as efficient as a hardware
PWM, but it is useful in some cases.  I have for example used it for
evaluating LED brightness handling (via leds-pwm) on a board where the
LED was just hooked up to a GPIO, and for a simple verification of the
timer frequency on another platform.

v2:
 - Rename gpio to gpios in binding
 - Calculate next expiry from expected current expiry rather than "now"
 - Only change configuration after current period ends
 - Implement get_state()
 - Add error message for probe failures
 - Stop PWM before unregister

Vincent Whitchurch (2):
  dt-bindings: pwm: Add pwm-gpio
  pwm: Add GPIO PWM driver

 .../devicetree/bindings/pwm/pwm-gpio.yaml     |  29 +++
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-gpio.c                        | 195 ++++++++++++++++++
 4 files changed, 235 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
 create mode 100644 drivers/pwm/pwm-gpio.c

Range-diff:
1:  0e672c567516 ! 1:  9efea8f7fb29 dt-bindings: pwm: Add pwm-gpio
    @@ Documentation/devicetree/bindings/pwm/pwm-gpio.yaml (new)
     +  "#pwm-cells":
     +    const: 2
     +
    -+  gpio:
    ++  gpios:
     +    maxItems: 1
     +    description: GPIO to toggle.
     +
2:  c9df282b1bd4 ! 2:  f5a4a9391e78 pwm: Add GPIO PWM driver
    @@ drivers/pwm/pwm-gpio.c (new)
     +
     +#include <linux/gpio/consumer.h>
     +#include <linux/platform_device.h>
    ++#include <linux/spinlock.h>
     +#include <linux/hrtimer.h>
     +#include <linux/module.h>
     +#include <linux/slab.h>
    @@ drivers/pwm/pwm-gpio.c (new)
     +	struct pwm_chip chip;
     +	struct hrtimer hrtimer;
     +	struct gpio_desc *gpio;
    -+	ktime_t on_interval;
    -+	ktime_t off_interval;
    -+	bool invert;
    -+	bool on;
    ++	struct pwm_state state;
    ++	struct pwm_state nextstate;
    ++	spinlock_t lock;
    ++	bool changing;
    ++	bool running;
    ++	bool level;
     +};
     +
    ++static unsigned long pwm_gpio_toggle(struct pwm_gpio *gpwm, bool level)
    ++{
    ++	const struct pwm_state *state = &gpwm->state;
    ++	bool invert = state->polarity == PWM_POLARITY_INVERSED;
    ++
    ++	gpwm->level = level;
    ++	gpiod_set_value(gpwm->gpio, gpwm->level ^ invert);
    ++
    ++	if (!state->duty_cycle || state->duty_cycle == state->period) {
    ++		gpwm->running = false;
    ++		return 0;
    ++	}
    ++
    ++	gpwm->running = true;
    ++	return level ? state->duty_cycle : state->period - state->duty_cycle;
    ++}
    ++
     +static enum hrtimer_restart pwm_gpio_timer(struct hrtimer *hrtimer)
     +{
     +	struct pwm_gpio *gpwm = container_of(hrtimer, struct pwm_gpio, hrtimer);
    -+	bool newon = !gpwm->on;
    ++	unsigned long nexttoggle;
    ++	unsigned long flags;
    ++	bool newlevel;
    ++
    ++	spin_lock_irqsave(&gpwm->lock, flags);
    ++
    ++	/* Apply new state at end of current period */
    ++	if (!gpwm->level && gpwm->changing) {
    ++		gpwm->changing = false;
    ++		gpwm->state = gpwm->nextstate;
    ++		newlevel = !!gpwm->state.duty_cycle;
    ++	} else {
    ++		newlevel = !gpwm->level;
    ++	}
     +
    -+	gpwm->on = newon;
    -+	gpiod_set_value(gpwm->gpio, newon ^ gpwm->invert);
    ++	nexttoggle = pwm_gpio_toggle(gpwm, newlevel);
    ++	if (nexttoggle)
    ++		hrtimer_forward(hrtimer, hrtimer_get_expires(hrtimer),
    ++				ns_to_ktime(nexttoggle));
     +
    -+	hrtimer_forward_now(hrtimer, newon ? gpwm->on_interval : gpwm->off_interval);
    ++	spin_unlock_irqrestore(&gpwm->lock, flags);
     +
    -+	return HRTIMER_RESTART;
    ++	return nexttoggle ? HRTIMER_RESTART : HRTIMER_NORESTART;
     +}
     +
     +static int pwm_gpio_apply(struct pwm_chip *chip, struct pwm_device *pwm,
     +			  const struct pwm_state *state)
     +{
     +	struct pwm_gpio *gpwm = container_of(chip, struct pwm_gpio, chip);
    ++	unsigned long flags;
     +
    -+	hrtimer_cancel(&gpwm->hrtimer);
    ++	if (!state->enabled)
    ++		hrtimer_cancel(&gpwm->hrtimer);
    ++
    ++	spin_lock_irqsave(&gpwm->lock, flags);
     +
     +	if (!state->enabled) {
    ++		gpwm->state = *state;
    ++		gpwm->running = false;
    ++		gpwm->changing = false;
    ++
     +		gpiod_set_value(gpwm->gpio, 0);
    -+		return 0;
    ++	} else if (gpwm->running) {
    ++		gpwm->nextstate = *state;
    ++		gpwm->changing = true;
    ++	} else {
    ++		unsigned long nexttoggle;
    ++
    ++		gpwm->state = *state;
    ++		gpwm->changing = false;
    ++
    ++		nexttoggle = pwm_gpio_toggle(gpwm, !!state->duty_cycle);
    ++		if (nexttoggle)
    ++			hrtimer_start(&gpwm->hrtimer, nexttoggle,
    ++				      HRTIMER_MODE_REL);
     +	}
     +
    -+	gpwm->on_interval = ns_to_ktime(state->duty_cycle);
    -+	gpwm->off_interval = ns_to_ktime(state->period - state->duty_cycle);
    -+	gpwm->invert = state->polarity == PWM_POLARITY_INVERSED;
    ++	spin_unlock_irqrestore(&gpwm->lock, flags);
    ++
    ++	return 0;
    ++}
    ++
    ++static void pwm_gpio_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
    ++			       struct pwm_state *state)
    ++{
    ++	struct pwm_gpio *gpwm = container_of(chip, struct pwm_gpio, chip);
    ++	unsigned long flags;
     +
    -+	gpwm->on = !!gpwm->on_interval;
    -+	gpiod_set_value(gpwm->gpio, gpwm->on ^ gpwm->invert);
    ++	spin_lock_irqsave(&gpwm->lock, flags);
     +
    -+	if (gpwm->on_interval && gpwm->off_interval)
    -+		hrtimer_start(&gpwm->hrtimer, gpwm->on_interval, HRTIMER_MODE_REL);
    ++	if (gpwm->changing)
    ++		*state = gpwm->nextstate;
    ++	else
    ++		*state = gpwm->state;
     +
    -+	return 0;
    ++	spin_unlock_irqrestore(&gpwm->lock, flags);
     +}
     +
     +static const struct pwm_ops pwm_gpio_ops = {
     +	.owner = THIS_MODULE,
     +	.apply = pwm_gpio_apply,
    ++	.get_state = pwm_gpio_get_state,
     +};
     +
     +static int pwm_gpio_probe(struct platform_device *pdev)
     +{
    ++	struct device *dev = &pdev->dev;
     +	struct pwm_gpio *gpwm;
     +	int ret;
     +
    -+	gpwm = devm_kzalloc(&pdev->dev, sizeof(*gpwm), GFP_KERNEL);
    ++	gpwm = devm_kzalloc(dev, sizeof(*gpwm), GFP_KERNEL);
     +	if (!gpwm)
     +		return -ENOMEM;
     +
    -+	gpwm->gpio = devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
    ++	spin_lock_init(&gpwm->lock);
    ++
    ++	gpwm->gpio = devm_gpiod_get(dev, NULL, GPIOD_OUT_LOW);
     +	if (IS_ERR(gpwm->gpio))
    -+		return PTR_ERR(gpwm->gpio);
    ++		return dev_err_probe(dev, PTR_ERR(gpwm->gpio),
    ++				     "could not get gpio\n");
     +
     +	if (gpiod_cansleep(gpwm->gpio))
    -+		return -EINVAL;
    ++		return dev_err_probe(dev, -EINVAL,
    ++				     "sleeping GPIOs not supported\n");
     +
    -+	gpwm->chip.dev = &pdev->dev;
    ++	gpwm->chip.dev = dev;
     +	gpwm->chip.ops = &pwm_gpio_ops;
     +	gpwm->chip.base = pdev->id;
     +	gpwm->chip.npwm = 1;
    @@ drivers/pwm/pwm-gpio.c (new)
     +
     +	ret = pwmchip_add(&gpwm->chip);
     +	if (ret < 0)
    -+		return ret;
    ++		return dev_err_probe(dev, ret,
    ++				     "could not add pwmchip\n");
     +
     +	platform_set_drvdata(pdev, gpwm);
     +
    @@ drivers/pwm/pwm-gpio.c (new)
     +{
     +	struct pwm_gpio *gpwm = platform_get_drvdata(pdev);
     +
    ++	pwm_disable(&gpwm->chip.pwms[0]);
    ++
     +	return pwmchip_remove(&gpwm->chip);
     +}
     +
-- 
2.28.0

