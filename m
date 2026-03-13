Return-Path: <linux-pwm+bounces-8252-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEHFFtnts2m4dQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8252-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:58:33 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E89C3281D48
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 11:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A72F63025A45
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A238F64D;
	Fri, 13 Mar 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/+MwsKT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66C33815C8;
	Fri, 13 Mar 2026 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399496; cv=none; b=Wy0SA1/ms9x0mS0dbInYLa80brZszwK9TQzAX73gnPqasSNdu44ihvWaA3Cc1rhklEsxMZTVqotdw9VSfpqrpePd+Q5L0rbOwTZMeKmek+36GJqAI5ganInX+fRehqNvw5AvMzPuhHsS68z04xzDsfU9agkMwIsrWQ8pSY6xM4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399496; c=relaxed/simple;
	bh=ywlZKF2EeuFPRiyRmHuRnJIVuhykwHG7ywEkrrCvd+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcmLavA5pXJC+zw06Dx/EwaeBg/KSKTQvxjjZLGrCnRuuYPKhyUqbNqE5WSGTHUnRrpUJP/XvuhRqu4RQcEu625c3v/90YfS/k+V9PXDkixdK4KFQ+Bd9MfQAqUnwH0ZXOFKSXkHKXYdsht5fWJ4bxmz4JjDkdsbkxQ70nD0F40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/+MwsKT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773399495; x=1804935495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ywlZKF2EeuFPRiyRmHuRnJIVuhykwHG7ywEkrrCvd+8=;
  b=M/+MwsKTUr7QgF78+2adv4qmcROtWTIfWqBpUZUa3jZgrTzMLMWjYEud
   O7uyMva35dri0BS4G+WhBunFqpWW6kZajwxdUixE7jzIIHbM4h6wMB526
   WPN52wTlrd3sYDDg64K6N00pwD3dCKx4dr5QhF6KB/LO/R0fOHdH4i1xb
   Jmks3BXJRJUyGfRVVWlADMjSgGHQjBGfaUZWSOVvUanS12b3NGzF2gft0
   qWN16FVN9E7QrRuYFrF253UcgSHi+YtBP2AWyyRDZC39k8RGQSDG+FT3v
   BG+PGYYFRP5Q1bK5n2SPG8NySc6ARVv0davaYV8hlNT2U/7BaYGlVCgCn
   g==;
X-CSE-ConnectionGUID: LbMo3EksQJG0/pyRvk238Q==
X-CSE-MsgGUID: ysprSMSASjqDKsr2f7+Msw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74386393"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74386393"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:58:14 -0700
X-CSE-ConnectionGUID: +HyIi+hIRkG8uMmQUMdd7w==
X-CSE-MsgGUID: 4XvwEiMOQBiG0dE+2nTcdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="251647217"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 03:58:09 -0700
Date: Fri, 13 Mar 2026 12:58:07 +0200
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
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <abPtv0Y_QWYoMuAO@ashevche-desk.local>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8252-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E89C3281D48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 12:07:26PM +0200, Radu Sabau via B4 Relay wrote:

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

> +#define AD4691_SEQ_ALL_CHANNELS_OFF		0x00

Unused

...

> +#define AD4691_STATE_RESET_ALL			0x01
> +
> +#define AD4691_REF_CTRL_MASK			GENMASK(4, 2)

It's a bit better for navigating thru code if the register bit field
definitions are located after the respective register offset.

...

> +#define AD4691_DEVICE_MANUAL			0x14
> +#define AD4691_DEVICE_REGISTER			0x10

These two are unused.

...

> +#define AD4691_AUTONOMOUS_MODE_VAL		0x02

As per above (move closer to the respective offset definition).

...

> +#define AD4691_NOOP				0x00
> +#define AD4691_ADC_CHAN(ch)			((0x10 + (ch)) << 3)

Unused.

...

> +#define AD4691_STATUS_REG			0x014
> +#define AD4691_CLAMP_STATUS1_REG		0x01A
> +#define AD4691_CLAMP_STATUS2_REG		0x01B
> +#define AD4691_DEVICE_SETUP			0x020
> +#define AD4691_REF_CTRL				0x021
> +#define AD4691_OSC_FREQ_REG			0x023
> +#define AD4691_STD_SEQ_CONFIG			0x025
> +#define AD4691_SPARE_CONTROL			0x02A
> +
> +#define AD4691_OSC_EN_REG			0x180
> +#define AD4691_STATE_RESET_REG			0x181
> +#define AD4691_ADC_SETUP			0x182
> +#define AD4691_ACC_MASK1_REG			0x184
> +#define AD4691_ACC_MASK2_REG			0x185
> +#define AD4691_ACC_COUNT_LIMIT(n)		(0x186 + (n))

> +#define AD4691_ACC_COUNT_VAL			0x3F

Unused

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

> +#define AD4691_CHANNEL(chan, index, real_bits, storage_bits, _shift)	\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
> +					   | BIT(IIO_CHAN_INFO_SCALE),	\

Can be better formatting:

		.info_mask_shared_by_all =				\
			   BIT(IIO_CHAN_INFO_SAMP_FREQ)	|		\
			   BIT(IIO_CHAN_INFO_SCALE),			\

> +		.channel = chan,					\
> +		.scan_index = index,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = real_bits,				\
> +			.storagebits = storage_bits,			\
> +			.shift = _shift,				\
> +		},							\
> +	}

...

> +	u64				cnv_period;

Units?

...

> +static int ad4691_regulator_get(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret = devm_regulator_get_enable(dev, "vio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable VIO\n");
> +
> +	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (st->vref_uV == -ENODEV)
> +		st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "vrefin");

> +	if (st->vref_uV < 0)
> +		return dev_err_probe(dev, st->vref_uV,
> +				     "Failed to get reference supply\n");
> +
> +	if (st->vref_uV < AD4691_VREF_uV_MIN || st->vref_uV > AD4691_VREF_uV_MAX)
> +		return dev_err_probe(dev, -EINVAL, "vref(%d) must be under [%u %u]\n",

"...must be in the range [%u,%u]\n"
(or other possible delimiter instead of space: double or triple dots, dash).

> +				     st->vref_uV, AD4691_VREF_uV_MIN, AD4691_VREF_uV_MAX);
> +
> +	return 0;
> +}

...

> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct ad4691_state *st = context;
> +	struct spi_device *spi = to_spi_device(regmap_get_device(st->regmap));

Make the context to be spi, st is not used here...

> +	u8 tx[2], rx[4];
> +	int ret;
> +
> +	put_unaligned_be16(0x8000 | reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +		ret = spi_write_then_read(spi, tx, 2, rx, 1);
> +		if (ret)
> +			return ret;
> +		*val = rx[0];
> +		return 0;
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +		ret = spi_write_then_read(spi, tx, 2, rx, 2);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be16(rx);
> +		return 0;
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +		ret = spi_write_then_read(spi, tx, 2, rx, 3);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be24(rx);
> +		return 0;
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		ret = spi_write_then_read(spi, tx, 2, rx, 4);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be32(rx);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct ad4691_state *st = context;
> +	struct spi_device *spi = to_spi_device(regmap_get_device(st->regmap));

...neither here. Sorry if my previous comment was misleading in these cases.

> +	u8 tx[4];
> +
> +	put_unaligned_be16(reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
> +		if (val > 0xFF)
> +			return -EINVAL;
> +		tx[2] = val;
> +		return spi_write_then_read(spi, tx, 3, NULL, 0);
> +	case AD4691_STD_SEQ_CONFIG:
> +		if (val > 0xFFFF)
> +			return -EINVAL;
> +		put_unaligned_be16(val, &tx[2]);
> +		return spi_write_then_read(spi, tx, 4, NULL, 0);
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +{
> +	if (st->adc_mode == AD4691_MANUAL_MODE)
> +		return DIV_ROUND_CLOSEST(NSEC_PER_SEC,
> +					 ktime_to_ns(st->sampling_period));

> +	return DIV_ROUND_CLOSEST(NSEC_PER_SEC,
> +				 pwm_get_period(st->conv_trigger));

One line. It's fine to have ~83 character long lines if it increases
readability.

> +}

...

> +static int __ad4691_set_sampling_freq(struct ad4691_state *st, int freq)
> +{
> +	unsigned long long target, ref_clk_period_ns;
> +	struct pwm_state cnv_state;
> +
> +	pwm_init_state(st->conv_trigger, &cnv_state);
> +
> +	freq = clamp(freq, 1, st->chip->max_rate);
> +	target = DIV_ROUND_CLOSEST_ULL(st->ref_clk_rate, freq);
> +	ref_clk_period_ns = DIV_ROUND_CLOSEST_ULL(NANO, st->ref_clk_rate);

NANO --> NSEC_PER_SEC

Why _ULL?

> +	st->cnv_period = ref_clk_period_ns * target;
> +	cnv_state.period = ref_clk_period_ns * target;
> +	cnv_state.duty_cycle = AD4691_CNV_DUTY_CYCLE_NS;
> +	cnv_state.enabled = false;
> +
> +	return pwm_apply_might_sleep(st->conv_trigger, &cnv_state);
> +}

...

> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);

> +

Redundant blank line.

> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		if (!freq || freq > st->chip->max_rate)
> +			return -ERANGE;

> +		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST(NSEC_PER_SEC,
> +									 freq));

Better indentation either to put all on one line or

		st->sampling_period =
			ns_to_ktime(DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq));

> +		return 0;
> +	}
> +
> +	if (!st->conv_trigger)
> +		return -ENODEV;

> +	if (!freq || freq > st->chip->max_rate)

in_range() ?

> +		return -ERANGE;
> +
> +	return __ad4691_set_sampling_freq(st, freq);
> +}

...

> +static int ad4691_single_shot_read(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	u16 mask = ~BIT(chan->channel);

> +	u32 acc_mask[2] = { mask & 0xFF, mask >> 8 };

This looks quite wrong. Is it for sure like two 32-bit stances per each mask
byte? If not, this should be __le16 acc_mask = cpu_to_le16(~BIT(...));

> +	unsigned int reg_val;
> +	int ret;
> +
> +	/*
> +	 * Always use AUTONOMOUS mode for single-shot reads, regardless
> +	 * of the buffer mode (CNV_CLOCK or MANUAL). The chip is kept
> +	 * in AUTONOMOUS mode during idle; enter_conversion_mode() and
> +	 * exit_conversion_mode() handle the switch for buffer operation.
> +	 */
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
> +	ret = regmap_bulk_write(st->regmap, AD4691_ACC_MASK1_REG, acc_mask, 2);

I believe this is not doing what you were expected to do in accordance with u32
above. Using sizeof() is a good pattern to show mistakes.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 1);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Wait for conversion to complete using a timed delay.
> +	 * A single read needs 2 internal oscillator periods.
> +	 * OSC_FREQ_REG is never modified by the driver, so the
> +	 * oscillator runs at reset-default speed. Use chip->max_rate
> +	 * as a conservative proxy: it is always <= the OSC frequency,
> +	 * so the computed delay is >= the actual conversion time.
> +	 */

> +	unsigned long conv_us = DIV_ROUND_UP(2 * USEC_PER_SEC,
> +					     st->chip->max_rate);

No, we do not mix definitions and code (only a couple of exceptions, none of
which is applicable here).

> +	fsleep(conv_us);
> +
> +	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD4691_AVG_IN(chan->channel), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = reg_val;
> +	regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
> +
> +	return IIO_VAL_INT;
> +}

...

> +static int ad4691_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW: {
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		return ad4691_single_shot_read(indio_dev, chan, val);
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = ad4691_get_sampling_freq(st);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:

> +		*val = st->vref_uV / 1000;

"1000" --> "(MICRO / MILLI)"

> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct reset_control *rst;
> +
> +	rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(rst))

> +		return dev_err_probe(dev, PTR_ERR(rst),
> +				     "Failed to get reset\n");

It's one line (of 81 characters, which is fine in this case).

> +	if (!rst)
> +		return 0;

Is this required? I mean if reset APIs are NULL-aware, this will be just 300 µs
sleep.

> +	reset_control_assert(rst);
> +	/* Reset delay required. See datasheet Table 5. */
> +	fsleep(300);
> +	reset_control_deassert(rst);
> +
> +	return 0;
> +}

...

> +static int ad4691_config(struct ad4691_state *st)

I missed the fact that 'spi' is used in one occasion here, perhaps just supply
the max_speed_hz instead of to_spi_device() ?

> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	enum ad4691_ref_ctrl ref_val;
> +	unsigned int reg_val;
> +	int ret;
> +
> +	/*
> +	 * Determine buffer conversion mode from DT: if a PWM is provided it
> +	 * drives the CNV pin (CNV_CLOCK_MODE); otherwise CNV is tied to CS
> +	 * and each SPI transfer triggers a conversion (MANUAL_MODE).
> +	 * Both modes idle in AUTONOMOUS mode so that read_raw can use the
> +	 * internal oscillator without disturbing the hardware configuration.
> +	 */
> +	if (device_property_present(dev, "pwms")) {
> +		st->adc_mode = AD4691_CNV_CLOCK_MODE;
> +		ret = ad4691_pwm_get(st);
> +		if (ret)
> +			return ret;
> +	} else {
> +		st->adc_mode = AD4691_MANUAL_MODE;
> +		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC,

Why _ULL? The dividend is 32-bit.

> +			AD4691_MANUAL_MODE_STD_FREQ(st->chip->num_channels,
> +				to_spi_device(dev)->max_speed_hz)));
> +	}
> +
> +	/* Perform a state reset on the channels at start-up. */
> +	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			   AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write state reset\n");
> +
> +	/* Clear STATUS register by reading from the STATUS register. */
> +	ret = regmap_read(st->regmap, AD4691_STATUS_REG, &reg_val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read status register\n");
> +
> +	switch (st->vref_uV) {
> +	case AD4691_VREF_uV_MIN ... 2750000:
> +		ref_val = AD4691_VREF_2P5;
> +		break;
> +	case 2750001 ... 3250000:
> +		ref_val = AD4691_VREF_3P0;
> +		break;
> +	case 3250001 ... 3750000:
> +		ref_val = AD4691_VREF_3P3;
> +		break;
> +	case 3750001 ... 4500000:
> +		ref_val = AD4691_VREF_4P096;
> +		break;
> +	case 4500001 ... AD4691_VREF_uV_MAX:
> +		ref_val = AD4691_VREF_5P0;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Unsupported vref voltage: %d uV\n",
> +				     st->vref_uV);
> +	}
> +
> +	ret = regmap_write(st->regmap, AD4691_REF_CTRL,
> +			   FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");
> +
> +	/* Both CNV_CLOCK and MANUAL devices start in AUTONOMOUS mode. */
> +	ret = regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_AUTONOMOUS_MODE_VAL);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write ADC_SETUP\n");
> +
> +	return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG, AD4691_ADC_BUSY);
> +}

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

> +	st = iio_priv(indio_dev);
> +	ret = devm_mutex_init(dev, &st->lock);

It's better to have like this

	...
	st = iio_priv(indio_dev);
	st->chip = spi_get_device_match_data(spi);

	ret = devm_mutex_init(dev, &st->lock);
	...

> +	if (ret)
> +		return ret;
> +
> +	st->regmap = devm_regmap_init(dev, NULL, st, &ad4691_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	st->chip = spi_get_device_match_data(spi);
> +
> +	ret = ad4691_regulator_get(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4691_reset(st);
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
> +	indio_dev->channels = (st->adc_mode == AD4691_MANUAL_MODE) ?
> +		st->chip->manual_channels : st->chip->channels;
> +	indio_dev->num_channels = st->chip->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko



