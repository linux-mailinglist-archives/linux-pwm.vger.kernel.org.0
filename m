Return-Path: <linux-pwm+bounces-8930-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BS0cM1myCWq3lgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8930-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 14:19:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 259EB560EB7
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 14:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB49A30075C3
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 12:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394CC363C4B;
	Sun, 17 May 2026 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAeOKlzM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429C274B5F;
	Sun, 17 May 2026 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779020375; cv=none; b=dPF8vL2rKEHGvdQZ6yB2jbspKmNB/L0UFrTupGPRD2PGb19q7z+P3WMBE0GBIt7Ces5eHC2Ht89cNQ/eSTcUMn3Z15AoiAjMins2uDHGKqNtn2Ji+yNBEui7PX5KRRouN/4NdwcS9Z0t1iDRcd4NnEvpe8gbNZmuCoeoS+Fjgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779020375; c=relaxed/simple;
	bh=DIswO7u4c7g8Gias+0hS5WOPvHbcNBbCemaT+TW2XjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egH5/f9Mpwu1KoF+wbfhBmaoipeGSf9W76MbMa6E5KM8GdBlR+xbjPQvjg9C5toFdYodyZ3Mty7fr1Y/In4wO4NcLa5+cu+AzFE/2b5SjrlVFISTdITbNCnlvo/iyYZAxZV4x8Ngq/C4/ehoYioQdpWqvJeD4fZbgl4jI70xPSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAeOKlzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECA7C2BCB0;
	Sun, 17 May 2026 12:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779020374;
	bh=DIswO7u4c7g8Gias+0hS5WOPvHbcNBbCemaT+TW2XjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PAeOKlzMA1/uiqK1jM0BBK2IlE88wIHwAa+tKUSsBrYEXlfPXS7W5QVQ4dvom0aVn
	 9wTB2kMEBLAvgMmfa3G0Iik4ZBjFc5D6aPRL6S/E2lZCF1ZgMGLb4xLynOWRDkUils
	 PJdp5C7TRtePX4Pv2wUyE9Dxdray9F8Vi1DF+xhobOIqGqDpHXbYx2YauYS8Exno/M
	 SjXVoKtYUAUKlbOfih1dtxvzk09RU2aveu87K4JV018zIyvgyt/lFq0GgwMzWVmqrY
	 J9V9rSBb8chFuVkBaZrwWwXEt90TnYjRozSAjQ/vejLvkUOX1WHo2tHBUXZO+kuQkJ
	 bMUe5WATsq2ng==
Date: Sun, 17 May 2026 13:19:21 +0100
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
Subject: Re: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260517131921.63795664@jic23-huawei>
In-Reply-To: <20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 259EB560EB7
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
	TAGGED_FROM(0.00)[bounces-8930-lists,linux-pwm=lfdr.de];
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

On Fri, 15 May 2026 16:31:31 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
>=20
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
>=20
> The chip idles in Autonomous Mode so that single-shot read_raw can use
> the internal oscillator without disturbing the hardware configuration.
>=20
> Three voltage supply domains are managed: avdd (required), vio, and a
> reference supply on either the REF pin (ref-supply, external buffer)
> or the REFIN pin (refin-supply, uses the on-chip reference buffer;
> REFBUF_EN is set accordingly). Hardware reset is performed via
> the reset controller framework; a software reset through SPI_CONFIG_A
> is used as fallback when no hardware reset is available.
>=20
> Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> 16-bit transfer.
>=20
> IIO_CHAN_INFO_SAMP_FREQ is exposed as info_mask_separate. The oscillator
> is shared hardware =E2=80=94 writing any channel's sampling_frequency att=
ribute
> sets it for all others =E2=80=94 but per-channel attributes are used thro=
ughout
> the series to avoid an ABI change when per-channel oversampling ratios
> are introduced in a later commit, at which point the effective output
> rate (osc_freq / osr[N]) becomes genuinely per-channel.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Just a couple of really trivial comments.

I might just have tweaked some of these whilst applying but seeing
as it seems you'll be doing a v12 - over to you :)

Jonathan
=20

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..ba77e1bfef16
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c

> +
> +#define AD4691_OSC_EN_REG			0x180
> +#define AD4691_STATE_RESET_REG			0x181
> +#define AD4691_STATE_RESET_ALL			0x01
Is this a value in a field or documented as whole register value?
I checked, it's  BIT(0) - rest of register is Reserved 0
Hence cleaner to use BIT(0) for this definition.

> +#define AD4691_ADC_SETUP			0x182
> +#define AD4691_ADC_MODE_MASK			GENMASK(1, 0)
> +#define AD4691_AUTONOMOUS_MODE			0x02
Personal preference would have been to fully define the field values
at this stage, but meh, you bring in the other used ones in later patches
so not critical.

> +
> +#define AD4691_CHANNEL(ch)						\
> +	{								\
> +		.type =3D IIO_VOLTAGE,					\
> +		.indexed =3D 1,						\
> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)		\
> +				    | BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_separate_available =3D				\
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SCALE),	\
> +		.channel =3D ch,						\
> +		.scan_index =3D ch,					\
> +		.scan_type =3D {						\
> +			.sign =3D 'u',					\
> +			.realbits =3D 16,					\
> +			.storagebits =3D 16,				\

Really trivial but I suspect that scan_index and most of scan_type aren't u=
sed
until the buffered support is added. So in ideal world add that extra stuff
in that patch.  .realbits is used here so fine to initialize that now.

> +		},							\
> +	}

> +
> +static int ad4691_single_shot_read(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan, int *val)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_val, osc_idx, period_us;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	/* Use AUTONOMOUS mode for single-shot reads. */
> +	ret =3D regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +			   AD4691_STATE_RESET_ALL);

This identical to line below that you don't wrap. I don't mind which
but consistency is good.

> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   BIT(chan->channel));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			   ~BIT(chan->channel) & GENMASK(15, 0));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4691_OSC_FREQ_REG, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_OSC_EN_REG, 1);
> +	if (ret)
> +		return ret;
> +
> +	osc_idx =3D FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val);
> +	/* Wait 2 oscillator periods for the conversion to complete. */
> +	period_us =3D DIV_ROUND_UP(2UL * USEC_PER_SEC, ad4691_osc_freqs_Hz[osc_=
idx]);
> +	fsleep(period_us);
> +
> +	ret =3D regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(st->regmap, AD4691_AVG_IN(chan->channel), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*val =3D reg_val;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_R=
ESET_ALL);
See above.

> +	if (ret)
> +		return ret;
> +
> +	return IIO_VAL_INT;
> +}


> +
> +static const struct of_device_id ad4691_of_match[] =3D {
> +	{ .compatible =3D "adi,ad4691", .data =3D &ad4691_chip_info },
> +	{ .compatible =3D "adi,ad4692", .data =3D &ad4692_chip_info },
> +	{ .compatible =3D "adi,ad4693", .data =3D &ad4693_chip_info },
> +	{ .compatible =3D "adi,ad4694", .data =3D &ad4694_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad4691_of_match);
> +
> +static const struct spi_device_id ad4691_id[] =3D {
> +	{ "ad4691", (kernel_ulong_t)&ad4691_chip_info },
> +	{ "ad4692", (kernel_ulong_t)&ad4692_chip_info },
> +	{ "ad4693", (kernel_ulong_t)&ad4693_chip_info },
> +	{ "ad4694", (kernel_ulong_t)&ad4694_chip_info },

New thing to IIO, but as you are doing another spin anyway can you save
us a future patch.  Seems likely that similar to I2C that Uwe is
currently working on, we will eventually move away from stashing pointers
in that ulong_t.  So please use named initializers.  I'm not sure
why they've been standard for years for of_device_id but not spi_device_id!

Jonathan

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad4691_id);


