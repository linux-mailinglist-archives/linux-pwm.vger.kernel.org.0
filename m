Return-Path: <linux-pwm+bounces-8556-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SExKDXPV22kzHQkAu9opvQ
	(envelope-from <linux-pwm+bounces-8556-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 19:25:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E13E5131
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 19:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 336573002937
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Apr 2026 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8373537D7;
	Sun, 12 Apr 2026 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkUzgOmk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1932F851;
	Sun, 12 Apr 2026 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776014700; cv=none; b=IAdrOtsvZUnzlQrNWLkxEAjFnYR/0VfRqleK+n9ag46xnEr1aT7HJyoR9Qbs9XBiXsuchJueeI6tacG/TX2k6txwqYh+VtfXBTrXqejiklcrUheZVp1nBBTdnxJ8c92xlI6H1Ancmjwpv09d2pjB1ZxC2ngMU0Dch6BbKPVXf5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776014700; c=relaxed/simple;
	bh=PdDmV6O/9CIJlHOxrjdAFiW0wmsVsPDKGf7SYwZawuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmqfcIVy1ZcjoNVaSwhIXJdM3BHyqyVhwAQaqYxqtBP5eqX5htlkBx3AIh311k8mqTK4vWT9i/CkPLEFv3nXTrBVHUYyCay1/OgEANJqIdNWLN23ho/OoDKLZRRH01hJN3yi0InP6Pn0GrGG5nXTCAyNju2Ek4bVtqg7MRPdvJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkUzgOmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC4BC19424;
	Sun, 12 Apr 2026 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776014700;
	bh=PdDmV6O/9CIJlHOxrjdAFiW0wmsVsPDKGf7SYwZawuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fkUzgOmkZZsiREpgNczkRisQMat8Lye6lS9/lmoHEX3G251C5KcKu748KwNWnU++Y
	 cb8qRE0q9QVZyzPbX/Q3u2Nfm3SfEKC6Cvaf4t2afiBgjoG1zq3Un/NNNqntV/n9UH
	 +04MuSyqcPwVZXOKAxn8nHfw59gSKSG7FLtS3VhvlrYBEbajOYw0E8rKnPC/ZFCfT9
	 susszYRQNuMbvFyZBx5P90/7A3tenmgaPFshjFf1ULB8VxpDh0PNqzkt1WBKZgVfIU
	 4IKb5R3flA4DUarjEmZhmpGL2IjAw9F1aMEd3njfpPcKZxN6cew13O2b9twLF2mWGa
	 rGqyze/0DeYbA==
Date: Sun, 12 Apr 2026 18:24:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260412182446.1e80828f@jic23-huawei>
In-Reply-To: <20260409-ad4692-multichannel-sar-adc-driver-v7-2-be375d4df2c5@analog.com>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
	<20260409-ad4692-multichannel-sar-adc-driver-v7-2-be375d4df2c5@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8556-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 233E13E5131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 09 Apr 2026 18:28:23 +0300
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
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Mostly minor stuff but the regulator bit needs another look.

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..43bd408c3d11
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c

> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct spi_device *spi = context;
> +	u8 tx[2], rx[4];
> +	int ret;
> +
> +	/* Set bit 15 to mark the operation as READ. */
> +	put_unaligned_be16(0x8000 | reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +		ret = spi_write_then_read(spi, tx, 2, rx, 1);

for tx size can use sizeof(tx)

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
> +	struct spi_device *spi = context;
> +	u8 tx[4];
> +
> +	put_unaligned_be16(reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_MASK_REG - 1:
> +	case AD4691_ACC_MASK_REG + 1 ... AD4691_GPIO_MODE2_REG:
> +		if (val > 0xFF)

U8_MAX from limits.h

> +			return -EINVAL;
> +		tx[2] = val;
> +		return spi_write_then_read(spi, tx, 3, NULL, 0);
> +	case AD4691_ACC_MASK_REG:
> +	case AD4691_STD_SEQ_CONFIG:
> +		if (val > 0xFFFF)

U16_MAX
 
> +			return -EINVAL;
> +		put_unaligned_be16(val, &tx[2]);
> +		return spi_write_then_read(spi, tx, 4, NULL, 0);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int start = (st->info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1;

This appears in a couple of places. Maybe a little helper for
ad4691_samp_freq_array_start() would let you describe why in a comment
in a single location.

> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	for (unsigned int i = start; i < ARRAY_SIZE(ad4691_osc_freqs_Hz); i++) {
> +		if (ad4691_osc_freqs_Hz[i] != freq)
> +			continue;
> +		return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
> +					  AD4691_OSC_FREQ_MASK, i);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad4691_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type,
> +			     int *length, long mask)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int start = (st->info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = &ad4691_osc_freqs_Hz[start];
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(ad4691_osc_freqs_Hz) - start;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int ad4691_regulator_setup(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad4691_supplies),
> +					     ad4691_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable supplies\n");
> +
> +	ret = devm_regulator_get_enable(dev, "ldo-in");
> +	if (ret == -ENODEV)
> +		st->ldo_en = true;

This seems odd.  ldo_en to me implies enabling the internal LDO, which I'd expect
to need the ldo-in supply.  Anyhow - that oddity made me dig...

The datasheet is rather confusingly worded but the diagrams seem clear.

I 'think' the only time the ldo should not be enabled is when VDD = 1.8V and
LDO_IN is then tied to 0 (which maybe we represent at no ldo-in regulator?)

When ldo-in is supplied and the LDO enabled, the LDO output is tied to the VDD pin
internally.  So you'd should not be feeding VDD in that case.  There is a note
that says that it'll survive being also powered to 1.8V or grounded, but seems
to strongly advise against doing that.

Anyhow, what you have here and the dt-binding don't seem to align with the datasheet.

Figure 54 shows this most clearly. Your dt binding doesn't include vdd which
is also not aligning with the ad4691 datasheet on the website.

> +	else if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable LDO-IN\n");
> +
> +	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (st->vref_uV == -ENODEV) {
> +		st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "refin");
> +		st->refbuf_en = true;
> +	}
> +	if (st->vref_uV < 0)
> +		return dev_err_probe(dev, st->vref_uV,
> +				     "Failed to get reference supply\n");
> +
> +	if (st->vref_uV < AD4691_VREF_uV_MIN || st->vref_uV > AD4691_VREF_uV_MAX)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "vref(%d) must be in the range [%u...%u]\n",
> +				     st->vref_uV, AD4691_VREF_uV_MIN,
> +				     AD4691_VREF_uV_MAX);
> +
> +	return 0;
> +}
> +
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
> +		 * The GPIO is already asserted by reset_gpio_probe().

I thought assumption was that firmware (or driver going down) should always
leave the device in reset and hence could safely do 

devm_reset_control_get_optional_exclusive_deasserted() without
the need for the dance with asserting / sleep deasserting.

More than possible I've misunderstood this bit (or we have known firmware
out there that doesn't leave this in reset - in which case good to document
that here).

I don't mind the explicit code you have, just want to understand the reasoning
a little more.

FWIW, if anyone fancies taking a look, a few of the IIO drivers could
do to use the various 'extended' devm calls rather than doing their own
handling off assert and deassert via devm_add_action_or_rest()

> +		 * Wait for the reset pulse width required by the chip.
> +		 * See datasheet Table 5.
> +		 */
> +		fsleep(300);
> +		return reset_control_deassert(rst);
> +	}
> +
> +	/* No hardware reset available, fall back to software reset. */
> +	return regmap_write(st->regmap, AD4691_SPI_CONFIG_A_REG,
> +			    AD4691_SW_RESET);
> +}
> +
> +static int ad4691_config(struct ad4691_state *st)
> +{

...

> +	val = FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val);
> +	if (st->refbuf_en)
> +		val |= AD4691_REFBUF_EN;
> +
> +	ret = regmap_update_bits(st->regmap, AD4691_REF_CTRL,
> +				 AD4691_REF_CTRL_MASK | AD4691_REFBUF_EN, val);

It doesn't hugely matter but given (at least for the AD4691) the other bits
are reserved and reset to 0 you could just write the whole thing and avoid
a bus read.  Doing it like this kind of implies there is something to
preserve. I was curious what hence looked it up.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write REF_CTRL\n");
> +
> +	ret = regmap_assign_bits(st->regmap, AD4691_DEVICE_SETUP,
> +				 AD4691_LDO_EN, st->ldo_en);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write DEVICE_SETUP\n");
> +
> +	/*
> +	 * Set the internal oscillator to the highest rate this chip supports.
> +	 * Index 0 (1 MHz) exceeds the 500 kHz max of AD4691/AD4693, so those
> +	 * chips start at index 1 (500 kHz).
> +	 */
> +	ret = regmap_assign_bits(st->regmap, AD4691_OSC_FREQ_REG,
> +				 AD4691_OSC_FREQ_MASK,

Similar to above. You could simplify to a write only given rest are reserved 0 bits.

Maybe it's simpler to keep them all the same though. Up to you.

> +				 (st->info->max_rate == 1 * HZ_PER_MHZ) ? 0 : 1);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
> +
> +	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
> +				 AD4691_ADC_MODE_MASK, AD4691_AUTONOMOUS_MODE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write ADC_SETUP\n");
> +
> +	return 0;
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

	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->info = spi_get_device_match_data(spi);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
...

thanks

Jonathan

