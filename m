Return-Path: <linux-pwm+bounces-8192-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LPWD8DVqWnbFwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8192-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 20:13:04 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA442174CE
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 20:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A4B9300565D
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0367F303C83;
	Thu,  5 Mar 2026 19:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2J6ndRD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82923033C0;
	Thu,  5 Mar 2026 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772737981; cv=none; b=YEDPYtGAHlaGn1BX9QQwfnw4LeaIsfuBrGaVX7Ki0kNAUg0j4amSdq2B46kC3jUkJFhkAD0RejOWSpze+1gvATKagEsdva0N0iLijCBfYlViHqrEAdJmLOUKvwt0Sa9ggZ7kDuq59hXdPJxc/hF9ZwhJD6igfHkGfr9tWz9J220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772737981; c=relaxed/simple;
	bh=Ief7q3oirpCgncQbAgVs7CubXvbwMyrJCjMRgd7YqeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t6c4+gPwWLuydQNu00KVSn5n2yt3VKQ1zS/8aePaY4alTGAb3zyNsEeaj7cKhJaypU/nciQLjGVIIbnSFT6B+3JD6lwXU4yi/doXuDf15PTZh32sHEBN0yq3JVJ+CUm8HvHlxbnJZL2V3yHltW5tTswKvbMoNs6gnrkjfdM4k3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2J6ndRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7560FC116C6;
	Thu,  5 Mar 2026 19:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772737981;
	bh=Ief7q3oirpCgncQbAgVs7CubXvbwMyrJCjMRgd7YqeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2J6ndRDBLVE99lUgjeJNFY5jurf7N0IkHtFr8N8MgYNeVm+3Q8CKDj8cNkWFPL9V
	 4JM0KYtj2eREZt/i2RMPMI7ff7YYGoutp+p0eajNAON1eIi3CsT0ClCl91BssW43af
	 MHrGSrAvMchiBjRUKZNPs1NLunHwU401NT+19FdhRbpJ9zgneGslx9bDlHjRBImh3h
	 +0qq9hQOu9IsuPCbvR6fUzR9pcDO5cVC2NIiLJ5js8g6eFkHatZBYw79pyW9f0mW+z
	 01FfKevctFJtR+AdJhtmH09aT+ApM538j8KUfiiUp6oAJXE6c0tEqowk2gUaiLQmxs
	 KcIcBS03VrTJA==
Date: Thu, 5 Mar 2026 19:12:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260305191249.32b37d5f@jic23-huawei>
In-Reply-To: <20260305-ad4692-multichannel-sar-adc-driver-v1-2-336229a8dcc7@analog.com>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
	<20260305-ad4692-multichannel-sar-adc-driver-v1-2-336229a8dcc7@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AFA442174CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8192-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,analog.com:email]
X-Rspamd-Action: no action

On Thu, 05 Mar 2026 14:23:28 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
> 
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
> 
> Five operating modes are supported:
Given I'm strongly pushing for this to not be a binding mode thing, it
may well make sense to build the driver up adding modes over the course
of several patches.

>   - CNV Clock Mode:   external PWM drives CNV; sampling rate set via
>                       PWM period
>   - CNV Burst Mode:   PWM triggers burst cycles; internal oscillator
>                       drives conversions within each burst
>   - Autonomous Mode:  internal oscillator drives conversions;
>                       started/stopped via register write
>   - SPI Burst Mode:   like Autonomous but optimised for SPI burst reads
>   - Manual Mode:      CNV tied to SPI CS; pipelined protocol;
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Some initial comments inline.  I didn't do a particularly thorough review
yet as the DT binding feedback probably means quite a bit will change.

Thanks,

Jonathan
> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..dee8bc312d44
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c

> +
> +#define AD4691_CHANNEL(chan, index, real_bits, storage_bits, _shift)	\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ)	\
> +					   | BIT(IIO_CHAN_INFO_SCALE),	\
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

> +
> +static const struct iio_chan_spec ad4691_channels[] = {
> +	AD4691_CHANNEL(0, 0, 16, 32, 0),

Bring the macro def down next to first time it's used...

> +
> +static const struct ad4691_chip_info ad4691_chips[] = {

As mentioned below. Better to just have named individual struct instances.

> +	[AD4691_ID_AD4691] = {
> +		.channels = ad4691_channels,
> +		.name = "ad4691",
> +		.product_id = 0x11,
> +		.num_channels = ARRAY_SIZE(ad4691_channels),
> +		.max_rate = 500000,
> +	},
> +	[AD4691_ID_AD4692] = {
> +		.channels = ad4691_channels,
> +		.name = "ad4692",
> +		.product_id = 0x12,
> +		.num_channels = ARRAY_SIZE(ad4691_channels),
> +		.max_rate = 1000000,
> +	},
> +	[AD4691_ID_AD4693] = {
> +		.channels = ad4693_channels,
> +		.name = "ad4693",
> +		.product_id = 0x13,
> +		.num_channels = ARRAY_SIZE(ad4693_channels),
> +		.max_rate = 500000,
> +	},
> +	[AD4691_ID_AD4694] = {
> +		.channels = ad4693_channels,
> +		.name = "ad4694",
> +		.product_id = 0x14,
> +		.num_channels = ARRAY_SIZE(ad4693_channels),
> +		.max_rate = 1000000,
> +	},
> +};
> +
> +struct ad4691_state {
...

> +
> +	/* DMA (thus cache coherency maintenance) may require the

	/*
	 * DMA...

> +	 * transfer buffers to live in their own cache lines.
> +	 * Make the buffer large enough for one 24 bit sample and one 64 bit
> +	 * aligned 64 bit timestamp.
> +	 */
> +	unsigned char rx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);
> +	unsigned char tx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);

Why do they both need to be marked IIO_DMA_MINALIGN?  Make sure you understand
what this is for. The only time that would be needed is if the driver is changing
the value in one of these buffers whilst DMA is read/writing the other.


> +};

> +static int ad4691_regulators_get(struct ad4691_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct regulator *ref;
> +	int ret;
> +
> +	st->regulators[0].supply = "vio";
> +
> +	ret = devm_regulator_bulk_get(dev, AD4691_NUM_REGULATORS,
> +				      st->regulators);

There only seems to be 1. So until there are more just use non bulk and
do the get and enable in one call. (Fairly sure you can do that for bulk as well)

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get VIO regulator\n");
> +
> +	ret = regulator_bulk_enable(AD4691_NUM_REGULATORS, st->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulators\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad4691_disable_regulators, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register regulator disable action\n");
> +
> +	ref = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(ref)) {
> +		if (PTR_ERR(ref) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(ref),
> +					     "Failed to get vref regulator");
> +
> +		/* Internal REFIN must be used if optional REF isn't used. */
> +		ref = devm_regulator_get(dev, "vrefin");
> +		if (IS_ERR(ref))
> +			return dev_err_probe(dev, PTR_ERR(ref),
> +					     "Failed to get vrefin regulator");
> +	}
> +
> +	ret = regulator_enable(ref);
Just turn it on on in which ever of the two options above succeed.  Most likely
you can also get the reference voltage and simplify things further by just caching that.

	devm_regulator_get_enable_read_voltage()

Check return value for -ENODEV to handle the optional case.


> +	if (ret) {
> +		dev_err_probe(dev, ret, "Failed to enable specified ref supply\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, ad4691_disable_regulator, ref);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register ref disable action\n");
> +
> +	st->vref = regulator_get_voltage(ref);
> +	if (st->vref < AD4691_VREF_MIN || st->vref > AD4691_VREF_MAX)
> +		return dev_err_probe(dev, -EINVAL, "vref(%d) must be under [%u %u]\n",
> +				     st->vref, AD4691_VREF_MIN, AD4691_VREF_MAX);
> +
> +	return 0;
> +}
> +
> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct ad4691_state *st = context;
> +	unsigned char buf[6];
> +	int ret;
> +
> +	buf[0] = (reg >> 8) | 0x80;
> +	buf[1] = reg & 0xFF;

This is a unaligned be16 put with an extra bit. Probably clearer expressed
that way in code.

> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 1);

Why not have separate tx and rx buffers? Will be easier to read.

> +		if (!ret)
> +			*val = buf[2];
> +		break;
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 2);
> +		if (!ret)
> +			*val = get_unaligned_be16(&buf[2]);
> +		break;
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 3);
> +		if (!ret)
> +			*val = get_unaligned_be24(&buf[2]);
> +		break;
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 3);

Same as the one above. Just have two case lines before the implementation like
you do for the 2 byte one.

> +		if (!ret)
> +			*val = get_unaligned_be24(&buf[2]);
> +		break;
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		ret = spi_write_then_read(st->spi, &buf[0], 2, &buf[2], 4);
> +		if (!ret)
> +			*val = get_unaligned_be32(&buf[2]);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
CAn just return ret instead of break above.

> +}
> +
> +static int ad4691_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct ad4691_state *st = context;
> +	unsigned char buf[4];
> +
> +	buf[0] = (reg >> 8);
> +	buf[1] = reg & 0xFF;
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
> +		if (val > 0xFF)
> +			return -EINVAL;
> +		buf[2] = val;
> +
> +		return spi_write(st->spi, buf, 3);
You carefully use a padded buffer for other spi writes to ensure they are
DMA save but not here... 
Given these are small I'd use spi_write_then_read() with 0 sized read.
that will bounce them for you and avoid the DMA safety issue.

> +	case AD4691_STD_SEQ_CONFIG:
> +		if (val > 0xFFFF)
> +			return -EINVAL;
> +		put_unaligned_be16(val, &buf[2]);
> +
> +		return spi_write(st->spi, buf, 4);
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int ad4691_pwm_get(struct spi_device *spi, struct ad4691_state *st)
> +{
> +	struct clk *ref_clk;
> +	int ret;
> +
> +	ref_clk = devm_clk_get_enabled(&spi->dev, "ref_clk");
> +	if (IS_ERR(ref_clk))
> +		return dev_err_probe(&spi->dev, PTR_ERR(ref_clk),
> +				     "Failed to get ref_clk\n");
> +
> +	st->ref_clk_rate = clk_get_rate(ref_clk);
> +
> +	st->conv_trigger = devm_pwm_get(&spi->dev, "cnv");
> +	if (IS_ERR(st->conv_trigger)) {
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->conv_trigger),
> +				     "Failed to get cnv pwm\n");
> +	}

No brackets.

> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad4691_disable_pwm,
> +				       st->conv_trigger);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to register PWM disable action\n");
> +
> +	switch (st->adc_mode) {
> +	case AD4691_CNV_CLOCK_MODE:
> +		return __ad4691_set_sampling_freq(st, st->chip->max_rate);
> +	case AD4691_CNV_BURST_MODE: {
> +		/*
> +		 * In CNV Burst Mode, the internal oscillator drives per-channel
> +		 * conversions. The PWM triggers each burst cycle; its period
> +		 * must cover the full conversion time tOSC*(n+1) plus SPI
> +		 * transfer time. Use worst-case channel count here; the period
> +		 * is refined at buffer enable time when the active count is known.
> +		 */
> +		u64 period_ns = ad4691_cnv_burst_period_ns(st, st->chip->num_channels);
> +		int pwm_freq = (int)max(1ULL, div64_u64(NSEC_PER_SEC, period_ns));

NSEC_PER_SEC doesn't need a u64 to fit. So why do this as 64bit?


> +
> +		return __ad4691_set_sampling_freq(st, pwm_freq);
> +	}
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, unsigned int freq)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	int ret, i;
> +
> +	if (!iio_device_claim_direct(indio_dev))
we have the new IIO_DEV_ACQUIRE_DIRECT_MODE() stuff to simplify these.

> +		return -EBUSY;
> +
> +	mutex_lock(&st->lock);
Once you use the ACQUIRE stuff you can use a guard() here.

> +	switch (st->adc_mode) {
> +	case AD4691_MANUAL_MODE:
> +		if (!freq || freq > st->chip->max_rate) {
> +			ret = -EINVAL;

Then all these can be direct error returns as the cleanup is automatic.
That will simplify the code flow quite a lot.

> +			goto exit;
> +		}
> +
> +		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL
> +			(NSEC_PER_SEC, freq));
> +		ret = 0;
> +		goto exit;

...

> +
> +exit:
> +	mutex_unlock(&st->lock);
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}

> +/*
> + * Return the time in microseconds for a single-channel conversion driven by
> + * the internal oscillator. A single read requires (n_active + 1) = 2 oscillator
> + * periods (n_active = 1).
> + */
> +static unsigned long ad4691_osc_single_conv_us(struct ad4691_state *st)
> +{
> +	unsigned int osc_idx = AD4691_OSC_1MHZ;
> +
> +	regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &osc_idx);
Check for error return.

> +	if (osc_idx >= ARRAY_SIZE(ad4691_int_osc_val))

How did it end up out of range?  Multiple values that have same meaning?  
If so add a comment as it's not obvious.

> +		osc_idx = AD4691_OSC_1MHZ;
> +
> +	return DIV_ROUND_UP(2UL * USEC_PER_SEC, ad4691_int_osc_val[osc_idx]);
> +}
> +
> +static int ad4691_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		switch (st->adc_mode) {
> +		case AD4691_CNV_CLOCK_MODE:
> +		case AD4691_CNV_BURST_MODE:
> +		case AD4691_AUTONOMOUS_MODE:
> +		case AD4691_SPI_BURST_MODE:
> +			ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +					   AD4691_STATE_RESET_ALL);
> +			if (ret)
> +				goto done;
> +
> +			ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG, BIT(chan->channel));
> +			if (ret)
> +				goto done;
> +
> +			if (chan->channel < 8) {
> +				ret = regmap_write(st->regmap, AD4691_ACC_MASK1_REG,
> +						   ~BIT(chan->channel) & 0xFF);
> +				if (ret)
> +					goto done;
> +				ret = regmap_write(st->regmap, AD4691_ACC_MASK2_REG,
> +						   0xFF);
> +			} else {
> +				ret = regmap_write(st->regmap, AD4691_ACC_MASK1_REG,
> +						   0xFF);
> +				if (ret)
> +					goto done;
> +				ret = regmap_write(st->regmap, AD4691_ACC_MASK2_REG,
> +						   ~BIT(chan->channel - 8) & 0xFF);
> +			}

			So this is unmasking one channel across the two regs which are
			next two each other.  I'd do something like:
			u16 val = ~BIT(chan->channel);
	
			ret = regmap_write(st->regmap, AD4691_ACC_MASK1_REG,
					   val & 0xFF)
			if (ret)..

			ret = regmap_write(st->regmap, AD4691_ACC_MASK2_REG,
					   (val >>  8) & 0xFF);

			if (ret)...

You might be able to use regmap_bulk_write() and a cpu_to_le16() but I'm not sure it will
end up easier to read.

 
			
> +
> +			if (ret)
> +				goto done;
> +
> +			ret = ad4691_sampling_enable(st, true);
> +			if (ret)
> +				goto done;
> +
> +			/*
> +			 * Wait for conversion to complete using a timed delay.
> +			 * CNV_CLOCK_MODE conversion time is bounded by
> +			 * AD4691_MAX_CONV_PERIOD_US. All other modes are driven by
> +			 * the internal oscillator; two oscillator periods cover a
> +			 * single-channel read (n_active + 1 = 2).
> +			 */
> +			if (st->adc_mode == AD4691_CNV_CLOCK_MODE) {
> +				usleep_range(AD4691_MAX_CONV_PERIOD_US,
> +					     AD4691_MAX_CONV_PERIOD_US + 100);
fsleep()
> +			} else {
> +				unsigned long conv_us = ad4691_osc_single_conv_us(st);
> +
> +				usleep_range(conv_us, conv_us + conv_us / 4 + 1);
fsleep()
I have no idea where this complex range comes from though.

> +			}
> +
> +			ret = ad4691_sampling_enable(st, false);
> +			if (ret)
> +				goto done;
> +
> +			ret = regmap_read(st->regmap,
> +					  AD4691_AVG_IN(chan->channel),
> +					  &reg_val);
> +
> +			*val = reg_val;
> +			regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +					AD4691_STATE_RESET_ALL);
> +
> +			break;
> +		case AD4691_MANUAL_MODE:
> +			ret = ad4691_transfer(st, AD4691_ADC_CHAN(chan->channel), val);
> +			if (ret)
> +				goto done;
> +
> +			ret = ad4691_transfer(st, AD4691_NOOP, val);
> +			if (ret)
> +				goto done;
> +
> +			/* Extract ADC data from the 24-bit SPI frame */
> +			*val = *val >> 8;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto done;
> +		}
> +
> +done:

I'd suggest factoring out the code in between so you don't have
labels in a switch case statement.

> +		iio_device_release_direct(indio_dev);
> +
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = ad4691_get_sampling_freq(st);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref / 1000;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (st->adc_mode) {
> +		case AD4691_CNV_CLOCK_MODE:
> +		case AD4691_MANUAL_MODE:
> +			return -EOPNOTSUPP;

If it's not supported, the attribute should not be visible so this should not
need to be present.  If we do need it because the change between modes becomes
a runtime thing, convention is to report the fastest it could be if samples
were back to back.  1/sampling periodd.

> +		case AD4691_CNV_BURST_MODE:
> +		case AD4691_AUTONOMOUS_MODE:
> +		case AD4691_SPI_BURST_MODE:
> +			*vals = ad4691_int_osc_val;
> +			*length = ARRAY_SIZE(ad4691_int_osc_val);
> +			*type = IIO_VAL_INT;
> +
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (st->adc_mode == AD4691_MANUAL_MODE)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&st->lock);
guard(mutex)(&st->lock)

and drop the manual unlocking of the mutex. Allows direct return on error.


> +	if (readval) {
> +		ret = regmap_read(st->regmap, reg, readval);
> +		goto mutex_unlock;
> +	}
> +
> +	ret = regmap_write(st->regmap, reg, writeval);
> +
> +mutex_unlock:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +

> +
> +static const struct spi_device_id ad4691_id[] = {
> +	{ "ad4692", (kernel_ulong_t)&ad4691_chips[AD4691_ID_AD4692] },
> +	{ "ad4691", (kernel_ulong_t)&ad4691_chips[AD4691_ID_AD4691] },
> +	{ "ad4694", (kernel_ulong_t)&ad4691_chips[AD4691_ID_AD4694] },
> +	{ "ad4693", (kernel_ulong_t)&ad4691_chips[AD4691_ID_AD4693] },

Same comments as below on no enum and { }

> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad4691_id);

Move this down next to the DT one. Doesn't make much sense up here
given the two types of id table are close to equivalent.


> +
> +static int ad4691_config(struct ad4691_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	unsigned int reg_val;
> +	u32 mode;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, AD4691_PRODUCT_ID_LSB_REG, &reg_val);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read product ID\n");
> +
> +	if (reg_val != st->chip->product_id)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Product ID mismatch: expected 0x%02x, got 0x%02x\n",
> +				     st->chip->product_id, reg_val);

We don't do hard rejection on product ids in new drivers. It was a historical
bad design choice because it breaks the concept of fallback compatibles in DT.
Those are used so an older kernel can support a newer 'backwards compatible' device.

> +
> +	ret = device_property_read_u32(dev, "adi,spi-mode", &mode);
> +	if (ret)
> +		return dev_err_probe(dev, -EINVAL, "Could not find SPI mode\n");

See binding comments.

> +
> +	if (mode > AD4691_MAX_ADC_MODE)
> +		return dev_err_probe(dev, -EINVAL, "Invalid SPI mode(%u)\n", mode);
> +
> +	st->adc_mode = mode;
> +
> +	/*
> +	 * CNV_CLOCK_MODE and CNV_BURST_MODE require a PWM for conversion timing.
> +	 * MANUAL_MODE doesn't need PWM - CS is tied to CNV, so each SPI
> +	 * transfer automatically triggers a conversion.
> +	 */
> +	if (st->adc_mode == AD4691_CNV_CLOCK_MODE ||
> +	    st->adc_mode == AD4691_CNV_BURST_MODE) {
> +		if (device_property_present(dev, "pwms")) {
> +			ret = ad4691_pwm_get(st->spi, st);
> +			if (ret)
> +				return ret;
> +		} else {
Flip logic
		if (!device_property_present(...)
			return dev_err_probe();

		ret = ...

Though this will probably change anyway given other feedback.

> +			return dev_err_probe(dev, -ENODEV,
> +					     "CNV modes require 'pwms' property\n");
> +		}

...


> +	switch (st->adc_mode) {
> +	case AD4691_CNV_CLOCK_MODE:
> +	case AD4691_CNV_BURST_MODE:
> +	case AD4691_AUTONOMOUS_MODE:
> +	case AD4691_SPI_BURST_MODE:
> +		/*
> +		 * The adi,spi-mode DT property values 0-3 map directly to the
> +		 * ADC_SETUP register encoding for these four modes.

Ah.  So you are more or less exposing the hardware control.  This needs a rethink
to make all the options possible in a given wiring of the chip possible to
select at runtime not from the binding.

> +		 */
> +		ret = regmap_write(st->regmap, AD4691_ADC_SETUP, mode);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to write ADC_SETUP\n");
> +
> +		if (st->adc_mode == AD4691_AUTONOMOUS_MODE)
> +			/* Configure GP0 as ADC_BUSY for trigger */
> +			return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG,
> +					    AD4691_ADC_BUSY);
> +		else

Else doesn't add much.

> +			/* Configure GP0 as DATA_READY for trigger */
> +			return regmap_write(st->regmap, AD4691_GPIO_MODE1_REG,
> +					    AD4691_DATA_READY);
> +	case AD4691_MANUAL_MODE:
> +		/* GP0 as ADC_BUSY; conversion completion is polled via CS in MANUAL_MODE. */
> +		ret = regmap_write(st->regmap, AD4691_GPIO_MODE1_REG,
> +				   AD4691_ADC_BUSY);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to write GPIO_MODE1\n");
> +
> +		return regmap_write(st->regmap, AD4691_DEVICE_SETUP,
> +				    AD4691_DEVICE_MANUAL);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void ad4691_setup_channels(struct iio_dev *indio_dev,
> +				  struct ad4691_state *st)
> +{
> +	if (st->adc_mode == AD4691_MANUAL_MODE) {
> +		if (st->chip->num_channels == 8)
> +			indio_dev->channels = ad4693_manual_channels;

Put them in the chip info structure as a pointer (like chip->channels)
and pick between the options by adc_mode.  If the pointer is null then
the option isn't supported.

After doing that I doubt a helper brings enough value, so probably squash
the resulting code in where you call this.


> +		else
> +			indio_dev->channels = ad4691_manual_channels;
> +	} else {
> +		indio_dev->channels = st->chip->channels;
> +	}
> +
> +	indio_dev->num_channels = st->chip->num_channels;
> +}
> +
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
> +	mutex_init(&st->lock);

	ret = devm_mutex_init(&st->lock);
	if (ret)
		return ret;

Brings some lock debugging we don't really care about, but it's cheap
to enable so we are doing so for new drivers.
> +
> +	st->spi = spi;
> +	spi_set_drvdata(spi, indio_dev);

Ysed?  If not, bring it in only when you need it.

> +
> +	st->regmap = devm_regmap_init(dev, NULL, st, &ad4691_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	st->chip = spi_get_device_match_data(spi);
> +	if (!st->chip) {
> +		st->chip = (void *)spi_get_device_id(spi)->driver_data;

Look at how spi_get_device_match_data() is implemented...

const void *spi_get_device_match_data(const struct spi_device *sdev)
{
	const void *match;

	match = device_get_match_data(&sdev->dev);
	if (match)
		return match;

	return (const void *)spi_get_device_id(sdev)->driver_data;
}
Last bit should look familiar ;)

> +		if (!st->chip)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "Could not find chip info data\n");
> +	}
> +
> +	ret = ad4691_regulators_get(st);
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
> +	ad4691_setup_channels(indio_dev, st);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad4691_of_match[] = {
> +	{ .compatible = "adi,ad4692", .data = &ad4691_chips[AD4691_ID_AD4692] },
Drop the enum and break up the array into named structures. Tends to end up
more redable in teh long run.

> +	{ .compatible = "adi,ad4691", .data = &ad4691_chips[AD4691_ID_AD4691] },
Put these in numeric order.

> +	{ .compatible = "adi,ad4694", .data = &ad4691_chips[AD4691_ID_AD4694] },
> +	{ .compatible = "adi,ad4693", .data = &ad4691_chips[AD4691_ID_AD4693] },
> +	{},
	{ }
For IIO.  It's a random choice but I'm trying to keep all drivers the same on this
in IIO at least given the wider kernel has not rule one way or the other.
The lack of comma is more generally accepted though as it makes not sense
to make it easy to put things after it.

> +};



