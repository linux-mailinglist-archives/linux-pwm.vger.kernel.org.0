Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9951B20DB57
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2020 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbgF2UFr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 29 Jun 2020 16:05:47 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:41706 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388610AbgF2UFq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 16:05:46 -0400
X-Greylist: delayed 3217 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2020 16:05:42 EDT
Received: from relay7-d.mail.gandi.net (unknown [217.70.183.200])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id D140A3AB3DE;
        Mon, 29 Jun 2020 14:09:07 +0000 (UTC)
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0AA9F20009;
        Mon, 29 Jun 2020 14:08:45 +0000 (UTC)
Date:   Mon, 29 Jun 2020 16:08:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200629160844.6ecf79c1@xps13>
In-Reply-To: <20200503105453.23658-1-miquel.raynal@bootlin.com>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe, Thierry,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Sun,  3 May 2020
12:54:53 +0200:

> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Can I have a status on this patch please?

If it was forgotten, I would be good to have it queued now, otherwise,
may I know the reason?

Thanks!
Miquèl

> 
> Changes in v6:
> * Rebased on top of v5.7-rc3.
> * Added a call to max7313_pwm_remove() in pca953x_remove() to
>   eventually run pwmchip_remove().
> 
> Changes in v5:
> * Enhanced the derivation of the intensity from the duty_cycle and the
>   other way around by creating two helpers. These helpers use a more
>   precise fixed point calculation logic than before (multiply then
>   divide instead of the opposite).
> * The above change also takes into account that the period cannot be
>   changed, so it doest not matter the given period (as long as it is
>   considered as valid), the actual period used for it will be the one
>   of the IP (not the one given by the user).
> * Simplified #define's as suggested by Andy.
> * Simplified the check for the IP being compatible with these PWM bits
>   as proposed by Andy, also moved into a helper.
> * Added missing error checks on regmap_read(). As the main function
>   using it returns void, I decided to print a warning and return a
>   duty_cycle value of 0.
> * Removed a redundant condition.
> * Simplified the access to the device structure from the PWM chip
>   structure.
> * Used __assign_bit() instead of the set_bit()/clear_bit() couple.
> * I did not split the driver as I think it is too much work for me
>   right now.
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
>  drivers/gpio/gpio-pca953x.c | 413 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 411 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 5638b4e5355f..ba5e1af0d281 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -12,18 +12,22 @@
>  #include <linux/bitmap.h>
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
> @@ -63,11 +67,18 @@
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
> @@ -93,7 +104,7 @@ static const struct i2c_device_id pca953x_id[] = {
>  
>  	{ "max7310", 8  | PCA953X_TYPE, },
>  	{ "max7312", 16 | PCA953X_TYPE | PCA_INT, },
> -	{ "max7313", 16 | PCA953X_TYPE | PCA_INT, },
> +	{ "max7313", 16 | PCA953X_TYPE | PCA_INT | MAX_PWM, },
>  	{ "max7315", 8  | PCA953X_TYPE | PCA_INT, },
>  	{ "max7318", 16 | PCA953X_TYPE | PCA_INT, },
>  	{ "pca6107", 8  | PCA953X_TYPE | PCA_INT, },
> @@ -119,6 +130,15 @@ MODULE_DEVICE_TABLE(acpi, pca953x_acpi_ids);
>  
>  #define NBANK(chip) DIV_ROUND_UP(chip->gpio_chip.ngpio, BANK_SZ)
>  
> +#define PWM_MAX_COUNT 16
> +#define PWM_PER_REG 2
> +#define PWM_BITS_PER_REG 4
> +#define PWM_MASTER_INTENSITY_SHIFT 4
> +#define PWM_INTENSITY_MASK GENMASK(3, 0)
> +
> +#define PWM_PERIOD_NS 31250
> +#define PWM_DC_STATES 16
> +
>  struct pca953x_reg_config {
>  	int direction;
>  	int output;
> @@ -140,6 +160,20 @@ static const struct pca953x_reg_config pca957x_regs = {
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
> @@ -162,6 +196,8 @@ struct pca953x_chip {
>  	struct regulator *regulator;
>  
>  	const struct pca953x_reg_config *regs;
> +
> +	struct max7313_pwm pwm;
>  };
>  
>  static int pca953x_bank_shift(struct pca953x_chip *chip)
> @@ -239,11 +275,26 @@ static bool pca953x_check_register(struct pca953x_chip *chip, unsigned int reg,
>  	return true;
>  }
>  
> +static bool max7313_pwm_reg_is_accessible(struct device *dev, unsigned int reg)
> +{
> +	struct pca953x_chip *chip = dev_get_drvdata(dev);
> +	unsigned int bank_sz = chip->driver_data & PCA_GPIO_MASK;
> +
> +	if (reg >= MAX7313_MASTER && reg < (MAX7313_INTENSITY + bank_sz))
> +		return true;
> +
> +	return false;
> +}
> +
>  static bool pca953x_readable_register(struct device *dev, unsigned int reg)
>  {
>  	struct pca953x_chip *chip = dev_get_drvdata(dev);
>  	u32 bank;
>  
> +	if ((chip->driver_data & MAX_PWM) &&
> +	    max7313_pwm_reg_is_accessible(dev, reg))
> +		return true;
> +
>  	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
>  		bank = PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
>  		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
> @@ -267,6 +318,10 @@ static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
>  	struct pca953x_chip *chip = dev_get_drvdata(dev);
>  	u32 bank;
>  
> +	if ((chip->driver_data & MAX_PWM) &&
> +	    max7313_pwm_reg_is_accessible(dev, reg))
> +		return true;
> +
>  	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
>  		bank = PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
>  			PCA953x_BANK_CONFIG;
> @@ -854,6 +909,346 @@ static int device_pca957x_init(struct pca953x_chip *chip, u32 invert)
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
> +static unsigned int max7313_pwm_intensity_to_duty(u8 intensity)
> +{
> +	unsigned long long value = intensity;
> +
> +	return DIV_ROUND_DOWN_ULL(value * PWM_PERIOD_NS, PWM_DC_STATES);
> +}
> +
> +static u8 max7313_pwm_duty_to_intensity(unsigned int duty)
> +{
> +	unsigned long long value = duty;
> +
> +	return DIV_ROUND_DOWN_ULL(value * PWM_DC_STATES, PWM_PERIOD_NS);
> +}
> +
> +static u8 max7313_pwm_get_intensity(struct pca953x_chip *pca_chip,
> +				    unsigned int idx)
> +{
> +	struct device *dev = &pca_chip->client->dev;
> +	unsigned int reg, shift, val, output;
> +	u8 intensity;
> +	bool phase;
> +	int ret;
> +
> +	/* Retrieve the intensity */
> +	reg = MAX7313_INTENSITY + (idx / PWM_PER_REG);
> +	shift = (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret = regmap_read(pca_chip->regmap, reg, &val);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot retrieve PWM intensity (%d)\n", ret);
> +		return 0;
> +	}
> +
> +	val >>= shift;
> +	val &= PWM_INTENSITY_MASK;
> +
> +	/* Retrieve the phase */
> +	reg = pca953x_recalc_addr(pca_chip, pca_chip->regs->output, idx, 0, 0);
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret = regmap_read(pca_chip->regmap, reg, &output);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot retrieve PWM phase (%d)\n", ret);
> +		return 0;
> +	}
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
> +	ret = regmap_read(pca_chip->regmap, reg, &output);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +	if (ret < 0)
> +		return ret;
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
> +	struct device *dev = &pca_chip->client->dev;
> +	struct max7313_pwm_data *data;
> +	struct gpio_desc *desc;
> +
> +	desc = gpiochip_request_own_desc(&pca_chip->gpio_chip, pwm->hwpwm,
> +					 "max7313-pwm", GPIO_ACTIVE_HIGH, 0);
> +	if (IS_ERR(desc)) {
> +		dev_err(dev, "pin already in use (probably as GPIO): %ld\n",
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
> +	intensity = max7313_pwm_duty_to_intensity(state->duty_cycle);
> +
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
> +
> +	__assign_bit(pwm->hwpwm, max_pwm->active_pwm, (bool)intensity);
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
> +	 * other of the spectrum (0/16 from phase 1, 16/16 from phase 0).
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
> +	state->duty_cycle = max7313_pwm_intensity_to_duty(intensity);
> +};
> +
> +static const struct pwm_ops max7313_pwm_ops = {
> +	.request = max7313_pwm_request,
> +	.free = max7313_pwm_free,
> +	.apply = max7313_pwm_apply,
> +	.get_state = max7313_pwm_get_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int max7313_pwm_probe(struct device *dev,
> +			     struct pca953x_chip *pca_chip)
> +{
> +	struct max7313_pwm *max_pwm = &pca_chip->pwm;
> +	struct pwm_chip *chip = &max_pwm->chip;
> +	int ret, i;
> +
> +	if (!(pca_chip->driver_data & MAX_PWM))
> +		return 0;
> +
> +	chip->dev = dev;
> +	chip->ops = &max7313_pwm_ops;
> +	chip->npwm = pca_chip->gpio_chip.ngpio;
> +	chip->base = -1;
> +
> +	/* Disable global control (does not affect GPIO functionality) */
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret = regmap_write_bits(pca_chip->regmap, MAX7313_CONFIGURATION,
> +				MAX7313_GLOB_INTENSITY, 0);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&max_pwm->count_lock);
> +	bitmap_zero(max_pwm->active_pwm, PWM_MAX_COUNT);
> +
> +	/* Count currently active PWM */
> +	mutex_lock(&max_pwm->count_lock);
> +	for (i = 0; i < chip->npwm; i++) {
> +		if (max7313_pwm_get_intensity(pca_chip, i))
> +			set_bit(i, max_pwm->active_pwm);
> +	}
> +
> +	if (bitmap_weight(max_pwm->active_pwm, PWM_MAX_COUNT))
> +		ret = max7313_pwm_set_master_intensity(pca_chip,
> +						       PWM_INTENSITY_MASK);
> +
> +	mutex_unlock(&max_pwm->count_lock);
> +
> +	if (ret)
> +		return ret;
> +
> +	return pwmchip_add(chip);
> +}
> +
> +static int max7313_pwm_remove(struct pca953x_chip *pca_chip)
> +{
> +	struct max7313_pwm *max_pwm = &pca_chip->pwm;
> +	struct pwm_chip *chip = &max_pwm->chip;
> +
> +	if (!(pca_chip->driver_data & MAX_PWM))
> +		return 0;
> +
> +	return pwmchip_remove(chip);
> +}
> +
>  static int pca953x_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *i2c_id)
>  {
> @@ -983,6 +1378,14 @@ static int pca953x_probe(struct i2c_client *client,
>  			dev_warn(&client->dev, "setup failed, %d\n", ret);
>  	}
>  
> +	if (IS_ENABLED(CONFIG_PWM)) {
> +		ret = max7313_pwm_probe(&client->dev, chip);
> +		if (ret) {
> +			dev_err(&client->dev, "pwm probe failed, %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  
>  err_exit:
> @@ -996,6 +1399,12 @@ static int pca953x_remove(struct i2c_client *client)
>  	struct pca953x_chip *chip = i2c_get_clientdata(client);
>  	int ret;
>  
> +	if (IS_ENABLED(CONFIG_PWM)) {
> +		ret = max7313_pwm_remove(chip);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (pdata && pdata->teardown) {
>  		ret = pdata->teardown(client, chip->gpio_chip.base,
>  				      chip->gpio_chip.ngpio, pdata->context);
> @@ -1127,7 +1536,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
>  
>  	{ .compatible = "maxim,max7310", .data = OF_953X( 8, 0), },
>  	{ .compatible = "maxim,max7312", .data = OF_953X(16, PCA_INT), },
> -	{ .compatible = "maxim,max7313", .data = OF_953X(16, PCA_INT), },
> +	{ .compatible = "maxim,max7313", .data = OF_953X(16, PCA_INT | MAX_PWM), },
>  	{ .compatible = "maxim,max7315", .data = OF_953X( 8, PCA_INT), },
>  	{ .compatible = "maxim,max7318", .data = OF_953X(16, PCA_INT), },
>  
