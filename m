Return-Path: <linux-pwm+bounces-4451-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500489FABA3
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 09:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA011164F21
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Dec 2024 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B49F189B9C;
	Mon, 23 Dec 2024 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9a9qzdp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3C38C;
	Mon, 23 Dec 2024 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734943543; cv=none; b=Zz9meeIeRY1fhiMMZRW7o6qnBFEDTpMljhnoFsvvJ2rYpA2+maM+IpqUU5RVhCG7KHzNKxQd2asOhmsCZ4oEb2Rm8A2wIYLlVk5TnaS3f7nLsOhtTsyskLgH6VXstJErv5MEU6GbWqmBSFOLykCinxf4bdcNQ6MjdQqgzQ4u5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734943543; c=relaxed/simple;
	bh=oxaR75KODgfW2g4uXMEUw5A3MMXtSY8IDeOlymmEhKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i27MclH4IEqJe0LhW4uNTIwBTw6MwhMquxy3U7BGzN9+t0FxwF2niXjouqLTxNhAXb6S3ZI8OxAe8FzOjNoxZE/8c8JK24pifN6haqOmyY2mvDQsjXiXATdONC/NRR/fOyeDDVAmysvyNINDsmDmQHqm3G8YVnPEnPJvLnJC5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9a9qzdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E5EAC4CED3;
	Mon, 23 Dec 2024 08:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734943542;
	bh=oxaR75KODgfW2g4uXMEUw5A3MMXtSY8IDeOlymmEhKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9a9qzdpmkgsbI7k3wSlaqFNGYvNBYYwyWo9EgRtUFLhK2ldTgv8Byp5AdA+Lm26d
	 Vd9H5nz/Gurph2NCBOA8fkm+LwR5xOFj/0dUv4F9RIXxCI8RC4bzQH366SZR4aQevy
	 u1EM7KRjDg11Pkiz6nosUYGieyRa+kSx0gsjrqnb+q8AAVsvbVNQoXt429bTmiXxxj
	 jZ5U+WkTtotEExmN7JovOwhUerdAPf7IxbjsABOLcY5Ae7KXBvh1iWUu37G27nrZtw
	 abIr+WPSP+0i8tZzp379DnmX4K+t6F/82HjrL0jlL9M+1Kiegt6LfPcbYhg+WlZdv5
	 xN38+TdG+Dtsw==
Date: Mon, 23 Dec 2024 09:45:39 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v10] pwm: airoha: Add support for EN7581 SoC
Message-ID: <fxunijzek27ixqou3ga6fnttc4aa3ierxqhef4xm2ir5aw2vgm@emet3mqb3qmd>
References: <20241103-en7581-pinctrl-v10-1-1990fb6996a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iibdbdrklzztnxwb"
Content-Disposition: inline
In-Reply-To: <20241103-en7581-pinctrl-v10-1-1990fb6996a0@kernel.org>


--iibdbdrklzztnxwb
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello,

thanks for your patience.

On Sun, Nov 03, 2024 at 10:04:04PM +0100, Lorenzo Bianconi wrote:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
>=20
> Introduce driver for PWM module available on EN7581 SoC.
>=20
> Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Introduce airoha-mfd driver in order to load pinctrl and pwm drivers for
> EN7581 SoC. airoha-mfd is needed since both pinctrl and pwm drivers
> needs to access the same memory block (gpio memory region) to configure
> {gio,irq}_chip and pwm functionalities respectively, so model them as
> childs of a parent mfd driver.
> Current EN7581 pinctrl driver supports the following functionalities:
> - pin multiplexing via chip_scu syscon
> - pin pull-up, pull-down, open-drain, current strength,
>   {input,output}_enable, output_{low,high} via chip_scu syscon
> - gpio controller
> - irq controller
> ---
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
> ---
>  drivers/pwm/Kconfig      |  11 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-airoha.c | 434 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 446 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-airoha.c b/drivers/pwm/pwm-airoha.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..78bc29e1deef9640f7021ce44=
fff5bce32dd5477
> --- /dev/null
> +++ b/drivers/pwm/pwm-airoha.c
> @@ -0,0 +1,434 @@
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

If there is a public datasheet, adding a link here would be great.

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
> +#include <asm/div64.h>
> +
> +#define REG_SGPIO_LED_DATA		0x0024
> +#define SGPIO_LED_DATA_SHIFT_FLAG_MASK	BIT(31)
> +#define SGPIO_LED_DATA_DATA_MASK	GENMASK(16, 0)
> +
> +#define REG_SGPIO_CLK_DIVR		0x0028
> +#define SGPIO_CLK_DIVR_MASK		GENMASK(1, 0)
> +
> +#define REG_SGPIO_CLK_DLY		0x002c
> +
> +#define REG_SIPO_FLASH_MODE_CFG		0x0030
> +#define SERIAL_GPIO_FLASH_MODE_MASK	BIT(1)
> +#define SERIAL_GPIO_MODE_74HC164_MASK	BIT(0)
> +
> +#define REG_GPIO_FLASH_PRD_SET(_n)	(0x003c + (((_n) >> 1) << 2))
> +#define GPIO_FLASH_PRD_HIGH_MASK(_n)	\
> +	GENMASK(7 + (((_n) % 2) << 4),	((_n) % 2) << 4)
> +#define GPIO_FLASH_PRD_LOW_MASK(_n)	\
> +	GENMASK(15 + (((_n) % 2) << 4), 8 + (((_n) % 2) << 4))
> +
> +#define REG_GPIO_FLASH_MAP(_n)		(0x004c + (((_n) >> 3) << 2))

Huh, this makes the usage ugly. E.g.

	addr =3D REG_GPIO_FLASH_MAP(hwpwm);

looks as if there was a register per hwpwm. Also in general it's
beneficial to have the defines match the data sheet and I doubt that
there are GPIO_FLASH_MAP0, GPIO_FLASH_MAP1 ... REG_GPIO_FLASH_MAP15 with
only two distinct values. Assuming the official names are

	GPIO_FLASH_MAP0
	GPIO_FLASH_MAP1

I'd do:

	#define AIROHA_PWM_GPIO_FLASH_MAP(n)	(0x004c + 4 * (n))

	...

	/* One GPIO_FLASH_MAP register handles 8 pins */
	addr =3D AIROHA_PWM_GPIO_FLASH_MAP(hwpwm / 8);

and then I'd even go so far and do

	mask =3D GPIO_FLASH_SET_ID_MASK(hwpwm % 8);

and drop the % 8 from the definition of GPIO_FLASH_SET_ID_MASK.

> +#define GPIO_FLASH_EN_MASK(_n)		BIT(3 + (((_n) % 8) << 2))

This is a flag in the REG_GPIO_FLASH_MAP register, so it would be nice
if the name would show that (i.e. please include the full name of the
register in the bit field define).

Also there is little gain in the MASK suffix.

> +#define GPIO_FLASH_SET_ID_MASK(_n)	\
> +	GENMASK(2 + (((_n) % 8) << 2), ((_n) % 8) << 2)
> +
> +/* Register map is equal to GPIO flash map */
> +#define REG_SIPO_FLASH_MAP(_n)		(0x0054 + (((_n) >> 3) << 2))
> +
> +#define REG_CYCLE_CFG_VALUE(_n)		(0x0098 + (((_n) >> 2) << 2))
> +#define WAVE_GEN_CYCLE_MASK(_n)		\
> +	GENMASK(7 + (((_n) % 4) << 3), ((_n) % 4) << 3)
> +

Can you please give these defines all a common name prefix?

> +#define AIROHA_PWM_NUM_BUCKETS		8
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
> +#define AIROHA_PWM_NUM_GPIO		16
> +#define AIROHA_PWM_NUM_SIPO		17
> +#define AIROHA_PWM_MAX_CHANNELS		(AIROHA_PWM_NUM_GPIO + AIROHA_PWM_NUM_S=
IPO)
> +

A comment here about why AIROHA_PWM_FIELD_[GS]ET exists would be nice.

> +#define AIROHA_PWM_FIELD_GET(mask, val)	(((val) & (mask)) >> __ffs(mask))
> +#define AIROHA_PWM_FIELD_SET(mask, val)	(((val) << __ffs(mask)) & (mask))
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
> +#define AIROHA_PWM_PERIOD_MIN_NS	(4 * NSEC_PER_MSEC)
> +#define AIROHA_PWM_PERIOD_MAX_NS	(1 * NSEC_PER_SEC)

the MAX_NS symbol is unused. If you want to mention that, do that in the
Limitations list.

> +/* It is represented internally as 1/250 s between 1 and 250 */
> +#define AIROHA_PWM_PERIOD_MIN		1
> +#define AIROHA_PWM_PERIOD_MAX		250

The unit of these is ticks. Maybe add that info in a comment.

> +/* Duty cycle is relative with 255 corresponding to 100% */
> +#define AIROHA_PWM_DUTY_FULL		255

So a setting of period_ticks =3D 1 and duty_ticks =3D 1 gives a setting of
period =3D 4000 =B5s and duty_cycle =3D 1 s / (250 * 255) =3D 15.6862745098=
03921
=B5s? So either the hardware has a fractional divider or the input clock
runs with a rate that is a multiple of 63750 Hz. While this is
theoretically possible I would have expected a 64 kHz input, but then
something is wrong here. Do you really get a 100% relative duty_cycle
with duty_step =3D 255?

> +static u32 airoha_pwm_get_duty_tick_from_ns(u64 duty_ns, u64 period_ns)
> +{
> +	u32 duty_tick;
> +
> +	duty_tick =3D mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
> +					period_ns);
> +	return min_t(u32, duty_tick, AIROHA_PWM_DUTY_FULL);
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
> +		duty_tick =3D airoha_pwm_get_duty_tick_from_ns(duty_ns,
> +							     period_ns);
> +		duty_tick_bucket =3D
> +			airoha_pwm_get_duty_tick_from_ns(bucket->duty_ns,
> +							 bucket->period_ns);
> +		if (duty_tick =3D=3D AIROHA_PWM_DUTY_FULL &&
> +		    duty_tick =3D=3D duty_tick_bucket)
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
> +
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
> +	regmap_clear_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
> +			  SERIAL_GPIO_MODE_74HC164_MASK);
> +
> +	/* Configure shift register timings, use 32x divisor */
> +	regmap_write(pc->regmap, REG_SGPIO_CLK_DIVR,
> +		     FIELD_PREP(SGPIO_CLK_DIVR_MASK, 0x3));
> +
> +	/*
> +	 * The actual delay is clock + 1.
> +	 * Notice that clock delay should not be greater
> +	 * than (divisor / 2) - 1.
> +	 * Set to 0 by default. (aka 1)
> +	 */
> +	regmap_write(pc->regmap, REG_SGPIO_CLK_DLY, 0x0);
> +
> +	/*
> +	 * It it necessary to after muxing explicitly shift out all
> +	 * zeroes to initialize the shift register before enabling PWM
> +	 * mode because in PWM mode SIPO will not start shifting until
> +	 * it needs to output a non-zero value (bit 31 of led_data
> +	 * indicates shifting in progress and it must return to zero
> +	 * before led_data can be written or PWM mode can be set)
> +	 */
> +	if (regmap_read_poll_timeout(pc->regmap, REG_SGPIO_LED_DATA, val,
> +				     !(val & SGPIO_LED_DATA_SHIFT_FLAG_MASK),
> +				     10, 200 * USEC_PER_MSEC))
> +		return -ETIMEDOUT;
> +
> +	regmap_clear_bits(pc->regmap, REG_SGPIO_LED_DATA,
> +			  SGPIO_LED_DATA_DATA_MASK);
> +	if (regmap_read_poll_timeout(pc->regmap, REG_SGPIO_LED_DATA, val,
> +				     !(val & SGPIO_LED_DATA_SHIFT_FLAG_MASK),
> +				     10, 200 * USEC_PER_MSEC))
> +		return -ETIMEDOUT;
> +
> +	/* Set SIPO in PWM mode */
> +	regmap_set_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
> +			SERIAL_GPIO_FLASH_MODE_MASK);
> +
> +	return 0;
> +}
> +
> +static void airoha_pwm_calc_bucket_config(struct airoha_pwm *pc, int buc=
ket,
> +					  u64 duty_ns, u64 period_ns)
> +{
> +	u32 period_tick, duty_tick, mask, val;
> +
> +	duty_tick =3D airoha_pwm_get_duty_tick_from_ns(duty_ns, period_ns);
> +	period_tick =3D mul_u64_u64_div_u64(period_ns, AIROHA_PWM_PERIOD_MAX,
> +					  NSEC_PER_SEC);
> +	period_tick =3D min_t(u32, period_tick, AIROHA_PWM_PERIOD_MAX);

This is inexact. You're supposed to pick the highest duty_cycle not
bigger than the requested value after picking the period in the same
way.

A request of

	.period =3D 43999999
	.duty_cycle =3D 19921569

yields actual .period =3D 40000000 ns and .duty_cycle =3D
18039215.68627451 ns (with period_tick =3D 10 and duty_tick =3D 115) while
it could use duty_tick =3D 127 which (I think) gives a duty cycle of
19921568.62745098 ns.

> +	/* Configure frequency divisor */
> +	mask =3D WAVE_GEN_CYCLE_MASK(bucket);
> +	val =3D AIROHA_PWM_FIELD_SET(mask, period_tick);
> +	regmap_update_bits(pc->regmap, REG_CYCLE_CFG_VALUE(bucket), mask, val);
> +
> +	/* Configure duty cycle */
> +	mask =3D GPIO_FLASH_PRD_HIGH_MASK(bucket);
> +	val =3D AIROHA_PWM_FIELD_SET(mask, duty_tick);
> +	regmap_update_bits(pc->regmap, REG_GPIO_FLASH_PRD_SET(bucket),
> +			   mask, val);
> +
> +	mask =3D GPIO_FLASH_PRD_LOW_MASK(bucket);
> +	val =3D AIROHA_PWM_FIELD_SET(mask, AIROHA_PWM_DUTY_FULL - duty_tick);
> +	regmap_update_bits(pc->regmap, REG_GPIO_FLASH_PRD_SET(bucket),
> +			   mask, val);
> +}
> +
> +static void airoha_pwm_config_flash_map(struct airoha_pwm *pc,
> +					unsigned int hwpwm, int index)
> +{
> +	u32 addr, mask, val;
> +
> +	if (hwpwm < AIROHA_PWM_NUM_GPIO) {
> +		addr =3D REG_GPIO_FLASH_MAP(hwpwm);
> +	} else {
> +		hwpwm -=3D AIROHA_PWM_NUM_GPIO;
> +		addr =3D REG_SIPO_FLASH_MAP(hwpwm);
> +	}
> +
> +	/* index -1 means disable PWM channel */
> +	if (index < 0) {
> +		/*
> +		 * Change of waveform takes effect immediately but
> +		 * disabling has some delay so to prevent glitching
> +		 * only the enable bit is touched when disabling.
> +		 * Duty cycle can't be set to 0 as it might be shared with
> +		 * others channels with same duty cycle.
> +		 */
> +		regmap_clear_bits(pc->regmap, addr, GPIO_FLASH_EN_MASK(hwpwm));
> +		return;
> +	}
> +
> +	mask =3D GPIO_FLASH_SET_ID_MASK(hwpwm);
> +	val =3D AIROHA_PWM_FIELD_SET(mask, index);
> +	regmap_update_bits(pc->regmap, addr, mask, val);
> +	regmap_set_bits(pc->regmap, addr, GPIO_FLASH_EN_MASK(hwpwm));
> +}
> +
> +static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *p=
wm,
> +			     u64 duty_ns, u64 period_ns)
> +{
> +	int bucket, hwpwm =3D pwm->hwpwm;
> +
> +	bucket =3D airoha_pwm_consume_generator(pc, duty_ns, period_ns,
> +					      hwpwm);
> +	if (bucket < 0)
> +		return -EBUSY;
> +
> +	if (!(pc->initialized & BIT_ULL(hwpwm)) &&
> +	    hwpwm >=3D AIROHA_PWM_NUM_GPIO)

No need for a line break in that if condition.

> +		airoha_pwm_sipo_init(pc);

Do you need to do that on each reconfiguration?

> +	airoha_pwm_calc_bucket_config(pc, bucket, duty_ns, period_ns);
> +	airoha_pwm_config_flash_map(pc, hwpwm, bucket);
> +
> +	pc->initialized |=3D BIT_ULL(hwpwm);
> +	pc->channel_bucket[hwpwm] =3D bucket;
> +
> +	return 0;
> +}
> +
> +static void airoha_pwm_disable(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct airoha_pwm *pc =3D pwmchip_get_drvdata(chip);
> +
> +	/* Disable PWM and release the bucket */
> +	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
> +	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
> +
> +	pc->initialized &=3D ~BIT_ULL(pwm->hwpwm);
> +	if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> +		regmap_clear_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
> +				  SERIAL_GPIO_FLASH_MODE_MASK);
> +}
> +
> +static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	u64 duty_ns =3D state->enabled ? state->duty_cycle : 0;

Using

	u64 duty_ns =3D state->duty_cycle

has the same effect and is simpler. Then dropping this variable is even
simpler as it's used only once.

> +	struct airoha_pwm *pc =3D pwmchip_get_drvdata(chip);
> +	u64 period_ns =3D state->period;
> +
> +	/* Only normal polarity is supported */
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		airoha_pwm_disable(chip, pwm);
> +		return 0;
> +	}
> +
> +	if (period_ns < AIROHA_PWM_PERIOD_MIN_NS)
> +		return -EINVAL;
> +
> +	return airoha_pwm_config(pc, pwm, duty_ns, period_ns);
> +}
> +
> +static int airoha_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				struct pwm_state *state)
> +{
> +	struct airoha_pwm *pc =3D pwmchip_get_drvdata(chip);
> +	int ret, hwpwm =3D pwm->hwpwm;
> +	u32 addr, val;
> +	u8 bucket;
> +
> +	if (hwpwm < AIROHA_PWM_NUM_GPIO) {
> +		addr =3D REG_GPIO_FLASH_MAP(hwpwm);
> +	} else {
> +		hwpwm -=3D AIROHA_PWM_NUM_GPIO;
> +		addr =3D REG_SIPO_FLASH_MAP(hwpwm);
> +	}
> +
> +	ret =3D regmap_read(pc->regmap, addr, &val);
> +	if (ret)
> +		return ret;
> +
> +	state->enabled =3D AIROHA_PWM_FIELD_GET(GPIO_FLASH_EN_MASK(hwpwm), val);
> +	if (!state->enabled)
> +		return 0;
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	bucket =3D AIROHA_PWM_FIELD_GET(GPIO_FLASH_SET_ID_MASK(hwpwm), val);
> +	ret =3D regmap_read(pc->regmap, REG_CYCLE_CFG_VALUE(bucket), &val);
> +	if (ret)
> +		return ret;
> +
> +	state->period =3D pc->buckets[bucket].period_ns;
> +	state->duty_cycle =3D pc->buckets[bucket].duty_ns;

So if airoha_pwm_get_state() is called before a setting was
airoha_pwm_apply()d, this gives 0, right? Would be great if you returned
the actually configured settings here. Additionally to the model
matching the reality better then, the inexactness I found above would
have been catchable by intensive testing.

> +	return 0;
> +}
> +
> +static const struct pwm_ops airoha_pwm_ops =3D {
> +	.apply =3D airoha_pwm_apply,
> +	.get_state =3D airoha_pwm_get_state,
> +};
> +
> +static int airoha_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct airoha_pwm *pc;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, AIROHA_PWM_MAX_CHANNELS, sizeof(*pc));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	chip->ops =3D &airoha_pwm_ops;
> +	pc =3D pwmchip_get_drvdata(chip);
> +
> +	pc->regmap =3D device_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(pc->regmap)) {
> +		dev_err_probe(dev, PTR_ERR(pc->regmap), "failed to get PWM regmap");
> +		return PTR_ERR(pc->regmap);

return dev_err_probe(dev, PTR_ERR(pc->regmap), "Failed to get PWM regmap\n"=
);

(Note there are three relevant changes in this suggestion.)

> +	}
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, chip);
> +	if (ret)
> +		dev_err_probe(dev, ret, "failed to add PWM chip");

return dev_err_probe(dev, ret, "Failed to add PWM chip\n");

> +	return ret;

return 0;

> +}
> +
> +static const struct of_device_id airoha_pwm_of_match[] =3D {
> +	{ .compatible =3D "airoha,en7581-pwm" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, airoha_pwm_of_match);
> +
> +static struct platform_driver airoha_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-airoha",
> +		.of_match_table =3D airoha_pwm_of_match,
> +	},
> +	.probe =3D airoha_pwm_probe,
> +};
> +module_platform_driver(airoha_pwm_driver);
> +
> +MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
> +MODULE_AUTHOR("Markus Gothe <markus.gothe@genexis.eu>");
> +MODULE_AUTHOR("Benjamin Larsson <benjamin.larsson@genexis.eu>");
> +MODULE_DESCRIPTION("Airoha EN7581 PWM driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--iibdbdrklzztnxwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdpIzAACgkQj4D7WH0S
/k4Bbgf9H7g0vmOS2vrufJkxXRNWrmDxnQsRE1VNQtODV257pBR6NIpXe7nMqzGF
h4SOtPnUZ1vBONQjoMAn9rvsa9uRP+PrNuUS1TzoxKCLK0lpmdgfVKT2fkV4o1Gt
PUB61bD9U6GhQl0OOY9KzJuDJAtKVeUbL6X9sjzhLl5fSu7yBE600aDCxAjW8AIU
shx4HkqIrdso8ZKadnk59BNedBhdobRsbUoB03451sQWe1AQ/nNxQyMQf4ibtMjz
Y4DhKQ82AFXPKrUscbTyevaGxfuYWArQ2UaTaOdEY0SJX472SJ8KefrJNNpeKKIZ
DQvcpHWUCaRjBNECb1h7hKAc0Al3tg==
=SaOZ
-----END PGP SIGNATURE-----

--iibdbdrklzztnxwb--

