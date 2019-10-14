Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F30D636E
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2019 15:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfJNNKd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Oct 2019 09:10:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43486 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfJNNKd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Oct 2019 09:10:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so19661087wrq.10;
        Mon, 14 Oct 2019 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jJpT6NDHI0aqjdFR5LMKovHhafheyDySsX9RwexnpP4=;
        b=m0ykXKONcdFuY0J6uhZ1ZYszbRmkoX+j3qxRovadx+CJY+sbohQvYxmzdpseS3my/H
         bwRKLlhsln6RpUwTgBOA2SV6IJsLPGkK5Y5Td8tllG+hyHVkjl1Bqwz+1ICiNfYaZdV5
         P/9hZVPGRRE6zXuV0+QdKWNY9JVzsAW/snFW31L2LcKhQBNwkyQpuorjWwQ35SYXxCHF
         WuBU7rmMJc8XqiTuC26Bdg452hcJkNu5r0IQRuMLWCiTDwBqP7QwoHLgDhq/aukt6FlY
         szHOsxnvkk6elj+vOkAoCxcBVeEKuaGmrhLodsbTkpIbcHOb0aSi7tBCIQWMqKVchbDx
         4cVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jJpT6NDHI0aqjdFR5LMKovHhafheyDySsX9RwexnpP4=;
        b=poLDb5TJg45JEerDfd+N7ngDeywtCCVyegfHMIkh6/pyO4xavrHNYy9u1Ee5PEDgTK
         IVv8TjDjv55o7UaP1aa5whaTEaLc+KkLv2y6W3Kuaf6zO2NFHXS1O0bj58781I29Gqbq
         1u/FVAedVlWUijv2x9LaLBfgBV5YUsVFUMyovY9PnAJ9L7ID9BSa1lE3ZLkrfOD8El65
         Qxeu6kBM7HvjL7oP9UTTOHPiDz2WQ5NTHPO0KyTTx2hQQOTaR+sajpP9mZj4SFbh8saa
         E/PCDEzGd5nXltjWNov6YrnGsj8FBthUk9E3E9kyOarpWEeaEAIlBaD5vVeueLL80eHj
         CL8w==
X-Gm-Message-State: APjAAAWz8KUkkIRj1TN/hueZQHrB4bP07EAAs025xN7vDjG7qz2cvs4s
        wKf9koLgdV1Fl1s3+ML5OUA=
X-Google-Smtp-Source: APXvYqzmJAlX6Mxs4GxKfSkMp6mnq2ja9hYp3IG5Ufp1Ui9xQ6rKlG6rWKZZ6iIma25loPMEZ0hloA==
X-Received: by 2002:a5d:510f:: with SMTP id s15mr16640472wrt.244.1571058628727;
        Mon, 14 Oct 2019 06:10:28 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id b130sm28798196wmh.12.2019.10.14.06.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:10:27 -0700 (PDT)
Date:   Mon, 14 Oct 2019 15:10:26 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        u.kleine-koenig@pengutronix.de, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191014131026.GC422231@ulmo>
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
In-Reply-To: <20191014124803.13661-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2019 at 02:48:03PM +0200, Miquel Raynal wrote:
> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 249 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 247 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index de5d1383f28d..16b5a991b32e 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -18,12 +18,15 @@
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
> @@ -63,11 +66,18 @@
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
> @@ -93,7 +103,7 @@ static const struct i2c_device_id pca953x_id[] =3D {
> =20
>  	{ "max7310", 8  | PCA953X_TYPE, },
>  	{ "max7312", 16 | PCA953X_TYPE | PCA_INT, },
> -	{ "max7313", 16 | PCA953X_TYPE | PCA_INT, },
> +	{ "max7313", 16 | PCA953X_TYPE | PCA_INT | MAX_PWM, },
>  	{ "max7315", 8  | PCA953X_TYPE | PCA_INT, },
>  	{ "max7318", 16 | PCA953X_TYPE | PCA_INT, },
>  	{ "pca6107", 8  | PCA953X_TYPE | PCA_INT, },
> @@ -118,6 +128,16 @@ MODULE_DEVICE_TABLE(acpi, pca953x_acpi_ids);
> =20
>  #define NBANK(chip) DIV_ROUND_UP(chip->gpio_chip.ngpio, BANK_SZ)
> =20
> +#define PWM_CHANNELS 16

Does it really make sense to hard-code this? During PWM chip
registration you assume that the number of PWM channels is the same as
the number of GPIO lines, so the hard-coded values here are only going
to work as long as the chip has 16 GPIO lines. Why not just parameterize
all the code based on the number of GPIO lines?

> +#define PWM_PER_REG 2
> +#define PWM_BITS_PER_REG (8 / PWM_PER_REG)
> +#define PWM_INTENSITY_MASK GENMASK(PWM_BITS_PER_REG - 1, 0)
> +#define PWM_BANK_SZ (PWM_CHANNELS / PWM_PER_REG)
> +
> +#define PWM_PERIOD_NS 31250
> +#define PWM_DC_STATES 16
> +#define PWM_OFFSET_NS (PWM_PERIOD_NS / PWM_DC_STATES)
> +
>  struct pca953x_reg_config {
>  	int direction;
>  	int output;
> @@ -139,6 +159,12 @@ static const struct pca953x_reg_config pca957x_regs =
=3D {
>  	.invert =3D PCA957X_INVRT,
>  };
> =20
> +struct max7313_pwm {
> +	struct pwm_chip chip;
> +	struct gpio_desc *gpiods[PWM_CHANNELS];

Have you considered using per pwm_device data to store the GPIO
descriptors? That avoids having to index some global variable with the
PWM index and allows you to directly get at the per-PWM channel data.

> +	unsigned int used;
> +};
> +
>  struct pca953x_chip {
>  	unsigned gpio_start;
>  	struct mutex i2c_lock;
> @@ -161,6 +187,8 @@ struct pca953x_chip {
>  	struct regulator *regulator;
> =20
>  	const struct pca953x_reg_config *regs;
> +
> +	struct max7313_pwm pwm;
>  };
> =20
>  static int pca953x_bank_shift(struct pca953x_chip *chip)
> @@ -243,6 +271,13 @@ static bool pca953x_readable_register(struct device =
*dev, unsigned int reg)
>  	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
>  	u32 bank;
> =20
> +	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE &&
> +	    chip->driver_data & MAX_PWM) {
> +		if (reg >=3D MAX7313_MASTER &&
> +		    reg < (MAX7313_INTENSITY + PWM_BANK_SZ))
> +			return true;
> +	}
> +
>  	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE) {
>  		bank =3D PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
>  		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
> @@ -266,6 +301,13 @@ static bool pca953x_writeable_register(struct device=
 *dev, unsigned int reg)
>  	struct pca953x_chip *chip =3D dev_get_drvdata(dev);
>  	u32 bank;
> =20
> +	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE &&
> +	    chip->driver_data & MAX_PWM) {
> +		if (reg >=3D MAX7313_MASTER &&
> +		    reg < (MAX7313_INTENSITY + PWM_BANK_SZ))
> +			return true;
> +	}
> +
>  	if (PCA_CHIP_TYPE(chip->driver_data) =3D=3D PCA953X_TYPE) {
>  		bank =3D PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
>  			PCA953x_BANK_CONFIG;
> @@ -886,6 +928,206 @@ static int device_pca957x_init(struct pca953x_chip =
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
> +static int max7313_pwm_set_intensity(struct pca953x_chip *chip,
> +				     unsigned int idx, u8 duty_cycle)
> +{
> +	/* Duty-cycle is in the range [1;16] while registers expect [0;15] */
> +	u8 intensity =3D (duty_cycle - 1) & PWM_INTENSITY_MASK;
> +	unsigned int reg, off;

off is really not a good abbreviation because it has a different
meaning. That means you have to go and actually look at the definition
to find out what value it contains.

I think it's clearer to name this "offset" or "shift".

> +	u8 val, mask;
> +	int ret;
> +
> +	reg =3D MAX7313_INTENSITY + (idx / PWM_PER_REG);
> +	off =3D (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;
> +
> +	mask =3D PWM_INTENSITY_MASK << off;
> +	val =3D intensity << off;
> +
> +	mutex_lock(&chip->i2c_lock);
> +	ret =3D regmap_write_bits(chip->regmap, reg, mask, val);
> +	mutex_unlock(&chip->i2c_lock);
> +
> +	return ret;
> +}
> +
> +static int max7313_pwm_disable(struct pca953x_chip *chip, unsigned int i=
dx)
> +{
> +	return pca953x_gpio_direction_input(&chip->gpio_chip, idx);
> +}

Does this really do what is expected? In my experience setting a GPIO as
input will typically make it high-impedance, which usually means it'll
be seen as "high". That's not what a disabled PWM is supposed to be.

Also, you've already requested the GPIO, why not continue using the GPIO
as a regular consumer? Seems like that would make all of this a little
more idiomatic.

> +
> +static int max7313_pwm_enable_static_low(struct pca953x_chip *chip,
> +					 unsigned int idx)
> +{
> +	/*
> +	 * For a given PWM channel, when the blink phase 0 bit is set, the
> +	 * intensity range is only [1/16;16/16]. With this range, a static low
> +	 * output is physically not possible. When the blink phase 0 bit is
> +	 * cleared, the intensity range is [15/16;0/16] which then allows a
> +	 * static low output but not a static high output.
> +	 *
> +	 * In this driver we choose to set the blink phase 0 bit by default,
> +	 * hence we can slide from a low output to a fully high output without
> +	 * glitch. However,  The only way to get a static low output is by
> +	 * clearing the blink phase 0 bit, and by changing the intensity value
> +	 * to its maximum (as, at this moment, intensity is reversed). There is
> +	 * no way to atomically flip the register *and* change the PWM value at
> +	 * the same time so this operation will produce a small glitch.
> +	 */
> +
> +	/* Invert the the PWM phase */
> +	pca953x_gpio_direction_output(&chip->gpio_chip, idx, 0);
> +
> +	/* Maximize the low time */
> +	return max7313_pwm_set_intensity(chip, idx, PWM_DC_STATES);
> +}
> +
> +static int max7313_pwm_enable(struct pca953x_chip *chip, unsigned int id=
x,
> +			      unsigned int duty_cycle)
> +{
> +	/* PWM phase must not be inverted to work in the [1/16;16/16] range */
> +	pca953x_gpio_direction_output(&chip->gpio_chip, idx, 1);
> +
> +	/* Set the PWM intensity to the desired duty-cycle */
> +	return max7313_pwm_set_intensity(chip, idx, duty_cycle);
> +}
> +
> +static int max7313_pwm_request(struct pwm_chip *pwm_chip,
> +			       struct pwm_device *pwm_device)
> +{
> +	struct max7313_pwm *pwm =3D to_max7313_pwm(pwm_chip);
> +	struct pca953x_chip *chip =3D to_pca953x(pwm);
> +	int idx =3D pwm_device->hwpwm;

unsigned int to mirror the type of hwpwm.

> +	struct gpio_desc *desc;
> +	int ret;
> +
> +	if (pwm->gpiods[idx]) {
> +		ret =3D -EBUSY;
> +	} else {
> +		desc =3D gpio_to_desc(chip->gpio_chip.base + idx);
> +		if (!desc)
> +			return -ENODEV;
> +
> +		ret =3D gpiod_request(desc, "max7313-pwm");
> +		if (ret)
> +			return ret;
> +
> +		pwm->gpiods[idx] =3D desc;

Can't you do this using gpiochip_request_own_desc()? Seems rather odd to
go through the global number space to get back at a "local" GPIO
descriptor.

> +	}
> +
> +	ret =3D max7313_pwm_disable(chip, idx);
> +	if (ret)
> +		return ret;

->request() shouldn't change the state of the PWM.

> +
> +	/*
> +	 * Set master intensity to the maximum level to let individual outputs
> +	 * the greatest flexibility range. Also enables the internal oscillator.
> +	 */
> +	if (!pwm->used) {
> +		mutex_lock(&chip->i2c_lock);
> +		ret =3D regmap_write_bits(chip->regmap, MAX7313_MASTER,
> +					PWM_INTENSITY_MASK << PWM_BITS_PER_REG,
> +					PWM_INTENSITY_MASK << PWM_BITS_PER_REG);
> +		mutex_unlock(&chip->i2c_lock);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	pwm->used++;
> +
> +	return 0;
> +}
> +
> +static void max7313_pwm_free(struct pwm_chip *pwm_chip,
> +			     struct pwm_device *pwm_device)
> +{
> +	struct max7313_pwm *pwm =3D to_max7313_pwm(pwm_chip);
> +	struct pca953x_chip *chip =3D to_pca953x(pwm);
> +	int idx =3D pwm_device->hwpwm;

unsigned int, please.

> +
> +	max7313_pwm_disable(chip, idx);
> +	pwm->used--;
> +
> +	/* Disable the internal oscillator if no channel is in use */
> +	if (!pwm->used) {
> +		mutex_lock(&chip->i2c_lock);
> +		regmap_write_bits(chip->regmap, MAX7313_MASTER,
> +				  PWM_INTENSITY_MASK << PWM_BITS_PER_REG, 0);
> +		mutex_unlock(&chip->i2c_lock);
> +	}
> +
> +	gpiod_free(pwm->gpiods[idx]);
> +	pwm->gpiods[idx] =3D NULL;
> +}
> +
> +static int max7313_pwm_apply(struct pwm_chip *pwm_chip,
> +			     struct pwm_device *pwm_device,
> +			     const struct pwm_state *state)
> +{
> +	struct max7313_pwm *pwm =3D to_max7313_pwm(pwm_chip);
> +	struct pca953x_chip *chip =3D to_pca953x(pwm);
> +	int idx =3D pwm_device->hwpwm;

unsigned int, please.

> +	unsigned int duty_cycle;
> +
> +	if (!state->enabled)
> +		return max7313_pwm_disable(chip, idx);
> +
> +	if (!state->period || !state->duty_cycle)
> +		return max7313_pwm_enable_static_low(chip, idx);
> +
> +	/* Convert the duty-cycle to be in the [1;16] range */
> +	duty_cycle =3D DIV_ROUND_UP(state->duty_cycle * PWM_DC_STATES,
> +				  state->period);
> +
> +	return max7313_pwm_enable(chip, idx, duty_cycle);
> +}
> +
> +static const struct pwm_ops max7313_pwm_ops =3D {
> +	.request =3D max7313_pwm_request,
> +	.free =3D max7313_pwm_free,
> +	.apply =3D max7313_pwm_apply,
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
> +	/* Disable global control */
> +	mutex_lock(&chip->i2c_lock);
> +	ret =3D regmap_write_bits(chip->regmap, MAX7313_CONFIGURATION,
> +				MAX7313_GLOB_INTENSITY, 0);
> +	mutex_unlock(&chip->i2c_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pwmchip_add(pwm_chip);
> +
> +	return ret;

Just "return pwmchip_add(...);" will do.

Thierry

> +}
> +
>  static const struct of_device_id pca953x_dt_ids[];
> =20
>  static int pca953x_probe(struct i2c_client *client,
> @@ -1018,6 +1260,9 @@ static int pca953x_probe(struct i2c_client *client,
>  			dev_warn(&client->dev, "setup failed, %d\n", ret);
>  	}
> =20
> +	if (IS_ENABLED(CONFIG_PWM))
> +		return max7313_pwm_probe(&client->dev, chip);
> +
>  	return 0;
> =20
>  err_exit:
> @@ -1162,7 +1407,7 @@ static const struct of_device_id pca953x_dt_ids[] =
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

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2kc78ACgkQ3SOs138+
s6EFIBAArt4X8ma6dwK1NfRPAnreFPm0CmRtySpfPZOqrAaXCAPqesQSvLN61k+E
5sN9Dn2fMRLeFKFJbgwrJ+6/PfeTShOkCrVu6KgFVT9i9B7IAA4y8RzihU0qUsBU
szSX0XN38KMD7ce96pXAmIkE98mPBb4ymndoWkq6Ww5ZiAXicr/TNJ3BVXOClyE/
BRFJzqZILUisL0F/MofSgF/Z8Uv7YX1dk9dX+GkpUJ8gvKwFh96egfYgo4JlBGpQ
oKQB+QrVTHoTfOL9P+uIlgAUEBdx8yjrCVRdJM+KFH+egRGCz5jTsSBVC1w11Q/m
0wfg5D0jDnuS6XBxRObjvxGq0s2WaVU4yB1t60OrbnKfRrjdzjQWX4QEMVDB7D73
Ab9jbeuwztMIJdSO+c2SeKVV5X6f3KlJ3gz4KTrvqU/PB50f8GvfGEX3JWUnvv2K
YIXVKfI5uyAiFyktYfvEpf1Br6ZDm0GR3lBWrd4IpJ/b5ps7sA4KRhQFfrRh7kZf
Ay87UliGnF/ZQi0cBSCq/K2KcYO56cv21Bk3qwsohSnrqsGfALAjWrAqXkNmGPEr
7leUDW8Nvtyfz0haPNz87vB3/tGwJUYXGDXB2jCCOCnxMXdNJpgjpOlhslwEKs6H
6df9gwlIHTjISiqXpDycNO13GSSmQYCOP8bzF5s6LGPJdd3cjZY=
=4Jbf
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
