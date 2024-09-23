Return-Path: <linux-pwm+bounces-3339-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6EC97EAE5
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 13:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B7ACB20FDA
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5567196C86;
	Mon, 23 Sep 2024 11:43:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB626197A7B;
	Mon, 23 Sep 2024 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091795; cv=none; b=dGlWJ5YKB50JcGFtt51Cl2+/pDLHiFwKbGB5VVTQxKYsxGmOmeuMSuerzcV/XZsQSltEpQ2d2UlBAtGRB+zBhufNgcOIefN07+D6MQnc2UcfqCeO+0QjhRQsWoWo3wDxtnBjJuSc6ZsIHOikVEte+PvX4F0re+X81YIpLiSe1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091795; c=relaxed/simple;
	bh=q+xYM8ruVi403qynBdAGESqa1zGxdzeCB+4HjE5+SnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrWkXSgu/K2Sk50W92FujycZ2p+nIbUyED6N9BFsQgBljJwuHw7mQeIgodRltiEUmUUN2TeK+sxcoKuv3fWYNHXKFx4TWpTEPSVS6rU7gNmdKlTKAdzfn0B3e1b0KqUu73hwgTi3xLT2FXLmILGo568ateTKW9uoRH6qjcrEJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: gQYITI9hQJCWzG5yahYh/g==
X-CSE-MsgGUID: +DJutFgHRTyiXYIZNpFYGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26225279"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="26225279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:43:13 -0700
X-CSE-ConnectionGUID: QC95i8t3Q66hQxv8II8OFg==
X-CSE-MsgGUID: x913OYUvQ2+fojH+GrLaPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71352475"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 04:43:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1sshT6-0000000ByP9-0Rm5;
	Mon, 23 Sep 2024 14:43:04 +0300
Date: Mon, 23 Sep 2024 14:43:03 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Dumitru Ceclan <mitrutzceclan@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <ZvFUR-mZJ4XufcAE@smile.fi.intel.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-7-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923101206.3753-7-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 23, 2024 at 01:10:23PM +0300, Antoniu Miclaus wrote:
> Add support for the AD485X DAS familiy.

...

> +#include <asm/unaligned.h>

It's better to move this after linux/*.h

> +#include <linux/delay.h>

> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>

This can be split to a group after the other linux/*.h

> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>

Seems missing headers:

+ array_size.h
+ bits.h
+ device.h
+ err.h
+ mod_devicetable.h
+ module.h
+ mutex.h
+ types.h

...

> +static int ad485x_set_sampling_freq(struct ad485x_state *st, unsigned int freq)
> +{
> +	struct pwm_state cnv_state = {
> +		.duty_cycle = AD485X_T_CNVH_NS,
> +		.enabled = true,
> +	};
> +	int ret;
> +
> +	if (freq > st->info->throughput)
> +		freq = st->info->throughput;

clamp() ? (will need minmax.h)

> +	cnv_state.period = DIV_ROUND_CLOSEST_ULL(1000000000, freq);

We have time / frequency constants, like HZ_PER_..., NSEC_PER_....

> +	ret = pwm_apply_might_sleep(st->cnv, &cnv_state);
> +	if (ret)
> +		return ret;
> +
> +	st->sampling_freq = freq;
> +
> +	return 0;
> +}
> +
> +static int ad485x_setup(struct ad485x_state *st)
> +{
> +	unsigned int product_id;
> +	int ret;
> +
> +	ret = ad485x_set_sampling_freq(st, 1000000);

Ditto.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_INTERFACE_CONFIG_A,
> +			   AD485X_SW_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_INTERFACE_CONFIG_B,
> +			   AD485X_SINGLE_INSTRUCTION);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_INTERFACE_CONFIG_A,
> +			   AD485X_SDO_ENABLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_PRODUCT_ID_L, &product_id);
> +	if (ret)
> +		return ret;
> +
> +	if (product_id != st->info->product_id)
> +		dev_warn(&st->spi->dev, "Unknown product ID: 0x%02X\n",
> +			 product_id);
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_DEVICE_CTRL,
> +			   AD485X_ECHO_CLOCK_MODE);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD485X_REG_PACKET, 0);
> +}

...

> +static int ad485x_find_opt(bool *field, u32 size, u32 *ret_start)
> +{
> +	int i, cnt = 0, max_cnt = 0, start, max_start = 0;

Why are they signed?

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
> +
> +	if (cnt > max_cnt) {
> +		max_cnt = cnt;
> +		max_start = start;
> +	}
> +
> +	if (!max_cnt)
> +		return -EIO;
> +
> +	*ret_start = max_start;
> +
> +	return max_cnt;
> +}

...

> +static int ad485x_calibrate(struct ad485x_state *st)
> +{
> +	int opt_delay, lane_num, delay, i, s, c;

Why e.g. i is signed?

> +	enum iio_backend_interface_type interface_type;

> +	bool pn_status[AD485X_MAX_LANES][AD485X_MAX_IODELAY];

Why not a bitmap?

> +	int ret;

> +}

...

> +static const char *const ad4858_packet_fmts[] = {
> +	"20-bit", "24-bit", "32-bit"

Leave trailing comma, it may help extending the list in case it becomes a
multi-line.

> +};
> +
> +static const char *const ad4857_packet_fmts[] = {
> +	"16-bit", "24-bit"

Ditto.

> +};

...

> +static int ad485x_get_packet_format(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan)
> +{
> +	struct ad485x_state *st = iio_priv(indio_dev);
> +	unsigned int format;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_PACKET, &format);
> +	if (ret)
> +		return ret;

> +	format = FIELD_GET(AD485X_PACKET_FORMAT_MASK, format);
> +
> +	return format;

	return  FIELD_GET(...);

> +}

> +static int ad485x_get_calibscale(struct ad485x_state *st, int ch, int *val,
> +				 int *val2)

One line?

...

> +	ret = regmap_read(st->regmap, AD485X_REG_CHX_GAIN_MSB(ch),
> +			  &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain = (reg_val & 0xFF) << 8;
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_CHX_GAIN_LSB(ch),
> +			  &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	gain |= reg_val & 0xFF;

Why not bulk read and proper __le16/__be16 type?

...

> +static int ad485x_set_calibscale(struct ad485x_state *st, int ch, int val,
> +				 int val2)
> +{
> +	unsigned long long gain;
> +	unsigned int reg_val;
> +	int ret;
> +
> +	gain = val * 1000000 + val2;

MICRO?

> +	gain = gain * 32768;
> +	gain = DIV_U64_ROUND_CLOSEST(gain, 1000000);

Can be combined into one lien.

> +	reg_val = gain;

...

> +	ret = regmap_write(st->regmap, AD485X_REG_CHX_GAIN_MSB(ch),
> +			   reg_val >> 8);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD485X_REG_CHX_GAIN_LSB(ch),
> +			    reg_val & 0xFF);

Bulk write?

> +}

...

> +	ret = regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_MSB(ch),
> +			  &msb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_MID(ch),
> +			  &mid);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_LSB(ch),
> +			  &lsb);
> +	if (ret)
> +		return ret;

Bulk read?

> +	if (st->info->resolution == 16) {
> +		*val = msb << 8;
> +		*val |= mid;
> +		*val = sign_extend32(*val, 15);

So, please use respective byteorder conversions...

> +	} else {
> +		*val = msb << 12;
> +		*val |= mid << 4;
> +		*val |= lsb >> 4;
> +		*val = sign_extend32(*val, 19);

...here as well (we have _be14()/_le24 ones).

> +	}

...

> +static int ad485x_set_calibbias(struct ad485x_state *st, int ch, int val,
> +				int val2)
> +{
> +	unsigned int lsb, mid, msb;
> +	int ret;
> +
> +	if (st->info->resolution == 16) {
> +		lsb = 0;
> +		mid = val & 0xFF;
> +		msb = (val >> 8) & 0xFF;
> +	} else {
> +		lsb = (val << 4) & 0xFF;
> +		mid = (val >> 4) & 0xFF;
> +		msb = (val >> 12) & 0xFF;
> +	}

Ditto.

> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_LSB(ch), lsb);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_MID(ch), mid);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_MSB(ch), msb);

Bulk write?

> +}

...

> +static const unsigned int ad485x_scale_table[][2] = {
> +	{2500, 0x0}, {5000, 0x1}, {5000, 0x2}, {10000, 0x3}, {6250, 0x04},
> +	{12500, 0x5}, {10000, 0x6}, {20000, 0x7}, {12500, 0x8}, {25000, 0x9},
> +	{20000, 0xA}, {40000, 0xB}, {25000, 0xC}, {50000, 0xD}, {40000, 0xE},
> +	{80000, 0xF}

It's more natural to list them in pow-of-two per line manner.
Moreover the last item is redundant. It's equal to the index. Why do you need it?

> +};

...

> +static const int ad4857_offset_table[] = {
> +	0, -32768

Here, and above and everywhere else in such cases leave a trailing comma.

> +};

...

> +	for (i = 0; i < info->num_scales; i++) {
> +		__ad485x_get_scale(st, info->scale_table[i][0],
> +				   &scale_val[0], &scale_val[1]);



> +		if (scale_val[0] != val || scale_val[1] != val2)
> +			continue;
> +
> +		/*
> +		 * Adjust the softspan value (differential or single ended)
> +		 * based on the scale value selected and current offset of
> +		 * the channel.
> +		 *
> +		 * If the offset is 0 then continue iterations until finding
> +		 * the next matching scale value which always corresponds to
> +		 * the single ended mode.
> +		 */
> +		if (!st->offsets[chan->channel] && !j) {
> +			j++;

So, j may be named properly and be boolean for the sake of the semantic usage.

> +			continue;
> +		}
> +
> +		return regmap_write(st->regmap,
> +				    AD485X_REG_CHX_SOFTSPAN(chan->channel),
> +				    info->scale_table[i][1]);
> +	}

...

> +{
> +	guard(mutex)(&st->lock);
> +
> +	if (st->offsets[chan->channel] != val) {

Invert and drop indentation for the next lines.

> +		st->offsets[chan->channel] = val;
> +		/* Restore to the default range if offset changes */
> +		if (st->offsets[chan->channel])
> +			return regmap_write(st->regmap,
> +						AD485X_REG_CHX_SOFTSPAN(chan->channel),
> +						AD485X_SOFTSPAN_N40V_40V);
> +		return regmap_write(st->regmap,
> +					AD485X_REG_CHX_SOFTSPAN(chan->channel),
> +					AD485X_SOFTSPAN_0V_40V);
> +	}
> +
> +	return 0;
> +}

...

> +static int ad485x_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad485x_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->sampling_freq;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad485x_get_calibscale(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad485x_get_scale(st, chan, val, val2);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		return ad485x_get_calibbias(st, chan->channel, val, val2);
> +	case IIO_CHAN_INFO_OFFSET:
> +		scoped_guard(mutex, &st->lock)
> +			* val = st->offsets[chan->channel];

This is interesting white space location...

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +	struct ad485x_state *st = iio_priv(indio_dev);
> +	unsigned int c;
> +	int ret;
> +
> +	for (c = 0; c < st->info->num_channels; c++) {
> +		if (test_bit(c, scan_mask))

Do we have a helper now for this iterator?

> +			ret = iio_backend_chan_enable(st->back, c);
> +		else
> +			ret = iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}

...

> +static struct iio_chan_spec_ext_info ad4858_ext_info[] = {
> +	IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> +	IIO_ENUM_AVAILABLE("packet_format",
> +			   IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> +	{},

Please, drop comma in the terminator lines.

> +};

...

> +static const struct ad485x_chip_info ad4858i_info = {
> +	.name = "ad4858i",
> +	.product_id = AD4858I_PROD_ID,
> +	.scale_table = ad485x_scale_table,
> +	.num_scales = ARRAY_SIZE(ad485x_scale_table),
> +	.offset_table = ad4858_offset_table,
> +	.num_offset = ARRAY_SIZE(ad4858_offset_table),
> +	.channels = ad4858_channels,
> +	.num_channels = ARRAY_SIZE(ad4858_channels),
> +	.throughput = 1000000,

How many people wrote this patch? It has inconsistency at least in multipliers
like this all over the code. Who knows what's else also being inconsistent...

> +	.resolution = 20,
> +};

...

> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(7),
> +};

Why do you need regmap lock?

...

> +static const char * const ad485x_power_supplies[] = {
> +	"vcc",	"vdd",	"vddh", "vio"

Leave trailing comma.

> +};

...

> +static int ad485x_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad485x_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;

> +	mutex_init(&st->lock);

Why not devm?

> +	ret = devm_regulator_bulk_get_enable(&spi->dev,
> +					     ARRAY_SIZE(ad485x_power_supplies),
> +					     ad485x_power_supplies);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "failed to get and enable supplies\n");
> +
> +	st->cnv = devm_pwm_get(&spi->dev, NULL);
> +	if (IS_ERR(st->cnv))
> +		return PTR_ERR(st->cnv);
> +
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
> +	st->regmap = devm_regmap_init_spi(spi, &regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ad485x_scale_offset_fill(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad485x_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->channels = st->info->channels;
> +	indio_dev->num_channels = st->info->num_channels;
> +	indio_dev->info = &ad485x_info;
> +
> +	st->back = devm_iio_backend_get(&spi->dev, NULL);
> +	if (IS_ERR(st->back))
> +		return PTR_ERR(st->back);
> +
> +	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(&spi->dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad485x_calibrate(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko



