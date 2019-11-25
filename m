Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15AAE108904
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2019 08:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725763AbfKYHOh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Nov 2019 02:14:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38632 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfKYHOh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Nov 2019 02:14:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so14597331wmk.3;
        Sun, 24 Nov 2019 23:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bJd+GQAQCuqkQilX5Q5Gm3gbG79NJp94+Sz20uvyhhg=;
        b=Cwnyc+rNkkqqZkkUmi/3/PzYtJJxDowJJTSN+3BpjyVwgnWdf+KcanHCC0PMYDK8Hk
         6txvJ67JPnl/s1MpNb8GUCm4rFKvjYMnPd01KlhEqds85AVega12ee/52NgHiQ8ytX66
         GN+fCo6Y7nBfF3wFhVxKwTouMrHCpKjEVtauSwy6agy0M872n0NPD+0H7LCujBLZaAmb
         utrxDAMooeoYhPr5fTz2+WChXqBYteVB5FFrELeKSj5kvaHrmQQ/gbkzkDqp0u/h1XYs
         ofmMy8Lnn7dafDeWC46NzlnVAwSzLYN8LbrCRR/OMxCQdnksWiFslgEyRm/aomajO3RU
         SrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bJd+GQAQCuqkQilX5Q5Gm3gbG79NJp94+Sz20uvyhhg=;
        b=rGfCiakTtBEJIwzhu48PA0OzVi/GM0fJmW5t2Fvutauh7PI/AJbySHzofWYOyVRvFM
         b3Imfgu7qfe/u3YHT7I9vb33zKMMeOOkr7wrzvhTCD1JB5ruwS0ZpVEPcGoFrEZ/ClTY
         zuKoMxdCrvfb9AapolYtBVu53ulGu5YYavdneGr+yhXREBV738IGkBAroHJfaO2Vu2FR
         Jp5/NZ8Ax2fdrHYYCzaSPQgBjLZcvwTjX5OrsjHMuxVFwOzTrv7Z+zIGegXeBqwkSKQB
         OnWPp202UguDS69puwjlb/V+rY1+P/BGVmqrx6Q+lk+sugt4o9klQrJoz8fTjThRUiiO
         dy2g==
X-Gm-Message-State: APjAAAWzypLMjBgPI5UXuWgFjHFnBogcNcj3OtOaZoIsb15oUm+oum+/
        HjoYRWbdwcWVKW9tac5dICI=
X-Google-Smtp-Source: APXvYqy5JgIkeblCslRWGPgIbYsJ4tyuPrB5SrQqJNP4P+8C6yFf4lQoECFPSs1QPp5/cCx7u6L0iA==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr16153302wmc.81.1574666071747;
        Sun, 24 Nov 2019 23:14:31 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id w4sm7702850wmk.29.2019.11.24.23.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 23:14:30 -0800 (PST)
Date:   Mon, 25 Nov 2019 08:14:29 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        u.kleine-koenig@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191125071429.GB1409040@ulmo>
References: <20191122113230.16486-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20191122113230.16486-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2019 at 12:32:30PM +0100, Miquel Raynal wrote:
> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
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
>=20
>  drivers/gpio/gpio-pca953x.c | 332 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 330 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index de5d1383f28d..baf639bec18d 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -12,18 +12,22 @@
>  #include <linux/bits.h>
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
> @@ -118,6 +129,14 @@ MODULE_DEVICE_TABLE(acpi, pca953x_acpi_ids);
> =20
>  #define NBANK(chip) DIV_ROUND_UP(chip->gpio_chip.ngpio, BANK_SZ)
> =20
> +#define PWM_PER_REG 2
> +#define PWM_BITS_PER_REG (8 / PWM_PER_REG)
> +#define PWM_INTENSITY_MASK GENMASK(PWM_BITS_PER_REG - 1, 0)
> +
> +#define PWM_PERIOD_NS 31250
> +#define PWM_DC_STATES 16
> +#define PWM_OFFSET_NS (PWM_PERIOD_NS / PWM_DC_STATES)
> +
>  struct pca953x_reg_config {
>  	int direction;
>  	int output;
> @@ -139,6 +158,22 @@ static const struct pca953x_reg_config pca957x_regs =
=3D {
>  	.invert =3D PCA957X_INVRT,
>  };
> =20
> +struct max7313_pwm_data {
> +	struct gpio_desc *desc;
> +	bool enabled;
> +	unsigned int duty_cycle;
> +};
> +
> +struct max7313_pwm {
> +	struct pwm_chip chip;
> +	/*
> +	 * Protect races when counting active PWMs for enabling or disabling
> +	 * the internal oscillator.
> +	 */
> +	struct mutex count_lock;
> +	unsigned int count;
> +};
> +
>  struct pca953x_chip {
>  	unsigned gpio_start;
>  	struct mutex i2c_lock;
> @@ -161,6 +196,8 @@ struct pca953x_chip {
>  	struct regulator *regulator;
> =20
>  	const struct pca953x_reg_config *regs;
> +
> +	struct max7313_pwm pwm;
>  };
> =20
>  static int pca953x_bank_shift(struct pca953x_chip *chip)
> @@ -241,8 +278,16 @@ static bool pca953x_check_register(struct pca953x_ch=
ip *chip, unsigned int reg,
>  static bool pca953x_readable_register(struct device *dev, unsigned int r=
eg)
>  {
>  	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
> +	unsigned int bank_sz =3D chip->driver_data & PCA_GPIO_MASK;
>  	u32 bank;
> =20
> +	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE &&
> +	    chip->driver_data & MAX_PWM) {
> +		if (reg >=3D MAX7313_MASTER &&
> +		    reg < (MAX7313_INTENSITY + bank_sz))
> +			return true;
> +	}
> +
>  	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE) {
>  		bank =3D PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
>  		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
> @@ -264,8 +309,16 @@ static bool pca953x_readable_register(struct device =
*dev, unsigned int reg)
>  static bool pca953x_writeable_register(struct device *dev, unsigned int =
reg)
>  {
>  	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
> +	unsigned int bank_sz =3D chip->driver_data & PCA_GPIO_MASK;
>  	u32 bank;
> =20
> +	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE &&
> +	    chip->driver_data & MAX_PWM) {
> +		if (reg >=3D MAX7313_MASTER &&
> +		    reg < (MAX7313_INTENSITY + bank_sz))
> +			return true;
> +	}
> +
>  	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE) {
>  		bank =3D PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
>  			PCA953x_BANK_CONFIG;
> @@ -886,6 +939,278 @@ static int device_pca957x_init(struct pca953x_chip =
*chip, u32 invert)
>  	return ret;
>  }
> =20
> +/* PWM specific methods */
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
> +static u8 max7313_pwm_get_intensity(struct pca953x_chip *chip,
> +				    unsigned int idx)
> +{
> +	unsigned int reg, shift, val;
> +	u8 duty_cycle;
> +
> +	reg =3D MAX7313_INTENSITY + (idx / PWM_PER_REG);
> +	shift =3D (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
> +
> +	mutex_lock(&chip->i2c_lock);
> +	regmap_read(chip->regmap, reg, &val);
> +	mutex_unlock(&chip->i2c_lock);
> +
> +	if (shift)
> +		val >>=3D shift;
> +
> +	val &=3D PWM_INTENSITY_MASK;
> +
> +	/*
> +	 * Register values in the [0;15] range mean a value in the [1;16] range.
> +	 * A register value of 16 means the logic has been inverted to produce a
> +	 * static low output.
> +	 */
> +	if (val =3D=3D PWM_INTENSITY_MASK)
> +		duty_cycle =3D 0;
> +	else
> +		duty_cycle =3D val + 1;

That comment doesn't seem right. PWM_INTENSITY_MASK is 0xf as far as I
can tell, which means that your comment above is off-by-one with regards
to the upper limit of the range.

Also, a register value of 16 doesn't make sense if your field is 4 bits
wide.

> +
> +	return duty_cycle;
> +}
> +
> +static int max7313_pwm_set_intensity(struct pca953x_chip *chip,
> +				     unsigned int idx, u8 duty_cycle)
> +{
> +	/* Duty-cycle is in the range [1;16] while registers expect [0;15] */
> +	u8 intensity =3D (duty_cycle - 1) & PWM_INTENSITY_MASK;
> +	unsigned int reg, shift;
> +	u8 val, mask;
> +	int ret;
> +
> +	reg =3D MAX7313_INTENSITY + (idx / PWM_PER_REG);
> +	shift =3D (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
> +
> +	mask =3D PWM_INTENSITY_MASK << shift;
> +	val =3D intensity << shift;
> +
> +	mutex_lock(&chip->i2c_lock);
> +	ret =3D regmap_write_bits(chip->regmap, reg, mask, val);
> +	mutex_unlock(&chip->i2c_lock);
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
> + * In this driver we choose to set the blink phase 0 bit by default, hen=
ce we
> + * can slide from a low output to a fully high output without glitch. Ho=
wever,
> + * the only way to get a static low output is by clearing the blink phas=
e 0 bit,
> + * and by changing the intensity value to its maximum (as, at this momen=
t,
> + * intensity is reversed). There is no way to atomically flip the regist=
er *and*
> + * change the PWM value at the same time so this will produce a small gl=
itch.
> + */
> +static int max7313_pwm_set_state(struct pca953x_chip *chip,
> +				 struct pwm_device *pwm_device,
> +				 unsigned int duty_cycle)
> +{
> +	struct max7313_pwm_data *data =3D pwm_get_chip_data(pwm_device);
> +	struct gpio_desc *desc =3D data->desc;
> +	int ret;
> +
> +	/* A null duty_cycle will invert the phase */
> +	ret =3D gpiod_direction_output(desc, duty_cycle);

It might be worth making this a little more explicit. While gpiolib does
reduce the value to [0, 1], and hence this should work correctly, I find
this a little confusing to read.

> +	if (ret)
> +		return ret;
> +
> +	/* Maximize the low time in case of static low state */
> +	if (!duty_cycle)
> +		duty_cycle =3D PWM_DC_STATES;
> +
> +	return max7313_pwm_set_intensity(chip, pwm_device->hwpwm, duty_cycle);
> +}
> +
> +static int max7313_pwm_request(struct pwm_chip *pwm_chip,
> +			       struct pwm_device *pwm_device)
> +{
> +	struct max7313_pwm *pwm =3D to_max7313_pwm(pwm_chip);
> +	struct pca953x_chip *chip =3D to_pca953x(pwm);
> +	struct max7313_pwm_data *data;
> +	struct gpio_desc *desc;
> +	int ret;
> +
> +	desc =3D gpiochip_request_own_desc(&chip->gpio_chip, pwm_device->hwpwm,
> +					 "max7313-pwm", GPIO_ACTIVE_HIGH,
> +					 GPIOD_OUT_LOW);
> +	if (IS_ERR(desc)) {
> +		dev_err(&chip->client->dev,
> +			"pin already in use (probably as GPIO)\n");
> +		return PTR_ERR(desc);
> +	}
> +
> +	data =3D devm_kzalloc(&chip->client->dev, sizeof(*data), GFP_KERNEL);

There should be no need to use managed memory in this case since the
core will take care of calling ->free() on the PWM at the right time. I
can't think of a case where the memory wouldn't be freed, unless perhaps
if there's a crash somewhere and the subsystem is thrown off course, in
which case memory leaks should be the least of your worries.

> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->desc =3D desc;
> +	pwm_set_chip_data(pwm_device, data);
> +
> +	ret =3D max7313_pwm_set_state(chip, pwm_device, 0);
> +	if (ret) {
> +		dev_err(&chip->client->dev, "cannot set PWM default state\n");
> +		goto free_gpiod;
> +	}
> +
> +	/*
> +	 * Set master intensity to the maximum level to let individual outputs
> +	 * the greatest flexibility range. Also enables the internal oscillator.
> +	 */
> +	mutex_lock(&pwm->count_lock);
> +	if (!pwm->count) {
> +		mutex_lock(&chip->i2c_lock);
> +		ret =3D regmap_write_bits(chip->regmap, MAX7313_MASTER,
> +					PWM_INTENSITY_MASK << PWM_BITS_PER_REG,
> +					PWM_INTENSITY_MASK << PWM_BITS_PER_REG);

This is a bit of a nitpick, but it seems to me like PWM_BITS_PER_REG
isn't really appropriate here since this is a register completely
different from those that control the PWM functionality of the PWMs.

Using the same definition implies some sort of correlation here, even
though it seems like this is really just a coincidence.

> +		mutex_unlock(&chip->i2c_lock);
> +	}
> +
> +	if (!ret)
> +		pwm->count++;
> +
> +	mutex_unlock(&pwm->count_lock);
> +
> +	if (ret)
> +		goto free_gpiod;
> +
> +	return 0;
> +
> +free_gpiod:
> +	gpiochip_free_own_desc(data->desc);
> +
> +	return ret;
> +}
> +
> +static void max7313_pwm_free(struct pwm_chip *pwm_chip,
> +			     struct pwm_device *pwm_device)
> +{
> +	struct max7313_pwm_data *data =3D pwm_get_chip_data(pwm_device);
> +	struct max7313_pwm *pwm =3D to_max7313_pwm(pwm_chip);
> +	struct pca953x_chip *chip =3D to_pca953x(pwm);
> +
> +	max7313_pwm_set_state(chip, pwm_device, 0);
> +
> +	mutex_lock(&pwm->count_lock);
> +
> +	pwm->count--;
> +
> +	/* Disable the internal oscillator if no channel is in use */
> +	if (!pwm->count) {
> +		mutex_lock(&chip->i2c_lock);
> +		regmap_write_bits(chip->regmap, MAX7313_MASTER,
> +				  PWM_INTENSITY_MASK << PWM_BITS_PER_REG, 0);
> +		mutex_unlock(&chip->i2c_lock);
> +	}
> +
> +	mutex_unlock(&pwm->count_lock);
> +
> +	gpiochip_free_own_desc(data->desc);
> +}
> +
> +static int max7313_pwm_apply(struct pwm_chip *pwm_chip,
> +			     struct pwm_device *pwm_device,

We'd typically just call this "pwm".

> +			     const struct pwm_state *state)
> +{
> +	struct max7313_pwm_data *data =3D pwm_get_chip_data(pwm_device);
> +	struct max7313_pwm *pwm =3D to_max7313_pwm(pwm_chip);
> +	struct pca953x_chip *chip =3D to_pca953x(pwm);
> +	unsigned int duty_cycle;
> +
> +	if (state->period !=3D PWM_PERIOD_NS ||
> +	    state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	data->enabled =3D state->enabled;
> +	data->duty_cycle =3D state->duty_cycle;
> +
> +	if (!state->enabled || !state->duty_cycle)
> +		duty_cycle =3D 0;
> +	else
> +		/* Convert the duty-cycle to be in the [1;16] range */
> +		duty_cycle =3D DIV_ROUND_DOWN_ULL(state->duty_cycle,
> +						PWM_OFFSET_NS);

If duty-cycle is somewhere in the range [1, PWM_OFFSET_NS - 1], then you
still end up with duty-cycle =3D 0 here, right?

> +
> +	/* The hardware is supposedly glitch-free */

Not sure I understand this comment. Didn't you say above that it's in
fact not glitch-free in the case where you need to change the blink bit?

> +	return max7313_pwm_set_state(chip, pwm_device, duty_cycle);
> +}
> +
> +static void max7313_pwm_get_state(struct pwm_chip *pwm_chip,
> +				  struct pwm_device *pwm_device,
> +				  struct pwm_state *state)
> +{
> +	struct max7313_pwm_data *data =3D pwm_get_chip_data(pwm_device);
> +	struct max7313_pwm *pwm =3D to_max7313_pwm(pwm_chip);
> +	struct pca953x_chip *chip =3D to_pca953x(pwm);
> +	u8 duty_cycle;
> +
> +	state->period =3D PWM_PERIOD_NS;
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	if (!data)
> +		return;
> +
> +	state->enabled =3D data->enabled;
> +	if (!state->enabled) {
> +		state->duty_cycle =3D data->duty_cycle;
> +	} else {
> +		duty_cycle =3D max7313_pwm_get_intensity(chip, pwm_device->hwpwm);
> +		state->duty_cycle =3D duty_cycle * PWM_OFFSET_NS;
> +	}
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
> +			     struct pca953x_chip *chip)
> +{
> +	struct max7313_pwm *pwm =3D &chip->pwm;
> +	struct pwm_chip *pwm_chip =3D &pwm->chip;
> +	int ret;
> +
> +	if (!(chip->driver_data & MAX_PWM))
> +		return 0;
> +
> +	pwm_chip->dev =3D dev;
> +	pwm_chip->ops =3D &max7313_pwm_ops;
> +	pwm_chip->npwm =3D chip->gpio_chip.ngpio;
> +	pwm_chip->base =3D -1;
> +
> +	/* Disable global control (does not affect GPIO functionality) */
> +	mutex_lock(&chip->i2c_lock);
> +	ret =3D regmap_write_bits(chip->regmap, MAX7313_CONFIGURATION,
> +				MAX7313_GLOB_INTENSITY, 0);
> +	mutex_unlock(&chip->i2c_lock);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&pwm->count_lock);
> +
> +	return pwmchip_add(pwm_chip);
> +}
> +
>  static const struct of_device_id pca953x_dt_ids[];
> =20
>  static int pca953x_probe(struct i2c_client *client,
> @@ -1018,6 +1343,9 @@ static int pca953x_probe(struct i2c_client *client,
>  			dev_warn(&client->dev, "setup failed, %d\n", ret);
>  	}
> =20
> +	if (IS_ENABLED(CONFIG_PWM))
> +		return max7313_pwm_probe(&client->dev, chip);

Might be more cautious to use a regular error check here, rather than a
plain return statement. As it is, if somebody's not careful, they'll go
and add some code between this and the "return 0;" below and end up
scratching their head why the code isn't getting executed on chips that
support PWM.

I guess that would be on them, but why not be proactive about preventing
that from happening in the first place? You never know if the person you
might be helping out ends up being yourself...

Thierry

> +
>  	return 0;
> =20
>  err_exit:
> @@ -1162,7 +1490,7 @@ static const struct of_device_id pca953x_dt_ids[] =
=3D {
> =20
>  	{ .compatible =3D "maxim,max7310", .data =3D OF_953X( 8, 0), },
>  	{ .compatible =3D "maxim,max7312", .data =3D OF_953X(16, PCA_INT), },
> -	{ .compatible =3D "maxim,max7313", .data =3D OF_953X(16, PCA_INT), },
> +	{ .compatible =3D "maxim,max7313", .data =3D OF_953X(16, PCA_INT | MAX_=
PWM), },
>  	{ .compatible =3D "maxim,max7315", .data =3D OF_953X( 8, PCA_INT), },
>  	{ .compatible =3D "maxim,max7318", .data =3D OF_953X(16, PCA_INT), },
> =20
> --=20
> 2.20.1
>=20

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3bf1MACgkQ3SOs138+
s6ETZQ/+PWJMVx2DhGPCfrQPY8SmDAwFcix2c+7We2g7LB/UsSIa0iexaWmE9GVI
sc3B+7RtlwiSyLzGmNe/NcHI9x9Xm1y6fUBAqPAMYz5kfKTHacptzrmV3WcTc3Xz
UQ2lrQUwSXiyxrx6llf0y0p7auqnhK4nC/tHoVLmrFgmvJNG3ra740ZjQ7zEiBnX
vkuhboRQpwefaAx8sMm44E5+QLpzFn0GM/VgQAovDiid7z+SFjSizXluAFWdkUki
4pPGP2PFA7dywoFevO8ifxfoMFulMLFv/syE7vi2ySI+ry71Hk8JUT68bPJegSGV
fNDadek1ZRe4lsQDw2VS8mSXX2hO+WpLyCiDh5lDdrGdFcxUjHZUitoIGtti3yJN
sTfqVk9KRnlc9S6wDqnrpzLcyCop/xMnq4XvP+e7Wyd4f/zCsp/Egt3fIA53qRWK
xvwRGUy1hy7gG38ZW9qVbdMBggpBMvc+GxXZcjUpUHTJLSZLZywfVO9GsVKKAjv9
lvvkexOy4rQIIPQh5yCxbN6wweH914+20RkuflB6iYLA3VNRt93ULCj1YD9KSf0F
gwimtJ0rWi8cE0IYi57p8T/CdNW4QKCKb9SAYOLSexG/Luitsv0dt4nOcom63hUO
XSlCLo88+MJyoPxi4HFqy0f/vzkyIGyI3vjuEdwq+yG+NFacLfk=
=Btc/
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
