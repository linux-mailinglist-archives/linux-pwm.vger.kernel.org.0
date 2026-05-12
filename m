Return-Path: <linux-pwm+bounces-8870-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLobEitPA2r63gEAu9opvQ
	(envelope-from <linux-pwm+bounces-8870-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2026 18:02:51 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D052449C
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2026 18:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBFDA3257165
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2026 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA753B5E15;
	Tue, 12 May 2026 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbeijzDr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769691E492D;
	Tue, 12 May 2026 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778599572; cv=none; b=UENPXPv5mzTQTrIKoFyQ+KqLvsrgi6Dm4W2TXPQHkZfyGA6bwZPrDB9FJQPEIMto4LEV6ORBwr41bsOpNh8jTQMbOf/0jjqTIlAAuRSh1EBcFVk2sRgVuqSS7LLHbVlNSaS8c4OpPGx0ju0PCuMHH+4BQR9x7bkGoiI4MdkWnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778599572; c=relaxed/simple;
	bh=bQJFkEtLqjdexrXMn601sYKTcRHWpk5xDsyl0OdHy/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrHC1BEHFYA6bf1k/qX5Jj1fh5aDB4wmf8st+GUim0JY22+xS1ajmpO+UxIzY4vJKnjblREz2WQSQ3JrRAPD9YtKAqsBsDm9NEvYZi7i7RSJbfsLISUGmap5FemRxL/swsmqEPLfusXq0ydZ/6khQMdJVSjRIkcSrsqxJLpskOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbeijzDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73177C2BCB0;
	Tue, 12 May 2026 15:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778599572;
	bh=bQJFkEtLqjdexrXMn601sYKTcRHWpk5xDsyl0OdHy/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EbeijzDrzyXgBJmo5oj83m1ZIz7sf5LwfXKQTSA8HlaiRS02Mwhn9ZGkvi45bJ2D0
	 upXM/EL0izFe9NZ/dKQuGdm4n+taoqrTMSFTQfQ+2TyfWbk1mWvQ0wyZO+d8op0alm
	 MLpooCHG0wE4sHBq+bE/qApJcBBBC4WiINs1UjdzOuoqUzeh8Kx3c92VtlZgLTHu0H
	 Lb4dkbTmz2bLwLM90EFt8eaZw/vRdOIQ2wgf72xLD4930C1ROGtdwV2Z9YD213PjX7
	 RJ1XR0yZOU1wdO+f/W8Q0Jn58Tyvr08ynIvuVb1vTWCFlcbvaszCY4L048IIa0REYL
	 wifuZULPEm4gQ==
Date: Tue, 12 May 2026 16:25:58 +0100
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
Subject: Re: [PATCH v10 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260512162558.5bbbd464@jic23-huawei>
In-Reply-To: <20260511-ad4692-multichannel-sar-adc-driver-v10-2-e1fbb1744e38@analog.com>
References: <20260511-ad4692-multichannel-sar-adc-driver-v10-0-e1fbb1744e38@analog.com>
	<20260511-ad4692-multichannel-sar-adc-driver-v10-2-e1fbb1744e38@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4C3D052449C
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-8870-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,baylibre.com:email]
X-Rspamd-Action: no action

On Mon, 11 May 2026 14:54:14 +0300
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
> IIO_CHAN_INFO_SAMP_FREQ is exposed as info_mask_shared_by_all because
> the AD4691 family has a single internal oscillator whose frequency
> register is shared across all channels. Writing sampling_frequency for
> any one channel necessarily changes the conversion rate for every other
> channel, so the shared annotation correctly reflects the hardware
> behaviour.

Sashiko correctly points out that this last paragraph doesn't correspond to
the driver. Needs an update.
https://sashiko.dev/#/patchset/20260511-ad4692-multichannel-sar-adc-driver-v10-0-e1fbb1744e38%40analog.com

Otherwise just a few more sashiko things inline and my
comments on whether they are true - I think they are in this case...

> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..5b72216bca80
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c

> +
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
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_MASK_REG - 1:
> +	case AD4691_ACC_MASK_REG + 1 ... AD4691_ACC_SAT_OVR_REG(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 1);
> +		if (ret)
> +			return ret;
> +		*val = rx[0];
> +		return 0;
> +	case AD4691_ACC_MASK_REG:
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 2);

Just to check - (another sashiko one) is it a problem if via debugfs we
read addresses that aren't the base ones of these bigger reads?

> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be16(rx);
> +		return 0;
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 3);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be24(rx);
> +		return 0;
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 4);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be32(rx);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +}
> +
> +static bool ad4691_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AD4691_STATUS_REG:
> +	case AD4691_CLAMP_STATUS1_REG:
> +	case AD4691_CLAMP_STATUS2_REG:
> +	case AD4691_GPIO_READ:
> +	case AD4691_ACC_STATUS_FULL1_REG ... AD4691_ACC_STATUS_SAT2_REG:
> +	case AD4691_ACC_SAT_OVR_REG(0) ... AD4691_ACC_SAT_OVR_REG(15):
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool ad4691_readable_reg(struct device *dev, unsigned int reg)

I think this will all end up easier to follow if you add some checks in
this and the next one to exclude the latter parts of multi address registers.
Neater to do it here than in the read and write calls themselves.

> +{
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool ad4691_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_SPARE_CONTROL ... AD4691_GPIO_MODE2_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
>
> +
> +static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +
I think sashiko's comment on locking here is a false positive because you'll
always get the value from regcache. Maybe worth a comment on that though.

Sashiko suggests the direct read goes away later anyway.


> +	ret = regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*val = ad4691_osc_freqs_Hz[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)];
> +	return IIO_VAL_INT;
> +}


> +static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad4691_state *st = iio_priv(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +
> +	return regmap_write(st->regmap, reg, writeval);

This is where we perhaps have too much freedom given the effective gaps
in register addresses due for the larger 'registers'.

Using those wrong addresses might not be a problem belong filling the
regcache with garbage. If we can just screen them out in the readable
writeable checks that would be better.

> +}

...


> +static int ad4691_config(struct ad4691_state *st)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	enum ad4691_ref_ctrl ref_val;
> +	unsigned int val;
> +	int ret;
> +
> +	switch (st->vref_uV) {
> +	case AD4691_VREF_uV_MIN ... AD4691_VREF_2P5_uV_MAX:
> +		ref_val = AD4691_VREF_2P5;
> +		break;
> +	case AD4691_VREF_2P5_uV_MAX + 1 ... AD4691_VREF_3P0_uV_MAX:
> +		ref_val = AD4691_VREF_3P0;
> +		break;
> +	case AD4691_VREF_3P0_uV_MAX + 1 ... AD4691_VREF_3P3_uV_MAX:
> +		ref_val = AD4691_VREF_3P3;
> +		break;
> +	case AD4691_VREF_3P3_uV_MAX + 1 ... AD4691_VREF_4P096_uV_MAX:
> +		ref_val = AD4691_VREF_4P096;
> +		break;
> +	case AD4691_VREF_4P096_uV_MAX + 1 ... AD4691_VREF_uV_MAX:
> +		ref_val = AD4691_VREF_5P0;
> +		break;
> +	default:
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Unsupported vref voltage: %d uV\n",
> +				     st->vref_uV);
> +	}
> +
> +	val = FIELD_PREP(AD4691_REF_CTRL_MASK, ref_val);
> +	if (st->refbuf_en)
> +		val |= AD4691_REFBUF_EN;
> +
> +	ret = regmap_write(st->regmap, AD4691_REF_CTRL, val);
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
> +	ret = regmap_write(st->regmap, AD4691_OSC_FREQ_REG,

As per the comment above - I think this is why we don't have a bug reading
back the frequency during an ADC sampling sequence.  This ensures we have
the value cached.

> +			   ad4691_samp_freq_start(st->info));
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


