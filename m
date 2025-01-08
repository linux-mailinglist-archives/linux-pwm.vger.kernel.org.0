Return-Path: <linux-pwm+bounces-4556-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86767A06965
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 00:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682961673F2
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jan 2025 23:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6DC204C2C;
	Wed,  8 Jan 2025 23:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bMcKX2PZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4220408A
	for <linux-pwm@vger.kernel.org>; Wed,  8 Jan 2025 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736378689; cv=none; b=dopsZJTs64vK1xFTQd07rgIanWOl4wLQtgHU8H/uwxWoL2tFfXzZwN/yuGh73K85kEGgH+MR+rNF+N8ntN1Eg2JcLPJ186ZK289aVAymhySXhAmFbCaaWR4syo5wnVWDiUSe77LVz4VM6G5H0EFeNVzbYBPAAnJ8tUWBFNswskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736378689; c=relaxed/simple;
	bh=gkUW3b4I+YA+GoJ+oVp8A9Hccw2Ntj9ZvouOH7ZPuDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pB8edfjdCOUTdPmBwe5AkaKpL8UIUqeub9/JGhM0+cmLZ/OArnYgDJvqyAwaQE1S+3hNMPJ8KV+avSQrNH1bd/C4CbzQlIc3+NxKbdczVUxkfRF2RAiwqbLgO/N9s96u18AY/hWempURuLqkpSdxqCmipMiJrYSe2JrSfGRd1zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bMcKX2PZ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-721d213e2aeso94884a34.3
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jan 2025 15:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736378684; x=1736983484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nYRfQbT2y5EDiMCV8SZgEqV8gcN7eNUWBvXOJOWyXkU=;
        b=bMcKX2PZOO4W6bQHrr1siAJfxG0j8JSy2Dqy8LVwAJ3Oq6IHy3shuDD3bisqKjSaZf
         DU40Z9+zQ+bpG2HYp0QtvhWDySd3bbjGtveA1Jf/EHFF+tqiC6QfWzUIou+tk1vN0wgF
         xLQcjv0S6Yz2RQKvnjmU++ABArn6A94pMCgS9GIkPZBepouCqsdG0VmUuOdrSz0P1Ny5
         Kgu/ogd/L/TzhUF4DG2UphnPfEACLtKt9WsWLPMZCcMOuBgQVYibXrRZak4GbSllPAjx
         Q3zvpid+C3G6neM9SW/jvJBXXZ9UwC6CYlHAMVDIHlYvbl91JcKXwy/7diC6RZH+VssT
         GriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736378684; x=1736983484;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYRfQbT2y5EDiMCV8SZgEqV8gcN7eNUWBvXOJOWyXkU=;
        b=ee7ifn4fvqZsESW17Chp2ls+r0+uQkL+qhmlJfrb0MuF3E2jAADzuwfo7DMNkirhFD
         dC24CGb4rkrUsVoF/QWEsMupXzHADkAyeN3GKaX6MKt/Ol+DrZNJszqTRkVoRQ7Cf14s
         FmmgJr8BOJ4nmiDfzbZR0jQpjAzqgK5vgDcFBlq2P+luC8cXy1CXRoSzlNqa1F6ZKKWE
         8jAhiZxipAFbdCvhk6wqzzsAj9CO7SSCgLm6VLZS41qbSQ5j5Euhrf8qgxxG7Sk4tagx
         dLDdUTYycHnInAT474dpsQHXUEihzbRJ2PkLv9mwwbOO+zBBq/L2buy8n6XD1EIfQ7FQ
         axfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwfjukesKjOchmpC+khNzdtz9webA8kh92g8fHotl2EkeFfwyiv6tacwUzAoezQesxX6gYb4f0IZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRQSG+nFGZ2EfeTWjhl2vYQsCYqtaLeZ+SI1XjKfjQ/a/tZxrd
	BRh/oUR7lLtJlHAlwJpqpGG2WdNWUNGeO8reOZQvDBOUWS8yWCleGe1GY+38mms=
X-Gm-Gg: ASbGnctAW81pztKvkBugq1FZC7qrbM34K8QPcoBZTY2V204SSK28L8pJVMrxWoHH645
	5jMPyjQ7anwjEhrD5psbo8rh3jECtDFGy3Rv9AYhorfnMvneUGGWP1gzctOIUcaL7Nul0/aIoQx
	PoXDY2Qa+RSHnWrb1P9feDPfz+Qu7Z3qTJ5ExUUfFTkAuWjajUFvsGFqQeCMSjRqffrJjGLoHwi
	QzImcreFHRdCV3J9djmnqrPJK6YvAtsO+qL6TupEr0fCkRal9W5MhHNGKa2uUQBCVRubQGQfxhj
	k/FJpMdZbN3G7OP7yQ==
X-Google-Smtp-Source: AGHT+IEF+BpPGNeHMwx3mqdBrhx5W9hlcGQ+9PRmXsV4PlryxsaThNIpRV2jNu4NUUf3POOnoWXG7g==
X-Received: by 2002:a05:6830:d86:b0:710:fef4:3c92 with SMTP id 46e09a7af769-721e2ebdfcbmr3301717a34.21.1736378683886;
        Wed, 08 Jan 2025 15:24:43 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72318538268sm53282a34.9.2025.01.08.15.24.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 15:24:43 -0800 (PST)
Message-ID: <37fcda1c-0051-4a8c-b61c-583a1b8faa1e@baylibre.com>
Date: Wed, 8 Jan 2025 17:24:42 -0600
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/8] iio: adc: ad4851: add ad485x driver
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
 <20241220120134.42760-8-antoniu.miclaus@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20241220120134.42760-8-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 6:01 AM, Antoniu Miclaus wrote:
> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v9:
>  - add back diff-channels property parsing.
>  - shrink code in one line where possible.
>  - use struct device *dev = &st->spi->dev
>  - split elements that are assigned from those which aren't in the places
>    mentioned by the review.
>  - avoid code duplication on num_channels
>  - parse bipolar and diff-channels properties separately.
>  - update comment on parse_channels
>  - use devm_regulator_get_enable_optional for vrefbuf and vrefio
>  - add devm_add_action_or_reset(&st->spi->dev, ad4851_pwm_disable, st->cnv)
>    after the pwm is turned on.
>  drivers/iio/adc/Kconfig  |   13 +
>  drivers/iio/adc/Makefile |    1 +
>  drivers/iio/adc/ad4851.c | 1290 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1304 insertions(+)
>  create mode 100644 drivers/iio/adc/ad4851.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..00ef9ed289e9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -61,6 +61,19 @@ config AD4695
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4695.
>  
> +config AD4851
> +	tristate "Analog Device AD4851 DAS Driver"
> +	depends on SPI

The driver won't work without a PWM, so needs depends or select PWM here.

> +	select REGMAP_SPI
> +	select IIO_BACKEND
> +	help
> +	  Say yes here to build support for Analog Devices AD4851, AD4852,
> +	  AD4853, AD4854, AD4855, AD4856, AD4857, AD4858, AD4858I high speed
> +	  data acquisition system (DAS).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad4851.
> +
>  config AD7091R
>  	tristate
>  
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index ee19afba62b7..e4d8ba12f841 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
>  obj-$(CONFIG_AD4000) += ad4000.o
>  obj-$(CONFIG_AD4130) += ad4130.o
>  obj-$(CONFIG_AD4695) += ad4695.o
> +obj-$(CONFIG_AD4851) += ad4851.o
>  obj-$(CONFIG_AD7091R) += ad7091r-base.o
>  obj-$(CONFIG_AD7091R5) += ad7091r5.o
>  obj-$(CONFIG_AD7091R8) += ad7091r8.o
> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> new file mode 100644
> index 000000000000..c5525433990c
> --- /dev/null
> +++ b/drivers/iio/adc/ad4851.c
> @@ -0,0 +1,1290 @@
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
> +#define AD4851_REG_CHX_SOFTSPAN(ch)	((0x12 * (ch)) + AD4851_REG_CH_CONFIG_BASE)
> +#define AD4851_REG_CHX_OFFSET(ch)	(AD4851_REG_CHX_SOFTSPAN(ch) + 0x01)
> +#define AD4851_REG_CHX_OFFSET_LSB(ch)	AD4851_REG_CHX_OFFSET(ch)
> +#define AD4851_REG_CHX_OFFSET_MID(ch)	(AD4851_REG_CHX_OFFSET_LSB(ch) + 0x01)
> +#define AD4851_REG_CHX_OFFSET_MSB(ch)	(AD4851_REG_CHX_OFFSET_MID(ch) + 0x01)
> +#define AD4851_REG_CHX_GAIN(ch)		(AD4851_REG_CHX_OFFSET(ch) + 0x03)
> +#define AD4851_REG_CHX_GAIN_LSB(ch)	AD4851_REG_CHX_GAIN(ch)
> +#define AD4851_REG_CHX_GAIN_MSB(ch)	(AD4851_REG_CHX_GAIN(ch) + 0x01)
> +#define AD4851_REG_CHX_PHASE(ch)	(AD4851_REG_CHX_GAIN(ch) + 0x02)
> +#define AD4851_REG_CHX_PHASE_LSB(ch)	AD4851_REG_CHX_PHASE(ch)
> +#define AD4851_REG_CHX_PHASE_MSB(ch)	(AD4851_REG_CHX_PHASE_LSB(ch) + 0x01)
> +
> +#define AD4851_REG_TESTPAT_0(c)		(0x38 + (c) * 0x12)
> +#define AD4851_REG_TESTPAT_1(c)		(0x39 + (c) * 0x12)
> +#define AD4851_REG_TESTPAT_2(c)		(0x3A + (c) * 0x12)
> +#define AD4851_REG_TESTPAT_3(c)		(0x3B + (c) * 0x12)
> +
> +#define AD4851_SW_RESET			(BIT(7) | BIT(0))
> +#define AD4851_SDO_ENABLE		BIT(4)
> +#define AD4851_SINGLE_INSTRUCTION	BIT(7)
> +#define AD4851_REFBUF_PD		BIT(2)
> +#define AD4851_REFSEL_PD		BIT(1)
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
> +static const struct ad4851_scale ad4851_scale_table_se[] = {

This should be called unipolar intead of se (single-ended). It is possible to
have bipolar single-ended.

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
> +static const struct ad4851_scale ad4851_scale_table_diff[] = {

This should be called bippolar instead of diff for the same reason.

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
> +static const unsigned int ad4851_scale_avail_se[] = {

ditto

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
> +static const unsigned int ad4851_scale_avail_diff[] = {

ditto

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
> +	unsigned int scales_se[AD4841_MAX_SCALE_AVAIL][2];
> +	unsigned int scales_diff[AD4841_MAX_SCALE_AVAIL][2];
> +};
> +
> +static int ad4851_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int ad4851_set_sampling_freq(struct ad4851_state *st, unsigned int freq)
> +{
> +	struct pwm_state cnv_state = {
> +		.duty_cycle = AD4851_T_CNVH_NS + AD4851_T_CNVH_NS_MARGIN,
> +		.enabled = true,
> +	};
> +	int ret;
> +
> +	freq = clamp(freq, 1, st->info->max_sample_rate_hz);
> +
> +	cnv_state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> +
> +	ret = pwm_apply_might_sleep(st->cnv, &cnv_state);
> +	if (ret)
> +		return ret;
> +
> +	st->cnv_trigger_rate_hz = freq;
> +
> +	return 0;
> +}
> +
> +static const int ad4851_oversampling_ratios[] = {
> +	1, 2, 4, 8, 16,	32, 64, 128,
> +	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
> +	65536,
> +};
> +
> +static int ad4851_osr_to_regval(unsigned int ratio)
> +{
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(ad4851_oversampling_ratios); i++)
> +		if (ratio == ad4851_oversampling_ratios[i])
> +			return i - 1;
> +
> +	return -EINVAL;
> +}
> +
> +static void __ad4851_get_scale(struct iio_dev *indio_dev, int scale_tbl,
> +			       unsigned int *val, unsigned int *val2)
> +{
> +	const struct iio_scan_type *scan_type;
> +	unsigned int tmp;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
> +
> +	tmp = ((unsigned long long)scale_tbl * MICRO) >> scan_type->realbits;
> +	*val = tmp / MICRO;
> +	*val2 = tmp % MICRO;
> +}
> +
> +static int ad4851_scale_fill(struct iio_dev *indio_dev)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	unsigned int i, val1, val2;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4851_scale_avail_se); i++) {
> +		__ad4851_get_scale(indio_dev, ad4851_scale_avail_se[i], &val1, &val2);
> +		st->scales_se[i][0] = val1;
> +		st->scales_se[i][1] = val2;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4851_scale_avail_diff); i++) {
> +		__ad4851_get_scale(indio_dev, ad4851_scale_avail_diff[i], &val1, &val2);
> +		st->scales_diff[i][0] = val1;
> +		st->scales_diff[i][1] = val2;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 unsigned int osr)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	int val, ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (osr == 1) {
> +		ret = regmap_clear_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					AD4851_OS_EN_MSK);
> +		if (ret)
> +			return ret;
> +	} else {
> +		val = ad4851_osr_to_regval(osr);
> +		if (val < 0)
> +			return -EINVAL;
> +
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_OVERSAMPLE,
> +					 AD4851_OS_EN_MSK |
> +					 AD4851_OS_RATIO_MSK,
> +					 FIELD_PREP(AD4851_OS_EN_MSK, 1) |
> +					 FIELD_PREP(AD4851_OS_RATIO_MSK, val));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = iio_backend_oversampling_ratio_set(st->back, osr);
> +	if (ret)
> +		return ret;
> +
> +	switch (st->info->resolution) {
> +	case 20:
> +		switch (osr) {
> +		case 0:
> +			return -EINVAL;
> +		case 1:
> +			val = 20;
> +			break;
> +		default:
> +			val = 24;
> +			break;
> +		}
> +		break;
> +	case 16:
> +		val = 16;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = iio_backend_data_size_set(st->back, val);
> +	if (ret)
> +		return ret;
> +
> +	if (osr == 1 || st->info->resolution == 16) {
> +		ret = regmap_clear_bits(st->regmap, AD4851_REG_PACKET,
> +					AD4851_PACKET_FORMAT_MASK);
> +		if (ret)
> +			return ret;
> +
> +		st->resolution_boost_enabled = false;
> +	} else {
> +		ret = regmap_update_bits(st->regmap, AD4851_REG_PACKET,

regmap_set_bits

> +					 AD4851_PACKET_FORMAT_MASK,
> +					 FIELD_PREP(AD4851_PACKET_FORMAT_MASK, 1));
> +		if (ret)
> +			return ret;
> +
> +		st->resolution_boost_enabled = true;
> +	}
> +
> +	if (st->osr != osr) {
> +		ret = ad4851_scale_fill(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		st->osr = osr;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4851_get_oversampling_ratio(struct ad4851_state *st, unsigned int *val)
> +{
> +	unsigned int osr;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_OVERSAMPLE, &osr);
> +	if (ret)
> +		return ret;
> +
> +	if (!FIELD_GET(AD4851_OS_EN_MSK, osr))
> +		*val = 1;
> +	else
> +		*val = ad4851_oversampling_ratios[FIELD_GET(AD4851_OS_RATIO_MSK, osr) + 1];
> +
> +	st->osr = *val;
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
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +				      AD4851_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vrefbuf_en) {
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +				      AD4851_REFBUF_PD);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (st->vrefio_en) {
> +		ret = regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +				      AD4851_REFSEL_PD);
> +		if (ret)
> +			return ret;
> +	}

PD stands for power down, so should we be powering down if not enabled? (i.e.
if is missing !)

> +
> +	ret = regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_B,
> +			   AD4851_SINGLE_INSTRUCTION);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_INTERFACE_CONFIG_A,
> +			   AD4851_SDO_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_PRODUCT_ID_L, &product_id);
> +	if (ret)
> +		return ret;
> +
> +	if (product_id != st->info->product_id)
> +		dev_info(&st->spi->dev, "Unknown product ID: 0x%02X\n",
> +			 product_id);
> +
> +	ret = regmap_set_bits(st->regmap, AD4851_REG_DEVICE_CTRL,
> +			      AD4851_ECHO_CLOCK_MODE);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_PACKET, 0);
> +}
> +
> +static int ad4851_find_opt(bool *field, u32 size, u32 *ret_start)
> +{
> +	unsigned int i, cnt = 0, max_cnt = 0, max_start = 0;
> +	int start;
> +
> +	for (i = 0, start = -1; i < size; i++) {
> +		if (field[i] == 0) {
> +			if (start == -1)
> +				start = i;
> +			cnt++;
> +		} else {
> +			if (cnt > max_cnt) {
> +				max_cnt = cnt;
> +				max_start = start;
> +			}
> +			start = -1;
> +			cnt = 0;
> +		}
> +	}
> +	/*
> +	 * Find the longest consecutive sequence of false values from field
> +	 * and return starting index.
> +	 */
> +	if (cnt > max_cnt) {
> +		max_cnt = cnt;
> +		max_start = start;
> +	}
> +
> +	if (!max_cnt)
> +		return -ENOENT;
> +
> +	*ret_start = max_start;
> +
> +	return max_cnt;
> +}
> +
> +static int ad4851_calibrate(struct iio_dev *indio_dev)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	unsigned int opt_delay, num_lanes, delay, i, s, c;
> +	enum iio_backend_interface_type interface_type;
> +	DECLARE_BITMAP(pn_status, AD4851_MAX_LANES * AD4851_MAX_IODELAY);
> +	bool status;
> +	int ret;
> +
> +	ret = iio_backend_interface_type_get(st->back, &interface_type);
> +	if (ret)
> +		return ret;
> +
> +	switch (interface_type) {
> +	case IIO_BACKEND_INTERFACE_SERIAL_CMOS:
> +		num_lanes = indio_dev->num_channels;
> +		break;
> +	case IIO_BACKEND_INTERFACE_SERIAL_LVDS:
> +		num_lanes = 1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (st->info->resolution == 16) {
> +		ret = iio_backend_data_size_set(st->back, 24);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4851_REG_PACKET,
> +				   AD4851_TEST_PAT | AD4857_PACKET_SIZE_24);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret = iio_backend_data_size_set(st->back, 32);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4851_REG_PACKET,
> +				   AD4851_TEST_PAT | AD4858_PACKET_SIZE_32);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_0(i),
> +				   AD4851_TESTPAT_0_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_1(i),
> +				   AD4851_TESTPAT_1_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_2(i),
> +				   AD4851_TESTPAT_2_DEFAULT);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_write(st->regmap, AD4851_REG_TESTPAT_3(i),
> +				   AD4851_TESTPAT_3_DEFAULT(i));
> +		if (ret)
> +			return ret;
> +
> +		ret = iio_backend_chan_enable(st->back, i);

Right now, i might not correspond to the channel number if channles were skipped
in the devicetree. Safer would be to use indio_dev->channels[i].channel.

Or, as I suggest in the channel parsing function below, we could just make sure
indio_dev->num_channels is always 8, then this code here is fine.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < num_lanes; i++) {
> +		for (delay = 0; delay < AD4851_MAX_IODELAY; delay++) {
> +			ret = iio_backend_iodelay_set(st->back, i, delay);
> +			if (ret)
> +				return ret;
> +
> +			ret = iio_backend_chan_status(st->back, i, &status);
> +			if (ret)
> +				return ret;
> +
> +			if (status)
> +				set_bit(i * AD4851_MAX_IODELAY + delay, pn_status);
> +			else
> +				clear_bit(i * AD4851_MAX_IODELAY + delay, pn_status);
> +		}
> +	}
> +
> +	for (i = 0; i < num_lanes; i++) {
> +		status = test_bit(i * AD4851_MAX_IODELAY, pn_status);
> +		c = ad4851_find_opt(&status, AD4851_MAX_IODELAY, &s);
> +		if (c < 0)
> +			return c;
> +
> +		opt_delay = s + c / 2;
> +		ret = iio_backend_iodelay_set(st->back, i, opt_delay);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		ret = iio_backend_chan_disable(st->back, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = iio_backend_data_size_set(st->back, 20);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_PACKET, 0);
> +}
> +
> +static int ad4851_get_calibscale(struct ad4851_state *st, int ch, int *val, int *val2)
> +{
> +	unsigned int reg_val;
> +	int gain;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_GAIN_MSB(ch), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain = reg_val << 8;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain |= reg_val;
> +
> +	*val = gain;
> +	*val2 = 32768;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int ad4851_set_calibscale(struct ad4851_state *st, int ch, int val,
> +				 int val2)
> +{
> +	u64 gain;
> +	u8 buf[2];
> +	int ret;
> +
> +	if (val < 0 || val2 < 0)
> +		return -EINVAL;
> +
> +	gain = val * MICRO + val2;
> +	gain = DIV_U64_ROUND_CLOSEST(gain * 32768, MICRO);
> +
> +	put_unaligned_be16(gain, buf);
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_CHX_GAIN_MSB(ch), buf[0]);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_CHX_GAIN_LSB(ch), buf[1]);
> +}
> +
> +static int ad4851_get_calibbias(struct ad4851_state *st, int ch, int *val)
> +{
> +	unsigned int lsb, mid, msb;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_OFFSET_MSB(ch), &msb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_OFFSET_MID(ch), &mid);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_OFFSET_LSB(ch), &lsb);
> +	if (ret)
> +		return ret;
> +
> +	if (st->info->resolution == 16) {
> +		*val = msb << 8;
> +		*val |= mid;
> +		*val = sign_extend32(*val, 15);
> +	} else {
> +		*val = msb << 12;
> +		*val |= mid << 4;
> +		*val |= lsb >> 4;
> +		*val = sign_extend32(*val, 19);
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4851_set_calibbias(struct ad4851_state *st, int ch, int val)
> +{
> +	u8 buf[3] = { 0 };

0 can be omitted

> +	int ret;
> +
> +	if (val < 0)
> +		return -EINVAL;
> +
> +	if (st->info->resolution == 16)
> +		put_unaligned_be16(val, buf);
> +	else
> +		put_unaligned_be24(val << 4, buf);
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_CHX_OFFSET_LSB(ch), buf[2]);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4851_REG_CHX_OFFSET_MID(ch), buf[1]);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD4851_REG_CHX_OFFSET_MSB(ch), buf[0]);
> +}
> +
> +static int ad4851_set_scale(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, int val, int val2)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	unsigned int scale_val[2];
> +	unsigned int i;
> +	const struct ad4851_scale *scale_table;
> +	size_t table_size;
> +
> +	if (chan->differential) {

This should check st->bipolar_ch[chan->channel], not chan->differential

> +		scale_table = ad4851_scale_table_diff;
> +		table_size = ARRAY_SIZE(ad4851_scale_table_diff);
> +	} else {
> +		scale_table = ad4851_scale_table_se;
> +		table_size = ARRAY_SIZE(ad4851_scale_table_se);
> +	}
> +
> +	for (i = 0; i < table_size; i++) {
> +		__ad4851_get_scale(indio_dev, scale_table[i].scale_val,
> +				   &scale_val[0], &scale_val[1]);
> +		if (scale_val[0] != val || scale_val[1] != val2)
> +			continue;
> +
> +		return regmap_write(st->regmap,
> +				    AD4851_REG_CHX_SOFTSPAN(chan->channel),
> +				    scale_table[i].reg_val);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad4851_get_scale(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, int *val,
> +			    int *val2)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	const struct ad4851_scale *scale_table;
> +	size_t table_size;
> +	int i, softspan_val;

Technically, softspan_val should be u32. And i should be size_t since it gets
compared to table_size.

> +	int ret;
> +
> +	if (chan->differential) {

This should check st->bipolar_ch[chan->channel], not chan->differential

> +		scale_table = ad4851_scale_table_diff;
> +		table_size = ARRAY_SIZE(ad4851_scale_table_diff);
> +	} else {
> +		scale_table = ad4851_scale_table_se;
> +		table_size = ARRAY_SIZE(ad4851_scale_table_se);
> +	}
> +
> +	ret = regmap_read(st->regmap, AD4851_REG_CHX_SOFTSPAN(chan->channel),
> +			  &softspan_val);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < table_size; i++) {
> +		if (softspan_val == scale_table[i].reg_val)
> +			break;
> +	}
> +
> +	if (i == table_size)
> +		return -EIO;
> +
> +	__ad4851_get_scale(indio_dev, scale_table[i].scale_val, val, val2);
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int ad4851_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->cnv_trigger_rate_hz / st->osr;

osr can be large here (2^16) so could be a good idea to use IIO_VAL_FRACTIONAL
instead to get a more accurate value.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4851_get_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4851_get_scale(indio_dev, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4851_get_calibbias(st, chan->channel, val);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4851_get_oversampling_ratio(st, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4851_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4851_set_sampling_freq(st, val * st->osr);

As above, osr can be large, so we should probably also take into consideration
val2 to allow for better accuracy.

> +	case IIO_CHAN_INFO_SCALE:
> +		return ad4851_set_scale(indio_dev, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4851_set_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad4851_set_calibbias(st, chan->channel, val);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4851_set_oversampling_ratio(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4851_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	unsigned int c;
> +	int ret;
> +
> +	for (c = 0; c < indio_dev->num_channels; c++) {
> +		if (test_bit(c, scan_mask))
> +			ret = iio_backend_chan_enable(st->back, c);
> +		else
> +			ret = iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4851_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long mask)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (st->bipolar_ch[chan->channel]) {
> +			*vals = (const int *)st->scales_diff;
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			/* Values are stored in a 2D matrix */
> +			*length = ARRAY_SIZE(ad4851_scale_avail_diff) * 2;
> +		} else {
> +			*vals = (const int *)st->scales_se;
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			/* Values are stored in a 2D matrix */
> +			*length = ARRAY_SIZE(ad4851_scale_avail_se) * 2;
> +		}
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = ad4851_oversampling_ratios;
> +		*length = ARRAY_SIZE(ad4851_oversampling_ratios);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_scan_type ad4851_scan_type_20_0[] = {
> +	[AD4851_SCAN_TYPE_NORMAL] = {
> +		.sign = 'u',
> +		.realbits = 20,
> +		.storagebits = 32,
> +	},
> +	[AD4851_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 'u',
> +		.realbits = 24,
> +		.storagebits = 32,
> +	},
> +};
> +
> +static const struct iio_scan_type ad4851_scan_type_20_1[] = {
> +	[AD4851_SCAN_TYPE_NORMAL] = {
> +		.sign = 's',
> +		.realbits = 20,
> +		.storagebits = 32,
> +	},
> +	[AD4851_SCAN_TYPE_RESOLUTION_BOOST] = {
> +		.sign = 's',
> +		.realbits = 24,
> +		.storagebits = 32,
> +	},
> +};
> +
> +static int ad4851_get_current_scan_type(const struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +
> +	return st->resolution_boost_enabled ? AD4851_SCAN_TYPE_RESOLUTION_BOOST
> +					    : AD4851_SCAN_TYPE_NORMAL;
> +}
> +
> +#define AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.type = IIO_VOLTAGE,							\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS) |					\
> +		BIT(IIO_CHAN_INFO_SCALE),					\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> +	.info_mask_shared_by_all_available =					\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
> +	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),		\

Would be more logical to move this line up right after info_mask_separate.

> +	.indexed = 1,								\
> +	.differential = diff,							\
> +	.channel = ch,								\
> +	.channel2 = ch + (diff * 8),						\

Hard-coding 8 here could be a bit fragile, e.g. if we ever add a 16-channel
chip. We should at least add a comment here or use the AD4851_MAX_CH_NR macro.

Also, diff * (ch + AD4851_MAX_CH_NR) would seem more logical so that the value
is 0 for single-ended inputs.

> +	.scan_index = index,
> +
> +#define AD4858_IIO_CHANNEL(index, ch, diff)					\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +}
> +
> +#define AD4857_IIO_CHANNEL(index, ch, diff)					\
> +{										\
> +	AD4851_IIO_CHANNEL(index, ch, diff)					\
> +	.scan_type = {								\
> +		.sign = diff ? 's' : 'u',					\

The sign depends on unipolar or bipolar for this chip, not differential or
single-ended. We can just make the default here 'u' and let the channel parseer
write over it if it is signed.

> +		.realbits = 16,							\
> +		.storagebits = 16,						\
> +	},									\
> +}
> +
> +static int ad4851_parse_channels(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec **ad4851_channels,

This parameter is reduandant and can be removed. The caller can just use
indio_dev->channels to get the same pointer.

> +				 const struct iio_chan_spec ad4851_chan,
> +				 const struct iio_chan_spec ad4851_chan_diff)

Better to pass structs as pointers instead of copying them.

> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *channels;
> +	unsigned int num_channels, reg;
> +	unsigned int index = 0;
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > AD4851_MAX_CH_NR)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels: %u\n",
> +				     num_channels);

Since this isn't the kind of chip where we can mix and match different input
pins to make different channels, I would suggest to always create the max
number of channels, then tweak the channel info based on channel nodes in the
DT. Any channels that don't have a channel node in DT can just default to
unipolar single-ended.

> +
> +	channels = devm_kcalloc(dev, num_channels,
> +				sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = num_channels;
> +
> +	device_for_each_child_node_scoped(dev, child) {

Then this just becomes a regular for loop so that a unique scan index is
assigned to each channel.

> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");

reg needs to be checked that it is in range, otherwise we get out of bounds
array access later.

> +		if (fwnode_property_present(child, "diff-channels")) {
> +			*channels = ad4851_chan_diff;
> +			channels->scan_index = index++;
> +			channels->channel = reg;
> +			channels->channel2 = reg + AD4851_MAX_CH_NR;

This looks a bit fragile. If AD4851_MAX_CH_NR was ever increased for a new chip
with more channels, then it would break userspace for other chips. Maybe use
the chip-specific max here instead of the global max.

> +
> +		} else {
> +			*channels = ad4851_chan;
> +			channels->scan_index = index++;
> +			channels->channel = reg;
> +		}
> +		channels++;
> +
> +		if (fwnode_property_present(child, "bipolar")) {

IIRC, fwnode_property_read_bool() is prefered for boolean flags.

> +			st->bipolar_ch[reg] = true;

This also needs to set the sign in scan_type to 's'.

> +		} else {
> +			st->bipolar_ch[reg] = false;
> +			ret = regmap_write(st->regmap, AD4851_REG_CHX_SOFTSPAN(reg),
> +					   AD4851_SOFTSPAN_0V_40V);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	*ad4851_channels = channels;
> +
> +	return 0;
> +}
> +
> +static int ad4857_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4857_IIO_CHANNEL(0, 0, 0);
> +	const struct iio_chan_spec ad4851_chan_diff = AD4857_IIO_CHANNEL(0, 0, 1);
> +
> +	return ad4851_parse_channels(indio_dev, &ad4851_channels, ad4851_chan, ad4851_chan_diff);
> +}
> +
> +static int ad4858_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4858_IIO_CHANNEL(0, 0, 0);
> +	const struct iio_chan_spec ad4851_chan_diff = AD4858_IIO_CHANNEL(0, 0, 1);
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = ad4851_parse_channels(indio_dev, &ad4851_channels, ad4851_chan, ad4851_chan_diff);
> +	if (ret)
> +		return ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Missing channel number\n");

reg is unused here so can be removed. It was already checked in
ad4851_parse_channels().

Also need to set ad4851_channels->has_ext_scan_type = 1 here.

> +		if (fwnode_property_present(child, "bipolar")) {
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_1;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_1);
> +
> +		} else {
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_0;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_0);
> +		}

Might want to warn if channel is differential but not bipolar. It couldn't work
with that config since negative differences are always possible even if the
individual inputs are both positive.

> +		ad4851_channels++;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * parse_channels() function handles the rest of the channel related attributes
> + * that are usually are stored in the chip info structure.
> + */
> +static const struct ad4851_chip_info ad4851_info = {
> +	.name = "ad4851",
> +	.product_id = 0x67,
> +	.max_sample_rate_hz = 250 * KILO,
> +	.resolution = 16,
> +	.parse_channels = ad4857_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4852_info = {
> +	.name = "ad4852",
> +	.product_id = 0x66,
> +	.max_sample_rate_hz = 250 * KILO,
> +	.resolution = 20,
> +	.parse_channels = ad4858_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4853_info = {
> +	.name = "ad4853",
> +	.product_id = 0x65,
> +	.max_sample_rate_hz = 1 * MEGA,
> +	.resolution = 16,
> +	.parse_channels = ad4857_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4854_info = {
> +	.name = "ad4854",
> +	.product_id = 0x64,
> +	.max_sample_rate_hz = 1 * MEGA,
> +	.resolution = 20,
> +	.parse_channels = ad4858_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4855_info = {
> +	.name = "ad4855",
> +	.product_id = 0x63,
> +	.max_sample_rate_hz = 250 * KILO,
> +	.resolution = 16,
> +	.parse_channels = ad4857_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4856_info = {
> +	.name = "ad4856",
> +	.product_id = 0x62,
> +	.max_sample_rate_hz = 250 * KILO,
> +	.resolution = 20,
> +	.parse_channels = ad4858_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4857_info = {
> +	.name = "ad4857",
> +	.product_id = 0x61,
> +	.max_sample_rate_hz = 1 * MEGA,
> +	.resolution = 16,
> +	.parse_channels = ad4857_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4858_info = {
> +	.name = "ad4858",
> +	.product_id = 0x60,
> +	.max_sample_rate_hz = 1 * MEGA,
> +	.resolution = 20,
> +	.parse_channels = ad4858_parse_channels,
> +};
> +
> +static const struct ad4851_chip_info ad4858i_info = {
> +	.name = "ad4858i",
> +	.product_id = 0x6F,
> +	.max_sample_rate_hz = 1 * MEGA,
> +	.resolution = 20,
> +	.parse_channels = ad4858_parse_channels,
> +};
> +
> +static const struct iio_info ad4851_iio_info = {
> +	.debugfs_reg_access = ad4851_reg_access,
> +	.read_raw = ad4851_read_raw,
> +	.write_raw = ad4851_write_raw,
> +	.update_scan_mode = ad4851_update_scan_mode,
> +	.get_current_scan_type = &ad4851_get_current_scan_type,

Odd &. 

> +	.read_avail = ad4851_read_avail,
> +};
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(7),
> +};
> +
> +static const char * const ad4851_power_supplies[] = {
> +	"vcc",	"vdd", "vee", "vio",
> +};
> +
> +static int ad4851_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &spi->dev;
> +	struct ad4851_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(ad4851_power_supplies),
> +					     ad4851_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get and enable supplies\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vddh");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vddh voltage\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vddl");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vddl voltage\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vrefbuf");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vrefbuf voltage\n");
> +
> +	if (ret > 0)
> +		st->vrefbuf_en = true;
> +	else
> +		st->vrefbuf_en = false;
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vrefio");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vrefio voltage\n");
> +
> +	if (ret > 0)
> +		st->vrefio_en = true;
> +	else
> +		st->vrefio_en = false;
> +
> +	st->pd_gpio = devm_gpiod_get_optional(dev, "pd", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->pd_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->pd_gpio),
> +				     "Error on requesting pd GPIO\n");
> +
> +	st->cnv = devm_pwm_get(dev, NULL);
> +	if (IS_ERR(st->cnv))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv),
> +				     "Error on requesting pwm\n");
> +
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	st->regmap = devm_regmap_init_spi(spi, &regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ad4851_set_sampling_freq(st, HZ_PER_MHZ);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&st->spi->dev, ad4851_pwm_disable,
> +				       st->cnv);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4851_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->info = &ad4851_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = st->info->parse_channels(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4851_scale_fill(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4851_calibrate(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad4851_of_match[] = {
> +	{ .compatible = "adi,ad4851", .data = &ad4851_info, },
> +	{ .compatible = "adi,ad4852", .data = &ad4852_info, },
> +	{ .compatible = "adi,ad4853", .data = &ad4853_info, },
> +	{ .compatible = "adi,ad4854", .data = &ad4854_info, },
> +	{ .compatible = "adi,ad4855", .data = &ad4855_info, },
> +	{ .compatible = "adi,ad4856", .data = &ad4856_info, },
> +	{ .compatible = "adi,ad4857", .data = &ad4857_info, },
> +	{ .compatible = "adi,ad4858", .data = &ad4858_info, },
> +	{ .compatible = "adi,ad4858i", .data = &ad4858i_info, },
> +	{ }
> +};
> +
> +static const struct spi_device_id ad4851_spi_id[] = {
> +	{ "ad4851", (kernel_ulong_t)&ad4851_info },
> +	{ "ad4852", (kernel_ulong_t)&ad4852_info },
> +	{ "ad4853", (kernel_ulong_t)&ad4853_info },
> +	{ "ad4854", (kernel_ulong_t)&ad4854_info },
> +	{ "ad4855", (kernel_ulong_t)&ad4855_info },
> +	{ "ad4856", (kernel_ulong_t)&ad4856_info },
> +	{ "ad4857", (kernel_ulong_t)&ad4857_info },
> +	{ "ad4858", (kernel_ulong_t)&ad4858_info },
> +	{ "ad4858i", (kernel_ulong_t)&ad4858i_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4851_spi_id);
> +
> +static struct spi_driver ad4851_driver = {
> +	.probe = ad4851_probe,
> +	.driver = {
> +		.name = "ad4851",
> +		.of_match_table = ad4851_of_match,
> +	},
> +	.id_table = ad4851_spi_id,
> +};
> +module_spi_driver(ad4851_driver);
> +
> +MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
> +MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD4851 DAS driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");


