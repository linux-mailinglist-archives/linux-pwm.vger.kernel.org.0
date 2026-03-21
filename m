Return-Path: <linux-pwm+bounces-8322-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL9LLcKvvmnEWwMAu9opvQ
	(envelope-from <linux-pwm+bounces-8322-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 15:48:34 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 184E52E5E23
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 15:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C7B4300695E
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CB7318ECB;
	Sat, 21 Mar 2026 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV1Rz2GK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA92F12A5;
	Sat, 21 Mar 2026 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774104504; cv=none; b=D75dqzIz4kZAlp4nzgVSQ342fKmuWkaefYpBuSsxXCU4OZK5c7OooB5F03/t3yWLMoYoXSJC88f55/ioAJQTYRqg4uHhAVoNsWCVUsX1cePdARIG6gXNnwHx9OJlRugSMenX7tImEnRtXquayNoUdCd5sUf/8XfF6b1FzJP1vRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774104504; c=relaxed/simple;
	bh=1hspwDxm5i95HPmRejs68JkolWq+xlqoExhyuZ4hwSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fk0QGJMB787pS0AslZg4U61wRDgFbWKyasT8395SCTkVgt1AZslJQHciFVKPWXxlRlM1S7l5jBpAvoVAlkbDly86ljKyEk47XNZOkx/tvyDWfXKzrAAskzI0wd6X0r2WSZaZM/gDQwkUsX5lwlWwB/CAPZrvdiJ7mx5O3JO96gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV1Rz2GK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4256C19421;
	Sat, 21 Mar 2026 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774104504;
	bh=1hspwDxm5i95HPmRejs68JkolWq+xlqoExhyuZ4hwSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BV1Rz2GK5IgIlOeIho+DG6ofMbjSSH5FT/5RCVpWsuUSfQo7q0kQjPGVBmlYFcY38
	 cQpUP7RpqX4gJXhsYg3fiKoTfdOE+MqdLZMuOYDYJeDfrYtVscdp+M1ubwplUQIF4c
	 6gK3G+XAXcciVByo1ds4jyqWvJIIZfiVDN9UmlOdOIB8B6kcf03CXEecfcbvIlmKbb
	 1f8i7ko2RhbA3TBqdu0/raCwqGXV7HCX04M8SstBXCfKGWIgO6MPXtc2TcAjMYqSNQ
	 x/g+fJ4WLysbwi3u4RzURwF/56jA9vZyqHet42yYCn06a8PA2t6GvNv64ONeKDWu94
	 0IF2F7v9GZTOQ==
Date: Sat, 21 Mar 2026 14:48:11 +0000
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
 <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260321144811.0c58dcf0@jic23-huawei>
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-2-052c1050507a@analog.com>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
	<20260320-ad4692-multichannel-sar-adc-driver-v4-2-052c1050507a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8322-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 184E52E5E23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 13:03:56 +0200
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
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Hi Radu,

Just a few minor comments from me.
I'd have tweak them whilst applying but looks like you are doing a v5 anyway
for other comments.

Jonathan


> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..5e02eb44ca44
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c

> +#define AD4691_CHANNEL(ch)						\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
> +				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_separate_available =				\
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.channel = ch,						\
> +		.scan_index = ch,					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = 16,					\
> +			.storagebits = 16,				\
> +			.shift = 0,					\

Unless there is a reason to need the 0 to act as documentation we normally
assume it's the natural default and don't set it explicitly (let the C
struct initialization rules deal with setting it to 0 for us).

> +		},							\
> +	}


> +static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int start = (st->info->max_rate == HZ_PER_MHZ) ? 0 : 1;

Use 1 * HZ_PER_MHZ

May seem pointless but that conversion scale macro on it's own looks
strange with respect to what is it converting.

> +	unsigned int i;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	for (i = start; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {
> +		if ((int)ad4691_osc_freqs[i] == freq)

I would flip this around to reduce the indent of the path for when
we have a match.

		if ((int)ad4691_osc_freqs[i] != freq)
			continue;

		return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
					  AD4691_OSC_FREQ_MASK, i);


> +			return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
> +						  AD4691_OSC_FREQ_MASK, i);
> +	}
> +
> +	return -EINVAL;
> +}

> +static int ad4691_single_shot_read(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/*
> +	 * Use AUTONOMOUS mode for single-shot reads. The chip always
> +	 * operates in AUTONOMOUS mode in this driver revision.
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
> +	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			   (u16)~BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
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
> +	fsleep(DIV_ROUND_UP(2 * USEC_PER_SEC,
> +			    ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK,
> +						       reg_val)]));

Go long on this line for readability.
			    ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)]));
Is fine.  The whole 80-100 char range is fine to use if it improves redability and
here I think it does.

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
> +
> +	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}
> +
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

I think we should have convention of no blank line here.
The bit above is setting a variable then we are checking it for error.

> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		return ad4691_single_shot_read(indio_dev, chan, val);
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4691_get_sampling_freq(st, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_uV / (MICRO / MILLI);
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int ad4691_regulator_setup(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret = devm_regulator_get_enable(dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable AVDD\n");
> +
> +	ret = devm_regulator_get_enable(dev, "ldo-in");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get and enable LDO-IN\n");
> +	st->ldo_en = (ret == -ENODEV);
> +
> +	ret = devm_regulator_get_enable(dev, "vio");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get and enable VIO\n");

Unless there is an ordering constraint for power supplies, I'd move this up to
just after avdd so the two non optional ones are done together.

> +
> +	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (st->vref_uV >= 0) {
> +		st->refbuf_en = false;
> +	} else if (st->vref_uV == -ENODEV) {
> +		st->vref_uV = devm_regulator_get_enable_read_voltage(dev, "refin");
> +		st->refbuf_en = true;
> +	}


