Return-Path: <linux-pwm+bounces-5320-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C43DA7A08D
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 11:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9605C18964DA
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 09:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF30224891;
	Thu,  3 Apr 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMvVXCBE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8260319340B;
	Thu,  3 Apr 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674332; cv=none; b=Hn6gWO+i2AhyR1N4IJubdClpFWIGdBU4wTkVUCMUj4mmK59HnkuMypgmZ2ZH7xPSXJP3dAjZL2WLONYT1J7v+Pnhn3BML48nCx/4Xcd3T5iIyGCNXUJIqWJWxdvQEl8KEgvLCpD8XMUCKtAJccROrsnz0Faw96Xc3Is7f1bcSIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674332; c=relaxed/simple;
	bh=N3GM1uYV6mY/2hVboEiPKNDl7OyXrDmjuadabrkmLbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1SuqTutmgm1GTo60+qi3c4kcs1VB8QkxX4yMER6FhKH2TsxcfojvvU1JvJYehD41grHIppmJqFGYeVMv4LGuFWa845Gop1wuO9sF6rY9u3C5CVmCP5kWSDRa37tC7uuMqH6AmBNMfF8okOn1tvxvC48+mf2mp2Ux+/l2l7IGfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMvVXCBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0ABC4CEE3;
	Thu,  3 Apr 2025 09:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743674331;
	bh=N3GM1uYV6mY/2hVboEiPKNDl7OyXrDmjuadabrkmLbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMvVXCBEc1rvAp9Mbg8JiKSdCtcWU/r4h+Pxf3GtfmIfUB+c06fdx/J6Cmaczvheq
	 WUyNb7283bxLMH9pbNwLwfbpJEcTU/fwJ7DA2gvY0TqGXxAt2uPCNtHQF7b2HAs4yO
	 TgOHDzAp6sXBgQoUeO5C1Va1Qd8mKT5yqz86qbRxJ0aojwnjm+Gz19TXczklnAIAkW
	 rD4tdpD5NTrvz1C3SvU8nn+f/zlY6vN50GiqF9c3syZisPHSaRn9slh1LUybeGMiqA
	 qimb3bx9xI75GM6PStlUMwX4peLlwR3cL1q/2sc+D5VSbXW5cmBFJUFIp+15Ic2MG4
	 39ZMiCtdqv92Q==
Date: Thu, 3 Apr 2025 11:58:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Benjamin Larsson <benjamin.larsson@genexis.eu>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [RESEND PATCH v11] pwm: airoha: Add support for EN7581 SoC
Message-ID: <cdwttmqcvhetlf446gsaxsta76ojlqckxc253svho4xsm7qxhs@6otqm6yyuvfh>
References: <20250226002537.3752-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lysf4vcnk3q2xb4m"
Content-Disposition: inline
In-Reply-To: <20250226002537.3752-1-ansuelsmth@gmail.com>


--lysf4vcnk3q2xb4m
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH v11] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello,

On Wed, Feb 26, 2025 at 01:24:42AM +0100, Christian Marangi wrote:
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
>  drivers/pwm/pwm-airoha.c | 488 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 500 insertions(+)
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
> index 000000000000..51d02a5ff064
> --- /dev/null
> +++ b/drivers/pwm/pwm-airoha.c
> @@ -0,0 +1,488 @@
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
> +#include <asm/div64.h>
> +
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

Just for my understanding: So the input clock runs at a multiple of
63750 Hz.

> +static void airoha_pwm_get_flash_map_addr_and_shift(unsigned int hwpwm,
> +						    u32 *addr, u32 *shift)
> +{
> +	u64 offset =3D hwpwm;

unsigned int should be big enough here. This also makes the divisions a
tad cheaper.

> +
> +	if (hwpwm >=3D AIROHA_PWM_NUM_GPIO)
> +		offset -=3D AIROHA_PWM_NUM_GPIO;
> +
> +	/* One FLASH_MAP register handles 8 pins */
> +	*shift =3D do_div(offset, AIROHA_PWM_PINS_PER_FLASH_MAP);
> +	*shift =3D AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(*shift);
> +
> +	if (offset < AIROHA_PWM_NUM_GPIO)
> +		*addr =3D AIROHA_PWM_REG_GPIO_FLASH_MAP(offset);
> +	else
> +		*addr =3D AIROHA_PWM_REG_SIPO_FLASH_MAP(offset);

A single if would be a bit more straight forward. Something like:

	static void airoha_pwm_get_flash_map_addr_and_shift(unsigned int hwpwm,
							    unsigned int *addr, unsigned int *shift)
	{
		u64 offset =3D hwpwm;
=09
		if (hwpwm >=3D AIROHA_PWM_NUM_GPIO) {
			unsigned sipohwpwm =3D hwpwm - AIROHA_PWM_NUM_GPIO;

			*shift =3D AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(sipohwpwm % AIROHA_PWM_PI=
NS_PER_FLASH_MAP)
			*addr =3D AIROHA_PWM_REG_SIPO_FLASH_MAP(sipohwpwm);
		} else {
			*shift =3D AIROHA_PWM_REG_GPIO_FLASH_MAP_SHIFT(hwpwm % AIROHA_PWM_PINS_P=
ER_FLASH_MAP)
			*addr =3D AIROHA_PWM_REG_GPIO_FLASH_MAP(hwpwm);
		}
	}

> +}
> +
> +static void airoha_pwm_get_ticks_from_ns(u64 period_ns, u32 *period_tick,
> +					 u64 duty_ns, u32 *duty_tick)
> +{
> +	period_ns =3D min_t(u64, period_ns, AIROHA_PWM_PERIOD_MAX_NS);
> +	*period_tick =3D div_u64(period_ns, AIROHA_PWM_PERIOD_TICK_NS);
> +
> +	*duty_tick =3D mul_u64_u64_div_u64(duty_ns, AIROHA_PWM_DUTY_FULL,
> +					 *period_tick * AIROHA_PWM_PERIOD_TICK_NS);
> +	*duty_tick =3D min_t(u32, *duty_tick, AIROHA_PWM_DUTY_FULL);
> +}
> +
> +static void airoha_pwm_fill_bucket(struct airoha_pwm *pc, int bucket)
> +{
> +	u64 offset, period_ns, duty_ns;
> +	u32 period_tick, duty_tick;
> +	u32 shift, val;
> +
> +	offset =3D bucket;
> +	shift =3D do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
> +	shift =3D AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> +
> +	regmap_read(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), &val);
> +
> +	period_tick =3D FIELD_GET(AIROHA_PWM_WAVE_GEN_CYCLE, val >> shift);
> +	period_ns =3D period_tick * AIROHA_PWM_PERIOD_TICK_NS;
> +
> +	offset =3D bucket;
> +	shift =3D do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
> +	shift =3D AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> +
> +	regmap_read(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset),
> +		    &val);
> +
> +	duty_tick =3D FIELD_GET(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, val >> shift);
> +	duty_ns =3D mul_u64_u64_div_u64(duty_tick, period_ns, AIROHA_PWM_DUTY_F=
ULL);
> +
> +	pc->buckets[bucket].period_ns =3D period_ns;
> +	pc->buckets[bucket].duty_ns =3D duty_ns;
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

If period_ns =3D=3D 4010 and bucket->period_ns =3D=3D 4000 you're not
considering *bucket even though it has the right period setting.
(period_ns is the requested period and not the expected period actually
implemented by HW, right?)

> +		/*
> +		 * Unlike duty cycle zero, which can be handled by
> +		 * disabling PWM, a generator is needed for full duty
> +		 * cycle but it can be reused regardless of period
> +		 */
> +		airoha_pwm_get_ticks_from_ns(period_ns, &period_tick,
> +					     duty_ns, &duty_tick);
> +		airoha_pwm_get_ticks_from_ns(bucket->period_ns, &period_tick,
> +					     bucket->duty_ns, &duty_tick_bucket);
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
> +	regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> +			  AIROHA_PWM_SERIAL_GPIO_MODE_74HC164);
> +
> +	/* Configure shift register timings, use 32x divisor */
> +	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DIVR,
> +		     FIELD_PREP(AIROHA_PWM_SGPIO_CLK_DIVR, 0x3));
> +
> +	/*
> +	 * The actual delay is clock + 1.
> +	 * Notice that clock delay should not be greater
> +	 * than (divisor / 2) - 1.
> +	 * Set to 0 by default. (aka 1)
> +	 */
> +	regmap_write(pc->regmap, AIROHA_PWM_REG_SGPIO_CLK_DLY, 0x0);
> +
> +	/*
> +	 * It it necessary to after muxing explicitly shift out all
> +	 * zeroes to initialize the shift register before enabling PWM
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
> +
> +static void airoha_pwm_calc_bucket_config(struct airoha_pwm *pc, int buc=
ket,
> +					  u64 duty_ns, u64 period_ns)
> +{
> +	u32 period_tick, duty_tick;
> +	u32 mask, shift, val;
> +	u64 offset;
> +
> +	airoha_pwm_get_ticks_from_ns(period_ns, &period_tick,
> +				     duty_ns, &duty_tick);
> +
> +	offset =3D bucket;
> +	shift =3D do_div(offset, AIROHA_PWM_BUCKET_PER_CYCLE_CFG);
> +	shift =3D AIROHA_PWM_REG_CYCLE_CFG_SHIFT(shift);
> +
> +	/* Configure frequency divisor */
> +	mask =3D AIROHA_PWM_WAVE_GEN_CYCLE << shift;
> +	val =3D FIELD_PREP(AIROHA_PWM_WAVE_GEN_CYCLE, period_tick) << shift;
> +	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_CYCLE_CFG_VALUE(offset), =
mask, val);
> +
> +	offset =3D bucket;
> +	shift =3D do_div(offset, AIROHA_PWM_BUCKET_PER_FLASH_PROD);
> +	shift =3D AIROHA_PWM_REG_GPIO_FLASH_PRD_SHIFT(shift);
> +
> +	/* Configure duty cycle */
> +	mask =3D AIROHA_PWM_GPIO_FLASH_PRD_HIGH << shift;
> +	val =3D FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_HIGH, duty_tick) << shift;
> +	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset=
),
> +			   mask, val);
> +
> +	mask =3D AIROHA_PWM_GPIO_FLASH_PRD_LOW << shift;
> +	val =3D FIELD_PREP(AIROHA_PWM_GPIO_FLASH_PRD_LOW,
> +			 AIROHA_PWM_DUTY_FULL - duty_tick) << shift;
> +	regmap_update_bits(pc->regmap, AIROHA_PWM_REG_GPIO_FLASH_PRD_SET(offset=
),
> +			   mask, val);
> +}
> +
> +static void airoha_pwm_config_flash_map(struct airoha_pwm *pc,
> +					unsigned int hwpwm, int index)
> +{
> +	u32 addr, shift;
> +
> +	airoha_pwm_get_flash_map_addr_and_shift(hwpwm, &addr, &shift);
> +
> +	/* index -1 means disable PWM channel */
> +	if (index < 0) {
> +		/*
> +		 * Change of waveform takes effect immediately but
> +		 * disabling has some delay so to prevent glitching
> +		 * only the enable bit is touched when disabling.
> +		 * Duty cycle can't be set to 0 as it might be shared with
> +		 * others channels with same duty cycle.

clearing enable changes the output to low anyhow, so there would be no
gain in explicitly setting the duty to 0?

> +		 */
> +		regmap_clear_bits(pc->regmap, addr,

regmap_clear_bits expects an unsigned int as 2nd parameter, so maybe use
this type for addr.

> +				  AIROHA_PWM_GPIO_FLASH_EN << shift);
> +		return;
> +	}
> +
> +	regmap_update_bits(pc->regmap, addr,
> +			   AIROHA_PWM_GPIO_FLASH_SET_ID << shift,
> +			   FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID, index) << shift);

Huh, I'd prefer:

	regmap_update_bits(pc->regmap, addr,
			   AIROHA_PWM_GPIO_FLASH_SET_ID(hwpwm % 8)
			   FIELD_PREP(AIROHA_PWM_GPIO_FLASH_SET_ID(hwpwm % 8), index));

(That probably doesn't work out of the box because of the
__builtin_constant_p check on mask, so you might need a local
alternative to FIELD_PREP without that check.)

> +	regmap_set_bits(pc->regmap, addr, AIROHA_PWM_GPIO_FLASH_EN << shift);
> +}
> +
> +static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *p=
wm,
> +			     u64 duty_ns, u64 period_ns)
> +{
> +	int bucket, hwpwm =3D pwm->hwpwm;

hwpwm is unsigned.

> +	bucket =3D airoha_pwm_consume_generator(pc, duty_ns, period_ns,
> +					      hwpwm);
> +	if (bucket < 0)
> +		return -EBUSY;
> +
> +	/*
> +	 * For SIPO reinit is always needed to trigger the shift register chip
> +	 * and apply the new flash configuration.

I don't understand that sentence. What is the shift register chip? What
is a flash configuration?

> +	 */
> +	if (!(pc->initialized & BIT_ULL(hwpwm)) && hwpwm >=3D AIROHA_PWM_NUM_GP=
IO)
> +		airoha_pwm_sipo_init(pc);

The comment says "always", but here you skip if pc->initialized has the
respective bit cleared?

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
> +	pc->initialized &=3D ~BIT_ULL(pwm->hwpwm);
> +	if (!(pc->initialized >> AIROHA_PWM_NUM_GPIO))
> +		regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> +				  AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);

What is the objective of the if block? (-> comment)

> +}
> +
> +static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct airoha_pwm *pc =3D pwmchip_get_drvdata(chip);
> +	u64 period_ns =3D state->period;
> +
> +	/* Only normal polarity is supported */
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		airoha_pwm_disable(chip, pwm);

Maybe pass pc instead of chip here to not have to call
pwmchip_get_drvdata() again. (Alternatively introduce a wrapper around
pwmchip_get_drvdata() that is marked __pure and returns the right type.)

> +		return 0;
> +	}
> +
> +	if (period_ns < AIROHA_PWM_PERIOD_TICK_NS)
> +		return -EINVAL;
> +
> +	return airoha_pwm_config(pc, pwm, state->duty_cycle, period_ns);
> +}
> +
> +static int airoha_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				struct pwm_state *state)
> +{
> +	struct airoha_pwm *pc =3D pwmchip_get_drvdata(chip);
> +	int ret, hwpwm =3D pwm->hwpwm;
> +	u32 addr, shift, val;
> +	u8 bucket;
> +
> +	airoha_pwm_get_flash_map_addr_and_shift(hwpwm, &addr, &shift);
> +
> +	ret =3D regmap_read(pc->regmap, addr, &val);
> +	if (ret)
> +		return ret;
> +
> +	state->enabled =3D FIELD_GET(AIROHA_PWM_GPIO_FLASH_EN, val >> shift);
> +	if (!state->enabled)
> +		return 0;
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +
> +	bucket =3D FIELD_GET(AIROHA_PWM_GPIO_FLASH_SET_ID, val >> shift);
> +	state->period =3D pc->buckets[bucket].period_ns;

Does .period_ns hold the requested or the actual period? You should
return the latter.

> +	state->duty_cycle =3D pc->buckets[bucket].duty_ns;
> +
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
> +	int i, ret;
> +
> +	chip =3D devm_pwmchip_alloc(dev, AIROHA_PWM_MAX_CHANNELS, sizeof(*pc));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	chip->ops =3D &airoha_pwm_ops;
> +	pc =3D pwmchip_get_drvdata(chip);
> +
> +	pc->regmap =3D device_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(pc->regmap))
> +		return dev_err_probe(dev, PTR_ERR(pc->regmap), "Failed to get PWM regm=
ap\n");
> +
> +	/* Fill buckets with initial values */
> +	for (i =3D 0; i < AIROHA_PWM_NUM_BUCKETS; i++)
> +		airoha_pwm_fill_bucket(pc, i);
> +
> +	ret =3D devm_pwmchip_add(&pdev->dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +
> +	return 0;
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

--lysf4vcnk3q2xb4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfuW9YACgkQj4D7WH0S
/k5f+gf+JWmuaxDd1JbUXIzrIYea9paNN7r1oXAc4NZdEsCycEvdlw5a5KpmM0jd
DLE1xXspKNDS1Uo20iTKRqTM7j/DjkeKlZ+5UW4TgZVql3GmDjD17D0xfEbQSavx
EcsfqKNdPJVpvdStklhCXGJ2XZeSqmJpNMqIN/Lm/7iYkpDynVKj0kBK5mORpvgJ
PBwW7t3p8pNM58VEHFBJl/ieKVec8w3c72LRmgcSKwAsU7McEGQsosWOLzgZ7R5w
3tbmmVy4d45lQjv33/NazamB+h9bgn/W8o4VE8U8GbWknl8WHr7x8tRnGkE0j9ET
xr4VRGkOzatqvMzAp35PvvfPhEuymw==
=9k49
-----END PGP SIGNATURE-----

--lysf4vcnk3q2xb4m--

