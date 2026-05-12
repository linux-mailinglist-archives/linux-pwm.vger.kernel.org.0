Return-Path: <linux-pwm+bounces-8871-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP5xAbtNA2pq3AEAu9opvQ
	(envelope-from <linux-pwm+bounces-8871-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2026 17:56:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6925242C6
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2026 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12977332E7DE
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2026 15:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F333C4164;
	Tue, 12 May 2026 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moMZGQZb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C973C5850;
	Tue, 12 May 2026 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600724; cv=none; b=GMc6xlePA5LygJMcngAj6m1N1si4RodCFu3YZ4cbZYG7yLT4BR6DNiZmEgUtpN2tS5gKWPPQt5f5HrZBwtPGLI/YZbqp0yDkhO/NdeTrc2jMlqxi08EpefHkRU1KoHgL0HaohQEei+ZZxkC/YqKF6W4F5SvtAJuDu1TH59dS9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600724; c=relaxed/simple;
	bh=UPTsSXVqrpNioAawmeVwwn89Z4hceuaoH7R8YMg6KAY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8MmHhoT20SlP6fITEXSJiGZn7o4L/+05JJ0lOE3eplq+YS5SpIUdbMe3wdLA5gvBrxCcWa88ZStxFIOFfAuSh5THQ7+ZssjAcaZW16o9AbsFLiFWOOD85Y8FAk1qhQYsVK4H23RVeJmy0gLdpw/wjGqFjVAb/8NBJI3QQHiais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moMZGQZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCF3C2BCB0;
	Tue, 12 May 2026 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778600724;
	bh=UPTsSXVqrpNioAawmeVwwn89Z4hceuaoH7R8YMg6KAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=moMZGQZb9IvwY7Hp94T6nwhBLqFjxmHjmSvRQ0esPijeXKCHpLdJAwHMptFit6xsP
	 HcZdIr2u6RdslL8cfu6AUTmrNeBoT3A4JV8mu5iGHQlfHUOO18ST83n4WqVQKmBmwB
	 YZ6IBFAImb1TgXHL0WDKdLurRL+RpbHWhz4BZZp/dNffX4Nidu/dMM+O5GmZIHhat/
	 hqm+8gk/WJ06U/SNY17Y+b7FuSoLDfXtldF5RkTNZwESL4p/+pvtpIDcB7mbStJAS1
	 G/d92PnU7FjhBsWumrMZ9kzqg+2iBtJmp4uXRMUtrV6gBr2kNv9g5zQRSRHT0G7a6l
	 nzlVImAYVAWzg==
Date: Tue, 12 May 2026 16:45:14 +0100
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
Subject: Re: [PATCH v10 3/6] iio: adc: ad4691: add triggered buffer support
Message-ID: <20260512164514.38bbfd4c@jic23-huawei>
In-Reply-To: <20260511-ad4692-multichannel-sar-adc-driver-v10-3-e1fbb1744e38@analog.com>
References: <20260511-ad4692-multichannel-sar-adc-driver-v10-0-e1fbb1744e38@analog.com>
	<20260511-ad4692-multichannel-sar-adc-driver-v10-3-e1fbb1744e38@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6E6925242C6
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
	TAGGED_FROM(0.00)[bounces-8871-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Action: no action

On Mon, 11 May 2026 14:54:15 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add buffered capture support using the IIO triggered buffer framework.
>=20
> CNV Burst Mode: the GP pin identified by interrupt-names in the device
> tree is configured as DATA_READY output. The IRQ handler stops
> conversions and fires the IIO trigger; the trigger handler executes a
> pre-built SPI message that reads all active channels from the AVG_IN
> accumulator registers and then resets accumulator state and restarts
> conversions for the next cycle.
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
> one u16 slot per active channel, densely paccked in scan_index order,
> followed by a timestamp.
>=20
> The CNV Burst Mode sampling frequency (PWM period) is exposed as a
> buffer-level attribute via IIO_DEVICE_ATTR.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Sashiko pointed out you have a buffer that is big endian but
chan_spec doesn't reflect that.  That should have generated obvious
garbage output (unless you are actually testing on a be machine!)

Various other things came up, some of which I thought were in previous
reviews - but maybe I'm confusing drivers.

Thanks

Jonathan

> @@ -204,7 +230,14 @@ static const struct ad4691_chip_info ad4694_chip_inf=
o =3D {
>  struct ad4691_state {
>  	const struct ad4691_chip_info *info;
>  	struct regmap *regmap;
> +	struct spi_device *spi;
> +
> +	struct pwm_device *conv_trigger;
> +	int irq;
>  	int vref_uV;
> +	u32 cnv_period_ns;
> +
> +	bool manual_mode;
>  	bool refbuf_en;
>  	bool ldo_en;
>  	/*
> @@ -212,8 +245,56 @@ struct ad4691_state {
>  	 * atomicity of consecutive SPI operations.
>  	 */
>  	struct mutex lock;
> +	/*
> +	 * Per-buffer-enable lifetime resources:
> +	 * Manual Mode - a pre-built SPI message that clocks out N+1
> +	 *		 transfers in one go.
> +	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
> +	 *		    transfers in one go.
> +	 */
> +	struct spi_message scan_msg;
> +	/*
> +	 * max 16 + 1 NOOP (manual) or 2*16 + 1 state-reset (CNV burst).
> +	 */
> +	struct spi_transfer scan_xfers[34];
> +	/*
> +	 * CNV burst: 16 AVG_IN addresses =3D 16.  Manual: 16 channel cmds +
> +	 * 1 NOOP =3D 17.  Stored as native u16; put_unaligned_be16() fills each
> +	 * slot so the SPI controller (bits_per_word=3D8) sends bytes MSB-first.
> +	 */
> +	u16 scan_tx[17] __aligned(IIO_DMA_MINALIGN);
> +	/*
> +	 * CNV burst state-reset: 4-byte write [addr_hi, addr_lo,
> +	 * STATE_RESET_ALL, OSC_EN=3D1]. CS is asserted throughout, so
> +	 * ADDR_DESCENDING writes byte[3]=3D1 to OSC_EN_REG (0x180) as a
> +	 * deliberate side-write, keeping the oscillator enabled. Shared
> +	 * with the offload path (mutually exclusive at probe).
> +	 */
> +	u8 scan_tx_reset[4] __aligned(IIO_DMA_MINALIGN);
> +	/*
> +	 * Scan buffer: one BE16 slot per active channel, plus timestamp.
> +	 * DMA-aligned because scan_xfers point rx_buf directly into vals[].
> +	 */
> +	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, vals, 16);
As per comments elsewhere: If it is big endian why is the channel not marked
as such in the iio_chan_spec?

>  };

> +
> +static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +	unsigned int acc_mask;
> +	unsigned int k, i;
> +	int ret;
> +
> +	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
> +	memset(st->scan_tx, 0, sizeof(st->scan_tx));
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
> +		put_unaligned_be16(0x8000 | AD4691_AVG_IN(i), &st->scan_tx[k]);
> +		st->scan_xfers[2 * k].tx_buf =3D &st->scan_tx[k];
> +		st->scan_xfers[2 * k].len =3D sizeof(st->scan_tx[k]);
> +		spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
> +		st->scan_xfers[2 * k + 1].rx_buf =3D &st->vals[k];
> +		st->scan_xfers[2 * k + 1].len =3D sizeof(st->scan_tx[k]);
> +		st->scan_xfers[2 * k + 1].cs_change =3D 1;
> +		spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
> +		k++;
> +	}
> +
> +	/*
> +	 * Append a 4-byte state-reset transfer [addr_hi, addr_lo,
> +	 * STATE_RESET_ALL, OSC_EN=3D1]. CS is asserted throughout, so
> +	 * ADDR_DESCENDING writes byte[3]=3D1 to OSC_EN_REG (0x180) as a
> +	 * deliberate side-write, keeping the oscillator enabled.
> +	 */
> +	put_unaligned_be16(AD4691_STATE_RESET_REG, st->scan_tx_reset);
> +	st->scan_tx_reset[2] =3D AD4691_STATE_RESET_ALL;
> +	st->scan_tx_reset[3] =3D 1;
> +	st->scan_xfers[2 * k].tx_buf =3D st->scan_tx_reset;
> +	st->scan_xfers[2 * k].len =3D sizeof(st->scan_tx_reset);
> +	st->scan_xfers[2 * k].cs_change =3D 1;

Our old friend - cs_change =3D 1 is very rarely the right thing to do on a
final message.  I thought this came up in an earlier version.

> +	spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
> +
> +	ret =3D spi_optimize_message(st->spi, &st->scan_msg);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
> +			   bitmap_read(indio_dev->active_scan_mask, 0,
> +				       iio_get_masklength(indio_dev)));
> +	if (ret)
> +		goto err_unoptimize;
> +
> +	acc_mask =3D ~bitmap_read(indio_dev->active_scan_mask, 0,
> +				iio_get_masklength(indio_dev)) & GENMASK(15, 0);
> +	ret =3D regmap_write(st->regmap, AD4691_ACC_MASK_REG, acc_mask);
> +	if (ret)
> +		goto err_unoptimize;
> +
> +	ret =3D ad4691_enter_conversion_mode(st);
> +	if (ret)
> +		goto err_unoptimize;
> +
> +	return 0;
> +
> +err_unoptimize:
> +	spi_unoptimize_message(&st->scan_msg);
> +	return ret;
> +}


> +
> +static const struct iio_trigger_ops ad4691_trigger_ops =3D {
> +	.validate_device =3D iio_trigger_validate_own_device,
Same thing about manual mode as mentioned below.

> +};

> +
> +static irqreturn_t ad4691_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct ad4691_state *st =3D iio_priv(indio_dev);
> +
> +	ad4691_read_scan(indio_dev, pf->timestamp);
> +	if (!st->manual_mode)
> +		enable_irq(st->irq);

Maybe it was a different driver but I thought I commented on this before.
There are a bunch of races if you reenable this here - needs to be
in the trigger reenable callback.
(Sashiko is pointing this out as well with more detail on what those
races are)  The short story is that you can race and have a trigger between
the enable and the notify_done which will be dropped on the floor meaning
we never get in here again - IIRC there is (rather convoluted) code to hand=
le that
corner case in via the reenable callback and a work item.

> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info ad4691_info =3D {
>  	.read_raw =3D &ad4691_read_raw,
>  	.write_raw =3D &ad4691_write_raw,
>  	.read_avail =3D &ad4691_read_avail,
>  	.debugfs_reg_access =3D &ad4691_reg_access,
> +	.validate_trigger =3D iio_validate_own_trigger,

Sashiko noted that this seems odd. If we only support our own
trigger how does manual mode work given it isn't registering one?

You will need to do something more clever to handle that.
Either pick between info structures or use custom validation callbacks.

>  };

...

> @@ -651,6 +1119,75 @@ static int ad4691_config(struct ad4691_state *st)
>  	return 0;
>  }
> =20
> +static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
> +					 struct ad4691_state *st)
> +{
> +	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct iio_trigger *trig;
> +	unsigned int i;
> +	int irq, ret;
> +
> +	trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +				      iio_device_id(indio_dev));
> +	if (!trig)
> +		return -ENOMEM;
> +
> +	trig->ops =3D &ad4691_trigger_ops;
> +	iio_trigger_set_drvdata(trig, st);
> +
> +	ret =3D devm_iio_trigger_register(dev, trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "IIO trigger register failed\n");
> +
> +	indio_dev->trig =3D iio_trigger_get(trig);

Sashiko correctly points out the general bug we have right now about leaking
trigger context on any error.
Need to solve that for all drivers though so don't worry about it here.
It did give more complex reasoning than normal however!

> +
> +	if (st->manual_mode)
> +		return devm_iio_triggered_buffer_setup(dev, indio_dev,
> +						       &iio_pollfunc_store_time,
> +						       &ad4691_trigger_handler,
> +						       &ad4691_manual_buffer_setup_ops);
> +
> +	/*
> +	 * The GP pin named in interrupt-names asserts at end-of-conversion.
> +	 * The IRQ handler stops conversions and fires the IIO trigger so
> +	 * the trigger handler can read and push the sample to the buffer.
> +	 * The IRQ is kept disabled until the buffer is enabled.
> +	 */
> +	irq =3D -ENXIO;
> +	for (i =3D 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
> +		irq =3D fwnode_irq_get_byname(dev_fwnode(dev),
> +					    ad4691_gp_names[i]);
> +		if (irq > 0 || irq =3D=3D -EPROBE_DEFER)
> +			break;
> +	}
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "failed to get GP interrupt\n");
> +
> +	st->irq =3D irq;
> +
> +	ret =3D ad4691_gpio_setup(st, i);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * IRQ is kept disabled until the buffer is enabled to prevent
> +	 * spurious DATA_READY events before the SPI message is set up.
> +	 */
> +	ret =3D devm_request_threaded_irq(dev, irq, NULL,
> +					&ad4691_irq,
> +					IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
> +						   &iio_pollfunc_store_time,
> +						   &ad4691_trigger_handler,
> +						   IIO_BUFFER_DIRECTION_IN,
> +						   &ad4691_cnv_burst_buffer_setup_ops,
> +						   ad4691_buffer_attrs);
> +}
> +
>  static int ad4691_probe(struct spi_device *spi)
>  {
>  	struct device *dev =3D &spi->dev;
> @@ -663,6 +1200,7 @@ static int ad4691_probe(struct spi_device *spi)
>  		return -ENOMEM;
> =20
>  	st =3D iio_priv(indio_dev);
> +	st->spi =3D spi;
>  	st->info =3D spi_get_device_match_data(spi);
>  	if (!st->info)
>  		return -ENODEV;
> @@ -692,8 +1230,9 @@ static int ad4691_probe(struct spi_device *spi)
>  	indio_dev->info =3D &ad4691_info;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =20
> -	indio_dev->channels =3D st->info->sw_info->channels;
> -	indio_dev->num_channels =3D st->info->sw_info->num_channels;

You've lost me here. Where are these now set?

> +	ret =3D ad4691_setup_triggered_buffer(indio_dev, st);
> +	if (ret)
> +		return ret;
> =20
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>=20


