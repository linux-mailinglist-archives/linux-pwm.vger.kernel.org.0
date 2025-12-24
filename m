Return-Path: <linux-pwm+bounces-7827-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6D7CDBDD4
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Dec 2025 10:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17304300DA5E
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Dec 2025 09:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F4A29B204;
	Wed, 24 Dec 2025 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B+M6zCt4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E82D6E40
	for <linux-pwm@vger.kernel.org>; Wed, 24 Dec 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766570104; cv=none; b=ifzBl5ZrjlAKgDA8LpPgJYByyYmvpuFbtCGVywHuZz5TbDdVjCgwTemW4hL2xnGmgZw5a0CkJKH7tlijWqT4LVq3cE7dMw9+3ULSc+AKygBLDE4+goliH7VghEGDbn+9A9ZAIh3Ue0pMpmTO7aNbHk4NCUJIgAGvOsBVM74fReU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766570104; c=relaxed/simple;
	bh=GOZXnibYE+8ge4MEeYA4l1wy8jQyvzRqYHh9le2DerM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmCDgPD5fxmLypNgoIwYkwNDCZsAWazz69mtR9BVYyfWHIvXCTeGhu8LOC7mcQzQA/p64J73B6NjWMijdwAEicDxJ9JjfF+poC4Xwv7qBRTq9H/Jf3InYe4S6WojA4W3CVhEd57DNfveZXo0ZnIpqSC/nmJ0BhoZNxOLcu7+OQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B+M6zCt4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so30007005e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 24 Dec 2025 01:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766570098; x=1767174898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CbcHPJhxZ1ygS43fP7Igmyk+vKbbtbKqiV1YPsz8QA=;
        b=B+M6zCt46nczcQC2st56rDyoG+08ALa0iwAYLNzyrp0DTXf12pabDrGOgyB8U3L4HJ
         qG3vE+pBJ83bbf9rR9A44dGTBV4ST9EFb+ugXAmWRTFpExSn4Ei7dKvTQGA0x8fwr/rj
         f6fxvEKNKrldeDbJdj7JSDDIXWuyqdPkzquuPt8w3EW8aHDR2+CZPYGNNQrcNvCEszK/
         WtoavgIEH/Y/Pvv4mcjFHvDnUl6tUd2P1eewlZ32Z5ZNgcKluX2FlHNMMQO4J5dles4B
         wQ1IlL52omB585REqDGuY/NHWT8fKtPsof74lwHklqs0RbGJUNZIuW/jubXJPy3lIlKd
         AIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766570098; x=1767174898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CbcHPJhxZ1ygS43fP7Igmyk+vKbbtbKqiV1YPsz8QA=;
        b=O+TzIQ34s05FJOQm5CBdxZXh1Y7BhYZ9eP2AAYVCpnuFsVH/SqIFIVbR1RA564MNHu
         eZSASNOONKhBRcwMn0+RVouI2rISMIqczTQ8o/LZGpTrVTlS/HhjcysUz+hhuwoZ6KrU
         //8qDj77jUZx+OdJbYa4JRaKq9RVzY3WXJGFhi8DH1d4ibOKkSiD8kxPOlWiZ/17/BBv
         MTH4dQRwVNm6Y2SBdGO5N9JtY9DkL13fRYOk71pDd2MT5VzLCPrnJyjNvVtRpikTyG25
         R5AGa0ExdvAGR5Ivle0acmytOV9Q5WOi6GAL+pmIKAJJMZErlUKj4e02bUT6M+GwxFzW
         LfVg==
X-Forwarded-Encrypted: i=1; AJvYcCW3F6U0Q+2wOu10VBPgpksyPJhxc7kd4XZW4aesq4M8rG3Or1TL6QIyLEtyuKPMTorg2YqG6U7Psxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynWvWQzCCOcuVR0f/KIAPqEZh7Py0mDr/tvlM52ngVnDoyf2CY
	I2KhfVPhWDgfQZvyMowpt2KOvMYyorwc/Q1QChzg8oyQdx35NuL01IV9n7yXQY3tkLo=
X-Gm-Gg: AY/fxX5+Mae2xLKWMavWJbSJWTwDo8bARNpNKoVxwDY3oPumHQrYLWerK+0MUakbJTI
	P64lcVGLDZ2GRfPlhd4/2duZzbBEndm7oz2rttU8Mrh8BnwGJ15F6FRm8S4gPFSc0BOfAjPRDYe
	4yXxwu1bWrsVI+k7OHGLRnkU8AAy+bMvkU9ii/b+khmtjHYbqfRJY/zjAtkIydtfPXstQfuHEY7
	8qljgDpHT9BoDngYHuJjMVQmiq4cSjX+FBk+7TuitO03ruhpUC1Xs0hvkSciivx/cGUqJzExfxS
	ghhQdFoq4EssuTywmuROKUzOgVF5mM0MblVZCaA44J1qDXiyOW1W3l/PrVitynkqQ7UMZCXsvvy
	Nx6iDh05Oq9UohqoVxgc5W19j+fQg+1MloSRwg1SroSl/k82nyb2l8k+CC6MFbF4bsQD8hu4RI0
	16uZIpAukv97grJJmnrQ/WheTCLAVQECPAaMabQcvM20DG0g1v08JHYqbl+Ig=
X-Google-Smtp-Source: AGHT+IFMl+nXU4bHpG9SowrS/2wez4DHqwNti3IxwwkrDshie+68S5SqcsH9UqdWy/4NRXY8T5sjoA==
X-Received: by 2002:a05:600c:818f:b0:477:7b16:5f77 with SMTP id 5b1f17b1804b1-47d19538725mr171367295e9.3.1766570097743;
        Wed, 24 Dec 2025 01:54:57 -0800 (PST)
Received: from localhost (ip-185-104-138-126.ptr.icomera.net. [185.104.138.126])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47d1936d220sm307668185e9.8.2025.12.24.01.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 01:54:57 -0800 (PST)
Date: Wed, 24 Dec 2025 10:54:54 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Joao Schim <joao@schimsalabim.eu>
Subject: Re: [PATCH v2 2/4] pwm: sun50i: Add H616 PWM support
Message-ID: <en7wscywn3xpw7cxvc2ngwrmjfciglzxgaje5qc5ngiehrjufh@jbvgp2neyzzx>
References: <20251217082504.80226-1-richard.genoud@bootlin.com>
 <20251217082504.80226-3-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7vwgv3lf455gi2pg"
Content-Disposition: inline
In-Reply-To: <20251217082504.80226-3-richard.genoud@bootlin.com>


--7vwgv3lf455gi2pg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/4] pwm: sun50i: Add H616 PWM support
MIME-Version: 1.0

Hello,

this patch isn't checkpatch clean.

On Wed, Dec 17, 2025 at 09:25:02AM +0100, Richard Genoud wrote:
> Add driver for Allwinner H616 PWM controller, supporting up to 6
> channels.
> Those channels output can be either a PWM signal output or a clock
> output, thanks to the bypass.
>=20
> The channels are paired (0/1, 2/3 and 4/5) and each pair has a
> prescaler/mux/gate.
> Moreover, each channel has its own prescaler and bypass.
>=20
> Tested-by: Joao Schim <joao@schimsalabim.eu>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/pwm/Kconfig           |  12 +
>  drivers/pwm/Makefile          |   1 +
>  drivers/pwm/pwm-sun50i-h616.c | 892 ++++++++++++++++++++++++++++++++++
>  3 files changed, 905 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun50i-h616.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6f3147518376..66534e033761 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -736,6 +736,18 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN50I_H616
> +	tristate "Allwinner H616 PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on HAS_IOMEM && COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner H616 SoCs.
> +	  It supports generic PWM, but can also provides a plain clock.
> +	  The AC300 PHY integrated in H616 SoC needs such a clock.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-h616.
> +
>  config PWM_SUNPLUS
>  	tristate "Sunplus PWM support"
>  	depends on ARCH_SUNPLUS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0dc0d2b69025..a16ae9eef9e5 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN50I_H616)	+=3D pwm-sun50i-h616.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TH1520)	+=3D pwm_th1520.o
> diff --git a/drivers/pwm/pwm-sun50i-h616.c b/drivers/pwm/pwm-sun50i-h616.c
> new file mode 100644
> index 000000000000..b002ea5935e4
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun50i-h616.c
> @@ -0,0 +1,892 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Allwinner H616 Pulse Width Modulation Controller
> + *
> + * (C) Copyright 2025 Richard Genoud, Bootlin <richard.genoud@bootlin.co=
m>
> + *
> + * Based on drivers/pwm/pwm-sun4i.c with Copyright:
> + *
> + * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@bootlin.com>
> + *
> + * Limitations:
> + * - When outputing the source clock directly, the PWM logic is bypassed=
 and the
> + *   currently running period is not guaranteed to be completed.
> + * - As the channels are paired (0/1, 2/3, 4/5), they share the same clo=
ck
> + *   source and prescaler(div_m), but they also have their own prescaler=
(div_k)
> + *   and bypass.
> + *
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/spinlock.h>
> +#include <linux/time.h>
> +
> +#ifndef UINT32_MAX
> +#define UINT32_MAX 0xffffffffU
> +#endif

Please include <linux/limits.h> and use U32_MAX.

> +
> +/* PWM IRQ Enable Register */
> +#define PWM_IER				0x0

Use a driver specific prefix for your defines. Otherwise these constants
look more generic than they are.

> +/* PWM IRQ Status Register */
> +#define PWM_ISR				0x4
> +
> +/* PWM Capture IRQ Enable Register */
> +#define PWM_CIER			0x10
> +
> +/* PWM Capture IRQ Status Register */
> +#define PWM_CISR			0x14
> +
> +/* PWMCC Pairs Clock Configuration Registers */
> +#define PWM_XY_CLK_CR(pair)		(0x20 + ((pair) * 0x4))
> +#define PWM_XY_CLK_CR_SRC_SHIFT		7
> +#define PWM_XY_CLK_CR_SRC_MASK		1

Please do:

	#define H616_PWM_XY_CLK_CR_SRC		BIT(7)

and then use the helper functions from bitfield.h=20

> +#define PWM_XY_CLK_CR_GATE_BIT		4
> +#define PWM_XY_CLK_CR_BYPASS_BIT(chan)	((chan) % 2 + 5)
> +#define PWM_XY_CLK_CR_DIV_M_SHIFT	0
> +
> +/* PWMCC Pairs Dead Zone Control Registers */
> +#define PWM_XY_DZ(pair)			(0x30 + ((pair) * 0x4))
> +
> +/* PWM Enable Register */
> +#define PWM_ENR				0x40
> +#define PWM_ENABLE(x)			BIT(x)

Please use the full register name as prefix for bitfields.

> +/* PWM Capture Enable Register */
> +#define PWM_CER				0x44
> +
> +/* PWM Control Register */
> +#define PWM_CTRL_REG(chan)		(0x60 + (chan) * 0x20)
> +#define PWM_CTRL_PRESCAL_K_SHIFT	0
> +#define PWM_CTRL_PRESCAL_K_WIDTH	8
> +#define PWM_CTRL_ACTIVE_STATE		BIT(8)
> +
> +/* PWM Period Register */
> +#define PWM_PERIOD_REG(ch)		(0x64 + (ch) * 0x20)
> +#define PWM_PERIOD_MASK			GENMASK(31, 16)
> +#define PWM_DUTY_MASK			GENMASK(15, 0)
> +#define PWM_REG_PERIOD(reg)		(FIELD_GET(PWM_PERIOD_MASK, reg) + 1)
> +#define PWM_REG_DUTY(reg)		FIELD_GET(PWM_DUTY_MASK, reg)
> +#define PWM_PERIOD(prd)			FIELD_PREP(PWM_PERIOD_MASK, (prd) - 1)
> +#define PWM_DUTY(dty)			FIELD_PREP(PWM_DUTY_MASK, dty)
> +#define PWM_PERIOD_MAX			FIELD_MAX(PWM_PERIOD_MASK)
> +
> +
> +/* PWM Count Register */
> +#define PWM_CNT_REG(x)			(0x68 + (x) * 0x20)
> +
> +/* PWM Capture Control Register */
> +#define PWM_CCR(x)			(0x6c + (x) * 0x20)
> +
> +/* PWM Capture Rise Lock Register */
> +#define PWM_CRLR(x)			(0x70 + (x) * 0x20)
> +
> +/* PWM Capture Fall Lock Register */
> +#define PWM_CFLR(x)			(0x74 + (x) * 0x20)
> +
> +#define PWM_PAIR_IDX(chan)		((chan) >> 2)
> +
> +/*
> + * Block diagram of the PWM clock controller:
> + *
> + *             _____      ______      ________
> + * OSC24M --->|     |    |      |    |        |
> + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
> + *            |_____|    |______|    |________|
> + *                           ________
> + *                          |        |
> + *                       +->| /div_k |---> PWM_clock_x
> + *                       |  |________|
> + *                       |    ______
> + *                       |   |      |
> + *                       +-->| Gate |----> PWM_bypass_clock_x
> + *                       |   |______|
> + * PWM_clock_src_xy -----+   ________
> + *                       |  |        |
> + *                       +->| /div_k |---> PWM_clock_y
> + *                       |  |________|
> + *                       |    ______
> + *                       |   |      |
> + *                       +-->| Gate |----> PWM_bypass_clock_y
> + *                           |______|
> + *
> + * NB: when the bypass is set, all the PWM logic is bypassed.
> + * So, the duty cycle and polarity can't be modified (we just have a clo=
ck).
> + * The bypass in PWM mode is used to achieve a 1/2 duty cycle with the f=
astest
> + * clock.

1/2 *relative* duty cycle.

> + *
> + * PWM_clock_x/y serve for the PWM purpose.
> + * PWM_bypass_clock_x/y serve for the clock-provider purpose.
> + *
> + */
> +
> +/*
> + * Table used for /div_m (diviser before obtaining PWM_clock_src_xy)
> + * It's actually CLK_DIVIDER_POWER_OF_TWO, but limited to /256
> + */
> +static const struct clk_div_table clk_table_div_m[] =3D {
> +	{ .val =3D 0, .div =3D 1, },
> +	{ .val =3D 1, .div =3D 2, },
> +	{ .val =3D 2, .div =3D 4, },
> +	{ .val =3D 3, .div =3D 8, },
> +	{ .val =3D 4, .div =3D 16, },
> +	{ .val =3D 5, .div =3D 32, },
> +	{ .val =3D 6, .div =3D 64, },
> +	{ .val =3D 7, .div =3D 128, },
> +	{ .val =3D 8, .div =3D 256, },
> +	{ .val =3D 0, .div =3D 0, }, /* last entry */
> +};

=2Ediv is just 1 << .val, so I would expect you can better use math
expressions instead of this table.

> +#define PWM_XY_SRC_GATE(_pair, _reg)			\
> +struct clk_gate gate_xy_##_pair =3D {			\
> +	.reg =3D (void *)_reg,				\
> +	.bit_idx =3D PWM_XY_CLK_CR_GATE_BIT,		\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D  &clk_gate_ops,			\
> +	}						\

I would consider

	.hw.init.ops =3D ...;

and

	.hw =3D {
		.init =3D {
			.ops =3D ...;
		},
	},

natural here. The middleway you chose looks strange to me.
Also s/  / /.

> +}
> +
> +#define PWM_XY_SRC_MUX(_pair, _reg)			\
> +struct clk_mux mux_xy_##_pair =3D {			\
> +	.reg =3D (void *)_reg,				\
> +	.shift =3D PWM_XY_CLK_CR_SRC_SHIFT,		\
> +	.mask =3D PWM_XY_CLK_CR_SRC_MASK,			\

Huh, why does this structure has both a shift and a mask value? What is
the difference between

	.shift =3D 7,
	.mask =3D 1,

and

	.shift =3D 0,
	.mask =3D 1 << 7,

? If the latter is equivalent, you could just pass
H616_PWM_XY_CLK_CR_SRC and get rid of the extra definitions for _SHIFT
and _MASK.

> +	.flags =3D CLK_MUX_ROUND_CLOSEST,			\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D  &clk_mux_ops,			\
> +	}						\
> +}
> +
> +#define PWM_XY_SRC_DIV(_pair, _reg)			\
> +struct clk_divider rate_xy_##_pair =3D {			\
> +	.reg =3D (void *)_reg,				\
> +	.shift =3D PWM_XY_CLK_CR_DIV_M_SHIFT,		\
> +	.table =3D clk_table_div_m,			\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D  &clk_divider_ops,		\
> +	}						\
> +}
> +
> +#define PWM_X_DIV(_idx, _reg)				\
> +struct clk_divider rate_x_##_idx =3D {			\
> +	.reg =3D (void *)_reg,				\
> +	.shift =3D PWM_CTRL_PRESCAL_K_SHIFT,		\
> +	.width =3D PWM_CTRL_PRESCAL_K_WIDTH,		\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D  &clk_divider_ops,		\
> +	}						\
> +}
> +
> +#define PWM_X_BYPASS_GATE(_idx)				\
> +struct clk_gate gate_x_bypass_##_idx =3D {		\
> +	.reg =3D (void *)PWM_ENR,				\
> +	.bit_idx =3D _idx,				\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D  &clk_gate_ops,			\
> +	}						\
> +}
> +
> +#define PWM_XY_CLK_SRC(_pair, _reg)			\
> +	static PWM_XY_SRC_MUX(_pair, _reg);		\
> +	static PWM_XY_SRC_GATE(_pair, _reg);		\
> +	static PWM_XY_SRC_DIV(_pair, _reg)
> +
> +#define PWM_X_CLK(_idx)					\
> +	static PWM_X_DIV(_idx, PWM_CTRL_REG(_idx))
> +
> +#define PWM_X_BYPASS_CLK(_idx)						\
> +	PWM_X_BYPASS_GATE(_idx)
> +
> +#define REF_CLK_XY_SRC(_pair)						\
> +	{								\
> +		.name =3D "pwm-clk-src" #_pair,				\
> +		.mux_hw =3D &mux_xy_##_pair.hw,				\
> +		.gate_hw =3D &gate_xy_##_pair.hw,				\
> +		.rate_hw =3D &rate_xy_##_pair.hw,				\
> +	}
> +
> +#define REF_CLK_X(_idx, _pair)						\
> +	{								\
> +		.name =3D "pwm-clk" #_idx,				\
> +		.parent_names =3D (const char *[]){ "pwm-clk-src" #_pair }, \
> +		.num_parents =3D 1,					\
> +		.rate_hw =3D &rate_x_##_idx.hw,				\
> +		.flags =3D CLK_SET_RATE_PARENT,				\
> +	}
> +
> +#define REF_CLK_BYPASS(_idx, _pair)					\
> +	{								\
> +		.name =3D "pwm-clk-bypass" #_idx,				\
> +		.parent_names =3D (const char *[]){ "pwm-clk-src" #_pair }, \
> +		.num_parents =3D 1,					\
> +		.gate_hw =3D &gate_x_bypass_##_idx.hw,			\
> +		.flags =3D CLK_SET_RATE_PARENT,	\
> +	}
> +
> +/*
> + * PWM_clock_src_xy generation:
> + *             _____      ______      ________
> + * OSC24M --->|     |    |      |    |        |
> + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> PWM_clock_src_xy
> + *            |_____|    |______|    |________|
> + */
> +PWM_XY_CLK_SRC(01, PWM_XY_CLK_CR(0));
> +PWM_XY_CLK_SRC(23, PWM_XY_CLK_CR(1));
> +PWM_XY_CLK_SRC(45, PWM_XY_CLK_CR(2));
> +
> +/*
> + * PWM_clock_x_div generation:
> + *                       ________
> + *                      |        | PWM_clock_x/y
> + * PWM_clock_src_xy --->| /div_k |--------------->
> + *                      |________|
> + */
> +PWM_X_CLK(0);
> +PWM_X_CLK(1);
> +PWM_X_CLK(2);
> +PWM_X_CLK(3);
> +PWM_X_CLK(4);
> +PWM_X_CLK(5);
> +
> +/*
> + * PWM_bypass_clock_xy generation:
> + *                        ______
> + *                       |      |
> + * PWM_clock_src_xy ---->| Gate |-------> PWM_bypass_clock_x
> + *                       |______|
> + *
> + * The gate is actually PWM_ENR register.
> + */
> +PWM_X_BYPASS_CLK(0);
> +PWM_X_BYPASS_CLK(1);
> +PWM_X_BYPASS_CLK(2);
> +PWM_X_BYPASS_CLK(3);
> +PWM_X_BYPASS_CLK(4);
> +PWM_X_BYPASS_CLK(5);
> +
> +struct clk_pwm_data {
> +	const char *name;
> +	const char **parent_names;
> +	unsigned int num_parents;
> +	struct clk_hw *mux_hw;
> +	struct clk_hw *rate_hw;
> +	struct clk_hw *gate_hw;
> +	unsigned long flags;
> +};
> +
> +#define CLK_BYPASS(h616chip, ch) ((h616chip)->data->npwm + (ch))
> +#define CLK_XY_SRC_IDX(h616chip, ch) ((h616chip)->data->npwm * 2 + ((ch)=
 >> 1))
> +static struct clk_pwm_data pwmcc_data[] =3D {
> +	REF_CLK_X(0, 01),
> +	REF_CLK_X(1, 01),
> +	REF_CLK_X(2, 23),
> +	REF_CLK_X(3, 23),
> +	REF_CLK_X(4, 45),
> +	REF_CLK_X(5, 45),
> +	REF_CLK_BYPASS(0, 01),
> +	REF_CLK_BYPASS(1, 01),
> +	REF_CLK_BYPASS(2, 23),
> +	REF_CLK_BYPASS(3, 23),
> +	REF_CLK_BYPASS(4, 45),
> +	REF_CLK_BYPASS(5, 45),
> +	REF_CLK_XY_SRC(01),
> +	REF_CLK_XY_SRC(23),
> +	REF_CLK_XY_SRC(45),
> +	{ /* sentinel */ },
> +};
> +
> +enum h616_pwm_mode {
> +	H616_PWM_MODE_NONE,
> +	H616_PWM_MODE_PWM,
> +	H616_PWM_MODE_CLK,
> +};
> +
> +struct h616_pwm_data {
> +	unsigned int npwm;
> +};
> +
> +struct h616_pwm_channel {
> +	struct clk *pwm_clk;
> +	unsigned long rate;
> +	unsigned int entire_cycles;
> +	unsigned int active_cycles;
> +	enum h616_pwm_mode mode;
> +	bool bypass;
> +};
> +
> +struct clk_pwm_pdata {
> +	struct clk_hw_onecell_data *hw_data;
> +	spinlock_t lock;
> +	void __iomem *reg;
> +};
> +
> +struct h616_pwm_chip {
> +	struct clk_pwm_pdata *clk_pdata;
> +	struct h616_pwm_channel *channels;
> +	struct clk *bus_clk;
> +	struct reset_control *rst;
> +	void __iomem *base;
> +	const struct h616_pwm_data *data;
> +};
> +
> +static inline struct h616_pwm_chip *to_h616_pwm_chip(struct pwm_chip *ch=
ip)

It probably doesn't help much, but conceptually this could be

	static inline struct h616_pwm_chip *to_h616_pwm_chip(const struct pwm_chip=
 *chip)

> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static inline u32 h616_pwm_readl(struct h616_pwm_chip *h616chip,
> +				 unsigned long offset)
> +{
> +	return readl(h616chip->base + offset);
> +}
> +
> +static inline void h616_pwm_writel(struct h616_pwm_chip *h616chip,
> +				   u32 val, unsigned long offset)
> +{
> +	writel(val, h616chip->base + offset);
> +}
> +
> +static void h616_pwm_set_bypass(struct h616_pwm_chip *h616chip, unsigned=
 int idx,
> +				bool en_bypass)
> +{
> +	unsigned long flags;
> +	u32 val;
> +
> +	spin_lock_irqsave(&h616chip->clk_pdata->lock, flags);
> +
> +	val =3D h616_pwm_readl(h616chip, PWM_XY_CLK_CR(PWM_PAIR_IDX(idx)));
> +	if (en_bypass)
> +		val |=3D BIT(PWM_XY_CLK_CR_BYPASS_BIT(idx));
> +	else
> +		val &=3D ~BIT(PWM_XY_CLK_CR_BYPASS_BIT(idx));
> +
> +	h616_pwm_writel(h616chip, val, PWM_XY_CLK_CR(PWM_PAIR_IDX(idx)));
> +
> +	spin_unlock_irqrestore(&h616chip->clk_pdata->lock, flags);
> +}
> +
> +static int h616_pwm_request(struct pwm_chip *chip, struct pwm_device *pw=
m)
> +{
> +	struct h616_pwm_chip *h616chip =3D to_h616_pwm_chip(chip);
> +	struct h616_pwm_channel *chan =3D &h616chip->channels[pwm->hwpwm];
> +	struct device *dev =3D pwmchip_parent(chip);
> +	unsigned long flags;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&h616chip->clk_pdata->lock, flags);
> +
> +	if (chan->mode =3D=3D H616_PWM_MODE_CLK)
> +		ret =3D -EBUSY;
> +	else
> +		chan->mode =3D H616_PWM_MODE_PWM;
> +
> +	spin_unlock_irqrestore(&h616chip->clk_pdata->lock, flags);
> +	if (ret)
> +		goto out;

You could simplify that to:

	scoped_guard(spinlock_irqsave, &h616chip->clk_pdata->lock) {
		if (chan->mode =3D=3D H616_PWM_MODE_CLK)
			return -EBUSY;
		else
			chan->mode =3D H616_PWM_MODE_PWM;
	}

> +
> +	ret =3D clk_prepare_enable(chan->pwm_clk);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable clock %s: %d\n",
> +			__clk_get_name(chan->pwm_clk), ret);
> +	}

Please no error messages in the runtime callbacks.

> +out:
> +	return ret;
> +}
> +
> +static void h616_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct h616_pwm_chip *h616chip =3D to_h616_pwm_chip(chip);
> +	struct h616_pwm_channel *chan =3D &h616chip->channels[pwm->hwpwm];
> +
> +	clk_disable_unprepare(chan->pwm_clk);
> +	chan->mode =3D H616_PWM_MODE_NONE;
> +}
> +
> +static int h616_pwm_get_state(struct pwm_chip *chip,
> +			      struct pwm_device *pwm,
> +			      struct pwm_state *state)
> +{
> +	struct h616_pwm_chip *h616chip =3D to_h616_pwm_chip(chip);
> +	struct h616_pwm_channel *chan =3D &h616chip->channels[pwm->hwpwm];
> +	u64 clk_rate, tmp;
> +	u32 val;
> +
> +	clk_rate =3D clk_get_rate(chan->pwm_clk);
> +	if (!clk_rate)
> +		return -EINVAL;
> +
> +	val =3D h616_pwm_readl(h616chip, PWM_ENR);
> +	state->enabled =3D !!(PWM_ENABLE(pwm->hwpwm) & val);
> +
> +	val =3D h616_pwm_readl(h616chip, PWM_XY_CLK_CR(PWM_PAIR_IDX(pwm->hwpwm)=
));
> +	if (val & BIT(PWM_XY_CLK_CR_BYPASS_BIT(pwm->hwpwm))) {
> +		/*
> +		 * When bypass is enabled, the PWM logic is inactive.
> +		 * The PWM_clock_src_xy is directly routed to PWM_clock_x
> +		 */
> +		state->period =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate);
> +		state->duty_cycle =3D DIV_ROUND_UP_ULL(state->period, 2);
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +		return 0;
> +	}
> +
> +	state->enabled &=3D !!(BIT(PWM_XY_CLK_CR_GATE_BIT) & val);
> +
> +	val =3D h616_pwm_readl(h616chip, PWM_CTRL_REG(pwm->hwpwm));
> +	if (val & PWM_CTRL_ACTIVE_STATE)
> +		state->polarity =3D PWM_POLARITY_NORMAL;
> +	else
> +		state->polarity =3D PWM_POLARITY_INVERSED;
> +
> +	val =3D h616_pwm_readl(h616chip, PWM_PERIOD_REG(pwm->hwpwm));
> +
> +	tmp =3D NSEC_PER_SEC * PWM_REG_DUTY(val);
> +	state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
> +
> +	tmp =3D NSEC_PER_SEC * PWM_REG_PERIOD(val);
> +	state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);

This needs to use uprounding. Ideally enabling CONFIG_PWM_DEBUG and
extensive testing should catch that error.

> +
> +	return 0;
> +}
> +
> +static int h616_pwm_calc(struct pwm_chip *chip, unsigned int idx,
> +			 const struct pwm_state *state)
> +{
> +	struct h616_pwm_chip *h616chip =3D to_h616_pwm_chip(chip);
> +	struct h616_pwm_channel *chan =3D &h616chip->channels[idx];
> +	unsigned int cnt, duty_cnt;
> +	unsigned long max_rate;
> +	long calc_rate;
> +	u64 duty, period, freq;
> +
> +	duty =3D state->duty_cycle;
> +	period =3D state->period;
> +
> +	max_rate =3D clk_round_rate(chan->pwm_clk, UINT32_MAX);

Huh, is this an artificial limitation? Do you rely on how clk_round_rate
picks the return value? (I.e. nearest value? nearest time? round up?
round down?)

> +	dev_dbg(pwmchip_parent(chip), "max_rate: %ld Hz\n", max_rate);
> +
> +	if ((period * max_rate >=3D NSEC_PER_SEC) &&

If period is big, this overflows.

> +	    (period * max_rate < 2 * NSEC_PER_SEC) &&
> +	    (duty * max_rate * 2 >=3D NSEC_PER_SEC)) {
> +		/*
> +		 * If the requested period is to small to be generated by the
> +		 * PWM, we can just select the highest clock and bypass the
> +		 * PWM logic
> +		 */
> +		dev_dbg(pwmchip_parent(chip), "Setting bypass (period=3D%lld)\n",
> +			period);
> +		freq =3D div64_u64(NSEC_PER_SEC, period);
> +		chan->bypass =3D true;
> +		duty =3D period / 2;

You must not round up duty. So if a small period and duty_cycle <
period/2 is requested, you have to return an error value. (Note that
with waveforms the semantic is a bit different.)

> +	} else {
> +		chan->bypass =3D false;
> +		freq =3D div64_u64(NSEC_PER_SEC * (u64)PWM_PERIOD_MAX, period);
> +		if (freq > UINT32_MAX)
> +			freq =3D UINT32_MAX;
> +	}
> +
> +	calc_rate =3D clk_round_rate(chan->pwm_clk, freq);
> +	if (calc_rate <=3D 0) {
> +		dev_err(pwmchip_parent(chip),
> +			"Invalid source clock frequency %llu\n", freq);
> +		return calc_rate ? calc_rate : -EINVAL;
> +	}
> +
> +	dev_dbg(pwmchip_parent(chip), "calc_rate: %ld Hz\n", calc_rate);
> +
> +	cnt =3D mul_u64_u64_div_u64(calc_rate, period, NSEC_PER_SEC);

Please use a better name here, something like period_ticks would be
good.

> +	if ((cnt =3D=3D 0) || (cnt > PWM_PERIOD_MAX)) {
> +		dev_err(pwmchip_parent(chip), "Period out of range\n");
> +		return -EINVAL;
> +	}

If the requested value is too big, clamp it to the maximal possible
value.

> +	duty_cnt =3D mul_u64_u64_div_u64(calc_rate, duty, NSEC_PER_SEC);
> +
> +	if (duty_cnt >=3D cnt)
> +		duty_cnt =3D cnt - 1;

Does that mean the PWM cannot produce a 100% relative duty cycle?

> +	dev_dbg(pwmchip_parent(chip), "period=3D%llu cnt=3D%u duty=3D%llu duty_=
cnt=3D%u\n",
> +		period, cnt, duty, duty_cnt);

This is little helpful without the input parameters.

> +	chan->active_cycles =3D duty_cnt;
> +	chan->entire_cycles =3D cnt;
> +
> +	chan->rate =3D calc_rate;
> +
> +	return 0;
> +}
> +
> +static int h616_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{

Please consider implementing .round_waveform_tohw(),
=2Eround_waveform_fromhw(), .read_waveform() and .write_waveform() instead
of .apply() and .get_state().

> +	struct h616_pwm_chip *h616chip =3D to_h616_pwm_chip(chip);
> +	struct h616_pwm_channel *chan =3D &h616chip->channels[pwm->hwpwm];
> +	struct pwm_state cstate;
> +	unsigned long flags;
> +	u32 val;
> +	int ret;
> +
> +	ret =3D h616_pwm_calc(chip, pwm->hwpwm, state);
> +	if (ret) {
> +		dev_err(pwmchip_parent(chip), "period exceeds the maximum value\n");
> +		return ret;
> +	}
> +
> +	pwm_get_state(pwm, &cstate);

Don't call PWM API functions. (h616_pwm_apply() is called by
pwm_apply_{might_sleep,atomic} which grabs the chip lock. That
pwm_get_state() doesn't is an implementation detail that you should not
rely on.) I would prefer that you don't access pwm->state at all but
determine the state by looking at the registers.

> +	ret =3D clk_set_rate(chan->pwm_clk, chan->rate);
> +	if (ret) {
> +		dev_err(pwmchip_parent(chip), "failed to set PWM %d clock rate to %lu\=
n",
> +			pwm->hwpwm, chan->rate);
> +		return ret;
> +	}
> +
> +	h616_pwm_set_bypass(h616chip, pwm->hwpwm, chan->bypass);
> +
> +	/*
> +	 * If bypass is set, the PWM logic (polarity, duty) can't be applied
> +	 */
> +
> +	if (chan->bypass && (state->polarity =3D=3D PWM_POLARITY_INVERSED)) {
> +		dev_warn(pwmchip_parent(chip),
> +			 "Can't set inversed polarity with bypass enabled\n");
> +	} else {
> +		val =3D h616_pwm_readl(h616chip, PWM_CTRL_REG(pwm->hwpwm));
> +		val &=3D ~PWM_CTRL_ACTIVE_STATE;
> +		if (state->polarity =3D=3D PWM_POLARITY_NORMAL)
> +			val |=3D PWM_CTRL_ACTIVE_STATE;
> +		h616_pwm_writel(h616chip, val, PWM_CTRL_REG(pwm->hwpwm));
> +	}
> +
> +	if (chan->bypass && (state->duty_cycle * 2 !=3D state->period)) {
> +		dev_warn(pwmchip_parent(chip),
> +			 "Can't set a duty cycle with bypass enabled\n");
> +	}

Please no output in runtime callbacks. (And even then

	state->period / 2 !=3D state->duty_cycle

would probaly be the nicer check as it also works for uneven periods.)

> +
> +	if (!chan->bypass) {
> +		val =3D PWM_DUTY(chan->active_cycles);
> +		val |=3D PWM_PERIOD(chan->entire_cycles);
> +		h616_pwm_writel(h616chip, val, PWM_PERIOD_REG(pwm->hwpwm));
> +	}
> +
> +	if (state->enabled =3D=3D cstate.enabled)
> +		return 0;
> +
> +	if (cstate.enabled) {
> +		unsigned long delay_us;
> +
> +		/*
> +		 * We need a full period to elapse before
> +		 * disabling the channel.

You need a full period between what and disabling? Assuming this is
about period and duty setting: Why not skip it if you disable?

> +		 */
> +		delay_us =3D DIV_ROUND_UP_ULL(cstate.period, NSEC_PER_USEC);
> +		fsleep(delay_us);

Huu, sleeping while holding a spin_lock and having disabled irqs :-\

> +	}
> +
> +	spin_lock_irqsave(&h616chip->clk_pdata->lock, flags);
> +
> +	val =3D h616_pwm_readl(h616chip, PWM_ENR);
> +	if (state->enabled)
> +		val |=3D PWM_ENABLE(pwm->hwpwm);
> +	else
> +		val &=3D ~PWM_ENABLE(pwm->hwpwm);
> +	h616_pwm_writel(h616chip, val, PWM_ENR);
> +
> +	spin_unlock_irqrestore(&h616chip->clk_pdata->lock, flags);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops h616_pwm_ops =3D {
> +	.apply =3D h616_pwm_apply,
> +	.get_state =3D h616_pwm_get_state,
> +	.request =3D h616_pwm_request,
> +	.free =3D h616_pwm_free,
> +};
> +
> +static struct clk_hw *h616_pwm_of_clk_get(struct of_phandle_args *clkspe=
c,
> +					  void *data)
> +{
> +	struct h616_pwm_chip *h616chip =3D data;
> +	struct clk_hw_onecell_data *hw_data =3D h616chip->clk_pdata->hw_data;
> +	unsigned int idx =3D clkspec->args[0];
> +	struct h616_pwm_channel *chan;
> +	struct clk_hw *ret_clk =3D NULL;
> +	unsigned long flags;
> +
> +	if (idx >=3D h616chip->data->npwm)
> +		return ERR_PTR(-EINVAL);
> +
> +	chan =3D &h616chip->channels[idx];
> +
> +	spin_lock_irqsave(&h616chip->clk_pdata->lock, flags);
> +
> +	if (chan->mode =3D=3D H616_PWM_MODE_PWM) {
> +		ret_clk =3D ERR_PTR(-EBUSY);
> +	} else {
> +		chan->mode =3D H616_PWM_MODE_CLK;
> +		ret_clk =3D hw_data->hws[CLK_BYPASS(h616chip, idx)];
> +	}
> +	spin_unlock_irqrestore(&h616chip->clk_pdata->lock, flags);
> +
> +	if (IS_ERR(ret_clk))
> +		goto out;
> +
> +	chan->bypass =3D true;
> +	h616_pwm_set_bypass(h616chip, idx, chan->bypass);
> +out:
> +	return ret_clk;
> +}
> +
> +static int h616_add_composite_clk(struct clk_pwm_data *data,
> +				  void __iomem *reg, spinlock_t *lock,
> +				  struct device *dev, struct clk_hw **hw)
> +{
> +	const struct clk_ops *mux_ops =3D NULL, *gate_ops =3D NULL, *rate_ops =
=3D NULL;
> +	struct clk_hw *mux_hw =3D NULL, *gate_hw =3D NULL, *rate_hw =3D NULL;
> +	struct device_node *node =3D dev->of_node;
> +
> +	if (data->mux_hw) {
> +		struct clk_mux *mux;
> +
> +		mux_hw =3D data->mux_hw;
> +		mux =3D to_clk_mux(mux_hw);
> +		mux->lock =3D lock;
> +		mux_ops =3D mux_hw->init->ops;
> +		mux->reg =3D (u64)mux->reg + reg;
> +	}
> +
> +	if (data->gate_hw) {
> +		struct clk_gate *gate;
> +
> +		gate_hw =3D data->gate_hw;
> +		gate =3D to_clk_gate(gate_hw);
> +		gate->lock =3D lock;
> +		gate_ops =3D gate_hw->init->ops;
> +		gate->reg =3D (u64)gate->reg + reg;
> +	}
> +
> +	if (data->rate_hw) {
> +		struct clk_divider *rate;
> +
> +		rate_hw =3D data->rate_hw;
> +		rate =3D to_clk_divider(rate_hw);
> +		rate_ops =3D rate_hw->init->ops;
> +		rate->lock =3D lock;
> +		rate->reg =3D (u64)rate->reg + reg;
> +
> +		if (rate->table) {
> +			const struct clk_div_table *clkt;
> +			int table_size =3D 0;
> +
> +			for (clkt =3D rate->table; clkt->div; clkt++)
> +				table_size++;
> +			rate->width =3D order_base_2(table_size);
> +		}
> +	}
> +
> +	/*
> +	 * Retrieve the parent clock names from DTS for pwm-clk-srcxy
> +	 */
> +	if (!data->parent_names) {
> +		data->num_parents =3D of_clk_get_parent_count(node);
> +		if (data->num_parents =3D=3D 0)
> +			return -ENOENT;
> +
> +		data->parent_names =3D devm_kzalloc(dev,
> +						  sizeof(*data->parent_names),
> +						  GFP_KERNEL);
> +		for (unsigned int i =3D 0; i < data->num_parents; i++)
> +			data->parent_names[i] =3D of_clk_get_parent_name(node, i);
> +	}
> +
> +	*hw =3D clk_hw_register_composite(dev, data->name, data->parent_names,
> +					data->num_parents, mux_hw,
> +					mux_ops, rate_hw, rate_ops,
> +					gate_hw, gate_ops, data->flags);
> +
> +	return PTR_ERR_OR_ZERO(*hw);
> +}
> +
> +static int h616_pwm_init_clocks(struct platform_device *pdev,
> +				struct h616_pwm_chip *h616chip)
> +{
> +	struct clk_pwm_pdata *pdata;
> +	struct device *dev =3D &pdev->dev;
> +	int num_clocks =3D 0;
> +	int ret;
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	while (pwmcc_data[num_clocks].name)
> +		num_clocks++;
> +
> +	pdata->hw_data =3D devm_kzalloc(dev, struct_size(pdata->hw_data, hws, n=
um_clocks),
> +				      GFP_KERNEL);
> +	if (!pdata->hw_data)
> +		return -ENOMEM;
> +
> +	pdata->hw_data->num =3D num_clocks;
> +	pdata->reg =3D h616chip->base;
> +
> +	spin_lock_init(&pdata->lock);
> +
> +	for (int i =3D 0; i < num_clocks; i++) {
> +		struct clk_hw **hw =3D &pdata->hw_data->hws[i];
> +
> +		ret =3D h616_add_composite_clk(&pwmcc_data[i], pdata->reg,
> +					     &pdata->lock, dev, hw);
> +		if (ret) {
> +			dev_err_probe(dev, ret,
> +				      "Failed to register hw clock %s\n",
> +				      pwmcc_data[i].name);
> +			for (i--; i >=3D 0; i--)
> +				clk_hw_unregister_composite(pdata->hw_data->hws[i]);
> +			return ret;
> +		}
> +	}
> +
> +	h616chip->clk_pdata =3D pdata;
> +
> +	return 0;
> +}
> +
> +static int h616_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct h616_pwm_data *data;
> +	struct device *dev =3D &pdev->dev;
> +	struct h616_pwm_chip *h616chip;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	data =3D of_device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;

error message please. (Or at least a comment that this cannot happen.)

> +
> +	chip =3D devm_pwmchip_alloc(dev, data->npwm, sizeof(*h616chip));
> +	if (IS_ERR(chip))
> +		return dev_err_probe(dev, PTR_ERR(chip),
> +				     "Failed to allocate pwmchip\n");
> +
> +	h616chip =3D to_h616_pwm_chip(chip);
> +	h616chip->data =3D data;
> +	h616chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(h616chip->base))
> +		return dev_err_probe(dev, PTR_ERR(h616chip->base),
> +				     "Failed to get PWM base address\n");
> +
> +	h616chip->bus_clk =3D devm_clk_get_enabled(dev, "bus");
> +	if (IS_ERR(h616chip->bus_clk))
> +		return dev_err_probe(dev, PTR_ERR(h616chip->bus_clk),
> +				     "Failed to get bus clock\n");
> +
> +	h616chip->channels =3D devm_kmalloc_array(dev, data->npwm,
> +						sizeof(*(h616chip->channels)),
> +						GFP_KERNEL);

There is a big amount of allocations here. Would be great to have this
reduced to save some memory management overhead and get some cache
locality in return.

> +	if (!h616chip->channels)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Failed to allocate %d channels array\n",
> +				     data->npwm);
> +
> +	h616chip->rst =3D devm_reset_control_get_shared(dev, NULL);
> +	if (IS_ERR(h616chip->rst))
> +		return dev_err_probe(dev, PTR_ERR(h616chip->rst),
> +				     "Failed to get reset control\n");
> +
> +	chip->ops =3D &h616_pwm_ops;
> +
> +	ret =3D h616_pwm_init_clocks(pdev, h616chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize clocks\n");

h616_pwm_init_clocks() already emits error messages.

> +	for (unsigned int i =3D 0; i < data->npwm; i++) {

Huh, AFAIK we're not using declarations in for loops in the kernel.

> +		struct h616_pwm_channel *chan =3D &h616chip->channels[i];
> +		struct clk_hw **hw =3D &h616chip->clk_pdata->hw_data->hws[i];
> +
> +		chan->pwm_clk =3D devm_clk_hw_get_clk(dev, *hw, NULL);
> +		if (IS_ERR(chan->pwm_clk)) {
> +			ret =3D dev_err_probe(dev, PTR_ERR(chan->pwm_clk),
> +					    "Failed to register PWM clock %d\n", i);
> +			goto err_get_clk;
> +		}
> +		chan->mode =3D H616_PWM_MODE_NONE;
> +	}
> +
> +	ret =3D devm_of_clk_add_hw_provider(dev, h616_pwm_of_clk_get, h616chip);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to add HW clock provider\n");
> +		goto err_add_clk_provider;
> +	}
> +
> +	/* Deassert reset */
> +	ret =3D reset_control_deassert(h616chip->rst);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Cannot deassert reset control\n");
> +		goto err_ctrl_deassert;
> +	}
> +
> +	ret =3D pwmchip_add(chip);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +		goto err_pwm_add;
> +	}
> +
> +	platform_set_drvdata(pdev, chip);

this is unused.

> +	return 0;
> +
> +err_pwm_add:
> +	reset_control_assert(h616chip->rst);
> +
> +err_ctrl_deassert:
> +err_add_clk_provider:
> +err_get_clk:
> +	for (int i =3D 0; i < h616chip->clk_pdata->hw_data->num; i++)
> +		clk_hw_unregister_composite(h616chip->clk_pdata->hw_data->hws[i]);
> +
> +	return ret;
> +}

You need to implement a .remove() callback to not leak resources (or use
devm functions).

> +
> +static const struct h616_pwm_data sun50i_h616_pwm_data =3D {
> +	.npwm =3D 6,
> +};
> +
> +static const struct of_device_id h616_pwm_dt_ids[] =3D {
> +	{
> +		.compatible =3D "allwinner,sun50i-h616-pwm",
> +		.data =3D &sun50i_h616_pwm_data,
> +	}, {
> +		/* sentinel */
> +	},

no , here.

> +};
> +MODULE_DEVICE_TABLE(of, h616_pwm_dt_ids);
> +
> +

A single empty line is enough here.

> +static struct platform_driver h616_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "h616-pwm",
> +		.of_match_table =3D h616_pwm_dt_ids,
> +	},
> +	.probe =3D h616_pwm_probe,
> +};
> +module_platform_driver(h616_pwm_driver);
> +
> +MODULE_AUTHOR("Richard Genoud <richard.genoud@bootlin.com>");
> +MODULE_DESCRIPTION("Allwinner H616 PWM driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--7vwgv3lf455gi2pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlLuGsACgkQj4D7WH0S
/k7eQAgAkUj4yAlSRtLHzfqQaZD6VztxL3VHBSZdNPwCBktzPJH7NwdsV0KnFaYh
/Azd+parO4D586KZ4wb74nOeZjt9dHZU5fvn4voQrH25IRxDO85x8XQ5jfihMZCz
inYI6ofUBEzStaBsf1KrrPqEhWu7e8W3imUa69mY67d6jwv6sdS3ufWwhoDMTa4O
x8cfT2kdogsThBb0pLxiY5S2S1y/eICy5Y8bU8op3XtlHr4drT74EZDJnE77NPVj
RXtmYRqX9PMuB4Zh3ahuvd0McTNRBqXCxs58EEZ706bYhRzoUnMaFc+axluHzS30
pYSSKAjccVtu6j+B2oyfgPa5+BBxTw==
=z6Eu
-----END PGP SIGNATURE-----

--7vwgv3lf455gi2pg--

