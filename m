Return-Path: <linux-pwm+bounces-8236-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIEXB7fYsWlPFwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8236-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 22:03:51 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5EE26A3D0
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 22:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA01305B099
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 21:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7512FDC20;
	Wed, 11 Mar 2026 21:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXQ0sYW/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BEE2DB78E;
	Wed, 11 Mar 2026 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263027; cv=none; b=VSm+ZAYQOBatzSn8oN9+q2jllLeEvMvhOrCIUca5fmrdmjQjul3LWKd5aMKyuSFHE+bEqk3sO9WZvjUtFSl7SLYRWpCxoGjnaoO1hZll0Au54yHFbDSD7pUS9e3P6fCImhRQ5HytAJEKQh08gbZpQ2lU/2BaMLimfA3KlRrKpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263027; c=relaxed/simple;
	bh=XKcghGsmODJgD7o1S6Hr+XH9Mqwh8kpeIKrEjcANRkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nf8QxvikIzGTov80AQsgebGuByxE3OB5Ysq2qswqLTIUpkL1iOspfdFokqeyA1Lr2vaZFW9ivw60+zwfT2sdKD7R9yhAtMqMDzjCcLch+pL0Di+R7Q6qKhCzSpSpBTTuineZx9S3Dfh6sgaHniD0UQssp2tyAE9qrjWu0EyRgOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXQ0sYW/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773263026; x=1804799026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XKcghGsmODJgD7o1S6Hr+XH9Mqwh8kpeIKrEjcANRkY=;
  b=NXQ0sYW/74rTelNuhpl1naQyhg4AnqKk3q7PrnzgZQE9ls2681bsLA17
   jYjXj3HmNKiDJ581CSh6t0jdfCTfldH6qaSiCHkGymmXsxHioc36kvZqM
   XZI9dQgWPCd9OWSIhCdYrLd6fNLRzjaWzF8fc0B5/mCGKktSYfkLegT61
   sXD7wQKjtTQaR46DClctdME4GiUpZDRHaOtz+rJR2tLmZotBvZretPyLQ
   ukvA7KaRZ2TYYDcNl64w0hMQKF1bUptJfop8uf8pwpxOsbyFGblU6nUHD
   8GHizygppBXDHsm5stGB+m3PNWVyHpBM5NtDpK7KziRe7/pkmD0YEyCuY
   g==;
X-CSE-ConnectionGUID: 9f1htcEiRRGvif5VO77bBg==
X-CSE-MsgGUID: Oqdwk2EkT+WAGPWcHnOoLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85823943"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="85823943"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 14:03:45 -0700
X-CSE-ConnectionGUID: w7nu8sBmTmG8dLC6ZL3A0Q==
X-CSE-MsgGUID: OImJDmfUR+up1tp5SSqWRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="225572944"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.178])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 14:03:41 -0700
Date: Wed, 11 Mar 2026 23:03:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <abHYqvZpQrdF_d8a@ashevche-desk.local>
References: <20260310-ad4692-multichannel-sar-adc-driver-v2-0-d9bb8aeb5e17@analog.com>
 <20260310-ad4692-multichannel-sar-adc-driver-v2-2-d9bb8aeb5e17@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-ad4692-multichannel-sar-adc-driver-v2-2-d9bb8aeb5e17@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8236-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ashevche-desk.local:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 7D5EE26A3D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 10, 2026 at 04:32:23PM +0200, Radu Sabau via B4 Relay wrote:

> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
> 
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
> 
> Two buffered operating modes are supported, auto-detected from the
> device tree:
> 
>     - CNV Clock Mode:  an external PWM drives the CNV pin; the sampling
>                        rate is controlled via the PWM period. Requires a
>                        reference clock and a DATA_READY interrupt.
> 
>     - Manual Mode:     CNV is tied to SPI CS; each SPI transfer triggers
>                        a conversion and returns the previous result
>                        (pipelined). No external clock or interrupt needed.
> 
> In both modes the chip idles in Autonomous Mode so that single-shot
> read_raw can use the internal oscillator without disturbing the
> hardware configuration.

...

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>

> +#include <linux/kernel.h>

Just no.

> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/util_macros.h>
> +#include <linux/units.h>
> +#include <linux/unaligned.h>

...

> +#define AD4691_VREF_MIN				2400000
> +#define AD4691_VREF_MAX				5250000

What are the units? _uV ?

#define AD4691_VREF_uV_MIN				2400000
#define AD4691_VREF_uV_MAX				5250000

...

> +#define AD4691_NOOP				0x00
> +#define AD4691_ADC_CHAN(ch)			((0x10 + (ch)) << 3)
> +
> +#define AD4691_STATUS_REG			0x14
> +#define AD4691_CLAMP_STATUS1_REG		0x1A
> +#define AD4691_CLAMP_STATUS2_REG		0x1B
> +#define AD4691_DEVICE_SETUP			0x20
> +#define AD4691_REF_CTRL				0x21
> +#define AD4691_OSC_FREQ_REG			0x23
> +#define AD4691_STD_SEQ_CONFIG			0x25
> +#define AD4691_SPARE_CONTROL			0x2A
> +
> +#define AD4691_OSC_EN_REG			0x180

Make all register offsets equal in width, id est the above will be 0x023
and so on.

> +#define AD4691_STATE_RESET_REG			0x181
> +#define AD4691_ADC_SETUP			0x182
> +#define AD4691_ACC_MASK1_REG			0x184
> +#define AD4691_ACC_MASK2_REG			0x185
> +#define AD4691_ACC_COUNT_LIMIT(n)		(0x186 + (n))
> +#define AD4691_ACC_COUNT_VAL			0x3F
> +#define AD4691_GPIO_MODE1_REG			0x196
> +#define AD4691_GPIO_MODE2_REG			0x197
> +#define AD4691_GPIO_READ			0x1A0
> +#define AD4691_ACC_STATUS_FULL1_REG		0x1B0
> +#define AD4691_ACC_STATUS_FULL2_REG		0x1B1
> +#define AD4691_ACC_STATUS_OVERRUN1_REG		0x1B2
> +#define AD4691_ACC_STATUS_OVERRUN2_REG		0x1B3
> +#define AD4691_ACC_STATUS_SAT1_REG		0x1B4
> +#define AD4691_ACC_STATUS_SAT2_REG		0x1BE
> +#define AD4691_ACC_SAT_OVR_REG(n)		(0x1C0 + (n))
> +#define AD4691_AVG_IN(n)			(0x201 + (2 * (n)))
> +#define AD4691_AVG_STS_IN(n)			(0x222 + (3 * (n)))
> +#define AD4691_ACC_IN(n)			(0x252 + (3 * (n)))
> +#define AD4691_ACC_STS_DATA(n)			(0x283 + (4 * (n)))

...

> +enum ad4691_ref_ctrl {
> +	AD4691_VREF_2P5 = 0,
> +	AD4691_VREF_3P0,
> +	AD4691_VREF_3P3,
> +	AD4691_VREF_4P096,
> +	AD4691_VREF_5P0,

Is it HW related? Make sure you have _all_ of that being assigned explicitly.
Otherwise drop the standard assignment (if it's Linux enum). Ditto rule of
thumb to *all* enums in the code here and in the future.

This can be written on your internal Wiki page for the internal review rounds.

> +};

...

> +	int num_channels;
> +	int max_rate;

Why are they signed?

...

> +static const struct ad4691_chip_info ad4691_ad4691 = {
> +	.channels = ad4691_channels,
> +	.manual_channels = ad4691_manual_channels,
> +	.name = "ad4691",
> +	.num_channels = ARRAY_SIZE(ad4691_channels),
> +	.max_rate = 500000,

500 * HZ_PER_KHZ

> +};
> +
> +static const struct ad4691_chip_info ad4691_ad4692 = {
> +	.channels = ad4691_channels,
> +	.manual_channels = ad4691_manual_channels,
> +	.name = "ad4692",
> +	.num_channels = ARRAY_SIZE(ad4691_channels),
> +	.max_rate = 1000000,

1 * HZ_PER_MHZ

> +};
> +
> +static const struct ad4691_chip_info ad4691_ad4693 = {
> +	.channels = ad4693_channels,
> +	.manual_channels = ad4693_manual_channels,
> +	.name = "ad4693",
> +	.num_channels = ARRAY_SIZE(ad4693_channels),
> +	.max_rate = 500000,

...and so on...

> +};
> +
> +static const struct ad4691_chip_info ad4691_ad4694 = {
> +	.channels = ad4693_channels,
> +	.manual_channels = ad4693_manual_channels,
> +	.name = "ad4694",
> +	.num_channels = ARRAY_SIZE(ad4693_channels),
> +	.max_rate = 1000000,
> +};

...

> +struct ad4691_state {
> +	const struct ad4691_chip_info	*chip;

> +	struct spi_device		*spi;

Why? regmap has reference to struct device. This should be enough.

> +	struct regmap			*regmap;
> +
> +	unsigned long			ref_clk_rate;
> +	struct pwm_device		*conv_trigger;
> +
> +	enum ad4691_adc_mode		adc_mode;
> +
> +	int				vref;

Units? _uV?

	int				vref_uV;

> +	u64				cnv_period;
> +	/*
> +	 * Synchronize access to members of the driver state, and ensure
> +	 * atomicity of consecutive SPI operations.
> +	 */
> +	struct mutex			lock;
> +};

...

> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +		ret = spi_write_then_read(st->spi, tx, 2, rx, 1);
> +		if (!ret)
> +			*val = rx[0];

Regular pattern, please.

		if (ret)
			return ret;
		...
		return 0;

> +		return ret;
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +		ret = spi_write_then_read(st->spi, tx, 2, rx, 2);
> +		if (!ret)
> +			*val = get_unaligned_be16(rx);
> +		return ret;
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +		ret = spi_write_then_read(st->spi, tx, 2, rx, 3);
> +		if (!ret)
> +			*val = get_unaligned_be24(rx);
> +		return ret;
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		ret = spi_write_then_read(st->spi, tx, 2, rx, 4);
> +		if (!ret)
> +			*val = get_unaligned_be32(rx);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +	.cache_type = REGCACHE_RBTREE,

Why not MAPLE?

...

> +static int ad4691_get_sampling_freq(struct ad4691_state *st)
> +{
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
> +					     ktime_to_ns(st->sampling_period));
> +	}

Unneeded {}, why 64-bit division?

> +
> +	return DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,
> +				     pwm_get_period(st->conv_trigger));

Ditto.

> +}

...

> +static int ad4691_pwm_get(struct spi_device *spi, struct ad4691_state *st)

Is spi used at all here? I do not see it. Why not drop it and take struct
device from regmap? Same question to the entire code.

...

> +		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL
> +			(NSEC_PER_SEC, freq));

Bad indentation.

...

> +	if (!freq || freq > st->chip->max_rate)
> +		return -EINVAL;

ERANGE ?

...

> +	unsigned long conv_us = DIV_ROUND_UP(2UL * USEC_PER_SEC,

Why UL?

> +					     st->chip->max_rate);

Also it's harder to read. Split this assignment to be closer for its first
user.

...

> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK1_REG, mask & 0xFF);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK2_REG, (mask >> 8) & 0xFF);
> +	if (ret)
> +		return ret;

Why not bulk write?

...

> +static int ad4691_gpio_setup(struct ad4691_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct gpio_desc *reset;
> +
> +	reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset),
> +				     "Failed to get reset GPIO\n");
> +
> +	/* Reset delay required. See datasheet Table 5. */
> +	fsleep(300);
> +	gpiod_set_value(reset, 0);
> +
> +	return 0;
> +}

Use reset-gpio instead.

...

> +		ret = regmap_write(st->regmap, AD4691_REF_CTRL,
> +				   FIELD_PREP(AD4691_REF_CTRL_MASK,
> +					      AD4691_VREF_3P0));

Make the second line a bit longer. Ditto for the rest.

> +		break;
> +	case 3250001 ... 3750000:
> +		ret = regmap_write(st->regmap, AD4691_REF_CTRL,
> +				   FIELD_PREP(AD4691_REF_CTRL_MASK,
> +					      AD4691_VREF_3P3));
> +		break;
> +	case 3750001 ... 4500000:
> +		ret = regmap_write(st->regmap, AD4691_REF_CTRL,
> +				   FIELD_PREP(AD4691_REF_CTRL_MASK,
> +					      AD4691_VREF_4P096));
> +		break;
> +	case 4500001 ... AD4691_VREF_MAX:
> +		ret = regmap_write(st->regmap, AD4691_REF_CTRL,
> +				   FIELD_PREP(AD4691_REF_CTRL_MASK,
> +					      AD4691_VREF_5P0));
> +		break;

It's all the repetitions of the same regmap_write. Prepare value instead of ret
inside the switch and call regmap_write() only once after it.

...

> +static int ad4691_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4691_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;

> +	st->spi = spi;

No need.

> +	st->regmap = devm_regmap_init(dev, NULL, st, &ad4691_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	st->chip = spi_get_device_match_data(spi);

> +	if (!st->chip)
> +		return dev_err_probe(dev, -ENODEV, "Could not find chip info\n");

We agreed to avoid this dead code.

> +	ret = ad4691_regulator_get(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4691_gpio_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4691_config(st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->chip->name;
> +	indio_dev->info = &ad4691_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	indio_dev->channels = (st->adc_mode == AD4691_MANUAL_MODE)
> +		? st->chip->manual_channels : st->chip->channels;

Locate ? on the previous line

> +	indio_dev->num_channels = st->chip->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


-- 
With Best Regards,
Andy Shevchenko



