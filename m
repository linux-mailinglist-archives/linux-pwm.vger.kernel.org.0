Return-Path: <linux-pwm+bounces-4673-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E9FA15D96
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 16:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E673A2C33
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9024192D83;
	Sat, 18 Jan 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsygUyIa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE25188015;
	Sat, 18 Jan 2025 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737213039; cv=none; b=Z+5q7aQlQ90WNeB8pyZcaN+VWipllVinsqn9MpPrhgInSy7+B4odDM5mjCZ8VAR2kNLXnZhdttmrRhLqQ+53AIATR6M9YE1P3qQjgufdVLWiUzHHXTm4RS+T0yuBoy51ti1XJjYmOVhxuG2uV0UpPhTnGeqaJeVqRXT3uRfPxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737213039; c=relaxed/simple;
	bh=+XclBhJM7aSHIdnBN8L+1ehLdMmgIfzBqBeiYaM4rpI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNVmPDrOHYcorTDQcVoTRHcxgRYWCuIPPPPSFaq3yDrdwvFI/B0e76ce5mzKcU1406H+bqdS8YjPIhI1joipZbFqhJmWtkaZUjZDCyMJiVJdL956YyfQnPc2cC0eb+QdE/iu+uaH69ESwEQFkbL2SPoCFnKlya2KPC00Z9bl6co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsygUyIa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4363ae65100so32381025e9.0;
        Sat, 18 Jan 2025 07:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737213035; x=1737817835; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txK+fcD8QVAXKwWXWHLSr3eBD2v8Xauzh2LcdSoWEqM=;
        b=AsygUyIaWO6QbSPnsIXlbA+egcf1vjv5wqIikmfw6wZM3EJd3SwGkXcoX+d6eMcGSB
         ClrSe7+8ZpDl6H4TKo4AsD1dnVsaWKb5rDJTljyeiy7gVWfLaZYf8fJVqRPnQPIUviHl
         tVlTXiCU2zfFqDA+G0F8WM9vjkwioTF9bzQvOlEPWKHct52zV5gSLD9d3US6RIBMqWTP
         cyDYwCd53Of2AUc/7d078vSVvxCSgnDj2XqgLCLZWjSYhWYdBa9PLfXAYnLtUUFQJpLt
         QHT3reeAbPYKCK4m4owGFm1p8uG9u83Z4P+2fWrUF1tq/clIUuGqLnZVuY9sbmVfcqo+
         keBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737213035; x=1737817835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txK+fcD8QVAXKwWXWHLSr3eBD2v8Xauzh2LcdSoWEqM=;
        b=Gook++jifPLohoc3ie2ahtgofi+CpT85JcK/8nXaeuRA7T9QtQ1xNiv1reM6yP29PV
         823k2cOJVm6VprmINZNoj5Wbm0s8Z4WEiUfIHp1Af4bk4PEHUMNdeHeBCs4Vl422LzP0
         PvsNBI2IqZyyOcovjwVYoUfh8qjNoYdLnFJBEgr9LjTRJ93ckZhRoPrx7M1C1r8BOYgN
         3aWR9uWlQrCyI0bHtbz4RyAulrW3eimo42Ntv0FB0aCwhDtgosRykST9qU53ky7qc9J6
         yjSTXPe7LDCzGrmrtjVfhgPCPS9QpDCe8JdrZQTD3/j1a+fBjf4EUK6cR5muojgQuxaD
         vDjw==
X-Forwarded-Encrypted: i=1; AJvYcCUiHXEO5Vku6Rox1GykKQEPWdnbmAfOWIPQ67imjssjCL/h8H93c51yhnxyz7wfhxTQ0U7OL9OQaYD3@vger.kernel.org, AJvYcCUtVuCQkGTmQLI/iliQsLgOXL7OWxbpdTCclYxIyG8JEwza82SzIar+TpClPbCk5g4cCxGyzUJuAFpf@vger.kernel.org, AJvYcCWjWC04PevOvEiNUWAGTjDmP1iK87xYDzXliAvsTx9vhvO/kdm28aodPWG9MQjer49CN6UZOgk5LsN5@vger.kernel.org, AJvYcCX34kmH8PVfp83Y0m4TVJs6TmhDkQIQL8vXlucN6tl4x+NVTpO0VJuIU2Lr6tFqWXx5OjfS/urfyBiP7no4@vger.kernel.org
X-Gm-Message-State: AOJu0YyflIfDukVouEugjFBVCg+lRkh2LW7CQvJaCuZ9jjLzhiu/+Mk7
	xD5mID5L9YPHhRp1ejuEHoOeSWdtBUntQzL17rBUB69oW77/ZzGw
X-Gm-Gg: ASbGncu2XJQRldUhvKCNl7eBHchfjIjeQsc+/GJmuDki5fUm7yk0XV+8oS1Jy0BL7jB
	8oJa/EHkqGEj50wSBPLU6qA+IsYLa4A30KX3OVNOxl6zFo587RLlTevS7zaO+VwnwktW34K9b+Q
	ZgucXCv0LJbf072lRcgYWV1fQ9bRLjP8PNVioB0OQXWsm5Cv8tqLmA9q2l+hR13EHQBSZ4jrK72
	sPnQ4mPJhYpCklJLxfDf52noNS5ROCRhCPfWf8+BM1zYx4iTuaonmv80Zx8iq+RgqzPZ73PHSio
	IJ6gakpxVpxCSg3LxCG1jmvevXUctlOhIR8owFCItg==
X-Google-Smtp-Source: AGHT+IHKoN8WpXWfvQj/ffB2AqGvM0TDGp9YqspjQ7bYUQFE1rmeZCjGnizvdPojx5klemTfLw5g3Q==
X-Received: by 2002:a05:600c:1554:b0:434:fbe2:4f with SMTP id 5b1f17b1804b1-4389143b41fmr64212245e9.23.1737213034860;
        Sat, 18 Jan 2025 07:10:34 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904087cbsm72574905e9.3.2025.01.18.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 07:10:34 -0800 (PST)
Message-ID: <a45c60fe9fff0f517032a7e9eb3881cf340a8c1e.camel@gmail.com>
Subject: Re: [PATCH v10 8/8] iio: adc: ad4851: add ad485x driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Date: Sat, 18 Jan 2025 15:10:39 +0000
In-Reply-To: <20250117130702.22588-9-antoniu.miclaus@analog.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
	 <20250117130702.22588-9-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-17 at 15:07 +0200, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v10:
> =C2=A0- use u64 for scale_tbl cast.
> =C2=A0- use IIO_VAL_FRACTIONAL_LOG2
> =C2=A0- add comment for not using bulk_read
> =C2=A0- use _u and _b suffix for scan_type structures.
> =C2=A0- add comment for not setting scan_type in macro definitions.
> =C2=A0- fix some wrapping.
> =C2=A0- rework vrefbuf_en and vrefio_en handling.
> =C2=A0- add depends on PWM in Kconfig
> =C2=A0- add unipolar/bipolar suffix where requested.
> =C2=A0- rename REFSEL REFBUF macros.
> =C2=A0- use indio_dev->channels[i].channel for iio_backend_chan_enable
> =C2=A0- drop initialization for 'buf'
> =C2=A0- use st->bipolar_ch[chan->channel], not chan->differential
> =C2=A0- use u32 for softspan_val
> =C2=A0- move info_mask_separate above as suggested.
> =C2=A0- handle sign in parse channel function and use `u` as default in m=
acro.
> =C2=A0- check `reg` range.
> =C2=A0- use fwnode_property_read_bool
> =C2=A0- drop redundant `reg` parsing
> =C2=A0- rework channel2 statement in channel macro and parse_channels.
> =C2=A0- set ad4851_channels->has_ext_scan_type =3D 1
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 14 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4851.c | 1293 +++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 1308 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad4851.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..afd83fddda76 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -61,6 +61,20 @@ config AD4695
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will be
> =C2=A0	=C2=A0 called ad4695.
> =C2=A0
> +config AD4851
> +	tristate "Analog Device AD4851 DAS Driver"
> +	depends on SPI
> +	depends on PWM
> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD4851, AD4852,
> +	=C2=A0 AD4853, AD4854, AD4855, AD4856, AD4857, AD4858, AD4858I high spe=
ed
> +	=C2=A0 data acquisition system (DAS).
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll be
> +	=C2=A0 called ad4851.
> +
> =C2=A0config AD7091R
> =C2=A0	tristate
> =C2=A0
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ee19afba62b7..e4d8ba12f841 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> =C2=A0obj-$(CONFIG_AD4000) +=3D ad4000.o
> =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> =C2=A0obj-$(CONFIG_AD4695) +=3D ad4695.o
> +obj-$(CONFIG_AD4851) +=3D ad4851.o
> =C2=A0obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
> =C2=A0obj-$(CONFIG_AD7091R5) +=3D ad7091r5.o
> =C2=A0obj-$(CONFIG_AD7091R8) +=3D ad7091r8.o
> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> new file mode 100644
> index 000000000000..a39d863bf62d
> --- /dev/null
> +++ b/drivers/iio/adc/ad4851.c
> @@ -0,0 +1,1293 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD4851 DAS driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +

...

> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +
> +#define AD4851_REG_INTERFACE_CONFIG_A	0x00
> +#define AD4851_REG_INTERFACE_CONFIG_B	0x01
> +#define AD4851_REG_PRODUCT_ID_L		0x04
> +#define AD4851_REG_PRODUCT_ID_H		0x05
> +#define AD4851_REG_DEVICE_CTRL		0x25
> +#define AD4851_REG_PACKET		0x26
> +#define AD4851_REG_OVERSAMPLE		0x27
> +
> +#define AD4851_REG_CH_CONFIG_BASE	0x2A
> +#define AD4851_REG_CHX_SOFTSPAN(ch)	((0x12 * (ch)) +
> AD4851_REG_CH_CONFIG_BASE)
> +#define AD4851_REG_CHX_OFFSET(ch)	(AD4851_REG_CHX_SOFTSPAN(ch) + 0x01)
> +#define AD4851_REG_CHX_OFFSET_LSB(ch)	AD4851_REG_CHX_OFFSET(ch)
> +#define AD4851_REG_CHX_OFFSET_MID(ch)	(AD4851_REG_CHX_OFFSET_LSB(ch) + 0=
x01)
> +#define AD4851_REG_CHX_OFFSET_MSB(ch)	(AD4851_REG_CHX_OFFSET_MID(ch) + 0=
x01)
> +#define AD4851_REG_CHX_GAIN(ch)		(AD4851_REG_CHX_OFFSET(ch) + 0x03)
> +#define AD4851_REG_CHX_GAIN_LSB(ch)	AD4851_REG_CHX_GAIN(ch)
> +#define AD4851_REG_CHX_GAIN_MSB(ch)	(AD4851_REG_CHX_GAIN(ch) + 0x01)
> +#define AD4851_REG_CHX_PHASE(ch)	(AD4851_REG_CHX_GAIN(ch) + 0x02)
> +#define AD4851_REG_CHX_PHASE_LSB(ch)	AD4851_REG_CHX_PHASE(ch)
> +#define AD4851_REG_CHX_PHASE_MSB(ch)	(AD4851_REG_CHX_PHASE_LSB(ch) + 0x0=
1)
> +
> +#define AD4851_REG_TESTPAT_0(c)		(0x38 + (c) * 0x12)
> +#define AD4851_REG_TESTPAT_1(c)		(0x39 + (c) * 0x12)
> +#define AD4851_REG_TESTPAT_2(c)		(0x3A + (c) * 0x12)
> +#define AD4851_REG_TESTPAT_3(c)		(0x3B + (c) * 0x12)
> +
> +#define AD4851_SW_RESET			(BIT(7) | BIT(0))
> +#define AD4851_SDO_ENABLE		BIT(4)
> +#define AD4851_SINGLE_INSTRUCTION	BIT(7)
> +#define AD4851_REFBUF			BIT(2)
> +#define AD4851_REFSEL			BIT(1)
> +#define AD4851_ECHO_CLOCK_MODE		BIT(0)
> +
> +#define AD4851_PACKET_FORMAT_0		0
> +#define AD4851_PACKET_FORMAT_1		1
> +#define AD4851_PACKET_FORMAT_MASK	GENMASK(1, 0)
> +
> +#define AD4851_OS_EN_MSK		BIT(7)
> +#define AD4851_OS_RATIO_MSK		GENMASK(3, 0)
> +
> +#define AD4851_TEST_PAT			BIT(2)
> +
> +#define AD4858_PACKET_SIZE_20		0
> +#define AD4858_PACKET_SIZE_24		1
> +#define AD4858_PACKET_SIZE_32		2
> +
> +#define AD4857_PACKET_SIZE_16		0
> +#define AD4857_PACKET_SIZE_24		1
> +
> +#define AD4851_TESTPAT_0_DEFAULT	0x2A
> +#define AD4851_TESTPAT_1_DEFAULT	0x3C
> +#define AD4851_TESTPAT_2_DEFAULT	0xCE
> +#define AD4851_TESTPAT_3_DEFAULT(c)	(0x0A + (0x10 * (c)))
> +
> +#define AD4851_SOFTSPAN_0V_2V5		0
> +#define AD4851_SOFTSPAN_N2V5_2V5	1
> +#define AD4851_SOFTSPAN_0V_5V		2
> +#define AD4851_SOFTSPAN_N5V_5V		3
> +#define AD4851_SOFTSPAN_0V_6V25		4
> +#define AD4851_SOFTSPAN_N6V25_6V25	5
> +#define AD4851_SOFTSPAN_0V_10V		6
> +#define AD4851_SOFTSPAN_N10V_10V	7
> +#define AD4851_SOFTSPAN_0V_12V5		8
> +#define AD4851_SOFTSPAN_N12V5_12V5	9
> +#define AD4851_SOFTSPAN_0V_20V		10
> +#define AD4851_SOFTSPAN_N20V_20V	11
> +#define AD4851_SOFTSPAN_0V_25V		12
> +#define AD4851_SOFTSPAN_N25V_25V	13
> +#define AD4851_SOFTSPAN_0V_40V		14
> +#define AD4851_SOFTSPAN_N40V_40V	15
> +
> +#define AD4851_MAX_LANES		8
> +#define AD4851_MAX_IODELAY		32
> +
> +#define AD4851_T_CNVH_NS		40
> +#define AD4851_T_CNVH_NS_MARGIN		10
> +
> +#define AD4841_MAX_SCALE_AVAIL		8
> +
> +#define AD4851_MAX_CH_NR		8
> +#define AD4851_CH_START			0
> +
> +struct ad4851_scale {
> +	unsigned int scale_val;
> +	u8 reg_val;
> +};
> +
> +static const struct ad4851_scale ad4851_scale_table_unipolar[] =3D {
> +	{ 2500, 0x0 },
> +	{ 5000, 0x2 },
> +	{ 6250, 0x4 },
> +	{ 10000, 0x6 },
> +	{ 12500, 0x8 },
> +	{ 20000, 0xA },
> +	{ 25000, 0xC },
> +	{ 40000, 0xE },
> +};
> +
> +static const struct ad4851_scale ad4851_scale_table_bipolar[] =3D {
> +	{ 5000, 0x1 },
> +	{ 10000, 0x3 },
> +	{ 12500, 0x5 },
> +	{ 20000, 0x7 },
> +	{ 25000, 0x9 },
> +	{ 40000, 0xB },
> +	{ 50000, 0xD },
> +	{ 80000, 0xF },
> +};
> +
> +static const unsigned int ad4851_scale_avail_unipolar[] =3D {
> +	2500,
> +	5000,
> +	6250,
> +	10000,
> +	12500,
> +	20000,
> +	25000,
> +	40000,
> +};
> +
> +static const unsigned int ad4851_scale_avail_bipolar[] =3D {
> +	5000,
> +	10000,
> +	12500,
> +	20000,
> +	25000,
> +	40000,
> +	50000,
> +	80000,
> +};
> +
> +struct ad4851_chip_info {
> +	const char *name;
> +	unsigned int product_id;
> +	int num_scales;
> +	unsigned long max_sample_rate_hz;
> +	unsigned int resolution;
> +	int (*parse_channels)(struct iio_dev *indio_dev);
> +};
> +
> +enum {
> +	AD4851_SCAN_TYPE_NORMAL,
> +	AD4851_SCAN_TYPE_RESOLUTION_BOOST,
> +};
> +
> +struct ad4851_state {
> +	struct spi_device *spi;
> +	struct pwm_device *cnv;
> +	struct iio_backend *back;
> +	/*
> +	 * Synchronize access to members the of driver state, and ensure
> +	 * atomicity of consecutive regmap operations.
> +	 */
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	const struct ad4851_chip_info *info;
> +	struct gpio_desc *pd_gpio;
> +	bool resolution_boost_enabled;
> +	unsigned long cnv_trigger_rate_hz;
> +	unsigned int osr;
> +	bool vrefbuf_en;
> +	bool vrefio_en;
> +	bool bipolar_ch[AD4851_MAX_CH_NR];
> +	unsigned int scales_unipolar[AD4841_MAX_SCALE_AVAIL][2];
> +	unsigned int scales_bipolar[AD4841_MAX_SCALE_AVAIL][2];
> +};
> +
> +static int ad4851_reg_access(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int writeval,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *readval)
> +{
> +	struct ad4851_state *st =3D iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +

no need for the above lock. I guess you're not disabling regmap internal lo=
ck...

> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +

...

>=20
> +static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 unsigned int osr)
> +{
> +	struct ad4851_state *st =3D iio_priv(indio_dev);
> +	int val, ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (osr =3D=3D 1) {
> +		ret =3D regmap_clear_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;
> +	} else {
> +		val =3D ad4851_osr_to_regval(osr);
> +		if (val < 0)
> +			return -EINVAL;
> +
> +		ret =3D regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_EN_MSK |
> +					 AD4851_OS_RATIO_MSK,
> +					 FIELD_PREP(AD4851_OS_EN_MSK, 1) |
> +					 FIELD_PREP(AD4851_OS_RATIO_MSK, val));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D iio_backend_oversampling_ratio_set(st->back, osr);
> +	if (ret)
> +		return ret;
> +
> +	switch (st->info->resolution) {
> +	case 20:
> +		switch (osr) {
> +		case 0:
> +			return -EINVAL;
> +		case 1:
> +			val =3D 20;
> +			break;
> +		default:
> +			val =3D 24;
> +			break;
> +		}
> +		break;
> +	case 16:
> +		val =3D 16;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret =3D iio_backend_data_size_set(st->back, val);
> +	if (ret)
> +		return ret;
> +
> +	if (osr =3D=3D 1 || st->info->resolution =3D=3D 16) {
> +		ret =3D regmap_clear_bits(st->regmap, AD4851_REG_PACKET,
> +					AD4851_PACKET_FORMAT_MASK);
> +		if (ret)
> +			return ret;
> +
> +		st->resolution_boost_enabled =3D false;
> +	} else {
> +		ret =3D regmap_update_bits(st->regmap, AD4851_REG_PACKET,
> +					 AD4851_PACKET_FORMAT_MASK,
> +					 FIELD_PREP(AD4851_PACKET_FORMAT_MASK,
> 1));
> +		if (ret)
> +			return ret;
> +
> +		st->resolution_boost_enabled =3D true;
> +	}
> +
> +	if (st->osr !=3D osr) {
> +		ret =3D ad4851_scale_fill(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		st->osr =3D osr;
> +	}

nit: I would instead do

if (st->osr =3D=3D osr)
    return 0;

...

> +
> +	return 0;
> +}
> +
> +static int ad4851_get_oversampling_ratio(struct ad4851_state *st, unsign=
ed int
> *val)
> +{
> +	unsigned int osr;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D regmap_read(st->regmap, AD4851_REG_OVERSAMPLE, &osr);
> +	if (ret)
> +		return ret;
> +
> +	if (!FIELD_GET(AD4851_OS_EN_MSK, osr))
> +		*val =3D 1;
> +	else
> +		*val =3D ad4851_oversampling_ratios[FIELD_GET(AD4851_OS_RATIO_MSK,
> osr) + 1];
> +
> +	st->osr =3D *val;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static void ad4851_pwm_disable(void *data)
> +{
> +	pwm_disable(data);
> +}
> +
> +static int ad4851_setup(struct ad4851_state *st)
> +{
> +	unsigned int product_id;
> +	int ret;
> +
> +	if (st->pd_gpio) {
> +		/* To initiate a global reset, bring the PD pin high twice */
> +		gpiod_set_value(st->pd_gpio, 1);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 0);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 1);
> +		fsleep(1);
> +		gpiod_set_value(st->pd_gpio, 0);
> +		fsleep(1000);
> +	} else {
> +		ret =3D regmap_set_bits(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4851_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vrefbuf_en) {
> +		ret =3D regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4851_REFBUF);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vrefio_en) {
> +		ret =3D regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4851_REFSEL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_B,
> +			=C2=A0=C2=A0 AD4851_SINGLE_INSTRUCTION);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +			=C2=A0=C2=A0 AD4851_SDO_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4851_REG_PRODUCT_ID_L, &product_id);
> +	if (ret)
> +		return ret;
> +
> +	if (product_id !=3D st->info->product_id)
> +		dev_info(&st->spi->dev, "Unknown product ID: 0x%02X\n",
> +			 product_id);
> +
> +	ret =3D regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD4851_ECHO_CLOCK_MODE);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_PACKET, 0);
> +}
> +
> +static int ad4851_find_opt(bool *field, u32 size, u32 *ret_start)
> +{
> +	unsigned int i, cnt =3D 0, max_cnt =3D 0, max_start =3D 0;
> +	int start;
> +
> +	for (i =3D 0, start =3D -1; i < size; i++) {
> +		if (field[i] =3D=3D 0) {
> +			if (start =3D=3D -1)
> +				start =3D i;
> +			cnt++;
> +		} else {
> +			if (cnt > max_cnt) {
> +				max_cnt =3D cnt;
> +				max_start =3D start;
> +			}
> +			start =3D -1;
> +			cnt =3D 0;
> +		}
> +	}
> +	/*
> +	 * Find the longest consecutive sequence of false values from field
> +	 * and return starting index.
> +	 */
> +	if (cnt > max_cnt) {
> +		max_cnt =3D cnt;
> +		max_start =3D start;
> +	}
> +
> +	if (!max_cnt)
> +		return -ENOENT;
> +
> +	*ret_start =3D max_start;
> +
> +	return max_cnt;
> +}
>=20

Your status seems to be a bitmap now, can you take a look in here and see i=
f you can
do something similar?

https://elixir.bootlin.com/linux/v6.12.6/source/drivers/iio/adc/ad9467.c#L6=
33

Anyways, look at the bitmap API. It might have helpers to make the above fu=
nction
simpler.

> +
> +static int ad4851_calibrate(struct iio_dev *indio_dev)
> +{
> +	struct ad4851_state *st =3D iio_priv(indio_dev);
> +	unsigned int opt_delay, num_lanes, delay, i, s, c;
> +	enum iio_backend_interface_type interface_type;
> +	DECLARE_BITMAP(pn_status, AD4851_MAX_LANES * AD4851_MAX_IODELAY);
> +	bool status;
> +	int ret;
> +
> +	ret =3D iio_backend_interface_type_get(st->back, &interface_type);
> +	if (ret)
> +		return ret;
> +
> +	switch (interface_type) {
> +	case IIO_BACKEND_INTERFACE_SERIAL_CMOS:
> +		num_lanes =3D indio_dev->num_channels;
> +		break;
> +	case IIO_BACKEND_INTERFACE_SERIAL_LVDS:
> +		num_lanes =3D 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (st->info->resolution =3D=3D 16) {
> +		ret =3D iio_backend_data_size_set(st->back, 24);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(st->regmap, AD4851_REG_PACKET,
> +				=C2=A0=C2=A0 AD4851_TEST_PAT | AD4857_PACKET_SIZE_24);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D iio_backend_data_size_set(st->back, 32);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(st->regmap, AD4851_REG_PACKET,
> +				=C2=A0=C2=A0 AD4851_TEST_PAT | AD4858_PACKET_SIZE_32);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i =3D 0; i < indio_dev->num_channels; i++) {
> +		ret =3D regmap_write(st->regmap, AD4851_REG_TESTPAT_0(i),
> +				=C2=A0=C2=A0 AD4851_TESTPAT_0_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(st->regmap, AD4851_REG_TESTPAT_1(i),
> +				=C2=A0=C2=A0 AD4851_TESTPAT_1_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(st->regmap, AD4851_REG_TESTPAT_2(i),
> +				=C2=A0=C2=A0 AD4851_TESTPAT_2_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(st->regmap, AD4851_REG_TESTPAT_3(i),
> +				=C2=A0=C2=A0 AD4851_TESTPAT_3_DEFAULT(i));
> +		if (ret)
> +			return ret;
> +
> +		ret =3D iio_backend_chan_enable(st->back,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->channels[i].channel);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i =3D 0; i < num_lanes; i++) {
> +		for (delay =3D 0; delay < AD4851_MAX_IODELAY; delay++) {
> +			ret =3D iio_backend_iodelay_set(st->back, i, delay);
> +			if (ret)
> +				return ret;
> +
> +			ret =3D iio_backend_chan_status(st->back, i, &status);
> +			if (ret)
> +				return ret;
> +
> +			if (status)
> +				set_bit(i * AD4851_MAX_IODELAY + delay,
> pn_status);
> +			else
> +				clear_bit(i * AD4851_MAX_IODELAY + delay,
> pn_status);
> +		}

you can use the lighter forms __set_bit()/__clear_bit(). But going one step=
 further,
maybe __assign_bit()?

> +	}
> +
> +	for (i =3D 0; i < num_lanes; i++) {
> +		status =3D test_bit(i * AD4851_MAX_IODELAY, pn_status);
> +		c =3D ad4851_find_opt(&status, AD4851_MAX_IODELAY, &s);

status is just a bool and it seems your iterating on it? Am I missing somet=
hing?

> +		if (c < 0)
> +			return c;
> +
> +		opt_delay =3D s + c / 2;
> +		ret =3D iio_backend_iodelay_set(st->back, i, opt_delay);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i =3D 0; i < indio_dev->num_channels; i++) {
> +		ret =3D iio_backend_chan_disable(st->back, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D iio_backend_data_size_set(st->back, 20);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_PACKET, 0);
> +}
> +
>=20

...

> +static int ad4851_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 const struct iio_chan_spec *chan,
> +			=C2=A0=C2=A0 int *val, int *val2, long info)
> +{
> +	struct ad4851_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D st->cnv_trigger_rate_hz / st->osr;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4851_get_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4851_get_scale(indio_dev, chan, val, val2);

Maybe this was discussed already and I missed it but I'm a bit puzzled. Don=
't we
still need OFFSET for differential channels? How do you express negative vo=
ltages?

- Nuno S=C3=A1


