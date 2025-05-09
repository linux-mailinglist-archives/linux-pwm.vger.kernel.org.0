Return-Path: <linux-pwm+bounces-5876-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78538AB10EE
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 12:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C22916E0F1
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 10:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D1D28ECCB;
	Fri,  9 May 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gML0R/6h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7682928EA70;
	Fri,  9 May 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787180; cv=none; b=GseN0YTFs9Nsc3B2iqAl+vy3gEe9JVSP2pT9aOEQIh2uqUdgRpLqJfNE/X0W63n19B1wcF1ryL6J1ksqAJ6SnutVnecyZYMd3RuseS4rlphiCnU9PsD01uhY5dwVGeqtDsgb4wNivFR5kQWZSu1BvayNgMJ4YxKuymKa3CYTYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787180; c=relaxed/simple;
	bh=wjz4XrNIey3l7e+1ExSFYbtCYtVWCzKYPigcvS5X9Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHvOFaDkAwXSaxL7wYZU82F4u6EyuyGihYrFAgRKoC2UdPQnh1qSL1SmZ7uvqD5F7EKceSU2q+nj7gSbcxxowEdQYNDF0FzhZ31GMqR0N/xAOrNEAiaLB0+1iwqYzs+V/X4aFDQneBWDG1qqMjUzdRwwsPd2nsGCeJPLgsClDbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gML0R/6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FEDC4CEE4;
	Fri,  9 May 2025 10:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746787179;
	bh=wjz4XrNIey3l7e+1ExSFYbtCYtVWCzKYPigcvS5X9Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gML0R/6h9iM+Mklf78oW4IdKs1bQt1X7EhvA+5qP0vXjElvWSught88xmvl2z/Uz5
	 NCSAoFDOnUA+EdywudYITsnGzhrhdc6/ua13jMHVYv5y0wcdd4DBf7wu9Xeze+H5XH
	 M5mU+blE45lQFgpikGyh+k/r0Iqjn1ATS4XlrReEC7jpQdo1uB2S9f4PP+DO+xsy7k
	 v7eDAMRDAVZotABe5M6eFIqjyKP21mCjZEWnp3cUx2bzTFV7bThfGvymnAzFjgHy9U
	 G5Bqy062uNFXyofJfIMPzlnMNprv8hthTUW7Vv51/Jt9H+vvlUEzTalLxD/I5aqUwC
	 2lfisu43lhl4g==
Date: Fri, 9 May 2025 12:39:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v12] pwm: airoha: Add support for EN7581 SoC
Message-ID: <q46vqvt4ebepk47as3vhx24fqfnv2ollatjzjw5hbxtcbaklff@exkozghztvlv>
References: <20250407173559.29600-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k4gp3tbfhumfaehw"
Content-Disposition: inline
In-Reply-To: <20250407173559.29600-1-ansuelsmth@gmail.com>


--k4gp3tbfhumfaehw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello Christian,

thanks for your patience.

On Mon, Apr 07, 2025 at 07:35:53PM +0200, Christian Marangi wrote:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
>=20
> Introduce driver for PWM module available on EN7581 SoC.
>=20
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v12:
> - Make shift function more readable
> - Use unsigned int where possible
> - Better comment some SIPO strangeness
> - Move SIPO init after flash map config
> - Retrun real values in get_state instead of the
>   one saved in bucket
> - Improve period_ns parsing so we can better share generators
>=20
> Changes v11:
> - Fix wrong calculation of period and duty
> - Use AIROHA_PWM prefix for each define
> - Drop set/get special define in favour of BITS and GENMASK
> - Correctly use dev_err_probe
> - Init bucket with initial values
> - Rework define to make use of FIELD_PREP and FIELD_GET
>=20
> Changes in v10:
> - repost just patch 6/6 (pwm driver) since patches {1/6-5/6} have been
>   already applied in linux-pinctrl tree
> - pwm: introduce AIROHA_PWM_FIELD_GET and AIROHA_PWM_FIELD_SET macros to
>   get/set field with non-const mask
> - pwm: simplify airoha_pwm_get_generator() to report unused generator
>   and remove double lookup
> - pwm: remove device_node pointer in airoha_pwm struct since this is
>   write-only field
> - pwm: cosmetics
> - Link to v9: https://lore.kernel.org/r/20241023-en7581-pinctrl-v9-0-afb0=
cbcab0ec@kernel.org
>=20
> Changes in v9:
> - pwm: remove unused properties
> - Link to v8: https://lore.kernel.org/r/20241018-en7581-pinctrl-v8-0-b676=
b966a1d1@kernel.org
>=20
> Changes in v8:
> - pwm: add missing properties documentation
> - Link to v7: https://lore.kernel.org/r/20241016-en7581-pinctrl-v7-0-4ff6=
11f263a7@kernel.org
>=20
> Changes in v7:
> - pinctrl: cosmetics
> - pinctrl: fix compilation warning
> - Link to v6: https://lore.kernel.org/r/20241013-en7581-pinctrl-v6-0-2048=
e2d099c2@kernel.org
>=20
> Changes in v6:
> - pwm: rely on regmap APIs
> - pwm: introduce compatible string
> - pinctrl: introduce compatible string
> - remove airoha-mfd driver
> - add airoha,en7581-pinctrl binding
> - add airoha,en7581-pwm binding
> - update airoha,en7581-gpio-sysctl binding
> - Link to v5: https://lore.kernel.org/r/20241001-en7581-pinctrl-v5-0-dc1c=
e542b6c6@kernel.org
>=20
> Changes in v5:
> - use spin_lock in airoha_pinctrl_rmw instead of a mutex since it can run
>   in interrupt context
> - remove unused includes in pinctrl driver
> - since the irq_chip is immutable, allocate the gpio_irq_chip struct
>   statically in pinctrl driver
> - rely on regmap APIs in pinctrl driver but keep the spin_lock local to t=
he
>   driver
> - rely on guard/guard_scope APIs in pinctrl driver
> - improve naming convention pinctrl driver
> - introduce airoha_pinconf_set_pin_value utility routine
> - Link to v4: https://lore.kernel.org/r/20240911-en7581-pinctrl-v4-0-60ac=
93d760bb@kernel.org
>=20
> Changes in v4:
> - add 'Limitation' description in pwm driver
> - fix comments in pwm driver
> - rely on mfd->base __iomem pointer in pwm driver, modify register
>   offsets according to it and get rid of sgpio_cfg, flash_cfg and
>   cycle_cfg pointers
> - simplify register utility routines in pwm driver
> - use 'generator' instead of 'waveform' suffix for pwm routines
> - fix possible overflow calculating duty cycle in pwm driver
> - do not modify pwm state in free callback in pwm driver
> - cap the maximum period in pwm driver
> - do not allow inverse polarity in pwm driver
> - do not set of_xlate callback in the pwm driver and allow the stack to
>   do it
> - fix MAINTAINERS file for airoha pinctrl driver
> - fix undefined reference to __ffsdi2 in pinctrl driver
> - simplify airoha,en7581-gpio-sysctl.yam binding
> - Link to v3: https://lore.kernel.org/r/20240831-en7581-pinctrl-v3-0-98ee=
bfb4da66@kernel.org
>=20
> Changes in v3:
> - introduce airoha-mfd driver
> - add pwm driver to the same series
> - model pinctrl and pwm drivers as childs of a parent mfd driver.
> - access chip-scu memory region in pinctrl driver via syscon
> - introduce a single airoha,en7581-gpio-sysctl.yaml binding and get rid
>   of dedicated bindings for pinctrl and pwm
> - add airoha,en7581-chip-scu.yaml binding do the series
> - Link to v2: https://lore.kernel.org/r/20240822-en7581-pinctrl-v2-0-ba15=
59173a7f@kernel.org
>=20
> Changes in v2:
> - Fix compilation errors
> - Collapse some register mappings for gpio and irq controllers
> - update dt-bindings according to new register mapping
> - fix some dt-bindings errors
> - Link to v1: https://lore.kernel.org/all/cover.1723392444.git.lorenzo@ke=
rnel.org/
>=20
>  drivers/pwm/Kconfig      |  11 +
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-airoha.c | 506 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 518 insertions(+)
>  create mode 100644 drivers/pwm/pwm-airoha.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 63beb0010e3e..e939187784c0 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -54,6 +54,17 @@ config PWM_ADP5585
>  	  This option enables support for the PWM function found in the Analog
>  	  Devices ADP5585.
> =20
> +config PWM_AIROHA
> +	tristate "Airoha PWM support"
> +	depends on ARCH_AIROHA || COMPILE_TEST
> +	depends on OF
> +	select REGMAP_MMIO
> +	help
> +	  Generic PWM framework driver for Airoha SoC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-airoha.
> +
>  config PWM_APPLE
>  	tristate "Apple SoC PWM support"
>  	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 539e0def3f82..97c1c79bbc54 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PWM)		+=3D core.o
>  obj-$(CONFIG_PWM_AB8500)	+=3D pwm-ab8500.o
>  obj-$(CONFIG_PWM_ADP5585)	+=3D pwm-adp5585.o
> +obj-$(CONFIG_PWM_AIROHA)	+=3D pwm-airoha.o
>  obj-$(CONFIG_PWM_APPLE)		+=3D pwm-apple.o
>  obj-$(CONFIG_PWM_ATMEL)		+=3D pwm-atmel.o
>  obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+=3D pwm-atmel-hlcdc.o
> diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
> new file mode 100644
> index 000000000000..05dd34656c23
> --- /dev/null
> +++ b/drivers/pwm/pwm-airoha.c
> @@ -0,0 +1,506 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
> + *
> + *  Limitations:
> + *  - Only 8 concurrent waveform generators are available for 8 combinat=
ions of
> + *    duty_cycle and period. Waveform generators are shared between 16 G=
PIO
> + *    pins and 17 SIPO GPIO pins.
> + *  - Supports only normal polarity.
> + *  - On configuration the currently running period is completed.
> + *  - Minimum supported period is 4ms
> + *  - Maximum supported period is 1s
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/gpio.h>
> +#include <linux/bitops.h>
> +#include <linux/regmap.h>

alphabetic ordering would be nice for the includes.

> +#include <asm/div64.h>

linux/math64.h is the right include for div_u64 et al.

> +#define AIROHA_PWM_REG_SGPIO_LED_DATA		0x0024
> +#define AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG	BIT(31)
> +#define AIROHA_PWM_SGPIO_LED_DATA_DATA		GENMASK(16, 0)
> +
> +#define AIROHA_PWM_REG_SGPIO_CLK_DIVR		0x0028
> +#define AIROHA_PWM_SGPIO_CLK_DIVR		GENMASK(1, 0)
> +
> +#define AIROHA_PWM_REG_SGPIO_CLK_DLY		0x002c
> +
> +#define AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG	0x0030
> +#define AIROHA_PWM_SERIAL_GPIO_FLASH_MODE	BIT(1)
> +#define AIROHA_PWM_SERIAL_GPIO_MODE_74HC164	BIT(0)
> +
> +#define AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(_n)	(0x003c + (4 * (_n)))
> +#define AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(_n) (16 * (_n))
> +#define AIROHA_PWM_GPIO_FLASH_PRD_LOW		GENMASK(15, 8)
> +#define AIROHA_PWM_GPIO_FLASH_PRD_HIGH		GENMASK(7, 0)
> +
> +#define AIROHA_PWM_REG_GPIO_FLASH_MAP(_n)	(0x004c + (4 * (_n)))
> +#define AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(_n) (4 * (_n))
> +#define AIROHA_PWM_GPIO_FLASH_EN		BIT(3)
> +#define AIROHA_PWM_GPIO_FLASH_SET_ID		GENMASK(2, 0)
> +
> +/* Register map is equal to GPIO flash map */
> +#define AIROHA_PWM_REG_SIPO_FLASH_MAP(_n)	(0x0054 + (4 * (_n)))
> +
> +#define AIROHA_PWM_REG_CYCLE_CFG_VALUE(_n)	(0x0098 + (4 * (_n)))
> +#define AIROHA_PWM_REG_CYCLE_CFG_SHIFT(_n)	(8 * (_n))
> +#define AIROHA_PWM_WAVE_GEN_CYCLE		GENMASK(7, 0)
> +
> +/* GPIO/SIPO flash map handles 8 pins in one register */
> +#define AIROHA_PWM_PINS_PER_FLASH_MAP		8
> +/* Cycle cfg handles 4 generators in one register */
> +#define AIROHA_PWM_BUCKET_PER_CYCLE_CFG		4
> +/* Flash producer handles 2 generators in one register */
> +#define AIROHA_PWM_BUCKET_PER_FLASH_PROD	2
> +
> +#define AIROHA_PWM_NUM_BUCKETS			8
> +/*
> + * The first 16 GPIO pins, GPIO0-GPIO15, are mapped into 16 PWM channels=
, 0-15.
> + * The SIPO GPIO pins are 17 pins which are mapped into 17 PWM channels,=
 16-32.
> + * However, we've only got 8 concurrent waveform generators and can ther=
efore
> + * only use up to 8 different combinations of duty cycle and period at a=
 time.
> + */
> +#define AIROHA_PWM_NUM_GPIO			16
> +#define AIROHA_PWM_NUM_SIPO			17
> +#define AIROHA_PWM_MAX_CHANNELS			(AIROHA_PWM_NUM_GPIO + AIROHA_PWM_NUM_=
SIPO)
> +
> +struct airoha_pwm_bucket {
> +	/* Bitmask of PWM channels using this bucket */
> +	u64 used;
> +	u64 period_ns;
> +	u64 duty_ns;
> +};
> +
> +struct airoha_pwm {
> +	struct regmap *regmap;
> +
> +	u64 initialized;
> +
> +	struct airoha_pwm_bucket buckets[AIROHA_PWM_NUM_BUCKETS];
> +
> +	/* Cache bucket used by each pwm channel */
> +	u8 channel_bucket[AIROHA_PWM_MAX_CHANNELS];
> +};
> +
> +/* The PWM hardware supports periods between 4 ms and 1 s */
> +#define AIROHA_PWM_PERIOD_TICK_NS	(4 * NSEC_PER_MSEC)
> +#define AIROHA_PWM_PERIOD_MAX_NS	(1 * NSEC_PER_SEC)
> +/* It is represented internally as 1/250 s between 1 and 250. Unit is ti=
cks. */
> +#define AIROHA_PWM_PERIOD_MIN		1
> +#define AIROHA_PWM_PERIOD_MAX		250
> +/* Duty cycle is relative with 255 corresponding to 100% */
> +#define AIROHA_PWM_DUTY_FULL		255
> +
> +static void airoha_pwm_get_flash_map_addr_and_shift(unsigned int hwpwm,
> +						    u32 *addr, u32 *shift)
> +{
> +	unsigned int offset, hwpwm_bit;
> +
> +	if (hwpwm >=3D AIROHA_PWM_NUM_GPIO) {
> +		unsigned int sipohwpwm =3D hwpwm - AIROHA_PWM_NUM_GPIO;
> +
> +		offset =3D sipohwpwm / AIROHA_PWM_PINS_PER_FLASH_MAP;
> +		hwpwm_bit =3D sipohwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP;
> +
> +		/* One FLASH_MAP register handles 8 pins */
> +		*shift =3D AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm_bit);
> +		*addr =3D AIROHA_PWM_REG_SIPO_FLASH_MAP(offset);
> +	} else {
> +		offset =3D hwpwm / AIROHA_PWM_PINS_PER_FLASH_MAP;
> +		hwpwm_bit =3D hwpwm % AIROHA_PWM_PINS_PER_FLASH_MAP;
> +
> +		/* One FLASH_MAP register handles 8 pins */
> +		*shift =3D AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm_bit);
> +		*addr =3D AIROHA_PWM_REG_GPIO_FLASH_MAP(offset);
> +	}
> +}
> +
> +static void airoha_pwm_get_ticks_from_ns(u64 period_ns, u32 *period_tick,
> +					 u64 duty_ns, u32 *duty_tick)
> +{
> +	u64 tmp_duty_tick;
> +
> +	*period_tick =3D div_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> +
> +	tmp_duty_tick =3D mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
> +					    period_ns);

So period can be set to multiples of 4 ms. If you request

	.period_ns =3D 11999 ns
	.duty_ns =3D 4016 ns

the hardware should configure=20

	.period =3D 8000 ns
	.duty_cycle =3D 4015.6862745098038 ns (i.e. 128/255 * period)

corresponding to period_tick =3D 2 and duty_tick =3D 128.

However you calculate duty_tick =3D 85.

I would expect that with having PWM_DEBUG enabled you get a warning when
you do:

	pwmset -P 8000 -D 4016
	pwmset -P 11999 -D 4016

> +	if (tmp_duty_tick > AIROHA_PWM_DUTY_FULL)
> +		tmp_duty_tick =3D AIROHA_PWM_DUTY_FULL;

This can only happen when duty_ns > period_ns is passed to
airoha_pwm_get_ticks_from_ns(). You can rule that out if you do in
=2Eapply():

	if (period_ns > AIROHA_PWM_PERIOD_MAX_NS) {
		period_ns =3D AIROHA_PWM_PERIOD_MAX_NS;

		if (duty_ns > period_ns)
			duty_ns =3D period_ns;
	}

which should be a tad cheaper.

> +	*duty_tick =3D tmp_duty_tick;
> +}
> +
> +static void airoha_pwm_get_bucket(struct airoha_pwm *pc, int bucket,
> +				  u64 *period_ns, u64 *duty_ns)
> +{
> +	u32 period_tick, duty_tick;
> +	unsigned int offset;
> +	u32 shift, val;
> +
> +	offset =3D bucket / AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> +	shift =3D bucket % AIROHA_PWM_BUCKET_PER_CYCLE_CFG;
> +	shift =3D AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> +
> +	regmap_read(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), &val);
> +
> +	period_tick =3D FIELD_GET(AIROHA_PWM_WAVE_GEN_CYCLE, val >> shift);

What a pity that FIELD_GET only works for compile time constants.

> +	*period_ns =3D period_tick * AIROHA_PWM_PERIOD_TICK_NS;
> +
> +	offset =3D bucket / AIROHA_PWM_BUCKET_PER_FLASH_PROD;
> +	shift =3D bucket % AIROHA_PWM_BUCKET_PER_FLASH_PROD;
> +	shift =3D AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> +
> +	regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> +		    &val);
> +
> +	duty_tick =3D FIELD_GET(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, val >> shift);
> +	*duty_ns =3D DIV_U64_ROUND_UP(duty_tick * *period_ns, AIROHA_PWM_DUTY_F=
ULL);

The multiplication cannot overflow here I assume because duty_tick and
*period_ns are small enough. Please justify that in a comment.

> +}
> +
> +static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
> +				    u64 period_ns)
> +{
> +	int i, unused =3D -1;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pc->buckets); i++) {
> +		struct airoha_pwm_bucket *bucket =3D &pc->buckets[i];
> +		u32 duty_tick, duty_tick_bucket;
> +		u32 period_tick;
> +
> +		/* If found, save an unused bucket to return it later */
> +		if (!bucket->used && unused =3D=3D -1) {
> +			unused =3D i;
> +			continue;
> +		}
> +
> +		if (duty_ns =3D=3D bucket->duty_ns &&
> +		    period_ns =3D=3D bucket->period_ns)
> +			return i;
> +
> +		/*
> +		 * Unlike duty cycle zero, which can be handled by
> +		 * disabling PWM, a generator is needed for full duty
> +		 * cycle but it can be reused regardless of period
> +		 */
> +		airoha_pwm_get_ticks_from_ns(period_ns, &period_tick,
> +					     duty_ns, &duty_tick);
> +		airoha_pwm_get_ticks_from_ns(bucket->period_ns, &period_tick,
> +					     bucket->duty_ns, &duty_tick_bucket);

This uselessly calculates the value for &period_tick twice :-\

> +		if (duty_tick =3D=3D AIROHA_PWM_DUTY_FULL &&
> +		    duty_tick =3D=3D duty_tick_bucket)

I would say that

	if (duty_tick =3D=3D AIROHA_PWM_DUTY_FULL &&
	    duty_tick_bucket =3D=3D AIROHA_PWM_DUTY_FULL)

is more intuitive here. Do you agree?

> +			return i;
> +	}
> +
> +	return unused;
> +}
> +
> +static void airoha_pwm_release_bucket_config(struct airoha_pwm *pc,
> +					     unsigned int hwpwm)
> +{
> +	int bucket;
> +
> +	/* Nothing to clear, PWM channel never used */
> +	if (!(pc->initialized & BIT_ULL(hwpwm)))
> +		return;
> +
> +	bucket =3D pc->channel_bucket[hwpwm];
> +	pc->buckets[bucket].used &=3D ~BIT_ULL(hwpwm);
> +}
> +
> +static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
> +					u64 duty_ns, u64 period_ns,
> +					unsigned int hwpwm)
> +{
> +	int bucket;
> +
> +	/*
> +	 * Search for a bucket that already satisfy duty and period
> +	 * or an unused one.
> +	 * If not found, -1 is returned.
> +	 */
> +	bucket =3D airoha_pwm_get_generator(pc, duty_ns, period_ns);
> +	if (bucket < 0)
> +		return bucket;

You're supposed to configure the maximal possible period not bigger than
the requested one. So if period_ns =3D 16 ms, picking a bucket that has
period_ns =3D 12 ns is better than having to give up.

> +	airoha_pwm_release_bucket_config(pc, hwpwm);
> +	pc->buckets[bucket].used |=3D BIT_ULL(hwpwm);
> +	pc->buckets[bucket].period_ns =3D period_ns;
> +	pc->buckets[bucket].duty_ns =3D duty_ns;
> +
> +	return bucket;
> +}
> +
> +static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
> +{
> +	u32 val;
> +
> +	if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> +		return 0;
> +
> +	regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> +			  AIROHA_PWM_SERIAL_GPIO_MODE_74HC164);
> +
> +	/* Configure shift register timings, use 32x divisor */
> +	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DIVR,
> +		     FIELD_PREP(AIROHA_PWM_SGPIO_CLK_DIVR, 0x3));
> +
> +	/*
> +	 * The actual delay is clock + 1.

What is `clock`?

> +	 * Notice that clock delay should not be greater
> +	 * than (divisor / 2) - 1.

`divisor` is the value written to AIROHA_PWM_SGPIO_CLK_DIVR?

> +	 * Set to 0 by default. (aka 1)

Set to 0 by default corresponding to a delay of 1 ms (or 4 ms or what?)

> +	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DLY, 0x0);
> +
> +	/*
> +	 * It it necessary to after muxing explicitly shift out all
> +	 * zeroes to initialize the shift register before enabling PWM

My German ear suggests: "It is necessary to explicitly shift out all
zeros after muxing to ..."

> +	 * mode because in PWM mode SIPO will not start shifting until
> +	 * it needs to output a non-zero value (bit 31 of led_data
> +	 * indicates shifting in progress and it must return to zero
> +	 * before led_data can be written or PWM mode can be set)
> +	 */
> +	if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA,=
 val,
> +				     !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
> +				     10, 200 * USEC_PER_MSEC))
> +		return -ETIMEDOUT;
> +
> +	regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA,
> +			  AIROHA_PWM_SGPIO_LED_DATA_DATA);
> +	if (regmap_read_poll_timeout(pc->regmap, AIROHA_PWM_REG_SGPIO_LED_DATA,=
 val,
> +				     !(val & AIROHA_PWM_SGPIO_LED_DATA_SHIFT_FLAG),
> +				     10, 200 * USEC_PER_MSEC))
> +		return -ETIMEDOUT;
> +
> +	/* Set SIPO in PWM mode */
> +	regmap_set_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> +			AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
> +
> +	return 0;
> +}

Best regards
Uwe

--k4gp3tbfhumfaehw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgd22YACgkQj4D7WH0S
/k64yQgAp3w2fxQ0p0AvY0hzlU6aRPfM4yhbjlwrluAV2hyoZf6u7BAqLXdCBCwE
s1/uZHT40PDP5Xru6rWcCvi5PhPkbF+8u4vyVXpo8+LIfJEOEH9M73YcEGvjxujC
3EAQVa/+urcpIYxPRu27Z74tieGKcLddUU8jfyTpagQ9cnGxalgkZu5ige9a5hWv
Lssb807h5Ypq76epy+GC07i3gMw5TuctX4Xkj9EY/2I18yZuphLekiMrliB+Doxp
XtS9zDmyYLAKHosQ/l+vvT+w18PIZHeMPNErZmjQN71F0YimD9ruFvhRRs9SFQof
2P7it24NTjekmZX9688+J1fmAgAY+w==
=DjDp
-----END PGP SIGNATURE-----

--k4gp3tbfhumfaehw--

