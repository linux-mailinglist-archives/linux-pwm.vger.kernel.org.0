Return-Path: <linux-pwm+bounces-8388-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICNPNiltxmmkJwUAu9opvQ
	(envelope-from <linux-pwm+bounces-8388-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 12:42:33 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB0A343A2C
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 12:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EABB1308840D
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 11:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E55395240;
	Fri, 27 Mar 2026 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEJ/zDcq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE53921D8;
	Fri, 27 Mar 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611392; cv=none; b=UdxUtRLqT0KSE3bT27e+PUI35n9ID39ScMbUQ7wnIjY6K0eLMJmCG6dHB+1+jzcHUkdBBOdq+OZ/lx8BPzsq38YHAf4s3C/zSqRptfiH4RBbw9UvFcnQtKXoAMe4iV/bJzR0hf4X2xBwsFjTf1P3BF5gufLGkvvoV+PpMIBDU+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611392; c=relaxed/simple;
	bh=BwuVAlS1WQBp2ZvGwb0RNnOh7+zck+YFMiwPvgLg6B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtHHrfIhenjyT7oMLpR3uRkbbht5JFcHrl9wpLa6wBLsoyhXnmO1NdlKkhlTeCDnCegwEzKrYczsWfbRYitNERO4u2ki9fdQBt+YPjKP57jKpjDXgT5ZqxEZ8uKzsVpGYaZmD+wuMOQsNJu1m10AGbPN/xmRuqzXNqL8qBWQLu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEJ/zDcq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774611392; x=1806147392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BwuVAlS1WQBp2ZvGwb0RNnOh7+zck+YFMiwPvgLg6B0=;
  b=FEJ/zDcq8T7P00RhiCFu7mA+y5tCLcM/EiOt5zeQzSpEgonaHeZzZqbR
   kvAN/eUuGRd0ArcUJk1sN9joao4FDen69m6V/WkD7fDLQekANFoH3LY4n
   SVkO0Lowofmj9O7iRaY5NI0B2RebN2UmFxdZy+EM4/Bn7yWZfOFW1ERzF
   4HpIOHYFK+Nux9SIFkbDI0dZrIS3MPq3C1x/lG7j9I2Q5/Hkeq/H0Xs2c
   oECgag7jB8EdU9YZNwDjKkyEXaKk66WAB/WbOkT3Oj4KuFpQpuGGsnv6E
   1DoJ/JW9dQivpHXMlGPo6X1aFuFCsKrosY/qqJTqZ7Nymtg7jhIgg1SSz
   g==;
X-CSE-ConnectionGUID: 1Og1V1jwTCaiDwi46jN3iA==
X-CSE-MsgGUID: sbSnKvbORMii4WKy2VCc5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="85990005"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="85990005"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:36:31 -0700
X-CSE-ConnectionGUID: e0OPuncfQ2G4mWJdIl6FfQ==
X-CSE-MsgGUID: 6Xwp7fUzTka7Gj2k6P7w9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="229371935"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:36:24 -0700
Date: Fri, 27 Mar 2026 13:36:22 +0200
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
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <acZrthJYQX-h_9p5@ashevche-desk.local>
References: <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
 <20260327-ad4692-multichannel-sar-adc-driver-v5-2-11f789de47b8@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-ad4692-multichannel-sar-adc-driver-v5-2-11f789de47b8@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8388-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: DEB0A343A2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:07:58PM +0200, Radu Sabau via B4 Relay wrote:

> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
> 
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
> 
> The chip idles in Autonomous Mode so that single-shot read_raw can use
> the internal oscillator without disturbing the hardware configuration.
> 
> Three voltage supply domains are managed: avdd (required), vio, and a
> reference supply on either the REF pin (ref-supply, external buffer)
> or the REFIN pin (refin-supply, uses the on-chip reference buffer;
> REFBUF_EN is set accordingly). Hardware reset is performed via
> the reset controller framework; a software reset through SPI_CONFIG_A
> is used as fallback when no hardware reset is available.
> 
> Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> 16-bit transfer.

...

+ array_size.h

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>

Hmm... Is it used? Or perhaps you need only
dev_printk.h
device/devres.h
?

> +#include <linux/err.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +#include <linux/unaligned.h>

...

> +/*
> + * Internal oscillator frequency table. Index is the OSC_FREQ_REG[3:0] value.
> + * Index 0 (1 MHz) is only valid for AD4692/AD4694; AD4691/AD4693 support
> + * up to 500 kHz and use index 1 as their highest valid rate.
> + */
> +static const int ad4691_osc_freqs[] = {
> +	1000000,	/* 0x0: 1 MHz */
> +	500000,		/* 0x1: 500 kHz */
> +	400000,		/* 0x2: 400 kHz */
> +	250000,		/* 0x3: 250 kHz */
> +	200000,		/* 0x4: 200 kHz */
> +	167000,		/* 0x5: 167 kHz */
> +	133000,		/* 0x6: 133 kHz */
> +	125000,		/* 0x7: 125 kHz */
> +	100000,		/* 0x8: 100 kHz */
> +	50000,		/* 0x9: 50 kHz */
> +	25000,		/* 0xA: 25 kHz */
> +	12500,		/* 0xB: 12.5 kHz */
> +	10000,		/* 0xC: 10 kHz */
> +	5000,		/* 0xD: 5 kHz */
> +	2500,		/* 0xE: 2.5 kHz */
> +	1250,		/* 0xF: 1.25 kHz */

Instead of comments, make the code self-commented and robust:

/* ...the top comment... */
static const int ad4691_osc_freqs_Hz[] = {
	...
	[0xD] = 5000,
	[0xE] = 2500,
	[0xF] = 1250,
};

I would even use unit multipliers in some cases, but it might make the whole
table inconsistent, dunno.

> +};

From this it will be visible that the table is in Hz and each value is properly
indexed, even shuffling won't break the code.

...

> +static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int start = (st->info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1;
> +	unsigned int i;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;

> +	for (i = start; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {

	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {

> +		if (ad4691_osc_freqs[i] != freq)
> +			continue;
> +		return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
> +					  AD4691_OSC_FREQ_MASK, i);
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int ad4691_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type,
> +			     int *length, long mask)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int start = (st->info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1;

Yeah, in the table it's written as 1000000... But as I mentioned above, using
unit multipliers _there_ maybe not a good idea.

> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = &ad4691_osc_freqs[start];
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(ad4691_osc_freqs) - start;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int ad4691_single_shot_read(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);

> +	/*
> +	 * Use AUTONOMOUS mode for single-shot reads.
> +	 */

One line?

> +	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			   AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			   (u16)~BIT(chan->channel));

Why do you need casting?

> +	if (ret)
> +		return ret;

> +	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Wait for at least 2 internal oscillator periods for the
> +	 * conversion to complete.
> +	 */
> +	fsleep(DIV_ROUND_UP(2 * USEC_PER_SEC, ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)]));

Way too long line. Use temporary variables for that to make it easier to parse.
Also add a (short) comment on how the OSC periods are being calculated.

> +	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4691_AVG_IN(chan->channel), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = reg_val;
> +
> +	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}

...

> +	ret = devm_regulator_get_enable(dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable AVDD\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable VIO\n");

Can they be united to a bulk?

...

> +static int ad4691_reset(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct reset_control *rst;
> +
> +	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
> +
> +	if (rst) {
> +		/*
> +		 * The GPIO is already asserted by reset_gpio_probe (GPIOD_OUT_HIGH).
> +		 * Wait for the reset pulse width required by the chip. See datasheet Table 5.

Too long, try to wrap around 80, and drop unneeded (confusing?) details.

> +		 */

		/*
		 * The GPIO is already asserted by reset_gpio_probe().
		 * Wait for the reset pulse width required by the chip.
		 * See datasheet Table 5.
		 */

> +		fsleep(300);
> +		return reset_control_deassert(rst);
> +	}
> +
> +	/* No hardware reset available, fall back to software reset. */
> +	return regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG,
> +			    AD4691_SW_RESET);
> +}

...

> +	ret = regmap_update_bits(st->regmap, AD4691_REF_CTRL,
> +				 AD4691_REF_CTRL_MASK | AD4691_REFBUF_EN,
> +				 FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val) |
> +				 (st->refbuf_en ? AD4691_REFBUF_EN : 0));

With temporary variable it will become something like

	/* ...Comment on what is this... */
	val = FIELD_PREP(...);
	FIELD_MODIFY(...);

	ret = regmap_update_bits(st->regmap, AD4691_REF_CTRL,
				 AD4691_REF_CTRL_MASK | AD4691_REFBUF_EN, val);


> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");

...

> +	/*
> +	 * Set the internal oscillator to the highest rate this chip supports.
> +	 * Index 0 (1 MHz) exceeds the 500 kHz max of AD4691/AD4693, so those
> +	 * chips start at index 1 (500 kHz).
> +	 */
> +	ret = regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
> +				 AD4691_OSC_FREQ_MASK,
> +				 (st->info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1);

_assign_bits?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");

-- 
With Best Regards,
Andy Shevchenko



