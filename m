Return-Path: <linux-pwm+bounces-9125-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3vaKLLuNFGpyOQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9125-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 19:58:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC075CD7FD
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB21D3011115
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F6733ADA2;
	Mon, 25 May 2026 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga6LFt0e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315B232A3F3;
	Mon, 25 May 2026 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731896; cv=none; b=XqelAwPf6fjsHzsf1SpHA206NOD5nHqwbv0jbd8bVWp3Y5LPiszc550GBjWQ1Drx9AfQgtZ116GSIqifoxPpQz4u4bG/G04Jxl4k355CbTmyeFkG4GVN2sKl3wqsvt5zAIDDbsij8qqoQZkuLu6IdcPr2SjuUR7BvwwjbMsVM+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731896; c=relaxed/simple;
	bh=8rg+u4p1HHynYnAHZYJhkd+PkI3+SIsLFgzbIsMjUYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwC5IZjY2zFgcC54PeE8+UfNY1rOtgzeYkudlYyCwYpkr9BZsfjuELFfbQ1mOhGFXk1cMjPsOTCcuJ7duBGrdBa9m1tdDFnCYPmzQiiWgcOwLUfIqEMRWgc57FziV9ijTVeo0i2anLBgQtNZIP/2aOoii2VBMMU6wRBAe+aN4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga6LFt0e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E81591F000E9;
	Mon, 25 May 2026 17:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779731893;
	bh=zFng/XxJ8N1C//+vfx7jUN3164uooKej4vWPB6DRH+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ga6LFt0eWiLcyrM3Zgct7PiMju28Xw8NqxGpMJ6ialxn049g6BaXzwnQz9FFyzr9F
	 5cS1G2DMs4dj7xAwGNtgRBQjsW+rP0XBXvYmT6/l9x2EpeZWroNl6GTTtZFCLD7Rca
	 vNcgSWKQcLnX3PdRjquSpVOj46P78hcu475mw3KAH4sZeIpyii0242DfLYThOM7JsT
	 NXX+POd74Bk3BFld8frVplqSn9v12a7ImM1x65Io7c10tjQBsuvvw2FJ+UI1cGBuJv
	 OEFxsxesvLlvnGZ3vYllCHm09gb1iNY1THVCDFOs4C1mZxcmXzrL4/L2T7Pr3Lsz7C
	 6yvzr+9hZmLIw==
Date: Mon, 25 May 2026 19:58:10 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Paul Kocialkowski <paulk@sys-base.io>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	John Stultz <jstultz@google.com>, Joao Schim <joao@schimsalabim.eu>, bigunclemax@gmail.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] pwm: sun8i: Add H616 PWM support
Message-ID: <ahR-CvUXrq_fKy9E@monoceros>
References: <20260416134037.3160537-1-richard.genoud@bootlin.com>
 <20260416134037.3160537-3-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3yp4lgbcfrxjaenc"
Content-Disposition: inline
In-Reply-To: <20260416134037.3160537-3-richard.genoud@bootlin.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9125-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,pengutronix.de,sys-base.io,bootlin.com,google.com,schimsalabim.eu,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,schimsalabim.eu:email]
X-Rspamd-Queue-Id: EAC075CD7FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--3yp4lgbcfrxjaenc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 2/4] pwm: sun8i: Add H616 PWM support
MIME-Version: 1.0

Hello Richard,

I cannot say much about the clk part of this driver and thus would like
to get some input from the clk people. Can you please add them to the
list of recipents for the next revision?

On Thu, Apr 16, 2026 at 03:40:35PM +0200, Richard Genoud wrote:
> Add driver for Allwinner H616 PWM controller, supporting up to 6
> channels.
> Those channels output can be either a PWM signal output or a clock
> output, thanks to the bypass.
>=20
> The channels are paired (0/1, 2/3 and 4/5) and each pair has a
> prescaler/mux/gate.
> Moreover, each channel has its own prescaler and bypass.
>=20
> The clock provider part of this driver is needed not only because the
> H616 PWM controller provides also clocks when bypass is enabled, but
> really because pwm-clock isn't fit to handle all cases here.
> pwm-clock would work if the 100MHz clock is requested, but if a lower
> clock is requested (like 24MHz), it will request a 42ns period to the
> PWM driver which will happily serve, with the 100MHz clock as input a
> 25MHz frequency and a duty cycle adjustable in the range [0-4]/4,
> because that is a sane thing to do for a PWM.
> The information missing is that a real clock is resquested, not a PWM.
>=20
> Tested-by: John Stultz <jstultz@google.com>
> Tested-by: Joao Schim <joao@schimsalabim.eu>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/pwm/Kconfig     |  12 +
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-sun8i.c | 938 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 951 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sun8i.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6f3147518376..c4fd682860d6 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -736,6 +736,18 @@ config PWM_SUN4I
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sun4i.
> =20
> +config PWM_SUN8I
> +	tristate "Allwinner sun8i/sun50i PWM support"
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on HAS_IOMEM && COMMON_CLK
> +	help
> +	  Generic PWM framework driver for Allwinner H616 SoCs.
> +	  It supports generic PWM, but can also provides a plain clock.
> +	  The AC300 PHY integrated in H616 SoC needs such a clock.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-sun8i.
> +
>  config PWM_SUNPLUS
>  	tristate "Sunplus PWM support"
>  	depends on ARCH_SUNPLUS || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 0dc0d2b69025..ba2e0ec7fc17 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_PWM_STM32)		+=3D pwm-stm32.o
>  obj-$(CONFIG_PWM_STM32_LP)	+=3D pwm-stm32-lp.o
>  obj-$(CONFIG_PWM_STMPE)		+=3D pwm-stmpe.o
>  obj-$(CONFIG_PWM_SUN4I)		+=3D pwm-sun4i.o
> +obj-$(CONFIG_PWM_SUN8I)		+=3D pwm-sun8i.o
>  obj-$(CONFIG_PWM_SUNPLUS)	+=3D pwm-sunplus.o
>  obj-$(CONFIG_PWM_TEGRA)		+=3D pwm-tegra.o
>  obj-$(CONFIG_PWM_TH1520)	+=3D pwm_th1520.o
> diff --git a/drivers/pwm/pwm-sun8i.c b/drivers/pwm/pwm-sun8i.c
> new file mode 100644
> index 000000000000..8f1023e3a2e5
> --- /dev/null
> +++ b/drivers/pwm/pwm-sun8i.c
> @@ -0,0 +1,938 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Driver for Allwinner sun8i Pulse Width Modulation Controller
> + *
> + * (C) Copyright 2025 Richard Genoud, Bootlin <richard.genoud@bootlin.co=
m>
> + *
> + * Based on drivers/pwm/pwm-sun4i.c with Copyright:
> + *
> + * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@bootlin.com>
> + *
> + * Limitations:
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
> +#include <linux/limits.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/spinlock.h>
> +#include <linux/time.h>
> +
> +/* PWM IRQ Enable Register */
> +#define SUN8I_PWM_PIER			0x0
> +
> +/* PWM IRQ Status Register */
> +#define SUN8I_PWM_PISR			0x4
> +
> +/* PWM Capture IRQ Enable Register */
> +#define SUN8I_PWM_CIER			0x10
> +
> +/* PWM Capture IRQ Status Register */
> +#define SUN8I_PWM_CISR			0x14
> +
> +/* PWMCC Pairs Clock Configuration Registers */
> +#define SUN8I_PWM_PCCR(pair)		(0x20 + ((pair) * 0x4))
> +#define SUN8I_PWM_PCCR_SRC_SHIFT	7
> +#define SUN8I_PWM_PCCR_SRC_MASK		1
> +#define SUN8I_PWM_PCCR_GATE_BIT		4
> +#define SUN8I_PWM_PCCR_BYPASS_BIT(chan)	((chan) % 2 + 5)
> +#define SUN8I_PWM_PCCR_DIV_M_SHIFT	0
> +
> +/* PWMCC Pairs Dead Zone Control Registers */
> +#define SUN8I_PWM_PDZCR(pair)		(0x30 + ((pair) * 0x4))
> +
> +/* PWM Enable Register */
> +#define SUN8I_PWM_PER			0x40
> +#define SUN8I_PWM_ENABLE(chan)		BIT(chan)
> +
> +/* PWM Capture Enable Register */
> +#define SUN8I_PWM_CER			0x44
> +
> +/* PWM Control Register */
> +#define SUN8I_PWM_PCR(chan)		(0x60 + (chan) * 0x20)
> +#define SUN8I_PWM_PCR_PRESCAL_K_SHIFT	0
> +#define SUN8I_PWM_PCR_PRESCAL_K_WIDTH	8
> +#define SUN8I_PWM_PCR_ACTIVE_STATE	BIT(8)
> +
> +/* PWM Period Register */
> +#define SUN8I_PWM_PPR(chan)		(0x64 + (chan) * 0x20)
> +#define SUN8I_PWM_PPR_PERIOD_MASK	GENMASK(31, 16)
> +#define SUN8I_PWM_PPR_DUTY_MASK		GENMASK(15, 0)
> +#define SUN8I_PWM_PPR_PERIOD_VALUE(reg)	(FIELD_GET(SUN8I_PWM_PPR_PERIOD_=
MASK, reg) + 1)
> +#define SUN8I_PWM_PPR_DUTY_VALUE(reg)	FIELD_GET(SUN8I_PWM_PPR_DUTY_MASK,=
 reg)
> +#define SUN8I_PWM_PPR_PERIOD(prd)	FIELD_PREP(SUN8I_PWM_PPR_PERIOD_MASK, =
(prd) - 1)
> +#define SUN8I_PWM_DUTY(dty)		FIELD_PREP(SUN8I_PWM_PPR_DUTY_MASK, dty)
> +#define SUN8I_PWM_PPR_PERIOD_MAX	(FIELD_MAX(SUN8I_PWM_PPR_PERIOD_MASK) +=
 1)
> +
> +/* PWM Count Register */
> +#define SUN8I_PWM_PCNTR(chan)		(0x68 + (chan) * 0x20)
> +
> +/* PWM Capture Control Register */
> +#define SUN8I_PWM_CCR(chan)		(0x6c + (chan) * 0x20)
> +
> +/* PWM Capture Rise Lock Register */
> +#define SUN8I_PWM_CRLR(chan)		(0x70 + (chan) * 0x20)
> +
> +/* PWM Capture Fall Lock Register */
> +#define SUN8I_PWM_CFLR(chan)		(0x74 + (chan) * 0x20)
> +
> +#define SUN8I_PWM_PAIR_IDX(chan)	((chan) >> 1)
> +
> +/*
> + * Block diagram of the PWM clock controller:
> + *
> + *             _____      ______      ________
> + * OSC24M --->|     |    |      |    |        |
> + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> SUN8I_PWM_clock_sr=
c_xy
> + *            |_____|    |______|    |________|
> + *                               ________
> + *                              |        |
> + *                           +->| /div_k |---> SUN8I_PWM_clock_x
> + *                           |  |________|
> + *                           |    ______
> + *                           |   |      |
> + *                           +-->| Gate |----> SUN8I_PWM_bypass_clock_x
> + *                           |   |______|
> + * SUN8I_PWM_clock_src_xy ---+   ________
> + *                           |  |        |
> + *                           +->| /div_k |---> SUN8I_PWM_clock_y
> + *                           |  |________|
> + *                           |    ______
> + *                           |   |      |
> + *                           +-->| Gate |----> SUN8I_PWM_bypass_clock_y
> + *                               |______|
> + *
> + * NB: when the bypass is set, all the PWM logic is bypassed.
> + * So, the duty cycle and polarity can't be modified (we just have a clo=
ck).
> + * The bypass in PWM mode is used to achieve a 1/2 relative duty cycle w=
ith the
> + * fastest clock.
> + *
> + * SUN8I_PWM_clock_x/y serve for the PWM purpose.
> + * SUN8I_PWM_bypass_clock_x/y serve for the clock-provider purpose.
> + *
> + */
> +
> +/*
> + * Table used for /div_m (diviser before obtaining SUN8I_PWM_clock_src_x=
y)
> + * It's actually CLK_DIVIDER_POWER_OF_TWO, but limited to /256
> + */
> +#define CLK_TABLE_DIV_M_ENTRY(i) { \
> +	.val =3D (i), .div =3D 1 << (i) \
> +}
> +
> +static const struct clk_div_table clk_table_div_m[] =3D {
> +	CLK_TABLE_DIV_M_ENTRY(0),
> +	CLK_TABLE_DIV_M_ENTRY(1),
> +	CLK_TABLE_DIV_M_ENTRY(2),
> +	CLK_TABLE_DIV_M_ENTRY(3),
> +	CLK_TABLE_DIV_M_ENTRY(4),
> +	CLK_TABLE_DIV_M_ENTRY(5),
> +	CLK_TABLE_DIV_M_ENTRY(6),
> +	CLK_TABLE_DIV_M_ENTRY(7),
> +	CLK_TABLE_DIV_M_ENTRY(8),
> +	{ /* sentinel */ }
> +};
> +
> +#define SUN8I_PWM_XY_SRC_GATE(_pair, _reg)		\
> +struct clk_gate gate_xy_##_pair =3D {			\
> +	.reg =3D (void *)(_reg),				\
> +	.bit_idx =3D SUN8I_PWM_PCCR_GATE_BIT,		\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D &clk_gate_ops,			\
> +	}						\
> +}
> +
> +#define SUN8I_PWM_XY_SRC_MUX(_pair, _reg)		\
> +struct clk_mux mux_xy_##_pair =3D {			\
> +	.reg =3D (void *)(_reg),				\
> +	.shift =3D SUN8I_PWM_PCCR_SRC_SHIFT,		\
> +	.mask =3D SUN8I_PWM_PCCR_SRC_MASK,		\
> +	.flags =3D CLK_MUX_ROUND_CLOSEST,			\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D &clk_mux_ops,			\
> +	}						\
> +}
> +
> +#define SUN8I_PWM_XY_SRC_DIV(_pair, _reg)		\
> +struct clk_divider rate_xy_##_pair =3D {			\
> +	.reg =3D (void *)(_reg),				\
> +	.shift =3D SUN8I_PWM_PCCR_DIV_M_SHIFT,		\
> +	.table =3D clk_table_div_m,			\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D &clk_divider_ops,		\
> +	}						\
> +}
> +
> +#define SUN8I_PWM_X_DIV(_idx, _reg)			\
> +struct clk_divider rate_x_##_idx =3D {			\
> +	.reg =3D (void *)(_reg),				\
> +	.shift =3D SUN8I_PWM_PCR_PRESCAL_K_SHIFT,		\
> +	.width =3D SUN8I_PWM_PCR_PRESCAL_K_WIDTH,		\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D &clk_divider_ops,		\
> +	}						\
> +}
> +
> +#define SUN8I_PWM_X_BYPASS_GATE(_idx)			\
> +struct clk_gate gate_x_bypass_##_idx =3D {		\
> +	.reg =3D (void *)SUN8I_PWM_PER,			\
> +	.bit_idx =3D _idx,				\
> +	.hw.init =3D &(struct clk_init_data){		\
> +		.ops =3D &clk_gate_ops,			\
> +	}						\
> +}
> +
> +#define SUN8I_PWM_XY_CLK_SRC(_pair, _reg)			\
> +	static SUN8I_PWM_XY_SRC_MUX(_pair, _reg);		\
> +	static SUN8I_PWM_XY_SRC_GATE(_pair, _reg);		\
> +	static SUN8I_PWM_XY_SRC_DIV(_pair, _reg)
> +
> +#define SUN8I_PWM_X_CLK(_idx)					\
> +	static SUN8I_PWM_X_DIV(_idx, SUN8I_PWM_PCR(_idx))
> +
> +#define SUN8I_PWM_X_BYPASS_CLK(_idx)				\
> +	SUN8I_PWM_X_BYPASS_GATE(_idx)
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
> +		.flags =3D CLK_SET_RATE_PARENT,				\
> +	}
> +
> +/*
> + * SUN8I_PWM_clock_src_xy generation:
> + *             _____      ______      ________
> + * OSC24M --->|     |    |      |    |        |
> + * APB1 ----->| Mux |--->| Gate |--->| /div_m |-----> SUN8I_PWM_clock_sr=
c_xy
> + *            |_____|    |______|    |________|
> + */
> +SUN8I_PWM_XY_CLK_SRC(01, SUN8I_PWM_PCCR(0));
> +SUN8I_PWM_XY_CLK_SRC(23, SUN8I_PWM_PCCR(1));
> +SUN8I_PWM_XY_CLK_SRC(45, SUN8I_PWM_PCCR(2));
> +
> +/*
> + * SUN8I_PWM_clock_x_div generation:
> + *                            ________
> + *                           |        | SUN8I_PWM_clock_x/y
> + * SUN8I_PWM_clock_src_xy -->| /div_k |--------------->
> + *                           |________|
> + */
> +SUN8I_PWM_X_CLK(0);
> +SUN8I_PWM_X_CLK(1);
> +SUN8I_PWM_X_CLK(2);
> +SUN8I_PWM_X_CLK(3);
> +SUN8I_PWM_X_CLK(4);
> +SUN8I_PWM_X_CLK(5);
> +
> +/*
> + * SUN8I_PWM_bypass_clock_xy generation:
> + *                             ______
> + *                            |      |
> + * SUN8I_PWM_clock_src_xy --->| Gate |-------> SUN8I_PWM_bypass_clock_x
> + *                            |______|
> + *
> + * The gate is actually SUN8I_PWM_PER register.
> + */
> +SUN8I_PWM_X_BYPASS_CLK(0);
> +SUN8I_PWM_X_BYPASS_CLK(1);
> +SUN8I_PWM_X_BYPASS_CLK(2);
> +SUN8I_PWM_X_BYPASS_CLK(3);
> +SUN8I_PWM_X_BYPASS_CLK(4);
> +SUN8I_PWM_X_BYPASS_CLK(5);
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
> +/* Indexes of REF_CLK_BYPASS and REF_CLK_XY_SRC in the array */
> +#define CLK_BYPASS_IDX(sun8i_chip, chan) ((sun8i_chip)->data->npwm + (ch=
an))
> +#define CLK_XY_SRC_IDX(sun8i_chip, chan) \
> +	((sun8i_chip)->data->npwm * 2 + SUN8I_PWM_PAIR_IDX(chan))
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
> +	{ /* sentinel */ }
> +};
> +
> +enum sun8i_pwm_mode {
> +	SUN8I_PWM_MODE_NONE,
> +	SUN8I_PWM_MODE_PWM,
> +	SUN8I_PWM_MODE_CLK,
> +};
> +
> +struct sun8i_pwm_data {
> +	unsigned int npwm;
> +};
> +
> +struct sun8i_pwm_channel {
> +	struct clk *pwm_clk;
> +	enum sun8i_pwm_mode mode;
> +};
> +
> +struct clk_pwm_pdata {
> +	struct clk_hw_onecell_data *hw_data;
> +	spinlock_t lock;
> +	void __iomem *reg;
> +};
> +
> +struct sun8i_pwm_chip {
> +	struct clk_pwm_pdata *clk_pdata;
> +	struct sun8i_pwm_channel *channels;
> +	struct clk *bus_clk;
> +	struct reset_control *rst;
> +	void __iomem *base;
> +	const struct sun8i_pwm_data *data;
> +};
> +
> +struct sun8i_pwm_waveform {
> +	u8 enabled:1;
> +	u8 active_state:1;
> +	u8 bypass_en:1;
> +	u16 duty_ticks;
> +	u32 period_ticks;
> +	unsigned long clk_rate;
> +};
> +
> +static inline struct sun8i_pwm_chip *sun8i_pwm_from_chip(const struct pw=
m_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static inline u32 sun8i_pwm_readl(struct sun8i_pwm_chip *sun8i_chip,
> +				  unsigned long offset)
> +{
> +	return readl(sun8i_chip->base + offset);
> +}
> +
> +static inline void sun8i_pwm_writel(struct sun8i_pwm_chip *sun8i_chip,
> +				    u32 val, unsigned long offset)
> +{
> +	writel(val, sun8i_chip->base + offset);
> +}
> +
> +static void sun8i_pwm_set_bypass(struct sun8i_pwm_chip *sun8i_chip,
> +				 unsigned int idx, bool en_bypass)
> +{
> +	unsigned long flags, reg_offset;
> +	u32 val;
> +
> +	spin_lock_irqsave(&sun8i_chip->clk_pdata->lock, flags);
> +
> +	reg_offset =3D SUN8I_PWM_PCCR(SUN8I_PWM_PAIR_IDX(idx));
> +	val =3D sun8i_pwm_readl(sun8i_chip, reg_offset);
> +	if (en_bypass)
> +		val |=3D BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx));
> +	else
> +		val &=3D ~BIT(SUN8I_PWM_PCCR_BYPASS_BIT(idx));
> +
> +	sun8i_pwm_writel(sun8i_chip, val, reg_offset);
> +
> +	spin_unlock_irqrestore(&sun8i_chip->clk_pdata->lock, flags);
> +}
> +
> +static int sun8i_pwm_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chip);
> +	struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm->hwpwm];
> +
> +	scoped_guard(spinlock_irqsave, &sun8i_chip->clk_pdata->lock) {
> +		if (chan->mode =3D=3D SUN8I_PWM_MODE_CLK)
> +			return -EBUSY;
> +		chan->mode =3D SUN8I_PWM_MODE_PWM;
> +	}
> +
> +	return clk_prepare_enable(chan->pwm_clk);
> +}
> +
> +static void sun8i_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chip);
> +	struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm->hwpwm];
> +
> +	clk_disable_unprepare(chan->pwm_clk);
> +	chan->mode =3D SUN8I_PWM_MODE_NONE;
> +}
> +
> +static int sun8i_pwm_read_waveform(struct pwm_chip *chip,
> +				   struct pwm_device *pwm,
> +				   void *_wfhw)
> +{
> +	struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> +	struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chip);
> +	struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm->hwpwm];
> +	u32 val;
> +
> +	wfhw->clk_rate =3D clk_get_rate(chan->pwm_clk);
> +
> +	val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> +	wfhw->enabled =3D !!(SUN8I_PWM_ENABLE(pwm->hwpwm) & val);
> +
> +	val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCCR(SUN8I_PWM_PAIR_IDX(p=
wm->hwpwm)));
> +	wfhw->bypass_en =3D !!(val & BIT(SUN8I_PWM_PCCR_BYPASS_BIT(pwm->hwpwm))=
);
> +
> +	val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(pwm->hwpwm));
> +	wfhw->active_state =3D !!(val & SUN8I_PWM_PCR_ACTIVE_STATE);
> +
> +	val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PPR(pwm->hwpwm));
> +	wfhw->duty_ticks =3D SUN8I_PWM_PPR_DUTY_VALUE(val);
> +	wfhw->period_ticks =3D SUN8I_PWM_PPR_PERIOD_VALUE(val);
> +
> +	dev_dbg(pwmchip_parent(chip),
> +		"pwm%u: %s, bypass: %s, polarity: %s, clk_rate=3D%lu period_ticks=3D%u=
 duty_ticks=3D%u\n",
> +		pwm->hwpwm,
> +		wfhw->enabled ? "enabled" : "disabled",
> +		wfhw->bypass_en ? "enabled" : "disabled",
> +		wfhw->active_state ? "normal" : "inversed",
> +		wfhw->clk_rate, wfhw->period_ticks, wfhw->duty_ticks);
> +
> +	return 0;
> +}
> +
> +static int sun8i_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const void *_wfhw,
> +					   struct pwm_waveform *wf)
> +{
> +	const struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> +	u64 tmp, resolution;
> +
> +	dev_dbg(pwmchip_parent(chip),
> +		"pwm%u: %s, bypass: %s, polarity: %s, clk_rate=3D%lu period_ticks=3D%u=
 duty_ticks=3D%u\n",
> +		pwm->hwpwm,
> +		wfhw->enabled ? "enabled" : "disabled",
> +		wfhw->bypass_en ? "enabled" : "disabled",
> +		wfhw->active_state ? "normal" : "inversed",
> +		wfhw->clk_rate, wfhw->period_ticks, wfhw->duty_ticks);
> +
> +	wf->duty_offset_ns =3D 0;
> +
> +	if (!wfhw->enabled || !wfhw->clk_rate) {
> +		wf->period_length_ns =3D 0;
> +		wf->duty_length_ns =3D 0;
> +		return 0;
> +	}
> +
> +	if (wfhw->bypass_en) {
> +		wf->period_length_ns =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> +							wfhw->clk_rate);
> +		wf->duty_length_ns =3D DIV_ROUND_UP_ULL(wf->period_length_ns, 2);
> +		return 0;
> +	}
> +
> +	tmp =3D NSEC_PER_SEC * (u64)wfhw->period_ticks;
> +	wf->period_length_ns =3D DIV_ROUND_UP_ULL(tmp, wfhw->clk_rate);
> +
> +	tmp =3D NSEC_PER_SEC * (u64)wfhw->duty_ticks;
> +	wf->duty_length_ns =3D DIV_ROUND_UP_ULL(tmp, wfhw->clk_rate);
> +	if (!wfhw->active_state) {
> +		/*
> +		 * For inverted polarity, we have to fix cases where
> +		 * computed duty_length_ns > requested duty_length_ns
> +		 * For that, we subtract the actual resolution of the PWM
> +		 * registers
> +		 */
> +		wf->duty_offset_ns =3D wf->duty_length_ns;
> +		wf->duty_length_ns =3D wf->period_length_ns - wf->duty_length_ns;
> +
> +		resolution =3D DIV_ROUND_UP_ULL(NSEC_PER_SEC, wfhw->clk_rate);
> +
> +		if (wf->duty_offset_ns >=3D resolution)
> +			wf->duty_offset_ns -=3D resolution;

This looks wrong. If you have

	clk_rate =3D 300000
	period_ticks =3D 3000
	duty_ticks =3D 440
	active_state =3D 0

you're supposed to report:

	.period_length_ns =3D roundup(3000 * 1000000000 / 300000) =3D 10000000
	.duty_length_ns =3D roundup((3000 - 440) * 1000000000 / 300000) =3D 8533334
	.duty_offset_ns =3D roundup(440 * 1000000000 / 300000) =3D 1466667

> +	}
> +
> +	dev_dbg(pwmchip_parent(chip),
> +		"pwm%u period_length_ns=3D%llu duty_length_ns=3D%llu duty_offset_ns=3D=
%llu\n",
> +		pwm->hwpwm, wf->period_length_ns, wf->duty_length_ns,
> +		wf->duty_offset_ns);

Can you please only use a single output that has both the register state
and the waveform representation? Currently the waveform part is also
skipped on the early returns above. Also please use "%lld/%lld [+%lld]"
to represent the waveform.

> +	return 0;
> +}
> +
> +static int sun8i_pwm_write_waveform(struct pwm_chip *chip,
> +				    struct pwm_device *pwm, const void *_wfhw)
> +{
> +	const struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> +	struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chip);
> +	struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm->hwpwm];
> +	unsigned long flags;
> +	u32 val;
> +	int ret;
> +
> +	ret =3D clk_set_rate(chan->pwm_clk, wfhw->clk_rate);
> +	if (ret)
> +		return ret;
> +
> +	sun8i_pwm_set_bypass(sun8i_chip, pwm->hwpwm, wfhw->bypass_en);
> +
> +	val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PCR(pwm->hwpwm));
> +	if (wfhw->active_state)
> +		val |=3D SUN8I_PWM_PCR_ACTIVE_STATE;
> +	else
> +		val &=3D ~SUN8I_PWM_PCR_ACTIVE_STATE;
> +	sun8i_pwm_writel(sun8i_chip, val, SUN8I_PWM_PCR(pwm->hwpwm));
> +
> +	val =3D SUN8I_PWM_DUTY(wfhw->duty_ticks);
> +	val |=3D SUN8I_PWM_PPR_PERIOD(wfhw->period_ticks);
> +	sun8i_pwm_writel(sun8i_chip, val, SUN8I_PWM_PPR(pwm->hwpwm));
> +
> +	spin_lock_irqsave(&sun8i_chip->clk_pdata->lock, flags);
> +
> +	val =3D sun8i_pwm_readl(sun8i_chip, SUN8I_PWM_PER);
> +	if (wfhw->enabled)
> +		val |=3D SUN8I_PWM_ENABLE(pwm->hwpwm);
> +	else
> +		val &=3D ~SUN8I_PWM_ENABLE(pwm->hwpwm);
> +	sun8i_pwm_writel(sun8i_chip, val, SUN8I_PWM_PER);
> +
> +	spin_unlock_irqrestore(&sun8i_chip->clk_pdata->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int sun8i_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					 struct pwm_device *pwm,
> +					 const struct pwm_waveform *wf,
> +					 void *_wfhw)
> +{
> +	struct sun8i_pwm_chip *sun8i_chip =3D sun8i_pwm_from_chip(chip);
> +	struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[pwm->hwpwm];
> +	struct sun8i_pwm_waveform *wfhw =3D _wfhw;
> +	unsigned long max_rate;
> +	long calc_rate;
> +	u64 period_ratio, double_duty_ratio, freq, duty_cycle;
> +
> +	dev_dbg(pwmchip_parent(chip),
> +		"pwm%u period_length_ns=3D%llu duty_length_ns=3D%llu duty_offset_ns=3D=
%llu\n",
> +		pwm->hwpwm, wf->period_length_ns, wf->duty_length_ns,
> +		wf->duty_offset_ns);
> +
> +	if (wf->period_length_ns =3D=3D 0) {
> +		wfhw->enabled =3D 0;
> +		return 0;
> +	}
> +
> +	wfhw->enabled =3D 1;
> +
> +	duty_cycle =3D wf->duty_length_ns;
> +	if (wf->duty_length_ns + wf->duty_offset_ns < wf->period_length_ns)
> +		wfhw->active_state =3D 1;
> +	else
> +		wfhw->active_state =3D 0;

Please look at pwm-stm32.c on how to determine if inversed polarity
should be used or not.

> +	dev_dbg(pwmchip_parent(chip), "polarity: %s\n",
> +		wfhw->active_state ? "normal" : "inversed");
> +
> +	/*
> +	 * Lowest possible period case:
> +	 * Without bypass, the lowest possible period is when:
> +	 * duty cycle =3D 1 and period cycle =3D 2 (0x10001 in period register)
> +	 * E.g. if the input clock is 100MHz, we have a lowest period of 20ns.
> +	 * Now, with the bypass, the period register is ignored and we directly
> +	 * have the 100MHz clock as PWM output, that can act as a 10ns period
> +	 * with 5ns duty.
> +	 * So, to detect this lowest period case, just get the maximum possible
> +	 * rate from chan->pwm_clk and compare it with requested period and
> +	 * duty_cycle.
> +	 *
> +	 * But, to get the maximum possible rate, we have to use U32_MAX instead
> +	 * of (unsigned long)-1.
> +	 * This is because clk_round_rate() uses ultimately DIV_ROUND_UP_ULL()
> +	 * that in turn do_div(n,base). And base is uint32_t divisor.
> +	 */
> +	max_rate =3D clk_round_rate(chan->pwm_clk, U32_MAX);
> +
> +	dev_dbg(pwmchip_parent(chip), "max_rate: %ld Hz\n", max_rate);
> +
> +	period_ratio =3D mul_u64_u64_div_u64(wf->period_length_ns,
> +					   max_rate, NSEC_PER_SEC);
> +	double_duty_ratio =3D mul_u64_u64_div_u64(duty_cycle, (u64)max_rate * 2,
> +						NSEC_PER_SEC);
> +	if (period_ratio =3D=3D 1) {
> +		if (double_duty_ratio =3D=3D 0)
> +			/* requested period and duty are too small */
> +			return -EINVAL;
> +		/*
> +		 * If the requested period is to small to be generated by the
> +		 * PWM, but matches the highest clock with a
> +		 * duty_cycle >=3D period*2, just bypass the PWM logic
> +		 */
> +		freq =3D div64_u64(NSEC_PER_SEC, wf->period_length_ns);
> +		wfhw->bypass_en =3D true;
> +	} else {
> +		wfhw->bypass_en =3D false;
> +		freq =3D div64_u64(NSEC_PER_SEC * (u64)SUN8I_PWM_PPR_PERIOD_MAX,
> +				 wf->period_length_ns);
> +		/*
> +		 * Same remark as above, this is to prevent a value to big for
> +		 * clk_round_rate() to handle
> +		 */
> +		if (freq > U32_MAX)
> +			freq =3D U32_MAX;
> +	}
> +
> +	dev_dbg(pwmchip_parent(chip), "bypass: %s\n",
> +		wfhw->bypass_en ? "enabled" : "disabled");
> +
> +	calc_rate =3D clk_round_rate(chan->pwm_clk, freq);
> +	if (calc_rate <=3D 0)
> +		return calc_rate ? calc_rate : -EINVAL;
> +
> +	dev_dbg(pwmchip_parent(chip), "calc_rate: %ld Hz\n", calc_rate);
> +
> +	wfhw->period_ticks =3D mul_u64_u64_div_u64(calc_rate,
> +						 wf->period_length_ns,
> +						 NSEC_PER_SEC);
> +	if (wfhw->period_ticks > SUN8I_PWM_PPR_PERIOD_MAX)
> +		wfhw->period_ticks =3D SUN8I_PWM_PPR_PERIOD_MAX;
> +
> +	/* min value in period register is 1 */
> +	if (wfhw->period_ticks =3D=3D 0)
> +		return -EINVAL;
> +
> +	wfhw->duty_ticks =3D mul_u64_u64_div_u64(calc_rate, duty_cycle,
> +					       NSEC_PER_SEC);
> +
> +	if (wfhw->duty_ticks > wfhw->period_ticks)
> +		wfhw->duty_ticks =3D wfhw->period_ticks;
> +
> +	if (!wfhw->active_state)
> +		wfhw->duty_ticks =3D wfhw->period_ticks - wfhw->duty_ticks;
> +
> +	dev_dbg(pwmchip_parent(chip),
> +		"pwm%u period_ticks=3D%u duty_cycle=3D%llu duty_ticks=3D%u\n",
> +		pwm->hwpwm, wfhw->period_ticks, duty_cycle, wfhw->duty_ticks);

As for the fromhw callback: Please emit a single line here and stick to
the common format for *wf.

> +
> +	wfhw->clk_rate =3D calc_rate;
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops sun8i_pwm_ops =3D {
> +	.request =3D sun8i_pwm_request,
> +	.free =3D sun8i_pwm_free,
> +	.sizeof_wfhw =3D sizeof(struct sun8i_pwm_waveform),
> +	.round_waveform_tohw =3D sun8i_pwm_round_waveform_tohw,
> +	.round_waveform_fromhw =3D sun8i_pwm_round_waveform_fromhw,
> +	.read_waveform =3D sun8i_pwm_read_waveform,
> +	.write_waveform =3D sun8i_pwm_write_waveform,
> +};
> +
> +static struct clk_hw *sun8i_pwm_of_clk_get(struct of_phandle_args *clksp=
ec,
> +					   void *data)
> +{
> +	struct sun8i_pwm_chip *sun8i_chip =3D data;
> +	struct clk_hw_onecell_data *hw_data =3D sun8i_chip->clk_pdata->hw_data;
> +	unsigned int idx =3D clkspec->args[0];
> +	struct sun8i_pwm_channel *chan;
> +	struct clk_hw *ret_clk =3D NULL;
> +	unsigned long flags;
> +
> +	if (idx >=3D sun8i_chip->data->npwm)
> +		return ERR_PTR(-EINVAL);
> +
> +	chan =3D &sun8i_chip->channels[idx];
> +
> +	spin_lock_irqsave(&sun8i_chip->clk_pdata->lock, flags);
> +
> +	if (chan->mode =3D=3D SUN8I_PWM_MODE_PWM) {
> +		ret_clk =3D ERR_PTR(-EBUSY);
> +	} else {
> +		chan->mode =3D SUN8I_PWM_MODE_CLK;
> +		ret_clk =3D hw_data->hws[CLK_BYPASS_IDX(sun8i_chip, idx)];
> +	}
> +	spin_unlock_irqrestore(&sun8i_chip->clk_pdata->lock, flags);
> +
> +	if (IS_ERR(ret_clk))
> +		goto out;
> +
> +	sun8i_pwm_set_bypass(sun8i_chip, idx, true);
> +out:
> +	return ret_clk;
> +}
> +
> +static int sun8i_add_composite_clk(struct clk_pwm_data *data,
> +				   void __iomem *reg, spinlock_t *lock,
> +				   struct device *dev, struct clk_hw **hw)
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
> +		mux->reg =3D (uintptr_t)mux->reg + reg;
> +	}
> +
> +	if (data->gate_hw) {
> +		struct clk_gate *gate;
> +
> +		gate_hw =3D data->gate_hw;
> +		gate =3D to_clk_gate(gate_hw);
> +		gate->lock =3D lock;
> +		gate_ops =3D gate_hw->init->ops;
> +		gate->reg =3D (uintptr_t)gate->reg + reg;
> +	}
> +
> +	if (data->rate_hw) {
> +		struct clk_divider *rate;
> +
> +		rate_hw =3D data->rate_hw;
> +		rate =3D to_clk_divider(rate_hw);
> +		rate_ops =3D rate_hw->init->ops;
> +		rate->lock =3D lock;
> +		rate->reg =3D (uintptr_t)rate->reg + reg;
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
> +static int sun8i_pwm_init_clocks(struct platform_device *pdev,
> +				 struct sun8i_pwm_chip *sun8i_chip)
> +{
> +	struct clk_pwm_pdata *pdata;
> +	struct device *dev =3D &pdev->dev;
> +	int num_clocks =3D 0;
> +	int ret;
> +
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Failed to allocate clk_pwm_pdata\n");
> +
> +	while (pwmcc_data[num_clocks].name)
> +		num_clocks++;
> +
> +	pdata->hw_data =3D devm_kzalloc(dev, struct_size(pdata->hw_data, hws, n=
um_clocks),
> +				      GFP_KERNEL);
> +	if (!pdata->hw_data)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Failed to allocate hw clocks\n");
> +
> +	pdata->hw_data->num =3D num_clocks;
> +	pdata->reg =3D sun8i_chip->base;
> +
> +	spin_lock_init(&pdata->lock);
> +
> +	for (int i =3D 0; i < num_clocks; i++) {
> +		struct clk_hw **hw =3D &pdata->hw_data->hws[i];
> +
> +		ret =3D sun8i_add_composite_clk(&pwmcc_data[i], pdata->reg,
> +					      &pdata->lock, dev, hw);

If you register the unregister call here, cleanup gets a bit easier.

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
> +	sun8i_chip->clk_pdata =3D pdata;

If you copy the content of *pdata to sun8i_chip you can save an
allocation here and several pointer dereferences during runtime.

> +
> +	return 0;
> +}
> +
> +static void sun8i_pwm_unregister_clk(void *data)
> +{
> +	struct clk_hw_onecell_data *hw_data =3D data;
> +
> +	for (unsigned int i =3D 0; i < hw_data->num; i++)
> +		clk_hw_unregister_composite(hw_data->hws[i]);
> +}
> +
> +static int sun8i_pwm_probe(struct platform_device *pdev)
> +{
> +	const struct sun8i_pwm_data *data;
> +	struct device *dev =3D &pdev->dev;
> +	struct sun8i_pwm_chip *sun8i_chip;
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	data =3D of_device_get_match_data(dev);
> +	if (!data)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Missing specific data structure\n");
> +
> +	chip =3D devm_pwmchip_alloc(dev, data->npwm, sizeof(*sun8i_chip));
> +	if (IS_ERR(chip))
> +		return dev_err_probe(dev, PTR_ERR(chip),
> +				     "Failed to allocate pwmchip\n");
> +
> +	sun8i_chip =3D sun8i_pwm_from_chip(chip);
> +	sun8i_chip->data =3D data;
> +	sun8i_chip->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(sun8i_chip->base))
> +		return dev_err_probe(dev, PTR_ERR(sun8i_chip->base),
> +				     "Failed to get PWM base address\n");
> +
> +	sun8i_chip->bus_clk =3D devm_clk_get_enabled(dev, "bus");
> +	if (IS_ERR(sun8i_chip->bus_clk))
> +		return dev_err_probe(dev, PTR_ERR(sun8i_chip->bus_clk),
> +				     "Failed to get bus clock\n");
> +
> +	sun8i_chip->channels =3D devm_kmalloc_array(dev, data->npwm,
> +						  sizeof(*(sun8i_chip->channels)),
> +						  GFP_KERNEL);

I wonder if the clk framework ensures that after
devm_of_clk_release_provider() (i.e. the unregister part of
devm_of_clk_add_hw_provider()) sun8i_pwm_of_clk_get() isn't called any
more. If not this might trigger a use-after-free.

> +	if (!sun8i_chip->channels)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Failed to allocate %d channels array\n",
> +				     data->npwm);
> +
> +	chip->ops =3D &sun8i_pwm_ops;

Apart from the clk_get_rate() call in the callbacks you could set
=2Eatomic=3Dtrue.=20

Also use clk_rate_exclusive_get() to prevent that the parent clk rate
changes while the hardware emits a waveform. (Then also the need to have
clk_rate in sun8i_pwm_waveform goes away.)

> +
> +	ret =3D sun8i_pwm_init_clocks(pdev, sun8i_chip);
> +	if (ret)
> +		return ret;
> +
> +	for (unsigned int i =3D 0; i < data->npwm; i++) {
> +		struct sun8i_pwm_channel *chan =3D &sun8i_chip->channels[i];
> +		struct clk_hw **hw =3D &sun8i_chip->clk_pdata->hw_data->hws[i];
> +
> +		chan->pwm_clk =3D devm_clk_hw_get_clk(dev, *hw, NULL);
> +		if (IS_ERR(chan->pwm_clk)) {
> +			ret =3D dev_err_probe(dev, PTR_ERR(chan->pwm_clk),
> +					    "Failed to register PWM clock %d\n", i);
> +			return ret;

Please shorten that to

	return dev_err_probe(....);

> +		}
> +		chan->mode =3D SUN8I_PWM_MODE_NONE;
> +	}
> +
> +	ret =3D devm_of_clk_add_hw_provider(dev, sun8i_pwm_of_clk_get, sun8i_ch=
ip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add HW clock provider\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, sun8i_pwm_unregister_clk,
> +				       sun8i_chip->clk_pdata->hw_data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add devm action\n");
> +
> +	/* Deassert reset */
> +	sun8i_chip->rst =3D devm_reset_control_get_shared_deasserted(dev, NULL);
> +	if (IS_ERR(sun8i_chip->rst))
> +		return dev_err_probe(dev, PTR_ERR(sun8i_chip->rst),
> +				     "Failed to get reset control\n");
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
> +
> +	platform_set_drvdata(pdev, chip);

this isn't used, so please drop it.

> +	return 0;
> +}
> +
> +static const struct sun8i_pwm_data sun50i_h616_pwm_data =3D {
> +	.npwm =3D 6,
> +};

Do you expect that other variants of this hardware will appear that have
!=3D 6 channels? If not, please use the 6 directly in .probe().

> +static const struct of_device_id sun8i_pwm_dt_ids[] =3D {
> +	{
> +		.compatible =3D "allwinner,sun50i-h616-pwm",
> +		.data =3D &sun50i_h616_pwm_data,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_pwm_dt_ids);
> +
> +static struct platform_driver sun8i_pwm_driver =3D {
> +	.driver =3D {
> +		.name =3D "sun8i-pwm",
> +		.of_match_table =3D sun8i_pwm_dt_ids,
> +	},
> +	.probe =3D sun8i_pwm_probe,
> +};
> +module_platform_driver(sun8i_pwm_driver);
> +
> +MODULE_AUTHOR("Richard Genoud <richard.genoud@bootlin.com>");
> +MODULE_DESCRIPTION("Allwinner sun8i PWM driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--3yp4lgbcfrxjaenc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoUja8ACgkQj4D7WH0S
/k5rUgf/dqaNd+I4gLZZSusH2dcF58CimiczLZiSMFAoEYvXpqSldA4BGAc97Obz
c6+wYgr+RWagidMMWIkNf0nsSPGj39AH21W/iZ65svB7xhc4PMB0OkiT2ndq0KNk
D6pDLUrkDGborQH0ijRtrnZ7q2ushOsGS2CU6vLRJqwFBW8tmPWwwD7Gj5VPaLq8
uwhPjEms9EYmo4Hs0bQldca0NEAJrhg0yK63woakmeI/qyNy5VvjWDh4evU1ps5z
iD5tVaMUv91RNc1hGUG9gK49QIFIx37WTZRB0qiJzc+v/bEsXv9gA/N9u3z3P6Iv
gSpEioJjmQSAvDUPa0PlWvd3xbH90Q==
=1RZn
-----END PGP SIGNATURE-----

--3yp4lgbcfrxjaenc--

