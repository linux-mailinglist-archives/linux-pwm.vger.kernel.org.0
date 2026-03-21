Return-Path: <linux-pwm+bounces-8324-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPQYB9e2vmkrXgMAu9opvQ
	(envelope-from <linux-pwm+bounces-8324-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 16:18:47 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D38B2E5FFB
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 16:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AAAC30151C6
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01E439280E;
	Sat, 21 Mar 2026 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2Pdnfru"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2528391E41;
	Sat, 21 Mar 2026 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774106213; cv=none; b=iksy7J6iqg1QMboNJKKuIp8Ry7z7ZqhvZxvfXijeTDlZrV1KMCGF9Akwg7wItydk3NNcuLFdh2rwHHvW8xkLD1MNBNDU0KKunBLI7fnu06mhSNUa//PbuhDURuQG9Gkx8/PTKPfjbz/RSoA+30EzHVIOgAvasgDNlvLzV7rFLro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774106213; c=relaxed/simple;
	bh=rsWzocyurDD535xDRZpVwg628R4UqgGMEMnHT5DchEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZYTrlpj9SI8lJV8vyJs5RDH1wop3kBVGkHGFsLSGDMzI5WuRg1qX6R9Vk+uJfR/LHIl4w/N3BdCoDM0HtMxCfDFq44naFfy/pM7rJGalxRgClq5vB7+PecCWX1XMdZvoxylkdQiyfhsAnWdUo89zp7MaA/QxUYmUiwNtJ80YTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2Pdnfru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8884C19421;
	Sat, 21 Mar 2026 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774106213;
	bh=rsWzocyurDD535xDRZpVwg628R4UqgGMEMnHT5DchEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m2Pdnfru7KtXLZaMfVw7hS1qqfCwmUXeV0LYKPKLX8ieAIXBjFdWLQOHDZC/89vME
	 Zqb/YAggmyoTZQp7FHV3q2zwBDKP8Ibj0I+wjVxECLRZY940I9Ff3IPcZf8F0ZLyQk
	 BdNKptAGA+NirGYG6QbBUQCfyUr9Yk2m2a4PziopNEUqrFpJs2i+bmhgCHK0+xqaaH
	 E3khmfyMgrVgDxclSfJTR/tDqYHtxX2YDpo5uVW1jhig6P1hSB+qK5Bx6mYspfrPBn
	 WtIkHmWHaNERYINmtwPSsNn5VogrfzuXYXjmt/HRDJk6rxii9WNyN2jVcai+QtG05C
	 Nv+xVclpQNMrw==
Date: Sat, 21 Mar 2026 15:16:40 +0000
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
Subject: Re: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260321151640.4dae9b91@jic23-huawei>
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
	<20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-8324-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: 7D38B2E5FFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 20 Mar 2026 13:03:57 +0200
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add buffered capture support using the IIO triggered buffer framework.
>=20
> CNV Burst Mode: the GP pin identified by interrupt-names in the device

The first I assume?  Might be up to 4 of them.

> tree is configured as DATA_READY output. The IRQ handler stops
> conversions and fires the IIO trigger; the trigger handler executes a
> pre-built SPI message that reads all active channels from the AVG_IN
> accumulator registers and then resets accumulator state and restarts
> conversions for the next cycle.

No oversampling configuration?  If it's a fixed length burst I'd still
expect to see an indication of what it is and if we can flip back to
no oversampling by changing mode, that should be oversampling =3D=3D 1.
Seems there is a depth setting for the averaging filters, that superficially
at least appears to be the right control for this.

Seems like there is an SPI burst mode as well?  That feels like very
standard oversampling.

>=20
> Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
> reads the previous result and starts the next conversion (pipelined
> N+1 scheme). At preenable time a pre-built, optimised SPI message of
> N+1 transfers is constructed (N channel reads plus one NOOP to drain
> the pipeline). The trigger handler executes the message in a single
> spi_sync() call and collects the results. An external trigger (e.g.
> iio-trig-hrtimer) is required to drive the trigger at the desired
> sample rate.
>=20
> Both modes share the same trigger handler and push a complete scan =E2=80=
=94
> one u16 slot per channel at its scan_index position, followed by a
> timestamp =E2=80=94 to the IIO buffer via iio_push_to_buffers_with_ts().
>=20
> The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> buffer-level attribute via IIO_DEVICE_ATTR.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
A few comments inline.  All the modes etc in this driver are complex
enough I think this one needs a driver specific document in Documentation/i=
io

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> index 5e02eb44ca44..db776de32846 100644
> --- a/drivers/iio/adc/ad4691.c
> +++ b/drivers/iio/adc/ad4691.c

> @@ -121,6 +140,7 @@ static const struct iio_chan_spec ad4691_channels[] =
=3D {
>  	AD4691_CHANNEL(13),
>  	AD4691_CHANNEL(14),
>  	AD4691_CHANNEL(15),
> +	IIO_CHAN_SOFT_TIMESTAMP(16),
>  };
> =20
>  static const struct iio_chan_spec ad4693_channels[] =3D {
> @@ -132,6 +152,7 @@ static const struct iio_chan_spec ad4693_channels[] =
=3D {
>  	AD4691_CHANNEL(5),
>  	AD4691_CHANNEL(6),
>  	AD4691_CHANNEL(7),
> +	IIO_CHAN_SOFT_TIMESTAMP(16),

Any big advantage in pushing it all the way down to 16?  It's ABI compliant
as these only have to be monotonic, but I'd feel it was more natural as 8 u=
nless
there is something I'm missing.

>  };
> =20
>  /*
> @@ -189,16 +210,63 @@ static const struct ad4691_chip_info ad4694_chip_in=
fo =3D {
>  struct ad4691_state {
>  	const struct ad4691_chip_info	*info;
>  	struct regmap			*regmap;
> +
> +	struct pwm_device		*conv_trigger;
> +	struct iio_trigger		*trig;
> +	int				irq;
> +
> +	bool				manual_mode;
> +
>  	int				vref_uV;
>  	bool				refbuf_en;
>  	bool				ldo_en;
> +	u32				cnv_period_ns;
>  	/*
>  	 * Synchronize access to members of the driver state, and ensure
>  	 * atomicity of consecutive SPI operations.
>  	 */
>  	struct mutex			lock;
> +	/*
> +	 * Per-buffer-enabl ree lifetimesources:
> +	 * Manual Mode - a pre-built SPI message that clocks out N+1
> +	 *		 transfers in one go.
> +	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
> +	 *		    transfers in one go.
> +	 */
> +	void				*scan_devm_group;
> +	struct spi_message		scan_msg;
> +	struct spi_transfer		*scan_xfers;
> +	__be16				*scan_tx;
> +	__be16				*scan_rx;
> +	/* Scan buffer: one slot per channel (u16) plus timestamp */
> +	struct {
> +		u16 vals[16];
> +		s64 ts __aligned(8);

aligned_s64

That was introduced last year IIRC.


> +	} scan __aligned(IIO_DMA_MINALIGN);
>  };

>  static int ad4691_reg_read(void *context, unsigned int reg, unsigned int=
 *val)
>  {
>  	struct spi_device *spi =3D context;
> @@ -341,14 +409,16 @@ static int ad4691_get_sampling_freq(struct ad4691_s=
tate *st, int *val)
>  static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
>  {
>  	struct ad4691_state *st =3D iio_priv(indio_dev);
> -	unsigned int start =3D (st->info->max_rate =3D=3D HZ_PER_MHZ) ? 0 : 1;
>  	unsigned int i;
> =20
> +	if (freq > st->info->max_rate)
> +		return -EINVAL;
> +
>  	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>  	if (IIO_DEV_ACQUIRE_FAILED(claim))
>  		return -EBUSY;
> =20
> -	for (i =3D start; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {
> +	for (i =3D 0; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {

Why is the start offset no longer relevant?

>  		if ((int)ad4691_osc_freqs[i] =3D=3D freq)
>  			return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
>  						  AD4691_OSC_FREQ_MASK, i);

> @@ -386,8 +459,7 @@ static int ad4691_single_shot_read(struct iio_dev *in=
dio_dev,
>  	guard(mutex)(&st->lock);
> =20
>  	/*
> -	 * Use AUTONOMOUS mode for single-shot reads. The chip always
> -	 * operates in AUTONOMOUS mode in this driver revision.
> +	 * Use AUTONOMOUS mode for single-shot reads.
This edit doesn't seem to belong in this patch. I'd just put the new
text in place in the earlier patch.

> +static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	unsigned int n_active =3D hweight_long(*indio_dev->active_scan_mask);
> +	unsigned int n_xfers =3D n_active + 1;
> +	unsigned int k, i;
> +	int ret;
> +
> +	st->scan_devm_group =3D devres_open_group(dev, NULL, GFP_KERNEL);
> +	if (!st->scan_devm_group)
> +		return -ENOMEM;
> +
> +	st->scan_xfers =3D devm_kcalloc(dev, n_xfers, sizeof(*st->scan_xfers),
> +				      GFP_KERNEL);
> +	st->scan_tx =3D devm_kcalloc(dev, n_xfers, sizeof(*st->scan_tx),
> +				   GFP_KERNEL);
> +	st->scan_rx =3D devm_kcalloc(dev, n_xfers, sizeof(*st->scan_rx),
> +				   GFP_KERNEL);
> +	if (!st->scan_xfers || !st->scan_tx || !st->scan_rx) {
> +		devres_release_group(dev, st->scan_devm_group);
> +		return -ENOMEM;
> +	}
> +
> +	spi_message_init(&st->scan_msg);
> +
> +	k =3D 0;
> +	iio_for_each_active_channel(indio_dev, i) {
> +		st->scan_tx[k] =3D cpu_to_be16(AD4691_ADC_CHAN(i));
> +		st->scan_xfers[k].tx_buf =3D &st->scan_tx[k];
> +		st->scan_xfers[k].rx_buf =3D &st->scan_rx[k];
> +		st->scan_xfers[k].len =3D sizeof(__be16);
> +		st->scan_xfers[k].cs_change =3D 1;
> +		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
> +		k++;
> +	}
> +
> +	/* Final NOOP transfer to retrieve last channel's result. */
> +	st->scan_tx[k] =3D cpu_to_be16(AD4691_NOOP);
> +	st->scan_xfers[k].tx_buf =3D &st->scan_tx[k];
> +	st->scan_xfers[k].rx_buf =3D &st->scan_rx[k];
> +	st->scan_xfers[k].len =3D sizeof(__be16);
> +	spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
> +
> +	devres_close_group(dev, st->scan_devm_group);

Similar comment to below on devres groups not really being appropriate
here.

> +
> +	st->scan_msg.spi =3D spi;
> +
> +	ret =3D spi_optimize_message(spi, &st->scan_msg);
> +	if (ret) {
> +		devres_release_group(dev, st->scan_devm_group);
If you were keeping this, better to do an error handling block via
gotos like you do for the other similar code.

> +		return ret;
> +	}
> +
> +	ret =3D ad4691_enter_conversion_mode(st);
> +	if (ret) {
> +		spi_unoptimize_message(&st->scan_msg);
> +		devres_release_group(dev, st->scan_devm_group);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4691_manual_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	int ret;
> +
> +	ret =3D ad4691_exit_conversion_mode(st);
> +	spi_unoptimize_message(&st->scan_msg);
> +	devres_release_group(dev, st->scan_devm_group);
> +	return ret;
> +}
;
> +
> +static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	unsigned int n_active =3D hweight_long(*indio_dev->active_scan_mask);
> +	unsigned int bit, k, i;
> +	int ret;
> +
> +	st->scan_devm_group =3D devres_open_group(dev, NULL, GFP_KERNEL);
> +	if (!st->scan_devm_group)
> +		return -ENOMEM;
> +
> +	st->scan_xfers =3D devm_kcalloc(dev, 2 * n_active, sizeof(*st->scan_xfe=
rs),
> +				      GFP_KERNEL);

See later.  I don't see a benefit in using a devres group here. It's nothing
to do with device lifetime.

> +	st->scan_tx =3D devm_kcalloc(dev, n_active, sizeof(*st->scan_tx),
> +				   GFP_KERNEL);
> +	st->scan_rx =3D devm_kcalloc(dev, n_active, sizeof(*st->scan_rx),
> +				   GFP_KERNEL);
> +	if (!st->scan_xfers || !st->scan_tx || !st->scan_rx) {
> +		devres_release_group(dev, st->scan_devm_group);
> +		return -ENOMEM;
> +	}
> +
> +	spi_message_init(&st->scan_msg);
> +
> +	/*
> +	 * Each AVG_IN read needs two transfers: a 2-byte address write phase
> +	 * followed by a 2-byte data read phase. CS toggles between channels
> +	 * (cs_change=3D1 on the read phase of all but the last channel).
> +	 */
> +	k =3D 0;
> +	iio_for_each_active_channel(indio_dev, i) {
> +		st->scan_tx[k] =3D cpu_to_be16(0x8000 | AD4691_AVG_IN(i));
> +		st->scan_xfers[2 * k].tx_buf =3D &st->scan_tx[k];
> +		st->scan_xfers[2 * k].len =3D sizeof(__be16);
> +		spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
> +		st->scan_xfers[2 * k + 1].rx_buf =3D &st->scan_rx[k];
> +		st->scan_xfers[2 * k + 1].len =3D sizeof(__be16);
> +		if (k < n_active - 1)
> +			st->scan_xfers[2 * k + 1].cs_change =3D 1;
> +		spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
> +		k++;
> +	}
> +
> +	devres_close_group(dev, st->scan_devm_group);

If you were keeping this (against comment below) why close it here?  Close =
it once
devm calls are done above.

> +
> +	st->scan_msg.spi =3D spi;
> +
> +	ret =3D spi_optimize_message(spi, &st->scan_msg);
> +	if (ret) {
> +		devres_release_group(dev, st->scan_devm_group);
> +		return ret;
> +	}
> +
> +	ret =3D regmap_write(st->regmap, AD4691_ACC_MASK_REG,
> +			   (u16)~(*indio_dev->active_scan_mask));
> +	if (ret)
> +		goto err;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   *indio_dev->active_scan_mask);
> +	if (ret)
> +		goto err;
> +
> +	iio_for_each_active_channel(indio_dev, bit) {
> +		ret =3D regmap_write(st->regmap, AD4691_ACC_COUNT_LIMIT(bit),
> +				   AD4691_ACC_COUNT_VAL);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret =3D ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		goto err;
> +
> +	ret =3D ad4691_sampling_enable(st, true);
> +	if (ret)
> +		goto err;
> +
> +	enable_irq(st->irq);
> +	return 0;
> +err:
> +	spi_unoptimize_message(&st->scan_msg);
> +	devres_release_group(dev, st->scan_devm_group);
> +	return ret;
> +}
> +
> +static int ad4691_cnv_burst_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	int ret;
> +
> +	disable_irq(st->irq);
> +
> +	ret =3D ad4691_sampling_enable(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   AD4691_SEQ_ALL_CHANNELS_OFF);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4691_exit_conversion_mode(st);
> +	spi_unoptimize_message(&st->scan_msg);
> +	devres_release_group(dev, st->scan_devm_group);

I'm not seeing an obvious reason for devres group handling here.
Normally we do that if there is a path to remove() in which the cleanup
still needs to be done.  Here there isn't as we always turn the buffer
off earlier in the remove flow.  So I'd do things the old fashioned way
and free them by hand.


> +	return ret;
> +}

> +static IIO_DEVICE_ATTR(sampling_frequency, 0644,
> +		       sampling_frequency_show,
> +		       sampling_frequency_store, 0);
> +
> +static const struct iio_dev_attr *ad4691_buffer_attrs[] =3D {
> +	&iio_dev_attr_sampling_frequency,
> +	NULL,

No comma.

> +};

> +
> +static irqreturn_t ad4691_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	unsigned int i, k =3D 0;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);

General rule (see cleanup.h comments) is don't use guard() or __free()
stuff in a function that also does goto.  Just handle the mutex()
the old fashioned way.  Alternative is to use a helper function and
just leave the iio_trigger_notify_done() in this outer call.

> +
> +	ret =3D spi_sync(st->scan_msg.spi, &st->scan_msg);
> +	if (ret)
> +		goto done;
> +
> +	if (st->manual_mode) {
> +		iio_for_each_active_channel(indio_dev, i) {
> +			st->scan.vals[i] =3D be16_to_cpu(st->scan_rx[k + 1]);
> +			k++;
> +		}
> +	} else {
> +		iio_for_each_active_channel(indio_dev, i) {
> +			st->scan.vals[i] =3D be16_to_cpu(st->scan_rx[k]);
> +			k++;
> +		}
> +
> +		ret =3D regmap_write(st->regmap, AD4691_STATE_RESET_REG,
> +				   AD4691_STATE_RESET_ALL);
> +		if (ret)
> +			goto done;
> +
> +		ret =3D ad4691_sampling_enable(st, true);
> +		if (ret)
> +			goto done;
> +	}
> +
> +	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
> +				    pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +


> @@ -595,17 +1071,91 @@ static int ad4691_config(struct ad4691_state *st)
>  		return dev_err_probe(dev, ret, "Failed to write DEVICE_SETUP\n");
> =20
>  	/*
> -	 * Set the internal oscillator to the highest valid rate for this chip.
> -	 * Index 0 (1 MHz) is valid only for AD4692/AD4694; AD4691/AD4693 start
> -	 * at index 1 (500 kHz).
> +	 * Set the internal oscillator to the highest rate this chip supports.

This reword doesn't obviously fit in this patch. Move it to earlier one.

> +	 * Index 0 (1 MHz) exceeds the 500 kHz max of AD4691/AD4693, so those
> +	 * chips start at index 1 (500 kHz).
>  	 */
>  	ret =3D regmap_write(st->regmap, AD4691_OSC_FREQ_REG,
> -			   (st->info->max_rate =3D=3D HZ_PER_MHZ) ? 0 : 1);
> +			   (ad4691_osc_freqs[0] > st->info->max_rate) ? 1 : 0);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
> =20
>  	/* Device always operates in AUTONOMOUS mode. */
> -	return regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_AUTONOMOUS_MOD=
E_VAL);
> +	ret =3D regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_AUTONOMOUS_MO=
DE);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to write ADC_SETUp\n");
> +
> +	if (st->manual_mode)
> +		return 0;
> +
> +	ret =3D device_property_read_string_array(dev, "interrupt-names",
> +						&irq_name, 1);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read interrupt-names\n");
> +
> +	if (strncmp(irq_name, "gp", 2) !=3D 0 ||
> +	    kstrtouint(irq_name + 2, 10, &gp_num) || gp_num > 3)

No need to check this. Just request the individual GPIOs when needed by nam=
e.

> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid interrupt name '%s'\n", irq_name);
> +
> +	return ad4691_gpio_setup(st, gp_num);
> +}
> +
> +static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
> +					 struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	int irq, ret;
> +
> +	st->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d",
> +					  indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops =3D &ad4691_trigger_ops;
> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret =3D devm_iio_trigger_register(dev, st->trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "IIO trigger register failed\n");
> +
> +	indio_dev->trig =3D iio_trigger_get(st->trig);
> +
> +	if (!st->manual_mode) {
> +		/*
> +		 * GP0 asserts at end-of-conversion. The IRQ handler stops
> +		 * conversions and fires the IIO trigger so the trigger handler
> +		 * can read and push the sample to the buffer. The IRQ is kept
> +		 * disabled until the buffer is enabled.
> +		 */
> +		irq =3D fwnode_irq_get(dev_fwnode(dev), 0);

Given the presence of interrupt names, there is no guarantee that this is G=
P0.
You need to get it by name to know that.  They can come in any order, or in=
deed
any given one can be not wired.

> +		if (irq < 0)
> +			return dev_err_probe(dev, irq,
> +					     "failed to get GP interrupt\n");
> +
> +		st->irq =3D irq;
> +
> +		ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +						&ad4691_irq,
> +						IRQF_ONESHOT | IRQF_NO_AUTOEN,

When we are not enabling at boot it is usually helpful to add a comment for=
 why
not.

> +						indio_dev->name, indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		return devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
> +							   &iio_pollfunc_store_time,
> +							   &ad4691_trigger_handler,
> +							   IIO_BUFFER_DIRECTION_IN,
> +							   &ad4691_cnv_burst_buffer_setup_ops,
> +							   ad4691_buffer_attrs);
> +	}
> +
> +	return devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					       &iio_pollfunc_store_time,
> +					       &ad4691_trigger_handler,
> +					       &ad4691_manual_buffer_setup_ops);
>  }


