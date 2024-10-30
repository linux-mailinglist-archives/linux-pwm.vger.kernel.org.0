Return-Path: <linux-pwm+bounces-3968-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4520E9B5CFA
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 08:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1029E1F22466
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 07:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF5C1DF74B;
	Wed, 30 Oct 2024 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IhayTUMA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08191DF723
	for <linux-pwm@vger.kernel.org>; Wed, 30 Oct 2024 07:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273537; cv=none; b=BdTL0A7f0xqC9L80xLWr5W+IQW8pEUKg3nUh83QxT+AYJWFY17W0RT+LLeGtSlrsbKwJEZX5oht9tSJbA0z8F5Iib6tuZC7OTz9rgkzhO7Ic2FofPH5m5F5p5EqsDyVqMQHHO6InA1cqaWsGxRCZzzVfGbiDCoaoQ0PphNAon4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273537; c=relaxed/simple;
	bh=V4ph6pquEImBzFPl35g5KkmEoftAJkoWE2HEYiIc0xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUZ4uwq5OQIlGn0Nz7V36hooFtN5Hro1mNb61IcZ9NsZvgv74ZSA3le1onPO5olZO2C3HjWtrOxKvqPxAS6NG0XAGvxrV+dIlVRSDqSRQVg1zyfi+r3tXpVvs6fYdy7zU5q5dhKzQ0nG7dlaKRp13TikRtbnnO8+kxAoGIQubBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IhayTUMA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d3ecad390so318453f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 30 Oct 2024 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730273531; x=1730878331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFItFkm7xxlGReyd+CKxgiNteBFqPMNGPEXfruG+1LA=;
        b=IhayTUMAlvbEMtMD5J6VWYX85w6JecKf1AjR2YLbMF9dZ0FI+lgYvExna+qwZAgjID
         ieyJTVXywXsfhi40XvU7t+2vdT1pQTcpIBSjOiWXBiw7xDoKLS6iKueUchpUvOtEclnc
         WAw26q+hk4RtocFSQqN3yPIh3LBUG3nZskdAEHDKRVHG5clOkR7SmskYpHrGuOnnvb9g
         s8JPJ1PWpp62aDOo5fDvLIckeBsucWs9oxYb4iojiSLIfhiC/uv/JavLj7y41A/NjKzK
         RxXjm378UeYlsWcTf74VFFkWJ2JFgNGa5XMbDUXdmCixdaoboDHzhRWGHzSqC4F9Wm3l
         TzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730273531; x=1730878331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFItFkm7xxlGReyd+CKxgiNteBFqPMNGPEXfruG+1LA=;
        b=k3rcXwbMhy+GOuyK/S4xcPfhNBG0zr3Frz6qQIeimEWGnJ2EK40XZLoz+3YEnEkdnD
         uTMUA8qY0mboyWnoPQQ6ZkzwY8ausizlpizKLJZAO/35kVlq9/27xdYyC2pyVB7Tdkch
         3wi2IYgiXO88D1FoyobbcmvPspP2FecLu4M/p2XtwwCHPNl6bpo8fzGNpeAldnHWIQyD
         Xbh4Ter8Xr/PPfs4nZugkauTDEQtpm9uxIGT3ALdt0FVuVce7bk2XzhWJcjwGR+ap/Fj
         1wlPO0/iJHp2ZVRBFuURZAkmUZQoPNU6i/giHlDPX8SIRjZ7SndSQ/1WOetyRUtGsSer
         nNhw==
X-Forwarded-Encrypted: i=1; AJvYcCX273+m+ds6mRxowKc3Md1hRQLrUjh6FeCDwaDURJTsUTETVe941RHNypgf9sHBgpImC/QnmnpdagA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rmRXcum4ogKkgYR9A7Gyl1Q7HebWocKWe6M0h6X+dSTMcwsj
	HZFaNjlIE+VQG3524q4XYY4TJdYWaJT9che5XvIgxBc+kCEJPlSF/XzvstX82MY=
X-Google-Smtp-Source: AGHT+IE6ED3eAQ5A9DCGC3XuLYb92IN+MGup7zF2u95nFYke47sqJfEa/gMWC7gX4SrjKhKfIq9wmA==
X-Received: by 2002:a5d:5e05:0:b0:37d:3f81:153f with SMTP id ffacd0b85a97d-3817d622612mr3826629f8f.17.1730273530893;
        Wed, 30 Oct 2024 00:32:10 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9294dsm14542597f8f.105.2024.10.30.00.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:32:10 -0700 (PDT)
Date: Wed, 30 Oct 2024 08:32:09 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v9 6/6] pwm: airoha: Add support for EN7581 SoC
Message-ID: <bf5lpb3dwfywzgnbcel6de57ick7hfzxfaovyqrt7juif6tgp7@sdmugrua6t3c>
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-6-afb0cbcab0ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zrrgadsxh7nw5d7s"
Content-Disposition: inline
In-Reply-To: <20241023-en7581-pinctrl-v9-6-afb0cbcab0ec@kernel.org>


--zrrgadsxh7nw5d7s
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 6/6] pwm: airoha: Add support for EN7581 SoC
MIME-Version: 1.0

Hello,

On Wed, Oct 23, 2024 at 01:20:06AM +0200, Lorenzo Bianconi wrote:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
>=20
> Introduce driver for PWM module available on EN7581 SoC.
>=20
> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pwm/Kconfig      |  11 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-airoha.c | 386 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 398 insertions(+)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 0915c1e7df16d451e987dcc5f10e0b57edc32ee1..99aa87136c272555c10102590=
fcf9f911161c3d3 100644
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
> index 9081e0c0e9e09713fe05479c257eebe5f02b91e9..fbf7723d845807fd1e2893c6e=
a4f736785841b0d 100644
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
> index 0000000000000000000000000000000000000000..658884852e7ad7a76ff499879=
eda9c50dfc5f745
> --- /dev/null
> +++ b/drivers/pwm/pwm-airoha.c
> @@ -0,0 +1,386 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 Markus Gothe <markus.gothe@genexis.eu>
> + *
> + *  Limitations:
> + *  - No disable bit, so a disabled PWM is simulated by setting duty_cyc=
le to 0
> + *  - Only 8 concurrent waveform generators are available for 8 combinat=
ions of
> + *    duty_cycle and period. Waveform generators are shared between 16 G=
PIO
> + *    pins and 17 SIPO GPIO pins.
> + *  - Supports only normal polarity.
> + *  - On configuration the currently running period is completed.

Maybe I already asked before: Is there a public manual? If so, please
add a link here.

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
> +#define SGPIO_LED_DATA_SHIFT_FLAG	BIT(31)
> +#define SGPIO_LED_DATA_DATA		GENMASK(16, 0)
> +
> +#define REG_SGPIO_CLK_DIVR		0x0028
> +#define REG_SGPIO_CLK_DIVR_MASK		GENMASK(1, 0)
> +#define REG_SGPIO_CLK_DLY		0x002c
> +
> +#define REG_SIPO_FLASH_MODE_CFG		0x0030
> +#define SERIAL_GPIO_FLASH_MODE		BIT(1)
> +#define SERIAL_GPIO_MODE_74HC164	BIT(0)
> +
> +#define REG_GPIO_FLASH_PRD_SET(_n)	(0x003c + ((_n) << 2))
> +#define GPIO_FLASH_PRD_MASK(_n)		GENMASK(15 + ((_n) << 4), ((_n) << 4))
> +
> +#define REG_GPIO_FLASH_MAP(_n)		(0x004c + ((_n) << 2))
> +#define GPIO_FLASH_SETID_MASK(_n)	GENMASK(2 + ((_n) << 2), ((_n) << 2))
> +#define GPIO_FLASH_EN(_n)		BIT(3 + ((_n) << 2))
> +
> +#define REG_SIPO_FLASH_MAP(_n)		(0x0054 + ((_n) << 2))
> +
> +#define REG_CYCLE_CFG_VALUE(_n)		(0x0098 + ((_n) << 2))
> +#define WAVE_GEN_CYCLE_MASK(_n)		GENMASK(7 + ((_n) << 3), ((_n) << 3))
> +
> +#define PWM_NUM_BUCKETS			8
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
> +	struct device_node *np;
> +	u64 initialized;
> +
> +	struct airoha_pwm_bucket bucket[PWM_NUM_BUCKETS];
> +};
> +
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
> +#define PWM_NUM_GPIO	16
> +#define PWM_NUM_SIPO	17
> +
> +/* The PWM hardware supports periods between 4 ms and 1 s */
> +#define PERIOD_MIN_NS	(4 * NSEC_PER_MSEC)
> +#define PERIOD_MAX_NS	(1 * NSEC_PER_SEC)
> +/* It is represented internally as 1/250 s between 1 and 250 */
> +#define PERIOD_MIN	1
> +#define PERIOD_MAX	250
> +/* Duty cycle is relative with 255 corresponding to 100% */
> +#define DUTY_FULL	255

Please add proper namespacing to these constants, some of these make a
more generic impression than justified. (i.e. add a common prefix like
"AIROHA_PWM_")

> +static int airoha_pwm_get_generator(struct airoha_pwm *pc, u64 duty_ns,
> +				    u64 period_ns)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pc->bucket); i++) {
> +		if (!pc->bucket[i].used)
> +			continue;
> +
> +		if (duty_ns =3D=3D pc->bucket[i].duty_ns &&
> +		    period_ns =3D=3D pc->bucket[i].period_ns)
> +			return i;
> +
> +		/*
> +		 * Unlike duty cycle zero, which can be handled by
> +		 * disabling PWM, a generator is needed for full duty
> +		 * cycle but it can be reused regardless of period
> +		 */
> +		if (duty_ns =3D=3D DUTY_FULL && pc->bucket[i].duty_ns =3D=3D DUTY_FULL)

I wonder: The PWM supports periods starting at 4ms, but 255 is the
maximal value for duty_ns? Isn't that a misnomer and is about
duty_ticks?

> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
> +static void airoha_pwm_release_bucket_config(struct airoha_pwm *pc,
> +					     unsigned int hwpwm)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(pc->bucket); i++)
> +		pc->bucket[i].used &=3D ~BIT_ULL(hwpwm);
> +}
> +
> +static int airoha_pwm_consume_generator(struct airoha_pwm *pc,
> +					u64 duty_ns, u64 period_ns,
> +					unsigned int hwpwm)
> +{
> +	int id =3D airoha_pwm_get_generator(pc, duty_ns, period_ns);
> +
> +	if (id < 0) {
> +		int i;
> +
> +		/* find an unused waveform generator */
> +		for (i =3D 0; i < ARRAY_SIZE(pc->bucket); i++) {
> +			if (!(pc->bucket[i].used & ~BIT_ULL(hwpwm))) {
> +				id =3D i;
> +				break;
> +			}
> +		}
> +	}

I think airoha_pwm_get_generator could return an unused generator, then
you don't need to loop twice over all buckets. Just an idea, not sure
this becomes considerably faster or easier to understand.

> +	if (id >=3D 0) {
> +		airoha_pwm_release_bucket_config(pc, hwpwm);
> +		pc->bucket[id].used |=3D BIT_ULL(hwpwm);
> +		pc->bucket[id].period_ns =3D period_ns;
> +		pc->bucket[id].duty_ns =3D duty_ns;
> +	}
> +
> +	return id;
> +}
> +
> +static int airoha_pwm_sipo_init(struct airoha_pwm *pc)
> +{
> +	u32 val;
> +
> +	if (!(pc->initialized >> PWM_NUM_GPIO))
> +		return 0;
> +
> +	regmap_clear_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
> +			  SERIAL_GPIO_MODE_74HC164);
> +
> +	/* Configure shift register timings, use 32x divisor */
> +	regmap_write(pc->regmap, REG_SGPIO_CLK_DIVR,
> +		     FIELD_PREP(REG_SGPIO_CLK_DIVR_MASK, 0x3));
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
> +				     !(val & SGPIO_LED_DATA_SHIFT_FLAG), 10,
> +				     200 * USEC_PER_MSEC))
> +		return -ETIMEDOUT;
> +
> +	regmap_clear_bits(pc->regmap, REG_SGPIO_LED_DATA, SGPIO_LED_DATA_DATA);
> +	if (regmap_read_poll_timeout(pc->regmap, REG_SGPIO_LED_DATA, val,
> +				     !(val & SGPIO_LED_DATA_SHIFT_FLAG), 10,
> +				     200 * USEC_PER_MSEC))
> +		return -ETIMEDOUT;
> +
> +	/* Set SIPO in PWM mode */
> +	regmap_set_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
> +			SERIAL_GPIO_FLASH_MODE);
> +
> +	return 0;
> +}
> +
> +static void airoha_pwm_calc_bucket_config(struct airoha_pwm *pc, int ind=
ex,
> +					  u64 duty_ns, u64 period_ns)
> +{
> +	u32 period, duty, mask, val;

Please use duty_ns for values in nanoseconds and duty_ticks (or
something similar) for values in clock ticks consistently.

> +	u64 tmp;
> +
> +	tmp =3D duty_ns * DUTY_FULL;

This might overflow. =3D> Use mul_u64_u64_div_u64() or a suitable cousin
of it.

> +	duty =3D clamp_val(div64_u64(tmp, period_ns), 0, DUTY_FULL);
> +	tmp =3D period_ns * 25;
> +	period =3D clamp_val(div64_u64(tmp, 100000000), PERIOD_MIN, PERIOD_MAX);

Huh, we already know that period_ns >=3D PERIOD_MIN_NS =3D 4000000, so
period is >=3D PERIOD_MIN =3D 1 already. So the lower bound part of that
clamping is not needed. (And it looks wrong because you're not supposed
to round up.) Ditto for the duty_clamp, tmp/period_ns will never be less
than 0.

> +	/* Configure frequency divisor */
> +	mask =3D WAVE_GEN_CYCLE_MASK(index % 4);
> +	val =3D (period << __ffs(mask)) & mask;

FIELD_PREP please.

> +	regmap_update_bits(pc->regmap, REG_CYCLE_CFG_VALUE(index / 4),
> +			   mask, val);
> +
> +	/* Configure duty cycle */
> +	duty =3D ((DUTY_FULL - duty) << 8) | duty;

Please use proper defines for the bit fields and then use FIELD_PREP
here instead of shifts with an explicit number as RHS.

> +	mask =3D GPIO_FLASH_PRD_MASK(index % 2);
> +	val =3D (duty << __ffs(mask)) & mask;
> +	regmap_update_bits(pc->regmap, REG_GPIO_FLASH_PRD_SET(index / 2),
> +			   mask, val);
> +}
> +
> +static void airoha_pwm_config_flash_map(struct airoha_pwm *pc,
> +					unsigned int hwpwm, int index)
> +{
> +	u32 addr, mask, val;
> +
> +	if (hwpwm < PWM_NUM_GPIO) {
> +		addr =3D REG_GPIO_FLASH_MAP(hwpwm / 8);
> +	} else {
> +		addr =3D REG_SIPO_FLASH_MAP(hwpwm / 8);
> +		hwpwm -=3D PWM_NUM_GPIO;
> +	}
> +
> +	if (index < 0) {
> +		/*
> +		 * Change of waveform takes effect immediately but
> +		 * disabling has some delay so to prevent glitching
> +		 * only the enable bit is touched when disabling

Together with "No disable bit, so a disabled PWM is simulated by setting
duty_cycle to 0" from the Limitations paragraph above I don't understand
that. And if disabling has some delay but reconfiguration doesn't, it
would give a more consistent behaviour to configure a duty_cycle =3D 0
here?

> +		 */
> +		regmap_clear_bits(pc->regmap, addr, GPIO_FLASH_EN(hwpwm % 8));
> +		return;
> +	}
> +
> +	mask =3D GPIO_FLASH_SETID_MASK(hwpwm % 8);
> +	val =3D ((index & 7) << __ffs(mask)) & mask;
> +	regmap_update_bits(pc->regmap, addr, mask, val);
> +	regmap_set_bits(pc->regmap, addr, GPIO_FLASH_EN(hwpwm % 8));
> +}
> +
> +static int airoha_pwm_config(struct airoha_pwm *pc, struct pwm_device *p=
wm,
> +			     u64 duty_ns, u64 period_ns)
> +{
> +	int index =3D -1;

This initialisation isn't needed.

> +	index =3D airoha_pwm_consume_generator(pc, duty_ns, period_ns,
> +					     pwm->hwpwm);
> +	if (index < 0)
> +		return -EBUSY;
> +
> +	if (!(pc->initialized & BIT_ULL(pwm->hwpwm)) &&
> +	    pwm->hwpwm >=3D PWM_NUM_GPIO)
> +		airoha_pwm_sipo_init(pc);
> +
> +	if (index >=3D 0) {

After the return above index >=3D 0 is always true.

> +		airoha_pwm_calc_bucket_config(pc, index, duty_ns, period_ns);
> +		airoha_pwm_config_flash_map(pc, pwm->hwpwm, index);
> +	} else {
> +		airoha_pwm_config_flash_map(pc, pwm->hwpwm, index);
> +		airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
> +	}
> +
> +	pc->initialized |=3D BIT_ULL(pwm->hwpwm);
> +
> +	return 0;
> +}
> +
> +static void airoha_pwm_disable(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct airoha_pwm *pc =3D pwmchip_get_drvdata(chip);
> +
> +	/* Disable PWM and release the waveform */

s/waveform/bucket/ ?

> +	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
> +	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
> +
> +	pc->initialized &=3D ~BIT_ULL(pwm->hwpwm);
> +	if (!(pc->initialized >> PWM_NUM_GPIO))
> +		regmap_clear_bits(pc->regmap, REG_SIPO_FLASH_MODE_CFG,
> +				  SERIAL_GPIO_FLASH_MODE);
> +}
> +
> +static int airoha_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct airoha_pwm *pc =3D pwmchip_get_drvdata(chip);
> +	u64 duty =3D state->enabled ? state->duty_cycle : 0;
> +	u64 period =3D state->period;
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
> +	if (period < PERIOD_MIN_NS)
> +		return -EINVAL;
> +
> +	if (period > PERIOD_MAX_NS)
> +		period =3D PERIOD_MAX_NS;

If you ask me, don't check the nanosecond values, but convert them to
ticks and check only then. That feels more natural.

> +	return airoha_pwm_config(pc, pwm, duty, period);
> +}
> +
> +static int airoha_pwm_get_state(struct pwm_chip *chip, struct pwm_device=
 *pwm,
> +				struct pwm_state *state)
> +{
> +	struct airoha_pwm *pc =3D pwmchip_get_drvdata(chip);
> +	int i;
> +
> +	/* find hwpwm in waveform generator bucket */
> +	for (i =3D 0; i < ARRAY_SIZE(pc->bucket); i++) {
> +		if (pc->bucket[i].used & BIT_ULL(pwm->hwpwm)) {
> +			state->enabled =3D pc->initialized & BIT_ULL(pwm->hwpwm);
> +			state->polarity =3D PWM_POLARITY_NORMAL;
> +			state->period =3D pc->bucket[i].period_ns;
> +			state->duty_cycle =3D pc->bucket[i].duty_ns;
> +			break;
> +		}
> +	}

Is it worth to maintain the information about index of the used bucket
for a given pwm_device in airoha_pwm to save a few loops?

> +	if (i =3D=3D ARRAY_SIZE(pc->bucket))
> +		state->enabled =3D false;
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops airoha_pwm_ops =3D {
> +	.get_state =3D airoha_pwm_get_state,
> +	.apply =3D airoha_pwm_apply,

I'm a big fan of consistency, so you can make me a bit more happy if you
define airoha_pwm_get_state() before airoha_pwm_apply() or switch the
order here. (The latter is slightly preferred as this matches the order
of their definition in struct pwm_ops.)

> +};
> +
> +static int airoha_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct airoha_pwm *pc;
> +	struct pwm_chip *chip;
> +
> +	chip =3D devm_pwmchip_alloc(dev, PWM_NUM_GPIO + PWM_NUM_SIPO,
> +				  sizeof(*pc));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	chip->ops =3D &airoha_pwm_ops;
> +	pc =3D pwmchip_get_drvdata(chip);
> +	pc->np =3D dev->of_node;

=2Enp is a write only struct member and so can be dropped.

> +
> +	pc->regmap =3D device_node_to_regmap(dev->parent->of_node);
> +	if (IS_ERR(pc->regmap))
> +		return PTR_ERR(pc->regmap);
> +
> +	return devm_pwmchip_add(&pdev->dev, chip);

Please add error messages to .probe() using dev_err_probe().

> +}

Best regards
Uwe

--zrrgadsxh7nw5d7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmch4PYACgkQj4D7WH0S
/k7LbAf9Fo37Np82ysJ0fxX1NWb/5j2EmlCbY9Z3gbto0DZ7lEu0U8zlhXFtSjV9
Y3da4yz/a0Sz0lTUE3CIsjs4O/ipnIII7cILDB7phRlZhjNt+YxOeRUdX3A6yZdG
RN01b19OdC214Sa2zk+or4Kvfutw+bz+ZaOVKZJ+D7l+y0TWGsKCmg4a9zspo6kh
wfucvuCo8ZBpeWVlJDy6FDSqqylmASlWu1t54LIpUdQowI2M8NwmUvpR6N5azlsO
wycrSRPbptc1MYx3jTGjPxkJTHqZc1zOJFxucvHiU8zLl+v0qMmOkf6bhgPh0AKT
SBfBCwKSLbGcD3L8IlVlOTwFCoKfBw==
=hKzh
-----END PGP SIGNATURE-----

--zrrgadsxh7nw5d7s--

