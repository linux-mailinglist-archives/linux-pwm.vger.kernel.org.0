Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C0142A46
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 13:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgATMNg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 07:13:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38220 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgATMNg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 07:13:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id u2so14459293wmc.3;
        Mon, 20 Jan 2020 04:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7NBAyx4aE/1Vd/PutWKEgQtYjSqO1FybSkgkEp/1rg=;
        b=R1AtPP8MRqTw+YRBwW1xAB1Y8q1Qnn0D8stSpDGQH7enzdVzAFDZ5GnMVKDuCFDO1t
         sj35nP+qabFe62vT1WJ7BBDThacKRjDhClSfi1Yt97YM5mf2tHt6pmPHzFyUY5d2iMWw
         0gTXvViljs0mz3JBwNefk/Sva9uni2+Lehb7sqqdijAxtj891YjNM0QvnwapPvkMu0/J
         tXWwzwhfE67mguQyz8ZlmcHvLutMkUD5UWyAOIpG33pK1mVlnj2eczrf1x3hGA1N/kUS
         AEN4al7re9xZskRlMB3L+lp/ln/jcAD6x2pQ6XIsiALLUcvmR/GkTmatO0OMw/x2S7ar
         XRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7NBAyx4aE/1Vd/PutWKEgQtYjSqO1FybSkgkEp/1rg=;
        b=C8ykpn7XglKlriHbWnhXEVGr0GlUTJUFF9RHgzafeC7ygbzDR7339C0DsfAVANE/WO
         QwDGWtJy3bZe56rMUalgBcigoYy9DF/9LKSUinwQVWkkkCDRjE0qFwu+TPbpNJ4r6tie
         t+GnME/nxIB8Tor0NW4oTSUbYmK0wlBGYPiviA5iyKcOQS4RQKxgK3rn5vj664wtVLdJ
         mK47+nGSYFlPCQrcJCTPIhZIJxAzhHv7r3wbI3meibx5imyuJZ8R53ejYhtxA/69aClo
         J94bOCmUAElpcjw8oBwlj7RZuALOhgRlZ1dLLBCEL8zocMgHU4JfP8ReCAYDjlolYlu/
         QvNg==
X-Gm-Message-State: APjAAAVxmTQ4fEikNlD7Q6x6hIRDZT0PoN9RalRMHcZXRhRcZTSx+UoO
        CBV1Ems5kpp6w1jfDyIEZmo=
X-Google-Smtp-Source: APXvYqzr1IpijxvAl/SUo7KSstNlgCQRwjrHDPe4XAxwwrNyAOPigjE6JP5m1duQfLzjJJ9ZYVUpdA==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr17819558wme.125.1579522411867;
        Mon, 20 Jan 2020 04:13:31 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id a5sm22702643wmb.37.2020.01.20.04.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 04:13:30 -0800 (PST)
Date:   Mon, 20 Jan 2020 13:13:29 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200120121329.GC206171@ulmo>
References: <20200107133130.1338-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8NvZYKFJsRX2Djef"
Content-Disposition: inline
In-Reply-To: <20200107133130.1338-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--8NvZYKFJsRX2Djef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 02:31:30PM +0100, Miquel Raynal wrote:
> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>=20
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
>=20
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
>=20
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
>=20
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
>=20
>  drivers/gpio/gpio-pca953x.c | 396 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 394 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 9853547e7276..cb9343f05434 100644
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
> =20
>  #include <asm/unaligned.h>
> =20
> +#include "gpiolib.h"
> +
>  #define PCA953X_INPUT		0x00
>  #define PCA953X_OUTPUT		0x01
>  #define PCA953X_INVERT		0x02
> @@ -63,11 +67,18 @@
> =20
>  #define PCA_INT			BIT(8)
>  #define PCA_PCAL		BIT(9)
> +#define MAX_PWM			BIT(10)
>  #define PCA_LATCH_INT		(PCA_PCAL | PCA_INT)
>  #define PCA953X_TYPE		BIT(12)
>  #define PCA957X_TYPE		BIT(13)
>  #define PCA_TYPE_MASK		GENMASK(15, 12)
> =20
> +#define MAX7313_MASTER		0x0E
> +#define MAX7313_CONFIGURATION	0x0F
> +#define MAX7313_INTENSITY	0x10
> +
> +#define MAX7313_GLOB_INTENSITY	BIT(2)
> +
>  #define PCA_CHIP_TYPE(x)	((x) & PCA_TYPE_MASK)
> =20
>  static const struct i2c_device_id pca953x_id[] =3D {
> @@ -93,7 +104,7 @@ static const struct i2c_device_id pca953x_id[] =3D {
> =20
>  	{ "max7310", 8  | PCA953X_TYPE, },
>  	{ "max7312", 16 | PCA953X_TYPE | PCA_INT, },
> -	{ "max7313", 16 | PCA953X_TYPE | PCA_INT, },
> +	{ "max7313", 16 | PCA953X_TYPE | PCA_INT | MAX_PWM, },
>  	{ "max7315", 8  | PCA953X_TYPE | PCA_INT, },
>  	{ "max7318", 16 | PCA953X_TYPE | PCA_INT, },
>  	{ "pca6107", 8  | PCA953X_TYPE | PCA_INT, },
> @@ -119,6 +130,15 @@ MODULE_DEVICE_TABLE(acpi, pca953x_acpi_ids);
> =20
>  #define NBANK(chip) DIV_ROUND_UP(chip->gpio_chip.ngpio, BANK_SZ)
> =20
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
> @@ -140,6 +160,20 @@ static const struct pca953x_reg_config pca957x_regs =
=3D {
>  	.invert =3D PCA957X_INVRT,
>  };
> =20
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
> =20
>  	const struct pca953x_reg_config *regs;
> +
> +	struct max7313_pwm pwm;
>  };
> =20
>  static int pca953x_bank_shift(struct pca953x_chip *chip)
> @@ -239,11 +275,26 @@ static bool pca953x_check_register(struct pca953x_c=
hip *chip, unsigned int reg,
>  	return true;
>  }
> =20
> +static bool max7313_pwm_reg_is_accessible(struct device *dev, unsigned i=
nt reg)
> +{
> +	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
> +	unsigned int bank_sz =3D chip->driver_data & PCA_GPIO_MASK;
> +
> +	if (reg >=3D MAX7313_MASTER && reg < (MAX7313_INTENSITY + bank_sz))
> +		return true;
> +
> +	return false;
> +}
> +
>  static bool pca953x_readable_register(struct device *dev, unsigned int r=
eg)
>  {
>  	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
>  	u32 bank;
> =20
> +	if ((chip->driver_data & MAX_PWM) &&
> +	    max7313_pwm_reg_is_accessible(dev, reg))
> +		return true;

This doesn't look correct. The MAX_PWM flag doesn't signify that all
GPIOs are used in PWM mode, right? So the above check would return true
even if you're trying to access GPIO registers on a chip that has PWM
support.

I think you still want to proceed with the checks below if reg doesn't
match any of the PWM related registers. So it'd be something more along
these lines:

	if ((chip->driver_data & MAX_PWM) &&
	    !max7313_pwm_reg_is_accessible(dev, reg))
		return false;

> +
>  	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE) {
>  		bank =3D PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
>  		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
> @@ -267,6 +318,10 @@ static bool pca953x_writeable_register(struct device=
 *dev, unsigned int reg)
>  	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
>  	u32 bank;
> =20
> +	if ((chip->driver_data & MAX_PWM) &&
> +	    max7313_pwm_reg_is_accessible(dev, reg))
> +		return true;

Same here.

> +
>  	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE) {
>  		bank =3D PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
>  			PCA953x_BANK_CONFIG;
> @@ -855,6 +910,335 @@ static int device_pca957x_init(struct pca953x_chip =
*chip, u32 invert)
>  	return ret;
>  }
> =20
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
> +	unsigned long long value =3D intensity;
> +
> +	return DIV_ROUND_DOWN_ULL(value * PWM_PERIOD_NS, PWM_DC_STATES);
> +}
> +
> +static u8 max7313_pwm_duty_to_intensity(unsigned int duty)
> +{
> +	unsigned long long value =3D duty;
> +
> +	return DIV_ROUND_DOWN_ULL(value * PWM_DC_STATES, PWM_PERIOD_NS);
> +}
> +
> +static u8 max7313_pwm_get_intensity(struct pca953x_chip *pca_chip,
> +				    unsigned int idx)
> +{
> +	struct device *dev =3D &pca_chip->client->dev;
> +	unsigned int reg, shift, val, output;
> +	u8 intensity;
> +	bool phase;
> +	int ret;
> +
> +	/* Retrieve the intensity */
> +	reg =3D MAX7313_INTENSITY + (idx / PWM_PER_REG);
> +	shift =3D (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret =3D regmap_read(pca_chip->regmap, reg, &val);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot retrieve PWM intensity (%d)\n", ret);
> +		return 0;
> +	}
> +
> +	val >>=3D shift;
> +	val &=3D PWM_INTENSITY_MASK;
> +
> +	/* Retrieve the phase */
> +	reg =3D pca953x_recalc_addr(pca_chip, pca_chip->regs->output, idx, 0, 0=
);
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret =3D regmap_read(pca_chip->regmap, reg, &output);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +	if (ret < 0) {
> +		dev_err(dev, "Cannot retrieve PWM phase (%d)\n", ret);
> +		return 0;
> +	}
> +
> +	phase =3D output & BIT(idx % BANK_SZ);
> +
> +	/*
> +	 * Register values in the [0;15] range mean a value in the [1/16;16/16]
> +	 * range if the phase is set, a [15/16;0/16] range otherwise.
> +	 */
> +	if (phase)
> +		intensity =3D val + 1;
> +	else
> +		intensity =3D PWM_INTENSITY_MASK - val;
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
> +	reg =3D MAX7313_INTENSITY + (idx / PWM_PER_REG);
> +	shift =3D (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
> +
> +	mask =3D PWM_INTENSITY_MASK << shift;
> +	val =3D (intensity & PWM_INTENSITY_MASK) << shift;
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret =3D regmap_write_bits(pca_chip->regmap, reg, mask, val);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +
> +	return ret;
> +}
> +
> +/*
> + * For a given PWM channel, when the blink phase 0 bit is set, the inten=
sity
> + * range is only [1/16;16/16]. With this range, a static low output is
> + * physically not possible. When the blink phase 0 bit is cleared, the i=
ntensity
> + * range is [15/16;0/16] which then allows a static low output but not a=
 static
> + * high output.
> + *
> + * In this driver we choose to switch the blink phase only when mandatory
> + * because there is no way to atomically flip the register *and* change =
the PWM
> + * value at the same time so, in this case, it will produce a small glit=
ch.
> + */
> +static int max7313_pwm_set_state(struct pca953x_chip *pca_chip,
> +				 struct pwm_device *pwm,
> +				 unsigned int intensity)
> +{
> +	struct max7313_pwm_data *data =3D pwm_get_chip_data(pwm);
> +	struct gpio_desc *desc =3D data->desc;
> +	unsigned int idx =3D pwm->hwpwm, reg, output;
> +	bool phase;
> +	int ret;
> +
> +	/* Retrieve the phase */
> +	reg =3D pca953x_recalc_addr(pca_chip, pca_chip->regs->output, idx, 0, 0=
);
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret =3D regmap_read(pca_chip->regmap, reg, &output);
> +	mutex_unlock(&pca_chip->i2c_lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	phase =3D output & BIT(idx % BANK_SZ);
> +
> +	/* Need to blink the phase */
> +	if ((phase && !intensity) || (!phase && intensity =3D=3D PWM_DC_STATES)=
) {
> +		phase =3D !phase;
> +		ret =3D gpiod_direction_output(desc, phase);
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* Ensure the pin is in output state (default might be input) */
> +		ret =3D gpiod_direction_output(desc, phase);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (phase)
> +		intensity =3D intensity - 1;
> +	else
> +		intensity =3D PWM_INTENSITY_MASK - intensity;
> +
> +	return max7313_pwm_set_intensity(pca_chip, idx, intensity);
> +}
> +
> +static int max7313_pwm_set_master_intensity(struct pca953x_chip *pca_chi=
p,
> +					    u8 intensity)
> +{
> +	int ret;
> +
> +	intensity &=3D PWM_INTENSITY_MASK;
> +
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret =3D regmap_write_bits(pca_chip->regmap, MAX7313_MASTER,
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
> +	struct max7313_pwm *max_pwm =3D to_max7313_pwm(chip);
> +	struct pca953x_chip *pca_chip =3D to_pca953x(max_pwm);
> +	struct device *dev =3D &pca_chip->client->dev;
> +	struct max7313_pwm_data *data;
> +	struct gpio_desc *desc;
> +
> +	desc =3D gpiochip_request_own_desc(&pca_chip->gpio_chip, pwm->hwpwm,
> +					 "max7313-pwm", GPIO_ACTIVE_HIGH, 0);
> +	if (IS_ERR(desc)) {
> +		dev_err(dev, "pin already in use (probably as GPIO): %ld\n",
> +			PTR_ERR(desc));
> +		return PTR_ERR(desc);
> +	}
> +
> +	data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		gpiochip_free_own_desc(desc);
> +		return -ENOMEM;
> +	}
> +
> +	data->desc =3D desc;
> +	pwm_set_chip_data(pwm, data);
> +
> +	return 0;
> +}
> +
> +static void max7313_pwm_free(struct pwm_chip *chip,
> +			     struct pwm_device *pwm)
> +{
> +	struct max7313_pwm_data *data =3D pwm_get_chip_data(pwm);
> +
> +	gpiochip_free_own_desc(data->desc);
> +	kfree(data);
> +}
> +
> +static int max7313_pwm_apply(struct pwm_chip *chip,
> +			     struct pwm_device *pwm,
> +			     const struct pwm_state *state)
> +{
> +	struct max7313_pwm *max_pwm =3D to_max7313_pwm(chip);
> +	struct pca953x_chip *pca_chip =3D to_pca953x(max_pwm);
> +	unsigned int intensity, active;
> +	int ret =3D 0;
> +
> +	if (!state->enabled ||
> +	    state->period < PWM_PERIOD_NS ||

I think you should actually make this a !=3D so that you refuse any
attempt to change the period, since you can't do it anyway.

> +	    state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	/* Convert the duty-cycle to be in the [0;16] range */
> +	intensity =3D max7313_pwm_duty_to_intensity(state->duty_cycle);
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
> +	active =3D bitmap_weight(max_pwm->active_pwm, PWM_MAX_COUNT);
> +	if (!active)
> +		ret =3D max7313_pwm_set_master_intensity(pca_chip, 0);
> +	else if (active =3D=3D 1)
> +		ret =3D max7313_pwm_set_master_intensity(pca_chip,
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
> +	struct max7313_pwm *max_pwm =3D to_max7313_pwm(chip);
> +	struct pca953x_chip *pca_chip =3D to_pca953x(max_pwm);
> +	u8 intensity;
> +
> +	state->enabled =3D true;
> +	state->period =3D PWM_PERIOD_NS;
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	intensity =3D max7313_pwm_get_intensity(pca_chip, pwm->hwpwm);
> +	state->duty_cycle =3D max7313_pwm_intensity_to_duty(intensity);
> +};
> +
> +static const struct pwm_ops max7313_pwm_ops =3D {
> +	.request =3D max7313_pwm_request,
> +	.free =3D max7313_pwm_free,
> +	.apply =3D max7313_pwm_apply,
> +	.get_state =3D max7313_pwm_get_state,
> +	.owner =3D THIS_MODULE,
> +};
> +
> +static int max7313_pwm_probe(struct device *dev,
> +			     struct pca953x_chip *pca_chip)
> +{
> +	struct max7313_pwm *max_pwm =3D &pca_chip->pwm;
> +	struct pwm_chip *chip =3D &max_pwm->chip;
> +	int ret, i;
> +
> +	if (!(pca_chip->driver_data & MAX_PWM))
> +		return 0;
> +
> +	chip->dev =3D dev;
> +	chip->ops =3D &max7313_pwm_ops;
> +	chip->npwm =3D pca_chip->gpio_chip.ngpio;
> +	chip->base =3D -1;
> +
> +	/* Disable global control (does not affect GPIO functionality) */
> +	mutex_lock(&pca_chip->i2c_lock);
> +	ret =3D regmap_write_bits(pca_chip->regmap, MAX7313_CONFIGURATION,
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
> +	for (i =3D 0; i < chip->npwm; i++) {
> +		if (max7313_pwm_get_intensity(pca_chip, i))
> +			set_bit(i, max_pwm->active_pwm);
> +	}
> +
> +	if (bitmap_weight(max_pwm->active_pwm, PWM_MAX_COUNT))
> +		ret =3D max7313_pwm_set_master_intensity(pca_chip,
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
>  static const struct of_device_id pca953x_dt_ids[];
> =20
>  static int pca953x_probe(struct i2c_client *client,
> @@ -986,6 +1370,14 @@ static int pca953x_probe(struct i2c_client *client,
>  			dev_warn(&client->dev, "setup failed, %d\n", ret);
>  	}
> =20
> +	if (IS_ENABLED(CONFIG_PWM)) {
> +		ret =3D max7313_pwm_probe(&client->dev, chip);
> +		if (ret) {
> +			dev_err(&client->dev, "pwm probe failed, %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
> =20
>  err_exit:
> @@ -1130,7 +1522,7 @@ static const struct of_device_id pca953x_dt_ids[] =
=3D {
> =20
>  	{ .compatible =3D "maxim,max7310", .data =3D OF_953X( 8, 0), },
>  	{ .compatible =3D "maxim,max7312", .data =3D OF_953X(16, PCA_INT), },
> -	{ .compatible =3D "maxim,max7313", .data =3D OF_953X(16, PCA_INT), },
> +	{ .compatible =3D "maxim,max7313", .data =3D OF_953X(16, PCA_INT | MAX_=
PWM), },
>  	{ .compatible =3D "maxim,max7315", .data =3D OF_953X( 8, PCA_INT), },
>  	{ .compatible =3D "maxim,max7318", .data =3D OF_953X(16, PCA_INT), },

Aren't you missing a call to pwmchip_remove() somewhere? Otherwise once
you unload the driver, the PWM chip will become dangling and any attempt
to access its PWMs will crash.

Thierry

--8NvZYKFJsRX2Djef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4lmWcACgkQ3SOs138+
s6HIxhAAi5UAdKssnPjyBzFyOvblAWtfQPHH5JHwX6w7vqpza//76qvJB8w9rBnE
/2GaZQm6yaDKi2rMsrvvP5IiHZlkS3Nfy35uWLTdJH1LIeHbJS/cab/L/x2hiLFF
TqLZwMarglMZ3+UHMW7o6iE6fVFcbxl/oG+f7L3xf6tG4y4lc0YFD1CAfzM6t2/r
C4LlnD3Vilgza8csGlz74H4WZQQlISM5YnXVSkWXDC/wHvcuwms51FggXH+dmdom
AK1Me+KSSbiMKa1QUrqBEBbmptM2rrUiKCmbCA7GhsISHSv7TdeDnXIDYP2SW6Lv
lbx5R01L6D45ZieZJnW3TxGUO7TZpA+DBffMz+xpeczos9GkbqDr8aE7zxkk9s1Q
5aBxrHKEK/mHAcW0tYg5oJ7hQhOq9mtG5j/uAw7YnxhY1EQFuTRyJqOO/K8yPgW5
XikKTGseFn12uaZ3Lwwz2fgxgTAWCBaf7TTQFa7qyrNxjyURLtNPJ1G9eqItAB10
NbTLDZmMp04mcN0/ZdoihQC4qDN+nO33tmRjFfxr89OUgtP38RAO/mrkCc1fYkrx
aKbOBeIO04qfmnJydbUbF7RY8O/rP33YUy7VuYh7GHRhveNT5msjn1T6vWqqaIS5
xc1vR1MFHtcp4MHWRH7mmBviZxsT0zBzWhNwBd+OsrJ72LHqQzo=
=KWz0
-----END PGP SIGNATURE-----

--8NvZYKFJsRX2Djef--
