Return-Path: <linux-pwm+bounces-2941-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B18C942120
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 21:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F42B1C20B2E
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E2E18C91F;
	Tue, 30 Jul 2024 19:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zj9prkkb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898718991F
	for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369277; cv=none; b=o/vomYK4r03BST+qgtxCxXY8pGT12+XeH+VCoSCZ6q/ra8ev+e6D8hI2+Oj53ffDkQc8V7j5Lz1dCqFmXwfBEboaErVdJmJ5pkuZ1JJRp6DOoNOLkdcUoCEAqERTcFKCcsl5zx/P7U2hrWgyc7dYhJl2jBRxKLFzPvM4SR0C7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369277; c=relaxed/simple;
	bh=FKyKLCWlvkc328X1wcJ8LTBp1YXFuq8EjdgtRUGp5LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmJRS1OY0B58p1VSGMA5XKKD/bUT3Z9xQ46gRyEVEzYSHub5hje4viBIF/2UcgWpnsvjtMEZCmNP7pWn0rIK3zR1bUi/7dbSgjcwLtg0nobMuUJVOqardtdOc7B8IATC2/z4vuMKfB8k5kCEzs0RpizCwzglFMyGk+I4lA9/Y+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zj9prkkb; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5afd7a9660eso5631279a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722369271; x=1722974071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Af4xaTj/3V/FVBSrERqns2JQoDJGzYx9XL+BW9OWLQQ=;
        b=zj9prkkbgZn7/gMZfnt6vf8uqcdSewkUOmXZkYr0WeEnGpE0MT8v5Ary607EIwo0V2
         RYDtqBA05wiB8cX9S1/qBHBYt1m5IMsWKlVctiS1HG/NeUpZ3kAa09ptnTgerDrlnfEc
         /nUlaZLCLvqiTKTqs21AawpluygeC9W2N8Am+DbfVheTVUm/uQ5kG4QIJpaif5T56kCH
         JhTuEg6y9W9HSo/cQQeItR3/SvcAvZkig0ps5ih6kYDalMcgfqgUql3KIdEXRmvKzp6w
         TuGEELLggNFJ/0uLTQM5vi2zIgTqH8qiC+DawtXv3eFIzCo2Ics0Bf8OBqerQJd2F+0R
         zfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722369271; x=1722974071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Af4xaTj/3V/FVBSrERqns2JQoDJGzYx9XL+BW9OWLQQ=;
        b=s2gBwuP/rJnqGginjmt9cFvHJJSTxbTW67y0s3JF3tKN9QK5dvIhgiafN0/496Ci7f
         +2krr7Oa2on202jTUQvKUFkLsKylIdG4mtnHkXa10wMzEeChDQIpE4zUtm0sE69EUcq/
         Wm3j1ukT5xZXNbtzsK+qWFrh6kpVeqn19Iz1CIGbTEyMFrvSz/5c7MgEErZzlTdS+BsH
         HtxeAwFAmaPCrlrcw1EqPn4EWSBGHD2ilMdAQfZ62Bn7USMHqEf9bWzmUQQE9dAyEduX
         tezyFmuThO9ZDd91Ap2i4F3xfAGLxAstt8u0jB6xJdjH+tOkGLXZBCjZUEA4c5TNqrb2
         tk9A==
X-Forwarded-Encrypted: i=1; AJvYcCVNc+mkqUQFnOzGzl8L5/bBKdhn2J1l5U3i4CHyPHgndi+JeUETfkLg7C9AVqHhvQckc2D/Jm0kaFeHaVXRiLdfwCAn8/uA+f8g
X-Gm-Message-State: AOJu0Yy/qkqEJGFEO/wQhnZASFjm0GnP+Bm/1fP+mxL6KXpKspLX+S4X
	ahKB6aOwSCYaJOGCZ3oCvzSw7FYRuuxZnn2l33COcBFwmrk25AQ478CDUmGJEeY=
X-Google-Smtp-Source: AGHT+IF6LnbQfY8p9FaCruWDkouQa0u2qcv+gwf/DflEsk0gF+nFf7zYgrlvFlacjbcpJD6Q19Aytg==
X-Received: by 2002:a17:906:d54f:b0:a7a:ab1a:2d67 with SMTP id a640c23a62f3a-a7d3ffaacdbmr989454466b.1.1722369270760;
        Tue, 30 Jul 2024 12:54:30 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9105fsm688696466b.177.2024.07.30.12.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 12:54:30 -0700 (PDT)
Date: Tue, 30 Jul 2024 21:54:27 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v20 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <yli3bq6i2467mzdtwkn3czls4w2snvegkzyun3uq4lto35wuhv@2wcju755otau>
References: <20240614154242.419043-1-biju.das.jz@bp.renesas.com>
 <20240614154242.419043-4-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p4gq5fistn4p4sfb"
Content-Disposition: inline
In-Reply-To: <20240614154242.419043-4-biju.das.jz@bp.renesas.com>


--p4gq5fistn4p4sfb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm a bit unlucky about this driver. I have the impression it is
complicated and wonder if that is necessary because the hardware is
unusual or if we just have to spot some simplifications.

I guess another problem is that the time between two consecutive reviews
is long and I forget most things I learned about the hardware from one
to the other. While this is mostly my problem, the same problem arises
if the driver is touched later again. So I wonder if some more
documentation is needed about the relation between channels and outputs
and subchannels. If the driver only supported one output per channel, it
could be considerably simpler (I think). But I guess that would be a
practically relevant restriction??

Some simplifications spotted below.

On Fri, Jun 14, 2024 at 04:42:41PM +0100, Biju Das wrote:
> RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
> (GPT32E). It supports the following functions
>  * 32 bits x 8 channels
>  * Up-counting or down-counting (saw waves) or up/down-counting
>    (triangle waves) for each counter.
>  * Clock sources independently selectable for each channel
>  * Two I/O pins per channel
>  * Two output compare/input capture registers per channel
>  * For the two output compare/input capture registers of each channel,
>    four registers are provided as buffer registers and are capable of
>    operating as comparison registers when buffering is not in use.
>  * In output compare operation, buffer switching can be at crests or
>    troughs, enabling the generation of laterally asymmetric PWM waveforms.
>  * Registers for setting up frame cycles in each channel (with capability
>    for generating interrupts at overflow or underflow)
>  * Generation of dead times in PWM operation
>  * Synchronous starting, stopping and clearing counters for arbitrary
>    channels
>  * Starting, stopping, clearing and up/down counters in response to input
>    level comparison
>  * Starting, clearing, stopping and up/down counters in response to a
>    maximum of four external triggers
>  * Output pin disable function by dead time error and detected
>    short-circuits between output pins
>  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
>  * Enables the noise filter for input capture and external trigger
>    operation
>=20
> Add basic pwm support for RZ/G2L GPT driver by creating separate
> logical channels for each IOs.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v19->v20:
>  * Added locks for rmw operations in rzg2l_gpt_{en,dis}able().
>  * Dropped decremeng enable_count based ch_en_bits in rzg2l_gpt_disable().
>  * Added a comment in calculate_period_or_duty() related to overflow.
>  * Replaced ch_en_bits->bootloader_enabled_channels and used this variable
>    in probe(), apply() and remove() for simplification
>  * Replaced pm_runtime_enable()->devm_pm_runtime_enable()
> [...]
> ---
>  drivers/pwm/Kconfig         |  11 +
>  drivers/pwm/Makefile        |   1 +
>  drivers/pwm/pwm-rzg2l-gpt.c | 555 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 567 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 00a543de8f82..3d398b308e3f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -522,6 +522,17 @@ config PWM_ROCKCHIP
>  	  Generic PWM framework driver for the PWM controller found on
>  	  Rockchip SoCs.
> =20
> +config PWM_RZG2L_GPT
> +	tristate "Renesas RZ/G2L General PWM Timer support"
> +	depends on ARCH_RZG2L || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This driver exposes the General PWM Timer controller found in Renesas
> +	  RZ/G2L like chips through the PWM API.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-rzg2l-gpt.
> +
>  config PWM_RZ_MTU3
>  	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
>  	depends on RZ_MTU3
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 6964ba45c795..fb9a2d9b9adb 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+=3D pwm-raspberrypi-=
poe.o
>  obj-$(CONFIG_PWM_RCAR)		+=3D pwm-rcar.o
>  obj-$(CONFIG_PWM_RENESAS_TPU)	+=3D pwm-renesas-tpu.o
>  obj-$(CONFIG_PWM_ROCKCHIP)	+=3D pwm-rockchip.o
> +obj-$(CONFIG_PWM_RZG2L_GPT)	+=3D pwm-rzg2l-gpt.o
>  obj-$(CONFIG_PWM_RZ_MTU3)	+=3D pwm-rz-mtu3.o
>  obj-$(CONFIG_PWM_SAMSUNG)	+=3D pwm-samsung.o
>  obj-$(CONFIG_PWM_SIFIVE)	+=3D pwm-sifive.o
> diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> new file mode 100644
> index 000000000000..6005a689173e
> --- /dev/null
> +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> @@ -0,0 +1,555 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/G2L General PWM Timer (GPT) driver
> + *
> + * Copyright (C) 2024 Renesas Electronics Corporation
> + *
> + * Hardware manual for this IP can be found here
> + * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-u=
sers-manual-hardware-0?language=3Den
> + *
> + * Limitations:
> + * - Counter must be stopped before modifying Mode and Prescaler.
> + * - When PWM is disabled, the output is driven to inactive.
> + * - While the hardware supports both polarities, the driver (for now)
> + *   only handles normal polarity.
> + * - When both channels are used, disabling the channel on one stops the
> + *   other.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/limits.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +#include <linux/time.h>
> +#include <linux/units.h>
> +
> +#define RZG2L_GTCR		0x2c
> +#define RZG2L_GTUDDTYC		0x30
> +#define RZG2L_GTIOR		0x34
> +#define RZG2L_GTBER		0x40
> +#define RZG2L_GTCNT		0x48
> +#define RZG2L_GTCCR(i)		(0x4c + 4 * (i))
> +#define RZG2L_GTPR		0x64
> +
> +#define RZG2L_GTCR_CST		BIT(0)
> +#define RZG2L_GTCR_MD		GENMASK(18, 16)
> +#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
> +
> +#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
> +
> +#define RZG2L_GTUDDTYC_UP	BIT(0)
> +#define RZG2L_GTUDDTYC_UDF	BIT(1)
> +#define RZG2L_GTUDDTYC_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_U=
DF)
> +
> +#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
> +#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
> +#define RZG2L_GTIOR_GTIOx(a)	((a) ? RZG2L_GTIOR_GTIOB : RZG2L_GTIOR_GTIO=
A)
> +#define RZG2L_GTIOR_OAE		BIT(8)
> +#define RZG2L_GTIOR_OBE		BIT(24)
> +#define RZG2L_GTIOR_OxE(a)	((a) ? RZG2L_GTIOR_OBE : RZG2L_GTIOR_OAE)
> +
> +#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
> +#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE)
> +#define RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
> +	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE) | R=
ZG2L_GTIOR_OBE)
> +
> +#define RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(a) \
> +	((a) ? RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH : \
> +	 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH)
> +
> +#define RZG2L_MAX_HW_CHANNELS	8
> +#define RZG2L_CHANNELS_PER_IO	2
> +#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_P=
ER_IO)
> +#define RZG2L_MAX_SCALE_FACTOR	1024
> +
> +#define RZG2L_GET_CH(a)		((a) / 2)
> +
> +#define RZG2L_GET_CH_OFFS(i)	(0x100 * (i))
> +
> +struct rzg2l_gpt_chip {
> +	void __iomem *mmio;
> +	struct reset_control *rstc;
> +	struct mutex lock; /* lock to protect shared channel resources */
> +	unsigned long rate_khz;
> +	u64 max_val;
> +	u32 period_cycles[RZG2L_MAX_HW_CHANNELS];
> +	u32 user_count[RZG2L_MAX_HW_CHANNELS];
> +	u32 enable_count[RZG2L_MAX_HW_CHANNELS];
> +	u8 bootloader_enabled_channels[RZG2L_MAX_PWM_CHANNELS];

Semantically bootloader_enabled_channels[x] is a bool, right?

> +};
> +
> +static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *=
chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
> +static inline unsigned int rzg2l_gpt_subchannel(unsigned int hwpwm)
> +{
> +	return hwpwm & 0x1;
> +}
> +
> +static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u=
32 data)
> +{
> +	writel(data, rzg2l_gpt->mmio + reg);
> +}
> +
> +static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg)
> +{
> +	return readl(rzg2l_gpt->mmio + reg);
> +}
> +
> +static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, =
u32 clr,
> +			     u32 set)
> +{
> +	rzg2l_gpt_write(rzg2l_gpt, reg,
> +			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set);
> +}
> +
> +static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
> +				       u64 period_cycles)
> +{
> +	u32 prescaled_period_cycles;
> +	u8 prescale;
> +
> +	prescaled_period_cycles =3D period_cycles >> 32;
> +	if (prescaled_period_cycles >=3D 256)
> +		prescale =3D 5;
> +	else
> +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> +
> +	return prescale;
> +}
> +
> +static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->user_count[ch]++;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->user_count[ch]--;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +}
> +
> +static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8=
 hwpwm)
> +{
> +	u8 ch =3D RZG2L_GET_CH(hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +	u32 val;
> +
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +	if (!(val & RZG2L_GTCR_CST))
> +		return false;
> +
> +	val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTIOR);
> +
> +	return val & RZG2L_GTIOR_OxE(rzg2l_gpt_subchannel(hwpwm));
> +}
> +
> +static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			    struct pwm_device *pwm)
> +{
> +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	u32 val =3D RZG2L_GTIOR_GTIOx(sub_ch) | RZG2L_GTIOR_OxE(sub_ch);
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	/* Enable pin output */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR, val,
> +			 RZG2L_GTIOR_GTIOx_OUT_HI_END_TOGGLE_CMP_MATCH(sub_ch));
> +
> +	if (!rzg2l_gpt->enable_count[ch])
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, 0, RZG2L_GTCR_CST);
> +
> +	rzg2l_gpt->enable_count[ch]++;
> +	mutex_unlock(&rzg2l_gpt->lock);
> +
> +	return 0;
> +}
> +
> +static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
> +			      struct pwm_device *pwm)
> +{
> +	u8 sub_ch =3D rzg2l_gpt_subchannel(pwm->hwpwm);
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +
> +	/* Stop count, Output low on GTIOCx pin when counting stops */
> +	mutex_lock(&rzg2l_gpt->lock);
> +	rzg2l_gpt->enable_count[ch]--;
> +
> +	if (!rzg2l_gpt->enable_count[ch])
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST, 0);
> +
> +	/* Disable pin output */
> +	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR, RZG2L_GTIOR_OxE(sub_ch)=
, 0);
> +	mutex_unlock(&rzg2l_gpt->lock);
> +}
> +
> +static u64 calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt, u3=
2 val, u8 prescale)
> +{
> +	u64 tmp;
> +
> +	/*
> +	 * This cannot overflow because,
> +	 * 2^32 * 2^10 (prescalar) * 10^6 (rate_khz) < 2^64

I find the notation here hard to parse. I personally would prefer:

  /*
   * The calculation doesn't overflow an u64 because prescale =E2=89=A4 5 a=
nd so
   * tmp =3D val << (2 * prescale) * USEC_PER_SEC
   *     < 2^32 * 2^10 * 10^6
   *     < 2^32 * 2^10 * 2^20
   *     =3D 2^62
   */

Is it only me?

> +	 */
> +	tmp =3D (u64)val << (2 * prescale);
> +	tmp *=3D USEC_PER_SEC;
> +
> +	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
> +}
> +
> +static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	int rc;
> +
> +	rc =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> +	if (rc)
> +		return rc;
> +
> +	state->enabled =3D rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
> +	if (state->enabled) {
> +		u32 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +		u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +		u8 prescale;
> +		u32 val;
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
> +		prescale =3D FIELD_GET(RZG2L_GTCR_TPCS, val);

Can it happen that prescale is > 5 here?

> +		val =3D rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTPR);
> +		state->period =3D calculate_period_or_duty(rzg2l_gpt, val, prescale);
> +
> +		val =3D rzg2l_gpt_read(rzg2l_gpt,
> +				     offs + RZG2L_GTCCR(rzg2l_gpt_subchannel(pwm->hwpwm)));
> +		state->duty_cycle =3D calculate_period_or_duty(rzg2l_gpt, val, prescal=
e);
> +		if (state->duty_cycle > state->period)
> +			state->duty_cycle =3D state->period;
> +	}
> +
> +	state->polarity =3D PWM_POLARITY_NORMAL;
> +	pm_runtime_put(pwmchip_parent(chip));
> +
> +	return 0;
> +}
> +
> +static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 pre=
scale)
> +{
> +	return min_t(u64, (period_or_duty_cycle + (1 << (2 * prescale)) - 1) >>=
 (2 * prescale),
> +		     U32_MAX);
> +}
> +
> +/* Caller holds the lock while calling rzg2l_gpt_config() */
> +static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pw=
m,
> +			    const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u64 period, duty_cycle, period_cycles, duty_cycles;
> +	u8 ch =3D RZG2L_GET_CH(pwm->hwpwm);
> +	u32 offs =3D RZG2L_GET_CH_OFFS(ch);
> +	unsigned long pv, dc;
> +	u8 prescale;
> +
> +	/* Limit period/duty cycle to max value supported by the HW */
> +	period =3D min(state->period, rzg2l_gpt->max_val);
> +	period_cycles =3D mul_u64_u64_div_u64(period, rzg2l_gpt->rate_khz, USEC=
_PER_SEC);
> +
> +	/*
> +	 * GPT counter is shared by multiple channels, so prescale and period
> +	 * can NOT be modified when there are multiple channels in use with
> +	 * different settings.
> +	 */
> +	if (rzg2l_gpt->user_count[ch] > 1 && period_cycles < rzg2l_gpt->period_=
cycles[ch])
> +		return -EBUSY;
> +
> +	prescale =3D rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
> +	pv =3D rzg2l_gpt_calculate_pv_or_dc(period_cycles, prescale);
> +
> +	duty_cycle =3D min(state->duty_cycle, rzg2l_gpt->max_val);
> +	duty_cycles =3D mul_u64_u64_div_u64(duty_cycle, rzg2l_gpt->rate_khz, US=
EC_PER_SEC);

These two variable names are too similar. One is in nano seconds, the
other in hw ticks. Maybe rename the latter to duty_ticks, or duty_count.

> +	dc =3D rzg2l_gpt_calculate_pv_or_dc(duty_cycles, prescale);

If you use mul_u64_u64_div_u64() anyhow you can implement the check if
the value is too big later, that is:

	#define RZG2L_MAX_TICKS ((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR) /* is this=
 right?  */
	...
	duty_ticks =3D mul_u64_u64_div_u64(state->duty_cycle, rzg2l_gpt->rate_khz,=
 USEC_PER_SEC);
	if (duty_ticks > RZG2L_MAX_TICKS)
		duty_ticks =3D RZG2L_MAX_TICKS;

Then you could get rid of .max_val I think.

> +	/*
> +	 * GPT counter is shared by multiple channels, we cache the period cycl=
es
> +	 * from the first enabled channel and use the same value for both
> +	 * channels.
> +	 */
> +	rzg2l_gpt->period_cycles[ch] =3D period_cycles;
> +
> +	/*
> +	 * Counter must be stopped before modifying mode, prescaler, timer
> +	 * counter and buffer enable registers. These registers are shared
> +	 * between both channels. So allow updating these registers only for the
> +	 * first enabled channel.
> +	 */
> +	if (rzg2l_gpt->enable_count[ch] <=3D 1) {
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST, 0);

Maybe instead of using the local variable offs introduce a helper =C3=A0 la:

	static void rzg2l_gpt_ch_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u8 ch, u=
32 reg, u32 clr, u32 set)
	{
		u32 offs =3D RZG2L_GET_CH_OFFS(ch);

		rrzg2l_gpt_modify(rzg2l_gpt, offs + reg, clr, set);
	}

or define RZG2L_GTCR as:

	#define RZG2L_GTCR(ch)	(RZG2L_GET_CH_OFFS(ch) + 0x2c)

=2E I think I like the latter better.

For RZG2L_GTCCR (which depends on channel and subchannel) maybe pass
hwpwm as macro parameter. (It's a bit ugly to have different parameters
for different register offsets, but passing hwpwm if only the channel
matters is also strange. Hmm, unsure; your chance to have a strong
opinion :-)

> +		/* GPT set operating mode (saw-wave up-counting) */
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_MD,
> +				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
> +
> +		/* Set count direction */
> +		rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTUDDTYC, RZG2L_GTUDDTYC);
> +
> +		/* Select count clock */
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_TPCS,
> +				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> +
> +		/* Set period */
> +		rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTPR, pv);
> +	}
> +
> +	/* Set duty cycle */
> +	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCCR(rzg2l_gpt_subchannel(pwm-=
>hwpwm)),
> +			dc);
> +
> +	if (rzg2l_gpt->enable_count[ch] <=3D 1) {
> +		/* Set initial value for counter */
> +		rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCNT, 0);
> +
> +		/* Set no buffer operation */
> +		rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTBER, 0);
> +
> +		/* Restart the counter after updating the registers */
> +		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR,
> +				 RZG2L_GTCR_CST, RZG2L_GTCR_CST);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	bool enabled =3D pwm->state.enabled;
> +	int ret;
> +
> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> +		return -EINVAL;
> +
> +	if (!state->enabled) {
> +		if (enabled) {
> +			/*
> +			 * Probe() sets bootloader_enabled_channels. In such case,
> +			 * clearing the flag will avoid errors during unbind.
> +			 */
> +			if (rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm])
> +				rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D 0;
> +
> +			rzg2l_gpt_disable(rzg2l_gpt, pwm);
> +			pm_runtime_put_sync(pwmchip_parent(chip));
> +		}
> +
> +		return 0;
> +	}
> +
> +	if (rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm]) {
> +		/*
> +		 * it's already be on. Instead of reenabling in hardware
> +		 * just take over from the bootloader
> +		 */
> +		rzg2l_gpt->bootloader_enabled_channels[pwm->hwpwm] =3D 0;

If .apply() is called, bootloader_enabled_channels[pwm->hwpwm] is
certainly 0 afterwards, right? I think this means it could be
simplified by only handling bootloader_enabled_channels[pwm->hwpwm] =3D=3D
true in a single place?!

> +	} else {
> +		if (!enabled) {
> +			ret =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	mutex_lock(&rzg2l_gpt->lock);
> +	ret =3D rzg2l_gpt_config(chip, pwm, state);
> +	mutex_unlock(&rzg2l_gpt->lock);
> +	if (ret)
> +		goto err_pm_runtime_put;

So if rzg2l_gpt_config() fails you call pm_runtime_put_sync(). But the
next time .apply() is called we might still have pwm->state.enabled =3D=3D
true and so assume we're still holding a pm_runtime reference. That's a
bug, right?

> +
> +	if (!enabled) {
> +		ret =3D rzg2l_gpt_enable(rzg2l_gpt, pwm);
> +		if (ret)
> +			goto err_pm_runtime_put;
> +	}
> +
> +	return 0;
> +
> +err_pm_runtime_put:
> +	pm_runtime_put_sync(pwmchip_parent(chip));
> +	return ret;
> +}
> +
> +static const struct pwm_ops rzg2l_gpt_ops =3D {
> +	.request =3D rzg2l_gpt_request,
> +	.free =3D rzg2l_gpt_free,
> +	.get_state =3D rzg2l_gpt_get_state,
> +	.apply =3D rzg2l_gpt_apply,
> +};
> +
> +static void rzg2l_gpt_reset_assert(void *data)
> +{
> +	struct pwm_chip *chip =3D data;
> +	struct rzg2l_gpt_chip *rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +	u32 i;
> +
> +	/*
> +	 * The below check is for making balanced PM usage count
> +	 * eg: boot loader is turning on PWM and probe increments the PM usage
> +	 * count. Before apply, if there is unbind/remove callback we need to
> +	 * decrement the PM usage count.
> +	 */
> +	for (i =3D 0; i < chip->npwm; i++) {
> +		if (rzg2l_gpt->bootloader_enabled_channels[i])
> +			pm_runtime_put(pwmchip_parent(chip));
> +	}
> +
> +	reset_control_assert(rzg2l_gpt->rstc);
> +}

If you split this in two cleanups, and register the one for
reset_control_assert(rzg2l_gpt->rstc) earlier in .probe() the error
handling there gets easier. This would also simplify conversion to=20
devm_reset_control_get_exclusive_deasserted() once that lands in
mainline.

> +static int rzg2l_gpt_probe(struct platform_device *pdev)
> +{
> +	struct rzg2l_gpt_chip *rzg2l_gpt;
> +	struct device *dev =3D &pdev->dev;
> +	struct pwm_chip *chip;
> +	unsigned long rate;
> +	struct clk *clk;
> +	int ret;
> +	u32 i;
> +
> +	chip =3D devm_pwmchip_alloc(dev, RZG2L_MAX_PWM_CHANNELS, sizeof(*rzg2l_=
gpt));
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	rzg2l_gpt =3D to_rzg2l_gpt_chip(chip);
> +
> +	rzg2l_gpt->mmio =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(rzg2l_gpt->mmio))
> +		return PTR_ERR(rzg2l_gpt->mmio);
> +
> +	rzg2l_gpt->rstc =3D devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(rzg2l_gpt->rstc))
> +		return dev_err_probe(dev, PTR_ERR(rzg2l_gpt->rstc),
> +				     "get reset failed\n");
> +
> +	clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "cannot get clock\n");
> +
> +	ret =3D reset_control_deassert(rzg2l_gpt->rstc);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
> +
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret)
> +		goto err_reset;
> +
> +	ret =3D pm_runtime_resume_and_get(dev);
> +	if (ret)
> +		goto err_reset;
> +
> +	ret =3D devm_clk_rate_exclusive_get(dev, clk);
> +	if (ret)
> +		goto err_pm_put;
> +
> +	rate =3D clk_get_rate(clk);
> +	if (!rate) {
> +		ret =3D dev_err_probe(dev, -EINVAL, "gpt clk rate is 0");
> +		goto err_pm_put;
> +	}
> +
> +	/*
> +	 * Refuse clk rates > 1 GHz to prevent overflow later for computing
> +	 * period and duty cycle.
> +	 */
> +	if (rate > NSEC_PER_SEC) {
> +		ret =3D dev_err_probe(dev, -EINVAL, "gpt clk rate is > 1GHz");
> +		goto err_pm_put;
> +	}
> +
> +	/*
> +	 * Rate is in MHz and is always integer for peripheral clk
> +	 * 2^32 * 2^10 (prescalar) * 10^6 (rate_khz) < 2^64
> +	 * So make sure rate is multiple of 1000.
> +	 */
> +	rzg2l_gpt->rate_khz =3D rate / KILO;
> +	if (rzg2l_gpt->rate_khz * KILO !=3D rate) {
> +		ret =3D dev_err_probe(dev, -EINVAL, "rate is not multiple of 1000");
> +		goto err_pm_put;
> +	}
> +
> +	rzg2l_gpt->max_val =3D div64_u64((u64)U32_MAX * USEC_PER_SEC,
> +				       rzg2l_gpt->rate_khz) * RZG2L_MAX_SCALE_FACTOR;

This might loose precision (not entirely sure this is relevant, still
more if you drop .max_val as suggested above).

> +
> +	/*
> +	 *  We need to keep the clock on, in case the bootloader has enabled the
> +	 *  PWM and is running during probe().
> +	 */
> +	for (i =3D 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
> +		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i)) {
> +			u8 ch =3D RZG2L_GET_CH(i);
> +
> +			rzg2l_gpt->bootloader_enabled_channels[i] =3D 1;
> +			rzg2l_gpt->enable_count[ch]++;
> +			pm_runtime_get_sync(dev);
> +		}
> +	}
> +
> +	pm_runtime_put(dev);
> +
> +	mutex_init(&rzg2l_gpt->lock);
> +	ret =3D devm_add_action_or_reset(dev, rzg2l_gpt_reset_assert, chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->ops =3D &rzg2l_gpt_ops;
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
> +
> +	return 0;
> +
> +err_pm_put:
> +	pm_runtime_put(dev);

A guard (=C3=A0 la guard(pm_runtime_resume)(dev), similar to the guards for
mutexes and spinlocks) would be elegant here and simplify error
handling. (Only if you're motivated, I wouldn't make this a precondition
for accepting your driver.)

> +err_reset:
> +	reset_control_assert(rzg2l_gpt->rstc);
> +	return ret;
> +}
> +
> +static const struct of_device_id rzg2l_gpt_of_table[] =3D {
> +	{ .compatible =3D "renesas,rzg2l-gpt", },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
> +
> +static struct platform_driver rzg2l_gpt_driver =3D {
> +	.driver =3D {
> +		.name =3D "pwm-rzg2l-gpt",
> +		.of_match_table =3D rzg2l_gpt_of_table,
> +	},
> +	.probe =3D rzg2l_gpt_probe,
> +};
> +module_platform_driver(rzg2l_gpt_driver);
> +
> +MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--p4gq5fistn4p4sfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmapROQACgkQj4D7WH0S
/k7cDgf/btNMkkX8HNorHYY0i1fjB171yfe8l/lJL/qFdHmwlWkgsfIGptDahlV/
0wggCKgqZDzBzlpkdheWllHW6A1Sjkl7RvNt+j8cpKoCfEr6sY2Q3yqOrvqwwLvv
fbXybsfvw56VoSRKMbZjTJ1R37gRKB5qDg0GgggLTH+plg97+zA42P/fGRdaqc8u
knUmQbr6KRyVLtPbbcwuRCMTS2Zwt0kD1whFastphN5BuLEP3jt+UmTNstP7Vbt6
4VFuYh3ne2oOOdvVzqVjvHzN8rZFZSZmZwtDLFrsXYwApk68AvlPVlmr4coLrPik
NUAB90WHuzaYiUJNTUZqMbLPs1//UQ==
=0KxX
-----END PGP SIGNATURE-----

--p4gq5fistn4p4sfb--

