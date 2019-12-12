Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2128D11D85F
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Dec 2019 22:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbfLLVOi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Dec 2019 16:14:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51505 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbfLLVOi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Dec 2019 16:14:38 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ifVn9-0000px-7j; Thu, 12 Dec 2019 22:14:35 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ifVn8-00064Q-CM; Thu, 12 Dec 2019 22:14:34 +0100
Date:   Thu, 12 Dec 2019 22:14:34 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191212211434.455trhnlcvn26zl6@pengutronix.de>
References: <20191129191023.2209-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191129191023.2209-1-miquel.raynal@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Nov 29, 2019 at 08:10:23PM +0100, Miquel Raynal wrote:
> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes in v4:
> * Fix wrong comment about register value.
> * Rewrite ->set_state() to make it more readable, include the fact
>   that the phase may blink and to limit the number of blink changes
>   when possible ("lazy switching" as discussed with Uwe).
> * Prevent using managed memory when not relevant.
> * Add a definition to the master intensity shift.
> * Rename all struct pwm_device to pwm and all struct pwm_chip as
>   chip. Then, struct pca953x_chip are called pca_chip instead of chip
>   and struct max7313_pwm are called max_pwm intead of pwm.
> * Enhance the comment about glitch-free hardware.
> * Add a plain error check at the ->pwm_probe() return location.
> * Rename duty_cycle to intensity when relevant.
> * Do not initialize the PWM in ->request(). Also do not change the
>   state in ->free().
> * New way to count enabled/disabled PWM (with a bitmap). Disable the
>   oscillator only when 0 PWM are in use, enable it when there is
>   one. Also always set the pin to output state otherwise the default
>   might be input.
> * Force state->enable to be true and drop all the boilerplate around
>   enable and .duty_cycle.
> 
> Changes in v3:
> * Added two error messages in ->request().
> * Protected the PWM count agains races with an additional mutex.
> * Dropped an useless check on the period value in ->apply().
> * Forced the .period to be constant.
> * Checked state->polarity when needed.
> * Used DIV_ROUND_DOWN_ULL for computing the duty_cycle.
> * Implemented ->get_state().
> * Added a comment to explain that the GPIO functionality is not harmed
>   by the global intensity setting.
> 
> Changes in v2:
> * Removed the hardcoding of PWM_CHANNELS, changed the code to use the
>   number of GPIO lines which is programatically known.
> * Used per pwm_device chip data to store the GPIO descriptors instead
>   of having a static array of GPIO descriptors in the private PWM
>   structure. It also enhanced the readability.
> * Rename an offset variable: s/off/shift/.
> * The default PWM state is now static low instead of input.
> * Used the GPIO as regular consumer thanks to the stored GPIO
>   descriptors to "make it more idiomatic" (requested by Thierry).
> * Used gpiochip_request_own_desc() instead of
>   gpio_to_desc()/gpiod_request(). This prevented the build issue and
>   an additional dependency that would have requested a DEPENDS ON line
>   in Kconfig.
> * Enhanced the return line of max7313_pwm_probe().
> 
> 
>  drivers/gpio/gpio-pca953x.c | 375 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 373 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index de5d1383f28d..347988bc630f 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -10,20 +10,25 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/bits.h>
> +#include <linux/bitmap.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/i2c.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_data/pca953x.h>
> +#include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
>  #include <asm/unaligned.h>
>  
> +#include "gpiolib.h"
> +
>  #define PCA953X_INPUT		0x00
>  #define PCA953X_OUTPUT		0x01
>  #define PCA953X_INVERT		0x02
> @@ -63,11 +68,18 @@
>  
>  #define PCA_INT			BIT(8)
>  #define PCA_PCAL		BIT(9)
> +#define MAX_PWM			BIT(10)
>  #define PCA_LATCH_INT		(PCA_PCAL | PCA_INT)
>  #define PCA953X_TYPE		BIT(12)
>  #define PCA957X_TYPE		BIT(13)
>  #define PCA_TYPE_MASK		GENMASK(15, 12)
>  
> +#define MAX7313_MASTER		0x0E
> +#define MAX7313_CONFIGURATION	0x0F
> +#define MAX7313_INTENSITY	0x10
> +
> +#define MAX7313_GLOB_INTENSITY	BIT(2)
> +
>  #define PCA_CHIP_TYPE(x)	((x) & PCA_TYPE_MASK)
>  
>  static const struct i2c_device_id pca953x_id[] = {
> @@ -93,7 +105,7 @@ static const struct i2c_device_id pca953x_id[] = {
>  
>  	{ "max7310", 8  | PCA953X_TYPE, },
>  	{ "max7312", 16 | PCA953X_TYPE | PCA_INT, },
> -	{ "max7313", 16 | PCA953X_TYPE | PCA_INT, },
> +	{ "max7313", 16 | PCA953X_TYPE | PCA_INT | MAX_PWM, },
>  	{ "max7315", 8  | PCA953X_TYPE | PCA_INT, },
>  	{ "max7318", 16 | PCA953X_TYPE | PCA_INT, },
>  	{ "pca6107", 8  | PCA953X_TYPE | PCA_INT, },
> @@ -118,6 +130,16 @@ MODULE_DEVICE_TABLE(acpi, pca953x_acpi_ids);
>  
>  #define NBANK(chip) DIV_ROUND_UP(chip->gpio_chip.ngpio, BANK_SZ)
>  
> +#define PWM_MAX_COUNT 16
> +#define PWM_PER_REG 2
> +#define PWM_BITS_PER_REG (8 / PWM_PER_REG)
> +#define PWM_MASTER_INTENSITY_SHIFT 4
> +#define PWM_INTENSITY_MASK GENMASK(PWM_BITS_PER_REG - 1, 0)
> +
> +#define PWM_PERIOD_NS 31250
> +#define PWM_DC_STATES 16
> +#define PWM_OFFSET_NS (PWM_PERIOD_NS / PWM_DC_STATES)
> +
>  struct pca953x_reg_config {
>  	int direction;
>  	int output;
> @@ -139,6 +161,20 @@ static const struct pca953x_reg_config pca957x_regs = {
>  	.invert = PCA957X_INVRT,
>  };
>  
> +struct max7313_pwm_data {
> +	struct gpio_desc *desc;
> +};
> +
> +struct max7313_pwm {
> +	struct pwm_chip chip;
> +	/*
> +	 * Protect races when counting active PWMs for enabling or disabling
> +	 * the internal oscillator.
> +	 */
> +	struct mutex count_lock;
> +	DECLARE_BITMAP(active_pwm, PWM_MAX_COUNT);
> +};
> +
>  struct pca953x_chip {
>  	unsigned gpio_start;
>  	struct mutex i2c_lock;
> @@ -161,6 +197,8 @@ struct pca953x_chip {
>  	struct regulator *regulator;
>  
>  	const struct pca953x_reg_config *regs;
> +
> +	struct max7313_pwm pwm;
>  };
>  
>  static int pca953x_bank_shift(struct pca953x_chip *chip)
> @@ -241,8 +279,16 @@ static bool pca953x_check_register(struct pca953x_chip *chip, unsigned int reg,
>  static bool pca953x_readable_register(struct device *dev, unsigned int reg)
>  {
>  	struct pca953x_chip *chip = dev_get_drvdata(dev);
> +	unsigned int bank_sz = chip->driver_data & PCA_GPIO_MASK;
>  	u32 bank;
>  
> +	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE &&
> +	    chip->driver_data & MAX_PWM) {
> +		if (reg >= MAX7313_MASTER &&
> +		    reg < (MAX7313_INTENSITY + bank_sz))
> +			return true;
> +	}
> +
>  	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
>  		bank = PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
>  		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
> @@ -264,8 +310,16 @@ static bool pca953x_readable_register(struct device *dev, unsigned int reg)
>  static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
>  {
>  	struct pca953x_chip *chip = dev_get_drvdata(dev);
> +	unsigned int bank_sz = chip->driver_data & PCA_GPIO_MASK;
>  	u32 bank;
>  
> +	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE &&
> +	    chip->driver_data & MAX_PWM) {
> +		if (reg >= MAX7313_MASTER &&
> +		    reg < (MAX7313_INTENSITY + bank_sz))
> +			return true;
> +	}
> +
>  	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
>  		bank = PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
>  			PCA953x_BANK_CONFIG;
> @@ -886,6 +940,315 @@ static int device_pca957x_init(struct pca953x_chip *chip, u32 invert)
>  	return ret;
>  }
>  
> +/*
> + * Max7313 PWM specific methods
> + *
> + * Limitations:
> + * - Does not support a disabled state
> + * - Period fixed to 31.25ms
> + * - Only supports normal polarity
> + * - Some glitches cannot be prevented
> + */
> +
> +static struct max7313_pwm *to_max7313_pwm(struct pwm_chip *chip)
> +{
> +	return container_of(chip, struct max7313_pwm, chip);
> +}
> +
> +static struct pca953x_chip *to_pca953x(struct max7313_pwm *chip)
> +{
> +	return container_of(chip, struct pca953x_chip, pwm);
> +}
> +
> +static u8 max7313_pwm_get_intensity(struct pca953x_chip *pca_chip,
> +				    unsigned int idx)
> +{
> +	unsigned int reg, shift, val, output;
> +	u8 intensity;
> +	bool phase;
> +
> +	/* Retrieve the intensity */
> +	reg = MAX7313_INTENSITY + (idx / PWM_PER_REG);
> +	shift = (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	regmap_read(pca_chip->regmap, reg, &val);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +
> +	if (shift)
> +		val >>= shift;
> +
> +	val &= PWM_INTENSITY_MASK;
> +
> +	/* Retrieve the phase */
> +	reg = pca953x_recalc_addr(pca_chip, pca_chip->regs->output, idx, 0, 0);
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	regmap_read(pca_chip->regmap, reg, &output);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +
> +	phase = output & BIT(idx % BANK_SZ);
> +
> +	/*
> +	 * Register values in the [0;15] range mean a value in the [1/16;16/16]
> +	 * range if the phase is set, a [15/16;0/16] range otherwise.
> +	 */
> +	if (phase)
> +		intensity = val + 1;
> +	else
> +		intensity = PWM_INTENSITY_MASK - val;
> +
> +	return intensity;
> +}
> +
> +static int max7313_pwm_set_intensity(struct pca953x_chip *pca_chip,
> +				     unsigned int idx, u8 intensity)
> +{
> +	unsigned int reg, shift;
> +	u8 val, mask;
> +	int ret;
> +
> +	reg = MAX7313_INTENSITY + (idx / PWM_PER_REG);
> +	shift = (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
> +
> +	mask = PWM_INTENSITY_MASK << shift;
> +	val = (intensity & PWM_INTENSITY_MASK) << shift;
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret = regmap_write_bits(pca_chip->regmap, reg, mask, val);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * For a given PWM channel, when the blink phase 0 bit is set, the intensity
> + * range is only [1/16;16/16]. With this range, a static low output is
> + * physically not possible. When the blink phase 0 bit is cleared, the intensity
> + * range is [15/16;0/16] which then allows a static low output but not a static
> + * high output.
> + *
> + * In this driver we choose to switch the blink phase only when mandatory
> + * because there is no way to atomically flip the register *and* change the PWM
> + * value at the same time so, in this case, it will produce a small glitch.
> + */
> +static int max7313_pwm_set_state(struct pca953x_chip *pca_chip,
> +				 struct pwm_device *pwm,
> +				 unsigned int intensity)
> +{
> +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm);
> +	struct gpio_desc *desc = data->desc;
> +	unsigned int idx = pwm->hwpwm, reg, output;
> +	bool phase;
> +	int ret;
> +
> +	/* Retrieve the phase */
> +	reg = pca953x_recalc_addr(pca_chip, pca_chip->regs->output, idx, 0, 0);
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	regmap_read(pca_chip->regmap, reg, &output);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +
> +	phase = output & BIT(idx % BANK_SZ);
> +
> +	/* Need to blink the phase */
> +	if ((phase && !intensity) || (!phase && intensity == PWM_DC_STATES)) {
> +		phase = !phase;
> +		ret = gpiod_direction_output(desc, phase);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* Ensure the pin is in output state (default might be input) */
> +		ret = gpiod_direction_output(desc, phase);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (phase)
> +		intensity = intensity - 1;
> +	else
> +		intensity = PWM_INTENSITY_MASK - intensity;
> +
> +	return max7313_pwm_set_intensity(pca_chip, idx, intensity);
> +}
> +
> +static int max7313_pwm_set_master_intensity(struct pca953x_chip *pca_chip,
> +					    u8 intensity)
> +{
> +	int ret;
> +
> +	intensity &= PWM_INTENSITY_MASK;
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret = regmap_write_bits(pca_chip->regmap, MAX7313_MASTER,
> +				PWM_INTENSITY_MASK << PWM_MASTER_INTENSITY_SHIFT,
> +				intensity << PWM_MASTER_INTENSITY_SHIFT);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +
> +	return ret;
> +}
> +
> +static int max7313_pwm_request(struct pwm_chip *chip,
> +			       struct pwm_device *pwm)
> +{
> +	struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> +	struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> +	struct max7313_pwm_data *data;
> +	struct gpio_desc *desc;
> +
> +	desc = gpiochip_request_own_desc(&pca_chip->gpio_chip, pwm->hwpwm,
> +					 "max7313-pwm", GPIO_ACTIVE_HIGH, 0);
> +	if (IS_ERR(desc)) {
> +		dev_err(&pca_chip->client->dev,
> +			"pin already in use (probably as GPIO): %ld\n",
> +			PTR_ERR(desc));
> +		return PTR_ERR(desc);
> +	}
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		gpiochip_free_own_desc(desc);
> +		return -ENOMEM;
> +	}
> +
> +	data->desc = desc;
> +	pwm_set_chip_data(pwm, data);
> +
> +	return 0;
> +}
> +
> +static void max7313_pwm_free(struct pwm_chip *chip,
> +			     struct pwm_device *pwm)
> +{
> +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm);
> +
> +	gpiochip_free_own_desc(data->desc);
> +	kfree(data);
> +}
> +
> +static int max7313_pwm_apply(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> +	struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> +	unsigned int intensity, active;
> +	int ret = 0;
> +
> +	if (!state->enabled ||
> +	    state->period < PWM_PERIOD_NS ||
> +	    state->polarity != PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	/* Convert the duty-cycle to be in the [0;16] range */
> +	intensity = DIV_ROUND_DOWN_ULL(state->duty_cycle,
> +				       state->period / PWM_DC_STATES);

this looks wrong. The period must not have an influence on the selection
of the duty_cycle (other than duty_cycle < period). So given that the
period is fixed at 31.25 ms, the result of

	pwm_apply_state(pwm, { .enabled = 1, .period = 2s, .duty_cycle = 16 ms })

must be the same as for

	pwm_apply_state(pwm, { .enabled = 1, .period = 3s, .duty_cycle = 16 ms })

. Also dividing by a division looses precision.

> +	/*
> +	 * If this is the first PWM to enable, set the master intensity to the
> +	 * maximum level to let individual outputs the greatest flexibility
> +	 * range. It also enables the internal oscillator.
> +	 *
> +	 * When shutting down the last active PWM, the oscillator is disabled.
> +	 *
> +	 * Lazy logic is applied to simplify the code: always enable the
> +	 * oscillator when there is 1 active pwm, always disable it when there
> +	 * is none.
> +	 */
> +	mutex_lock(&max_pwm->count_lock);
> +	if (intensity)
> +		set_bit(pwm->hwpwm, max_pwm->active_pwm);
> +	else
> +		clear_bit(pwm->hwpwm, max_pwm->active_pwm);
> +
> +	active = bitmap_weight(max_pwm->active_pwm, PWM_MAX_COUNT);
> +	if (!active)
> +		ret = max7313_pwm_set_master_intensity(pca_chip, 0);
> +	else if (active == 1)
> +		ret = max7313_pwm_set_master_intensity(pca_chip,
> +						       PWM_INTENSITY_MASK);
> +	mutex_unlock(&max_pwm->count_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The hardware is supposedly glitch-free when changing the intensity,
> +	 * unless we need to flip the blink phase to reach an extremity or the
> +	 * other of the spectre (0/16 from phase 1, 16/16 from phase 0).

I think you mean spectrum here, not spectre. :-)

> +	 */
> +	return max7313_pwm_set_state(pca_chip, pwm, intensity);
> +}
> +
> +static void max7313_pwm_get_state(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  struct pwm_state *state)
> +{
> +	struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> +	struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> +	u8 intensity;
> +
> +	state->enabled = true;
> +	state->period = PWM_PERIOD_NS;
> +	state->polarity = PWM_POLARITY_NORMAL;
> +
> +	intensity = max7313_pwm_get_intensity(pca_chip, pwm->hwpwm);
> +	state->duty_cycle = intensity * PWM_OFFSET_NS;

I think you need to take into account the blink phase bit.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
