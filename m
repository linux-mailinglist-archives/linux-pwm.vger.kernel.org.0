Return-Path: <linux-pwm+bounces-6345-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B141CAD9BFA
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 12:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22483BBB13
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA751D5146;
	Sat, 14 Jun 2025 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+/mslCZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF73FFD;
	Sat, 14 Jun 2025 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749895702; cv=none; b=Get3d2aZPMPtNyJ9OQNrsmEFH/sIvgicv1oa8GV+t8tH8QeGBB0k3O/1YyPWubfWNpD7zGqK1M6P7Nt2tfTfNvmRohnYkMkO/Miwt2Us/kLk65KIWhoOwlSc4DlQ5Aj/VKEQo2HodRSbWUJiQnfN1/zsodf5XMLBJG7VXT7ImPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749895702; c=relaxed/simple;
	bh=LYUOXEwhIzg7MROvHrJQMLI06S8gu89x+0gLB8Lf6xk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeC4upETJ0ps+9ZTdItdmjx1Ya4mD+27O+v0fQWfNnZFv4m/5mDIHthvyfNwVpycBPvKxN0JpBjeHlAhcXFB1Yaajo/BYu9eYQAqjCLbhN9Hg9Q73Hkb5f8VaPDB6JTX6GAaXzFycGIdD0CcETM/hxjW33aYEOelIvBVmui2Tpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+/mslCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29800C4CEEB;
	Sat, 14 Jun 2025 10:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749895701;
	bh=LYUOXEwhIzg7MROvHrJQMLI06S8gu89x+0gLB8Lf6xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d+/mslCZ1XbCeipCJ3vAS/hAOdDogRWH+NmJSzuwH8sujHMb12Uu4FoFS9ovGlasm
	 aVGAuntT0L+hKRpP6Pd+iPq+xZIA9L0tz7BcY8B5x6cL83y8W1BBCKLPupChwmUQCl
	 +DZV79oTheErAo9EqRTDE+dBtn/KLBW+kEBipj9MRBMTk0JI6MpRnFPdscAPD+uQe7
	 JC3+gKsWFWDbF4JsZlby4d4Tqhv2w/+HjpMrQW0qEwEPhZpHcTKDPDTAqjbI65Un4D
	 p/56oLEQ4MzXKMKAlLMK6tz6hCy9p1vna5onFEyM2GP4Utg5x4S31WtbE6EnSqvHyJ
	 w0GvM1l9a2zmA==
Date: Sat, 14 Jun 2025 11:08:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 4/8] iio: adc: Add support for ad4052
Message-ID: <20250614110812.39af2c41@jic23-huawei>
In-Reply-To: <20250610-iio-driver-ad4052-v3-4-cf1e44c516d4@analog.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-4-cf1e44c516d4@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 09:34:37 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit, successive
> approximation register (SAR) analog-to-digital converter (ADC) that
> enables low-power, high-density data acquisition solutions without
> sacrificing precision. This ADC offers a unique balance of performance
> and power efficiency, plus innovative features for seamlessly switching
> between high-resolution and low-power modes tailored to the immediate
> needs of the system. The AD4052/AD4058/AD4050/AD4056 are ideal for
> battery-powered, compact data acquisition and edge sensing applications.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Hi Jorge,

Various minor comments inline.

Jonathan

> diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..842f5972a1c58701addf5243e7b87da9c26c773f
> --- /dev/null
> +++ b/drivers/iio/adc/ad4052.c
> @@ -0,0 +1,1083 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AD4052 SPI ADC driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>

whilst I've asked you to drop the of specific code, the
absences of an appropriate header here makes me thing you
should take another look at these.  

> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +#include <linux/unaligned.h>
> +#include <dt-bindings/iio/adc/adi,ad4052.h>


> +
> +struct ad4052_chip_info {
> +	const struct iio_chan_spec channels[1];

As below. If it's always one drop the array.

> +	const char *name;
> +	u16 prod_id;
> +	u8 max_avg;
> +	u8 grade;
> +};

> +};
> +
> +struct ad4052_state {
> +	const struct ad4052_bus_ops *ops;
> +	const struct ad4052_chip_info *chip;
> +	enum ad4052_operation_mode mode;
> +	struct spi_device *spi;
> +	struct pwm_device *cnv_pwm;
> +	struct pwm_state pwm_st;
> +	struct spi_transfer xfer;
> +	struct gpio_desc *cnv_gp;
> +	struct completion completion;
> +	struct regmap *regmap;
> +	u16 oversampling_frequency;
> +	int gp1_irq;
> +	int vio_uv;
> +	int vref_uv;
> +	u8 reg_tx[3];

These look to also be used in spi transactions?  As such don't the
need to be IIO_DMA_MINALIGN?   Fine to have all these with just one
marking but it needs to be on the first one used in this fashion and you need
to be sure that they are all protected by an appropriate lock.
SYSFS access can race and the bus lock isn't sufficient as it only protects
the actual bus, not the buffers passed.  Also don't rely on core locking
(i.e. claim direct etc) because whether they prevent multiple users is an
implementation detail of the core and shouldn't be relied on by users.
They are only guaranteed to hold the buffer / direct state.

> +	u8 reg_rx[3];
> +	u8 raw[4] __aligned(IIO_DMA_MINALIGN);
> +	u8 buf_reset_pattern[18];
> +};


> +
> +#define AD4052_CHAN(bits, grade) {							\
> +	.type = IIO_VOLTAGE,								\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
> +				    BIT(IIO_CHAN_INFO_SCALE) |				\
> +				    BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
> +				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +	.indexed = 1,									\
> +	.channel = 0,									\
> +	.has_ext_scan_type = 1,								\
> +	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
> +	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
> +	.ext_info = grade##_ext_info,							\
> +}
> +
> +#define AD4052_OFFLOAD_CHAN(bits, grade) {						\

Not used in this patch I think.  Push it to the later one.

> +	.type = IIO_VOLTAGE,								\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
> +				    BIT(IIO_CHAN_INFO_SCALE) |				\
> +				    BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
> +				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |		\
> +				    BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +	.indexed = 1,									\
> +	.channel = 0,									\
> +	.has_ext_scan_type = 1,								\
> +	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
> +	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
> +	.ext_info = grade##_ext_info,							\
> +}
> +
> +static const struct ad4052_chip_info ad4050_chip_info = {
> +	.name = "ad4050",
> +	.channels = { AD4052_CHAN(12, AD4052_2MSPS) },

Are we ever going to have more than 1?  Maybe just use channel and drop the array part.

> +	.prod_id = 0x70,
> +	.max_avg = AD4050_MAX_AVG,
> +	.grade = AD4052_2MSPS,
> +};
> +
> +static const struct ad4052_chip_info ad4052_chip_info = {
> +	.name = "ad4052",
> +	.channels = { AD4052_CHAN(16, AD4052_2MSPS) },
> +	.prod_id = 0x72,
> +	.max_avg = AD4052_MAX_AVG,
> +	.grade = AD4052_2MSPS,
> +};
> +
> +static const struct ad4052_chip_info ad4056_chip_info = {
> +	.name = "ad4056",
> +	.channels = { AD4052_CHAN(12, AD4052_500KSPS) },
> +	.prod_id = 0x76,
> +	.max_avg = AD4050_MAX_AVG,
> +	.grade = AD4052_500KSPS,
> +};
> +
> +static const struct ad4052_chip_info ad4058_chip_info = {
> +	.name = "ad4058",
> +	.channels = { AD4052_CHAN(16, AD4052_500KSPS) },
> +	.prod_id = 0x78,
> +	.max_avg = AD4052_MAX_AVG,
> +	.grade = AD4052_500KSPS,
> +};
> +
> +static int ad4052_update_xfer_raw(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	struct spi_transfer *xfer = &st->xfer;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	xfer->rx_buf = st->raw;
> +	xfer->bits_per_word = scan_type->realbits;
> +	xfer->len = scan_type->realbits == 24 ? 4 : 2;

This is a little odd. I'm not sure what happens with len not dividing
into a whole number of bits per word chunks.
Maybe a comment?

> +	xfer->speed_hz = AD4052_SPI_MAX_ADC_XFER_SPEED(st->vio_uv);
> +
> +	return 0;
> +}


> +static int ad4052_exit_command(struct ad4052_state *st)
> +{
> +	struct spi_device *spi = st->spi;
> +	const u8 val = 0xA8;
> +
> +	return spi_write(spi, &val, 1);

Even a one byte spi_write() requires a DMA safe buffer.
Feel free to use spi_write_then_read() with zero size read as that doesn't
need dma safety.

> +}

> +static int ad4052_set_sampling_freq(struct ad4052_state *st, unsigned int freq)
> +{
> +	const u32 start = 1;

Only used in the check so why the local variable? Maybe this makes sense in
later patches in which case fine to leave it here.

> +
> +	if (!in_range(freq, start, AD4052_MAX_RATE(st->chip->grade)))
> +		return -EINVAL;
> +
> +	st->pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> +	return pwm_apply_might_sleep(st->cnv_pwm, &st->pwm_st);
> +}


> +static int ad4052_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			const bool *ref_sel)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	int ret;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	u8 val = FIELD_PREP(AD4052_REG_GP_CONF_MODE_MSK_0, AD4052_GP_INTR) |

Declarations still at the top (unless doing cleanup.h stuff)

> +		 FIELD_PREP(AD4052_REG_GP_CONF_MODE_MSK_1, AD4052_GP_DRDY);
> +
> +	ret = regmap_update_bits(st->regmap, AD4052_REG_GP_CONF,
> +				 AD4052_REG_GP_CONF_MODE_MSK_1 | AD4052_REG_GP_CONF_MODE_MSK_0,
> +				 val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(AD4052_REG_INTR_CONF_EN_MSK_0, (AD4052_INTR_EN_EITHER)) |
> +	      FIELD_PREP(AD4052_REG_INTR_CONF_EN_MSK_1, (AD4052_INTR_EN_NEITHER));

Excess brackets. Also why set this here to write it many lines later?

> +
> +	if (st->chip->grade == AD4052_500KSPS) {
> +		ret = regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG,
> +				   FIELD_PREP(AD4052_REG_TIMER_CONFIG_FS_MASK,
> +					      AD4052_REG_TIMER_CONFIG_300KSPS));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_update_bits(st->regmap, AD4052_REG_ADC_MODES,
> +				 AD4052_REG_ADC_CONFIG_REF_EN_MSK,
> +				 FIELD_PREP(AD4052_REG_ADC_CONFIG_REF_EN_MSK,
> +					    *ref_sel));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS,
> +			   AD4052_REG_DEVICE_STATUS_DEVICE_RESET);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->regmap, AD4052_REG_INTR_CONF,
> +				  AD4052_REG_INTR_CONF_EN_MSK_0 | AD4052_REG_INTR_CONF_EN_MSK_1,
> +				  val);
> +}



> +static int __ad4052_read_chan_raw(struct ad4052_state *st, int *val)
> +{
> +	struct spi_device *spi = st->spi;
> +	struct spi_transfer t_cnv = {};
> +	int ret;
> +
> +	reinit_completion(&st->completion);
> +
> +	if (st->cnv_gp) {
> +		gpiod_set_value_cansleep(st->cnv_gp, 1);
> +		gpiod_set_value_cansleep(st->cnv_gp, 0);
> +	} else {
> +		ret = spi_sync_transfer(spi, &t_cnv, 1);

Add a comment for this.   I can't immediately spot documentation on what
a content free transfer actually does.  I assume pulses the chip select?
is that true for all SPI controllers?

> +		if (ret)
> +			return ret;
> +	}
> +	/*
> +	 * Single sample read should be used only for oversampling and
> +	 * sampling frequency pairs that take less than 1 sec.
> +	 */
> +	if (st->gp1_irq) {
> +		ret = wait_for_completion_timeout(&st->completion,
> +						  msecs_to_jiffies(1000));
> +		if (!ret)
> +			return -ETIMEDOUT;
> +	}
> +
> +	ret = spi_sync_transfer(spi, &st->xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (st->xfer.len == 2)
> +		*val = sign_extend32(*(u16 *)(st->raw), 15);
> +	else
> +		*val = sign_extend32(*(u32 *)(st->raw), 23);
> +
> +	return ret;
> +}

> +
> +static int ad4052_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	int ret;
> +
> +	if (info ==  IIO_CHAN_INFO_SAMP_FREQ)
> +		return ad4052_get_samp_freq(indio_dev, chan, val, val2);
> +	else if (info == IIO_CHAN_INFO_SCALE)

if (info == IIO_CHAN_INFO_SCALE) as you returned in the if above.


Or just make it a switch statement with default: covering the rest
of the cases.

> +		return ad4052_get_chan_scale(indio_dev, chan, val, val2);
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret = ad4052_read_raw_dispatch(indio_dev, chan, val, val2, info);
> +	iio_device_release_direct(indio_dev);
> +	return ret ? ret : IIO_VAL_INT;
> +}

> +
> +static int ad4052_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +				     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))

For these guards in the debugfs callback, please add a comment on why they
are needed.   We've had a lot of questions about these recently and I'd
like it to be clear to people when they should cut and paste these and when
not.

> +		return -EBUSY;
> +
> +	if (readval)
> +		ret = regmap_read(st->regmap, reg, readval);
> +	else
> +		ret = regmap_write(st->regmap, reg, writeval);
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}

> +static int __ad4052_validate_trigger_sources(struct of_phandle_args *trigger_sources)
> +{
> +	switch (trigger_sources->args[1]) {
> +	case AD4052_TRIGGER_PIN_GP1:
> +		return trigger_sources->args[0] == AD4052_TRIGGER_EVENT_DATA_READY ?
> +		       0 : -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4052_validate_trigger_sources(struct iio_dev *indio_dev)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	struct of_phandle_args trigger_sources;
> +	struct device_node *np;
> +	int ret;
> +
> +	np = st->spi->dev.of_node;
> +	ret = of_parse_phandle_with_args(np, "trigger-sources",
> +					 "#trigger-source-cells", 0,
> +					 &trigger_sources);

Can we use fwnode_property_get_reference_args() here?
Ideally we don't use of specific code in drivers.

TWith that use dev_fnwode() to get the more generic representation.

> +	if (ret)
> +		return ret;
> +
> +	ret = __ad4052_validate_trigger_sources(&trigger_sources);
> +	of_node_put(trigger_sources.np);
> +	return ret;
> +}
> +
> +static int ad4052_regulators_get(struct ad4052_state *st, bool *ref_sel)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int uv;
> +
> +	st->vio_uv = devm_regulator_get_enable_read_voltage(dev, "vio");
> +	if (st->vio_uv < 0)
> +		return dev_err_probe(dev, st->vio_uv,
> +				     "Failed to enable and read vio voltage\n");
> +
> +	uv = devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (uv < 0)
> +		return dev_err_probe(dev, uv,
> +				     "Failed to enable vdd regulator\n");
> +
> +	st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	*ref_sel = st->vref_uv == -ENODEV;
> +	if (st->vref_uv == -ENODEV)
> +		st->vref_uv = uv;

We probably don't care but we could support only enabling vdd if we aren't
using it's voltage.  That would allow a fake regulator if a board didn't
supply it (as always on).  Bit of an odd corner case though to rely on a stub
for that one but require the other regulators. Hence this is more of a comment
than a reason to change anything!

> +	else if (st->vref_uv < 0)
> +		return dev_err_probe(dev, st->vref_uv,
> +				     "Failed to enable and read ref voltage\n");
> +	return 0;
> +}


> +
> +static int ad4052_runtime_resume(struct device *dev)
> +{
> +	struct ad4052_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_clear_bits(st->regmap, AD4052_REG_DEVICE_CONFIG,
> +				AD4052_REG_DEVICE_CONFIG_POWER_MODE_MSK);
> +
> +	fsleep(4000);
I doesn't hugely matter as we don't expect an error, but normal approx
assumption of a regmap call failing is that we have lost comms with the chip
and in that case we just error out fast.  

	if (ret)
		return ret;

	fsleep(4000);

	return 0;

would reflect that handling.

> +	return ret;
> +}

