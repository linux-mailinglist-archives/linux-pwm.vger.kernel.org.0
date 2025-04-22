Return-Path: <linux-pwm+bounces-5659-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9391A972D5
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 18:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23FD717B980
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 16:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA723293453;
	Tue, 22 Apr 2025 16:33:18 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617A7212FBF;
	Tue, 22 Apr 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745339598; cv=none; b=HRxYdLMj2bsr6joisTG1kiiqZmK02EXtVpyMP2oHHJVnIh439jd8HJFRoveBeUQOREq5r6/S6aiJONXxoUT8j7izunkQxoF978/Zz9aYkRI0qGy1pQX+Z0pJetKSJkSWAhbX7gvkntxyxxZfup9hKUf/SfbPUZaQXZXKlQvMwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745339598; c=relaxed/simple;
	bh=u3cF0Mo2Bw7M6p+sQNOBt/FD6MnbO0aHMW6uX/ggRZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1mYy6WKRaUT1R97gJnSzlWtneSTNAfuMK/KwSC+fnZprveWeZS55lu2dhrUVHQg2c8nrMDqdwyguKNSTpluo1SaWdFphcLnaXAbjbA39RPwqI7jozbh+2abFI9r3u90qeI6Yd3Mp94cjjBlKfGebwiXtdEYbK5pWW2O41jn1U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: S6XiziiiRE6uJwMNE1MRZA==
X-CSE-MsgGUID: KQSyVCMxSjeH1DhRi2FNHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57891793"
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="57891793"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 09:33:15 -0700
X-CSE-ConnectionGUID: mBNZD8b+RbCVT77eR7nR1Q==
X-CSE-MsgGUID: i8TJH0pzQMi8aU97TPvvpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,231,1739865600"; 
   d="scan'208";a="137042752"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 09:33:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u7GYV-0000000EmPT-3CM5;
	Tue, 22 Apr 2025 19:33:07 +0300
Date: Tue, 22 Apr 2025 19:33:07 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: adc: add support for ad4052
Message-ID: <aAfEw-2D4tjLJtAN@smile.fi.intel.com>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 22, 2025 at 01:34:50PM +0200, Jorge Marques wrote:
> The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
> successive approximation register (SAR) analog-to-digital converter (ADC)
> that enables low-power, high-density data acquisition solutions without
> sacrificing precision.
> This ADC offers a unique balance of performance and power efficiency,
> plus innovative features for seamlessly switching between high-resolution
> and low-power modes tailored to the immediate needs of the system.
> The AD4052/AD4058/AD4050/AD4056 are ideal for battery-powered,
> compact data acquisition and edge sensing applications.

...

+ array_size.h

> +#include <linux/bitfield.h>

+ bitops.h
+ completion.h

> +#include <linux/delay.h>

+ dev_printk.h
+ err.h

> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer-dmaengine.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/interrupt.h>

+ jiffies.h
+ math.h

> +#include <linux/pm_runtime.h>

+ property.h

> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/offload/consumer.h>
> +#include <linux/spi/offload/provider.h>

+ string.h
+ types.h

+ asm/byteorder.h

...

> +#define AD4052_FS(g)		((&ad4052_conversion_freqs[AD4052_FS_OFFSET(g)]))

Why double parentheses? What does this mean?

...

> +#define AD4052_FS_LEN(g)	(ARRAY_SIZE(ad4052_conversion_freqs) - (AD4052_FS_OFFSET(g)))

Too many parentheses.

...

> +static const struct iio_event_spec ad4052_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE)

Leave trailing comma.

> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
> +				      BIT(IIO_EV_INFO_HYSTERESIS)

Ditto.

> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
> +				      BIT(IIO_EV_INFO_HYSTERESIS)

Ditto.

> +	}
> +};

...

> +static const char *const ad4052_conversion_freqs[] = {
> +	"2000000", "1000000", "300000", "100000", "33300",
> +	"10000", "3000", "500", "333", "250", "200",
> +	"166", "140", "124", "111",

Better to format with equal amount of members per line (usually power-of-two)
with a comment.

	"2000000", "1000000", "300000", "100000",	/*  0 -  3 */
	"33300", "10000", "3000", "500",		/*  4 -  7 */
	"333", "250", "200", "166",			/*  8 - 11 */
	"140", "124", "111",				/* 12 - 15 */

And why these are string literals?

> +};

...

> +static ssize_t ad4052_events_frequency_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct ad4052_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sprintf(buf, "%s\n", ad4052_conversion_freqs[st->events_frequency]);

You should use sysfs_emit() from sysfs.h.

> +}

...

> +static ssize_t ad4052_events_frequency_available_show(struct device *dev,
> +						      struct device_attribute *attr,
> +						      char *buf)
> +{
> +	struct ad4052_state *st = iio_priv(dev_to_iio_dev(dev));
> +	int len = 0;
> +
> +	for (u8 i = AD4052_FS_OFFSET(st->grade);
> +	     i < AD4052_FS_LEN(st->grade); i++)
> +		len += sprintf(buf + len, "%s ", ad4052_conversion_freqs[i]);
> +
> +	return sprintf(buf + len, "\n") + len;

sysfs_emit_at(). Use of sprintf() is quite wrong here even if don't care about
sysfs_emit*() APIs.

> +}

> +static IIO_DEVICE_ATTR(sampling_frequency, 0644,
> +		       ad4052_events_frequency_show,
> +		       ad4052_events_frequency_store, 0);
> +
> +static IIO_DEVICE_ATTR(sampling_frequency_available, 0444,
> +		       ad4052_events_frequency_available_show,
> +		       NULL, 0);

Please, move each of them closer to the callback. Also, why not
IIO_DEVICE_ATTR_RO() to begin with?

...

> +static struct attribute *ad4052_event_attributes[] = {
> +	&iio_dev_attr_sampling_frequency.dev_attr.attr,
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,

No comma in terminator entry.

> +};

...

> +static void ad4052_update_xfer_raw(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	struct spi_transfer *xfer = &st->xfer;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);

> +

Unneeded blank line.

> +	if (IS_ERR(scan_type))
> +		return;
> +
> +	xfer->bits_per_word = scan_type->realbits;
> +	xfer->len = BITS_TO_BYTES(scan_type->storagebits);
> +}
> +
> +static int ad4052_update_xfer_offload(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	struct spi_transfer *xfer = &st->xfer;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> +

Ditto.

> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	xfer = &st->offload_xfer;
> +	xfer->bits_per_word = scan_type->realbits;
> +	xfer->len = BITS_TO_BYTES(scan_type->storagebits);
> +
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> +	st->offload_msg.offload = st->offload;
> +
> +	return spi_optimize_message(st->spi, &st->offload_msg);
> +}

...

> +static int ad4052_set_oversampling_ratio(struct iio_dev *indio_dev,
> +					 const struct iio_chan_spec *chan,
> +					 unsigned int val)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if ((val) < 1 || (val) > BIT(st->chip->max_avg + 1))

Too many parentheses.

> +		return -EINVAL;
> +
> +	/* 1 disables oversampling */
> +	if (val == 1) {
> +		st->mode = AD4052_SAMPLE_MODE;
> +	} else {
> +		val = ilog2(val);
> +		st->mode = AD4052_BURST_AVERAGING_MODE;
> +		ret = regmap_write(st->regmap, AD4052_REG_AVG_CONFIG, val - 1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ad4052_update_xfer_raw(indio_dev, chan);
> +
> +	return 0;
> +}

...

> +static int ad4052_get_oversampling_ratio(struct ad4052_state *st,
> +					 unsigned int *val)
> +{
> +	int ret;
> +
> +	if (st->mode == AD4052_SAMPLE_MODE) {
> +		*val = 1;
> +		return 0;
> +	}
> +
> +	ret = regmap_read(st->regmap, AD4052_REG_AVG_CONFIG, val);
> +	if (ret)
> +		return ret;
> +
> +	*val = BIT(*val + 1);

Please, introduce a local variable and use it. This one looks bad because it
will write into output knowing when it's an error case.

> +	return 0;
> +}

...

> +static int ad4052_set_sampling_freq(struct ad4052_state *st, unsigned int freq)
> +{
> +	struct pwm_state pwm_st;
> +
> +	if (freq <= 0 || freq > AD4052_MAX_RATE(st->grade))

in_range() from minmax.h?

> +		return -EINVAL;
> +
> +	pwm_get_state(st->cnv_pwm, &pwm_st);
> +	pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> +	return pwm_apply_might_sleep(st->cnv_pwm, &pwm_st);
> +}

...

> +static int ad4052_soft_reset(struct ad4052_state *st)
> +{
> +	int ret;
> +
> +	memset(st->buf_reset_pattern, 0xFF, sizeof(st->buf_reset_pattern));
> +	for (int i = 0; i < 3; i++)
> +		st->buf_reset_pattern[6 * (i + 1) - 1] = 0xFE;

Only three times and simple oneliner, can we unroll the loop and show
the indices explicitly? It will help a lot in understanding what the actual
pattern is.

> +	ret = spi_write(st->spi, st->buf_reset_pattern,
> +			sizeof(st->buf_reset_pattern));
> +	if (ret)
> +		return ret;
> +
> +	/* Wait AD4052 reset delay */
> +	fsleep(5000);
> +
> +	return 0;
> +}

...

> +static int ad4052_setup(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);

> +

Unneeded blank line.

> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	u8 val = FIELD_PREP(AD4052_GP_CONF_MODE_MSK_0, AD4052_GP_INTR) |
> +		 FIELD_PREP(AD4052_GP_CONF_MODE_MSK_1, AD4052_GP_DRDY);
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD4052_REG_GP_CONF,
> +				 AD4052_GP_CONF_MODE_MSK_1 | AD4052_GP_CONF_MODE_MSK_0,
> +				 val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(AD4052_INTR_CONF_EN_MSK_0, (AD4052_INTR_EN_EITHER)) |
> +	      FIELD_PREP(AD4052_INTR_CONF_EN_MSK_1, (AD4052_INTR_EN_NEITHER));
> +
> +	ret = regmap_update_bits(st->regmap, AD4052_REG_INTR_CONF,
> +				 AD4052_INTR_CONF_EN_MSK_0 | AD4052_INTR_CONF_EN_MSK_1,
> +				 val);
> +	if (ret)
> +		return ret;

> +	val = 0;
> +	if (scan_type->sign == 's')
> +		val |= AD4052_ADC_MODES_DATA_FORMAT;
> +
> +	st->data_format = val;

Why not simply:

	if (scan_type->sign == 's')
		st->data_format = val | AD4052_ADC_MODES_DATA_FORMAT;
	else
		st->data_format = 0;

?

> +	if (st->grade == AD4052_500KSPS) {
> +		ret = regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG,
> +				   FIELD_PREP(AD4052_TIMER_CONFIG_FS_MASK,
> +					      AD4052_TIMER_CONFIG_300KSPS));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return regmap_write(st->regmap, AD4052_REG_ADC_MODES, val);
> +}

...

> +static int ad4052_request_irq(struct iio_dev *indio_dev)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;

> +	int ret = 0;

Why an assignment?

> +	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp0");
> +	if (ret <= 0)
> +		return ret ? ret : -EINVAL;
> +
> +	ret = devm_request_threaded_irq(dev, ret, NULL,
> +					ad4052_irq_handler_thresh,
> +					IRQF_ONESHOT, indio_dev->name,
> +					indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp1");
> +	if (ret <= 0)

Ahy comparison to 0?

> +		return ret ? ret : -EINVAL;

This is not needed in such a form. Please, read the above API's doc and act
accordingly.

> +	st->gp1_irq = ret;
> +	return devm_request_threaded_irq(dev, ret, NULL,
> +					 ad4052_irq_handler_drdy,
> +					 IRQF_ONESHOT, indio_dev->name,
> +					 st);
> +}

...

> +static int __ad4052_read_chan_raw(struct ad4052_state *st, int *val)
> +{
> +	struct spi_device *spi = st->spi;
> +	int ret;

> +	struct spi_transfer t_cnv = {
> +		.len = 0

Missing comma, but...

> +	};

This all is not needed, just make it

	struct spi_transfer t_cnv = {};

> +	reinit_completion(&st->completion);
> +
> +	if (st->cnv_gp) {
> +		gpiod_set_value_cansleep(st->cnv_gp, 1);

No delay?

> +		gpiod_set_value_cansleep(st->cnv_gp, 0);
> +	} else {
> +		ret = spi_sync_transfer(spi, &t_cnv, 1);
> +		if (ret)
> +			return ret;
> +	}
> +	/*
> +	 * Single sample read should be used only for oversampling and
> +	 * sampling frequency pairs that take less than 1 sec.
> +	 */
> +	ret = wait_for_completion_timeout(&st->completion,
> +					  msecs_to_jiffies(1000));

Where msec_to_jiffies() is defined?

> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	ret = spi_sync_transfer(spi, &st->xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (st->xfer.len == 2) {
> +		*val = be16_to_cpu(st->d16);
> +		if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT)
> +			*val = sign_extend32(*val, 15);

Where sign_extend32() is defined?

> +	} else {
> +		*val = be32_to_cpu(st->d32);
> +		if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT)
> +			*val = sign_extend32(*val, 23);
> +	}
> +
> +	return ret;
> +}

...

> +static int ad4052_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	struct pwm_state pwm_st;
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	if (st->wait_event) {

> +		iio_device_release_direct(indio_dev);
> +		return -EBUSY;

Inconsistent approach, use the same goto.

> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ad4052_read_chan_raw(indio_dev, val);
> +		if (ret)
> +			goto out_release;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = ad4052_get_oversampling_ratio(st, val);
> +		if (ret)
> +			goto out_release;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = pwm_get_state_hw(st->cnv_pwm, &pwm_st);
> +		if (ret)
> +			goto out_release;
> +
> +		if (!pwm_st.enabled)
> +			pwm_get_state(st->cnv_pwm, &pwm_st);
> +
> +		*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, pwm_st.period);
> +
> +		ret = IIO_VAL_INT;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret;

You may have a great deal of reducing or at least making this readable if split
to two, one is claim_direct wrapped.

> +}
> +
> +static int ad4052_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long info)

Ditto for the above function. At least try and see the result. I believe that
it might even shrink number of LoCs.

...

> +static int ad4052_monitor_mode_disable(struct ad4052_state *st)
> +{
> +	int ret;
> +
> +	pm_runtime_mark_last_busy(&st->spi->dev);
> +	pm_runtime_put_autosuspend(&st->spi->dev);
> +
> +	ret = ad4052_exit_command(st);

> +

Unneeded blank line.

> +	if (ret)
> +		pm_runtime_resume_and_get(&st->spi->dev);
> +
> +	return ret;
> +}

...

> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	u8 reg, size = 1;

Make size assignment explicit in each case, it will help a lot for both:
maintaining in long term and reading the code.

> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	if (st->wait_event) {
> +		iio_device_release_direct(indio_dev);
> +		return -EBUSY;
> +	}
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (dir == IIO_EV_DIR_RISING)
> +			reg = AD4052_REG_MAX_LIMIT;
> +		else
> +			reg = AD4052_REG_MIN_LIMIT;
> +		size = 2;
> +		break;
> +	case IIO_EV_INFO_HYSTERESIS:
> +		if (dir == IIO_EV_DIR_RISING)
> +			reg = AD4052_REG_MAX_HYST;
> +		else
> +			reg = AD4052_REG_MIN_HYST;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto out_release;
> +	}
> +
> +	ret = regmap_bulk_read(st->regmap, reg, &st->d32, size);
> +	if (ret)
> +		goto out_release;
> +
> +	if (reg == AD4052_REG_MAX_LIMIT || reg == AD4052_REG_MIN_LIMIT) {
> +		*val = be16_to_cpu(st->d16);
> +		if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT)
> +			*val = sign_extend32(*val, 11);

Better pattern is to use local variable and assign if and only if the function
returns success.

> +	} else {
> +		*val = be32_to_cpu(st->d32);
> +	}
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret ? ret : IIO_VAL_INT;

Again, try with a wrapper.

> +}

...

> +static int ad4052_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int val,
> +				    int val2)

Same comments as per previous one.

> +static int ad4052_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	pwm_disable(st->cnv_pwm);
> +
> +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> +	spi_unoptimize_message(&st->offload_msg);
> +	enable_irq(st->gp1_irq);
> +
> +	ret = ad4052_exit_command(st);

You leave IRQ enabled even in error case, is it on purpose?

> +	pm_runtime_mark_last_busy(&st->spi->dev);
> +	pm_runtime_put_autosuspend(&st->spi->dev);
> +
> +	return ret;
> +}

...

> +static int ad4052_request_offload(struct iio_dev *indio_dev)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct dma_chan *rx_dma;
> +	struct spi_offload_trigger_info trigger_info = {
> +		.fwnode = dev_fwnode(dev),
> +		.ops = &ad4052_offload_trigger_ops,
> +		.priv = st,
> +	};
> +	struct pwm_state pwm_st;
> +	int ret;
> +
> +	indio_dev->setup_ops = &ad4052_buffer_setup_ops;
> +
> +	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to register offload trigger\n");

One line?

> +	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
> +							   SPI_OFFLOAD_TRIGGER_DATA_READY);
> +	if (IS_ERR(st->offload_trigger))
> +		return PTR_ERR(st->offload_trigger);
> +
> +	st->cnv_pwm = devm_pwm_get(dev, NULL);
> +	if (IS_ERR(st->cnv_pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm),
> +				     "failed to get CNV PWM\n");

Can be one line (you already have above 91 character long line).

> +	pwm_init_state(st->cnv_pwm, &pwm_st);
> +
> +	pwm_st.enabled = false;
> +	pwm_st.duty_cycle = AD4052_T_CNVH_NS * 2;

> +	pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> +					 AD4052_MAX_RATE(st->grade));

It can be one line (83 characters).


> +	ret = pwm_apply_might_sleep(st->cnv_pwm, &pwm_st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to apply CNV PWM\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad4052_pwm_disable, st->cnv_pwm);
> +	if (ret)
> +		return ret;
> +
> +	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
> +	if (IS_ERR(rx_dma))
> +		return PTR_ERR(rx_dma);
> +
> +	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
> +							   IIO_BUFFER_DIRECTION_IN);
> +}

...

> +static int ad4052_probe(struct spi_device *spi)
> +{
> +	const struct ad4052_chip_info *chip;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4052_state *st;

> +	int ret = 0;

What is this for?

> +	chip = spi_get_device_match_data(spi);
> +	if (!chip)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Could not find chip info data\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	spi_set_drvdata(spi, st);
> +	init_completion(&st->completion);
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ad4052_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	st->mode = AD4052_SAMPLE_MODE;
> +	st->wait_event = false;
> +	st->chip = chip;
> +	st->grade = chip->prod_id <= 0x75 ? AD4052_2MSPS : AD4052_500KSPS;
> +	st->oversampling_frequency = AD4052_FS_OFFSET(st->grade);
> +	st->events_frequency = AD4052_FS_OFFSET(st->grade);
> +
> +	st->cnv_gp = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->cnv_gp))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_gp),
> +				     "Failed to get cnv gpio\n");
> +
> +	indio_dev->modes = INDIO_BUFFER_HARDWARE | INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ad4052_info;
> +	indio_dev->name = chip->name;
> +
> +	st->offload = devm_spi_offload_get(dev, spi, &ad4052_offload_config);
> +	if (IS_ERR(st->offload))
> +		return PTR_ERR(st->offload);

> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get offload\n");

Huh?! Leftover?

> +	if (ret == -ENODEV) {
> +		st->offload_trigger = NULL;
> +		indio_dev->channels = chip->channels;

How this is not a dead code, please?

> +	} else {
> +		indio_dev->channels = chip->offload_channels;
> +		ret = ad4052_request_offload(indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to configure offload\n");
> +	}
> +
> +	st->xfer.rx_buf = &st->d32;
> +
> +	ret = ad4052_soft_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "AD4052 failed to soft reset\n");
> +
> +	ret = ad4052_check_ids(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "AD4052 fields assertions failed\n");
> +
> +	ret = ad4052_setup(indio_dev, indio_dev->channels);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS,
> +			   AD4052_DEVICE_STATUS_DEVICE_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4052_request_irq(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ad4052_update_xfer_raw(indio_dev, indio_dev->channels);
> +
> +	pm_runtime_set_active(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable pm_runtime\n");
> +
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

...

> +static int ad4052_runtime_resume(struct device *dev)
> +{
> +	struct ad4052_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
> +			   FIELD_PREP(AD4052_DEVICE_CONFIG_POWER_MODE_MSK, 0));
> +	return ret;

Redundant local variable.

> +}

-- 
With Best Regards,
Andy Shevchenko



